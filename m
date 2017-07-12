Return-Path: <rtc-linux+bncBDKNBMNKRMJRBV5QS7FQKGQECQKJ67Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x236.google.com (mail-wr0-x236.google.com. [2a00:1450:400c:c0c::236])
        by gmr-mx.google.com with ESMTPS id j203si426280wmg.1.2017.07.12.01.05.43
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jul 2017 01:05:43 -0700 (PDT)
Received: by mail-wr0-x236.google.com with SMTP id 77so22548680wrb.1
        for <rtc-linux@googlegroups.com>; Wed, 12 Jul 2017 01:05:43 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH v2 20/22] rtc: sysfs: stop using rtc deprecated functions
Date: Wed, 12 Jul 2017 10:04:40 +0200
Message-Id: <1499846682-14093-21-git-send-email-benjamin.gaignard@linaro.org>
In-Reply-To: <1499846682-14093-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1499846682-14093-1-git-send-email-benjamin.gaignard@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
rely on 32bits variables and that will make rtc break in y2038/2016.
Stop using those two functions to safer 64bits ones.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux@googlegroups.com
CC: linux-kernel@vger.kernel.org
---
 drivers/rtc/rtc-sysfs.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/rtc-sysfs.c
index e364550..8b97def 100644
--- a/drivers/rtc/rtc-sysfs.c
+++ b/drivers/rtc/rtc-sysfs.c
@@ -72,9 +72,10 @@
 
 	retval = rtc_read_time(to_rtc_device(dev), &tm);
 	if (retval == 0) {
-		unsigned long time;
-		rtc_tm_to_time(&tm, &time);
-		retval = sprintf(buf, "%lu\n", time);
+		unsigned long long time;
+
+		time = rtc_tm_to_time64(&tm);
+		retval = sprintf(buf, "%llu\n", time);
 	}
 
 	return retval;
@@ -132,7 +133,7 @@
 wakealarm_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	ssize_t retval;
-	unsigned long alarm;
+	unsigned long long alarm;
 	struct rtc_wkalrm alm;
 
 	/* Don't show disabled alarms.  For uniformity, RTC alarms are
@@ -145,8 +146,8 @@
 	 */
 	retval = rtc_read_alarm(to_rtc_device(dev), &alm);
 	if (retval == 0 && alm.enabled) {
-		rtc_tm_to_time(&alm.time, &alarm);
-		retval = sprintf(buf, "%lu\n", alarm);
+		alarm = rtc_tm_to_time64(&alm.time);
+		retval = sprintf(buf, "%llu\n", alarm);
 	}
 
 	return retval;
@@ -157,8 +158,8 @@
 		const char *buf, size_t n)
 {
 	ssize_t retval;
-	unsigned long now, alarm;
-	unsigned long push = 0;
+	unsigned long long now, alarm;
+	unsigned long long push = 0;
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
+	retval = kstrtoull(buf_ptr, 0, &alarm);
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
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
