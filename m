Return-Path: <rtc-linux+bncBDP6N55ZUYDRBPHEYWWQKGQENBBQFLQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-x22c.google.com (mail-pd0-x22c.google.com. [2607:f8b0:400e:c02::22c])
        by gmr-mx.google.com with ESMTPS id x3si1114149pdh.2.2015.07.23.16.01.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2015 16:01:16 -0700 (PDT)
Received: by pdbbh15 with SMTP id bh15so3235766pdb.1
        for <rtc-linux@googlegroups.com>; Thu, 23 Jul 2015 16:01:16 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [rtc-linux] [PATCH v2 2/3] RTC: switch wakealarm attribute to DEVICE_ATTR_RW
Date: Thu, 23 Jul 2015 16:01:07 -0700
Message-Id: <1437692468-24788-2-git-send-email-dmitry.torokhov@gmail.com>
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

Instead of using older style DEVICE_ATTR for wakealarm attribute let's
switch to using DEVICE_ATTR_RW that ensures consistent across the kernel
permissions on the attribute.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/rtc/rtc-sysfs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/rtc-sysfs.c
index 2fbc11b..e3ce1dc 100644
--- a/drivers/rtc/rtc-sysfs.c
+++ b/drivers/rtc/rtc-sysfs.c
@@ -134,8 +134,7 @@ static struct attribute *rtc_attrs[] = {
 ATTRIBUTE_GROUPS(rtc);
 
 static ssize_t
-rtc_sysfs_show_wakealarm(struct device *dev, struct device_attribute *attr,
-		char *buf)
+wakealarm_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	ssize_t retval;
 	unsigned long alarm;
@@ -159,7 +158,7 @@ rtc_sysfs_show_wakealarm(struct device *dev, struct device_attribute *attr,
 }
 
 static ssize_t
-rtc_sysfs_set_wakealarm(struct device *dev, struct device_attribute *attr,
+wakealarm_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t n)
 {
 	ssize_t retval;
@@ -221,8 +220,7 @@ rtc_sysfs_set_wakealarm(struct device *dev, struct device_attribute *attr,
 	retval = rtc_set_alarm(rtc, &alm);
 	return (retval < 0) ? retval : n;
 }
-static DEVICE_ATTR(wakealarm, S_IRUGO | S_IWUSR,
-		rtc_sysfs_show_wakealarm, rtc_sysfs_set_wakealarm);
+static DEVICE_ATTR_RW(wakealarm);
 
 
 /* The reason to trigger an alarm with no process watching it (via sysfs)
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
