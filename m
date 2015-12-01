Return-Path: <rtc-linux+bncBAABBRPT66ZAKGQEEJ5TFGA@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id g21si1135073wmd.3.2015.12.01.11.49.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 01 Dec 2015 11:49:25 -0800 (PST)
Date: Tue, 1 Dec 2015 20:49:19 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	kernel@pengutronix.de, Kumar Gala <galak@codeaurora.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [rtc-linux] Re: [PATCH v2 2/2] rtc: add driver for RX6110SA real time clock
Message-ID: <20151201194919.GG5072@pengutronix.de>
References: <1448977700-10924-1-git-send-email-s.trumtrar@pengutronix.de>
 <1448977700-10924-2-git-send-email-s.trumtrar@pengutronix.de>
 <20151201144218.GS22136@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20151201144218.GS22136@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hello Alexandre,

Cc +=3D Arnd

On Tue, Dec 01, 2015 at 03:42:18PM +0100, Alexandre Belloni wrote:
> > +/**
> > + * rx6110_set_time - set the current time in the rx6110 registers
> > + *
> > + * @dev: the rtc device in use
> > + * @tm: holds date and time
> > + *
> > + * BUG: The HW assumes every year that is a multiple of 4 to be a leap
> > + * year. Next time this is wrong is 2100, which will not be a leap yea=
r
> > + *
> > + * Note: If STOP is not set/cleared, the clock will start when the sec=
onds
> > + *       register is written
> > + *
> > + */
> > +static int rx6110_set_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +	struct rx6110_data *rx6110 =3D dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	if (tm->tm_year > 137)
> > +		return -EINVAL;
> > +
>=20
> Seeing the comment comment above, this should probably be if
> (tm->tm_year < 100 || tm->tm_year >=3D 200)
> I don't think this particular part has any issue
> handling 2038. However, on 32bit platform, your userspace is probably
> not ready to handle those date. hwclock should return the correct date.

userspace is not ready because it cannot. Before this can be addressed,
quite some things need fixing first. If I understood correctly timerfd
for example is broken which completely locks up systemd.

Note this doesn't justify to not write a date later than 2037 in the rtc
driver however. Still thinking about how to handle this for the machines
we work on, we thought about letting the RTC_RD_TIME ioctl fail for
dates later than 2038 to work around this issue.

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
