Return-Path: <SRS0=XIIG=RG=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26068C43381
	for <linux-rtc@archiver.kernel.org>; Sun,  3 Mar 2019 21:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E800520830
	for <linux-rtc@archiver.kernel.org>; Sun,  3 Mar 2019 21:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfCCVpV (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 3 Mar 2019 16:45:21 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:57975 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfCCVpV (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 3 Mar 2019 16:45:21 -0500
X-Originating-IP: 82.246.155.60
Received: from localhost (hy283-1-82-246-155-60.fbx.proxad.net [82.246.155.60])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id AFBA9FF805;
        Sun,  3 Mar 2019 21:45:18 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] rtc: zynqmp: fix possible race condition
Date:   Sun,  3 Mar 2019 22:45:02 +0100
Message-Id: <20190303214503.17400-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The IRQ is requested before the struct rtc is allocated and registered, but
this struct is used in the IRQ handler. This may lead to a NULL pointer
dereference.

Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
struct before requesting the IRQ.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-zynqmp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index c532bd13fbe5..f0dd20785b54 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -222,6 +222,12 @@ static int xlnx_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, xrtcdev);
 
+	xrtcdev->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(xrtcdev->rtc))
+		return PTR_ERR(xrtcdev->rtc);
+
+	xrtcdev->rtc->ops = &xlnx_rtc_ops;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	xrtcdev->reg_base = devm_ioremap_resource(&pdev->dev, res);
@@ -263,9 +269,7 @@ static int xlnx_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	xrtcdev->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-					 &xlnx_rtc_ops, THIS_MODULE);
-	return PTR_ERR_OR_ZERO(xrtcdev->rtc);
+	return rtc_register_device(xrtcdev->rtc);
 }
 
 static int xlnx_rtc_remove(struct platform_device *pdev)
-- 
2.20.1

