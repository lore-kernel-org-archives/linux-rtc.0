Return-Path: <rtc-linux+bncBDXOFUXT2UGBB66OV7DAKGQEB3GVHKY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from relmlie2.idc.renesas.com (relmlor3.renesas.com. [210.160.252.173])
        by gmr-mx.google.com with ESMTP id 2si1437380pfx.8.2017.03.17.06.41.14
        for <rtc-linux@googlegroups.com>;
        Fri, 17 Mar 2017 06:41:15 -0700 (PDT)
From: Chris Brandt <Chris.Brandt@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Simon Horman
	<horms+renesas@verge.net.au>, RTCLINUX <rtc-linux@googlegroups.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-Renesas
	<linux-renesas-soc@vger.kernel.org>
Subject: [rtc-linux] RE: [PATCH 2/5] rtc: Add rtc-sh
Date: Fri, 17 Mar 2017 13:41:10 +0000
Message-ID: <SG2PR06MB11653BB788CADBEE78FE4CF58A390@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170316175112.27913-1-chris.brandt@renesas.com>
 <20170316175112.27913-3-chris.brandt@renesas.com>
 <CAMuHMdVu0dQjptyW0F5YS+V6sixXTM3P6VWq2=8BQ5njUOXf-Q@mail.gmail.com>
 <SG2PR06MB1165A9931C930DF9BCD5C0A98A390@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <CAMuHMdW0nHiZkE_RxVLX3G0MuwQLPHVFyNq5C1tx0yAqDQefaA@mail.gmail.com>
In-Reply-To: <CAMuHMdW0nHiZkE_RxVLX3G0MuwQLPHVFyNq5C1tx0yAqDQefaA@mail.gmail.com>
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

Hi Geert,

On Friday, March 17, 2017, Geert Uytterhoeven wrote:
> > On Friday, March 17, 2017, Geert Uytterhoeven wrote:
> >> On Thu, Mar 16, 2017 at 6:51 PM, Chris Brandt
> >> <chris.brandt@renesas.com>
> >> wrote:
> >> > +- clocks: the clock source for the RTC controller.
> >>
> >> The datasheet mentions 3 possible clock sources?
> >
> > There is the clock source that does the counting (RTC_X1, RTC_X3, XTAL),
> and then a clock source that runs the register interface (run off of the
> p0 clock). So I just need to turn on the p0 clock so I can get at the
> registers. Note that if you do a hard reset with a RESET button, and all
> the registers in the chip go back to their POR state, the counter still
> counts off of the 32KHz XTAL even though the "peripheral clock" is stopped
> (which just means you can't get to the registers).
> >
> > In reality, you have to assume the RTC counting source has already been
> set up by u-boot, or from a past reboot, so I don't do any of that select
> configuration at all.
> 
> it would still be good to have phandles to the external clock sources as
> well, as that describes the hardware topology.

I'm confused, you mean make new clocks node for RTC_X1 (fixed at 32.768kHZ) and
RTC_X3 (fixed at 4MHz), but then not really do anything with then? (the driver
doesn't need them)


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
