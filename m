Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:40934 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762260AbdKQVQJ (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 17 Nov 2017 16:16:09 -0500
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Brian Norris <computersforpeace@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        bcm-kernel-feedback-list@broadcom.com, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] rtc: brcmstb-waketimer: fix error handling in brcmstb_waketmr_probe()
Date: Sat, 18 Nov 2017 00:15:58 +0300
Message-Id: <1510953358-7043-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

brcmstb_waketmr_probe() does not disable timer->clk on error paths.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/rtc/rtc-brcmstb-waketimer.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-waketimer.c
index 796ac792a381..6cee61201c30 100644
--- a/drivers/rtc/rtc-brcmstb-waketimer.c
+++ b/drivers/rtc/rtc-brcmstb-waketimer.c
@@ -253,7 +253,7 @@ static int brcmstb_waketmr_probe(struct platform_device *pdev)
 	ret = devm_request_irq(dev, timer->irq, brcmstb_waketmr_irq, 0,
 			       "brcmstb-waketimer", timer);
 	if (ret < 0)
-		return ret;
+		goto err_clk;
 
 	timer->reboot_notifier.notifier_call = brcmstb_waketmr_reboot;
 	register_reboot_notifier(&timer->reboot_notifier);
@@ -262,12 +262,21 @@ static int brcmstb_waketmr_probe(struct platform_device *pdev)
 					 &brcmstb_waketmr_ops, THIS_MODULE);
 	if (IS_ERR(timer->rtc)) {
 		dev_err(dev, "unable to register device\n");
-		unregister_reboot_notifier(&timer->reboot_notifier);
-		return PTR_ERR(timer->rtc);
+		ret = PTR_ERR(timer->rtc);
+		goto err_notifier;
 	}
 
 	dev_info(dev, "registered, with irq %d\n", timer->irq);
 
+	return 0;
+
+err_notifier:
+	unregister_reboot_notifier(&timer->reboot_notifier);
+
+err_clk:
+	if (timer->clk)
+		clk_disable_unprepare(timer->clk);
+
 	return ret;
 }
 
-- 
2.7.4
