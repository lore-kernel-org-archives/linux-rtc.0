Return-Path: <SRS0=47cv=RQ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E05FC43381
	for <linux-rtc@archiver.kernel.org>; Wed, 13 Mar 2019 21:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2152070D
	for <linux-rtc@archiver.kernel.org>; Wed, 13 Mar 2019 21:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfCMVFD (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:05:03 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:37323 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfCMVFD (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 13 Mar 2019 17:05:03 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 09A9D60003;
        Wed, 13 Mar 2019 21:05:00 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5/5] rtc: ab-b5ze-s3: remove unnecessary check
Date:   Wed, 13 Mar 2019 22:04:56 +0100
Message-Id: <20190313210456.8495-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313210456.8495-1-alexandre.belloni@bootlin.com>
References: <20190313210456.8495-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The core already checks that the alarm is set in the future. IT is not
necessary to do it again in the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ab-b5ze-s3.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-ab-b5ze-s3.c b/drivers/rtc/rtc-ab-b5ze-s3.c
index 65de9cf4a48d..ef895ae431c1 100644
--- a/drivers/rtc/rtc-ab-b5ze-s3.c
+++ b/drivers/rtc/rtc-ab-b5ze-s3.c
@@ -438,28 +438,25 @@ static int _abb5zes3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	struct abb5zes3_rtc_data *data = dev_get_drvdata(dev);
 	struct rtc_time *alarm_tm = &alarm->time;
-	unsigned long rtc_secs, alarm_secs;
 	u8 regs[ABB5ZES3_ALRM_SEC_LEN];
 	struct rtc_time rtc_tm;
 	int ret, enable = 1;
 
-	ret = _abb5zes3_rtc_read_time(dev, &rtc_tm);
-	if (ret)
-		return ret;
-
-	rtc_secs = rtc_tm_to_time64(&rtc_tm);
-	alarm_secs = rtc_tm_to_time64(alarm_tm);
-
-	/* If alarm time is before current time, disable the alarm */
-	if (!alarm->enabled || alarm_secs <= rtc_secs) {
+	if (!alarm->enabled) {
 		enable = 0;
 	} else {
+		unsigned long rtc_secs, alarm_secs;
+
 		/*
 		 * Chip only support alarms up to one month in the future. Let's
 		 * return an error if we get something after that limit.
 		 * Comparison is done by incrementing rtc_tm month field by one
 		 * and checking alarm value is still below.
 		 */
+		ret = _abb5zes3_rtc_read_time(dev, &rtc_tm);
+		if (ret)
+			return ret;
+
 		if (rtc_tm.tm_mon == 11) { /* handle year wrapping */
 			rtc_tm.tm_mon = 0;
 			rtc_tm.tm_year += 1;
@@ -468,6 +465,7 @@ static int _abb5zes3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 		}
 
 		rtc_secs = rtc_tm_to_time64(&rtc_tm);
+		alarm_secs = rtc_tm_to_time64(alarm_tm);
 
 		if (alarm_secs > rtc_secs) {
 			dev_err(dev, "%s: alarm maximum is one month in the "
-- 
2.20.1

