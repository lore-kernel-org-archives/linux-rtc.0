Return-Path: <SRS0=47cv=RQ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D94C10F03
	for <linux-rtc@archiver.kernel.org>; Wed, 13 Mar 2019 21:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2ABD2070D
	for <linux-rtc@archiver.kernel.org>; Wed, 13 Mar 2019 21:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfCMVFB (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:05:01 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:48811 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfCMVFB (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 13 Mar 2019 17:05:01 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 73C231C0003;
        Wed, 13 Mar 2019 21:04:59 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/5] rtc: ab-b5ze-s3: remove unnecessary gotos
Date:   Wed, 13 Mar 2019 22:04:53 +0100
Message-Id: <20190313210456.8495-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313210456.8495-1-alexandre.belloni@bootlin.com>
References: <20190313210456.8495-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Rework error handling to remove unnecessary gotos.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ab-b5ze-s3.c | 93 +++++++++++++++---------------------
 1 file changed, 38 insertions(+), 55 deletions(-)

diff --git a/drivers/rtc/rtc-ab-b5ze-s3.c b/drivers/rtc/rtc-ab-b5ze-s3.c
index 1b7314843dc8..223e0124b087 100644
--- a/drivers/rtc/rtc-ab-b5ze-s3.c
+++ b/drivers/rtc/rtc-ab-b5ze-s3.c
@@ -227,14 +227,12 @@ static int _abb5zes3_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	if (ret) {
 		dev_err(dev, "%s: reading RTC time failed (%d)\n",
 			__func__, ret);
-		goto err;
+		return ret;
 	}
 
 	/* If clock integrity is not guaranteed, do not return a time value */
-	if (regs[ABB5ZES3_REG_RTC_SC] & ABB5ZES3_REG_RTC_SC_OSC) {
-		ret = -ENODATA;
-		goto err;
-	}
+	if (regs[ABB5ZES3_REG_RTC_SC] & ABB5ZES3_REG_RTC_SC_OSC)
+		return -ENODATA;
 
 	tm->tm_sec = bcd2bin(regs[ABB5ZES3_REG_RTC_SC] & 0x7F);
 	tm->tm_min = bcd2bin(regs[ABB5ZES3_REG_RTC_MN]);
@@ -252,7 +250,6 @@ static int _abb5zes3_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	tm->tm_mon  = bcd2bin(regs[ABB5ZES3_REG_RTC_MO]) - 1; /* starts at 1 */
 	tm->tm_year = bcd2bin(regs[ABB5ZES3_REG_RTC_YR]) + 100;
 
-err:
 	return ret;
 }
 
