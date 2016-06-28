Return-Path: <rtc-linux+bncBAABBSHRZC5QKGQEWMAAZZA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from arcturus.kleine-koenig.org (arcturus.kleine-koenig.org. [78.47.169.190])
        by gmr-mx.google.com with ESMTPS id f138si835941wmf.3.2016.06.28.01.43.52
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2016 01:43:52 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 1/4] rtc: simplify implementations of read_alarm
Date: Tue, 28 Jun 2016 10:43:45 +0200
Message-Id: <1467103428-19047-1-git-send-email-uwe@kleine-koenig.org>
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

Since commit d68778b80dd7 ("rtc: initialize output parameter for read
alarm to "uninitialized"") there is no need to explicitly set
unsupported members to -1. So drop the respective assignments from
drivers.

Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
---
 drivers/rtc/rtc-cmos.c    |  3 ---
 drivers/rtc/rtc-ds1305.c  |  7 -------
 drivers/rtc/rtc-ds1307.c  |  5 -----
 drivers/rtc/rtc-ds1343.c  |  6 ------
 drivers/rtc/rtc-ds1685.c  | 19 ++++---------------
 drivers/rtc/rtc-ds3232.c  |  6 ------
 drivers/rtc/rtc-hym8563.c |  3 ---
 drivers/rtc/rtc-m41t80.c  |  2 --
 drivers/rtc/rtc-mrst.c    |  8 --------
 drivers/rtc/rtc-pcf8563.c |  4 ----
 drivers/rtc/rtc-rs5c372.c |  6 ------
 drivers/rtc/rtc-rv8803.c  |  3 ---
 drivers/rtc/rtc-rx8010.c  |  8 +-------
 drivers/rtc/rtc-rx8025.c  |  5 -----
 drivers/rtc/rtc-s3c.c     | 12 ------------
 drivers/rtc/rtc-tegra.c   |  6 ------
 16 files changed, 5 insertions(+), 98 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index f9fdb6fc641c..43745cac0141 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -220,8 +220,6 @@ static int cmos_read_alarm(struct device *dev, struct r=
tc_wkalrm *t)
 	 * Some also support day and month, for alarms up to a year in
 	 * the future.
 	 */
-	t->time.tm_mday =3D -1;
-	t->time.tm_mon =3D -1;
=20
 	spin_lock_irq(&rtc_lock);
 	t->time.tm_sec =3D CMOS_READ(RTC_SECONDS_ALARM);
@@ -272,7 +270,6 @@ static int cmos_read_alarm(struct device *dev, struct r=
tc_wkalrm *t)
 			}
 		}
 	}
-	t->time.tm_year =3D -1;
=20
 	t->enabled =3D !!(rtc_control & RTC_AIE);
 	t->pending =3D 0;
diff --git a/drivers/rtc/rtc-ds1305.c b/drivers/rtc/rtc-ds1305.c
index 8e41c4613e51..72b22935eb62 100644
--- a/drivers/rtc/rtc-ds1305.c
+++ b/drivers/rtc/rtc-ds1305.c
@@ -313,13 +313,6 @@ static int ds1305_get_alarm(struct device *dev, struct=
 rtc_wkalrm *alm)
 	alm->time.tm_sec =3D bcd2bin(buf[DS1305_SEC]);
 	alm->time.tm_min =3D bcd2bin(buf[DS1305_MIN]);
 	alm->time.tm_hour =3D bcd2hour(buf[DS1305_HOUR]);
-	alm->time.tm_mday =3D -1;
-	alm->time.tm_mon =3D -1;
-	alm->time.tm_year =3D -1;
-	/* next three fields are unused by Linux */
-	alm->time.tm_wday =3D -1;
-	alm->time.tm_mday =3D -1;
-	alm->time.tm_isdst =3D -1;
=20
 	return 0;
 }
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 821d9c089cdb..67a6100de1ac 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -482,11 +482,6 @@ static int ds1337_read_alarm(struct device *dev, struc=
t rtc_wkalrm *t)
 	t->time.tm_min =3D bcd2bin(ds1307->regs[1] & 0x7f);
 	t->time.tm_hour =3D bcd2bin(ds1307->regs[2] & 0x3f);
 	t->time.tm_mday =3D bcd2bin(ds1307->regs[3] & 0x3f);
-	t->time.tm_mon =3D -1;
-	t->time.tm_year =3D -1;
-	t->time.tm_wday =3D -1;
-	t->time.tm_yday =3D -1;
-	t->time.tm_isdst =3D -1;
=20
 	/* ... and status */
 	t->enabled =3D !!(ds1307->regs[7] & DS1337_BIT_A1IE);
