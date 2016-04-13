Return-Path: <rtc-linux+bncBCQI7JPS3IGRBDG5XK4AKGQE4LQRZ3I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com. [2a00:1450:400c:c09::241])
        by gmr-mx.google.com with ESMTPS id d92si667162wma.2.2016.04.13.13.39.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 13:39:40 -0700 (PDT)
Received: by mail-wm0-x241.google.com with SMTP id a140so17325339wma.2
        for <rtc-linux@googlegroups.com>; Wed, 13 Apr 2016 13:39:40 -0700 (PDT)
To: rtc-linux@googlegroups.com
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 linux-kernel@vger.kernel.org
From: Tomas Krcka <tomas.krcka@nkgroup.cz>
Subject: [rtc-linux] [PATCH] rtc: support for rv4162c7
Message-ID: <570EAE8B.7010706@nkgroup.cz>
Date: Wed, 13 Apr 2016 22:39:39 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This patch is for support of rv4162c7 RTC chip.
The device has same parameters as rv4162, but with different identification.
Tested with PhyTec module AM335x. 

Signed-off-by: Tomas Krcka <tomas.krcka@nkgroup.cz> 

---
 drivers/rtc/rtc-m41t80.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index d107a8e..1aa57d8 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -81,6 +81,7 @@ static const struct i2c_device_id m41t80_id[] = {
     { "m41st85", M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ },
     { "m41st87", M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ },
     { "rv4162", M41T80_FEATURE_SQ | M41T80_FEATURE_WD | M41T80_FEATURE_SQ_ALT },
+    { "rv4162c7", M41T80_FEATURE_SQ | M41T80_FEATURE_WD | M41T80_FEATURE_SQ_ALT },
     { }
 };
 MODULE_DEVICE_TABLE(i2c, m41t80_id);
-- 1.9.1

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
