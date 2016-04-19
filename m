Return-Path: <rtc-linux+bncBAABBM7L224AKGQEJDSKBQA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from na01-by2-obe.outbound.protection.outlook.com (mail-by2on0062.outbound.protection.outlook.com. [207.46.100.62])
        by gmr-mx.google.com with ESMTPS id d22si3085992pfd.0.2016.04.18.21.36.03
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Apr 2016 21:36:03 -0700 (PDT)
From: Gong Qianyu <Qianyu.Gong@nxp.com>
To: <rtc-linux@googlegroups.com>, <akinobu.mita@gmail.com>,
	<alexandre.belloni@free-electrons.com>
CC: <mingkai.hu@nxp.com>, Gong Qianyu <Qianyu.Gong@nxp.com>
Subject: [rtc-linux] [PATCH] rtc: ds3232: fix call trace when rtc->ops_lock is
 used as NULL
Date: Tue, 19 Apr 2016 12:26:23 +0800
Message-ID: <1461039983-32434-1-git-send-email-Qianyu.Gong@nxp.com>
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

Move devm_rtc_device_register() just before registering irq handler
to initialize rtc->ops_lock earlier.

Signed-off-by: Gong Qianyu <Qianyu.Gong@nxp.com>
---
 drivers/rtc/rtc-ds3232.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index 7edc889..9d44b2f 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -369,6 +369,8 @@ static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
 	if (ret)
 		return ret;
 
+	ds3232->rtc = devm_rtc_device_register(dev, name, &ds3232_rtc_ops,
+						THIS_MODULE);
 	if (ds3232->irq > 0) {
 		ret = devm_request_threaded_irq(dev, ds3232->irq, NULL,
 						ds3232_irq,
@@ -380,8 +382,6 @@ static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
 		} else
 			device_init_wakeup(dev, 1);
 	}
-	ds3232->rtc = devm_rtc_device_register(dev, name, &ds3232_rtc_ops,
-						THIS_MODULE);
 
 	return PTR_ERR_OR_ZERO(ds3232->rtc);
 }
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
