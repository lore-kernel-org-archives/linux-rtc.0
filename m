Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35009 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbeABFKb (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 2 Jan 2018 00:10:31 -0500
Received: by mail-pg0-f67.google.com with SMTP id b70so625907pga.2
        for <linux-rtc@vger.kernel.org>; Mon, 01 Jan 2018 21:10:31 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        corbet@lwn.net
Cc: arnd@arndb.de, broonie@kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        baolin.wang@linaro.org
Subject: [RFC PATCH 2/4] rtc: sysfs: Export the valid range supported by RTC hardware
Date: Tue,  2 Jan 2018 13:10:06 +0800
Message-Id: <2f0fb91c39534ecc2e94148a1a6998ba32ab90cf.1514869622.git.baolin.wang@linaro.org>
In-Reply-To: <9ab56bdcaeb52241e22b738d6babe7b01728f64c.1514869621.git.baolin.wang@linaro.org>
References: <9ab56bdcaeb52241e22b738d6babe7b01728f64c.1514869621.git.baolin.wang@linaro.org>
In-Reply-To: <9ab56bdcaeb52241e22b738d6babe7b01728f64c.1514869621.git.baolin.wang@linaro.org>
References: <9ab56bdcaeb52241e22b738d6babe7b01728f64c.1514869621.git.baolin.wang@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

We have introduced one interface to get the RTC range, so this patch
exports the valid range supported by RTC hardware to userspace.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 Documentation/rtc.txt   |    2 ++
 drivers/rtc/rtc-sysfs.c |   30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/rtc.txt b/Documentation/rtc.txt
index c0c9774..4fe437b 100644
--- a/Documentation/rtc.txt
+++ b/Documentation/rtc.txt
@@ -164,6 +164,8 @@ offset		 The amount which the rtc clock has been adjusted in firmware.
 		 which are added to or removed from the rtc's base clock per
 		 billion ticks. A positive value makes a day pass more slowly,
 		 longer, and a negative value makes a day pass more quickly.
+range_max	 The maximum time values in seconds supported by RTC hardware.
+range_min	 The minimum time values in seconds supported by RTC hardware.
 */nvmem		 The non volatile storage exported as a raw file, as described
 		 in Documentation/nvmem/nvmem.txt
 ================ ==============================================================
diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/rtc-sysfs.c
index 92ff2ed..60e1f6c 100644
--- a/drivers/rtc/rtc-sysfs.c
+++ b/drivers/rtc/rtc-sysfs.c
@@ -248,6 +248,34 @@
 }
 static DEVICE_ATTR_RW(offset);
 
+static ssize_t
+range_max_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	ssize_t retval;
+	time64_t max_hw_secs, min_hw_secs;
+
+	retval = rtc_read_range(to_rtc_device(dev), &max_hw_secs, &min_hw_secs);
+	if (retval == 0)
+		retval = sprintf(buf, "%lld\n", max_hw_secs);
+
+	return retval;
+}
+static DEVICE_ATTR_RO(range_max);
+
+static ssize_t
+range_min_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	ssize_t retval;
+	time64_t max_hw_secs, min_hw_secs;
+
+	retval = rtc_read_range(to_rtc_device(dev), &max_hw_secs, &min_hw_secs);
+	if (retval == 0)
+		retval = sprintf(buf, "%lld\n", min_hw_secs);
+
+	return retval;
+}
+static DEVICE_ATTR_RO(range_min);
+
 static struct attribute *rtc_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_date.attr,
@@ -257,6 +285,8 @@
 	&dev_attr_hctosys.attr,
 	&dev_attr_wakealarm.attr,
 	&dev_attr_offset.attr,
+	&dev_attr_range_max.attr,
+	&dev_attr_range_min.attr,
 	NULL,
 };
 
-- 
1.7.9.5
