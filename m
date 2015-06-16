Return-Path: <rtc-linux+bncBAABB2G576VQKGQEXTW4DQY@googlegroups.com>
MIME-Version: 1.0
Received: from mx.dave-tech.it (mx.dave-tech.it. [2.229.21.40])
        by gmr-mx.google.com with ESMTP id gt9si61812wib.2.2015.06.16.02.39.51
        for <rtc-linux@googlegroups.com>;
        Tue, 16 Jun 2015 02:39:51 -0700 (PDT)
From: rnd4@dave-tech.it
To: alexandre.belloni@free-electrons.com
Cc: a.zummo@towertech.it,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Andrea Scian <andrea.scian@dave.eu>
Subject: [rtc-linux] [PATCH v2] driver: rtc: pcf2127: use OFS flag to detect
 unreliable date and warn the user
Date: Tue, 16 Jun 2015 11:39:47 +0200
Message-Id: <1434447587-23992-1-git-send-email-rnd4@dave-tech.it>
In-Reply-To: <557EF5DD.9070300@dave-tech.it>
References: <557EF5DD.9070300@dave-tech.it>
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

Signed-off-by: Andrea Scian <andrea.scian@dave.eu>
---

Changes since v1:
* use BIT() to select the right bitfield instead of hardcode value
* return -EINVAL if OFS is detected
* cache OSF into driver structure to warn the user even later

 drivers/rtc/rtc-pcf2127.c |   26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 7f803b2..aecee0b 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -33,11 +33,14 @@
 #define PCF2127_REG_MO          (0x08)
 #define PCF2127_REG_YR          (0x09)
 
+#define PCF2127_OSF             BIT(7)  /* Oscillator Fail flag */
+
 static struct i2c_driver pcf2127_driver;
 
 struct pcf2127 {
 	struct rtc_device *rtc;
 	int voltage_low; /* indicates if a low_voltage was detected */
+	int oscillator_failed; /* OSF was detected and date in unreliable */
 };
 
 /*
@@ -59,7 +62,18 @@ static int pcf2127_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 	if (buf[PCF2127_REG_CTRL3] & 0x04) {
 		pcf2127->voltage_low = 1;
 		dev_info(&client->dev,
-			"low voltage detected, date/time is not reliable.\n");
+			"low voltage detected, check/replace RTC battery.\n");
+	}
+
+	if (buf[PCF2127_REG_SC] & PCF2127_OSF) {
+		/*
+		 * no need clear the flag here,
+		 * it will be cleared once the new date is saved
+		 */
+		pcf2127->oscillator_failed = 1;
+		dev_warn(&client->dev,
+			"oscillator stop detected, date/time is not reliable\n");
+		return -EINVAL;
 	}
 
 	dev_dbg(&client->dev,
@@ -93,6 +107,7 @@ static int pcf2127_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 
 static int pcf2127_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 {
+	struct pcf2127 *pcf2127 = i2c_get_clientdata(client);
 	unsigned char buf[8];
 	int i = 0, err;
 
@@ -106,7 +121,7 @@ static int pcf2127_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 	buf[i++] = PCF2127_REG_SC;
 
 	/* hours, minutes and seconds */
-	buf[i++] = bin2bcd(tm->tm_sec);
+	buf[i++] = bin2bcd(tm->tm_sec);	/* this will also clear OFS flag */
 	buf[i++] = bin2bcd(tm->tm_min);
 	buf[i++] = bin2bcd(tm->tm_hour);
 	buf[i++] = bin2bcd(tm->tm_mday);
@@ -126,6 +141,9 @@ static int pcf2127_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 		return -EIO;
 	}
 
+	/* clear OSF flag in client data */
+	pcf2127->oscillator_failed = 0;
+
 	return 0;
 }
 
@@ -138,7 +156,9 @@ static int pcf2127_rtc_ioctl(struct device *dev,
 	switch (cmd) {
 	case RTC_VL_READ:
 		if (pcf2127->voltage_low)
-			dev_info(dev, "low voltage detected, date/time is not reliable.\n");
+			dev_info(dev, "low voltage detected, check/replace battery\n");
+		if (pcf2127->oscillator_failed)
+			dev_info(dev, "oscillator stop detected, date/time is not reliable\n");
 
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
