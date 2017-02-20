Return-Path: <rtc-linux+bncBAABBC6ZVTCQKGQE773RRPY@googlegroups.com>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk. [2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by gmr-mx.google.com with ESMTPS id p185si892267wme.1.2017.02.20.09.51.06
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 20 Feb 2017 09:51:06 -0800 (PST)
Date: Mon, 20 Feb 2017 17:50:54 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Jason Cooper <jason@lakedaemon.net>, rtc-linux@googlegroups.com,
	Andrew Lunn <andrew@lunn.ch>, Haim Boot <hayim@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [rtc-linux] Re: [PATCH v2 0/3] Extend rtc-armada38x support for
 Armada 7K/8K
Message-ID: <20170220175054.GP21222@n2100.armlinux.org.uk>
References: <20170217101907.8963-1-gregory.clement@free-electrons.com>
 <87tw7oaj24.fsf@free-electrons.com>
 <20170220173633.d4ke4eohaacgsw3h@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170220173633.d4ke4eohaacgsw3h@piout.net>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, Feb 20, 2017 at 06:36:33PM +0100, Alexandre Belloni wrote:
> On 20/02/2017 at 18:06:11 +0100, Gregory CLEMENT wrote:
> >  On ven., f=C3=A9vr. 17 2017, Gregory CLEMENT <gregory.clement@free-ele=
ctrons.com> wrote:
> >=20
> > > The Armada 7K/8K SoCs use the same RTC IP than the Armada 38x. Howeve=
r
> > > the SOC integration differs in 2 points:
> > >      - MBUS bridge timing initialization
> > >      - IRQ configuration at SoC level
> > >
> > > This patch set extends the driver support to these SoCs family.
> > >
> > > In this second version the device tree was updated allowing to use th=
e
> > > RTC on Armada 80x0 SoCs. Indeed on the Armada 80x0, the RTC clock in
> > > CP master is not connected (by package) to the oscillator. So this on=
e
> > > is disabled for the Armada 8020 and the Armada 8040. On these SoCs it
> > > will be the RTC clock in CP slave connected to the oscillator which
> > > will be used.
> >=20
> > I saw on IRC than Russell managed to have a more coherent date with thi=
s
> > series on his 8040 based board. For the record, as the U-Boot on this
> > board didn't provide a "date reset" command for the RTC located on CP
> > slave, then Russell needed to do the following:
> >=20
> > devmem2 0xf428401c w 0
> > devmem2 0xf4284018 w 0x2000
>=20
> The question being what does that do and whether it could be done in the
> driver instead.

It's not specific to the Armada 8040, the same problem exists with
Armada 38x, so holding this up for that reason does not make sense.

>From what I've been told via SolidRun, it's an errata work-around.
Armada 38x needs "date reset" to be given _twice_ in uboot if the
RTC is not functioning, and part of the "date reset" sequence is
the above couple of register writes.

What effect it would have on an already running RTC is not known -
but using "date reset" in uboot for a correct RTC has the effect of
setting it back to 1970.

On Armada 38x:

Table 1461: RTC Clock Correction Register   Offset:   0x000A3818
Bit         Field                Type / InitVal  Description
31:16       Reserved             RSVD   0x0      Reserved
15          Correct Mode         RW     0x0      Correction Mode
                                                 0 =3D Low
                                                 1 =3D High
14:0        Correct Value        RW     0x0      Correction Value

Table 1462: RTC Test Configuration Register Offset:   0x000A381C
Bit         Field                Type / InitVal   Description
31:5        Reserved             RSVD   0x0       Reserved
4           Func Test            RW     0x0       Functional Test Accelerat=
ion
3:0         Reserved             RSVD   0x0       Reserved

So, we don't know what the first write really does.

I suspect that the errata is "RTC is not reset at power up" for the RTC
power domain.

I don't know where the value of 0x2000 comes from for the correction
value, all I know is that's the value uboot uses with "date reset".
We probably do _not_ want the driver writing that each time the
kernel boots, since that's a tuning parameter.

This is all purely guesswork though.

--=20
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

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
