Return-Path: <rtc-linux+bncBDS7HNEFSALRBJ7Y363AKGQEK4ZBUXA@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w10si249491wmw.3.2016.03.03.00.56.07
        for <rtc-linux@googlegroups.com>;
        Thu, 03 Mar 2016 00:56:07 -0800 (PST)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] rtc: pcf8523: properly handle oscillator stop bit
Date: Thu,  3 Mar 2016 09:55:47 +0100
Message-Id: <1456995347-1318-1-git-send-email-alexandre.belloni@free-electrons.com>
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

The time and date register of the pcf8223 are undefined after a power
reset. Properly handle the OS bit and return -EINVAL when that bit is set.

It is properly removed when setting the time.

This solves an issue where the time and date may be valid for
rtc_valid_tm() but is not the current time.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-pcf8523.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
index 988566caaaa6..28c48b3c1946 100644
--- a/drivers/rtc/rtc-pcf8523.c
+++ b/drivers/rtc/rtc-pcf8523.c
@@ -178,28 +178,8 @@ static int pcf8523_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	if (err < 0)
 		return err;
 
-	if (regs[0] & REG_SECONDS_OS) {
-		/*
-		 * If the oscillator was stopped, try to clear the flag. Upon
-		 * power-up the flag is always set, but if we cannot clear it
-		 * the oscillator isn't running properly for some reason. The
-		 * sensible thing therefore is to return an error, signalling
-		 * that the clock cannot be assumed to be correct.
-		 */
-
-		regs[0] &= ~REG_SECONDS_OS;
-
-		err = pcf8523_write(client, REG_SECONDS, regs[0]);
-		if (err < 0)
-			return err;
-
-		err = pcf8523_read(client, REG_SECONDS, &regs[0]);
-		if (err < 0)
-			return err;
-
-		if (regs[0] & REG_SECONDS_OS)
-			return -EAGAIN;
-	}
+	if (regs[0] & REG_SECONDS_OS)
+		return -EINVAL;
 
 	tm->tm_sec = bcd2bin(regs[0] & 0x7f);
 	tm->tm_min = bcd2bin(regs[1] & 0x7f);
@@ -235,6 +215,7 @@ static int pcf8523_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		return err;
 
 	regs[0] = REG_SECONDS;
+	/* This will purposely overwrite REG_SECONDS_OS */
 	regs[1] = bin2bcd(tm->tm_sec);
 	regs[2] = bin2bcd(tm->tm_min);
 	regs[3] = bin2bcd(tm->tm_hour);
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
