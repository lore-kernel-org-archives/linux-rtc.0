Return-Path: <rtc-linux+bncBDP6N55ZUYDRBOXEYWWQKGQEMHMJARI@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com. [2607:f8b0:400e:c03::229])
        by gmr-mx.google.com with ESMTPS id x3si1112909pdh.2.2015.07.23.16.01.14
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2015 16:01:14 -0700 (PDT)
Received: by mail-pa0-x229.google.com with SMTP id kd10so3334016pab.2
        for <rtc-linux@googlegroups.com>; Thu, 23 Jul 2015 16:01:14 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [rtc-linux] [PATCH v2 1/3] RTC: make rtc_does_wakealarm() return boolean
Date: Thu, 23 Jul 2015 16:01:06 -0700
Message-Id: <1437692468-24788-1-git-send-email-dmitry.torokhov@gmail.com>
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

Users of rtc_does_wakealarm() return value treat it as boolean so let's
change the signature accordingly.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/rtc/rtc-sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/rtc-sysfs.c
index babd43b..2fbc11b 100644
--- a/drivers/rtc/rtc-sysfs.c
+++ b/drivers/rtc/rtc-sysfs.c
@@ -230,10 +230,11 @@ static DEVICE_ATTR(wakealarm, S_IRUGO | S_IWUSR,
  * suspend-to-disk.  So: no attribute unless that side effect is possible.
  * (Userspace may disable that mechanism later.)
  */
-static inline int rtc_does_wakealarm(struct rtc_device *rtc)
+static bool rtc_does_wakealarm(struct rtc_device *rtc)
 {
 	if (!device_can_wakeup(rtc->dev.parent))
-		return 0;
+		return false;
+
 	return rtc->ops->set_alarm != NULL;
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
