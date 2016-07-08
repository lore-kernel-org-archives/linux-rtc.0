Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBOHX725QKGQEDOY76RQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id o85si75971wme.0.2016.07.08.07.41.59
        for <rtc-linux@googlegroups.com>;
        Fri, 08 Jul 2016 07:41:59 -0700 (PDT)
Date: Fri, 8 Jul 2016 16:41:58 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Manuel =?iso-8859-1?Q?R=F6der?= <manuel_roeder@gmx.de>
Subject: [rtc-linux] Re: [PATCH v2 0/5] rtc: s35390a: allow shutdown of NAS
 after alarm triggered
Message-ID: <20160708144158.GL22202@piout.net>
References: <1467473292-26371-1-git-send-email-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1467473292-26371-1-git-send-email-uwe@kleine-koenig.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 02/07/2016 at 17:28:07 +0200, Uwe Kleine-K=C3=B6nig wrote :
> Hello,
>=20
> this is v2 of the series fixing https://bugs.debian.org/794266.
>=20
> The only change compared to (implicit) v1 is that reading out a disabled
> alarm is fixed. When the alarm is disabled the respective register is
> shadowed with the result is that the reported alarm time is 45:85:0
> because both hour and minute byte are read as 0xff and bcd2bin(0x3f) and
> bcd2bin(0x7f) are 45 and 85 respectively.
>=20
> The new behaviour is to only set .enabled =3D 0 and return. Not 100% sure
> this is the right thing, though. The only alternative is to enable alarm
> and read out a time, but that might have the side effect to trigger an
> unwanted alarm, so I didn't chose this way.
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=C3=B6nig (5):
>   rtc: s35390a: fix reading out alarm
>   rtc: s35390a: implement reset routine as suggested by the reference
>   rtc: s35390a: improve irq handling
>   rtc: s35390a: improve two comments in .set_alarm
>   rtc: fix a typo and reduce three empty lines to one
>=20
>  drivers/rtc/interface.c   |   4 +-
>  drivers/rtc/rtc-s35390a.c | 157 +++++++++++++++++++++++++++++++++++-----=
------
>  2 files changed, 120 insertions(+), 41 deletions(-)
>=20

All applied, thanks!


I added a quick commit message in 4/5.

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
