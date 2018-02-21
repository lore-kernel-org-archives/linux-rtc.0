Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:47020 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbeBUU5i (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 21 Feb 2018 15:57:38 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 056/100] rtc: pic32: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:51 +0100
Message-Id: <20180221205635.31314-57-alexandre.belloni@bootlin.com>
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The RTC core is always calling rtc_valid_tm after the read_time callback.
It is not necessary to call it just before returning from the callback.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pic32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pic32.c b/drivers/rtc/rtc-pic32.c
index 5cfb6df5c430..3c08eab4f1a8 100644
--- a/drivers/rtc/rtc-pic32.c
+++ b/drivers/rtc/rtc-pic32.c
@@ -175,7 +175,7 @@ static int pic32_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 		rtc_tm->tm_hour, rtc_tm->tm_min, rtc_tm->tm_sec);
 
 	clk_disable(pdata->clk);
-	return rtc_valid_tm(rtc_tm);
+	return 0;
 }
 
 static int pic32_rtc_settime(struct device *dev, struct rtc_time *tm)
-- 
2.16.1
