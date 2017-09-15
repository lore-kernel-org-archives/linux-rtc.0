Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:47393 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbdIOHHh (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 15 Sep 2017 03:07:37 -0400
Subject: Re: [PATCH 2/3] ARM: dts: at91: usb_a9g20: fix rtc node
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        <linux-rtc@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anatolij Gustschin <agust@denx.de>,
        <linuxppc-dev@lists.ozlabs.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
References: <20170915020004.24272-1-alexandre.belloni@free-electrons.com>
 <20170915020004.24272-2-alexandre.belloni@free-electrons.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Message-ID: <bf64c774-9057-d73e-8f39-7fcc5f32725c@microchip.com>
Date: Fri, 15 Sep 2017 09:08:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170915020004.24272-2-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 15/09/2017 at 04:00, Alexandre Belloni wrote:
> The rv3029 compatible is missing its vendor string, add it.
> Also fix the node name to be a proper generic name.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>  arch/arm/boot/dts/usb_a9g20_common.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/usb_a9g20_common.dtsi b/arch/arm/boot/dts/usb_a9g20_common.dtsi
> index 088c2c3685ab..81c3fe0465d9 100644
> --- a/arch/arm/boot/dts/usb_a9g20_common.dtsi
> +++ b/arch/arm/boot/dts/usb_a9g20_common.dtsi
> @@ -20,8 +20,8 @@
>  	};
>  
>  	i2c-gpio-0 {
> -		rv3029c2@56 {
> -			compatible = "rv3029c2";
> +		rtc@56 {
> +			compatible = "microcrystal,rv3029";
>  			reg = <0x56>;
>  		};
>  	};
> 


-- 
Nicolas Ferre
