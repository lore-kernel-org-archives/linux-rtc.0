Return-Path: <SRS0=47cv=RQ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EBCC4360F
	for <linux-rtc@archiver.kernel.org>; Wed, 13 Mar 2019 21:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACDF2070D
	for <linux-rtc@archiver.kernel.org>; Wed, 13 Mar 2019 21:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfCMVFC (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:05:02 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59501 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfCMVFB (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 13 Mar 2019 17:05:01 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 0134360002;
        Wed, 13 Mar 2019 21:04:59 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/5] rtc: ab-b5ze-s3: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Wed, 13 Mar 2019 22:04:54 +0100
Message-Id: <20190313210456.8495-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313210456.8495-1-alexandre.belloni@bootlin.com>
References: <20190313210456.8495-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Call the 64bit versions of rtc_time_to_tm as the range is enforced by the
core.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ab-b5ze-s3.c | 37 +++++++++---------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/rtc/rtc-ab-b5ze-s3.c b/drivers/rtc/rtc-ab-b5ze-s3.c
index 223e0124b087..398bb7b85a4d 100644
--- a/drivers/rtc/rtc-ab-b5ze-s3.c
+++ b/drivers/rtc/rtc-ab-b5ze-s3.c
@@ -332,9 +332,7 @@ static int _abb5zes3_rtc_read_timer(struct device *dev,
 		return ret;
 
 	/* ... convert to seconds ... */
-	ret = rtc_tm_to_time(&rtc_tm, &rtc_secs);
-	if (ret)
-		return ret;
+	rtc_secs = rtc_tm_to_time64(&rtc_tm);
 
 	/* ... add remaining timer A time ... */
 	ret = sec_from_timer_a(&timer_secs, regs[1], regs[2]);
@@ -342,7 +340,7 @@ static int _abb5zes3_rtc_read_timer(struct device *dev,
 		return ret;
 
 	/* ... and convert back. */
-	rtc_time_to_tm(rtc_secs + timer_secs, alarm_tm);
+	rtc_time64_to_tm(rtc_secs + timer_secs, alarm_tm);
 
 	ret = regmap_read(data->regmap, ABB5ZES3_REG_CTRL2, &reg);
 	if (ret) {
@@ -393,13 +391,8 @@ static int _abb5zes3_rtc_read_alarm(struct device *dev,
 	alarm_tm->tm_year = rtc_tm.tm_year;
 	alarm_tm->tm_mon = rtc_tm.tm_mon;
 
-	ret = rtc_tm_to_time(&rtc_tm, &rtc_secs);
-	if (ret)
-		return ret;
-
-	ret = rtc_tm_to_time(alarm_tm, &alarm_secs);
-	if (ret)
-		return ret;
+	rtc_secs = rtc_tm_to_time64(&rtc_tm);
+	alarm_secs = rtc_tm_to_time64(alarm_tm);
 
 	if (alarm_secs < rtc_secs) {
 		if (alarm_tm->tm_mon == 11) {
@@ -462,13 +455,8 @@ static int _abb5zes3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	if (ret)
 		return ret;
 
-	ret = rtc_tm_to_time(&rtc_tm, &rtc_secs);
-	if (ret)
-		return ret;
-
-	ret = rtc_tm_to_time(alarm_tm, &alarm_secs);
-	if (ret)
-		return ret;
+	rtc_secs = rtc_tm_to_time64(&rtc_tm);
+	alarm_secs = rtc_tm_to_time64(alarm_tm);
 
 	/* If alarm time is before current time, disable the alarm */
 	if (!alarm->enabled || alarm_secs <= rtc_secs) {
@@ -487,9 +475,7 @@ static int _abb5zes3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 			rtc_tm.tm_mon += 1;
 		}
 
-		ret = rtc_tm_to_time(&rtc_tm, &rtc_secs);
-		if (ret)
-			return ret;
+		rtc_secs = rtc_tm_to_time64(&rtc_tm);
 
 		if (alarm_secs > rtc_secs) {
 			dev_err(dev, "%s: alarm maximum is one month in the "
@@ -574,13 +560,8 @@ static int abb5zes3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	if (ret)
 		return ret;
 
-	ret = rtc_tm_to_time(&rtc_tm, &rtc_secs);
-	if (ret)
-		return ret;
-
-	ret = rtc_tm_to_time(alarm_tm, &alarm_secs);
-	if (ret)
-		return ret;
+	rtc_secs = rtc_tm_to_time64(&rtc_tm);
+	alarm_secs = rtc_tm_to_time64(alarm_tm);
 
 	/* Let's first disable both the alarm and the timer interrupts */
 	ret = _abb5zes3_rtc_update_alarm(dev, false);
-- 
2.20.1

