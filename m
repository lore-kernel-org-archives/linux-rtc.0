Return-Path: <rtc-linux+bncBD7YLCN32UNBB4HIZKZQKGQEQQQYUVA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wm0-x22c.google.com (mail-wm0-x22c.google.com. [2a00:1450:400c:c09::22c])
        by gmr-mx.google.com with ESMTPS id d185si77977wmf.0.2015.12.17.05.11.12
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2015 05:11:12 -0800 (PST)
Received: by mail-wm0-x22c.google.com with SMTP id p187so20203087wmp.1
        for <rtc-linux@googlegroups.com>; Thu, 17 Dec 2015 05:11:12 -0800 (PST)
From: LABBE Corentin <clabbe.montjoie@gmail.com>
To: alexandre.belloni@free-electrons.com,
	a.zummo@towertech.it
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH v2 1/1] rtc: Replace simple_strtoul by kstrtoul
Date: Thu, 17 Dec 2015 14:11:04 +0100
Message-Id: <1450357864-7852-2-git-send-email-clabbe.montjoie@gmail.com>
In-Reply-To: <1450357864-7852-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1450357864-7852-1-git-send-email-clabbe.montjoie@gmail.com>
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

The simple_strtoul function is obsolete.
This patch replace it by kstrtoul.

Since kstrtoul is more strict, it permits to filter some invalid input that
simple_strtoul accept. For example:
echo '1022xxx' > /sys/devices/pnp0/00:03/rtc/rtc0/max_user_freq
cat /sys/devices/pnp0/00:03/rtc/rtc0/max_user_freq
1022

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/rtc/rtc-sysfs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/rtc-sysfs.c
index 7273855..463e286 100644
--- a/drivers/rtc/rtc-sysfs.c
+++ b/drivers/rtc/rtc-sysfs.c
@@ -91,7 +91,12 @@ max_user_freq_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t n)
 {
 	struct rtc_device *rtc = to_rtc_device(dev);
-	unsigned long val = simple_strtoul(buf, NULL, 0);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 0, &val);
+	if (err)
+		return err;
 
 	if (val >= 4096 || val == 0)
 		return -EINVAL;
@@ -175,7 +180,9 @@ wakealarm_store(struct device *dev, struct device_attribute *attr,
 		} else
 			adjust = 1;
 	}
-	alarm = simple_strtoul(buf_ptr, NULL, 0);
+	retval = kstrtoul(buf_ptr, 0, &alarm);
+	if (retval)
+		return retval;
 	if (adjust) {
 		alarm += now;
 	}
-- 
2.4.10

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
