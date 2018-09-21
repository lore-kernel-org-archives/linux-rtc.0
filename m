Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:54766 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725748AbeIVFN4 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sat, 22 Sep 2018 01:13:56 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: lib: correct documentation typo
Date: Sat, 22 Sep 2018 01:22:34 +0200
Message-Id: <20180921232234.23164-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

rtc_time64_to_tm has not been called rtc_time_to_tm64

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-lib.c b/drivers/rtc/rtc-lib.c
index 4a3c0f3aab14..ef160da84220 100644
--- a/drivers/rtc/rtc-lib.c
+++ b/drivers/rtc/rtc-lib.c
@@ -47,7 +47,7 @@ EXPORT_SYMBOL(rtc_year_days);
 
 
 /*
- * rtc_time_to_tm64 - Converts time64_t to rtc_time.
+ * rtc_time64_to_tm - Converts time64_t to rtc_time.
  * Convert seconds since 01-01-1970 00:00:00 to Gregorian date.
  */
 void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
-- 
2.19.0
