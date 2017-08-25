Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37532 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932771AbdHYUGi (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 25 Aug 2017 16:06:38 -0400
Received: by mail-wr0-f193.google.com with SMTP id p14so435580wrg.4
        for <linux-rtc@vger.kernel.org>; Fri, 25 Aug 2017 13:06:37 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 4/5] rtc: ds1307: introduce constants for the timekeeping
 register masks
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <cb381496-4d55-996d-e2ae-18880330e386@gmail.com>
Message-ID: <d6b499e6-307f-fe33-353f-4be6864f1503@gmail.com>
Date: Fri, 25 Aug 2017 22:06:19 +0200
MIME-Version: 1.0
In-Reply-To: <cb381496-4d55-996d-e2ae-18880330e386@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

So far for masking the relevant bits of the timekeeping registers
magic numbers are used. Replace them with proper constants.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 63 ++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 69f514b6..a43a80b2 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -54,22 +54,29 @@ enum ds_type {
 
 /* RTC registers don't differ much, except for the century flag */
 #define DS1307_REG_SECS		0x00	/* 00-59 */
+#define DS1307_SECS_MASK	GENMASK(6, 0)
 #	define DS1307_BIT_CH		0x80
 #	define DS1340_BIT_nEOSC		0x80
 #	define MCP794XX_BIT_ST		0x80
 #define DS1307_REG_MIN		0x01	/* 00-59 */
+#define DS1307_MIN_MASK		GENMASK(6, 0)
 #	define M41T0_BIT_OF		0x80
 #define DS1307_REG_HOUR		0x02	/* 00-23, or 1-12{am,pm} */
+#define DS1307_HOUR_MASK	GENMASK(5, 0)
 #	define DS1307_BIT_12HR		0x40	/* in REG_HOUR */
 #	define DS1307_BIT_PM		0x20	/* in REG_HOUR */
 #	define DS1340_BIT_CENTURY_EN	0x80	/* in REG_HOUR */
 #	define DS1340_BIT_CENTURY	0x40	/* in REG_HOUR */
 #define DS1307_REG_WDAY		0x03	/* 01-07 */
+#define DS1307_WDAY_MASK	GENMASK(2, 0)
 #	define MCP794XX_BIT_VBATEN	0x08
 #define DS1307_REG_MDAY		0x04	/* 01-31 */
+#define DS1307_MDAY_MASK	GENMASK(5, 0)
 #define DS1307_REG_MONTH	0x05	/* 01-12 */
+#define DS1307_MONTH_MASK	GENMASK(4, 0)
 #	define DS1337_BIT_CENTURY	0x80	/* in REG_MONTH */
 #define DS1307_REG_YEAR		0x06	/* 00-99 */
+#define DS1307_YEAR_MASK	GENMASK(7, 0)
 
 /*
  * Other registers (control, status, alarms, trickle charge, NVRAM, etc)
@@ -395,36 +402,34 @@ static irqreturn_t ds1307_irq(int irq, void *dev_id)
 static int ds1307_get_time(struct device *dev, struct rtc_time *t)
 {
 	struct ds1307	*ds1307 = dev_get_drvdata(dev);
-	int		tmp, ret;
 	const struct chip_desc *chip = &chips[ds1307->type];
+	u8		*buf = ds1307->regs;
+	int		ret;
 
 	/* read the RTC date and time registers all at once */
-	ret = regmap_bulk_read(ds1307->regmap, chip->offset, ds1307->regs, 7);
+	ret = regmap_bulk_read(ds1307->regmap, chip->offset, buf, 7);
 	if (ret) {
 		dev_err(dev, "%s error %d\n", "read", ret);
 		return ret;
 	}
 
-	dev_dbg(dev, "%s: %7ph\n", "read", ds1307->regs);
+	dev_dbg(dev, "%s: %7ph\n", "read", buf);
 
 	/* if oscillator fail bit is set, no data can be trusted */
-	if (ds1307->type == m41t0 &&
-	    ds1307->regs[DS1307_REG_MIN] & M41T0_BIT_OF) {
+	if (ds1307->type == m41t0 && buf[DS1307_REG_MIN] & M41T0_BIT_OF) {
 		dev_warn_once(dev, "oscillator failed, set time!\n");
 		return -EINVAL;
 	}
 
-	t->tm_sec = bcd2bin(ds1307->regs[DS1307_REG_SECS] & 0x7f);
-	t->tm_min = bcd2bin(ds1307->regs[DS1307_REG_MIN] & 0x7f);
-	tmp = ds1307->regs[DS1307_REG_HOUR] & 0x3f;
-	t->tm_hour = bcd2bin(tmp);
-	t->tm_wday = bcd2bin(ds1307->regs[DS1307_REG_WDAY] & 0x07) - 1;
-	t->tm_mday = bcd2bin(ds1307->regs[DS1307_REG_MDAY] & 0x3f);
-	tmp = ds1307->regs[DS1307_REG_MONTH] & 0x1f;
-	t->tm_mon = bcd2bin(tmp) - 1;
-	t->tm_year = bcd2bin(ds1307->regs[DS1307_REG_YEAR]) + 100;
-
-	if (ds1307->regs[chip->century_reg] & chip->century_bit &&
+	t->tm_sec = bcd2bin(buf[DS1307_REG_SECS] & DS1307_SECS_MASK);
+	t->tm_min = bcd2bin(buf[DS1307_REG_MIN] & DS1307_MIN_MASK);
+	t->tm_hour = bcd2bin(buf[DS1307_REG_HOUR] & DS1307_HOUR_MASK);
+	t->tm_wday = bcd2bin(buf[DS1307_REG_WDAY] & DS1307_WDAY_MASK) - 1;
+	t->tm_mday = bcd2bin(buf[DS1307_REG_MDAY] & DS1307_MDAY_MASK);
+	t->tm_mon = bcd2bin(buf[DS1307_REG_MONTH] & DS1307_MONTH_MASK) - 1;
+	t->tm_year = bcd2bin(buf[DS1307_REG_YEAR] & DS1307_YEAR_MASK) + 100;
+
+	if (buf[chip->century_reg] & chip->century_bit &&
 	    IS_ENABLED(CONFIG_RTC_DRV_DS1307_CENTURY))
 		t->tm_year += 100;
 
@@ -522,10 +527,10 @@ static int ds1337_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 	 * report alarm time (ALARM1); assume 24 hour and day-of-month modes,
 	 * and that all four fields are checked matches
 	 */
-	t->time.tm_sec = bcd2bin(ds1307->regs[0] & 0x7f);
-	t->time.tm_min = bcd2bin(ds1307->regs[1] & 0x7f);
-	t->time.tm_hour = bcd2bin(ds1307->regs[2] & 0x3f);
-	t->time.tm_mday = bcd2bin(ds1307->regs[3] & 0x3f);
+	t->time.tm_sec = bcd2bin(ds1307->regs[0] & DS1307_SECS_MASK);
+	t->time.tm_min = bcd2bin(ds1307->regs[1] & DS1307_MIN_MASK);
+	t->time.tm_hour = bcd2bin(ds1307->regs[2] & DS1307_HOUR_MASK);
+	t->time.tm_mday = bcd2bin(ds1307->regs[3] & DS1307_MDAY_MASK);
 
 	/* ... and status */
 	t->enabled = !!(ds1307->regs[7] & DS1337_BIT_A1IE);
@@ -689,10 +694,10 @@ static int rx8130_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 
 	/* Report alarm 0 time assuming 24-hour and day-of-month modes. */
 	t->time.tm_sec = -1;
-	t->time.tm_min = bcd2bin(ald[0] & 0x7f);
-	t->time.tm_hour = bcd2bin(ald[1] & 0x7f);
+	t->time.tm_min = bcd2bin(ald[0] & DS1307_MIN_MASK);
+	t->time.tm_hour = bcd2bin(ald[1] & DS1307_HOUR_MASK);
 	t->time.tm_wday = -1;
-	t->time.tm_mday = bcd2bin(ald[2] & 0x7f);
+	t->time.tm_mday = bcd2bin(ald[2] & DS1307_MDAY_MASK);
 	t->time.tm_mon = -1;
 	t->time.tm_year = -1;
 	t->time.tm_yday = -1;
@@ -844,12 +849,12 @@ static int mcp794xx_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 	t->enabled = !!(regs[0] & MCP794XX_BIT_ALM0_EN);
 
 	/* Report alarm 0 time assuming 24-hour and day-of-month modes. */
-	t->time.tm_sec = bcd2bin(ds1307->regs[3] & 0x7f);
-	t->time.tm_min = bcd2bin(ds1307->regs[4] & 0x7f);
-	t->time.tm_hour = bcd2bin(ds1307->regs[5] & 0x3f);
-	t->time.tm_wday = bcd2bin(ds1307->regs[6] & 0x7) - 1;
-	t->time.tm_mday = bcd2bin(ds1307->regs[7] & 0x3f);
-	t->time.tm_mon = bcd2bin(ds1307->regs[8] & 0x1f) - 1;
+	t->time.tm_sec = bcd2bin(ds1307->regs[3] & DS1307_SECS_MASK);
+	t->time.tm_min = bcd2bin(ds1307->regs[4] & DS1307_MIN_MASK);
+	t->time.tm_hour = bcd2bin(ds1307->regs[5] & DS1307_HOUR_MASK);
+	t->time.tm_wday = bcd2bin(ds1307->regs[6] & DS1307_WDAY_MASK) - 1;
+	t->time.tm_mday = bcd2bin(ds1307->regs[7] & DS1307_MDAY_MASK);
+	t->time.tm_mon = bcd2bin(ds1307->regs[8] & DS1307_MONTH_MASK) - 1;
 	t->time.tm_year = -1;
 	t->time.tm_yday = -1;
 	t->time.tm_isdst = -1;
-- 
2.14.1
