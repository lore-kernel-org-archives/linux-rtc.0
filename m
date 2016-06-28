Return-Path: <rtc-linux+bncBAABBSPRZC5QKGQEH2DZALY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from arcturus.kleine-koenig.org (arcturus.kleine-koenig.org. [78.47.169.190])
        by gmr-mx.google.com with ESMTPS id r10si646647wmf.0.2016.06.28.01.43.53
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2016 01:43:53 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 2/4] rtc: isl12057: let the rtc core interpret the
 partial alarm
Date: Tue, 28 Jun 2016 10:43:46 +0200
Message-Id: <1467103428-19047-2-git-send-email-uwe@kleine-koenig.org>
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

The rtc chip doesn't support triggering on month and year. So just don't
assign the respective fields in .read_alarm and let the rtc core
interpret this accordingly.

Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
---
 drivers/rtc/rtc-isl12057.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/rtc/rtc-isl12057.c b/drivers/rtc/rtc-isl12057.c
index 54328d4ac0d3..e0245fc6205e 100644
--- a/drivers/rtc/rtc-isl12057.c
+++ b/drivers/rtc/rtc-isl12057.c
@@ -264,36 +264,6 @@ static int isl12057_rtc_read_alarm(struct device *dev,=
 struct rtc_wkalrm *alarm)
 	alarm_tm->tm_min  =3D bcd2bin(regs[1] & 0x7f);
 	alarm_tm->tm_hour =3D bcd2bin(regs[2] & 0x3f);
 	alarm_tm->tm_mday =3D bcd2bin(regs[3] & 0x3f);
-	alarm_tm->tm_wday =3D -1;
-
-	/*
-	 * The alarm section does not store year/month. We use the ones in rtc
-	 * section as a basis and increment month and then year if needed to get
-	 * alarm after current time.
-	 */
-	ret =3D _isl12057_rtc_read_time(dev, &rtc_tm);
-	if (ret)
-		goto err_unlock;
-
-	alarm_tm->tm_year =3D rtc_tm.tm_year;
-	alarm_tm->tm_mon =3D rtc_tm.tm_mon;
-
-	ret =3D rtc_tm_to_time(&rtc_tm, &rtc_secs);
-	if (ret)
-		goto err_unlock;
-
-	ret =3D rtc_tm_to_time(alarm_tm, &alarm_secs);
-	if (ret)
-		goto err_unlock;
-
-	if (alarm_secs < rtc_secs) {
-		if (alarm_tm->tm_mon =3D=3D 11) {
-			alarm_tm->tm_mon =3D 0;
-			alarm_tm->tm_year +=3D 1;
-		} else {
-			alarm_tm->tm_mon +=3D 1;
-		}
-	}
=20
 	ret =3D regmap_read(data->regmap, ISL12057_REG_INT, &ir);
 	if (ret) {
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
