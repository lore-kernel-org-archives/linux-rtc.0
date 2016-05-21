Return-Path: <rtc-linux+bncBDMITSXR5QMBBB56QO5AKGQEB3BQMUA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.18])
        by gmr-mx.google.com with ESMTPS id r72si125854wmd.2.2016.05.21.15.19.51
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 May 2016 15:19:51 -0700 (PDT)
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Joshua Kinard <kumba@gentoo.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [rtc-linux] [PATCH v2 1/1] rtc: ds1685: correct check of day of month
Date: Sun, 22 May 2016 00:18:55 +0200
Message-Id: <1463869135-32575-1-git-send-email-xypron.glpk@gmx.de>
In-Reply-To: <20160520223829.GA4963@piout.net>
References: <20160520223829.GA4963@piout.net>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The day of month is checked in ds1685_rtc_read_alarm
and ds1685_rtc_set_alarm.

Multiple errors exist in the day of month check.

Operator ! has a higher priority than &&.
(!(mday >= 1) && (mday <= 31)) is false for mday == 32.

When verifying the day of month the binary and the BCD mode
have to be considered.

v2:
	consider ds1685_rtc_read_alarm
	consider rtc->bcd_mode as indicated by Alexandre Belloni

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 drivers/rtc/rtc-ds1685.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index b3ce3c6..92e2f27 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -103,6 +103,26 @@ ds1685_rtc_bin2bcd(struct ds1685_priv *rtc, u8 val, u8 bin_mask, u8 bcd_mask)
 }
 
 /**
+ * s1685_rtc_check_mday - check validity of the day of month.
+ * @rtc: pointer to the ds1685 rtc structure.
+ * @mday: day of month.
+ *
+ * Returns -EDOM if the day of month is not within 1..31 range.
+ */
+static inline int
+ds1685_rtc_check_mday(struct ds1685_priv *rtc, u8 mday)
+{
+	if (rtc->bcd_mode) {
+		if (mday < 0x01 || mday > 0x31 || (mday & 0x0f) > 0x09)
+			return -EDOM;
+	} else {
+		if (mday < 1 || mday > 31)
+			return -EDOM;
+	}
+	return 0;
+}
+
+/**
  * ds1685_rtc_switch_to_bank0 - switch the rtc to bank 0.
  * @rtc: pointer to the ds1685 rtc structure.
  */
@@ -377,6 +397,7 @@ ds1685_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct ds1685_priv *rtc = platform_get_drvdata(pdev);
 	u8 seconds, minutes, hours, mday, ctrlb, ctrlc;
+	int ret;
 
 	/* Fetch the alarm info from the RTC alarm registers. */
 	ds1685_rtc_begin_data_access(rtc);
@@ -388,9 +409,10 @@ ds1685_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	ctrlc	= rtc->read(rtc, RTC_CTRL_C);
 	ds1685_rtc_end_data_access(rtc);
 
-	/* Check month date. */
-	if (!(mday >= 1) && (mday <= 31))
-		return -EDOM;
+	/* Check the month date for validity. */
+	ret = ds1685_rtc_check_mday(rtc, mday);
+	if (ret)
+		return ret;
 
 	/*
 	 * Check the three alarm bytes.
@@ -445,6 +467,7 @@ ds1685_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct ds1685_priv *rtc = platform_get_drvdata(pdev);
 	u8 ctrlb, seconds, minutes, hours, mday;
+	int ret;
 
 	/* Fetch the alarm info and convert to BCD. */
 	seconds	= ds1685_rtc_bin2bcd(rtc, alrm->time.tm_sec,
@@ -461,8 +484,9 @@ ds1685_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 				     RTC_MDAY_BCD_MASK);
 
 	/* Check the month date for validity. */
-	if (!(mday >= 1) && (mday <= 31))
-		return -EDOM;
+	ret = ds1685_rtc_check_mday(rtc, mday);
+	if (ret)
+		return ret;
 
 	/*
 	 * Check the three alarm bytes.
-- 
2.1.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
