Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37536 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932775AbdHYUGj (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 25 Aug 2017 16:06:39 -0400
Received: by mail-wr0-f196.google.com with SMTP id p14so435607wrg.4
        for <linux-rtc@vger.kernel.org>; Fri, 25 Aug 2017 13:06:39 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 5/5] rtc: ds1307: improve ds1307_set_time to respect config
 flag bits
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <cb381496-4d55-996d-e2ae-18880330e386@gmail.com>
Message-ID: <2a6d0034-745b-d959-4225-4ffaf9e5ac26@gmail.com>
Date: Fri, 25 Aug 2017 22:06:26 +0200
MIME-Version: 1.0
In-Reply-To: <cb381496-4d55-996d-e2ae-18880330e386@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Some chips use the unused bits in the timekeeping registers for config
bits. Therefore, when setting the time, we should read the timekeeping
registers and leave the unused bits intact when setting the date / time
values.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 68 ++++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index a43a80b2..1255b165 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -447,9 +447,8 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 {
 	struct ds1307	*ds1307 = dev_get_drvdata(dev);
 	const struct chip_desc *chip = &chips[ds1307->type];
-	int		result;
-	int		tmp;
 	u8		*buf = ds1307->regs;
+	int		ret;
 
 	dev_dbg(dev, "%s secs=%d, mins=%d, "
 		"hours=%d, mday=%d, mon=%d, year=%d, wday=%d\n",
@@ -457,51 +456,52 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 		t->tm_hour, t->tm_mday,
 		t->tm_mon, t->tm_year, t->tm_wday);
 
-	if (t->tm_year < 100)
+	if (t->tm_year < 100 || t->tm_year > 299)
 		return -EINVAL;
 
-#ifdef CONFIG_RTC_DRV_DS1307_CENTURY
-	if (t->tm_year > (chip->century_bit ? 299 : 199))
-		return -EINVAL;
-#else
-	if (t->tm_year > 199)
-		return -EINVAL;
-#endif
+	if (!IS_ENABLED(CONFIG_RTC_DRV_DS1307_CENTURY) || !chip->century_bit)
+		if (t->tm_year > 199)
+			return -EINVAL;
 
-	buf[DS1307_REG_SECS] = bin2bcd(t->tm_sec);
-	buf[DS1307_REG_MIN] = bin2bcd(t->tm_min);
-	buf[DS1307_REG_HOUR] = bin2bcd(t->tm_hour);
-	buf[DS1307_REG_WDAY] = bin2bcd(t->tm_wday + 1);
-	buf[DS1307_REG_MDAY] = bin2bcd(t->tm_mday);
-	buf[DS1307_REG_MONTH] = bin2bcd(t->tm_mon + 1);
+	ret = regmap_bulk_read(ds1307->regmap, chip->offset, buf, 7);
+	if (ret) {
+		dev_err(dev, "%s error %d\n", "read", ret);
+		return ret;
+	}
 
+	/*
+	 * Several chips use upper bits of these registers for
+	 * config bits, so leave them intact.
+	 */
+	buf[DS1307_REG_SECS] &= ~DS1307_SECS_MASK;
+	buf[DS1307_REG_SECS] |= bin2bcd(t->tm_sec);
+	buf[DS1307_REG_MIN] &= ~DS1307_MIN_MASK;
+	buf[DS1307_REG_MIN] |= bin2bcd(t->tm_min);
+	buf[DS1307_REG_HOUR] &= ~DS1307_HOUR_MASK;
+	buf[DS1307_REG_HOUR] |= bin2bcd(t->tm_hour);
+	buf[DS1307_REG_WDAY] &= ~DS1307_WDAY_MASK;
+	buf[DS1307_REG_WDAY] |= bin2bcd(t->tm_wday + 1);
+	buf[DS1307_REG_MDAY] &= ~DS1307_MDAY_MASK;
+	buf[DS1307_REG_MDAY] |= bin2bcd(t->tm_mday);
+	buf[DS1307_REG_MONTH] &= ~DS1307_MONTH_MASK;
+	buf[DS1307_REG_MONTH] |= bin2bcd(t->tm_mon + 1);
+
+	buf[DS1307_REG_YEAR] &= ~DS1307_YEAR_MASK;
 	/* assume 20YY not 19YY */
-	tmp = t->tm_year - 100;
-	buf[DS1307_REG_YEAR] = bin2bcd(tmp);
+	buf[DS1307_REG_YEAR] |= bin2bcd(t->tm_year - 100);
 
 	if (chip->century_enable_bit)
 		buf[chip->century_reg] |= chip->century_enable_bit;
 	if (t->tm_year > 199 && chip->century_bit)
 		buf[chip->century_reg] |= chip->century_bit;
 
-	if (ds1307->type == mcp794xx) {
-		/*
-		 * these bits were cleared when preparing the date/time
-		 * values and need to be set again before writing the
-		 * buffer out to the device.
-		 */
-		buf[DS1307_REG_SECS] |= MCP794XX_BIT_ST;
-		buf[DS1307_REG_WDAY] |= MCP794XX_BIT_VBATEN;
-	}
-
 	dev_dbg(dev, "%s: %7ph\n", "write", buf);
 
-	result = regmap_bulk_write(ds1307->regmap, chip->offset, buf, 7);
-	if (result) {
-		dev_err(dev, "%s error %d\n", "write", result);
-		return result;
-	}
-	return 0;
+	ret = regmap_bulk_write(ds1307->regmap, chip->offset, buf, 7);
+	if (ret)
+		dev_err(dev, "%s error %d\n", "write", ret);
+
+	return ret;
 }
 
 static int ds1337_read_alarm(struct device *dev, struct rtc_wkalrm *t)
-- 
2.14.1
