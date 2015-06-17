Return-Path: <rtc-linux+bncBCMNZUWXYYORB5UHQ6WAKGQEZUK2EQI@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com. [209.85.192.178])
        by gmr-mx.google.com with ESMTPS id ct6si677686pdb.1.2015.06.17.12.01.09
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jun 2015 12:01:09 -0700 (PDT)
Received: by pdbnf5 with SMTP id nf5so46918049pdb.2
        for <rtc-linux@googlegroups.com>; Wed, 17 Jun 2015 12:01:09 -0700 (PDT)
From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Cc: robh+dt@kernel.org,
	lee.jones@linaro.org,
	devicetree@vger.kernel.org,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Vaibhav Hiremath <vaibhav.hiremath@linaro.org>,
	Chao Xie <chao.xie@marvell.com>
Subject: [rtc-linux] [PATCH-v2] rtc: 88pm80x: add device tree support
Date: Thu, 18 Jun 2015 00:28:06 +0530
Message-Id: <1434567488-6477-3-git-send-email-vaibhav.hiremath@linaro.org>
In-Reply-To: <1434567488-6477-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <vaibhav.hiremath@linaro.org>
 <1434567488-6477-1-git-send-email-vaibhav.hiremath@linaro.org>
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

Along with DT support, this patch also cleans up the unnecessary
code around 'rtc_wakeup' initialization.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
Link to V1: https://lkml.org/lkml/2015/5/29/757

 drivers/rtc/rtc-88pm80x.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
index 7df0579..8f66519 100644
--- a/drivers/rtc/rtc-88pm80x.c
+++ b/drivers/rtc/rtc-88pm80x.c
@@ -251,17 +251,26 @@ static SIMPLE_DEV_PM_OPS(pm80x_rtc_pm_ops, pm80x_rtc_suspend, pm80x_rtc_resume);
 static int pm80x_rtc_probe(struct platform_device *pdev)
 {
 	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
-	struct pm80x_platform_data *pm80x_pdata =
-				dev_get_platdata(pdev->dev.parent);
-	struct pm80x_rtc_pdata *pdata = NULL;
+	struct pm80x_rtc_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct pm80x_rtc_info *info;
+	struct device_node *node = pdev->dev.of_node;
 	struct rtc_time tm;
 	unsigned long ticks = 0;
 	int ret;
 
-	pdata = dev_get_platdata(&pdev->dev);
-	if (pdata == NULL)
-		dev_warn(&pdev->dev, "No platform data!\n");
+	if (!pdata && !node) {
+		dev_err(&pdev->dev,
+			"pm80x-rtc requires platform data or of_node\n");
+		return -EINVAL;
+	}
+
+	if (!pdata) {
+		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata) {
+			dev_err(&pdev->dev, "failed to allocate memory\n");
+			return -ENOMEM;
+		}
+	}
 
 	info =
 	    devm_kzalloc(&pdev->dev, sizeof(struct pm80x_rtc_info), GFP_KERNEL);
@@ -327,11 +336,8 @@ static int pm80x_rtc_probe(struct platform_device *pdev)
 	regmap_update_bits(info->map, PM800_RTC_CONTROL, PM800_RTC1_USE_XO,
 			   PM800_RTC1_USE_XO);
 
-	if (pm80x_pdata) {
-		pdata = pm80x_pdata->rtc;
-		if (pdata)
-			info->rtc_dev->dev.platform_data = &pdata->rtc_wakeup;
-	}
+	/* remeber whether this power up is caused by PMIC RTC or not */
+	info->rtc_dev->dev.platform_data = &pdata->rtc_wakeup;
 
 	device_init_wakeup(&pdev->dev, 1);
 
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
