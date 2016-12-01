Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB7GV7XAQKGQEF6WGK7Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id s81si1010037wmf.3.2016.11.30.16.12.43
        for <rtc-linux@googlegroups.com>;
        Wed, 30 Nov 2016 16:12:43 -0800 (PST)
Date: Thu, 1 Dec 2016 01:12:43 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Vesa =?iso-8859-1?B?SuTkc2tlbORpbmVu?= <vesa.jaaskelainen@vaisala.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Lee Jones <lee.jones@linaro.org>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 1/2] drivers: rtc: rtc-tps65910: Add RTC
 calibration support
Message-ID: <20161201001243.aoxliubzg4sz7hsr@piout.net>
References: <1480067538-64415-1-git-send-email-vesa.jaaskelainen@vaisala.com>
 <1480067538-64415-2-git-send-email-vesa.jaaskelainen@vaisala.com>
 <20161125103254.7p7p4frk2cudwfwt@piout.net>
 <05f0a84b-00a1-5fe4-2f92-a58b0a87422c@vaisala.com>
 <20161125153711.ueervgro35xqy3ec@piout.net>
 <92675f10-b2ee-d8a0-c832-09b45d006881@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <92675f10-b2ee-d8a0-c832-09b45d006881@vaisala.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 28/11/2016 at 16:42:05 +0200, Vesa J=C3=A4=C3=A4skel=C3=A4inen wrote :
> On 2016-11-25 17:37, Alexandre Belloni wrote:
> > On 25/11/2016 at 13:20:05 +0200, Vesa J=C3=A4=C3=A4skel=C3=A4inen wrote=
 :
> > > On 2016-11-25 12:32, Alexandre Belloni wrote:
> > > > Hi,
> > > >=20
> > > > On 25/11/2016 at 11:52:17 +0200, Vesa J=C3=A4=C3=A4skel=C3=A4inen w=
rote :
> > > > > Texas Instrument's TPS65910 has support for compensating RTC crys=
tal
> > > > > inaccuracies. When enabled every hour RTC counter value will be c=
ompensated
> > > > > with two's complement value.
> > > > >=20
> > > > > Signed-off-by: Vesa J=C3=A4=C3=A4skel=C3=A4inen <vesa.jaaskelaine=
n@vaisala.com>
> > > > There is already a sysfs attribute for that kind of calibration
> > > > (offset, documented in Documentation/rtc.txt). Can you use that ins=
tead?
> > > That documentation in rtc.txt states that compensation is per billion=
 ticks.
> > > This compensation happens every 32768*60*60  =3D=3D 117964800 ticks.
> > >=20
> > > I modeled this after similar functionality of rtc-ab8500.c which prov=
ided
> > > similar sysfs file. But its time compensation happens also with diffe=
rent
> > > interval.
> > >=20
> > > Due to differences here in functionalities between different chips I =
decided
> > > to go with driver specific compensation value.
> > >=20
> > The functionality is exactly the same, but if I understand correctly,
> > your resolution is 8.477 ppb is that right ?
>=20
> I suppose so. Compensation resolution is the differenting factor here and
> also at what point of time compensation is happening.
>=20
> If I would convert this to 1ppb then there would be theoretical accuracy
> lost, not much but in year it sums up :).
>=20

Well, the best your RTC can do is 8.477 ppb so and the maximum drift
you'd get over a year because of this resolution is 133.5ms.
The precision loss by rounding to the closest ppb is 16ms over a year,
way below what you can achieve.

Also, remember that when setting the time, you are doing it at a one
second resolution and you may as well be at the 999th millisecond of
that second before even transferring any data to your RTC.

The unit (ppb) is fine and the magic of it is that you don't actually
care about when the correction happens as long as it happens regularly.

> btw. is there existing RTC compensation daemon that would support also
> temperature based calibration and would internally handle updating 'offse=
t'
> or custom calibration fields?
>=20

Nothing that I'm aware of

> If I spotted correctly this 'offset' property is only supported by
> rtc-pcf2123.c. That driver seems to use some kind of dynamic scaling for
> compensation.
>=20

It is the only one using it at the moment. This RTC has two ways of
specifying the compensation: fine (every 2 hours) or coarse (every
hour). This is handled automatically in the driver.

> Keeping data in chips native format would enable best possible accuracy a=
nd
> no-one could complain that it is not functioning in best possible way.
>

My point is that you don't lose any accuracy by using ppb and
converting in the driver anyway.
Using the native format will prevent anyone from writing a generic
userspace application handling that compensation.

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
