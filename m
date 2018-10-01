Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:45175 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbeJBEbn (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 2 Oct 2018 00:31:43 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: vr41xx: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date: Mon,  1 Oct 2018 23:51:35 +0200
Message-Id: <20181001215135.5831-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Call the 64bit versions of rtc_time_to_tm now that the range is enforced by
the core.
Also remove the open coded rtc_tm_to_time64.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-vr41xx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index 70f013e692b0..e66d0f63cee2 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -136,8 +136,7 @@ static int vr41xx_rtc_set_time(struct device *dev, struct rtc_time *time)
 	time64_t epoch_sec, current_sec;
 
 	epoch_sec = mktime64(epoch, 1, 1, 0, 0, 0);
-	current_sec = mktime64(time->tm_year + 1900, time->tm_mon + 1, time->tm_mday,
-			     time->tm_hour, time->tm_min, time->tm_sec);
+	current_sec = rtc_tm_to_time64(time);
 
 	write_elapsed_second(current_sec - epoch_sec);
 
@@ -158,7 +157,7 @@ static int vr41xx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 
 	spin_unlock_irq(&rtc_lock);
 
-	rtc_time_to_tm((high << 17) | (mid << 1) | (low >> 15), time);
+	rtc_time64_to_tm((high << 17) | (mid << 1) | (low >> 15), time);
 
 	return 0;
 }
@@ -166,10 +165,8 @@ static int vr41xx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 static int vr41xx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 {
 	time64_t alarm_sec;
-	struct rtc_time *time = &wkalrm->time;
 
-	alarm_sec = mktime64(time->tm_year + 1900, time->tm_mon + 1, time->tm_mday,
-			     time->tm_hour, time->tm_min, time->tm_sec);
+	alarm_sec = rtc_tm_to_time64(&wkalrm->time);
 
 	spin_lock_irq(&rtc_lock);
 
-- 
2.19.0
