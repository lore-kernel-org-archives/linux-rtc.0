Return-Path: <rtc-linux+bncBAABB45UQOZQKGQEBAZ7HCY@googlegroups.com>
MIME-Version: 1.0
Received: from aserp1040.oracle.com (aserp1040.oracle.com. [141.146.126.69])
        by gmr-mx.google.com with ESMTPS id mv7si100954igb.0.2015.12.03.16.12.34
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2015 16:12:34 -0800 (PST)
From: Sasha Levin <sasha.levin@oracle.com>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [rtc-linux] [PATCH] rtc: fix overflow and incorrect calculation in rtc_time64_to_tm
Date: Thu,  3 Dec 2015 19:12:24 -0500
Message-Id: <1449187944-11730-1-git-send-email-sasha.levin@oracle.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

At some point after humans go extinct and robots cotrol the world, dividing
he time64_t by 86400 to extract the days will overflow a 32bit integer,
leading to incorrect conversion into rtc_time in rtc_time64_to_tm().

Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 drivers/rtc/rtc-lib.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-lib.c b/drivers/rtc/rtc-lib.c
index e6bfb9c..459cd4d 100644
--- a/drivers/rtc/rtc-lib.c
+++ b/drivers/rtc/rtc-lib.c
@@ -54,11 +54,11 @@ void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
 {
 	unsigned int month, year;
 	unsigned long secs;
-	int days;
+	time64_t days;
 
 	/* time must be positive */
 	days = div_s64(time, 86400);
-	secs = time - (unsigned int) days * 86400;
+	secs = time - days * 86400;
 
 	/* day of the week, 1970-01-01 was a Thursday */
 	tm->tm_wday = (days + 4) % 7;
-- 
1.7.10.4

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