diff --git a/drivers/rtc/rtc-ds1343.c b/drivers/rtc/rtc-ds1343.c
index 23fa9f0cb5e3..895fbeeb47fe 100644
--- a/drivers/rtc/rtc-ds1343.c
+++ b/drivers/rtc/rtc-ds1343.c
@@ -504,12 +504,6 @@ static int ds1343_read_alarm(struct device *dev, struc=
t rtc_wkalrm *alarm)
 	alarm->time.tm_hour =3D priv->alarm_hour < 0 ? 0 : priv->alarm_hour;
 	alarm->time.tm_mday =3D priv->alarm_mday < 0 ? 0 : priv->alarm_mday;
=20
-	alarm->time.tm_mon =3D -1;
-	alarm->time.tm_year =3D -1;
-	alarm->time.tm_wday =3D -1;
-	alarm->time.tm_yday =3D -1;
-	alarm->time.tm_isdst =3D -1;
-
 out:
 	mutex_unlock(&priv->mutex);
 	return res;
diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 68197042feb7..ed43b4311660 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -419,25 +419,19 @@ ds1685_rtc_read_alarm(struct device *dev, struct rtc_=
wkalrm *alrm)
 	 *
 	 * The Linux RTC system doesn't support the "don't care" capability
 	 * of this RTC chip.  We check for it anyways in case support is
-	 * added in the future.
+	 * added in the future and only assign when we care.
 	 */
-	if (unlikely(seconds >=3D 0xc0))
-		alrm->time.tm_sec =3D -1;
-	else
+	if (likely(seconds < 0xc0))
 		alrm->time.tm_sec =3D ds1685_rtc_bcd2bin(rtc, seconds,
 						       RTC_SECS_BCD_MASK,
 						       RTC_SECS_BIN_MASK);
=20
-	if (unlikely(minutes >=3D 0xc0))
-		alrm->time.tm_min =3D -1;
-	else
+	if (likely(minutes < 0xc0))
 		alrm->time.tm_min =3D ds1685_rtc_bcd2bin(rtc, minutes,
 						       RTC_MINS_BCD_MASK,
 						       RTC_MINS_BIN_MASK);
=20
-	if (unlikely(hours >=3D 0xc0))
-		alrm->time.tm_hour =3D -1;
-	else
+	if (likely(hours < 0xc0))
 		alrm->time.tm_hour =3D ds1685_rtc_bcd2bin(rtc, hours,
 							RTC_HRS_24_BCD_MASK,
 							RTC_HRS_24_BIN_MASK);
@@ -445,11 +439,6 @@ ds1685_rtc_read_alarm(struct device *dev, struct rtc_w=
kalrm *alrm)
 	/* Write the data to rtc_wkalrm. */
 	alrm->time.tm_mday =3D ds1685_rtc_bcd2bin(rtc, mday, RTC_MDAY_BCD_MASK,
 						RTC_MDAY_BIN_MASK);
-	alrm->time.tm_mon =3D -1;
-	alrm->time.tm_year =3D -1;
-	alrm->time.tm_wday =3D -1;
-	alrm->time.tm_yday =3D -1;
-	alrm->time.tm_isdst =3D -1;
 	alrm->enabled =3D !!(ctrlb & RTC_CTRL_B_AIE);
 	alrm->pending =3D !!(ctrlc & RTC_CTRL_C_AF);
=20
diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index 04fbd7fffd0d..b1f20d8c358f 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -197,12 +197,6 @@ static int ds3232_read_alarm(struct device *dev, struc=
t rtc_wkalrm *alarm)
 	alarm->time.tm_hour =3D bcd2bin(buf[2] & 0x7F);
 	alarm->time.tm_mday =3D bcd2bin(buf[3] & 0x7F);
=20
-	alarm->time.tm_mon =3D -1;
-	alarm->time.tm_year =3D -1;
-	alarm->time.tm_wday =3D -1;
-	alarm->time.tm_yday =3D -1;
-	alarm->time.tm_isdst =3D -1;
-
 	alarm->enabled =3D !!(control & DS3232_REG_CR_A1IE);
 	alarm->pending =3D !!(stat & DS3232_REG_SR_A1F);
=20
diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index 207270376b55..795a3f517cd0 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -213,9 +213,6 @@ static int hym8563_rtc_read_alarm(struct device *dev, s=
truct rtc_wkalrm *alm)
 					-1 :
 					bcd2bin(buf[3] & HYM8563_WEEKDAY_MASK);
