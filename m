Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBOPS725QKGQEPWWMSEY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q124si122567wme.3.2016.07.08.07.31.21
        for <rtc-linux@googlegroups.com>;
        Fri, 08 Jul 2016 07:31:21 -0700 (PDT)
Date: Fri, 8 Jul 2016 16:31:20 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 1/4] rtc: simplify implementations of read_alarm
Message-ID: <20160708143120.GK22202@piout.net>
References: <1467103428-19047-1-git-send-email-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1467103428-19047-1-git-send-email-uwe@kleine-koenig.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 28/06/2016 at 10:43:45 +0200, Uwe Kleine-K=C3=B6nig wrote :
> Since commit d68778b80dd7 ("rtc: initialize output parameter for read
> alarm to "uninitialized"") there is no need to explicitly set
> unsupported members to -1. So drop the respective assignments from
> drivers.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
> ---
>  drivers/rtc/rtc-cmos.c    |  3 ---
>  drivers/rtc/rtc-ds1305.c  |  7 -------
>  drivers/rtc/rtc-ds1307.c  |  5 -----
>  drivers/rtc/rtc-ds1343.c  |  6 ------
>  drivers/rtc/rtc-ds1685.c  | 19 ++++---------------
>  drivers/rtc/rtc-ds3232.c  |  6 ------
>  drivers/rtc/rtc-hym8563.c |  3 ---
>  drivers/rtc/rtc-m41t80.c  |  2 --
>  drivers/rtc/rtc-mrst.c    |  8 --------
>  drivers/rtc/rtc-pcf8563.c |  4 ----
>  drivers/rtc/rtc-rs5c372.c |  6 ------
>  drivers/rtc/rtc-rv8803.c  |  3 ---
>  drivers/rtc/rtc-rx8010.c  |  8 +-------
>  drivers/rtc/rtc-rx8025.c  |  5 -----
>  drivers/rtc/rtc-s3c.c     | 12 ------------
>  drivers/rtc/rtc-tegra.c   |  6 ------
>  16 files changed, 5 insertions(+), 98 deletions(-)
>=20
All applied, thanks.

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
