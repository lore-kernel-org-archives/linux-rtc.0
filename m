Return-Path: <rtc-linux+bncBAABBAHI4CZAKGQETZLMVUA@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id g21si256057wmd.3.2015.11.27.02.44.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 27 Nov 2015 02:44:16 -0800 (PST)
Date: Fri, 27 Nov 2015 11:44:02 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Harald Geyer <harald@ccbib.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com, Wolfram Sang <wsa@the-dreams.de>,
	kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>
Subject: [rtc-linux] Re: [PATCH 2/2] watchdog: stmp3xxx: Implement GETBOOTSTATUS
Message-ID: <20151127104402.GT19888@pengutronix.de>
References: <1444220352-20548-1-git-send-email-harald@ccbib.org>
 <1444220352-20548-2-git-send-email-harald@ccbib.org>
 <20151126092526.GM19888@pengutronix.de>
 <E1a1wm1-0000XO-S7@stardust.g4.wien.funkfeuer.at>
 <20151127100254.GR19888@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20151127100254.GR19888@pengutronix.de>
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

On Fri, Nov 27, 2015 at 11:02:54AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Nov 26, 2015 at 02:39:45PM +0100, Harald Geyer wrote:
> > Uwe Kleine-K=C3=B6nig writes:
> > > On Wed, Oct 07, 2015 at 12:19:12PM +0000, Harald Geyer wrote:
> > > > This device doesn't provide any information about boot status.
> > > > As workaround we use a persitent bit to track watchdog activity.
> > >=20
> > > Hmm, so you set a bit in a persistent register iff the watchdog is
> > > running.  And if that bit is set during probe you assume the watchdog
> > > reset the machine. But this also happens, when the user presses the
> > > reset button which makes the detection unreliable.
> >=20
> > Yes, kind of. I'm using this driver on an imx233-olinuxino, where the
> > reset button causes the device to power cycle and thus clears the
> > persitent bit. So I can't test your case, but surely there are some pat=
hs
> > into reset, that don't clear the bit and cause false positives.
>=20
> OK, I found a i.MX28 machine in our repository:
>=20
> 	barebox# mw 0x80056080 0xbabecafe
> 	barebox# boot
> 	...
> 	linux# reboot
> 	barebox# md 0x80056080+4
> 	80056080: babecafe
>=20
> After a power cycle the value disappears (I didn't check the details, if
> there is a battery it might be empty).
>=20
> > I have considered gathering some additional information from the
> > power subsystem to refine the result, but decided that it's not
> > worth the complexity. Since the power system is a different silicon
> > block, we can't rely on it being available and would need to provide
> > a fall back implementation anyway.
>=20
> It would be really nice to get some details about boot rom usage of the
> persistent flags in use. I'd expect that these allow to determine the
> boot source.

A colleague just hinted me to

	http://git.pengutronix.de/?p=3Dbarebox.git;a=3Dblob;f=3Ddrivers/watchdog/i=
m28wd.c;h=3D3510776a3afc8aaf113eee995900b099c12c2be9;hb=3DHEAD

which contains a few bit definitions for the i.MX28. Maybe they can help
you to understand your machine better?! At a quick glance there is
nothing that helps you to determine the boot reason, but still it might
contain a few interesting things.

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
