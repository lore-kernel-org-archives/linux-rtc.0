Return-Path: <rtc-linux+bncBDJMJGESWAMRBVXNVKZQKGQERLV7A2A@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 124si95101wml.0.2015.12.11.03.43.18
        for <rtc-linux@googlegroups.com>;
        Fri, 11 Dec 2015 03:43:18 -0800 (PST)
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [rtc-linux] [PATCH] rtc: rv8803 Extend compatiblity with the rx8900
Date: Fri, 11 Dec 2015 12:43:05 +0100
Message-Id: <1449834186-3903-1-git-send-email-gregory.clement@free-electrons.com>
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

The Seiko Epson's RTC RX8900 layout register is compatible with the
RV8803. So let's add its ID in order to reuse the same driver.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/rtc/rtc-rv8803.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index e7329e2..db405f2 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -502,6 +502,7 @@ static int rv8803_remove(struct i2c_client *client)
 
 static const struct i2c_device_id rv8803_id[] = {
 	{ "rv8803", 0 },
+	{ "rx8900", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rv8803_id);
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
