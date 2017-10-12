Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52727 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753283AbdJLWFe (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Oct 2017 18:05:34 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 2/3] rtc: ds1511: allow waking platform
Date: Fri, 13 Oct 2017 00:05:28 +0200
Message-Id: <20171012220529.8142-2-alexandre.belloni@free-electrons.com>
In-Reply-To: <20171012220529.8142-1-alexandre.belloni@free-electrons.com>
References: <20171012220529.8142-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Disabling interrupts when removing the driver is bad practice as this will
prevent some platform from waking up when using that RTC.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-ds1511.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index d44635178771..eda45358d63a 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -511,16 +511,8 @@ static int ds1511_rtc_probe(struct platform_device *pdev)
 
 static int ds1511_rtc_remove(struct platform_device *pdev)
 {
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
-
 	sysfs_remove_bin_file(&pdev->dev.kobj, &ds1511_nvram_attr);
-	if (pdata->irq > 0) {
-		/*
-		 * disable the alarm interrupt
-		 */
-		rtc_write(rtc_read(RTC_CMD) & ~RTC_TIE, RTC_CMD);
-		rtc_read(RTC_CMD1);
-	}
+
 	return 0;
 }
 
-- 
2.14.2
