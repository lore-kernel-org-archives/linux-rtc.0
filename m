Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:52585 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeDTQO6 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 20 Apr 2018 12:14:58 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] rtc: ls1x: remove mktime usage
Date: Fri, 20 Apr 2018 18:14:25 +0200
Message-Id: <20180420161433.3721192-2-arnd@arndb.de>
In-Reply-To: <20180420161433.3721192-1-arnd@arndb.de>
References: <20180420161433.3721192-1-arnd@arndb.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The loongson1 platform is 32-bit, so storing a time value in 32 bits
suffers from limited range. In this case it is likely to be correct
until 2106, but it's better to avoid the limitation and just use
the time64_t based mktime64() and rtc_time64_to_tm() interfaces.

The hardware uses a 32-bit year number, and time64_t can cover that
entire range.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-ls1x.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ls1x.c b/drivers/rtc/rtc-ls1x.c
index 045af1135e48..de86f9fabc11 100644
--- a/drivers/rtc/rtc-ls1x.c
+++ b/drivers/rtc/rtc-ls1x.c
@@ -87,16 +87,17 @@
 
 static int ls1x_rtc_read_time(struct device *dev, struct rtc_time *rtm)
 {
-	unsigned long v, t;
+	unsigned long v;
+	time64_t t;
 
 	v = readl(SYS_TOYREAD0);
 	t = readl(SYS_TOYREAD1);
 
 	memset(rtm, 0, sizeof(struct rtc_time));
-	t  = mktime((t & LS1X_YEAR_MASK), ls1x_get_month(v),
+	t  = mktime64((t & LS1X_YEAR_MASK), ls1x_get_month(v),
 			ls1x_get_day(v), ls1x_get_hour(v),
 			ls1x_get_min(v), ls1x_get_sec(v));
-	rtc_time_to_tm(t, rtm);
+	rtc_time64_to_tm(t, rtm);
 
 	return 0;
 }
-- 
2.9.0
