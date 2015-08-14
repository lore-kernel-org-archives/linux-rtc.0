Return-Path: <rtc-linux+bncBDULZYNR2QMRB245WWXAKGQEHVJ7GPA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-yk0-x233.google.com (mail-yk0-x233.google.com. [2607:f8b0:4002:c07::233])
        by gmr-mx.google.com with ESMTPS id g144si450476ywb.6.2015.08.13.19.14.03
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2015 19:14:03 -0700 (PDT)
Received: by mail-yk0-x233.google.com with SMTP id z130so57953454yka.0
        for <rtc-linux@googlegroups.com>; Thu, 13 Aug 2015 19:14:03 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [rtc-linux] [PATCH] rtc: Pass the IRQF_ONESHOT flag
Date: Thu, 13 Aug 2015 23:13:36 -0300
Message-Id: <1439518416-13044-1-git-send-email-festevam@gmail.com>
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

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit 1c6c69525b40eb76de8adf039409722015927dc3 ("genirq: Reject
bogus threaded irq requests") threaded IRQs without a primary handler
need to be requested with IRQF_ONESHOT, otherwise the request will fail.

So pass the IRQF_ONESHOT flag in this case.

The semantic patch that makes this change is available
in scripts/coccinelle/misc/irqf_oneshot.cocci

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/rtc/rtc-isl1208.c  | 2 +-
 drivers/rtc/rtc-lp8788.c   | 2 +-
 drivers/rtc/rtc-max77686.c | 3 ++-
 drivers/rtc/rtc-max77802.c | 3 ++-
 drivers/rtc/rtc-max8997.c  | 2 +-
 drivers/rtc/rtc-max8998.c  | 3 ++-
 drivers/rtc/rtc-rc5t583.c  | 2 +-
 drivers/rtc/rtc-rk808.c    | 2 +-
 drivers/rtc/rtc-s5m.c      | 3 ++-
 drivers/rtc/rtc-tps65910.c | 3 ++-
 drivers/rtc/rtc-wm831x.c   | 3 ++-
 11 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index aa3b8f1..b57a304 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -638,7 +638,7 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (client->irq > 0) {
 		rc = devm_request_threaded_irq(&client->dev, client->irq, NULL,
 					       isl1208_rtc_interrupt,
-					       IRQF_SHARED,
+					       IRQF_SHARED | IRQF_ONESHOT,
 					       isl1208_driver.driver.name,
 					       client);
 		if (!rc) {
diff --git a/drivers/rtc/rtc-lp8788.c b/drivers/rtc/rtc-lp8788.c
index e20e7bd..e0de665 100644
--- a/drivers/rtc/rtc-lp8788.c
+++ b/drivers/rtc/rtc-lp8788.c
@@ -280,7 +280,7 @@ static int lp8788_alarm_irq_register(struct platform_device *pdev,
 
 	return devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
 				lp8788_alarm_irq_handler,
-				0, LP8788_ALM_IRQ, rtc);
+				IRQF_ONESHOT, LP8788_ALM_IRQ, rtc);
 }
 
 static int lp8788_rtc_probe(struct platform_device *pdev)
diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 7184a0e..06d1354 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -471,7 +471,8 @@ static int max77686_rtc_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, info->virq, NULL,
-				max77686_rtc_alarm_irq, 0, "rtc-alarm1", info);
+				max77686_rtc_alarm_irq, IRQF_ONESHOT,
+				"rtc-alarm1", info);
 	if (ret < 0)
 		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
 			info->virq, ret);
diff --git a/drivers/rtc/rtc-max77802.c b/drivers/rtc/rtc-max77802.c
index 82ffcc5..e275d9b 100644
--- a/drivers/rtc/rtc-max77802.c
+++ b/drivers/rtc/rtc-max77802.c
@@ -444,7 +444,8 @@ static int max77802_rtc_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, info->virq, NULL,
-					max77802_rtc_alarm_irq, 0, "rtc-alarm1",
+					max77802_rtc_alarm_irq, IRQF_ONESHOT,
+					"rtc-alarm1",
 					info);
 	if (ret < 0)
 		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
