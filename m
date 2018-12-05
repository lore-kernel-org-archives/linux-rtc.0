Return-Path: <SRS0=MiQX=OO=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9618CC04EB9
	for <linux-rtc@archiver.kernel.org>; Wed,  5 Dec 2018 15:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C89206B7
	for <linux-rtc@archiver.kernel.org>; Wed,  5 Dec 2018 15:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C89206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbeLEPCG (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:02:06 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:49659 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbeLEPCG (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 5 Dec 2018 10:02:06 -0500
Received: from sapphire.lan (unknown [10.0.4.3])
        by mx.tkos.co.il (Postfix) with ESMTP id 85DB8440869;
        Wed,  5 Dec 2018 17:02:03 +0200 (IST)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, Jon Nettleton <jon@solid-run.com>,
        =?UTF-8?q?Erik=20=C4=8Cuk?= <erik.cuk@domel.com>,
        Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] rtc: pcf8523: don't return invalid date when battery is low
Date:   Wed,  5 Dec 2018 17:00:09 +0200
Message-Id: <35660d21e523f535ac959dc9276f61104820f1bf.1544022009.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The RTC_VL_READ ioctl reports the low battery condition. Still,
pcf8523_rtc_read_time() happily returns invalid dates in this case.
Check the battery health on pcf8523_rtc_read_time() to avoid that.

Reported-by: Erik Čuk <erik.cuk@domel.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/rtc/rtc-pcf8523.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
index 453615f8ac9a..3fcd2cbafc84 100644
--- a/drivers/rtc/rtc-pcf8523.c
+++ b/drivers/rtc/rtc-pcf8523.c
@@ -85,6 +85,18 @@ static int pcf8523_write(struct i2c_client *client, u8 reg, u8 value)
 	return 0;
 }
 
+static int pcf8523_voltage_low(struct i2c_client *client)
+{
+	u8 value;
+	int err;
+
+	err = pcf8523_read(client, REG_CONTROL3, &value);
+	if (err < 0)
+		return err;
+
+	return !!(value & REG_CONTROL3_BLF);
+}
+
 static int pcf8523_select_capacitance(struct i2c_client *client, bool high)
 {
 	u8 value;
@@ -167,6 +179,14 @@ static int pcf8523_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	struct i2c_msg msgs[2];
 	int err;
 
+	err = pcf8523_voltage_low(client);
+	if (err < 0) {
+		return err;
+	} else if (err > 0) {
+		dev_err(dev, "low voltage detected, time is unreliable\n");
+		return -EINVAL;
+	}
+
 	msgs[0].addr = client->addr;
 	msgs[0].flags = 0;
 	msgs[0].len = 1;
@@ -251,17 +271,13 @@ static int pcf8523_rtc_ioctl(struct device *dev, unsigned int cmd,
 			     unsigned long arg)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	u8 value;
-	int ret = 0, err;
+	int ret;
 
 	switch (cmd) {
 	case RTC_VL_READ:
-		err = pcf8523_read(client, REG_CONTROL3, &value);
-		if (err < 0)
-			return err;
-
-		if (value & REG_CONTROL3_BLF)
-			ret = 1;
+		ret = pcf8523_voltage_low(client);
+		if (ret < 0)
+			return ret;
 
 		if (copy_to_user((void __user *)arg, &ret, sizeof(int)))
 			return -EFAULT;
-- 
2.19.2

