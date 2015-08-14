Return-Path: <rtc-linux+bncBDS7HNEFSALRBUGPW2XAKGQEBKLZXRY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt6si49683wib.1.2015.08.14.01.33.20
        for <rtc-linux@googlegroups.com>;
        Fri, 14 Aug 2015 01:33:20 -0700 (PDT)
Date: Fri, 14 Aug 2015 10:33:19 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, rtc-linux@googlegroups.com,
	tony@atomide.com, akpm@linux-foundation.org, johan@kernel.org,
	grygorii.strashko@ti.com, bcousson@baylibre.com,
	devicetree@vger.kernel.org, t-kristo@ti.com
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: omap: Add external clock enabling support
Message-ID: <20150814083319.GG22269@piout.net>
References: <1439449668-32301-1-git-send-email-j-keerthy@ti.com>
 <1439449668-32301-3-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1439449668-32301-3-git-send-email-j-keerthy@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 13/08/2015 at 12:37:48 +0530, Keerthy wrote :
> Configure the clock source to either internal clock
> or external clock based on the availability of the clocks.
> External clock is preferred as it can be ticking during suspend.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/rtc/rtc-omap.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 8b6355f..479f730 100644
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
> @@ -136,6 +138,7 @@ struct omap_rtc {
>  	int irq_timer;
>  	u8 interrupts_reg;
>  	bool is_pmic_controller;
> +	bool has_ext_clk;
>  	const struct omap_rtc_device_type *type;
>  };
>  
> @@ -525,6 +528,7 @@ static int omap_rtc_probe(struct platform_device *pdev)
>  {
>  	struct omap_rtc	*rtc;
>  	struct resource	*res;
> +	struct clk *ext_clk, *int_clk;
>  	u8 reg, mask, new_ctrl;
>  	const struct platform_device_id *id_entry;
>  	const struct of_device_id *of_id;
> @@ -553,6 +557,17 @@ static int omap_rtc_probe(struct platform_device *pdev)
>  	if (rtc->irq_alarm <= 0)
>  		return -ENOENT;
>  
> +	ext_clk = devm_clk_get(&pdev->dev, "ext-clk");
> +	if (!IS_ERR(ext_clk)) {
> +		rtc->has_ext_clk = true;
> +		clk_prepare(ext_clk);

I'd say this has to be prepare_enable because you are not enabling those
clocks anywhere

> +	} else {
> +		int_clk = devm_clk_get(&pdev->dev, "int-clk");
> +
> +		if (!IS_ERR(int_clk))
> +			clk_prepare(int_clk);
> +	}
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	rtc->base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(rtc->base))
> @@ -627,6 +642,17 @@ static int omap_rtc_probe(struct platform_device *pdev)
>  	if (reg != new_ctrl)
>  		rtc_write(rtc, OMAP_RTC_CTRL_REG, new_ctrl);
>  
> +	/*
> +	 * If we have the external clock then
> +	 * Switch to external clock so we can keep ticking
> +	 * acorss suspend
> +	 */
> +	if (rtc->has_ext_clk) {
> +		reg = rtc_read(rtc, OMAP_RTC_OSC_REG);
> +		rtc_write(rtc, OMAP_RTC_OSC_REG, reg |
> +			  OMAP_RTC_OSC_SEL_32KCLK_SRC);
> +	}
> +
>  	rtc->type->lock(rtc);
>  
>  	device_init_wakeup(&pdev->dev, true);
> @@ -672,6 +698,8 @@ err:
>  static int __exit omap_rtc_remove(struct platform_device *pdev)
>  {
>  	struct omap_rtc *rtc = platform_get_drvdata(pdev);
> +	struct clk *ext_clk, *int_clk;
> +	u8 reg;
>  
>  	if (pm_power_off == omap_rtc_power_off &&
>  			omap_rtc_power_off_rtc == rtc) {
> @@ -681,10 +709,26 @@ static int __exit omap_rtc_remove(struct platform_device *pdev)
>  
>  	device_init_wakeup(&pdev->dev, 0);
>  
> +	ext_clk = devm_clk_get(&pdev->dev, "ext-clk");
> +	if (!IS_ERR(ext_clk)) {
> +		clk_unprepare(ext_clk);
> +	} else {
> +		int_clk = devm_clk_get(&pdev->dev, "int-clk");
> +
> +		if (!IS_ERR(int_clk))
> +			clk_unprepare(int_clk);
> +	}
> +

You can probably add ext_clk and int_clk to struct omap_rtc and avoid
those devm_clk_get.

>  	rtc->type->unlock(rtc);
>  	/* leave rtc running, but disable irqs */
>  	rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, 0);
>  
> +	if (rtc->has_ext_clk) {

Then you could also avoid has_ext_clk and simply test rtc->ext_clk.

> +		reg = rtc_read(rtc, OMAP_RTC_OSC_REG);
> +		reg &= ~OMAP_RTC_OSC_SEL_32KCLK_SRC;
> +		rtc_write(rtc, OMAP_RTC_OSC_REG, reg);
> +	}
> +
>  	rtc->type->lock(rtc);
>  
>  	/* Disable the clock/module */
> -- 
> 1.9.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
