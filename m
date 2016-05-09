Return-Path: <uwe@kleine-koenig.org>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	Michael Langer <michael.brainbug.langer@googlemail.com>,
	Byron Bradley <byron.bbradley@gmail.com>,
	Tim Ellis <tim@ngndg.com>
Subject: [PATCH 0/2] rtc: initial patches to fix borkage of rtc-s35390a
Date: Mon,  9 May 2016 23:37:32 +0200
Message-Id: <1462829854-789-1-git-send-email-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>

Hello,

here are two patches that improve the rtc core's robustness regarding
stuff the rtc-s35390a does. That is in .read_alarm it only assigns
alm->time.tm_wday, alm->time.tm_hour and alm->time.tm_min which as of
now makes the kernel report things like:

	[    2.257418] rtc rtc0: invalid alarm value: 1900-1-29 1193031:57:16

.

The open issues (I'm aware of) but which are orthogonal to the patches
here are:

 - The core doesn't handle a driver setting alm->time.tm_wday but not
   alm->time.tm_mday.
 - The chip has status bits that signal if an irq is pending, but these
   are cleared at read and the first read during driver probe doesn't
   check for these bits set. (There are more such read-to-clear bits,
   e.g. when the battery backing was lost ...)
   The result is that the irq isn't acked (by unsetting INT2AE) which
   prevents some devices (e.g. QNAP TS-41x) to shutdown.
   (https://bugs.debian.org/794266)

So with the two patches in this series the QNAP TS-41x still fails to
shutdown, but it is handled a bit better. 

I'd consider this merge window material.

Uwe Kleine-König (2):
  rtc: initialize output parameter for read alarm to "uninitialized"
  rtc: make rtc_time64_to_tm save to use for dates before 1970

 drivers/rtc/interface.c | 12 +++++++++++-
 drivers/rtc/rtc-lib.c   | 13 +++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.8.1
