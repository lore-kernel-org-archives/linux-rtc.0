Return-Path: <rtc-linux+bncBDP6N55ZUYDRBIX4WWWQKGQEGONXXNY@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-x231.google.com (mail-pd0-x231.google.com. [2607:f8b0:400e:c02::231])
        by gmr-mx.google.com with ESMTPS id x3si2657565pdh.2.2015.07.20.16.02.58
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2015 16:02:58 -0700 (PDT)
Received: by mail-pd0-x231.google.com with SMTP id bh15so62868345pdb.1
        for <rtc-linux@googlegroups.com>; Mon, 20 Jul 2015 16:02:58 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 2/4] RTC: remove unnecessary device_get() in rtc_device_unregister
Date: Mon, 20 Jul 2015 16:02:50 -0700
Message-Id: <1437433372-15425-2-git-send-email-dmitry.torokhov@gmail.com>
In-Reply-To: <1437433372-15425-1-git-send-email-dmitry.torokhov@gmail.com>
References: <1437433372-15425-1-git-send-email-dmitry.torokhov@gmail.com>
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

Technically the address of rtc->dev can never be NULL, so get_device()
can never fail. Also caller of rtc_device_unregister() supposed to be
the owner of the device and thus have a valid reference. Therefore
call to get_device() is not needed here.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/rtc/class.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index eb82ec2..de7707f 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -266,19 +266,18 @@ EXPORT_SYMBOL_GPL(rtc_device_register);
  */
 void rtc_device_unregister(struct rtc_device *rtc)
 {
-	if (get_device(&rtc->dev) != NULL) {
-		mutex_lock(&rtc->ops_lock);
-		/* remove innards of this RTC, then disable it, before
-		 * letting any rtc_class_open() users access it again
-		 */
-		rtc_sysfs_del_device(rtc);
-		rtc_dev_del_device(rtc);
-		rtc_proc_del_device(rtc);
-		device_unregister(&rtc->dev);
-		rtc->ops = NULL;
-		mutex_unlock(&rtc->ops_lock);
-		put_device(&rtc->dev);
-	}
+	mutex_lock(&rtc->ops_lock);
+	/*
+	 * Remove innards of this RTC, then disable it, before
+	 * letting any rtc_class_open() users access it again
+	 */
+	rtc_sysfs_del_device(rtc);
+	rtc_dev_del_device(rtc);
+	rtc_proc_del_device(rtc);
+	device_del(&rtc->dev);
+	rtc->ops = NULL;
+	mutex_unlock(&rtc->ops_lock);
+	put_device(&rtc->dev);
 }
 EXPORT_SYMBOL_GPL(rtc_device_unregister);
 
-- 
2.4.3.573.g4eafbef

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
