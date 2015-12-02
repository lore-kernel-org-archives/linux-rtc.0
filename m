Return-Path: <rtc-linux+bncBDS7HNEFSALRBC7B7OZAKGQE6WMQBXY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id b62si110098wmc.0.2015.12.02.05.22.18
        for <rtc-linux@googlegroups.com>;
        Wed, 02 Dec 2015 05:22:18 -0800 (PST)
Date: Wed, 2 Dec 2015 14:21:38 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	kernel@pengutronix.de, Kumar Gala <galak@codeaurora.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [rtc-linux] Re: [PATCH v2 2/2] rtc: add driver for RX6110SA real time clock
Message-ID: <20151202132138.GB22136@piout.net>
References: <1448977700-10924-1-git-send-email-s.trumtrar@pengutronix.de>
 <1448977700-10924-2-git-send-email-s.trumtrar@pengutronix.de>
 <20151201144218.GS22136@piout.net>
 <20151201194919.GG5072@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20151201194919.GG5072@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 01/12/2015 at 20:49:19 +0100, Uwe Kleine-K=C3=B6nig wrote :
> > Seeing the comment comment above, this should probably be if
> > (tm->tm_year < 100 || tm->tm_year >=3D 200)
> > I don't think this particular part has any issue
> > handling 2038. However, on 32bit platform, your userspace is probably
> > not ready to handle those date. hwclock should return the correct date.
>=20
> userspace is not ready because it cannot. Before this can be addressed,
> quite some things need fixing first. If I understood correctly timerfd
> for example is broken which completely locks up systemd.
>=20
> Note this doesn't justify to not write a date later than 2037 in the rtc
> driver however. Still thinking about how to handle this for the machines
> we work on, we thought about letting the RTC_RD_TIME ioctl fail for
> dates later than 2038 to work around this issue.
>=20

Yeah but the rtc doesn't have any issue handling dates after 2038 so if
it is used on a 64bit system, it can work properly until february 2100.

Also, I'm not sure how that solves your problem anyway.

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
