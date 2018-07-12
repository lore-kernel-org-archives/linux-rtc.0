Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:56132 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbeGLKbl (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 12 Jul 2018 06:31:41 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: fix alarm read and set offset
Date: Thu, 12 Jul 2018 12:22:44 +0200
Message-Id: <20180712102244.12162-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The offset needs to be added after reading the alarm value.

It also needs to be subtracted after the now < alarm test.

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/interface.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 6d4012dd6922..bac1eeb3d312 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -265,8 +265,10 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 			return err;
 
 		/* full-function RTCs won't have such missing fields */
-		if (rtc_valid_tm(&alarm->time) == 0)
+		if (rtc_valid_tm(&alarm->time) == 0) {
+			rtc_add_offset(rtc, &alarm->time);
 			return 0;
+		}
 
 		/* get the "after" timestamp, to detect wrapped fields */
 		err = rtc_read_time(rtc, &now);
@@ -409,7 +411,6 @@ static int __rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	if (err)
 		return err;
 
-	rtc_subtract_offset(rtc, &alarm->time);
 	scheduled = rtc_tm_to_time64(&alarm->time);
 
 	/* Make sure we're not setting alarms in the past */
@@ -426,6 +427,8 @@ static int __rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	 * over right here, before we set the alarm.
 	 */
 
+	rtc_subtract_offset(rtc, &alarm->time);
+
 	if (!rtc->ops)
 		err = -ENODEV;
 	else if (!rtc->ops->set_alarm)
@@ -467,7 +470,6 @@ int rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 
 	mutex_unlock(&rtc->ops_lock);
 
-	rtc_add_offset(rtc, &alarm->time);
 	return err;
 }
 EXPORT_SYMBOL_GPL(rtc_set_alarm);
-- 
2.18.0
