Return-Path: <rtc-linux+bncBDS7HNEFSALRB7V62W4AKGQEG3DJDXI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id k143si34278wmg.1.2016.04.18.15.28.14
        for <rtc-linux@googlegroups.com>;
        Mon, 18 Apr 2016 15:28:14 -0700 (PDT)
Date: Tue, 19 Apr 2016 00:28:03 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Boullis <nboullis@debian.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: ds1307: ensure that any pending alarm is
 cleared before a new alarm is enabled
Message-ID: <20160418222803.GA25196@piout.net>
References: <20160402221047.GB3600@haddock.home>
 <20160410112305.GB3603@haddock.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160410112305.GB3603@haddock.home>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 10/04/2016 at 13:23:05 +0200, Nicolas Boullis wrote :
> If a previously-set alarm was disabled and then triggered, it may still=
=20
> be pending when a new alarm is configured.
>=20
> Then, if the alarm is enabled before the pending alarm is cleared, then=
=20
> an interrupt is immediately raised.
>=20
> Unfortunately, when the alarm is cleared and enabled during the same I=E6=
=B6=8E=20
> block write, the chip (at least the DS1339 I have) considers that the=20
> alarm is enabled before it is cleared, and raises an interrupt.
>=20
> This patch ensures that the pending alarm is cleared before the alarm is=
=20
> enabled.
>=20
> Signed-off-by: Nicolas Boullis <nboullis@debian.org>
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
