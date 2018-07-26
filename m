Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:59278 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729839AbeGZO6S (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 26 Jul 2018 10:58:18 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/8] rtc: sa1100: don't set PIE frequency
Date: Thu, 26 Jul 2018 15:40:49 +0200
Message-Id: <20180726134056.18273-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
References: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

It doesn't make sense to set the PIE frequency from the driver. Let
userspace do its job.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-sa1100.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index ed71d1113627..304d905cb23f 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -224,7 +224,6 @@ int sa1100_rtc_init(struct platform_device *pdev, struct sa1100_rtc *info)
 	info->rtc = rtc;
 
 	rtc->max_user_freq = RTC_FREQ;
-	rtc_irq_set_freq(rtc, NULL, RTC_FREQ);
 
 	/* Fix for a nasty initialization problem the in SA11xx RTSR register.
 	 * See also the comments in sa1100_rtc_interrupt().
-- 
2.18.0
