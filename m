Return-Path: <rtc-linux+bncBAABBI5O4SXQKGQELCJDQZY@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id bn1si102340wib.0.2015.09.16.00.15.46
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 16 Sep 2015 00:15:46 -0700 (PDT)
Date: Wed, 16 Sep 2015 09:15:45 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] rtctest woes
Message-ID: <20150916071545.GA28635@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hello,

I'm running rtctest (i.e. tools/testing/selftests/timers/rtctest.c)
against a pcf2127 i2c rtc. The driver doesn't have alarm support.

The first problem is that calling ioctl(fd, RTC_UIE_ON, 0) returns -1
and sets errno to EINVAL but rtctest expects ENOTTY if update irqs are
not supported. (I'll send a patch in reply to this mail.)

Then with this issue fixed the next failure is at ioctl(fd,
RTC_ALM_READ, &rtc_tm) after ioctl(fd, RTC_ALM_SET, &rtc_tm) succeeded.
If I understand the code correctly the RTC_ALM_SET is emulated using
kernel timers but ALM_GET is not. I'd say the right fix here is that
RTC_ALM_SET should already fail in this case, but as I'm not sure I
didn't create a patch.

BTW, asking scripts/get_maintainer.pl where to send a patch touching
rtctest the reply includes the timekeeping and selftest maintainer
entrys but not the rtc one. I suggest to move rtctest to
tools/testing/selftests/rtc/rtctest.c.

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
