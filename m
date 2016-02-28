Return-Path: <rtc-linux+bncBDS7HNEFSALRBQ6TZO3AKGQE5FQYHIA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s141si540250wmd.1.2016.02.28.04.36.19
        for <rtc-linux@googlegroups.com>;
        Sun, 28 Feb 2016 04:36:19 -0800 (PST)
Date: Sun, 28 Feb 2016 13:36:18 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
	rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] rv3029 EEPROM handling
Message-ID: <20160228123618.GD2398@piout.net>
References: <20160227153918.3c3d3853@wiggum>
 <20160228003139.GB2398@piout.net>
 <20160228094452.132c1938@wiggum>
 <20160228104110.GC2398@piout.net>
 <20160228125852.1a0b271e@wiggum>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160228125852.1a0b271e@wiggum>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 28/02/2016 at 12:58:52 +0100, Michael B=C3=BCsch wrote :
> On Sun, 28 Feb 2016 11:41:10 +0100
> Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
>=20
> > ds1339, ds1390 and bq32k are using trickle-resistor-ohms and
> > trickle-diode-disable.
>=20
>=20
> The rv3029 datasheet doesn't say anything about a diode (I think it
> still has one though). It merely talks about resistors connected
> between vdd and the battery pin.
> So I'm not sure whether we should use the 'trickle-diode-disable'
> property here. One other possibility would be to use
> trickle-resistor-ohms=3D-1 or such to disable the charger.
>=20

More simply, don't enable the trickle charger if the
trickle-resistor-ohms property is missing.

Leave out the trickle-diode-disable property

>=20
> > > The rv3029 does the compensation internally. It just needs to be
> > > enabled via a bit in its EEPROM. We could probably always set that bi=
t
> > > though. I'm not sure whether there is a case where one would not want
> > > that.
> > >  =20
> >=20
> > If you want to enable it without changing the values, just enable it
> > unconditionally.
>=20
>=20
> I think the internal temperature compensation should be enabled by
> default and be disabled via DT property ('temp-compensation-disable'
> or such).
>=20

That part is not HW related, it should not be in the device tree. I'd
really just enable the temperature compensation else, this has to be
done in sysfs



--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--=20
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
