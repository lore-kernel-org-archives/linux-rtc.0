Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46574 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeG3Pe6 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 30 Jul 2018 11:34:58 -0400
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] rtc: rtc-mrst: Replace mdelay() with msleep() in mrst_read_time()
Date: Mon, 30 Jul 2018 21:59:03 +0800
Message-Id: <20180730135903.9442-1-baijiaju1990@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

mrst_read_time() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/rtc/rtc-mrst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mrst.c b/drivers/rtc/rtc-mrst.c
index fcb9de5218b2..e4015f70f9fe 100644
--- a/drivers/rtc/rtc-mrst.c
+++ b/drivers/rtc/rtc-mrst.c
@@ -91,7 +91,7 @@ static int mrst_read_time(struct device *dev, struct rtc_time *time)
 	unsigned long flags;
 
 	if (vrtc_is_updating())
-		mdelay(20);
+		msleep(20);
 
 	spin_lock_irqsave(&rtc_lock, flags);
 	time->tm_sec = vrtc_cmos_read(RTC_SECONDS);
-- 
2.17.0
