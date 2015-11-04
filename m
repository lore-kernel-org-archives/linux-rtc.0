Return-Path: <rtc-linux+bncBDIZTUWNWICRB24V5CYQKGQEQJX3A6Y@googlegroups.com>
Received: from userp1040.oracle.com (userp1040.oracle.com. [156.151.31.81])
        by gmr-mx.google.com with ESMTPS id el2si136461pbb.0.2015.11.04.05.40.58
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2015 05:40:59 -0800 (PST)
Date: Wed, 4 Nov 2015 16:40:45 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com, kernel-janitors@vger.kernel.org
Subject: [rtc-linux] [patch] rtc: rtc-rv8803: Fix a couple locking bugs
Message-ID: <20151104134045.GJ20966@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

There was one missing unlock on error in rv8803_set_alarm() and one
unlock in rv8803_ioctl() which was missing altogether.

Fixes: 2f370c4a1a44 ('rtc: Add a driver for Micro Crystal RV8803')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Presumably the IOCTL issue was a last minute change after the driver had
been tested...

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 63244eb..9508de4 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -240,8 +240,10 @@ static int rv8803_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	spin_lock_irqsave(&rv8803->flags_lock, irqflags);
 
 	ret = i2c_smbus_read_i2c_block_data(client, RV8803_FLAG, 2, ctrl);
-	if (ret != 2)
+	if (ret != 2) {
+		spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
 		return ret < 0 ? ret : -EIO;
+	}
 
 	alarmvals[0] = bin2bcd(alrm->time.tm_min);
 	alarmvals[1] = bin2bcd(alrm->time.tm_hour);
@@ -338,6 +340,7 @@ static int rv8803_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 	case RTC_VL_READ:
 		spin_lock_irqsave(&rv8803->flags_lock, irqflags);
 		flags = i2c_smbus_read_byte_data(client, RV8803_FLAG);
+		spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
 		if (flags < 0)
 			return flags;
 

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
