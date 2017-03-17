Return-Path: <rtc-linux+bncBDXOFUXT2UGBBMGDV7DAKGQEFAZIMFI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from relmlie4.idc.renesas.com (relmlor1.renesas.com. [210.160.252.171])
        by gmr-mx.google.com with ESMTP id r66si1392458pfb.7.2017.03.17.06.16.31
        for <rtc-linux@googlegroups.com>;
        Fri, 17 Mar 2017 06:16:32 -0700 (PDT)
From: Chris Brandt <Chris.Brandt@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Simon Horman
	<horms+renesas@verge.net.au>, RTCLINUX <rtc-linux@googlegroups.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-Renesas
	<linux-renesas-soc@vger.kernel.org>
Subject: [rtc-linux] RE: [PATCH 2/5] rtc: Add rtc-sh
Date: Fri, 17 Mar 2017 13:16:25 +0000
Message-ID: <SG2PR06MB1165A9931C930DF9BCD5C0A98A390@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170316175112.27913-1-chris.brandt@renesas.com>
 <20170316175112.27913-3-chris.brandt@renesas.com>
 <CAMuHMdVu0dQjptyW0F5YS+V6sixXTM3P6VWq2=8BQ5njUOXf-Q@mail.gmail.com>
In-Reply-To: <CAMuHMdVu0dQjptyW0F5YS+V6sixXTM3P6VWq2=8BQ5njUOXf-Q@mail.gmail.com>
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


Happy St Patrick's Day!

    (I know you are not Irish....but you are closer to Ireland than I am ;)


On Friday, March 17, 2017, Geert Uytterhoeven wrote:
> On Thu, Mar 16, 2017 at 6:51 PM, Chris Brandt <chris.brandt@renesas.com>
> wrote:
> > rtc-sh is a RTC for SuperH and RZ/A SoCs.
>=20
> an RTC?

Good point. That's more better ;)


> > +Required properties:
> > +- compatible: Should be "renesas,r7s72100-rtc" or "renesas,sh-rtc" as
> > +a
>=20
> s/or/and/

OK


> > +  fallback.
> > +- reg: physical base address and length of memory mapped region.
> > +- interrupts: 3 interrupts for alarm, period, and carry.
>=20
> If there's a need for multiple interrupts, it's always a good idea to use
> interrupt-names. The datasheet calls them "arm", "prd", and "cup", but I
> wouldn't object against "alarm", "period", and "carry" ;-)

OK. I'll change.
I like the longer names as well ("prd" looks ugly)


> > +- clocks: the clock source for the RTC controller.
>=20
> The datasheet mentions 3 possible clock sources?

There is the clock source that does the counting (RTC_X1, RTC_X3, XTAL), an=
d then a clock source that runs the register interface (run off of the p0 c=
lock). So I just need to turn on the p0 clock so I can get at the registers=
. Note that if you do a hard reset with a RESET button, and all the registe=
rs in the chip go back to their POR state, the counter still counts off of =
the 32KHz XTAL even though the "peripheral clock" is stopped (which just me=
ans you can't get to the registers).

In reality, you have to assume the RTC counting source has already been set=
 up by u-boot, or from a past reboot, so I don't do any of that select conf=
iguration at all.


Chris

--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