=20
-	alm_tm->tm_mon =3D -1;
-	alm_tm->tm_year =3D -1;
-
 	ret =3D i2c_smbus_read_byte_data(client, HYM8563_CTL2);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index d1bf93a87200..c829bc45a371 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -320,10 +320,8 @@ static int m41t80_read_alarm(struct device *dev, struc=
t rtc_wkalrm *alrm)
 	alrm->time.tm_sec  =3D bcd2bin(alarmvals[4] & 0x7f);
 	alrm->time.tm_min  =3D bcd2bin(alarmvals[3] & 0x7f);
 	alrm->time.tm_hour =3D bcd2bin(alarmvals[2] & 0x3f);
-	alrm->time.tm_wday =3D -1;
 	alrm->time.tm_mday =3D bcd2bin(alarmvals[1] & 0x3f);
 	alrm->time.tm_mon  =3D bcd2bin(alarmvals[0] & 0x3f);
-	alrm->time.tm_year =3D -1;
=20
 	alrm->enabled =3D !!(alarmvals[0] & M41T80_ALMON_AFE);
 	alrm->pending =3D (flags & M41T80_FLAGS_AF) && alrm->enabled;
diff --git a/drivers/rtc/rtc-mrst.c b/drivers/rtc/rtc-mrst.c
index fe840c0edfef..7334c44fa7c3 100644
--- a/drivers/rtc/rtc-mrst.c
+++ b/drivers/rtc/rtc-mrst.c
@@ -149,14 +149,6 @@ static int mrst_read_alarm(struct device *dev, struct =
rtc_wkalrm *t)
 	if (mrst->irq <=3D 0)
 		return -EIO;
=20
-	/* Basic alarms only support hour, minute, and seconds fields.
-	 * Some also support day and month, for alarms up to a year in
-	 * the future.
-	 */
-	t->time.tm_mday =3D -1;
-	t->time.tm_mon =3D -1;
-	t->time.tm_year =3D -1;
-
 	/* vRTC only supports binary mode */
 	spin_lock_irq(&rtc_lock);
 	t->time.tm_sec =3D vrtc_cmos_read(RTC_SECONDS_ALARM);
diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index b9ddbb001283..26091a48925f 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -345,10 +345,6 @@ static int pcf8563_rtc_read_alarm(struct device *dev, =
struct rtc_wkalrm *tm)
 	tm->time.tm_hour =3D bcd2bin(buf[1] & 0x3F);
 	tm->time.tm_mday =3D bcd2bin(buf[2] & 0x3F);
 	tm->time.tm_wday =3D bcd2bin(buf[3] & 0x7);
-	tm->time.tm_mon =3D -1;
-	tm->time.tm_year =3D -1;
-	tm->time.tm_yday =3D -1;
-	tm->time.tm_isdst =3D -1;
=20
 	err =3D pcf8563_get_alarm_mode(client, &tm->enabled, &tm->pending);
 	if (err < 0)
diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index ef86229428fc..c8c757466783 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -341,12 +341,6 @@ static int rs5c_read_alarm(struct device *dev, struct =
rtc_wkalrm *t)
 	t->time.tm_sec =3D 0;
 	t->time.tm_min =3D bcd2bin(rs5c->regs[RS5C_REG_ALARM_A_MIN] & 0x7f);
 	t->time.tm_hour =3D rs5c_reg2hr(rs5c, rs5c->regs[RS5C_REG_ALARM_A_HOURS])=
;
-	t->time.tm_mday =3D -1;
-	t->time.tm_mon =3D -1;
-	t->time.tm_year =3D -1;
-	t->time.tm_wday =3D -1;
-	t->time.tm_yday =3D -1;
-	t->time.tm_isdst =3D -1;
=20
 	/* ... and status */
 	t->enabled =3D !!(rs5c->regs[RS5C_REG_CTRL1] & RS5C_CTRL1_AALE);
diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 022ef26bef47..05c79c38689d 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -210,10 +210,7 @@ static int rv8803_get_alarm(struct device *dev, struct=
 rtc_wkalrm *alrm)
 	alrm->time.tm_sec  =3D 0;
 	alrm->time.tm_min  =3D bcd2bin(alarmvals[0] & 0x7f);
 	alrm->time.tm_hour =3D bcd2bin(alarmvals[1] & 0x3f);
-	alrm->time.tm_wday =3D -1;
 	alrm->time.tm_mday =3D bcd2bin(alarmvals[2] & 0x3f);
