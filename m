Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:64502 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752560AbdKBJQx (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 2 Nov 2017 05:16:53 -0400
To: linux-rtc@vger.kernel.org, support.opensource@diasemi.com,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] rtc-da9063: Use common error handling code in
 da9063_rtc_probe()
Message-ID: <8733cf61-1c1a-cc3b-a6e9-37b9a5f8cc70@users.sourceforge.net>
Date: Thu, 2 Nov 2017 10:16:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 2 Nov 2017 09:45:46 +0100

* Add a jump target so that a specific error message is stored only once
  at the end of this function implementation.

* Replace two calls of the function "dev_err" by goto statements.

* Adjust two condition checks.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/rtc/rtc-da9063.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
index f85cae240f12..c5cbd40666aa 100644
--- a/drivers/rtc/rtc-da9063.c
+++ b/drivers/rtc/rtc-da9063.c
@@ -436,19 +436,15 @@ static int da9063_rtc_probe(struct platform_device *pdev)
 				 config->rtc_alarm_secs_reg,
 				 config->rtc_alarm_status_mask,
 				 0);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to access RTC alarm register\n");
-		return ret;
-	}
+	if (ret)
+		goto report_access_failure;
 
 	ret = regmap_update_bits(rtc->regmap,
 				 config->rtc_alarm_secs_reg,
 				 DA9063_ALARM_STATUS_ALARM,
 				 DA9063_ALARM_STATUS_ALARM);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to access RTC alarm register\n");
-		return ret;
-	}
+	if (ret)
+		goto report_access_failure;
 
 	ret = regmap_update_bits(rtc->regmap,
 				 config->rtc_alarm_year_reg,
@@ -490,6 +486,10 @@ static int da9063_rtc_probe(struct platform_device *pdev)
 			irq_alarm, ret);
 
 	return ret;
+
+report_access_failure:
+	dev_err(&pdev->dev, "Failed to access RTC alarm register\n");
+	return ret;
 }
 
 static struct platform_driver da9063_rtc_driver = {
-- 
2.14.3
