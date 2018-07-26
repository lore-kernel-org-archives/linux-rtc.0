Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:59309 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730198AbeGZO6Y (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 26 Jul 2018 10:58:24 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7/8] char: rtc: remove task handling
Date: Thu, 26 Jul 2018 15:40:55 +0200
Message-Id: <20180726134056.18273-8-alexandre.belloni@bootlin.com>
In-Reply-To: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
References: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Since commit 9e7002a70e42 ("char: rtc: remove unused rtc_control() API"),
it is not possible to set a callback anymore, remove its handling from the
interrupt handler.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
Hi,

My plan is to take that patch through the RTC tree because the next patch relies
on the rtc_task_t *rtc_callback removal.

 drivers/char/rtc.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/char/rtc.c b/drivers/char/rtc.c
index 94fedeeec035..4948c8bda6b1 100644
--- a/drivers/char/rtc.c
+++ b/drivers/char/rtc.c
@@ -193,14 +193,6 @@ static unsigned long rtc_freq;		/* Current periodic IRQ rate	*/
 static unsigned long rtc_irq_data;	/* our output to the world	*/
 static unsigned long rtc_max_user_freq = 64; /* > this, need CAP_SYS_RESOURCE */
 
-#ifdef RTC_IRQ
-/*
- * rtc_task_lock nests inside rtc_lock.
- */
-static DEFINE_SPINLOCK(rtc_task_lock);
-static rtc_task_t *rtc_callback;
-#endif
-
 /*
  *	If this driver ever becomes modularised, it will be really nice
  *	to make the epoch retain its value across module reload...
@@ -264,11 +256,6 @@ static irqreturn_t rtc_interrupt(int irq, void *dev_id)
 
 	spin_unlock(&rtc_lock);
 
-	/* Now do the rest of the actions */
-	spin_lock(&rtc_task_lock);
-	if (rtc_callback)
-		rtc_callback->func(rtc_callback->private_data);
-	spin_unlock(&rtc_task_lock);
 	wake_up_interruptible(&rtc_wait);
 
 	kill_fasync(&rtc_async_queue, SIGIO, POLL_IN);
-- 
2.18.0
