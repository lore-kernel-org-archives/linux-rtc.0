Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:50402 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933325AbdGLIXS (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 12 Jul 2017 04:23:18 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] rtc: Remove wrong deprecation comment
Date: Wed, 12 Jul 2017 10:23:13 +0200
Message-Id: <20170712082313.3417-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

rtc_time_to_tm and rtc_tm_to_time are not deprecated and make perfect sense
for RTCs that are simple 32bit counters.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 include/linux/rtc.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index b693adac853b..deb21a32ec43 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -32,17 +32,11 @@ static inline time64_t rtc_tm_sub(struct rtc_time *lhs, struct rtc_time *rhs)
 	return rtc_tm_to_time64(lhs) - rtc_tm_to_time64(rhs);
 }
 
-/**
- * Deprecated. Use rtc_time64_to_tm().
- */
 static inline void rtc_time_to_tm(unsigned long time, struct rtc_time *tm)
 {
 	rtc_time64_to_tm(time, tm);
 }
 
-/**
- * Deprecated. Use rtc_tm_to_time64().
- */
 static inline int rtc_tm_to_time(struct rtc_time *tm, unsigned long *time)
 {
 	*time = rtc_tm_to_time64(tm);
-- 
2.13.2
