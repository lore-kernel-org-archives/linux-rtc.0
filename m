Return-Path: <rtc-linux+bncBDXOFUXT2UGBBQMC57DAKGQEJXFWZVY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from relmlie3.idc.renesas.com (relmlor4.renesas.com. [210.160.252.174])
        by gmr-mx.google.com with ESMTP id 2si1141150pfz.1.2017.03.29.07.14.24
        for <rtc-linux@googlegroups.com>;
        Wed, 29 Mar 2017 07:14:25 -0700 (PDT)
From: Chris Brandt <Chris.Brandt@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>
CC: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, Mark Rutland <mark.rutland@arm.com>,
	Simon Horman <horms+renesas@verge.net.au>, RTCLINUX
	<rtc-linux@googlegroups.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Linux-Renesas
	<linux-renesas-soc@vger.kernel.org>
Subject: [rtc-linux] RE: [PATCH v2 2/7] rtc: Add rtc-sh
Date: Wed, 29 Mar 2017 14:14:20 +0000
Message-ID: <SG2PR06MB11657A015A46C48CDD3858978A350@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170322142754.30888-1-chris.brandt@renesas.com>
 <20170322142754.30888-3-chris.brandt@renesas.com>
 <20170329012441.bxnkyqui24mymuvr@rob-hp-laptop>
 <CAMuHMdVmwJYMzspVeDqToBrkfK+zGLMNhxGvEbqCA-vuCUXqoQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVmwJYMzspVeDqToBrkfK+zGLMNhxGvEbqCA-vuCUXqoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wednesday, March 29, 2017, Geert Uytterhoeven wrote:
> >> +Example:
> >> +rtc: rtc@fcff1000 {
> >> +     compatible = "renesas,r7s72100-rtc", "renesas,sh-rtc";
> >> +     reg = <0xfcff1000 0x2e>;
> >> +     interrupts = <GIC_SPI 276 IRQ_TYPE_EDGE_RISING
> >> +                   GIC_SPI 277 IRQ_TYPE_EDGE_RISING
> >> +                   GIC_SPI 278 IRQ_TYPE_EDGE_RISING>;
> >> +     interrupt-names = "alarm", "period", "carry";
> >> +     clocks = <&mstp6_clks R7S72100_CLK_RTC>, <&rtc_x1_clk>,
> >> +              <&rtc_x3_clk>, <&extal_clk>;
> >> +     clock-names = "fck", "rtc_x1", "rtc_x3", "extal";
> >> +     power-domains = <&cpg_clocks>;
> >
> > Not documented.
> 
> "power-domains" is a platform property.
> 
> All hardware components need power.
> All synchronous hardware components need a clock.
> Most hardware components have a reset signal.
> 
> Whether these are exposed and can be controlled depends on the
> platform/SoC.
> So documenting them in each and every device binding looks overkill to me.
> I think this is something to be addressed by devicetree-specification
> (which doesn't handle clocks, power-domains, resets yet).
> 
> If you prefer, the property can be removed from the example, though.

I'll go ahead and pull it out (since I have to update the commit title
anyway as per Rob's request)

Besides...it's probably the most least important part of the example ;)

Thanks,
Chris

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
