Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBK6SVTCQKGQEKOGB6XI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id y19si776527wmd.0.2017.02.20.09.36.43
        for <rtc-linux@googlegroups.com>;
        Mon, 20 Feb 2017 09:36:43 -0800 (PST)
Date: Mon, 20 Feb 2017 18:36:33 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, Haim Boot <hayim@marvell.com>
Subject: [rtc-linux] Re: [PATCH v2 0/3] Extend rtc-armada38x support for
 Armada 7K/8K
Message-ID: <20170220173633.d4ke4eohaacgsw3h@piout.net>
References: <20170217101907.8963-1-gregory.clement@free-electrons.com>
 <87tw7oaj24.fsf@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <87tw7oaj24.fsf@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 20/02/2017 at 18:06:11 +0100, Gregory CLEMENT wrote:
>  On ven., f=C3=A9vr. 17 2017, Gregory CLEMENT <gregory.clement@free-elect=
rons.com> wrote:
>=20
> > The Armada 7K/8K SoCs use the same RTC IP than the Armada 38x. However
> > the SOC integration differs in 2 points:
> >      - MBUS bridge timing initialization
> >      - IRQ configuration at SoC level
> >
> > This patch set extends the driver support to these SoCs family.
> >
> > In this second version the device tree was updated allowing to use the
> > RTC on Armada 80x0 SoCs. Indeed on the Armada 80x0, the RTC clock in
> > CP master is not connected (by package) to the oscillator. So this one
> > is disabled for the Armada 8020 and the Armada 8040. On these SoCs it
> > will be the RTC clock in CP slave connected to the oscillator which
> > will be used.
>=20
> I saw on IRC than Russell managed to have a more coherent date with this
> series on his 8040 based board. For the record, as the U-Boot on this
> board didn't provide a "date reset" command for the RTC located on CP
> slave, then Russell needed to do the following:
>=20
> devmem2 0xf428401c w 0
> devmem2 0xf4284018 w 0x2000

The question being what does that do and whether it could be done in the
driver instead.

--=20
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

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
