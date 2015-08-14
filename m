Return-Path: <rtc-linux+bncBCEPHYMUQEJRBGXPXCXAKGQEJ7BXKCQ@googlegroups.com>
Received: from mx02.posteo.de (mx02.posteo.de. [89.146.194.165])
        by gmr-mx.google.com with ESMTPS id jv9si113914wid.0.2015.08.14.11.46.50
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Aug 2015 11:46:50 -0700 (PDT)
Date: Fri, 14 Aug 2015 20:44:02 +0200
From: Bibek Basu <bbasu@nvidia.com>
To: rtc-linux@googlegroups.com
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH v2] drivers/rtc/rtc-as3722: correct month value
Message-ID: <20150814184402.GA8953@nyan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150814084515.GH22269@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

The RTCmonth value is 1-indexed, but the kernel assumes it is 0-indexed.
This may result in the RTC not rolling over correctly.

Signed-off-by: Bibek Basu <bbasu@nvidia.com>
Signed-off-by: Felix Janda <felix.janda@posteo.de>
---
v1 -> v2: Correct attribution and use original commit message
---
 drivers/rtc/rtc-as3722.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-as3722.c b/drivers/rtc/rtc-as3722.c
index 9f38eda..56cc582 100644
--- a/drivers/rtc/rtc-as3722.c
+++ b/drivers/rtc/rtc-as3722.c
@@ -45,7 +45,7 @@ static void as3722_time_to_reg(u8 *rbuff, struct rtc_time *tm)
 	rbuff[1] = bin2bcd(tm->tm_min);
 	rbuff[2] = bin2bcd(tm->tm_hour);
 	rbuff[3] = bin2bcd(tm->tm_mday);
-	rbuff[4] = bin2bcd(tm->tm_mon);
+	rbuff[4] = bin2bcd(tm->tm_mon + 1);
 	rbuff[5] = bin2bcd(tm->tm_year - (AS3722_RTC_START_YEAR - 1900));
 }
 
@@ -55,7 +55,7 @@ static void as3722_reg_to_time(u8 *rbuff, struct rtc_time *tm)
 	tm->tm_min = bcd2bin(rbuff[1] & 0x7F);
 	tm->tm_hour = bcd2bin(rbuff[2] & 0x3F);
 	tm->tm_mday = bcd2bin(rbuff[3] & 0x3F);
-	tm->tm_mon = bcd2bin(rbuff[4] & 0x1F);
+	tm->tm_mon = bcd2bin(rbuff[4] & 0x1F) - 1;
 	tm->tm_year = (AS3722_RTC_START_YEAR - 1900) + bcd2bin(rbuff[5] & 0x7F);
 	return;
 }
-- 
2.4.6

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
