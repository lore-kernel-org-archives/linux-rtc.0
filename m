Return-Path: <rtc-linux+bncBAABBYWI5OZAKGQEUMNNI5Y@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id y203si391274wmc.2.2015.11.29.03.41.22
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 29 Nov 2015 03:41:22 -0800 (PST)
Date: Sun, 29 Nov 2015 12:41:11 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Harald Geyer <harald@ccbib.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com, Wolfram Sang <wsa@the-dreams.de>,
	kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>
Subject: [rtc-linux] Re: [PATCH 2/2] watchdog: stmp3xxx: Implement GETBOOTSTATUS
Message-ID: <20151129114111.GB10431@pengutronix.de>
References: <1444220352-20548-1-git-send-email-harald@ccbib.org>
 <1444220352-20548-2-git-send-email-harald@ccbib.org>
 <20151126092526.GM19888@pengutronix.de>
 <E1a1wm1-0000XO-S7@stardust.g4.wien.funkfeuer.at>
 <20151127100254.GR19888@pengutronix.de>
 <20151127104402.GT19888@pengutronix.de>
 <b09608aa29195b41fc114a414d67af0f@ccbib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <b09608aa29195b41fc114a414d67af0f@ccbib.org>
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

On Sun, Nov 29, 2015 at 11:41:22AM +0100, Harald Geyer wrote:
> On 27.11.2015 11:44, Uwe Kleine-K=C3=B6nig wrote:
> >Hello Harald,
> >
> >On Fri, Nov 27, 2015 at 11:02:54AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> >>On Thu, Nov 26, 2015 at 02:39:45PM +0100, Harald Geyer wrote:
> >>> Uwe Kleine-K=C3=B6nig writes:
> >>> > On Wed, Oct 07, 2015 at 12:19:12PM +0000, Harald Geyer wrote:
> >>> > > This device doesn't provide any information about boot status.
> >>> > > As workaround we use a persitent bit to track watchdog activity.
> >>> >
> >>> > Hmm, so you set a bit in a persistent register iff the watchdog is
> >>> > running.  And if that bit is set during probe you assume the
> >>watchdog
> >>> > reset the machine. But this also happens, when the user presses the
> >>> > reset button which makes the detection unreliable.
> >>>
> >>> Yes, kind of. I'm using this driver on an imx233-olinuxino, where the
> >>> reset button causes the device to power cycle and thus clears the
> >>> persitent bit. So I can't test your case, but surely there are some
> >>paths
> >>> into reset, that don't clear the bit and cause false positives.
> >>
> >>OK, I found a i.MX28 machine in our repository:
> >>
> >>	barebox# mw 0x80056080 0xbabecafe
> >>	barebox# boot
> >>	...
> >>	linux# reboot
> >>	barebox# md 0x80056080+4
> >>	80056080: babecafe
> >>
> >>After a power cycle the value disappears (I didn't check the details, i=
f
> >>there is a battery it might be empty).
>=20
> Are there any concerns left on your side? Ie do you want me to do
> any additional tests before sending v4 of this patch with the
> whitespace changes and added URL to the freescale kernel?

I just notice that I failed to do the proper test. I.e. I reset the
machine using "reboot" instead of a reset button. But I'd expect that
doing the latter also keeps the value of the persistant register, which
would make your patch wrong here. I will check that tomorrow when I can
make someone do this test for me. (I'm 600 km from the machine above
away.)
=20
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
