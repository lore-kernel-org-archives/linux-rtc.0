Return-Path: <rtc-linux+bncBAABBLOYSCVQKGQESNG6M3Q@googlegroups.com>
MIME-Version: 1.0
Received: from mx.dave-tech.it (mx.dave-tech.it. [2.229.21.40])
        by gmr-mx.google.com with ESMTP id bc3si471292wib.2.2015.05.26.01.17.49
        for <rtc-linux@googlegroups.com>;
        Tue, 26 May 2015 01:17:49 -0700 (PDT)
From: rnd4@dave-tech.it
To: r.cerrato@til-technologies.fr
Cc: a.zummo@towertech.it,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Andrea Scian <andrea.scian@dave.eu>
Subject: [rtc-linux] [PATCH] driver: rtc: pcf2127: use OFS flag to detect
 unreliable date and warn the user
Date: Tue, 26 May 2015 10:17:40 +0200
Message-Id: <1432628260-24652-1-git-send-email-rnd4@dave-tech.it>
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

From: Andrea Scian <andrea.scian@dave.eu>

I'm using PCF2127 in a custom ARM-based board and, by looking into PCF2127 datasheet 
I've found that, in my understanding, it's wrong to say that the date in unreliable
if BLF (battery low flag) is set but you should use OSF flag (seconds register) to
check if oscillator, for any reason, stopped.
Battery may be low (usually below 2V5 threshold) but the date may be anyway correct
(tipically date is unreliable when input voltage is below 1V2).

Feel free to comment and apply if useful.

Kind Regards,

Andrea

---

Also change the power fail message, which does NOT mean that time is not
valid but also states that user should replace the battery

Signed-off-by: Andrea Scian <andrea.scian@dave.eu>
---
 drivers/rtc/rtc-pcf2127.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 1ee514a..2365788 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -59,7 +59,16 @@ static int pcf2127_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 	if (buf[PCF2127_REG_CTRL3] & 0x04) {
 		pcf2127->voltage_low = 1;
 		dev_info(&client->dev,
-			"low voltage detected, date/time is not reliable.\n");
+			"low voltage detected, check/replace RTC battery.\n");
+	}
+
+	if (buf[PCF2127_REG_SC] & 0x80) {
+		dev_warn(&client->dev,
+			"oscillator stop detected, date/time is not reliable.\n");
+		/*
+		 * no need clear the flag here,
+		 * it will be cleared once the new date is saved
+		 */
 	}
 
 	dev_dbg(&client->dev,
@@ -112,7 +121,7 @@ static int pcf2127_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 	buf[i++] = PCF2127_REG_SC;
 
 	/* hours, minutes and seconds */
-	buf[i++] = bin2bcd(tm->tm_sec);
+	buf[i++] = bin2bcd(tm->tm_sec);	/* this will also clear OFS flag */
 	buf[i++] = bin2bcd(tm->tm_min);
 	buf[i++] = bin2bcd(tm->tm_hour);
 	buf[i++] = bin2bcd(tm->tm_mday);
@@ -144,7 +153,7 @@ static int pcf2127_rtc_ioctl(struct device *dev,
 	switch (cmd) {
 	case RTC_VL_READ:
 		if (pcf2127->voltage_low)
-			dev_info(dev, "low voltage detected, date/time is not reliable.\n");
+			dev_info(dev, "low voltage detected, check/replace battery\n");
 
 		if (copy_to_user((void __user *)arg, &pcf2127->voltage_low,
 					sizeof(int)))
-- 
1.7.9.5

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
