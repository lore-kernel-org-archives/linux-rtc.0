Return-Path: <rtc-linux+bncBDS7HNEFSALRBO6LWO3AKGQEII4Z66A@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c143si23833wmd.1.2016.02.23.15.05.31
        for <rtc-linux@googlegroups.com>;
        Tue, 23 Feb 2016 15:05:31 -0800 (PST)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Juergen Borleis <jbe@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] rtc: pcf85063: remove useless century handling
Date: Wed, 24 Feb 2016 00:05:28 +0100
Message-Id: <1456268728-343-1-git-send-email-alexandre.belloni@free-electrons.com>
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

pcf85063_get_datetime() tries to handle a century bit but that bit is not
documented and the final value is never used anywhere else in the kernel.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-pcf85063.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index c5db231f14de..2b3b99b094b5 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -31,13 +31,10 @@
 #define PCF85063_REG_MO			0x09
 #define PCF85063_REG_YR			0x0A
 
-#define PCF85063_MO_C			0x80 /* century */
-
 static struct i2c_driver pcf85063_driver;
 
 struct pcf85063 {
 	struct rtc_device *rtc;
-	int c_polarity;	/* 0: MO_C=1 means 19xx, otherwise MO_C=1 means 20xx */
 	int voltage_low; /* indicates if a low_voltage was detected */
 };
 
@@ -103,9 +100,6 @@ static int pcf85063_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 	tm->tm_year = bcd2bin(regs[6]);
 	if (tm->tm_year < 70)
 		tm->tm_year += 100;	/* assume we are in 1970...2069 */
-	/* detect the polarity heuristically. see note above. */
-	pcf85063->c_polarity = (regs[5] & PCF85063_MO_C) ?
-		(tm->tm_year >= 100) : (tm->tm_year < 100);
 
 	return rtc_valid_tm(tm);
 }
-- 
2.7.0

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
