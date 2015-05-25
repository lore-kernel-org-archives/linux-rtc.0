Return-Path: <rtc-linux+bncBCV3TM5A74DRBS5DROVQKGQEVUZ7XQI@googlegroups.com>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com. [209.85.220.43])
        by gmr-mx.google.com with ESMTPS id xz5si1029353pac.1.2015.05.25.00.39.54
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 May 2015 00:39:54 -0700 (PDT)
Received: by mail-pa0-f43.google.com with SMTP id wv17so65920009pac.2
        for <rtc-linux@googlegroups.com>; Mon, 25 May 2015 00:39:54 -0700 (PDT)
Date: Mon, 25 May 2015 15:39:05 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Frank.Li@freescale.com
Cc: lznuaa@gmail.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org,
	alexandre.belloni@free-electrons.com, linux@arm.linux.org.uk,
	linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v4 6/6] arm: dts: imx6sx: enable snvs power key
Message-ID: <20150525073904.GJ3264@dragon>
References: <1432305399-30571-1-git-send-email-Frank.Li@freescale.com>
 <1432305399-30571-7-git-send-email-Frank.Li@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1432305399-30571-7-git-send-email-Frank.Li@freescale.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Fri, May 22, 2015 at 10:36:39PM +0800, Frank.Li@freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> enable snvs ONOFF power key support
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>

Please use 'ARM: dts: imx6sx: ...' for the patch subject.

> ---
>  arch/arm/boot/dts/imx6sx.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 3cb3b5b..ad38aea 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -677,6 +677,13 @@
>  					mask = <0x60>;
>  					status = "disabled";
>  				};
> +
> +				snvs_pwrkey: snvs-powerkey {
> +					compatible = "fsl,sec-v4.0-pwrkey";
> +					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +					linux,keycode = <116>; /* KEY_POWER */

With include/dt-bindings/input/input.h, you can use KEY_POWER directly
and save the comment.

Shawn

> +					wakeup;
> +				};
>  			};
>  
>  			epit1: epit@020d0000 {
> -- 
> 1.9.1
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
