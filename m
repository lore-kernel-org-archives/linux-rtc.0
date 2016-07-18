Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBONZWK6AKGQELCGDHJQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id r74si471189wme.3.2016.07.18.02.09.11
        for <rtc-linux@googlegroups.com>;
        Mon, 18 Jul 2016 02:09:11 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] rtc: pcf85063: fix year range
Date: Mon, 18 Jul 2016 11:08:59 +0200
Message-Id: <1468832939-16058-1-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The year range is not validated properly

As the driver has been mainlined in 2014, it is not an issue to stop
handling dates between 1970 and 2000 with the benefit of handling dates up
to 2100.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-pcf85063.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index e8ddbb359d11..f7d27b6857e6 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -57,7 +57,7 @@ static int pcf85063_stop_clock(struct i2c_client *client, u8 *ctrl1)
 
 /*
  * In the routines that deal directly with the pcf85063 hardware, we use
- * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
+ * rtc_time -- month 0-11, hour 0-23, yr = calendar year-100.
  */
 static int pcf85063_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 {
@@ -90,8 +90,7 @@ static int pcf85063_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 	tm->tm_wday = regs[4] & 0x07;
 	tm->tm_mon = bcd2bin(regs[5] & 0x1F) - 1; /* rtc mn 1-12 */
 	tm->tm_year = bcd2bin(regs[6]);
-	if (tm->tm_year < 70)
-		tm->tm_year += 100;	/* assume we are in 1970...2069 */
+	tm->tm_year += 100;
 
 	return rtc_valid_tm(tm);
 }
@@ -101,6 +100,9 @@ static int pcf85063_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 	int rc;
 	u8 regs[8];
 
+	if ((tm->tm_year < 100) || (tm->tm_year > 199))
+		return -EINVAL;
+
 	/*
 	 * to accurately set the time, reset the divider chain and keep it in
 	 * reset state until all time/date registers are written
@@ -125,7 +127,7 @@ static int pcf85063_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 	regs[5] = bin2bcd(tm->tm_mon + 1);
 
 	/* year and century */
-	regs[6] = bin2bcd(tm->tm_year % 100);
+	regs[6] = bin2bcd(tm->tm_year - 100);
 
 	/*
 	 * after all time/date registers are written, let the 'address auto
-- 
2.8.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
