Return-Path: <rtc-linux+bncBD2536XZRAKBBOULY6XAKGQEC4SMVPY@googlegroups.com>
Received: from mail-la0-x229.google.com (mail-la0-x229.google.com. [2a00:1450:4010:c03::229])
        by gmr-mx.google.com with ESMTPS id ku1si481928lbc.3.2015.08.17.04.30.02
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2015 04:30:02 -0700 (PDT)
Received: by mail-la0-x229.google.com with SMTP id z9so77007271lag.3
        for <rtc-linux@googlegroups.com>; Mon, 17 Aug 2015 04:30:02 -0700 (PDT)
Sender: rtc-linux@googlegroups.com
Date: Mon, 17 Aug 2015 13:30:00 +0200
From: Johan Hovold <johan@kernel.org>
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, rtc-linux@googlegroups.com,
	tony@atomide.com, alexandre.belloni@free-electrons.com,
	akpm@linux-foundation.org, johan@kernel.org,
	grygorii.strashko@ti.com, bcousson@baylibre.com,
	devicetree@vger.kernel.org, t-kristo@ti.com
Subject: [rtc-linux] Re: [PATCH v2 2/2] rtc: omap: Add external clock enabling support
Message-ID: <20150817113000.GF7053@localhost>
References: <1439787338-27396-1-git-send-email-j-keerthy@ti.com>
 <1439787338-27396-3-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1439787338-27396-3-git-send-email-j-keerthy@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Mon, Aug 17, 2015 at 10:25:38AM +0530, Keerthy wrote:
> Configure the clock source to either internal clock
> or external clock based on the availability of the clocks.
> External clock is preferred as it can be ticking during suspend.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in V2:
> 
>   * Changed clk_prepare calls to clk_prepare_enable.
>   * Changed clk_unprepare calls to clk_disable_unprepare.
>   * Added clk pointers for external and internal clock to omap_rtc structure.
> 
>  drivers/rtc/rtc-omap.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 8b6355f..46b3944 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -25,6 +25,7 @@
>  #include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/io.h>
> +#include <linux/clk.h>
>  
>  /*
>   * The OMAP RTC is a year/month/day/hours/minutes/seconds BCD clock
> @@ -107,6 +108,7 @@
>  
>  /* OMAP_RTC_OSC_REG bit fields: */
>  #define OMAP_RTC_OSC_32KCLK_EN		BIT(6)
> +#define OMAP_RTC_OSC_SEL_32KCLK_SRC	BIT(3)
>  
>  /* OMAP_RTC_IRQWAKEEN bit fields: */
>  #define OMAP_RTC_IRQWAKEEN_ALARM_WAKEEN	BIT(1)
> @@ -132,10 +134,13 @@ struct omap_rtc_device_type {
>  struct omap_rtc {
>  	struct rtc_device *rtc;
>  	void __iomem *base;
> +	struct clk *ext_clk;
> +	struct clk *int_clk;

As was already suggested, you could just use one clock here for now.

>  	int irq_alarm;
>  	int irq_timer;
>  	u8 interrupts_reg;
>  	bool is_pmic_controller;
> +	bool has_ext_clk;
>  	const struct omap_rtc_device_type *type;
>  };
>  
> @@ -553,6 +558,17 @@ static int omap_rtc_probe(struct platform_device *pdev)
>  	if (rtc->irq_alarm <= 0)
>  		return -ENOENT;
>  
> +	rtc->ext_clk = devm_clk_get(&pdev->dev, "ext-clk");
> +	if (!IS_ERR(rtc->ext_clk)) {
> +		rtc->has_ext_clk = true;
> +		clk_prepare_enable(rtc->ext_clk);
> +	} else {
> +		rtc->int_clk = devm_clk_get(&pdev->dev, "int-clk");
> +
> +		if (!IS_ERR(rtc->int_clk))
> +			clk_prepare_enable(rtc->int_clk);
> +	}
> +

Which would allow some simplification here.

But shouldn't enabling the internal clock go in its own patch before you
add support for the external clock?

>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	rtc->base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(rtc->base))
> @@ -627,6 +643,16 @@ static int omap_rtc_probe(struct platform_device *pdev)
>  	if (reg != new_ctrl)
>  		rtc_write(rtc, OMAP_RTC_CTRL_REG, new_ctrl);
>  
> +	/*
> +	 * If we have the external clock then switch to it so we can keep
> +	 * ticking acorss suspend.

You forgot to fix the "acorss" typo.

> +	 */
> +	if (rtc->has_ext_clk) {
> +		reg = rtc_read(rtc, OMAP_RTC_OSC_REG);
> +		rtc_write(rtc, OMAP_RTC_OSC_REG, reg |
> +			  OMAP_RTC_OSC_SEL_32KCLK_SRC);

Odd line break, break after the final comma instead?

> +	}
> +
>  	rtc->type->lock(rtc);
>  
>  	device_init_wakeup(&pdev->dev, true);
> @@ -672,6 +698,7 @@ err:
>  static int __exit omap_rtc_remove(struct platform_device *pdev)
>  {
>  	struct omap_rtc *rtc = platform_get_drvdata(pdev);
> +	u8 reg;
>  
>  	if (pm_power_off == omap_rtc_power_off &&
>  			omap_rtc_power_off_rtc == rtc) {
> @@ -681,10 +708,23 @@ static int __exit omap_rtc_remove(struct platform_device *pdev)
>  
>  	device_init_wakeup(&pdev->dev, 0);
>  
> +	if (!IS_ERR(rtc->ext_clk)) {
> +		clk_disable_unprepare(rtc->ext_clk);
> +	} else {
> +		if (!IS_ERR(rtc->int_clk))
> +			clk_disable_unprepare(rtc->int_clk);
> +	}
> +

This could also be simplified with a single clock entry in rtc.

>  	rtc->type->unlock(rtc);
>  	/* leave rtc running, but disable irqs */
>  	rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, 0);
>  
> +	if (rtc->has_ext_clk) {
> +		reg = rtc_read(rtc, OMAP_RTC_OSC_REG);
> +		reg &= ~OMAP_RTC_OSC_SEL_32KCLK_SRC;
> +		rtc_write(rtc, OMAP_RTC_OSC_REG, reg);
> +	}
> +
>  	rtc->type->lock(rtc);
>  
>  	/* Disable the clock/module */

Johan

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
