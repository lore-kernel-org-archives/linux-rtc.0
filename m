Return-Path: <rtc-linux+bncBAABBCMUS7BQKGQEPB3OX5I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id t67si14357953pfd.3.2016.12.29.18.44.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Dec 2016 18:44:25 -0800 (PST)
Date: Fri, 30 Dec 2016 10:44:10 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	Juergen Borleis <jbe@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [rtc-linux] Re: [PATCH 2/2 v2] ARM: i.MX25: add the optional security
 violation irq
Message-ID: <20161230024409.GK6177@dragon>
References: <1479560614-19293-1-git-send-email-martin@kaiser.cx>
 <1482361276-12475-1-git-send-email-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1482361276-12475-1-git-send-email-martin@kaiser.cx>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, Dec 22, 2016 at 12:01:16AM +0100, Martin Kaiser wrote:
> Add the security violation irq as an optional entry to rtc-imxdi's
> device tree bindings and to i.MX25's dtsi file.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v2:
>   - clarify that the security violation interrupt is optional
>   - use the same syntax as everwhere else for lists of interrupt numbers
> 
>  Documentation/devicetree/bindings/rtc/imxdi-rtc.txt |    5 ++++-
>  arch/arm/boot/dts/imx25.dtsi                        |    2 +-

I take DTS changes only.  Please make the bindings doc change a separate
patch, and have it go together with driver patch.  And I apply DTS patch
only after driver and bindings changes get accepted by RTC maintainer.

Shawn

>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt b/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt
> index c9d80d7..323cf26 100644
> --- a/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt
> +++ b/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt
> @@ -8,10 +8,13 @@ Required properties:
>    region.
>  - interrupts: rtc alarm interrupt
>  
> +Optional properties:
> +- interrupts: dryice security violation interrupt
> +
>  Example:
>  
>  rtc@80056000 {
>  	compatible = "fsl,imx53-rtc", "fsl,imx25-rtc";
>  	reg = <0x80056000 2000>;
> -	interrupts = <29>;
> +	interrupts = <29 56>;
>  };
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
