Return-Path: <rtc-linux+bncBCS7NNUK74ORBH72S2VQKGQEDMIUF2A@googlegroups.com>
MIME-Version: 1.0
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com. [209.85.217.179])
        by gmr-mx.google.com with ESMTPS id bm9si1163174lbb.0.2015.05.27.05.48.31
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2015 05:48:31 -0700 (PDT)
Received: by mail-lb0-f179.google.com with SMTP id ue7so6403904lbc.0
        for <rtc-linux@googlegroups.com>; Wed, 27 May 2015 05:48:31 -0700 (PDT)
From: Jan Kardell <jan.kardell@telliq.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Vincent Donnefort <vdonnefort@gmail.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	oen@telliq.com
Subject: [rtc-linux] [PATCH v2] rtc: pcf8563 fix: return -EINVAL if we read an
 invalid time.
Date: Wed, 27 May 2015 14:48:16 +0200
Message-Id: <1432730896-13423-1-git-send-email-jan.kardell@telliq.com>
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

Return -EINVAL if the voltage low bit is set to avoid getting a bogus
time at boot.
There was a comment stating that util-linux hwclock refuses to set a
new time if we return an error code on read, but at least the current
version do set the time as expected. Remove the comment and the check
for valid time, and let the rtc core check it for us.

Changes in v2: Remove the test for invalid time. Change dev_err to
dev_info when voltage low is set.

Signed-off-by: Jan Kardell <jan.kardell@telliq.com>
---
 drivers/rtc/rtc-pcf8563.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 0ba7e59..6ce0a86 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -22,7 +22,7 @@
 #include <linux/of.h>
 #include <linux/err.h>
 
-#define DRV_VERSION "0.4.3"
+#define DRV_VERSION "0.4.4"
 
 #define PCF8563_REG_ST1		0x00 /* status */
 #define PCF8563_REG_ST2		0x01
@@ -204,6 +204,7 @@ static int pcf8563_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 		pcf8563->voltage_low = 1;
 		dev_info(&client->dev,
 			"low voltage detected, date/time is not reliable.\n");
+		return -EINVAL;
 	}
 
 	dev_dbg(&client->dev,
@@ -234,12 +235,6 @@ static int pcf8563_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 		tm->tm_sec, tm->tm_min, tm->tm_hour,
 		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
 
-	/* the clock can give out invalid datetime, but we cannot return
-	 * -EINVAL otherwise hwclock will refuse to set the time on bootup.
-	 */
-	if (rtc_valid_tm(tm) < 0)
-		dev_err(&client->dev, "retrieved date/time is not valid.\n");
-
 	return 0;
 }
 
-- 
1.8.4.5

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
