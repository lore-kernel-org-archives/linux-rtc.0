Return-Path: <SRS0=JgwP=RJ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087BCC10F0E
	for <linux-rtc@archiver.kernel.org>; Wed,  6 Mar 2019 09:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EDA20828
	for <linux-rtc@archiver.kernel.org>; Wed,  6 Mar 2019 09:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfCFJvl (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:51:41 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:33603 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729754AbfCFJvk (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 6 Mar 2019 04:51:40 -0500
X-Originating-IP: 90.42.94.156
Received: from localhost (alyon-652-1-90-156.w90-42.abo.wanadoo.fr [90.42.94.156])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 8B0DC40018;
        Wed,  6 Mar 2019 09:51:38 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/3] rtc: abx80x: use rtc_add_group
Date:   Wed,  6 Mar 2019 10:51:33 +0100
Message-Id: <20190306095134.18550-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190306095134.18550-1-alexandre.belloni@bootlin.com>
References: <20190306095134.18550-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Use rtc_add_group to add the sysfs group in a race free manner.
This has the side effect of moving the files to their proper location.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-abx80x.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 8e7eb08281f7..90f25ac78abc 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -401,7 +401,7 @@ static ssize_t autocalibration_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	retval = abx80x_rtc_set_autocalibration(dev, autocalibration);
+	retval = abx80x_rtc_set_autocalibration(dev->parent, autocalibration);
 
 	return retval ? retval : count;
 }
@@ -411,7 +411,7 @@ static ssize_t autocalibration_show(struct device *dev,
 {
 	int autocalibration = 0;
 
-	autocalibration = abx80x_rtc_get_autocalibration(dev);
+	autocalibration = abx80x_rtc_get_autocalibration(dev->parent);
 	if (autocalibration < 0) {
 		dev_err(dev, "Failed to read RTC autocalibration\n");
 		sprintf(buf, "0\n");
@@ -427,7 +427,7 @@ static ssize_t oscillator_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct i2c_client *client = to_i2c_client(dev->parent);
 	int retval, flags, rc_mode = 0;
 
 	if (strncmp(buf, "rc", 2) == 0) {
@@ -469,7 +469,7 @@ static ssize_t oscillator_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	int rc_mode = 0;
-	struct i2c_client *client = to_i2c_client(dev);
+	struct i2c_client *client = to_i2c_client(dev->parent);
 
 	rc_mode = abx80x_is_rc_mode(client);
 
@@ -589,13 +589,6 @@ static int abx80x_dt_trickle_cfg(struct device_node *np)
 	return (trickle_cfg | i);
 }
 
-static void rtc_calib_remove_sysfs_group(void *_dev)
-{
-	struct device *dev = _dev;
-
-	sysfs_remove_group(&dev->kobj, &rtc_calib_attr_group);
-}
-
 #ifdef CONFIG_WATCHDOG
 
 static inline u8 timeout_bits(unsigned int timeout)
@@ -848,27 +841,14 @@ static int abx80x_probe(struct i2c_client *client,
 		}
 	}
 
-	/* Export sysfs entries */
-	err = sysfs_create_group(&(&client->dev)->kobj, &rtc_calib_attr_group);
+	err = rtc_add_group(priv->rtc, &rtc_calib_attr_group);
 	if (err) {
 		dev_err(&client->dev, "Failed to create sysfs group: %d\n",
 			err);
 		return err;
 	}
 
-	err = devm_add_action_or_reset(&client->dev,
-				       rtc_calib_remove_sysfs_group,
-				       &client->dev);
-	if (err) {
-		dev_err(&client->dev,
-			"Failed to add sysfs cleanup action: %d\n",
-			err);
-		return err;
-	}
-
-	err = rtc_register_device(priv->rtc);
-
-	return err;
+	return rtc_register_device(priv->rtc);
 }
 
 static int abx80x_remove(struct i2c_client *client)
-- 
2.20.1

