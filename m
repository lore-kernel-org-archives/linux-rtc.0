Return-Path: <SRS0=47cv=RQ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83463C43381
	for <linux-rtc@archiver.kernel.org>; Wed, 13 Mar 2019 21:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4962070D
	for <linux-rtc@archiver.kernel.org>; Wed, 13 Mar 2019 21:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfCMVFB (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:05:01 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:38013 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfCMVFB (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 13 Mar 2019 17:05:01 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id EA0B660006;
        Wed, 13 Mar 2019 21:04:58 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/5] rtc: ab-b5ze-s3: remove mutex
Date:   Wed, 13 Mar 2019 22:04:52 +0100
Message-Id: <20190313210456.8495-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The rtc_ops are already called with the RTC mutex locked so there is no
need to have a separate lock, unless it is used in the irq handler.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ab-b5ze-s3.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-ab-b5ze-s3.c b/drivers/rtc/rtc-ab-b5ze-s3.c
index 2233601761ac..1b7314843dc8 100644
--- a/drivers/rtc/rtc-ab-b5ze-s3.c
+++ b/drivers/rtc/rtc-ab-b5ze-s3.c
@@ -22,7 +22,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/rtc.h>
 #include <linux/i2c.h>
 #include <linux/bcd.h>
@@ -128,7 +127,6 @@
 struct abb5zes3_rtc_data {
 	struct rtc_device *rtc;
 	struct regmap *regmap;
-	struct mutex lock;
 
 	int irq;
 
@@ -138,8 +136,7 @@ struct abb5zes3_rtc_data {
 
 /*
  * Try and match register bits w/ fixed null values to see whether we
- * are dealing with an ABB5ZES3. Note: this function is called early
- * during init and hence does need mutex protection.
+ * are dealing with an ABB5ZES3.
  */
 static int abb5zes3_i2c_validate_chip(struct regmap *regmap)
 {
@@ -273,12 +270,9 @@ static int abb5zes3_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	regs[ABB5ZES3_REG_RTC_MO] = bin2bcd(tm->tm_mon + 1);
 	regs[ABB5ZES3_REG_RTC_YR] = bin2bcd(tm->tm_year - 100);
 
-	mutex_lock(&data->lock);
 	ret = regmap_bulk_write(data->regmap, ABB5ZES3_REG_RTC_SC,
 				regs + ABB5ZES3_REG_RTC_SC,
 				ABB5ZES3_RTC_SEC_LEN);
-	mutex_unlock(&data->lock);
-
 
 	return ret;
 }
@@ -447,12 +441,10 @@ static int abb5zes3_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	struct abb5zes3_rtc_data *data = dev_get_drvdata(dev);
 	int ret;
 
-	mutex_lock(&data->lock);
 	if (data->timer_alarm)
 		ret = _abb5zes3_rtc_read_timer(dev, alarm);
 	else
 		ret = _abb5zes3_rtc_read_alarm(dev, alarm);
-	mutex_unlock(&data->lock);
 
 	return ret;
 }
@@ -590,7 +582,6 @@ static int abb5zes3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	struct rtc_time rtc_tm;
 	int ret;
 
-	mutex_lock(&data->lock);
 	ret = _abb5zes3_rtc_read_time(dev, &rtc_tm);
 	if (ret)
 		goto err;
@@ -630,8 +621,6 @@ static int abb5zes3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 		ret = _abb5zes3_rtc_set_alarm(dev, alarm);
 
  err:
-	mutex_unlock(&data->lock);
-
 	if (ret)
 		dev_err(dev, "%s: unable to configure alarm (%d)\n", __func__,
 			ret);
@@ -650,8 +639,7 @@ static inline int _abb5zes3_rtc_battery_low_irq_enable(struct regmap *regmap,
 
 /*
  * Check current RTC status and enable/disable what needs to be. Return 0 if
- * everything went ok and a negative value upon error. Note: this function
- * is called early during init and hence does need mutex protection.
+ * everything went ok and a negative value upon error.
  */
 static int abb5zes3_rtc_check_setup(struct device *dev)
 {
@@ -788,12 +776,10 @@ static int abb5zes3_rtc_alarm_irq_enable(struct device *dev,
 	int ret = 0;
 
 	if (rtc_data->irq) {
-		mutex_lock(&rtc_data->lock);
 		if (rtc_data->timer_alarm)
 			ret = _abb5zes3_rtc_update_timer(dev, enable);
 		else
 			ret = _abb5zes3_rtc_update_alarm(dev, enable);
-		mutex_unlock(&rtc_data->lock);
 	}
 
 	return ret;
@@ -908,7 +894,6 @@ static int abb5zes3_probe(struct i2c_client *client,
 		goto err;
 	}
 
-	mutex_init(&data->lock);
 	data->regmap = regmap;
 	dev_set_drvdata(dev, data);
 
-- 
2.20.1

