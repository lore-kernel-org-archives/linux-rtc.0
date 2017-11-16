Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:37669 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932528AbdKPJpF (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 16 Nov 2017 04:45:05 -0500
Date: Thu, 16 Nov 2017 10:44:52 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-kernel-dev@beckhoff.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Patrick Bruenn <p.bruenn@beckhoff.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Juergen Borleis <jbe@pengutronix.de>,
        Noel Vellemans <Noel.Vellemans@visionbms.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] Documentation: dt: rtc-imxdi: imx53-rtc is not compatible
Message-ID: <20171116094452.as45k3y2dkly6sga@piout.net>
References: <20171116093425.32145-1-linux-kernel-dev@beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171116093425.32145-1-linux-kernel-dev@beckhoff.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

The following patch was already sent by Fabio:
http://patchwork.ozlabs.org/patch/838173/

On 16/11/2017 at 10:34:25 +0100, linux-kernel-dev@beckhoff.com wrote:
> From: Patrick Bruenn <p.bruenn@beckhoff.com>
> 
> rtc-imxdi driver is not compatible with imx53-rtc like the example
> suggested.
> Only the raw timestamp register offsets match by accident, which has the
> effect, that during startup/shutdown system clock syncronization with
> rtc seems to work for imx53, too.
> However hwclock and rtctest, will not work as expected on imx53.
> To avoid future reverts like [1], we should adjust the documentation.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-November/542312.html
> 
> Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>
> 
> ---
> 
> To: Alessandro Zummo <a.zummo@towertech.it>
> To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> Cc: linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM)
> Cc: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> Cc: linux-kernel@vger.kernel.org (open list)
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Juergen Borleis <jbe@pengutronix.de>
> Cc: Noel Vellemans <Noel.Vellemans@visionbms.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> ---
>  Documentation/devicetree/bindings/rtc/imxdi-rtc.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt b/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt
> index 323cf26374cb..af853b0ceac5 100644
> --- a/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt
> +++ b/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt
> @@ -1,6 +1,6 @@
>  * i.MX25 Real Time Clock controller
>  
> -This binding supports the following chips: i.MX25, i.MX53
> +This binding supports the following chips: i.MX25
>  
>  Required properties:
>  - compatible: should be: "fsl,imx25-rtc"
> @@ -14,7 +14,7 @@ Optional properties:
>  Example:
>  
>  rtc@80056000 {
> -	compatible = "fsl,imx53-rtc", "fsl,imx25-rtc";
> +	compatible = "fsl,imx25-rtc";
>  	reg = <0x80056000 2000>;
>  	interrupts = <29 56>;
>  };
> -- 
> 2.11.0
> 
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
