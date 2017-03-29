Return-Path: <rtc-linux+bncBCQJP74GSUDRBFVS5XDAKGQEKEDIIYA@googlegroups.com>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com. [2607:f8b0:4001:c0b::244])
        by gmr-mx.google.com with ESMTPS id f73si690375ita.1.2017.03.28.23.49.58
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Mar 2017 23:49:58 -0700 (PDT)
Received: by mail-it0-x244.google.com with SMTP id w11so628937itb.0
        for <rtc-linux@googlegroups.com>; Tue, 28 Mar 2017 23:49:58 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20170329012441.bxnkyqui24mymuvr@rob-hp-laptop>
References: <20170322142754.30888-1-chris.brandt@renesas.com>
 <20170322142754.30888-3-chris.brandt@renesas.com> <20170329012441.bxnkyqui24mymuvr@rob-hp-laptop>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Mar 2017 08:49:57 +0200
Message-ID: <CAMuHMdVmwJYMzspVeDqToBrkfK+zGLMNhxGvEbqCA-vuCUXqoQ@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v2 2/7] rtc: Add rtc-sh
To: Rob Herring <robh@kernel.org>
Cc: Chris Brandt <chris.brandt@renesas.com>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Mark Rutland <mark.rutland@arm.com>,
	Simon Horman <horms+renesas@verge.net.au>, RTCLINUX <rtc-linux@googlegroups.com>,
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

Hi Rob,

On Wed, Mar 29, 2017 at 3:24 AM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Mar 22, 2017 at 10:27:49AM -0400, Chris Brandt wrote:
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rtc/rtc-sh.txt
>> @@ -0,0 +1,29 @@
>> +* Real Time Clock for Renesas SH and ARM SoCs
>> +
>> +Required properties:
>> +- compatible: Should be "renesas,r7s72100-rtc" and "renesas,sh-rtc" as a
>> +  fallback.
>> +- reg: physical base address and length of memory mapped region.
>> +- interrupts: 3 interrupts for alarm, period, and carry.
>> +- interrupt-names: The interrupts should be labeled as "alarm", "period", and
>> +  "carry".
>> +- clocks: The functional clock source for the RTC controller must be listed
>> +  first (if exists). Additionally, potential clock counting sources are to be
>> +  listed.
>> +- clock-names: The functional clock must be labeled as "fck". Other clocks
>> +  may be named in accordance to the SoC hardware manuals.
>> +
>> +
>> +Example:
>> +rtc: rtc@fcff1000 {
>> +     compatible = "renesas,r7s72100-rtc", "renesas,sh-rtc";
>> +     reg = <0xfcff1000 0x2e>;
>> +     interrupts = <GIC_SPI 276 IRQ_TYPE_EDGE_RISING
>> +                   GIC_SPI 277 IRQ_TYPE_EDGE_RISING
>> +                   GIC_SPI 278 IRQ_TYPE_EDGE_RISING>;
>> +     interrupt-names = "alarm", "period", "carry";
>> +     clocks = <&mstp6_clks R7S72100_CLK_RTC>, <&rtc_x1_clk>,
>> +              <&rtc_x3_clk>, <&extal_clk>;
>> +     clock-names = "fck", "rtc_x1", "rtc_x3", "extal";
>> +     power-domains = <&cpg_clocks>;
>
> Not documented.

"power-domains" is a platform property.

All hardware components need power.
All synchronous hardware components need a clock.
Most hardware components have a reset signal.

Whether these are exposed and can be controlled depends on the platform/SoC.
So documenting them in each and every device binding looks overkill to me.
I think this is something to be addressed by devicetree-specification (which
doesn't handle clocks, power-domains, resets yet).

If you prefer, the property can be removed from the example, though.

Thanks!

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
