Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38544 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbdHZTQp (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 26 Aug 2017 15:16:45 -0400
Received: by mail-wr0-f196.google.com with SMTP id o76so1750676wrb.5
        for <linux-rtc@vger.kernel.org>; Sat, 26 Aug 2017 12:16:44 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] rtc: core: let rtc_set_time properly populate element wday
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
Message-ID: <3b43da73-ff4e-4519-d1c7-266b17cc5d05@gmail.com>
Date: Sat, 26 Aug 2017 21:16:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Some drivers use element wday of the struct rtc_time which is passed to
callback set_time. However element wday may incorrectly or not be
populated if struct rtc_time is coming from userspace via rtc_dev_ioctl.
rtc_valid_tm() doesn't check element wday.

Therefore convert struct rtc_time to time64_t and then use
rtc_time64_to_tm to generate a struct rtc_time with all elements properly
populated.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/rtc/interface.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 8cec9a02..5a53c590 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -59,28 +59,36 @@ EXPORT_SYMBOL_GPL(rtc_read_time);
 
 int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm)
 {
+	time64_t secs64;
 	int err;
 
 	err = rtc_valid_tm(tm);
 	if (err != 0)
 		return err;
 
+	secs64 = rtc_tm_to_time64(tm);
+
 	err = mutex_lock_interruptible(&rtc->ops_lock);
 	if (err)
 		return err;
 
 	if (!rtc->ops)
 		err = -ENODEV;
-	else if (rtc->ops->set_time)
-		err = rtc->ops->set_time(rtc->dev.parent, tm);
-	else if (rtc->ops->set_mmss64) {
-		time64_t secs64 = rtc_tm_to_time64(tm);
-
+	else if (rtc->ops->set_time) {
+		struct rtc_time tmp;
+
+		/*
+		 * element wday of tm may not be set, therefore use
+		 * rtc_time64_to_tm to generate a struct rtc_time
+		 * with all elements being properly populated
+		 */
+		rtc_time64_to_tm(secs64, &tmp);
+		err = rtc->ops->set_time(rtc->dev.parent, &tmp);
+	} else if (rtc->ops->set_mmss64)
 		err = rtc->ops->set_mmss64(rtc->dev.parent, secs64);
-	} else if (rtc->ops->set_mmss) {
-		time64_t secs64 = rtc_tm_to_time64(tm);
+	else if (rtc->ops->set_mmss)
 		err = rtc->ops->set_mmss(rtc->dev.parent, secs64);
-	} else
+	else
 		err = -EINVAL;
 
 	pm_stay_awake(rtc->dev.parent);
-- 
2.14.1
