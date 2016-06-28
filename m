Return-Path: <rtc-linux+bncBAABBSXRZC5QKGQEPYIYU7A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from arcturus.kleine-koenig.org (arcturus.kleine-koenig.org. [78.47.169.190])
        by gmr-mx.google.com with ESMTPS id f10si734967wmg.2.2016.06.28.01.43.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2016 01:43:54 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 4/4] rtc: sh: don't validate alarm time provided
 to .set_alarm
Date: Tue, 28 Jun 2016 10:43:48 +0200
Message-Id: <1467103428-19047-4-git-send-email-uwe@kleine-koenig.org>
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

The rtc core doesn't give broken dates to a driver's .set_alarm
callback, so there should be no need for validation.

Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
---
 drivers/rtc/rtc-sh.c | 41 +----------------------------------------
 1 file changed, 1 insertion(+), 40 deletions(-)

diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index 676949be777e..17b6235d67a5 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -499,52 +499,13 @@ static inline void sh_rtc_write_alarm_value(struct sh=
_rtc *rtc,
 		writeb(bin2bcd(value) | AR_ENB,  rtc->regbase + reg_off);
 }
=20
-static int sh_rtc_check_alarm(struct rtc_time *tm)
-{
-	/*
-	 * The original rtc says anything > 0xc0 is "don't care" or "match
-	 * all" - most users use 0xff but rtc-dev uses -1 for the same thing.
-	 * The original rtc doesn't support years - some things use -1 and
-	 * some 0xffff. We use -1 to make out tests easier.
-	 */
-	if (tm->tm_year =3D=3D 0xffff)
-		tm->tm_year =3D -1;
-	if (tm->tm_mon >=3D 0xff)
-		tm->tm_mon =3D -1;
-	if (tm->tm_mday >=3D 0xff)
-		tm->tm_mday =3D -1;
-	if (tm->tm_wday >=3D 0xff)
-		tm->tm_wday =3D -1;
-	if (tm->tm_hour >=3D 0xff)
-		tm->tm_hour =3D -1;
-	if (tm->tm_min >=3D 0xff)
-		tm->tm_min =3D -1;
-	if (tm->tm_sec >=3D 0xff)
-		tm->tm_sec =3D -1;
-
-	if (tm->tm_year > 9999 ||
-		tm->tm_mon >=3D 12 ||
-		tm->tm_mday =3D=3D 0 || tm->tm_mday >=3D 32 ||
-		tm->tm_wday >=3D 7 ||
-		tm->tm_hour >=3D 24 ||
-		tm->tm_min >=3D 60 ||
-		tm->tm_sec >=3D 60)
-		return -EINVAL;
-
-	return 0;
-}
-
 static int sh_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
 	struct sh_rtc *rtc =3D platform_get_drvdata(pdev);
 	unsigned int rcr1;
 	struct rtc_time *tm =3D &wkalrm->time;
-	int mon, err;
-
-	err =3D sh_rtc_check_alarm(tm);
-	if (unlikely(err < 0))
-		return err;
+	int mon;
=20
 	spin_lock_irq(&rtc->lock);
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
