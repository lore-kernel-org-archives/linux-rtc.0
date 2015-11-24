Return-Path: <rtc-linux+bncBDS7HNEFSALRBNXI2OZAKGQEI24B5VA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id g21si29796wmd.3.2015.11.24.15.35.18
        for <rtc-linux@googlegroups.com>;
        Tue, 24 Nov 2015 15:35:18 -0800 (PST)
Date: Wed, 25 Nov 2015 00:35:17 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	kernel@pengutronix.de
Subject: [rtc-linux] Re: [PATCH] rtc: pcf8523: refuse to write dates later
 than 2099
Message-ID: <20151124233517.GI3950@piout.net>
References: <1446827876-31613-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1446827876-31613-1-git-send-email-u.kleine-koenig@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 06/11/2015 at 17:37:56 +0100, Uwe Kleine-K=C3=B6nig wrote :
> When the chip increments the YEAR register and it already holds
> bin2bcd(99) it reads as 0 afterwards. With this behaviour the last valid
> day (without trickery) that has a representation is 2099-12-31 23:59:59.
> So refuse to write later dates.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> When setting the YEAR register to bin2bcd(100) =3D=3D 0xa0 it increments
> just fine up to bin2bcd(159) =3D=3D 0xf9 but these values are forbidden i=
n
> the manual. But this doesn't help to expand (or shift) the range of
> supported dates.
>=20
> An alternative to this patch would be to save tm_year % 100 because
> that's what happens when waiting long enough anyhow. Would that be
> better? Do we already care at all for year-2100-problems?
>=20

There is no way to tell whether the date is fine after February
2100 so I will take the patch as is.

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
