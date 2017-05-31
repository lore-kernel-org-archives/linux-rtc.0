Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35479 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdEaVdh (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 31 May 2017 17:33:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id g15so6648220wmc.2
        for <linux-rtc@vger.kernel.org>; Wed, 31 May 2017 14:33:37 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 2/4] rtc: ds1307: use regmap_update_bits where applicable
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <85789383-af9c-fdbb-ff58-121d9fd432f5@gmail.com>
Message-ID: <7e2108a4-c968-32f9-cac3-5b732f45fe53@gmail.com>
Date: Wed, 31 May 2017 23:32:51 +0200
MIME-Version: 1.0
In-Reply-To: <85789383-af9c-fdbb-ff58-121d9fd432f5@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

After the switch to regmap we can now make use of regmap_update_bits
to simplify read/modify/write ops.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 82 ++++++++++++------------------------------------
 1 file changed, 20 insertions(+), 62 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index b960ec3f..bf906e9f 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -247,7 +247,7 @@ static irqreturn_t ds1307_irq(int irq, void *dev_id)
 {
 	struct ds1307		*ds1307 = dev_id;
 	struct mutex		*lock = &ds1307->rtc->ops_lock;
-	int			stat, control, ret;
+	int			stat, ret;
 
 	mutex_lock(lock);
 	ret = regmap_read(ds1307->regmap, DS1337_REG_STATUS, &stat);
@@ -258,13 +258,11 @@ static irqreturn_t ds1307_irq(int irq, void *dev_id)
 		stat &= ~DS1337_BIT_A1I;
 		regmap_write(ds1307->regmap, DS1337_REG_STATUS, stat);
 
-		ret = regmap_read(ds1307->regmap, DS1337_REG_CONTROL, &control);
+		ret = regmap_update_bits(ds1307->regmap, DS1337_REG_CONTROL,
+					 DS1337_BIT_A1IE, 0);
 		if (ret)
 			goto out;
 
-		control &= ~DS1337_BIT_A1IE;
-		regmap_write(ds1307->regmap, DS1337_REG_CONTROL, control);
-
 		rtc_update_irq(ds1307->rtc, 1, RTC_AF | RTC_IRQF);
 	}
 
@@ -517,21 +515,13 @@ static int ds1337_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 static int ds1307_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
 	struct ds1307		*ds1307 = dev_get_drvdata(dev);
-	int			control, ret;
 
 	if (!test_bit(HAS_ALARM, &ds1307->flags))
 		return -ENOTTY;
 
-	ret = regmap_read(ds1307->regmap, DS1337_REG_CONTROL, &control);
-	if (ret)
-		return ret;
-
-	if (enabled)
-		control |= DS1337_BIT_A1IE;
-	else
-		control &= ~DS1337_BIT_A1IE;
-
-	return regmap_write(ds1307->regmap, DS1337_REG_CONTROL, control);
+	return regmap_update_bits(ds1307->regmap, DS1337_REG_CONTROL,
+				  DS1337_BIT_A1IE,
+				  enabled ? DS1337_BIT_A1IE : 0);
 }
 
 static const struct rtc_class_ops ds13xx_rtc_ops = {
@@ -586,11 +576,8 @@ static irqreturn_t mcp794xx_irq(int irq, void *dev_id)
 		goto out;
 
 	/* Disable alarm 0. */
-	ret = regmap_read(ds1307->regmap, MCP794XX_REG_CONTROL, &reg);
-	if (ret)
-		goto out;
-	reg &= ~MCP794XX_BIT_ALM0_EN;
-	ret = regmap_write(ds1307->regmap, MCP794XX_REG_CONTROL, reg);
+	ret = regmap_update_bits(ds1307->regmap, MCP794XX_REG_CONTROL,
+				 MCP794XX_BIT_ALM0_EN, 0);
 	if (ret)
 		goto out;
 
@@ -688,21 +675,13 @@ static int mcp794xx_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 static int mcp794xx_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
 	struct ds1307 *ds1307 = dev_get_drvdata(dev);
-	int reg, ret;
 
 	if (!test_bit(HAS_ALARM, &ds1307->flags))
 		return -EINVAL;
 
-	ret = regmap_read(ds1307->regmap, MCP794XX_REG_CONTROL, &reg);
-	if (ret)
-		return ret;
-
-	if (enabled)
-		reg |= MCP794XX_BIT_ALM0_EN;
-	else
-		reg &= ~MCP794XX_BIT_ALM0_EN;
-
-	return regmap_write(ds1307->regmap, MCP794XX_REG_CONTROL, reg);
+	return regmap_update_bits(ds1307->regmap, MCP794XX_REG_CONTROL,
+				  MCP794XX_BIT_ALM0_EN,
+				  enabled ? MCP794XX_BIT_ALM0_EN : 0);
 }
 
 static const struct rtc_class_ops mcp794xx_rtc_ops = {
@@ -905,20 +884,11 @@ static int ds3231_clk_sqw_rates[] = {
 static int ds1337_write_control(struct ds1307 *ds1307, u8 mask, u8 value)
 {
 	struct mutex *lock = &ds1307->rtc->ops_lock;
-	int control;
 	int ret;
 
 	mutex_lock(lock);
-
-	ret = regmap_read(ds1307->regmap, DS1337_REG_CONTROL, &control);
-	if (ret)
-		goto out;
-
-	control &= ~mask;
-	control |= value;
-
-	ret = regmap_write(ds1307->regmap, DS1337_REG_CONTROL, control);
-out:
+	ret = regmap_update_bits(ds1307->regmap, DS1337_REG_CONTROL,
+				 mask, value);
 	mutex_unlock(lock);
 
 	return ret;
@@ -1024,22 +994,12 @@ static unsigned long ds3231_clk_32khz_recalc_rate(struct clk_hw *hw,
 static int ds3231_clk_32khz_control(struct ds1307 *ds1307, bool enable)
 {
 	struct mutex *lock = &ds1307->rtc->ops_lock;
-	int status;
 	int ret;
 
 	mutex_lock(lock);
-
-	ret = regmap_read(ds1307->regmap, DS1337_REG_STATUS, &status);
-	if (ret)
-		goto out;
-
-	if (enable)
-		status |= DS3231_BIT_EN32KHZ;
-	else
-		status &= ~DS3231_BIT_EN32KHZ;
-
-	ret = regmap_write(ds1307->regmap, DS1337_REG_STATUS, status);
-out:
+	ret = regmap_update_bits(ds1307->regmap, DS1337_REG_STATUS,
+				 DS3231_BIT_EN32KHZ,
+				 enable ? DS3231_BIT_EN32KHZ : 0);
 	mutex_unlock(lock);
 
 	return ret;
@@ -1495,12 +1455,10 @@ static int ds1307_probe(struct i2c_client *client,
 	 * If different then set the wday which we computed using
 	 * timestamp
 	 */
-	if (wday != tm.tm_wday) {
-		regmap_read(ds1307->regmap, MCP794XX_REG_WEEKDAY, &wday);
-		wday = wday & ~MCP794XX_REG_WEEKDAY_WDAY_MASK;
-		wday = wday | (tm.tm_wday + 1);
-		regmap_write(ds1307->regmap, MCP794XX_REG_WEEKDAY, wday);
-	}
+	if (wday != tm.tm_wday)
+		regmap_update_bits(ds1307->regmap, MCP794XX_REG_WEEKDAY,
+				   MCP794XX_REG_WEEKDAY_WDAY_MASK,
+				   tm.tm_wday + 1);
 
 	if (want_irq) {
 		device_set_wakeup_capable(ds1307->dev, true);
-- 
2.13.0
