Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBCVGXG6AKGQEFJH5FVQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id r74si1059870wme.3.2016.07.19.09.19.22
        for <rtc-linux@googlegroups.com>;
        Tue, 19 Jul 2016 09:19:22 -0700 (PDT)
Date: Tue, 19 Jul 2016 18:19:21 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: Ben Hutchings <benh@debian.org>, rtc-linux@googlegroups.com,
	kernel@pengutronix.de, Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] Re: [PATCH 0/2] rtc: fix regressions of d68778b80dd7
Message-ID: <20160719161921.GM7132@piout.net>
References: <1468224328-7391-1-git-send-email-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1468224328-7391-1-git-send-email-uwe@kleine-koenig.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 11/07/2016 at 10:05:26 +0200, Uwe Kleine-K=C3=B6nig wrote :
> Hello,
>=20
> while applying d68778b80dd7 ("rtc: initialize output parameter for read
> alarm to "uninitialized"") to the Debian kernel Ben Hutchings wondered
> if there are drivers that rely on .tm_sec being initialized to 0.
>=20
> I checked this now an found a few that do.
>=20
> The hym8563 already used -1 explicitly, it is fixed in a separate patch.
>=20
> Uwe Kleine-K=C3=B6nig (2):
>   rtc: explicitly set tm_sec =3D 0 for drivers with minute accurancy
>   rtc: hym8563: in .read_alarm set .tm_sec to 0 to signal minute
>     accuracy
>=20

Applied, thanks.

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
