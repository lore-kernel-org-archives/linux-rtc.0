Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:40246 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbeIMBtg (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 12 Sep 2018 21:49:36 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: remove irq_task from kerneldoc
Date: Wed, 12 Sep 2018 22:43:07 +0200
Message-Id: <20180912204307.16373-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Stale mentions of irq_task are left in the kerneldoc after its removal.
Remove them.

There is still one indirect mention left but commit 3c8bb90efb6e ("rtc: Fix
hrtimer deadlock") can probably be reverted now.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/interface.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 3d577e259e91..612a83d3ddcc 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -596,7 +596,6 @@ EXPORT_SYMBOL_GPL(rtc_update_irq_enable);
  * This function is called when an AIE, UIE or PIE mode interrupt
  * has occurred (or been emulated).
  *
- * Triggers the registered irq_task function callback.
  */
 void rtc_handle_legacy_irq(struct rtc_device *rtc, int num, int mode)
 {
@@ -741,7 +740,6 @@ static int rtc_update_hrtimer(struct rtc_device *rtc, int enabled)
 /**
  * rtc_irq_set_state - enable/disable 2^N Hz periodic IRQs
  * @rtc: the rtc device
- * @task: currently registered with rtc_irq_register()
  * @enabled: true to enable periodic IRQs
  * Context: any
  *
@@ -764,7 +762,6 @@ int rtc_irq_set_state(struct rtc_device *rtc, int enabled)
 /**
  * rtc_irq_set_freq - set 2^N Hz periodic IRQ frequency for IRQ
  * @rtc: the rtc device
- * @task: currently registered with rtc_irq_register()
  * @freq: positive frequency
  * Context: any
  *
-- 
2.19.0.rc2
