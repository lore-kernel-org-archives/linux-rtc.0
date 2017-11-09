Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:47096 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752693AbdKIHJo (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 9 Nov 2017 02:09:44 -0500
Received: by mail-pg0-f66.google.com with SMTP id t10so2980748pgo.3
        for <linux-rtc@vger.kernel.org>; Wed, 08 Nov 2017 23:09:44 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH] rtc: Use time64_t variables to set time/alarm from sysfs
Date: Thu,  9 Nov 2017 15:09:20 +0800
Message-Id: <672d468478f3f67ef22e027460c59918dc581818.1510211132.git.baolin.wang@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use time64_t variables and related APIs for sysfs interfaces to
support setting time or alarm after the year 2038 on 32-bit system.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/rtc/rtc-sysfs.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/rtc-sysfs.c
index e364550..92ff2ed 100644
--- a/drivers/rtc/rtc-sysfs.c
+++ b/drivers/rtc/rtc-sysfs.c
@@ -72,9 +72,10 @@
 
 	retval = rtc_read_time(to_rtc_device(dev), &tm);
 	if (retval == 0) {
-		unsigned long time;
-		rtc_tm_to_time(&tm, &time);
-		retval = sprintf(buf, "%lu\n", time);
+		time64_t time;
+
+		time = rtc_tm_to_time64(&tm);
+		retval = sprintf(buf, "%lld\n", time);
 	}
 
 	return retval;
@@ -132,7 +133,7 @@
 wakealarm_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	ssize_t retval;
-	unsigned long alarm;
+	time64_t alarm;
 	struct rtc_wkalrm alm;
 
 	/* Don't show disabled alarms.  For uniformity, RTC alarms are
@@ -145,8 +146,8 @@
 	 */
 	retval = rtc_read_alarm(to_rtc_device(dev), &alm);
 	if (retval == 0 && alm.enabled) {
-		rtc_tm_to_time(&alm.time, &alarm);
-		retval = sprintf(buf, "%lu\n", alarm);
+		alarm = rtc_tm_to_time64(&alm.time);
+		retval = sprintf(buf, "%lld\n", alarm);
 	}
 
 	return retval;
@@ -157,8 +158,8 @@
 		const char *buf, size_t n)
 {
 	ssize_t retval;
-	unsigned long now, alarm;
-	unsigned long push = 0;
+	time64_t now, alarm;
+	time64_t push = 0;
 	struct rtc_wkalrm alm;
 	struct rtc_device *rtc = to_rtc_device(dev);
 	const char *buf_ptr;
@@ -170,7 +171,7 @@
 	retval = rtc_read_time(rtc, &alm.time);
 	if (retval < 0)
 		return retval;
-	rtc_tm_to_time(&alm.time, &now);
+	now = rtc_tm_to_time64(&alm.time);
 
 	buf_ptr = buf;
 	if (*buf_ptr == '+') {
@@ -181,7 +182,7 @@
 		} else
 			adjust = 1;
 	}
-	retval = kstrtoul(buf_ptr, 0, &alarm);
+	retval = kstrtos64(buf_ptr, 0, &alarm);
 	if (retval)
 		return retval;
 	if (adjust) {
@@ -197,7 +198,7 @@
 			return retval;
 		if (alm.enabled) {
 			if (push) {
-				rtc_tm_to_time(&alm.time, &push);
+				push = rtc_tm_to_time64(&alm.time);
 				alarm += push;
 			} else
 				return -EBUSY;
@@ -212,7 +213,7 @@
 		 */
 		alarm = now + 300;
 	}
-	rtc_time_to_tm(alarm, &alm.time);
+	rtc_time64_to_tm(alarm, &alm.time);
 
 	retval = rtc_set_alarm(rtc, &alm);
 	return (retval < 0) ? retval : n;
-- 
1.7.9.5