-	alrm->time.tm_mon  =3D -1;
-	alrm->time.tm_year =3D -1;
=20
 	alrm->enabled =3D !!(rv8803->ctrl & RV8803_CTRL_AIE);
 	alrm->pending =3D (flags & RV8803_FLAG_AF) && alrm->enabled;
diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index 772d221ec2d9..7163b91bb773 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -272,15 +272,9 @@ static int rx8010_read_alarm(struct device *dev, struc=
t rtc_wkalrm *t)
 	t->time.tm_min =3D bcd2bin(alarmvals[0] & 0x7f);
 	t->time.tm_hour =3D bcd2bin(alarmvals[1] & 0x3f);
=20
-	if (alarmvals[2] & RX8010_ALARM_AE)
-		t->time.tm_mday =3D -1;
-	else
+	if (!(alarmvals[2] & RX8010_ALARM_AE))
 		t->time.tm_mday =3D bcd2bin(alarmvals[2] & 0x7f);
=20
-	t->time.tm_wday =3D -1;
-	t->time.tm_mon =3D -1;
-	t->time.tm_year =3D -1;
-
 	t->enabled =3D !!(rx8010->ctrlreg & RX8010_CTRL_AIE);
 	t->pending =3D (flagreg & RX8010_FLAG_AF) && t->enabled;
=20
diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index 9f105efbc546..2b85cc7a24e7 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -319,11 +319,6 @@ static int rx8025_read_alarm(struct device *dev, struc=
t rtc_wkalrm *t)
 		t->time.tm_hour =3D bcd2bin(ald[1] & 0x1f) % 12
 			+ (ald[1] & 0x20 ? 12 : 0);
=20
-	t->time.tm_wday =3D -1;
-	t->time.tm_mday =3D -1;
-	t->time.tm_mon =3D -1;
-	t->time.tm_year =3D -1;
-
 	dev_dbg(dev, "%s: date: %ds %dm %dh %dmd %dm %dy\n",
 		__func__,
 		t->time.tm_sec, t->time.tm_min, t->time.tm_hour,
diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index d01ad7e8078e..6d25e373e246 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -264,35 +264,23 @@ static int s3c_rtc_getalarm(struct device *dev, struc=
t rtc_wkalrm *alrm)
 	/* decode the alarm enable field */
 	if (alm_en & S3C2410_RTCALM_SECEN)
 		alm_tm->tm_sec =3D bcd2bin(alm_tm->tm_sec);
-	else
-		alm_tm->tm_sec =3D -1;
=20
 	if (alm_en & S3C2410_RTCALM_MINEN)
 		alm_tm->tm_min =3D bcd2bin(alm_tm->tm_min);
-	else
-		alm_tm->tm_min =3D -1;
=20
 	if (alm_en & S3C2410_RTCALM_HOUREN)
 		alm_tm->tm_hour =3D bcd2bin(alm_tm->tm_hour);
-	else
-		alm_tm->tm_hour =3D -1;
=20
 	if (alm_en & S3C2410_RTCALM_DAYEN)
 		alm_tm->tm_mday =3D bcd2bin(alm_tm->tm_mday);
-	else
-		alm_tm->tm_mday =3D -1;
=20
 	if (alm_en & S3C2410_RTCALM_MONEN) {
 		alm_tm->tm_mon =3D bcd2bin(alm_tm->tm_mon);
 		alm_tm->tm_mon -=3D 1;
-	} else {
-		alm_tm->tm_mon =3D -1;
 	}
=20
 	if (alm_en & S3C2410_RTCALM_YEAREN)
 		alm_tm->tm_year =3D bcd2bin(alm_tm->tm_year);
-	else
-		alm_tm->tm_year =3D -1;
=20
 	return 0;
 }
diff --git a/drivers/rtc/rtc-tegra.c b/drivers/rtc/rtc-tegra.c
index 60232bd366ef..15ac597d54da 100644
--- a/drivers/rtc/rtc-tegra.c
+++ b/drivers/rtc/rtc-tegra.c
@@ -179,12 +179,6 @@ static int tegra_rtc_read_alarm(struct device *dev, st=
ruct rtc_wkalrm *alarm)
 	if (sec =3D=3D 0) {
 		/* alarm is disabled. */
 		alarm->enabled =3D 0;
-		alarm->time.tm_mon =3D -1;
-		alarm->time.tm_mday =3D -1;
-		alarm->time.tm_year =3D -1;
-		alarm->time.tm_hour =3D -1;
-		alarm->time.tm_min =3D -1;
-		alarm->time.tm_sec =3D -1;
 	} else {
 		/* alarm is enabled. */
 		alarm->enabled =3D 1;
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
