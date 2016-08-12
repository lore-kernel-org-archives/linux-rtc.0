Return-Path: <rtc-linux+bncBD7YLCN32UNBBGUKW66QKGQEYK4HVIQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com. [2a00:1450:400c:c09::244])
        by gmr-mx.google.com with ESMTPS id i198si111975wmd.2.2016.08.12.05.46.17
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Aug 2016 05:46:17 -0700 (PDT)
Received: by mail-wm0-x244.google.com with SMTP id o80so2671575wme.0
        for <rtc-linux@googlegroups.com>; Fri, 12 Aug 2016 05:46:17 -0700 (PDT)
From: LABBE Corentin <clabbe.montjoie@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: fix a cast removing the const attribute
Date: Fri, 12 Aug 2016 14:46:14 +0200
Message-Id: <1471005974-16973-1-git-send-email-clabbe.montjoie@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The char pointer buf_ptr is assigned an address from a const char
pointer buf (parameter of wakealarm_store).
The data pointer by buf_ptr is never modified.
So casting it to a (char *) is useless.

This patch remove this cast, and transform buf_ptr to a const char pointer.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/rtc/rtc-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/rtc-sysfs.c
index 63b9fb1..1218d5d 100644
--- a/drivers/rtc/rtc-sysfs.c
+++ b/drivers/rtc/rtc-sysfs.c
@@ -160,7 +160,7 @@ wakealarm_store(struct device *dev, struct device_attribute *attr,
 	unsigned long push = 0;
 	struct rtc_wkalrm alm;
 	struct rtc_device *rtc = to_rtc_device(dev);
-	char *buf_ptr;
+	const char *buf_ptr;
 	int adjust = 0;
 
 	/* Only request alarms that trigger in the future.  Disable them
@@ -171,7 +171,7 @@ wakealarm_store(struct device *dev, struct device_attribute *attr,
 		return retval;
 	rtc_tm_to_time(&alm.time, &now);
 
-	buf_ptr = (char *)buf;
+	buf_ptr = buf;
 	if (*buf_ptr == '+') {
 		buf_ptr++;
 		if (*buf_ptr == '=') {
-- 
2.7.3

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
