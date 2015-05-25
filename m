Return-Path: <rtc-linux+bncBCV3TM5A74DRBQ4HROVQKGQEPAQTRDA@googlegroups.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com. [209.85.220.45])
        by gmr-mx.google.com with ESMTPS id xz5si1015422pac.1.2015.05.24.23.40.03
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2015 23:40:03 -0700 (PDT)
Received: by pabru16 with SMTP id ru16so64943250pab.1
        for <rtc-linux@googlegroups.com>; Sun, 24 May 2015 23:40:03 -0700 (PDT)
Date: Mon, 25 May 2015 14:39:14 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Frank.Li@freescale.com
Cc: lznuaa@gmail.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org,
	alexandre.belloni@free-electrons.com, linux@arm.linux.org.uk,
	linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v4 3/6] arm: dts: imx: update snvs to use
 syscon access register
Message-ID: <20150525063913.GF3264@dragon>
References: <1432305399-30571-1-git-send-email-Frank.Li@freescale.com>
 <1432305399-30571-4-git-send-email-Frank.Li@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1432305399-30571-4-git-send-email-Frank.Li@freescale.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Fri, May 22, 2015 at 10:36:36PM +0800, Frank.Li@freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> snvs is MFP device. Change dts to use syscon to allocate register resource.
> snvs power off also switch to common syscon-poweroff
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 19 +++++++++----------
>  arch/arm/boot/dts/imx6sl.dtsi  | 19 +++++++++----------
>  arch/arm/boot/dts/imx6sx.dtsi  | 17 ++++++++---------
>  arch/arm/boot/dts/vfxxx.dtsi   |  9 +++------
>  4 files changed, 29 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 0482a66..4f3f5f4 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -686,22 +686,21 @@
>  				fsl,anatop = <&anatop>;
>  			};
>  
> -			snvs@020cc000 {
> -				compatible = "fsl,sec-v4.0-mon", "simple-bus";
> -				#address-cells = <1>;
> -				#size-cells = <1>;
> -				ranges = <0 0x020cc000 0x4000>;
> +			snvs:snvs@020cc000 {

There should be a space between label and node.

> +				compatible = "fsl,sec-v4.0-mon", "syscon",  "simple-mfd";

One space is enough in between.

> +				reg = <0x020cc000 0x4000>;
>  
> -				snvs_rtc: snvs-rtc-lp@34 {
> +				snvs_rtc: snvs-rtc-lp {
>  					compatible = "fsl,sec-v4.0-mon-rtc-lp";
> -					reg = <0x34 0x58>;

I think rtc node should have a similar property list like snvs-poweroff,
i.e. regmap and offset.

Shawn

>  					interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>,
>  						     <0 20 IRQ_TYPE_LEVEL_HIGH>;
>  				};
>  
> -				snvs_poweroff: snvs-poweroff@38 {
> -					compatible = "fsl,sec-v4.0-poweroff";
> -					reg = <0x38 0x4>;
> +				snvs_poweroff: snvs-poweroff {
> +					compatible = "syscon-poweroff";
> +					regmap = <&snvs>;
> +					offset = <0x38>;
> +					mask = <0x60>;
>  					status = "disabled";
>  				};
>  			};
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index a78e715..2de6d46 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -563,22 +563,21 @@
>  				fsl,anatop = <&anatop>;
>  			};
>  
> -			snvs@020cc000 {
> -				compatible = "fsl,sec-v4.0-mon", "simple-bus";
> -				#address-cells = <1>;
> -				#size-cells = <1>;
> -				ranges = <0 0x020cc000 0x4000>;
> +			snvs:snvs@020cc000 {
> +				compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
> +				reg = <0x020cc000 0x4000>;
>  
> -				snvs_rtc: snvs-rtc-lp@34 {
> +				snvs_rtc: snvs-rtc-lp {
>  					compatible = "fsl,sec-v4.0-mon-rtc-lp";
> -					reg = <0x34 0x58>;
>  					interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>,
>  						     <0 20 IRQ_TYPE_LEVEL_HIGH>;
>  				};
>  
> -				snvs_poweroff: snvs-poweroff@38 {
> -					compatible = "fsl,sec-v4.0-poweroff";
> -					reg = <0x38 0x4>;
> +				snvs_poweroff: snvs-poweroff {
> +					compatible = "syscon-poweroff";
> +					regmap = <&snvs>;
> +					offset = <0x38>;
> +					mask = <0x60>;
>  					status = "disabled";
>  				};
>  			};
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 708175d..3cb3b5b 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -662,20 +662,19 @@
>  			};
>  
>  			snvs: snvs@020cc000 {
> -				compatible = "fsl,sec-v4.0-mon", "simple-bus";
> -				#address-cells = <1>;
> -				#size-cells = <1>;
> -				ranges = <0 0x020cc000 0x4000>;
> +				compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
> +				reg = <0x020cc000 0x4000>;
>  
> -				snvs_rtc: snvs-rtc-lp@34 {
> +				snvs_rtc: snvs-rtc-lp {
>  					compatible = "fsl,sec-v4.0-mon-rtc-lp";
> -					reg = <0x34 0x58>;
>  					interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
>  				};
>  
> -				snvs_poweroff: snvs-poweroff@38 {
> -					compatible = "fsl,sec-v4.0-poweroff";
> -					reg = <0x38 0x4>;
> +				snvs_poweroff: snvs-poweroff {
> +					compatible = "syscon-poweroff";
> +					regmap = <&snvs>;
> +					offset = <0x38>;
> +					mask = <0x60>;
>  					status = "disabled";
>  				};
>  			};
> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> index 4aa3351..fccfc01 100644
> --- a/arch/arm/boot/dts/vfxxx.dtsi
> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> @@ -404,14 +404,11 @@
>  			};
>  
>  			snvs0: snvs@400a7000 {
> -			    compatible = "fsl,sec-v4.0-mon", "simple-bus";
> -				#address-cells = <1>;
> -				#size-cells = <1>;
> -				ranges = <0 0x400a7000 0x2000>;
> +			    compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
> +				reg = <0x400a7000 0x2000>;
>  
> -				snvsrtc: snvs-rtc-lp@34 {
> +				snvsrtc: snvs-rtc-lp {
>  					compatible = "fsl,sec-v4.0-mon-rtc-lp";
> -					reg = <0x34 0x58>;
>  					interrupts = <100 IRQ_TYPE_LEVEL_HIGH>;
>  					clocks = <&clks VF610_CLK_SNVS>;
>  					clock-names = "snvs-rtc";
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
