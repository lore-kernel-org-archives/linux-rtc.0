Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:32967 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753130AbdLMNxq (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 13 Dec 2017 08:53:46 -0500
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: akinobu.mita@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@free-electrons.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/2] rtc-r7301: Fix a possible sleep-in-atomic bug in rtc7301_set_time
Date: Wed, 13 Dec 2017 21:56:04 +0800
Message-Id: <1513173364-18424-1-git-send-email-baijiaju1990@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The driver may sleep under a spinlock.
The function call path is:
rtc7301_set_time (acquire the spinlock)
  usleep_range --> may sleep

To fix it, usleep_range is replaced with udelay.

This bug is found by my static analysis tool(DSAC) and checked by my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/rtc/rtc-r7301.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-r7301.c b/drivers/rtc/rtc-r7301.c
index 28d5408..a040536 100644
--- a/drivers/rtc/rtc-r7301.c
+++ b/drivers/rtc/rtc-r7301.c
@@ -235,7 +235,7 @@ static int rtc7301_set_time(struct device *dev, struct rtc_time *tm)
 	spin_lock_irqsave(&priv->lock, flags);
 
 	rtc7301_stop(priv);
-	usleep_range(200, 300);
+	udelay(300);
 	rtc7301_select_bank(priv, 0);
 	rtc7301_write_time(priv, tm, false);
 	rtc7301_start(priv);
-- 
1.7.9.5
