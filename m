Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:59288 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730198AbeGZO6W (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 26 Jul 2018 10:58:22 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6/8] rtc: unexport rtc_irq_set_*
Date: Thu, 26 Jul 2018 15:40:54 +0200
Message-Id: <20180726134056.18273-7-alexandre.belloni@bootlin.com>
In-Reply-To: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
References: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Make the rtc_irq_set interface internale to the RTC subsystem.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/interface.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 76eb3a2957cc..d0983ed6c842 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -758,7 +758,6 @@ int rtc_irq_set_state(struct rtc_device *rtc, int enabled)
 	trace_rtc_irq_set_state(enabled, err);
 	return err;
 }
-EXPORT_SYMBOL_GPL(rtc_irq_set_state);
 
 /**
  * rtc_irq_set_freq - set 2^N Hz periodic IRQ frequency for IRQ
@@ -784,7 +783,6 @@ int rtc_irq_set_freq(struct rtc_device *rtc, int freq)
 	trace_rtc_irq_set_freq(freq, err);
 	return err;
 }
-EXPORT_SYMBOL_GPL(rtc_irq_set_freq);
 
 /**
  * rtc_timer_enqueue - Adds a rtc_timer to the rtc_device timerqueue
-- 
2.18.0