@@ -326,23 +323,23 @@ static int _abb5zes3_rtc_read_timer(struct device *dev,
 	if (ret) {
 		dev_err(dev, "%s: reading Timer A section failed (%d)\n",
 			__func__, ret);
-		goto err;
+		return ret;
 	}
 
 	/* get current time ... */
 	ret = _abb5zes3_rtc_read_time(dev, &rtc_tm);
 	if (ret)
-		goto err;
+		return ret;
 
 	/* ... convert to seconds ... */
 	ret = rtc_tm_to_time(&rtc_tm, &rtc_secs);
 	if (ret)
-		goto err;
+		return ret;
 
 	/* ... add remaining timer A time ... */
 	ret = sec_from_timer_a(&timer_secs, regs[1], regs[2]);
 	if (ret)
-		goto err;
+		return ret;
 
 	/* ... and convert back. */
 	rtc_time_to_tm(rtc_secs + timer_secs, alarm_tm);
@@ -351,13 +348,12 @@ static int _abb5zes3_rtc_read_timer(struct device *dev,
 	if (ret) {
 		dev_err(dev, "%s: reading ctrl reg failed (%d)\n",
 			__func__, ret);
-		goto err;
+		return ret;
 	}
 
 	alarm->enabled = !!(reg & ABB5ZES3_REG_CTRL2_WTAIE);
 
-err:
-	return ret;
+	return 0;
 }
 
 /* Read alarm currently configured via a RTC alarm registers. */
@@ -376,7 +372,7 @@ static int _abb5zes3_rtc_read_alarm(struct device *dev,
 	if (ret) {
 		dev_err(dev, "%s: reading alarm section failed (%d)\n",
 			__func__, ret);
-		goto err;
+		return ret;
 	}
 
 	alarm_tm->tm_sec  = 0;
@@ -392,18 +388,18 @@ static int _abb5zes3_rtc_read_alarm(struct device *dev,
 	 */
 	ret = _abb5zes3_rtc_read_time(dev, &rtc_tm);
 	if (ret)
-		goto err;
+		return ret;
 
 	alarm_tm->tm_year = rtc_tm.tm_year;
 	alarm_tm->tm_mon = rtc_tm.tm_mon;
 
 	ret = rtc_tm_to_time(&rtc_tm, &rtc_secs);
 	if (ret)
-		goto err;
+		return ret;
 
 	ret = rtc_tm_to_time(alarm_tm, &alarm_secs);
 	if (ret)
-		goto err;
+		return ret;
 
 	if (alarm_secs < rtc_secs) {
 		if (alarm_tm->tm_mon == 11) {
@@ -418,13 +414,12 @@ static int _abb5zes3_rtc_read_alarm(struct device *dev,
 	if (ret) {
 		dev_err(dev, "%s: reading ctrl reg failed (%d)\n",
 			__func__, ret);
-		goto err;
+		return ret;
 	}
 
 	alarm->enabled = !!(reg & ABB5ZES3_REG_CTRL1_AIE);
 
-err:
-	return ret;
+	return 0;
 }
 
 /*
@@ -465,15 +460,15 @@ static int _abb5zes3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 
 	ret = _abb5zes3_rtc_read_time(dev, &rtc_tm);
 	if (ret)
-		goto err;
+		return ret;
 
 	ret = rtc_tm_to_time(&rtc_tm, &rtc_secs);
 	if (ret)
-		goto err;
+		return ret;
 
 	ret = rtc_tm_to_time(alarm_tm, &alarm_secs);
 	if (ret)
-		goto err;
+		return ret;
 
 	/* If alarm time is before current time, disable the alarm */
 	if (!alarm->enabled || alarm_secs <= rtc_secs) {
@@ -494,13 +489,12 @@ static int _abb5zes3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 
 		ret = rtc_tm_to_time(&rtc_tm, &rtc_secs);
 		if (ret)
-			goto err;
+			return ret;
 
 		if (alarm_secs > rtc_secs) {
 			dev_err(dev, "%s: alarm maximum is one month in the "
 				"future (%d)\n", __func__, ret);
-			ret = -EINVAL;
-			goto err;
+			return -EINVAL;
 		}
 	}
 
@@ -518,17 +512,14 @@ static int _abb5zes3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	if (ret < 0) {
 		dev_err(dev, "%s: writing ALARM section failed (%d)\n",
 			__func__, ret);
-		goto err;
+		return ret;
 	}
 
 	/* Record currently configured alarm is not a timer */
 	data->timer_alarm = 0;
 
 	/* Enable or disable alarm interrupt generation */
-	ret = _abb5zes3_rtc_update_alarm(dev, enable);
-
-err:
-	return ret;
+	return _abb5zes3_rtc_update_alarm(dev, enable);
 }
 
 /*
@@ -549,7 +540,7 @@ static int _abb5zes3_rtc_set_timer(struct device *dev, struct rtc_wkalrm *alarm,
 				ABB5ZES3_TIMA_SEC_LEN);
 	if (ret < 0) {
 		dev_err(dev, "%s: writing timer section failed\n", __func__);
-		goto err;
+		return ret;
 	}
 
 	/* Configure Timer A as a watchdog timer */
@@ -562,10 +553,7 @@ static int _abb5zes3_rtc_set_timer(struct device *dev, struct rtc_wkalrm *alarm,
 	data->timer_alarm = 1;
 
 	/* Enable or disable timer interrupt generation */
-	ret = _abb5zes3_rtc_update_timer(dev, alarm->enabled);
-
-err:
-	return ret;
+	return _abb5zes3_rtc_update_timer(dev, alarm->enabled);
 }
 
 /*
@@ -584,28 +572,28 @@ static int abb5zes3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 
 	ret = _abb5zes3_rtc_read_time(dev, &rtc_tm);
 	if (ret)
-		goto err;
+		return ret;
 
 	ret = rtc_tm_to_time(&rtc_tm, &rtc_secs);
 	if (ret)
-		goto err;
+		return ret;
 
 	ret = rtc_tm_to_time(alarm_tm, &alarm_secs);
 	if (ret)
-		goto err;
+		return ret;
 
 	/* Let's first disable both the alarm and the timer interrupts */
 	ret = _abb5zes3_rtc_update_alarm(dev, false);
 	if (ret < 0) {
 		dev_err(dev, "%s: unable to disable alarm (%d)\n", __func__,
 			ret);
-		goto err;
+		return ret;
 	}
 	ret = _abb5zes3_rtc_update_timer(dev, false);
 	if (ret < 0) {
 		dev_err(dev, "%s: unable to disable timer (%d)\n", __func__,
 			ret);
-		goto err;
+		return ret;
 	}
 
 	data->timer_alarm = 0;
@@ -620,7 +608,6 @@ static int abb5zes3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	else
 		ret = _abb5zes3_rtc_set_alarm(dev, alarm);
 
- err:
 	if (ret)
 		dev_err(dev, "%s: unable to configure alarm (%d)\n", __func__,
 			ret);
@@ -871,42 +858,38 @@ static int abb5zes3_probe(struct i2c_client *client,
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
 				     I2C_FUNC_SMBUS_BYTE_DATA |
-				     I2C_FUNC_SMBUS_I2C_BLOCK)) {
-		ret = -ENODEV;
-		goto err;
-	}
+				     I2C_FUNC_SMBUS_I2C_BLOCK))
+		return -ENODEV;
 
 	regmap = devm_regmap_init_i2c(client, &abb5zes3_rtc_regmap_config);
 	if (IS_ERR(regmap)) {
 		ret = PTR_ERR(regmap);
 		dev_err(dev, "%s: regmap allocation failed: %d\n",
 			__func__, ret);
-		goto err;
+		return ret;
 	}
 
 	ret = abb5zes3_i2c_validate_chip(regmap);
 	if (ret)
-		goto err;
+		return ret;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!data)
+		return -ENOMEM;
 
 	data->regmap = regmap;
 	dev_set_drvdata(dev, data);
 
 	ret = abb5zes3_rtc_check_setup(dev);
 	if (ret)
-		goto err;
+		return ret;
 
 	data->rtc = devm_rtc_allocate_device(dev);
 	ret = PTR_ERR_OR_ZERO(data->rtc);
 	if (ret) {
 		dev_err(dev, "%s: unable to allocate RTC device (%d)\n",
 			__func__, ret);
-		goto err;
+		return ret;
 	}
 
 	if (client->irq > 0) {
@@ -943,7 +926,7 @@ static int abb5zes3_probe(struct i2c_client *client,
 	ret = rtc_register_device(data->rtc);
 
 err:
-	if (ret && data && data->irq)
+	if (ret && data->irq)
 		device_init_wakeup(dev, false);
 	return ret;
 }
-- 
2.20.1

