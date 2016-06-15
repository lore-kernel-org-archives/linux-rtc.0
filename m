Return-Path: <rtc-linux+bncBDKOBWPM5ABRB3W5QO5QKGQEQBGOG2Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com. [2607:f8b0:400e:c03::243])
        by gmr-mx.google.com with ESMTPS id ci4si3625974pad.1.2016.06.14.23.00.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2016 23:00:13 -0700 (PDT)
Received: by mail-pa0-x243.google.com with SMTP id ts6so798783pac.0
        for <rtc-linux@googlegroups.com>; Tue, 14 Jun 2016 23:00:13 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [rtc-linux] [PATCH 12/13] RTC: ds1307: Report oscillator problems
 more intelligently
Date: Tue, 14 Jun 2016 22:59:38 -0700
Message-Id: <1465970379-14703-13-git-send-email-andrew.smirnov@gmail.com>
In-Reply-To: <1465970379-14703-1-git-send-email-andrew.smirnov@gmail.com>
References: <1465970379-14703-1-git-send-email-andrew.smirnov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Report oscillator problems more intelligently, by printing more
information about what cause the issue and not yelling "SET TIME!" at
the user.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 76e66a3..d9693bd 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1424,6 +1424,19 @@ static int ds1307_chip_configure(const struct ds1307 *ds1307)
 	return 0;
 }
 
+static void ds1307_report_clock_halt(const struct ds1307 *ds1307)
+{
+	dev_warn(&ds1307->client->dev, "RTC's oscillator is turned off. "
+		 "Turning it on. Please set time");
+}
+
+static void ds1307_report_oscillator_fault(const struct ds1307 *ds1307)
+{
+	dev_warn(&ds1307->client->dev, "RTC's reported oscillator fault. "
+		 "Clearing the fault flag and re-reading RTC status. "
+		 "Please set time");
+}
+
 static int ds1307_chip_sanity_check(const struct ds1307 *ds1307)
 {
 	int tmp, retries;
@@ -1453,7 +1466,7 @@ static int ds1307_chip_sanity_check(const struct ds1307 *ds1307)
 			if (tmp & DS1307_BIT_CH) {
 				i2c_smbus_write_byte_data(client,
 							  DS1307_REG_SECS, 0);
-				dev_warn(&client->dev, "SET TIME!\n");
+				ds1307_report_clock_halt(ds1307);
 				continue;
 			}
 			break;
@@ -1469,15 +1482,17 @@ static int ds1307_chip_sanity_check(const struct ds1307 *ds1307)
 							  DS1307_REG_CONTROL,
 							  regs[DS1307_REG_CONTROL]
 							  & ~DS1338_BIT_OSF);
-				dev_warn(&client->dev, "SET TIME!\n");
+				ds1307_report_oscillator_fault(ds1307);
 				continue;
 			}
 			break;
 		case ds_1340:
 			/* clock halted?  turn it on, so clock can tick. */
-			if (tmp & DS1340_BIT_nEOSC)
+			if (tmp & DS1340_BIT_nEOSC) {
 				i2c_smbus_write_byte_data(client,
 							  DS1307_REG_SECS, 0);
+				ds1307_report_clock_halt(ds1307);
+			}
 
 			tmp = i2c_smbus_read_byte_data(client, DS1340_REG_FLAG);
 			if (tmp < 0) {
@@ -1489,7 +1504,7 @@ static int ds1307_chip_sanity_check(const struct ds1307 *ds1307)
 			if (tmp & DS1340_BIT_OSF) {
 				i2c_smbus_write_byte_data(client,
 							  DS1340_REG_FLAG, 0);
-				dev_warn(&client->dev, "SET TIME!\n");
+				ds1307_report_oscillator_fault(ds1307);
 			}
 			return 0;
 
@@ -1500,6 +1515,9 @@ static int ds1307_chip_sanity_check(const struct ds1307 *ds1307)
 							  DS1307_REG_WDAY,
 							  regs[DS1307_REG_WDAY]
 							  | MCP794XX_BIT_VBATEN);
+				dev_warn(&client->dev,
+					 "battery backup was disabled. "
+					 "Re-enabling it\n");
 			}
 
 			/* clock halted?  turn it on, so clock can tick. */
@@ -1507,7 +1525,7 @@ static int ds1307_chip_sanity_check(const struct ds1307 *ds1307)
 				i2c_smbus_write_byte_data(client,
 							  DS1307_REG_SECS,
 							  MCP794XX_BIT_ST);
-				dev_warn(&client->dev, "SET TIME!\n");
+				ds1307_report_clock_halt(ds1307);
 				continue;
 			}
 
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
