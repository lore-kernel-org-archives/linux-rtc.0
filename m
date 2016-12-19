Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBH6Y3TBAKGQE2JKYUQY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id h23si920596wmi.1.2016.12.18.16.38.55
        for <rtc-linux@googlegroups.com>;
        Sun, 18 Dec 2016 16:38:55 -0800 (PST)
Date: Mon, 19 Dec 2016 01:38:54 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Vesa =?iso-8859-1?B?SuTkc2tlbORpbmVu?= <vesa.jaaskelainen@vaisala.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Lee Jones <lee.jones@linaro.org>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2 0/2] drivers: rtc: rtc-tps65910: Add RTC
 calibration support
Message-ID: <20161219003854.e6hbobkwa3kanbjp@piout.net>
References: <1481406644-1614-1-git-send-email-vesa.jaaskelainen@vaisala.com>
 <a22c9180-61bf-e307-9ba1-e24e1453459b@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <a22c9180-61bf-e307-9ba1-e24e1453459b@vaisala.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 11/12/2016 at 00:21:02 +0200, Vesa J=C3=A4=C3=A4skel=C3=A4inen wrote :
>=20
> On 2016-12-10 23:50, Vesa J=C3=A4=C3=A4skel=C3=A4inen wrote:
> > Texas Instrument's TPS65910 has support for compensating RTC crystal
> > inaccuracies. When enabled every hour RTC counter value will be compens=
ated
> > with two's complement value.
> >=20
> > Vesa J=C3=A4=C3=A4skel=C3=A4inen (2):
> >    drivers: rtc: rtc-tps65910: Add RTC calibration support
> >    drivers: rtc: rtc-tps65910: use 'unsigned int' instead of 'unsigned'
> >      in arguments
> >=20
> >   drivers/rtc/rtc-tps65910.c   | 135 ++++++++++++++++++++++++++++++++++=
++++++++-
> >   include/linux/mfd/tps65910.h |   1 +
> >   2 files changed, 135 insertions(+), 1 deletion(-)
> >=20
> This version now uses 'offset' sysfs file for calibration purposes.
>=20
> It supports rounding so if one calculates absolute 'offset' compensation
> value then it should give "optimal" calibration.
>=20
> I believe one should calculate compensation value like:
>=20
> offset =3D ((measured_freq/32768)-1)*10^9
>=20
> So if meaured_freq =3D=3D 32771.2768, then matching offset =3D=3D 100000.
> Or if mesured_freq =3D=3D 32764.7232, then matching offset =3D=3D -100000=
.
>=20
> 'offset' compensation value is following existing rtc.txt definition mean=
ing
> positive values causes time to slowdown and negative values to fasten up.
> Which I believe should be other way around to be more logical. This is ea=
sy
> to swap if I just understood it wrongly.
>=20

The hardware vendors are using positive offsets to slow the RTC and
negative offsets to hasten it so that's what we exposed to userspace as
it avoids a conversion.

> 'offset' value calculation assumes "common" understanding how ppm values =
are
> used, eg. it is negated compensation value (expect now positive).
>=20
> Eg. if RTC crystal is off by +100ppm then 'offset' value must be 100ppm
> (write 100000 to 'offset').
>=20
> I believe offset documentation in rtc.txt should be clarified on what val=
ue
> means.
>=20
> 'offset' value has limits due to RTC chip itself, if out-of-limits value =
is
> given -ERANGE is returned.
>=20

That's fine.

> Due to RTC chip's implementation -- it loses RTC compensation enable bit =
on
> reset, so compensation value must be written on every boot at least once =
to
> be active.
>=20
> When compensation is not enabled "cat offset" returns value. There is
> currently no way to know from users space (without i2cget -f) whether
> compensation is enabled or not. If this should not be the case it can be
> easily fixed, -EINVAL might do the trick.
>=20

If compensation is not enabled, simply return 0 so userspace actually
has a way to know it is not currently in effect. Anyway, you'll have to
write a value to enable it again.
You are probably already able to calculate that value anyway so I'm not
sure of the benefit of using the RTC to remember it across resets.


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
