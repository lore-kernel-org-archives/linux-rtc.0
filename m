Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:42513 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752155AbdI1MLj (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 28 Sep 2017 08:11:39 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] rtc: set the alarm to the next expiring timer
Date: Thu, 28 Sep 2017 14:11:32 +0200
Message-Id: <20170928121132.9454-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

If there is any non expired timer in the queue, the RTC alarm is never set.
This is an issue when adding a timer that expires before the next non
expired timer.

Ensure the RTC alarm is set in that case.

Fixes: 2b2f5ff00f63 ("rtc: interface: ignore expired timers when enqueuing new timers")
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 8cec9a02c0b8..9eb32ead63db 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -779,7 +779,7 @@ static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *timer)
 	}
 
 	timerqueue_add(&rtc->timerqueue, &timer->node);
-	if (!next) {
+	if (!next || ktime_before(timer->node.expires, next->expires)) {
 		struct rtc_wkalrm alarm;
 		int err;
 		alarm.time = rtc_ktime_to_tm(timer->node.expires);
-- 
2.14.2
