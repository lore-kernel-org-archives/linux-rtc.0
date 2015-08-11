Return-Path: <rtc-linux+bncBDS7HNEFSALRBF4AVCXAKGQEADQYHRA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt6si383080wib.1.2015.08.11.07.00.55
        for <rtc-linux@googlegroups.com>;
        Tue, 11 Aug 2015 07:00:55 -0700 (PDT)
Date: Tue, 11 Aug 2015 16:00:54 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, pawel.moll@arm.com,
	galak@codeaurora.org, paul@pwsan.com, akpm@linux-foundation.org,
	johan@kernel.org, grygorii.strashko@ti.com,
	rtc-linux@googlegroups.com, bcousson@baylibre.com, nm@ti.com,
	devicetree@vger.kernel.org, t-kristo@ti.com
Subject: [rtc-linux] Re: [PATCH v2 2/6] rtc: omap: Add external clock enabling support
Message-ID: <20150811140054.GM3411@piout.net>
References: <1439198906-31189-1-git-send-email-j-keerthy@ti.com>
 <1439198906-31189-3-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1439198906-31189-3-git-send-email-j-keerthy@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

This seems better but:

On 10/08/2015 at 14:58:22 +0530, Keerthy wrote :
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index d99b2ee..756819f 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -336,6 +336,8 @@
>  			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH
>  				      GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
>  			ti,hwmods = "rtc";
> +			clocks = <&clk_32768_ck>, <&clk_32k_rtc>;
> +			clock-names = "int-clk", "ext-clk";
>  			status = "disabled";
>  		};
>  

This change has to be part of another patch.

> @@ -698,6 +706,7 @@ static int __exit omap_rtc_remove(struct platform_device *pdev)
>  static int omap_rtc_suspend(struct device *dev)
>  {
>  	struct omap_rtc *rtc = dev_get_drvdata(dev);
> +	u8 reg;
>  
>  	rtc->interrupts_reg = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
>  
> @@ -711,6 +720,18 @@ static int omap_rtc_suspend(struct device *dev)
>  		enable_irq_wake(rtc->irq_alarm);
>  	else
>  		rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, 0);
> +
> +	/*
> +	 * If we have the luxury of external clock then
> +	 * Switch to external clock so we can keep ticking
> +	 * acorss suspend
> +	 */
> +	if (rtc->has_ext_clk) {
> +		reg = rtc_read(rtc, OMAP_RTC_OSC_REG);
> +		rtc_write(rtc, OMAP_RTC_OSC_REG, reg |
> +			  OMAP_RTC_OSC_SEL_32KCLK_SRC);
> +	}
> +

You should probably prepare/enable the clock before switching to it. I
know it doesn't matter right now but that may not be the case on other
boards.

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
