Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2FEC433ED
	for <linux-rtc@archiver.kernel.org>; Sun, 18 Apr 2021 00:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEDD60FF3
	for <linux-rtc@archiver.kernel.org>; Sun, 18 Apr 2021 00:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhDRAU4 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 17 Apr 2021 20:20:56 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:55003 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbhDRAU4 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 17 Apr 2021 20:20:56 -0400
X-Originating-IP: 90.65.108.55
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id DE64DE0005;
        Sun, 18 Apr 2021 00:20:27 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] rtc: pcf8523: report oscillator failures
Date:   Sun, 18 Apr 2021 02:20:23 +0200
Message-Id: <20210418002023.1000265-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210418002023.1000265-1-alexandre.belloni@bootlin.com>
References: <20210418002023.1000265-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Report oscillator failures and invalid date/time on RTC_VL_READ.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf8523.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
index feadab8e3bd3..bb23379bbfc7 100644
--- a/drivers/rtc/rtc-pcf8523.c
+++ b/drivers/rtc/rtc-pcf8523.c
@@ -406,6 +406,8 @@ static int pcf8523_rtc_ioctl(struct device *dev, unsigned int cmd,
 			     unsigned long arg)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	unsigned int flags = 0;
+	u8 value;
 	int ret;
 
 	switch (cmd) {
@@ -414,9 +416,16 @@ static int pcf8523_rtc_ioctl(struct device *dev, unsigned int cmd,
 		if (ret < 0)
 			return ret;
 		if (ret)
-			ret = RTC_VL_BACKUP_LOW;
+			flags |= RTC_VL_BACKUP_LOW;
+
+		ret = pcf8523_read(client, REG_SECONDS, &value);
+		if (ret < 0)
+			return ret;
+
+		if (value & REG_SECONDS_OS)
+			flags |= RTC_VL_DATA_INVALID;
 
-		return put_user(ret, (unsigned int __user *)arg);
+		return put_user(flags, (unsigned int __user *)arg);
 
 	default:
 		return -ENOIOCTLCMD;
-- 
2.30.2

