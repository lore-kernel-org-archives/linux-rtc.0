Return-Path: <rtc-linux+bncBCLMRFWKZAIBBNWN42VAKGQEGWNWW6A@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:6f8:1178:4:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id gt9si322622wib.2.2015.05.18.01.45.42
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 01:45:42 -0700 (PDT)
Message-ID: <1431938725.3209.15.camel@pengutronix.de>
Subject: [rtc-linux] Re: [PATCH 4/7] arm: dts: imx: update snvs to use syscon
 access register
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Frank.Li@freescale.com
Cc: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com,
 robh+dt@kernel.org, a.zummo@towertech.it,
 alexandre.belloni@free-electrons.com,  sachin.kamat@linaro.org,
 linux-arm-kernel@lists.infradead.org,  linux-input@vger.kernel.org,
 rtc-linux@googlegroups.com,  linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
Date: Mon, 18 May 2015 10:45:25 +0200
In-Reply-To: <1431696990-23078-5-git-send-email-Frank.Li@freescale.com>
References: <1431696990-23078-1-git-send-email-Frank.Li@freescale.com>
	 <1431696990-23078-5-git-send-email-Frank.Li@freescale.com>
Content-Type: text/plain; charset=UTF-8
Mime-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Frank,

Am Freitag, den 15.05.2015, 21:36 +0800 schrieb Frank.Li@freescale.com:
> From: Frank Li <Frank.Li@freescale.com>
> 
> snvs is MFP device. Change dts to use syscon to allocate register resource.
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 12 ++++--------
>  arch/arm/boot/dts/imx6sl.dtsi  | 12 ++++--------
>  arch/arm/boot/dts/imx6sx.dtsi  | 12 ++++--------
>  arch/arm/boot/dts/vfxxx.dtsi   |  9 +++------
>  4 files changed, 15 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 0482a66..6d8161d 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -687,21 +687,17 @@
>  			};
>  
>  			snvs@020cc000 {
> -				compatible = "fsl,sec-v4.0-mon", "simple-bus";
> -				#address-cells = <1>;
> -				#size-cells = <1>;
> -				ranges = <0 0x020cc000 0x4000>;
> +				compatible = "fsl,sec-v4.0-mon", "syscon",  "simple-bus";

The compatible should change from "simple-bus" to "simple-mfd", then.

regards
Philipp

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
