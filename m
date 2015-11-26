Return-Path: <rtc-linux+bncBAABBFNL32ZAKGQEFKYFYTQ@googlegroups.com>
Received: from mail.cosmopool.net (h1.radempa.de. [176.9.142.194])
        by gmr-mx.google.com with ESMTP id k189si175561wmg.2.2015.11.26.15.28.21
        for <rtc-linux@googlegroups.com>;
        Thu, 26 Nov 2015 15:28:21 -0800 (PST)
From: Harald Geyer <harald@ccbib.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
cc: Alessandro Zummo <a.zummo@towertech.it>,
    linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com,
    Wolfram Sang <wsa@the-dreams.de>, Wim Van Sebroeck <wim@iguana.be>,
    Alexandre Belloni <alexandre.belloni@free-electrons.com>,
    kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
    Guenter Roeck <linux@roeck-us.net>
Subject: [rtc-linux] Re: [PATCH 2/2] watchdog: stmp3xxx: Implement GETBOOTSTATUS
In-reply-to: <20151126163936.GO19888@pengutronix.de>
References: <1444220352-20548-1-git-send-email-harald@ccbib.org> <1444220352-20548-2-git-send-email-harald@ccbib.org> <20151126092526.GM19888@pengutronix.de> <E1a1wm1-0000XO-S7@stardust.g4.wien.funkfeuer.at> <20151126163936.GO19888@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2015 00:28:13 +0100
Message-Id: <E1a25xV-0000OQ-J9@stardust.g4.wien.funkfeuer.at>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Uwe,

Uwe Kleine-K=C3=B6nig writes:
> On Thu, Nov 26, 2015 at 02:39:45PM +0100, Harald Geyer wrote:
> > Uwe Kleine-K=C3=B6nig writes:
> > > Hmm, so you set a bit in a persistent register iff the watchdog is
> > > running.  And if that bit is set during probe you assume the watchdog
> > > reset the machine. But this also happens, when the user presses the
> > > reset button which makes the detection unreliable.
> >=20
> > Yes, kind of. I'm using this driver on an imx233-olinuxino, where the
> > reset button causes the device to power cycle and thus clears the
> > persitent bit. So I can't test your case, but surely there are some pat=
hs
>=20
> So the rtc isn't properly battery backed?

Yes, since the mainline kernel can't do anything useful with the battery
other than reporting it's voltage, nobody uses imx233-olinuxino with
mainline kernel and battery.

> AFAIUI the persistent bits should survive a power cycle?!

I only tested without battery, and in my case they definitely don't.

> I think somewhere in our hardware
> repository at Pengutronix we have a machine where I can test that, I
> will check that.

Thanks!

Best regards,
Harald

> > into reset, that don't clear the bit and cause false positives.
>=20
> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|

--=20
If you want to support my work:
see http://friends.ccbib.org/harald/supporting/
or donate via bitcoin to 1FUtd8T9jRN1rFz63vZz7s2fDtB6d6A7aS

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
