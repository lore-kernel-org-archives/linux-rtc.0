Return-Path: <rtc-linux+bncBCQJP74GSUDRB2PWR3DQKGQEUY44Q2I@googlegroups.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com. [2607:f8b0:4001:c0b::242])
        by gmr-mx.google.com with ESMTPS id a17si1834588itd.1.2017.04.04.08.27.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Apr 2017 08:27:36 -0700 (PDT)
Received: by mail-it0-x242.google.com with SMTP id y18so11477290itc.2
        for <rtc-linux@googlegroups.com>; Tue, 04 Apr 2017 08:27:36 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <CAL_JsqLLZsLzS4ONOexJADQXXXr9iquFUcVj8kX6AEVwM+x56A@mail.gmail.com>
References: <20170322142754.30888-1-chris.brandt@renesas.com>
 <20170322142754.30888-3-chris.brandt@renesas.com> <20170329012441.bxnkyqui24mymuvr@rob-hp-laptop>
 <CAMuHMdVmwJYMzspVeDqToBrkfK+zGLMNhxGvEbqCA-vuCUXqoQ@mail.gmail.com> <CAL_JsqLLZsLzS4ONOexJADQXXXr9iquFUcVj8kX6AEVwM+x56A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 4 Apr 2017 17:27:35 +0200
Message-ID: <CAMuHMdWs5ecdD6oCZ9ZO-mWkqwTJabHcn26TgfSwA4cGbp=9=Q@mail.gmail.com>
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

On Tue, Apr 4, 2017 at 4:29 PM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Mar 29, 2017 at 1:49 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Wed, Mar 29, 2017 at 3:24 AM, Rob Herring <robh@kernel.org> wrote:
>>> On Wed, Mar 22, 2017 at 10:27:49AM -0400, Chris Brandt wrote:
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/rtc/rtc-sh.txt

>>>> +Example:
>>>> +rtc: rtc@fcff1000 {
>>>> +     compatible = "renesas,r7s72100-rtc", "renesas,sh-rtc";
>>>> +     reg = <0xfcff1000 0x2e>;
>>>> +     interrupts = <GIC_SPI 276 IRQ_TYPE_EDGE_RISING
>>>> +                   GIC_SPI 277 IRQ_TYPE_EDGE_RISING
>>>> +                   GIC_SPI 278 IRQ_TYPE_EDGE_RISING>;
>>>> +     interrupt-names = "alarm", "period", "carry";
>>>> +     clocks = <&mstp6_clks R7S72100_CLK_RTC>, <&rtc_x1_clk>,
>>>> +              <&rtc_x3_clk>, <&extal_clk>;
>>>> +     clock-names = "fck", "rtc_x1", "rtc_x3", "extal";
>>>> +     power-domains = <&cpg_clocks>;
>>>
>>> Not documented.
>>
>> "power-domains" is a platform property.
>>
>> All hardware components need power.
>> All synchronous hardware components need a clock.
>> Most hardware components have a reset signal.
>
> And we document clocks and reset for every binding.

Then we'll have to add lots of them ;-)

Usually these are documented only if the user (the driver) cares about them,
and/or if there are multiple of the same type. E.g.
  - The driver needs to know or control a clock frequency,
  - The driver needs to enable/disable a clock,
  - The driver needs to know or control one or more voltages,
  - ...

It's not that devices without documented regulators, power-domains, or clocks
properties no longer consume power or don't run from a clock.  These are just
not described in DT, as deemed unimportant.  But on some platforms, they may
become important.

>> Whether these are exposed and can be controlled depends on the platform/SoC.
>> So documenting them in each and every device binding looks overkill to me.
>> I think this is something to be addressed by devicetree-specification (which
>> doesn't handle clocks, power-domains, resets yet).
>
> It's a question of validation. How do I validate power-domains is a
> valid property for a given compatible? What if it is required, but not

With platform property, I mean that it depends on the platform, not on the
compatible value of the device.

For a generic compatible value ("renesas,sh-srtc") you cannot know, as
it depends on the actual SoC the (same) RTC device is part of.

For an SoC-specific compatible value ("renesas,r7s72100-rtc"), you could know
from the compatible value (an r7s72100 SoC must have r7s72100 clocks, and the
r7s72100 clock domain, cfr.
Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt).
However. the SoC-specific compatible values exist only as a workaround
for not knowing
the exact version of the IP cores.

> present? Any node can have it? So it is valid for memory and chosen
> nodes, an i2c device, an LCD panel, etc?

It's not valid for a chosen node ;-)

It can be valid for memory (or the memory-controller; oops, the memory node is
not a child of the memory-controller node), i2c devices, LCD panels, ...
depending on the platform.

Consider e.g. i2c devices. I can add a GPIO-controlled MOSFET bank to my board,
to enable power to individual i2c devices, and abstract that as a
power-controller in DT.  Suddenly I have to add power-domains properties to the
individual i2c device nodes, while the i2c devices itself haven't changed, and
thus keep the same compatible values.
Should I now document the power-domains property in the i2c devices' DT binding
documents?

On Linux, the drivers won't care, as the platform-specific things are handled
transparently by Runtime PM.

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
