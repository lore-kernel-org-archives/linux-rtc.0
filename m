Return-Path: <rtc-linux+bncBAABBYUF2OZAKGQEWITRZYY@googlegroups.com>
MIME-Version: 1.0
Received: from vm1.sequanux.org (vm1.sequanux.org. [188.165.36.56])
        by gmr-mx.google.com with ESMTP id q80si36469wmg.0.2015.11.24.12.04.49
        for <rtc-linux@googlegroups.com>;
        Tue, 24 Nov 2015 12:04:49 -0800 (PST)
From: Simon Guinot <simon.guinot@sequanux.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	Vincent Donnefort <vdonnefort@gmail.com>,
	Yoann Sculo <yoann@printk.fr>,
	Simon Guinot <simon.guinot@sequanux.org>
Subject: [rtc-linux] [PATCH] rtc: ds1307: fix alarm reading at probe time
Date: Tue, 24 Nov 2015 21:04:46 +0100
Message-Id: <1448395486-10514-1-git-send-email-simon.guinot@sequanux.org>
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

With the actual code, read_alarm() always returns -EINVAL when called
during the RTC device registration. This prevents from retrieving an
already configured alarm in hardware.

This patch fixes the issue by moving the HAS_ALARM bit configuration
(if supported by the hardware) above the rtc_device_register() call.

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
 drivers/rtc/rtc-ds1307.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 188006c55ce0..732d2afd6489 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1139,6 +1139,8 @@ read_rtc:
 	}
 
 	device_set_wakeup_capable(&client->dev, want_irq);
+	if (want_irq)
+		set_bit(HAS_ALARM, &ds1307->flags);
 	ds1307->rtc = devm_rtc_device_register(&client->dev, client->name,
 				rtc_ops, THIS_MODULE);
 	if (IS_ERR(ds1307->rtc)) {
@@ -1158,7 +1160,6 @@ read_rtc:
 			goto no_irq;
 		}
 
-		set_bit(HAS_ALARM, &ds1307->flags);
 		dev_dbg(&client->dev, "got IRQ %d\n", client->irq);
 
 		/* Currently supported by OF code only! */
-- 
2.1.4

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
