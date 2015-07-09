Return-Path: <rtc-linux+bncBCMNZUWXYYORBAFX7CWAKGQEOPETTTY@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com. [209.85.192.174])
        by gmr-mx.google.com with ESMTPS id ns6si498314pbc.2.2015.07.08.23.58.08
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2015 23:58:08 -0700 (PDT)
Received: by pdrg1 with SMTP id g1so28260538pdr.2
        for <rtc-linux@googlegroups.com>; Wed, 08 Jul 2015 23:58:08 -0700 (PDT)
From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>,
	Chao Xie <chao.xie@marvell.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com (open list:REAL TIME CLOCK (RTC) SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [rtc-linux] [RESEND PATCH-v2] rtc: 88pm80x: add device tree support
Date: Thu,  9 Jul 2015 12:25:51 +0530
Message-Id: <1436424952-29680-1-git-send-email-vaibhav.hiremath@linaro.org>
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
