Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBMVV4HAQKGQEJF3BIRI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id l19si1347122wmg.0.2016.11.25.07.37.22
        for <rtc-linux@googlegroups.com>;
        Fri, 25 Nov 2016 07:37:22 -0800 (PST)
Date: Fri, 25 Nov 2016 16:37:11 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Vesa =?iso-8859-1?B?SuTkc2tlbORpbmVu?= <vesa.jaaskelainen@vaisala.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Lee Jones <lee.jones@linaro.org>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 1/2] drivers: rtc: rtc-tps65910: Add RTC
 calibration support
Message-ID: <20161125153711.ueervgro35xqy3ec@piout.net>
References: <1480067538-64415-1-git-send-email-vesa.jaaskelainen@vaisala.com>
 <1480067538-64415-2-git-send-email-vesa.jaaskelainen@vaisala.com>
 <20161125103254.7p7p4frk2cudwfwt@piout.net>
 <05f0a84b-00a1-5fe4-2f92-a58b0a87422c@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <05f0a84b-00a1-5fe4-2f92-a58b0a87422c@vaisala.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 25/11/2016 at 13:20:05 +0200, Vesa J=C3=A4=C3=A4skel=C3=A4inen wrote :
> On 2016-11-25 12:32, Alexandre Belloni wrote:
> > Hi,
> >=20
> > On 25/11/2016 at 11:52:17 +0200, Vesa J=C3=A4=C3=A4skel=C3=A4inen wrote=
 :
> > > Texas Instrument's TPS65910 has support for compensating RTC crystal
> > > inaccuracies. When enabled every hour RTC counter value will be compe=
nsated
> > > with two's complement value.
> > >=20
> > > Signed-off-by: Vesa J=C3=A4=C3=A4skel=C3=A4inen <vesa.jaaskelainen@va=
isala.com>
> > There is already a sysfs attribute for that kind of calibration
> > (offset, documented in Documentation/rtc.txt). Can you use that instead=
?
>=20
> That documentation in rtc.txt states that compensation is per billion tic=
ks.
> This compensation happens every 32768*60*60  =3D=3D 117964800 ticks.
>=20
> I modeled this after similar functionality of rtc-ab8500.c which provided
> similar sysfs file. But its time compensation happens also with different
> interval.
>=20
> Due to differences here in functionalities between different chips I deci=
ded
> to go with driver specific compensation value.
>=20

The functionality is exactly the same, but if I understand correctly,
your resolution is 8.477 ppb is that right ?

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
