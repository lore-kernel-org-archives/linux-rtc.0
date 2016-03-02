Return-Path: <rtc-linux+bncBDS7HNEFSALRB6FL3O3AKGQEY4RSZHA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w10si127443wmw.3.2016.03.02.04.00.56
        for <rtc-linux@googlegroups.com>;
        Wed, 02 Mar 2016 04:00:56 -0800 (PST)
Date: Wed, 2 Mar 2016 13:00:45 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc-rv3029c2: Add trickle charger
Message-ID: <20160302120045.GO23985@piout.net>
References: <20160301213322.661fe771@wiggum>
 <20160301213655.GG23985@piout.net>
 <20160301225401.3f0aeabb@wiggum>
 <20160301230745.GJ23985@piout.net>
 <20160302072627.14e53e94@wiggum>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160302072627.14e53e94@wiggum>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 02/03/2016 at 07:26:27 +0100, Michael B=C3=BCsch wrote :
> On Wed, 2 Mar 2016 00:07:45 +0100
> Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
>=20
> > > > I wouldn't reset the VLOW1 and VLOW2 flags here. Just bail out if t=
he
> > > > voltage is not sufficient. I don't think that condition will actual=
ly
> > > > get better simply by waiting. =20
> > >=20
> > >=20
> > > I do actually think so that we should clear them at least once (that =
is
> > > retry once). According to the data sheet these bits will not reset
> > > automatically and might be left over from machine start (brown out).
> > >  =20
> >=20
> > No, this should be handled differently. I have some pending patches to
> > handle those bits. The main issue is that if you reset those bits there=
,
> > there is now way to know whether the date has been set or is invalid.
> >=20
> > I think the best way to handle this case is to call the function again
> > when the date/time are set and we have to reset VLOW1/2.
>=20
> Yes, right. But as of now we do not have VLOW handling. So I don't see
> an issue with clearing the bits here.
> The clearing can be removed, if VLOW handling is added eventually.
>=20
> The issue currently is: We need to check VLOW before accessing the
> eeprom, because otherwise it would mean data corruption. This is
> especially true for writing. And if we read VLOW, we need a way to
> reset the bits from the probable initial brown out. Otherwise we can
> never access the eeprom as this check would hit often.
>=20

Ok, that is fine.

> So when are your VLOW patches going to be available?
>=20

I'll probably rebase on top of your changes.

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
