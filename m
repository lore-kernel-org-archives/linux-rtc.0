Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36652 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752832AbeFLEkK (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 12 Jun 2018 00:40:10 -0400
From: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: rtc-bq4802: add error handling for devm_ioremap
Date: Tue, 12 Jun 2018 12:40:03 +0800
Message-Id: <1528778404-41456-1-git-send-email-jiazhouyang09@gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

When devm_ioremap fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling devm_ioremap.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/rtc/rtc-bq4802.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/rtc/rtc-bq4802.c b/drivers/rtc/rtc-bq4802.c
index bd170cb..5747a54 100644
--- a/drivers/rtc/rtc-bq4802.c
+++ b/drivers/rtc/rtc-bq4802.c
@@ -164,6 +164,10 @@ static int bq4802_probe(struct platform_device *pdev)
 	} else if (p->r->flags & IORESOURCE_MEM) {
 		p->regs = devm_ioremap(&pdev->dev, p->r->start,
 					resource_size(p->r));
+		if (!p->regs){
+			err = -ENOMEM;
+			goto out;
+		}
 		p->read = bq4802_read_mem;
 		p->write = bq4802_write_mem;
 	} else {
-- 
2.7.4
