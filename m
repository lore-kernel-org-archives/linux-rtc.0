Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36085 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751335AbeABFK3 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 2 Jan 2018 00:10:29 -0500
Received: by mail-pf0-f195.google.com with SMTP id p84so25280246pfd.3
        for <linux-rtc@vger.kernel.org>; Mon, 01 Jan 2018 21:10:29 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        corbet@lwn.net
Cc: arnd@arndb.de, broonie@kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        baolin.wang@linaro.org
Subject: [RFC PATCH 1/4] rtc: Introduce one interface to save the RTC hardware time range
Date: Tue,  2 Jan 2018 13:10:05 +0800
Message-Id: <9ab56bdcaeb52241e22b738d6babe7b01728f64c.1514869621.git.baolin.wang@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

In order to the setting time values are not beyond the limitation
supported by RTC hardware, we introduce one interface to tell the
hardware range to the RTC core, which are used to valid if the
setting time values are in the RTC hardware range.

Moreover we also need the RTC hardware range to expand the RTC
range in next patches by adding one offset.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/rtc/class.c     |   13 ++++++++++
 drivers/rtc/interface.c |   62 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/rtc.h     |    9 +++++++
 3 files changed, 84 insertions(+)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 722d683..31fc0f1 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -247,6 +247,12 @@ struct rtc_device *rtc_device_register(const char *name, struct device *dev,
 
 	dev_set_name(&rtc->dev, "rtc%d", id);
 
+	err = rtc_read_range(rtc, &rtc->max_hw_secs, &rtc->min_hw_secs);
+	if (err) {
+		dev_err(&rtc->dev, "%s: failed to get RTC range\n", name);
+		goto exit_ida;
+	}
+
 	/* Check to see if there is an ALARM already set in hw */
 	err = __rtc_read_alarm(rtc, &alrm);
 
@@ -436,6 +442,13 @@ int __rtc_register_device(struct module *owner, struct rtc_device *rtc)
 
 	rtc->owner = owner;
 
+	err = rtc_read_range(rtc, &rtc->max_hw_secs, &rtc->min_hw_secs);
+	if (err) {
+		dev_err(&rtc->dev, "%s: failed to get RTC range\n",
+			dev_name(&rtc->dev));
+		return err;
+	}
+
 	/* Check to see if there is an ALARM already set in hw */
 	err = __rtc_read_alarm(rtc, &alrm);
 	if (!err && !rtc_valid_tm(&alrm.time))
diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 672b192..c8090e3 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -65,6 +65,10 @@ int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm)
 	if (err != 0)
 		return err;
 
+	err = rtc_valid_range(rtc, tm);
+	if (err)
+		return err;
+
 	err = mutex_lock_interruptible(&rtc->ops_lock);
 	if (err)
 		return err;
@@ -329,6 +333,11 @@ static int __rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	err = rtc_valid_tm(&alarm->time);
 	if (err)
 		return err;
+
+	err = rtc_valid_range(rtc, &alarm->time);
+	if (err)
+		return err;
+
 	scheduled = rtc_tm_to_time64(&alarm->time);
 
 	/* Make sure we're not setting alarms in the past */
@@ -1027,3 +1036,56 @@ int rtc_set_offset(struct rtc_device *rtc, long offset)
 	mutex_unlock(&rtc->ops_lock);
 	return ret;
 }
+
+/* rtc_read_range - Read the max and min hardware count supported by RTC device
+ * @ rtc: rtc device to be used.
+ * @ max_hw_secs: maximum hardware count in seconds, which can represent
+ * the maximum time values in RTC hardware.
+ * @ min_hw_secs: minimum hardware count in seconds, which can represent
+ * the minimum time values in RTC hardware.
+ *
+ * The max_hw_secs and min_hw_secs implemented by user must represent the
+ * correct hardware start time and maximum time, which means the count
+ * will wrap around to min_hw_secs after the maximum count.
+ *
+ * If user did not implement the read_range() interface, we can set max_hw_secs
+ * and min_hw_secs to 0, which avoids validing the range.
+ */
+int rtc_read_range(struct rtc_device *rtc, time64_t *max_hw_secs,
+		   time64_t *min_hw_secs)
+{
+	int ret;
+
+	if (!rtc->ops || !rtc->ops->read_range) {
+		*max_hw_secs = 0;
+		*min_hw_secs = 0;
+		return 0;
+	}
+
+	mutex_lock(&rtc->ops_lock);
+	ret = rtc->ops->read_range(rtc->dev.parent, max_hw_secs, min_hw_secs);
+	mutex_unlock(&rtc->ops_lock);
+
+	return ret;
+}
+
+/* rtc_valid_range - Valid if the setting time in the RTC range
+ * @ rtc: rtc device to be used.
+ * @ tm: time values need to valid.
+ *
+ * Only the rtc->max_hw_secs was set, then we can valid if the setting time
+ * values are beyond the RTC range.
+ */
+int rtc_valid_range(struct rtc_device *rtc, struct rtc_time *tm)
+{
+	time64_t secs;
+
+	if (!rtc->max_hw_secs)
+		return 0;
+
+	secs = rtc_tm_to_time64(tm);
+	if (secs < rtc->min_hw_secs || secs > rtc->max_hw_secs)
+		return -EINVAL;
+
+	return 0;
+}
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 41319a2..19a8989 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -85,6 +85,8 @@ struct rtc_class_ops {
 	int (*alarm_irq_enable)(struct device *, unsigned int enabled);
 	int (*read_offset)(struct device *, long *offset);
 	int (*set_offset)(struct device *, long offset);
+	int (*read_range)(struct device *, time64_t *max_hw_secs,
+			  time64_t *min_hw_secs);
 };
 
 #define RTC_DEVICE_NAME_SIZE 20
@@ -152,6 +154,9 @@ struct rtc_device {
 	bool nvram_old_abi;
 	struct bin_attribute *nvram;
 
+	time64_t max_hw_secs;
+	time64_t min_hw_secs;
+
 #ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
 	struct work_struct uie_task;
 	struct timer_list uie_timer;
@@ -225,6 +230,10 @@ int rtc_timer_start(struct rtc_device *rtc, struct rtc_timer *timer,
 int rtc_set_offset(struct rtc_device *rtc, long offset);
 void rtc_timer_do_work(struct work_struct *work);
 
+int rtc_read_range(struct rtc_device *rtc, time64_t *max_hw_secs,
+		   time64_t *min_hw_secs);
+int rtc_valid_range(struct rtc_device *rtc, struct rtc_time *tm);
+
 static inline bool is_leap_year(unsigned int year)
 {
 	return (!(year % 4) && (year % 100)) || !(year % 400);
-- 
1.7.9.5
