Return-Path: <rtc-linux+bncBDS7HNEFSALRB5GIROYQKGQEKDQ5UUI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id h2si294243wiy.0.2015.10.17.17.14.44
        for <rtc-linux@googlegroups.com>;
        Sat, 17 Oct 2015 17:14:44 -0700 (PDT)
Date: Sun, 18 Oct 2015 02:14:44 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	kernel@pengutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v1 2/4] rtc: pcf2127: remove useless driver version
Message-ID: <20151018001444.GW3421@piout.net>
References: <1443777442-15920-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1443777442-15920-3-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1443777442-15920-3-git-send-email-u.kleine-koenig@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 02/10/2015 at 11:17:20 +0200, Uwe Kleine-K=C3=B6nig wrote :
> A driver version is only really sensible for oot drivers. Also the
> dev_info about having found a chip only signals that allocating the
> driver data succeeded and so isn't worth much.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/rtc/rtc-pcf2127.c | 5 -----
>  1 file changed, 5 deletions(-)
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
