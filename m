Return-Path: <rtc-linux+bncBAABBMPX4G4AKGQE3GSWOFQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from na01-bn1-obe.outbound.protection.outlook.com (mail-bn1bon0092.outbound.protection.outlook.com. [157.56.111.92])
        by gmr-mx.google.com with ESMTPS id d22si218027pfd.0.2016.04.21.00.05.21
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Apr 2016 00:05:21 -0700 (PDT)
From: Gong Qianyu <Qianyu.Gong@nxp.com>
To: <rtc-linux@googlegroups.com>, <akinobu.mita@gmail.com>,
	<alexandre.belloni@free-electrons.com>
CC: <mingkai.hu@nxp.com>, Gong Qianyu <Qianyu.Gong@nxp.com>
Subject: [rtc-linux] [Patch v3] rtc: ds3232: fix call trace when rtc->ops_lock
 is used as NULL
Date: Thu, 21 Apr 2016 14:55:40 +0800
Message-ID: <1461221740-10739-1-git-send-email-Qianyu.Gong@nxp.com>
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

The rtc->ops_lock would be accessed in ds3232_irq() without being
initialized as rtc_device_register() is called too late.

So move devm_rtc_device_register() just before registering irq handler
to initialize rtc->ops_lock earlier.

Signed-off-by: Gong Qianyu <Qianyu.Gong@nxp.com>
---
V3:
 - revise the commit message.
V2:
 - fix the order of error check.

 drivers/rtc/rtc-ds3232.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index 7edc889..04fbd7f 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -369,6 +369,11 @@ static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
 	if (ret)
 		return ret;
 
+	ds3232->rtc = devm_rtc_device_register(dev, name, &ds3232_rtc_ops,
+						THIS_MODULE);
+	if (IS_ERR(ds3232->rtc))
+		return PTR_ERR(ds3232->rtc);
+
 	if (ds3232->irq > 0) {
 		ret = devm_request_threaded_irq(dev, ds3232->irq, NULL,
 						ds3232_irq,
@@ -380,10 +385,8 @@ static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
 		} else
 			device_init_wakeup(dev, 1);
 	}
-	ds3232->rtc = devm_rtc_device_register(dev, name, &ds3232_rtc_ops,
-						THIS_MODULE);
 
-	return PTR_ERR_OR_ZERO(ds3232->rtc);
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.1.0.27.g96db324

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