diff --git a/drivers/rtc/rtc-max8997.c b/drivers/rtc/rtc-max8997.c
index 9e02bcd..48e8ae4 100644
--- a/drivers/rtc/rtc-max8997.c
+++ b/drivers/rtc/rtc-max8997.c
@@ -499,7 +499,7 @@ static int max8997_rtc_probe(struct platform_device *pdev)
 	info->virq = virq;
 
 	ret = devm_request_threaded_irq(&pdev->dev, virq, NULL,
-				max8997_rtc_alarm_irq, 0,
+				max8997_rtc_alarm_irq, IRQF_ONESHOT,
 				"rtc-alarm0", info);
 	if (ret < 0)
 		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
diff --git a/drivers/rtc/rtc-max8998.c b/drivers/rtc/rtc-max8998.c
index 30804b0..bcd4956 100644
--- a/drivers/rtc/rtc-max8998.c
+++ b/drivers/rtc/rtc-max8998.c
@@ -287,7 +287,8 @@ static int max8998_rtc_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, info->irq, NULL,
-				max8998_rtc_alarm_irq, 0, "rtc-alarm0", info);
+				max8998_rtc_alarm_irq, IRQF_ONESHOT,
+				"rtc-alarm0", info);
 
 	if (ret < 0)
 		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
diff --git a/drivers/rtc/rtc-rc5t583.c b/drivers/rtc/rtc-rc5t583.c
index f28d577..a9b02af 100644
--- a/drivers/rtc/rtc-rc5t583.c
+++ b/drivers/rtc/rtc-rc5t583.c
@@ -248,7 +248,7 @@ static int rc5t583_rtc_probe(struct platform_device *pdev)
 
 	irq += RC5T583_IRQ_YALE;
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-		rc5t583_rtc_interrupt, IRQF_TRIGGER_LOW,
+		rc5t583_rtc_interrupt, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 		"rtc-rc5t583", &pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "IRQ is not free.\n");
diff --git a/drivers/rtc/rtc-rk808.c b/drivers/rtc/rtc-rk808.c
index 91ca0bc..bf118da 100644
--- a/drivers/rtc/rtc-rk808.c
+++ b/drivers/rtc/rtc-rk808.c
@@ -393,7 +393,7 @@ static int rk808_rtc_probe(struct platform_device *pdev)
 
 	/* request alarm irq of rk808 */
 	ret = devm_request_threaded_irq(&pdev->dev, rk808_rtc->irq, NULL,
-					rk808_alarm_irq, 0,
+					rk808_alarm_irq, IRQF_ONESHOT,
 					"RTC alarm", rk808_rtc);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request alarm IRQ %d: %d\n",
diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 8c70d78..dab0c34 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -740,7 +740,8 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, info->irq, NULL,
-					s5m_rtc_alarm_irq, 0, "rtc-alarm0",
+					s5m_rtc_alarm_irq, IRQF_ONESHOT,
+					"rtc-alarm0",
 					info);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
diff --git a/drivers/rtc/rtc-tps65910.c b/drivers/rtc/rtc-tps65910.c
index f42aa2b..9afafde 100644
--- a/drivers/rtc/rtc-tps65910.c
+++ b/drivers/rtc/rtc-tps65910.c
@@ -268,7 +268,8 @@ static int tps65910_rtc_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-		tps65910_rtc_interrupt, IRQF_TRIGGER_LOW | IRQF_EARLY_RESUME,
+		tps65910_rtc_interrupt,
+		IRQF_TRIGGER_LOW | IRQF_EARLY_RESUME | IRQF_ONESHOT,
 		dev_name(&pdev->dev), &pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "IRQ is not free.\n");
diff --git a/drivers/rtc/rtc-wm831x.c b/drivers/rtc/rtc-wm831x.c
index 75aea4c..54504d5 100644
--- a/drivers/rtc/rtc-wm831x.c
+++ b/drivers/rtc/rtc-wm831x.c
@@ -445,7 +445,8 @@ static int wm831x_rtc_probe(struct platform_device *pdev)
 
 	ret = devm_request_threaded_irq(&pdev->dev, alm_irq, NULL,
 				wm831x_alm_irq,
-				IRQF_TRIGGER_RISING, "RTC alarm",
+				IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+				"RTC alarm",
 				wm831x_rtc);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Failed to request alarm IRQ %d: %d\n",
-- 
1.9.1

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
