Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46091 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752962AbdLMNxc (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 13 Dec 2017 08:53:32 -0500
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: akinobu.mita@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@free-electrons.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/2] rtc-r7301: Fix a possible sleep-in-atomic bug in rtc7301_read_time
Date: Wed, 13 Dec 2017 21:55:50 +0800
Message-Id: <1513173350-18385-1-git-send-email-baijiaju1990@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The driver may sleep under a spinlock.
The function call path is:
rtc7301_read_time (acquire the spinlock)
  rtc7301_wait_while_busy 
    usleep_range --> may sleep

To fix it, usleep_range is replaced with udelay.

This bug is found by my static analysis tool(DSAC) and checked by my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/rtc/rtc-r7301.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-r7301.c b/drivers/rtc/rtc-r7301.c
index 28d5408..d846e97 100644
--- a/drivers/rtc/rtc-r7301.c
+++ b/drivers/rtc/rtc-r7301.c
@@ -95,7 +95,7 @@ static int rtc7301_wait_while_busy(struct rtc7301_priv *priv)
 		if (!(val & RTC7301_CONTROL_BUSY))
 			return 0;
 
-		usleep_range(200, 300);
+		udelay(300);
 	}
 
 	return -ETIMEDOUT;
-- 
1.7.9.5
