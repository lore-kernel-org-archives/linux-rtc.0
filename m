Return-Path: <rtc-linux+bncBAABBTXL3SZAKGQEDC44KHI@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id 204si136854wmx.1.2015.11.26.08.39.42
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 26 Nov 2015 08:39:42 -0800 (PST)
Date: Thu, 26 Nov 2015 17:39:36 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Harald Geyer <harald@ccbib.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com, Wolfram Sang <wsa@the-dreams.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [rtc-linux] Re: [PATCH 2/2] watchdog: stmp3xxx: Implement GETBOOTSTATUS
Message-ID: <20151126163936.GO19888@pengutronix.de>
References: <1444220352-20548-1-git-send-email-harald@ccbib.org>
 <1444220352-20548-2-git-send-email-harald@ccbib.org>
 <20151126092526.GM19888@pengutronix.de>
 <E1a1wm1-0000XO-S7@stardust.g4.wien.funkfeuer.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <E1a1wm1-0000XO-S7@stardust.g4.wien.funkfeuer.at>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hello Harald,

On Thu, Nov 26, 2015 at 02:39:45PM +0100, Harald Geyer wrote:
> Uwe Kleine-K=C3=B6nig writes:
> > On Wed, Oct 07, 2015 at 12:19:12PM +0000, Harald Geyer wrote:
> > > This device doesn't provide any information about boot status.
> > > As workaround we use a persitent bit to track watchdog activity.
> >=20
> > Hmm, so you set a bit in a persistent register iff the watchdog is
> > running.  And if that bit is set during probe you assume the watchdog
> > reset the machine. But this also happens, when the user presses the
> > reset button which makes the detection unreliable.
>=20
> Yes, kind of. I'm using this driver on an imx233-olinuxino, where the
> reset button causes the device to power cycle and thus clears the
> persitent bit. So I can't test your case, but surely there are some paths

So the rtc isn't properly battery backed? AFAIUI the persistent bits
should survive a power cycle?! I think somewhere in our hardware
repository at Pengutronix we have a machine where I can test that, I
will check that.

> into reset, that don't clear the bit and cause false positives.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

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
