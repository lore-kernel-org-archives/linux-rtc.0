Return-Path: <rtc-linux+bncBDS7HNEFSALRBR45ZO3AKGQEFPEPOAY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w10si420455wmw.3.2016.02.28.02.41.11
        for <rtc-linux@googlegroups.com>;
        Sun, 28 Feb 2016 02:41:11 -0800 (PST)
Date: Sun, 28 Feb 2016 11:41:10 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
	rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] rv3029 EEPROM handling
Message-ID: <20160228104110.GC2398@piout.net>
References: <20160227153918.3c3d3853@wiggum>
 <20160228003139.GB2398@piout.net>
 <20160228094452.132c1938@wiggum>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160228094452.132c1938@wiggum>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 28/02/2016 at 09:44:52 +0100, Michael B=C3=BCsch wrote :
> On Sun, 28 Feb 2016 01:31:39 +0100
> Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
>=20
> > trickle charging is usually enabled using device tree, however, I'd
> > really like to see more standardization on the property names.
>=20
> Is there an example of an rtc driver implementing this?
> For the rv3029 it's more than just enabling it. It also has a bunch of
> charging resistors to choose from.
>=20

ds1339, ds1390 and bq32k are using trickle-resistor-ohms and
trickle-diode-disable.

> > I'm not sure yet about the temperature compensation. I've just merged
> > the crystal offset modification api with a sysfs interface in rtc-next:
> > http://git.kernel.org/cgit/linux/kernel/git/abelloni/linux.git/commit/?=
h=3Drtc-next&id=3D5f23807caab7801c3333c68417bb13c7e2439193
> >=20
> > But this doesn't seem enough for that particular RTC.
>=20
> The rv3029 does the compensation internally. It just needs to be
> enabled via a bit in its EEPROM. We could probably always set that bit
> though. I'm not sure whether there is a case where one would not want
> that.
>=20

If you want to enable it without changing the values, just enable it
unconditionally.


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
