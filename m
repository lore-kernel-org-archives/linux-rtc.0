Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44691 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbeG3P21 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 30 Jul 2018 11:28:27 -0400
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] rtc: rtc-omap: Replace mdelay() with msleep() in omap_rtc_power_off()
Date: Mon, 30 Jul 2018 21:53:14 +0800
Message-Id: <20180730135314.9336-1-baijiaju1990@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

omap_rtc_power_off() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/rtc/rtc-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 39086398833e..ef3d09525d0f 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -476,7 +476,7 @@ static void omap_rtc_power_off(void)
 	 * power off the system. Add a 500 ms margin for external latencies
 	 * (e.g. debounce circuits).
 	 */
-	mdelay(2500);
+	msleep(2500);
 }
 
 static const struct rtc_class_ops omap_rtc_ops = {
-- 
2.17.0
