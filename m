Return-Path: <rtc-linux+bncBCQJP74GSUDRBEVXV3DAKGQEMDRNKZA@googlegroups.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com. [2607:f8b0:4001:c0b::243])
        by gmr-mx.google.com with ESMTPS id 125si476677ite.0.2017.03.17.01.17.22
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 01:17:22 -0700 (PDT)
Received: by mail-it0-x243.google.com with SMTP id r141so2684416ita.1
        for <rtc-linux@googlegroups.com>; Fri, 17 Mar 2017 01:17:22 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20170316175112.27913-3-chris.brandt@renesas.com>
References: <20170316175112.27913-1-chris.brandt@renesas.com> <20170316175112.27913-3-chris.brandt@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Mar 2017 09:17:20 +0100
Message-ID: <CAMuHMdVu0dQjptyW0F5YS+V6sixXTM3P6VWq2=8BQ5njUOXf-Q@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 2/5] rtc: Add rtc-sh
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms+renesas@verge.net.au>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Chris,

On Thu, Mar 16, 2017 at 6:51 PM, Chris Brandt <chris.brandt@renesas.com> wrote:
> rtc-sh is a RTC for SuperH and RZ/A SoCs.

an RTC?

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/rtc-sh.txt
> @@ -0,0 +1,19 @@
> +* Real Time Clock for Renesas SH and ARM SoCs
> +
> +Required properties:
> +- compatible: Should be "renesas,r7s72100-rtc" or "renesas,sh-rtc" as a

s/or/and/

> +  fallback.
> +- reg: physical base address and length of memory mapped region.
> +- interrupts: 3 interrupts for alarm, period, and carry.

If there's a need for multiple interrupts, it's always a good idea to use
interrupt-names. The datasheet calls them "arm", "prd", and "cup", but
I wouldn't object against "alarm", "period", and "carry" ;-)

> +- clocks: the clock source for the RTC controller.

The datasheet mentions 3 possible clock sources?

> +Example:
> +rtc: rtc@fcff1000 {
> +       compatible = "renesas,r7s72100-rtc", "renesas,sh-rtc";
> +       reg = <0xfcff1000 0x2e>;
> +       interrupts = <GIC_SPI 276 IRQ_TYPE_EDGE_RISING
> +                     GIC_SPI 277 IRQ_TYPE_EDGE_RISING
> +                     GIC_SPI 278 IRQ_TYPE_EDGE_RISING>;
> +       clocks = <&mstp6_clks R7S72100_CLK_RTC>;
> +       power-domains = <&cpg_clocks>;
> +};

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
