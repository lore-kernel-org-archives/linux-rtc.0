Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25356 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751635AbdFHNs1 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 8 Jun 2017 09:48:27 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 06/25] rtc: Switch to use %pt
Date: Thu,  8 Jun 2017 16:47:52 +0300
Message-Id: <20170608134811.60786-7-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %pt instead of open coded variant to print content of
struct rtc_time in human readable format.

Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/rtc.c      |  7 +++----
 drivers/rtc/hctosys.c   |  8 ++------
 drivers/rtc/interface.c |  8 ++------
 drivers/rtc/rtc-proc.c  | 36 +++++-------------------------------
 drivers/rtc/rtc-sysfs.c | 12 ++++--------
 5 files changed, 16 insertions(+), 55 deletions(-)

diff --git a/drivers/char/rtc.c b/drivers/char/rtc.c
index 974d48927b07..a2d664d4d011 100644
--- a/drivers/char/rtc.c
+++ b/drivers/char/rtc.c
@@ -1231,11 +1231,10 @@ static int rtc_proc_show(struct seq_file *seq, void *v)
 	 * time or for Universal Standard Time (GMT). Probably local though.
 	 */
 	seq_printf(seq,
-		   "rtc_time\t: %02d:%02d:%02d\n"
-		   "rtc_date\t: %04d-%02d-%02d\n"
+		   "rtc_time\t: %ptt\n"
+		   "rtc_date\t: %ptd\n"
 		   "rtc_epoch\t: %04lu\n",
-		   tm.tm_hour, tm.tm_min, tm.tm_sec,
-		   tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, epoch);
+		   &tm, &tm, epoch);
 
 	get_rtc_alm_time(&tm);
 
diff --git a/drivers/rtc/hctosys.c b/drivers/rtc/hctosys.c
index e1cfa06810ef..846b2b5e6434 100644
--- a/drivers/rtc/hctosys.c
+++ b/drivers/rtc/hctosys.c
@@ -51,12 +51,8 @@ static int __init rtc_hctosys(void)
 
 	err = do_settimeofday64(&tv64);
 
-	dev_info(rtc->dev.parent,
-		"setting system clock to "
-		"%d-%02d-%02d %02d:%02d:%02d UTC (%lld)\n",
-		tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
-		tm.tm_hour, tm.tm_min, tm.tm_sec,
-		(long long) tv64.tv_sec);
+	dev_info(rtc->dev.parent, "setting system clock to %pt UTC (%lld)\n",
+		 &tm, (long long)tv64.tv_sec);
 
 err_read:
 	rtc_class_close(rtc);
diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 8cec9a02c0b8..5735d4c901ec 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -288,12 +288,8 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	err = rtc_valid_tm(&alarm->time);
 
 done:
-	if (err) {
-		dev_warn(&rtc->dev, "invalid alarm value: %d-%d-%d %d:%d:%d\n",
-			alarm->time.tm_year + 1900, alarm->time.tm_mon + 1,
-			alarm->time.tm_mday, alarm->time.tm_hour, alarm->time.tm_min,
-			alarm->time.tm_sec);
-	}
+	if (err)
+		dev_warn(&rtc->dev, "invalid alarm value: %pt\n", &alarm->time);
 
 	return err;
 }
diff --git a/drivers/rtc/rtc-proc.c b/drivers/rtc/rtc-proc.c
index 31e7e23cc5be..a9769e4fb497 100644
--- a/drivers/rtc/rtc-proc.c
+++ b/drivers/rtc/rtc-proc.c
@@ -50,41 +50,15 @@ static int rtc_proc_show(struct seq_file *seq, void *offset)
 	err = rtc_read_time(rtc, &tm);
 	if (err == 0) {
 		seq_printf(seq,
-			"rtc_time\t: %02d:%02d:%02d\n"
-			"rtc_date\t: %04d-%02d-%02d\n",
-			tm.tm_hour, tm.tm_min, tm.tm_sec,
-			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday);
+				"rtc_time\t: %ptt\n"
+				"rtc_date\t: %ptd\n",
+				&tm, &tm);
 	}
 
 	err = rtc_read_alarm(rtc, &alrm);
 	if (err == 0) {
-		seq_printf(seq, "alrm_time\t: ");
-		if ((unsigned int)alrm.time.tm_hour <= 24)
-			seq_printf(seq, "%02d:", alrm.time.tm_hour);
-		else
-			seq_printf(seq, "**:");
-		if ((unsigned int)alrm.time.tm_min <= 59)
-			seq_printf(seq, "%02d:", alrm.time.tm_min);
-		else
-			seq_printf(seq, "**:");
-		if ((unsigned int)alrm.time.tm_sec <= 59)
-			seq_printf(seq, "%02d\n", alrm.time.tm_sec);
-		else
-			seq_printf(seq, "**\n");
-
-		seq_printf(seq, "alrm_date\t: ");
-		if ((unsigned int)alrm.time.tm_year <= 200)
-			seq_printf(seq, "%04d-", alrm.time.tm_year + 1900);
-		else
-			seq_printf(seq, "****-");
-		if ((unsigned int)alrm.time.tm_mon <= 11)
-			seq_printf(seq, "%02d-", alrm.time.tm_mon + 1);
-		else
-			seq_printf(seq, "**-");
-		if (alrm.time.tm_mday && (unsigned int)alrm.time.tm_mday <= 31)
-			seq_printf(seq, "%02d\n", alrm.time.tm_mday);
-		else
-			seq_printf(seq, "**\n");
+		seq_printf(seq, "alrm_time\t: %pttv\n", &alrm.time);
+		seq_printf(seq, "alrm_date\t: %ptdv\n", &alrm.time);
 		seq_printf(seq, "alarm_IRQ\t: %s\n",
 				alrm.enabled ? "yes" : "no");
 		seq_printf(seq, "alrm_pending\t: %s\n",
diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/rtc-sysfs.c
index e364550eb9a7..145c2c3fa988 100644
--- a/drivers/rtc/rtc-sysfs.c
+++ b/drivers/rtc/rtc-sysfs.c
@@ -39,10 +39,8 @@ date_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct rtc_time tm;
 
 	retval = rtc_read_time(to_rtc_device(dev), &tm);
-	if (retval == 0) {
-		retval = sprintf(buf, "%04d-%02d-%02d\n",
-			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday);
-	}
+	if (retval == 0)
+		retval = sprintf(buf, "%ptd\n", &tm);
 
 	return retval;
 }
@@ -55,10 +53,8 @@ time_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct rtc_time tm;
 
 	retval = rtc_read_time(to_rtc_device(dev), &tm);
-	if (retval == 0) {
-		retval = sprintf(buf, "%02d:%02d:%02d\n",
-			tm.tm_hour, tm.tm_min, tm.tm_sec);
-	}
+	if (retval == 0)
+		retval = sprintf(buf, "%ptt\n", &tm);
 
 	return retval;
 }
-- 
2.11.0
