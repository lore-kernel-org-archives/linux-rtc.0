Return-Path: <rtc-linux+bncBDMITSXR5QMBB5736K4QKGQEOUPAUCY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.22])
        by gmr-mx.google.com with ESMTPS id u18si905531wmd.1.2016.05.18.12.09.42
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 May 2016 12:09:43 -0700 (PDT)
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Joshua Kinard <kumba@gentoo.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [rtc-linux] [PATCH 1/1] rtc: ds1685: correct check of day of month
Date: Wed, 18 May 2016 21:09:29 +0200
Message-Id: <1463598569-4329-1-git-send-email-xypron.glpk@gmx.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Operator ! has a higher priority than &&.
(!(mday >= 1) && (mday <= 31)) is false for mday == 32.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 drivers/rtc/rtc-ds1685.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index b3ce3c6..b4fae3c 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -389,7 +389,7 @@ ds1685_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	ds1685_rtc_end_data_access(rtc);
 
 	/* Check month date. */
-	if (!(mday >= 1) && (mday <= 31))
+	if ((mday < 1) || (mday > 31))
 		return -EDOM;
 
 	/*
@@ -461,7 +461,7 @@ ds1685_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 				     RTC_MDAY_BCD_MASK);
 
 	/* Check the month date for validity. */
-	if (!(mday >= 1) && (mday <= 31))
+	if ((mday < 1) || (mday > 31))
 		return -EDOM;
 
 	/*
-- 
2.1.4

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
