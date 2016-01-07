Return-Path: <rtc-linux+bncBAABBIFMXG2AKGQELE6XEMA@googlegroups.com>
MIME-Version: 1.0
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id ui7si5690980pab.0.2016.01.07.04.12.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 07 Jan 2016 04:12:16 -0800 (PST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O0L00KUU0KBG570@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Thu, 07 Jan 2016 12:12:11 +0000 (GMT)
From: Andrzej Hajda <a.hajda@samsung.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 rtc-linux@googlegroups.com (open list:REAL TIME CLOCK (RTC) SUBSYSTEM)
Cc: Andrzej Hajda <a.hajda@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: [rtc-linux] [PATCH] rtc: fix rtc_time64_to_tm calculation
Date: Thu, 07 Jan 2016 13:11:50 +0100
Message-id: <1452168710-16317-1-git-send-email-a.hajda@samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Type of local variable days has been changed recently to unsigned,
but it can take negative values. As a result it works incorrectly for some
arguments. The patch fixes it.

The problem has been detected using proposed semantic patch
scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2120705

Fixes: cab572b82c4b ('rtc: fix overflow and incorrect calculation in rtc_time64_to_tm')
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/rtc/rtc-lib.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-lib.c b/drivers/rtc/rtc-lib.c
index cf2b23c..6323d13 100644
--- a/drivers/rtc/rtc-lib.c
+++ b/drivers/rtc/rtc-lib.c
@@ -54,7 +54,7 @@ void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
 {
 	unsigned int month, year;
 	int secs;
-	unsigned long days;
+	unsigned long days, leaps;
 
 	/*
 	 * time must be positive
@@ -66,13 +66,16 @@ void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
 	tm->tm_wday = (days + 4) % 7;
 
 	year = 1970 + days / 365;
-	days -= (year - 1970) * 365
-		+ LEAPS_THRU_END_OF(year - 1)
-		- LEAPS_THRU_END_OF(1970 - 1);
-	if (days < 0) {
+	days -= (year - 1970) * 365;
+	leaps = LEAPS_THRU_END_OF(year - 1) - LEAPS_THRU_END_OF(1970 - 1);
+
+	while (days < leaps) {
 		year -= 1;
 		days += 365 + is_leap_year(year);
 	}
+
+	days -= leaps;
+
 	tm->tm_year = year - 1900;
 	tm->tm_yday = days + 1;
 
-- 
1.9.1

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
