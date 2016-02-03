Return-Path: <rtc-linux+bncBCNNJWF7RUMRBEPMZC2QKGQEL5LQZCA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com. [2607:f8b0:400e:c03::244])
        by gmr-mx.google.com with ESMTPS id r2si965202pfr.0.2016.02.03.09.17.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 09:17:05 -0800 (PST)
Received: by mail-pa0-x244.google.com with SMTP id gc2so135004pab.3
        for <rtc-linux@googlegroups.com>; Wed, 03 Feb 2016 09:17:05 -0800 (PST)
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Joshua Clayton <stillcompiling@gmail.com>
Subject: [rtc-linux] [PATCH v3 2/3] rtc: implement a sysfs interface for clock offset
Date: Wed,  3 Feb 2016 09:16:43 -0800
Message-Id: <1454519804-13770-2-git-send-email-stillcompiling@gmail.com>
In-Reply-To: <1454519804-13770-1-git-send-email-stillcompiling@gmail.com>
References: <1454519804-13770-1-git-send-email-stillcompiling@gmail.com>
References: <20160202104111.GU20165@piout.net>
In-Reply-To: <20160202104111.GU20165@piout.net>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

clock offset may be set and read in decimal parts per billion
attribute is /sys/class/rtc/rtcN/offset
The attribute is only visible for rtcs that have set_offset implemented.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 Documentation/rtc.txt   |  6 ++++++
 drivers/rtc/rtc-sysfs.c | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/Documentation/rtc.txt b/Documentation/rtc.txt
index 8446f1e..ddc3660 100644
--- a/Documentation/rtc.txt
+++ b/Documentation/rtc.txt
@@ -157,6 +157,12 @@ wakealarm:	 The time at which the clock will generate a system wakeup
 		 the epoch by default, or if there's a leading +, seconds in the
 		 future, or if there is a leading +=, seconds ahead of the current
 		 alarm.
+offset:		 The amount which the rtc clock has been adjusted in firmware.
+		 Visible only if the driver supports clock offset adjustment.
+		 The unit is parts per billion, i.e. The number of clock ticks
+		 which are added to or removed from the rtc's base clock per
+		 billion ticks. A positive value makes a day pass more slowly,
+		 longer, and a negative value makes a day pass more quickly.
 
 IOCTL INTERFACE
 ---------------
diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/rtc-sysfs.c
index 463e286..f8d7f8d 100644
--- a/drivers/rtc/rtc-sysfs.c
+++ b/drivers/rtc/rtc-sysfs.c
@@ -218,6 +218,34 @@ wakealarm_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(wakealarm);
 
+static ssize_t
+offset_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	ssize_t retval;
+	long offset;
+
+	retval = rtc_read_offset(to_rtc_device(dev), &offset);
+	if (retval == 0)
+		retval = sprintf(buf, "%ld\n", offset);
+
+	return retval;
+}
+
+static ssize_t
+offset_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t n)
+{
+	ssize_t retval;
+	long offset;
+
+	retval = kstrtol(buf, 10, &offset);
+	if (retval == 0)
+		retval = rtc_set_offset(to_rtc_device(dev), offset);
+
+	return (retval < 0) ? retval : n;
+}
+static DEVICE_ATTR_RW(offset);
+
 static struct attribute *rtc_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_date.attr,
@@ -226,6 +254,7 @@ static struct attribute *rtc_attrs[] = {
 	&dev_attr_max_user_freq.attr,
 	&dev_attr_hctosys.attr,
 	&dev_attr_wakealarm.attr,
+	&dev_attr_offset.attr,
 	NULL,
 };
 
@@ -249,9 +278,13 @@ static umode_t rtc_attr_is_visible(struct kobject *kobj,
 	struct rtc_device *rtc = to_rtc_device(dev);
 	umode_t mode = attr->mode;
 
-	if (attr == &dev_attr_wakealarm.attr)
+	if (attr == &dev_attr_wakealarm.attr) {
 		if (!rtc_does_wakealarm(rtc))
 			mode = 0;
+	} else if (attr == &dev_attr_offset.attr) {
+		if (!rtc->ops->set_offset)
+			mode = 0;
+	}
 
 	return mode;
 }
-- 
2.5.0

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
