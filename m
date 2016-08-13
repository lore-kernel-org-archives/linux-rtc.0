Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBNOIXG6QKGQE5VSCZJI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id i193si224074wmg.1.2016.08.12.17.05.09
        for <rtc-linux@googlegroups.com>;
        Fri, 12 Aug 2016 17:05:09 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH v2 2/4] rtc: ds1307: add Intersil ISL12057 support
Date: Sat, 13 Aug 2016 02:05:00 +0200
Message-Id: <1471046702-20231-2-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1471046702-20231-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1471046702-20231-1-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Intersil ISL12057 is a drop-in replacement for DS1337. It can be supported
by the ds1307 driver.

Acked-by: Arnaud Ebalard <arno@natisbad.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Changes in v2:
 - fix i2c_device_id name

 drivers/rtc/Kconfig      | 8 ++++----
 drivers/rtc/rtc-ds1307.c | 6 ++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 022e833c2143..5d3079c672f9 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -198,14 +198,14 @@ config RTC_DRV_AS3722
 	  will be called rtc-as3722.
 
 config RTC_DRV_DS1307
-	tristate "Dallas/Maxim DS1307/37/38/39/40, ST M41T00, EPSON RX-8025"
+	tristate "Dallas/Maxim DS1307/37/38/39/40, ST M41T00, EPSON RX-8025, ISL12057"
 	help
 	  If you say yes here you get support for various compatible RTC
 	  chips (often with battery backup) connected with I2C. This driver
 	  should handle DS1307, DS1337, DS1338, DS1339, DS1340, ST M41T00,
-	  EPSON RX-8025 and probably other chips. In some cases the RTC
-	  must already have been initialized (by manufacturing or a
-	  bootloader).
+	  EPSON RX-8025, Intersil ISL12057 and probably other chips. In some
+	  cases the RTC must already have been initialized (by manufacturing or
+	  a bootloader).
 
 	  The first seven registers on these chips hold an RTC, and other
 	  registers may add features such as NVRAM, a trickle charger for
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 712e221d2415..4e31036ee259 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -186,6 +186,7 @@ static const struct i2c_device_id ds1307_id[] = {
 	{ "mcp7941x", mcp794xx },
 	{ "pt7c4338", ds_1307 },
 	{ "rx8025", rx_8025 },
+	{ "isl12057", ds_1337 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ds1307_id);
@@ -1333,6 +1334,11 @@ static int ds1307_probe(struct i2c_client *client,
 	if (of_property_read_bool(client->dev.of_node, "wakeup-source")) {
 		ds1307_can_wakeup_device = true;
 	}
+	/* Intersil ISL12057 DT backward compatibility */
+	if (of_property_read_bool(client->dev.of_node,
+				  "isil,irq2-can-wakeup-machine")) {
+		ds1307_can_wakeup_device = true;
+	}
 #endif
 
 	switch (ds1307->type) {
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
