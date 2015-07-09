Return-Path: <rtc-linux+bncBAABBKUM7KWAKGQEZXKFILQ@googlegroups.com>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTP id g7si238589igr.0.2015.07.09.07.33.14
        for <rtc-linux@googlegroups.com>;
        Thu, 09 Jul 2015 07:33:14 -0700 (PDT)
Date: Thu, 9 Jul 2015 22:32:57 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Philippe Reynes <tremyfr@gmail.com>
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	shawn.guo@linaro.org, kernel@pengutronix.de, linux@arm.linux.org.uk,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH v4 6/7] imx27: dt: add support of internal rtc
Message-ID: <20150709143257.GJ23464@tiger>
References: <1435965320-1478-1-git-send-email-tremyfr@gmail.com>
 <1435965320-1478-7-git-send-email-tremyfr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1435965320-1478-7-git-send-email-tremyfr@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Sat, Jul 04, 2015 at 01:15:19AM +0200, Philippe Reynes wrote:
> Add support of internal rtc on imx27.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
> ---
>  arch/arm/boot/dts/imx27.dtsi |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index b69be5c..38e6e84 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -144,6 +144,16 @@
>  				clock-names = "ipg", "per";
>  			};
>  
> +			rtc: rtc@10007000 {
> +				compatible = "fsl,imx21-rtc";
> +				reg = <0x10007000 0x1000>;
> +				interrupts = <22>;
> +				clocks = <&clks IMX27_CLK_CKIL>,
> +					 <&clks IMX27_CLK_RTC_IPG_GATE>;
> +				clock-names = "rtc", "ipg";
> +				status = "disabled";

It has neither pin-out nor board level configuration.  For such device,
it makes more sense to drop status = "disabled" and enable the device by
default.  The bonus point would be that patch #7 in the series can be
saved.

Shawn

> +			};
> +
>  			kpp: kpp@10008000 {
>  				compatible = "fsl,imx27-kpp", "fsl,imx21-kpp";
>  				reg = <0x10008000 0x1000>;
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

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
