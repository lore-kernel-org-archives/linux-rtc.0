Return-Path: <rtc-linux+bncBAABBSPRZC5QKGQEH2DZALY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from arcturus.kleine-koenig.org (arcturus.kleine-koenig.org. [78.47.169.190])
        by gmr-mx.google.com with ESMTPS id r10si646649wmf.0.2016.06.28.01.43.53
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2016 01:43:53 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 3/4] rtc: sh: drop bogus assignment of tm_year in .read_alarm
Date: Tue, 28 Jun 2016 10:43:47 +0200
Message-Id: <1467103428-19047-3-git-send-email-uwe@kleine-koenig.org>
In-Reply-To: <1467103428-19047-1-git-send-email-uwe@kleine-koenig.org>
References: <1467103428-19047-1-git-send-email-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This rtc doesn't support triggering on years, so don't assign tm_year
instead of claiming the alarm is to trigger in year 67435.

Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
---
 drivers/rtc/rtc-sh.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index a45845a571e5..676949be777e 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -481,7 +481,6 @@ static int sh_rtc_read_alarm(struct device *dev, struct=
 rtc_wkalrm *wkalrm)
 	tm->tm_mon	=3D sh_rtc_read_alarm_value(rtc, RMONAR);
 	if (tm->tm_mon > 0)
 		tm->tm_mon -=3D 1; /* RTC is 1-12, tm_mon is 0-11 */
-	tm->tm_year     =3D 0xffff;
=20
 	wkalrm->enabled =3D (readb(rtc->regbase + RCR1) & RCR1_AIE) ? 1 : 0;
=20
--=20
2.8.1

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
