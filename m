Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39638 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbeAZFHG (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 26 Jan 2018 00:07:06 -0500
Received: by mail-pf0-f196.google.com with SMTP id e11so7513283pff.6
        for <linux-rtc@vger.kernel.org>; Thu, 25 Jan 2018 21:07:06 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: arnd@arndb.de, broonie@kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolin.wang@linaro.org
Subject: [RESEND PATCH] rtc: Fix overflow when converting time64_t to rtc_time
Date: Fri, 26 Jan 2018 13:06:01 +0800
Message-Id: <a63f2b482281004df854d8345cb18368224880b6.1514200190.git.baolin.wang@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

If we convert one large time values to rtc_time, in the original formula
'days * 86400' can be overflowed in 'unsigned int' type to make the formula
get one incorrect remain seconds value. Thus we can use div_s64_rem()
function to avoid this situation.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/rtc/rtc-lib.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-lib.c b/drivers/rtc/rtc-lib.c
index 1ae7da5..ad5bb21 100644
--- a/drivers/rtc/rtc-lib.c
+++ b/drivers/rtc/rtc-lib.c
@@ -52,13 +52,11 @@ int rtc_year_days(unsigned int day, unsigned int month, unsigned int year)
  */
 void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
 {
-	unsigned int month, year;
-	unsigned long secs;
+	unsigned int month, year, secs;
 	int days;
 
 	/* time must be positive */
-	days = div_s64(time, 86400);
-	secs = time - (unsigned int) days * 86400;
+	days = div_s64_rem(time, 86400, &secs);
 
 	/* day of the week, 1970-01-01 was a Thursday */
 	tm->tm_wday = (days + 4) % 7;
-- 
1.7.9.5
