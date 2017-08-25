Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33681 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932771AbdHYUGg (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 25 Aug 2017 16:06:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id e67so844263wmd.0
        for <linux-rtc@vger.kernel.org>; Fri, 25 Aug 2017 13:06:36 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 3/5] rtc: ds1307: factor out fixing the weekday
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <cb381496-4d55-996d-e2ae-18880330e386@gmail.com>
Message-ID: <b2ffce23-6c19-e073-d8c4-691ca62e80f1@gmail.com>
Date: Fri, 25 Aug 2017 22:06:15 +0200
MIME-Version: 1.0
In-Reply-To: <cb381496-4d55-996d-e2ae-18880330e386@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Factor out checking and fixing the weekday.

In addition fix two issues with the old implementation:
- For variable timestamp use correct type time64_t instead of
  unsigned long which may be just 32bit long.
- Updating the weekday register only may be racy, therefore write all
  timekeeping registers.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index ea88e4b3..69f514b6 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1368,6 +1368,29 @@ static void ds1307_trickle_init(struct ds1307 *ds1307)
 	}
 }
 
+static void ds1307_fix_weekday(struct ds1307 *ds1307)
+{
+	struct rtc_time tm;
+	time64_t timestamp;
+	int wday;
+
+	if (ds1307_get_time(ds1307->dev, &tm))
+		return;
+
+	wday = tm.tm_wday;
+	timestamp = rtc_tm_to_time64(&tm);
+	rtc_time64_to_tm(timestamp, &tm);
+
+	/*
+	 * Check if reset wday is different from the computed wday
+	 * If different then set the wday which we computed using
+	 * timestamp
+	 * Set not only wday but complete date to avoid potential races.
+	 */
+	if (wday != tm.tm_wday)
+		ds1307_set_time(ds1307->dev, &tm);
+}
+
 static const struct regmap_config regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -1378,13 +1401,11 @@ static int ds1307_probe(struct i2c_client *client,
 {
 	struct ds1307		*ds1307;
 	int			err = -ENODEV;
-	int			tmp, wday;
+	int			tmp;
 	const struct chip_desc	*chip;
 	bool			want_irq;
 	bool			ds1307_can_wakeup_device = false;
 	unsigned char		*buf;
-	struct rtc_time		tm;
-	unsigned long		timestamp;
 
 	ds1307 = devm_kzalloc(&client->dev, sizeof(struct ds1307), GFP_KERNEL);
 	if (!ds1307)
@@ -1642,20 +1663,7 @@ static int ds1307_probe(struct i2c_client *client,
 	 * Some IPs have weekday reset value = 0x1 which might not correct
 	 * hence compute the wday using the current date/month/year values
 	 */
-	ds1307_get_time(ds1307->dev, &tm);
-	wday = tm.tm_wday;
-	timestamp = rtc_tm_to_time64(&tm);
-	rtc_time64_to_tm(timestamp, &tm);
-
-	/*
-	 * Check if reset wday is different from the computed wday
-	 * If different then set the wday which we computed using
-	 * timestamp
-	 */
-	if (wday != tm.tm_wday)
-		regmap_update_bits(ds1307->regmap, MCP794XX_REG_WEEKDAY,
-				   MCP794XX_REG_WEEKDAY_WDAY_MASK,
-				   tm.tm_wday + 1);
+	ds1307_fix_weekday(ds1307);
 
 	if (want_irq || ds1307_can_wakeup_device) {
 		device_set_wakeup_capable(ds1307->dev, true);
-- 
2.14.1
