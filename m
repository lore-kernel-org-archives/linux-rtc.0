Return-Path: <rtc-linux+bncBAABBXH52DBQKGQEBXKXQJQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id r1si61551pfg.4.2017.01.09.17.54.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jan 2017 17:54:36 -0800 (PST)
Date: Tue, 10 Jan 2017 09:53:47 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Sascha Hauer <kernel@pengutronix.de>,
	Juergen Borleis <jbe@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [rtc-linux] Re: [PATCH 2/3] ARM: dts: imx25.dtsi: DryIce security
 violation interrupt
Message-ID: <20170110015344.GQ20956@dragon>
References: <1479560614-19293-1-git-send-email-martin@kaiser.cx>
 <1483469457-7863-1-git-send-email-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1483469457-7863-1-git-send-email-martin@kaiser.cx>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Jan 03, 2017 at 07:50:57PM +0100, Martin Kaiser wrote:
> The DryIce block on i.MX25 chipset uses two interrupts: A normal and a
> security violation interrupt. Add the security violation interrupt to
> the list, it is optional.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

It looks like an independent patch, which improves the hardware
description.  So I just applied it.

Shawn

> ---
>  arch/arm/boot/dts/imx25.dtsi |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> index 831d09a..331d1e1 100644
> --- a/arch/arm/boot/dts/imx25.dtsi
> +++ b/arch/arm/boot/dts/imx25.dtsi
> @@ -560,7 +560,7 @@
>  				reg = <0x53ffc000 0x4000>;
>  				clocks = <&clks 81>;
>  				clock-names = "ipg";
> -				interrupts = <25>;
> +				interrupts = <25 56>;
>  			};
>  		};
>  
> -- 
> 1.7.10.4
> 

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
