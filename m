Return-Path: <alexandre.belloni@free-electrons.com>
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] rtc: rtc-mv: correct 24 hour error message
Date: Sat,  2 May 2015 11:28:30 +0200
Message-Id: <1430558910-7007-1-git-send-email-alexandre.belloni@free-electrons.com>
List-ID: <rtc-linux.googlegroups.com>

The driver can't accommodate the 12 hour mode but the error message states that
the 24 hour mode is not supported.
Also fix the typos (hour vs hours).
And finally use the BIT() macro.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-mv.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
index 423762241042..7f50d2ef7f6e 100644
--- a/drivers/rtc/rtc-mv.c
+++ b/drivers/rtc/rtc-mv.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/rtc.h>
 #include <linux/bcd.h>
+#include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
@@ -24,7 +25,7 @@
 #define RTC_MINUTES_OFFS	8
 #define RTC_HOURS_OFFS		16
 #define RTC_WDAY_OFFS		24
-#define RTC_HOURS_12H_MODE		(1 << 22) /* 12 hours mode */
+#define RTC_HOURS_12H_MODE	BIT(22) /* 12 hour mode */
 
 #define RTC_DATE_REG_OFFS	4
 #define RTC_MDAY_OFFS		0
@@ -33,7 +34,7 @@
 
 #define RTC_ALARM_TIME_REG_OFFS	8
 #define RTC_ALARM_DATE_REG_OFFS	0xc
-#define RTC_ALARM_VALID		(1 << 7)
+#define RTC_ALARM_VALID		BIT(7)
 
 #define RTC_ALARM_INTERRUPT_MASK_REG_OFFS	0x10
 #define RTC_ALARM_INTERRUPT_CASUE_REG_OFFS	0x14
@@ -77,7 +78,7 @@ static int mv_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	second = rtc_time & 0x7f;
 	minute = (rtc_time >> RTC_MINUTES_OFFS) & 0x7f;
-	hour = (rtc_time >> RTC_HOURS_OFFS) & 0x3f; /* assume 24 hours mode */
+	hour = (rtc_time >> RTC_HOURS_OFFS) & 0x3f; /* assume 24 hour mode */
 	wday = (rtc_time >> RTC_WDAY_OFFS) & 0x7;
 
 	day = rtc_date & 0x3f;
@@ -108,7 +109,7 @@ static int mv_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 
 	second = rtc_time & 0x7f;
 	minute = (rtc_time >> RTC_MINUTES_OFFS) & 0x7f;
-	hour = (rtc_time >> RTC_HOURS_OFFS) & 0x3f; /* assume 24 hours mode */
+	hour = (rtc_time >> RTC_HOURS_OFFS) & 0x3f; /* assume 24 hour mode */
 	wday = (rtc_time >> RTC_WDAY_OFFS) & 0x7;
 
 	day = rtc_date & 0x3f;
@@ -239,10 +240,10 @@ static int __init mv_rtc_probe(struct platform_device *pdev)
 	if (!IS_ERR(pdata->clk))
 		clk_prepare_enable(pdata->clk);
 
-	/* make sure the 24 hours mode is enabled */
+	/* make sure the 24 hour mode is enabled */
 	rtc_time = readl(pdata->ioaddr + RTC_TIME_REG_OFFS);
 	if (rtc_time & RTC_HOURS_12H_MODE) {
-		dev_err(&pdev->dev, "24 Hours mode not supported.\n");
+		dev_err(&pdev->dev, "12 Hour mode is enabled but not supported.\n");
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.1.4
