Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34910 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755534AbeAHGFX (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 8 Jan 2018 01:05:23 -0500
Received: by mail-pg0-f68.google.com with SMTP id d6so3852500pgv.2
        for <linux-rtc@vger.kernel.org>; Sun, 07 Jan 2018 22:05:23 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: arnd@arndb.de, broonie@kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolin.wang@linaro.org
Subject: [PATCH 2/3] rtc: Factor out the RTC range validation into rtc_valid_range()
Date: Mon,  8 Jan 2018 14:04:49 +0800
Message-Id: <ac45b2b55c1af9fa6d8c45904ff89fb83ffd6113.1515390560.git.baolin.wang@linaro.org>
In-Reply-To: <f64a09a864c00955eb994a0c03c503795adb0eee.1515390560.git.baolin.wang@linaro.org>
References: <f64a09a864c00955eb994a0c03c503795adb0eee.1515390560.git.baolin.wang@linaro.org>
In-Reply-To: <f64a09a864c00955eb994a0c03c503795adb0eee.1515390560.git.baolin.wang@linaro.org>
References: <f64a09a864c00955eb994a0c03c503795adb0eee.1515390560.git.baolin.wang@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The RTC range validation code can be factored into rtc_valid_range()
function to avoid duplicate code.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/rtc/interface.c |   30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 028dc16..55ada51 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -20,6 +20,18 @@
 static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *timer);
 static void rtc_timer_remove(struct rtc_device *rtc, struct rtc_timer *timer);
 
+static int rtc_valid_range(struct rtc_device *rtc, struct rtc_time *tm)
+{
+	if (rtc->range_min != rtc->range_max) {
+		time64_t time = rtc_tm_to_time64(tm);
+
+		if (time < rtc->range_min || time > rtc->range_max)
+			return -ERANGE;
+	}
+
+	return 0;
+}
+
 static int __rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm)
 {
 	int err;
@@ -65,12 +77,9 @@ int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm)
 	if (err != 0)
 		return err;
 
-	if (rtc->range_min != rtc->range_max) {
-		time64_t time = rtc_tm_to_time64(tm);
-
-		if (time < rtc->range_min || time > rtc->range_max)
-			return -ERANGE;
-	}
+	err = rtc_valid_range(rtc, tm);
+	if (err)
+		return err;
 
 	err = mutex_lock_interruptible(&rtc->ops_lock);
 	if (err)
@@ -370,12 +379,9 @@ int rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	if (err != 0)
 		return err;
 
-	if (rtc->range_min != rtc->range_max) {
-		time64_t time = rtc_tm_to_time64(&alarm->time);
-
-		if (time < rtc->range_min || time > rtc->range_max)
-			return -ERANGE;
-	}
+	err = rtc_valid_range(rtc, &alarm->time);
+	if (err)
+		return err;
 
 	err = mutex_lock_interruptible(&rtc->ops_lock);
 	if (err)
-- 
1.7.9.5
