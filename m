Return-Path: <rtc-linux+bncBDKOBWPM5ABRBVWWUO5QKGQE3S7YQGI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com. [2607:f8b0:400e:c00::243])
        by gmr-mx.google.com with ESMTPS id 62si7279324pfx.1.2016.06.21.00.23.02
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 00:23:02 -0700 (PDT)
Received: by mail-pf0-x243.google.com with SMTP id i123so755736pfg.3
        for <rtc-linux@googlegroups.com>; Tue, 21 Jun 2016 00:23:02 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	cphealy@gmail.com
Subject: [rtc-linux] [PATCH v2 04/17] RTC: ds1307: Add DS1341 specific
 power-saving options
Date: Tue, 21 Jun 2016 00:22:37 -0700
Message-Id: <1466493770-11895-3-git-send-email-andrew.smirnov@gmail.com>
In-Reply-To: <1466493770-11895-1-git-send-email-andrew.smirnov@gmail.com>
References: <1466493770-11895-1-git-send-email-andrew.smirnov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Add DS1341 specific power-saving options that allow to disable certain
functional aspects of the chip in order to minimize its power
consumption.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index c618c22..b21ea5d 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -78,6 +78,7 @@ enum ds_type {
 #define DS1337_REG_CONTROL	0x0e
 #	define DS1337_BIT_nEOSC		0x80
 #	define DS1339_BIT_BBSQI		0x20
+#	define DS1341_BIT_EGFIL		0x20
 #	define DS3231_BIT_BBSQW		0x40 /* same as BBSQI */
 #	define DS1337_BIT_RS2		0x10
 #	define DS1337_BIT_RS1		0x08
@@ -93,7 +94,9 @@ enum ds_type {
 #	define DS1340_BIT_OSF		0x80
 #define DS1337_REG_STATUS	0x0f
 #	define DS1337_BIT_OSF		0x80
+#	define DS1341_BIT_DOSF		0x40
 #	define DS3231_BIT_EN32KHZ	0x08
+#	define DS1341_BIT_ECLK		0x04
 #	define DS1337_BIT_A2I		0x02
 #	define DS1337_BIT_A1I		0x01
 #define DS1339_REG_ALARM1_SECS	0x07
@@ -1319,6 +1322,31 @@ static int ds1307_probe(struct i2c_client *client,
 		if (ds1307->regs[0] & DS1337_BIT_nEOSC)
 			ds1307->regs[0] &= ~DS1337_BIT_nEOSC;
 
+		if (ds1307->type == ds_1341) {
+			/* Make sure we are not generating square wave
+			 * output */
+			ds1307->regs[1] &= ~DS1341_BIT_ECLK;
+
+			if (of_property_read_bool(client->dev.of_node,
+						  "dallas,disable-oscillator-stop-flag"))
+				ds1307->regs[1] |= DS1341_BIT_DOSF;
+			else
+				ds1307->regs[1] &= ~DS1341_BIT_DOSF;
+
+			if (of_property_read_bool(client->dev.of_node,
+						  "dallas,enable-glitch-filter"))
+				ds1307->regs[0] |= DS1341_BIT_EGFIL;
+			else
+				ds1307->regs[0] &= ~DS1341_BIT_EGFIL;
+
+			/*
+			 * Write status register. Control register
+			 * would be set by the code below
+			 */
+			i2c_smbus_write_byte_data(client, DS1337_REG_STATUS,
+						  ds1307->regs[1]);
+		}
+
 		/*
 		 * Disable the square wave and both alarms.
 		 * For some variants, be sure alarms can trigger when we're
-- 
2.5.5

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
