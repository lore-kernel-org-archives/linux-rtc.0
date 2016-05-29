Return-Path: <rtc-linux+bncBDS7HNEFSALRBUXVVW5AKGQEXG3JSUI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id r72si908921wmd.2.2016.05.29.16.27.14
        for <rtc-linux@googlegroups.com>;
        Sun, 29 May 2016 16:27:14 -0700 (PDT)
Date: Mon, 30 May 2016 01:27:13 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Michael Langer <michael.brainbug.langer@googlemail.com>,
	Byron Bradley <byron.bbradley@gmail.com>,
	Manuel =?iso-8859-1?Q?R=F6der?= <manuel_roeder@gmx.de>
Subject: [rtc-linux] Re: [PATCH RESEND 1/2] rtc: initialize output parameter
 for read alarm to "uninitialized"
Message-ID: <20160529232713.GO3451@piout.net>
References: <1462950684-3661-1-git-send-email-uwe@kleine-koenig.org>
 <1462950684-3661-2-git-send-email-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1462950684-3661-2-git-send-email-uwe@kleine-koenig.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 11/05/2016 at 09:11:23 +0200, Uwe Kleine-K=C3=B6nig wrote :
> rtc drivers are supposed to set values they don't support to -1. To
> simplify this for drivers and also make it harder for them to get it
> wrong initialize the values to -1.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
> ---
>  drivers/rtc/interface.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
Applied, thanks.

--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
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
