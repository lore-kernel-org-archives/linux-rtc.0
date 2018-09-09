Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:47526 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbeIJCGS (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sun, 9 Sep 2018 22:06:18 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Matt Turner <mattst88@gmail.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] alpha: rtc: simplify alpha_rtc_init
Date: Sun,  9 Sep 2018 23:15:04 +0200
Message-Id: <20180909211504.11768-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use devm_rtc_allocate_device to simplify choosing the rtc_ops in
alpha_rtc_init().

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/alpha/kernel/rtc.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/alpha/kernel/rtc.c b/arch/alpha/kernel/rtc.c
index 1376a2867048..1b1d5963ac55 100644
--- a/arch/alpha/kernel/rtc.c
+++ b/arch/alpha/kernel/rtc.c
@@ -198,26 +198,24 @@ static const struct rtc_class_ops remote_rtc_ops = {
 static int __init
 alpha_rtc_init(void)
 {
-	const struct rtc_class_ops *ops;
 	struct platform_device *pdev;
 	struct rtc_device *rtc;
-	const char *name;
 
 	init_rtc_epoch();
-	name = "rtc-alpha";
-	ops = &alpha_rtc_ops;
 
-#ifdef HAVE_REMOTE_RTC
-	if (alpha_mv.rtc_boot_cpu_only)
-		ops = &remote_rtc_ops;
-#endif
-
-	pdev = platform_device_register_simple(name, -1, NULL, 0);
-	rtc = devm_rtc_device_register(&pdev->dev, name, ops, THIS_MODULE);
+	pdev = platform_device_register_simple("rtc-alpha", -1, NULL, 0);
+	rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
 	platform_set_drvdata(pdev, rtc);
-	return 0;
+	rtc->ops = &alpha_rtc_ops;
+
+#ifdef HAVE_REMOTE_RTC
+	if (alpha_mv.rtc_boot_cpu_only)
+		rtc->ops = &remote_rtc_ops;
+#endif
+
+	return rtc_register_device(rtc);
 }
 device_initcall(alpha_rtc_init);
-- 
2.19.0.rc2
