Return-Path: <rtc-linux+bncBDS7HNEFSALRBUNP4KXQKGQEW424MGQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id bn1si52665wib.0.2015.09.15.15.12.32
        for <rtc-linux@googlegroups.com>;
        Tue, 15 Sep 2015 15:12:32 -0700 (PDT)
Date: Wed, 16 Sep 2015 00:12:32 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	kernel@pengutronix.de
Subject: [rtc-linux] Re: [PATCH] rtc: pcf2127: make module license match the
 file header
Message-ID: <20150915221232.GE4287@piout.net>
References: <1441790950-9463-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1441790950-9463-1-git-send-email-u.kleine-koenig@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 09/09/2015 at 11:29:10 +0200, Uwe Kleine-K=C3=B6nig wrote :
> The header of the pcf2127 driver specifies GPL v2 only as license, so
> use "GPL v2" as module license specifier instead of "GPL" as the latter
> means "GNU Public License v2 or later".
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/rtc/rtc-pcf2127.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Applied, thanks.

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
