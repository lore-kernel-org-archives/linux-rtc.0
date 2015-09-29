Return-Path: <rtc-linux+bncBDS7HNEFSALRB6XYVOYAKGQE5W3HPIQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id fj10si802710wib.1.2015.09.29.14.02.49
        for <rtc-linux@googlegroups.com>;
        Tue, 29 Sep 2015 14:02:49 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] rtc: pcf85063: return an error when date is invalid
Date: Tue, 29 Sep 2015 23:02:46 +0200
Message-Id: <1443560566-20136-1-git-send-email-alexandre.belloni@free-electrons.com>
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

Return an error when the date is invalid as the policy should be
implemented there.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-pcf85063.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index b6d73dd881f2..63334cbeca41 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -80,13 +80,7 @@ static int pcf85063_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 	pcf85063->c_polarity = (buf[PCF85063_REG_MO] & PCF85063_MO_C) ?
 		(tm->tm_year >= 100) : (tm->tm_year < 100);
 
-	/* the clock can give out invalid datetime, but we cannot return
-	 * -EINVAL otherwise hwclock will refuse to set the time on bootup.
-	 */
-	if (rtc_valid_tm(tm) < 0)
-		dev_err(&client->dev, "retrieved date/time is not valid.\n");
-
-	return 0;
+	return rtc_valid_tm(tm);
 }
 
 static int pcf85063_set_datetime(struct i2c_client *client, struct rtc_time *tm)
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
