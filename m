Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52687 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756247AbdJLWEZ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Oct 2017 18:04:25 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 1/2] rtc: m48t86: switch to rtc_register_device
Date: Fri, 13 Oct 2017 00:04:20 +0200
Message-Id: <20171012220421.7784-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This allows for future improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-m48t86.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index 02af045305dd..22656a90cfc5 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -228,6 +228,7 @@ static int m48t86_rtc_probe(struct platform_device *pdev)
 	struct m48t86_rtc_info *info;
 	struct resource *res;
 	unsigned char reg;
+	int err;
 
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
@@ -254,11 +255,16 @@ static int m48t86_rtc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	info->rtc = devm_rtc_device_register(&pdev->dev, "m48t86",
-					     &m48t86_rtc_ops, THIS_MODULE);
+	info->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(info->rtc))
 		return PTR_ERR(info->rtc);
 
+	info->rtc->ops = &m48t86_rtc_ops;
+
+	err = rtc_register_device(info->rtc);
+	if (err)
+		return err;
+
 	/* read battery status */
 	reg = m48t86_readb(&pdev->dev, M48T86_D);
 	dev_info(&pdev->dev, "battery %s\n",
-- 
2.14.2
