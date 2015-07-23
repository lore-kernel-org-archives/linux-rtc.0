Return-Path: <rtc-linux+bncBDP6N55ZUYDRBPXEYWWQKGQE56IPTJQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-x22c.google.com (mail-pd0-x22c.google.com. [2607:f8b0:400e:c02::22c])
        by gmr-mx.google.com with ESMTPS id x3si1114149pdh.2.2015.07.23.16.01.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2015 16:01:18 -0700 (PDT)
Received: by mail-pd0-x22c.google.com with SMTP id bh15so3235766pdb.1
        for <rtc-linux@googlegroups.com>; Thu, 23 Jul 2015 16:01:18 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [rtc-linux] [PATCH v2 3/3] RTC: switch to using is_visible() to
 control sysfs attributes
Date: Thu, 23 Jul 2015 16:01:08 -0700
Message-Id: <1437692468-24788-3-git-send-email-dmitry.torokhov@gmail.com>
In-Reply-To: <1437692468-24788-1-git-send-email-dmitry.torokhov@gmail.com>
References: <1437692468-24788-1-git-send-email-dmitry.torokhov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Instead of creating wakealarm attribute manually, after the device has been
registered, let's rely on facilities provided by the attribute groups to
control which attributes are visible and which are not. This allows to to
create all needed attributes at once, at the same time that we register RTC
class device.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/rtc/class.c     |  4 +---
 drivers/rtc/rtc-core.h  | 19 +++-------------
 drivers/rtc/rtc-sysfs.c | 59 +++++++++++++++++++++++++------------------------
 3 files changed, 34 insertions(+), 48 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index de7707f..de86578 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -202,6 +202,7 @@ struct rtc_device *rtc_device_register(const char *name, struct device *dev,
 	rtc->max_user_freq = 64;
 	rtc->dev.parent = dev;
 	rtc->dev.class = rtc_class;
+	rtc->dev.groups = rtc_get_dev_attribute_groups();
 	rtc->dev.release = rtc_device_release;
 
 	mutex_init(&rtc->ops_lock);
@@ -240,7 +241,6 @@ struct rtc_device *rtc_device_register(const char *name, struct device *dev,
 	}
 
 	rtc_dev_add_device(rtc);
-	rtc_sysfs_add_device(rtc);
 	rtc_proc_add_device(rtc);
 
 	dev_info(dev, "rtc core: registered %s as %s\n",
@@ -271,7 +271,6 @@ void rtc_device_unregister(struct rtc_device *rtc)
 	 * Remove innards of this RTC, then disable it, before
 	 * letting any rtc_class_open() users access it again
 	 */
-	rtc_sysfs_del_device(rtc);
 	rtc_dev_del_device(rtc);
 	rtc_proc_del_device(rtc);
 	device_del(&rtc->dev);
@@ -360,7 +359,6 @@ static int __init rtc_init(void)
 	}
 	rtc_class->pm = RTC_CLASS_DEV_PM_OPS;
 	rtc_dev_init();
-	rtc_sysfs_init(rtc_class);
 	return 0;
 }
 
diff --git a/drivers/rtc/rtc-core.h b/drivers/rtc/rtc-core.h
index 5f9df74..a098aea 100644
--- a/drivers/rtc/rtc-core.h
+++ b/drivers/rtc/rtc-core.h
@@ -48,23 +48,10 @@ static inline void rtc_proc_del_device(struct rtc_device *rtc)
 #endif
 
 #ifdef CONFIG_RTC_INTF_SYSFS
-
-extern void __init rtc_sysfs_init(struct class *);
-extern void rtc_sysfs_add_device(struct rtc_device *rtc);
-extern void rtc_sysfs_del_device(struct rtc_device *rtc);
-
+const struct attribute_group **rtc_get_dev_attribute_groups(void);
 #else
-
-static inline void rtc_sysfs_init(struct class *rtc)
-{
-}
-
-static inline void rtc_sysfs_add_device(struct rtc_device *rtc)
+static inline const struct attribute_group **rtc_get_dev_attribute_groups(void)
 {
+	return NULL;
 }
-
-static inline void rtc_sysfs_del_device(struct rtc_device *rtc)
-{
-}
-
 #endif
diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/rtc-sysfs.c
index e3ce1dc..7273855 100644
--- a/drivers/rtc/rtc-sysfs.c
+++ b/drivers/rtc/rtc-sysfs.c
@@ -122,17 +122,6 @@ hctosys_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR_RO(hctosys);
 
-static struct attribute *rtc_attrs[] = {
-	&dev_attr_name.attr,
-	&dev_attr_date.attr,
-	&dev_attr_time.attr,
-	&dev_attr_since_epoch.attr,
-	&dev_attr_max_user_freq.attr,
-	&dev_attr_hctosys.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(rtc);
-
 static ssize_t
 wakealarm_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -222,6 +211,16 @@ wakealarm_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(wakealarm);
 
+static struct attribute *rtc_attrs[] = {
+	&dev_attr_name.attr,
+	&dev_attr_date.attr,
+	&dev_attr_time.attr,
+	&dev_attr_since_epoch.attr,
+	&dev_attr_max_user_freq.attr,
+	&dev_attr_hctosys.attr,
+	&dev_attr_wakealarm.attr,
+	NULL,
+};
 
 /* The reason to trigger an alarm with no process watching it (via sysfs)
  * is its side effect:  waking from a system state like suspend-to-RAM or
@@ -236,29 +235,31 @@ static bool rtc_does_wakealarm(struct rtc_device *rtc)
 	return rtc->ops->set_alarm != NULL;
 }
 
-
-void rtc_sysfs_add_device(struct rtc_device *rtc)
+static umode_t rtc_attr_is_visible(struct kobject *kobj,
+				   struct attribute *attr, int n)
 {
-	int err;
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct rtc_device *rtc = to_rtc_device(dev);
+	umode_t mode = attr->mode;
 
-	/* not all RTCs support both alarms and wakeup */
-	if (!rtc_does_wakealarm(rtc))
-		return;
+	if (attr == &dev_attr_wakealarm.attr)
+		if (!rtc_does_wakealarm(rtc))
+			mode = 0;
 
-	err = device_create_file(&rtc->dev, &dev_attr_wakealarm);
-	if (err)
-		dev_err(rtc->dev.parent,
-			"failed to create alarm attribute, %d\n", err);
+	return mode;
 }
 
-void rtc_sysfs_del_device(struct rtc_device *rtc)
-{
-	/* REVISIT did we add it successfully? */
-	if (rtc_does_wakealarm(rtc))
-		device_remove_file(&rtc->dev, &dev_attr_wakealarm);
-}
+static struct attribute_group rtc_attr_group = {
+	.is_visible	= rtc_attr_is_visible,
+	.attrs		= rtc_attrs,
+};
+
+static const struct attribute_group *rtc_attr_groups[] = {
+	&rtc_attr_group,
+	NULL
+};
 
-void __init rtc_sysfs_init(struct class *rtc_class)
+const struct attribute_group **rtc_get_dev_attribute_groups(void)
 {
-	rtc_class->dev_groups = rtc_groups;
+	return rtc_attr_groups;
 }
-- 
2.5.0.rc2.392.g76e840b

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
