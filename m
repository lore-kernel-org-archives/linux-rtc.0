Return-Path: <rtc-linux+bncBCW4XG6ATMLBBIOPSXBAKGQEKP6XKWQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wj0-x244.google.com (mail-wj0-x244.google.com. [2a00:1450:400c:c01::244])
        by gmr-mx.google.com with ESMTPS id l66si7757wml.0.2016.12.05.05.12.01
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2016 05:12:01 -0800 (PST)
Received: by mail-wj0-x244.google.com with SMTP id he10so25043680wjc.2
        for <rtc-linux@googlegroups.com>; Mon, 05 Dec 2016 05:12:01 -0800 (PST)
From: Emil Bartczak <emilbart@gmail.com>
To: a.zummo@towertech.it
Cc: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Emil Bartczak <emilbart@gmail.com>
Subject: [rtc-linux] [PATCH 3/4] rtc: mcp795: fix month write resetting date
 to 1.
Date: Mon,  5 Dec 2016 14:11:52 +0100
Message-Id: <6a1e8548654fd8a5b65ba98f59b2b5ccb1544f7f.1480939487.git.emilbart@gmail.com>
In-Reply-To: <cover.1480939487.git.emilbart@gmail.com>
References: <cover.1480939487.git.emilbart@gmail.com>
In-Reply-To: <cover.1480939487.git.emilbart@gmail.com>
References: <cover.1480939487.git.emilbart@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

According to Microchip errata some combinations of date and month
values may result in the date being reset to 1, even if the date
is also written with the month (for example 31-07 or 31-08).
As a workaround avoid writing date and month values within the same
Write command. Instead, terminate the Write command after loading
the date and begin a new command to write the month. In addition,
disable the oscillator before loading the new values. This is done
by ensuring both the ST and EXTOSC bits are cleared and waiting for
the OSCON bit to clear.
---
 drivers/rtc/rtc-mcp795.c | 103 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 82 insertions(+), 21 deletions(-)

diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index d15072c..c9ad46c 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -21,25 +21,34 @@
 #include <linux/spi/spi.h>
 #include <linux/rtc.h>
 #include <linux/of.h>
+#include <linux/delay.h>
 
 /* MCP795 Instructions, see datasheet table 3-1 */
-#define MCP795_EEREAD	0x03
-#define MCP795_EEWRITE	0x02
-#define MCP795_EEWRDI	0x04
-#define MCP795_EEWREN	0x06
-#define MCP795_SRREAD	0x05
-#define MCP795_SRWRITE	0x01
-#define MCP795_READ	0x13
-#define MCP795_WRITE	0x12
-#define MCP795_UNLOCK	0x14
-#define MCP795_IDWRITE	0x32
-#define MCP795_IDREAD	0x33
-#define MCP795_CLRWDT	0x44
-#define MCP795_CLRRAM	0x54
-
-#define MCP795_ST_BIT	0x80
-#define MCP795_24_BIT	0x40
-#define MCP795_LP_BIT	0x20
+#define MCP795_EEREAD		0x03
+#define MCP795_EEWRITE		0x02
+#define MCP795_EEWRDI		0x04
+#define MCP795_EEWREN		0x06
+#define MCP795_SRREAD		0x05
+#define MCP795_SRWRITE		0x01
+#define MCP795_READ		0x13
+#define MCP795_WRITE		0x12
+#define MCP795_UNLOCK		0x14
+#define MCP795_IDWRITE		0x32
+#define MCP795_IDREAD		0x33
+#define MCP795_CLRWDT		0x44
+#define MCP795_CLRRAM		0x54
+
+/* MCP795 RTCC registers, see datasheet table 4-1 */
+#define MCP795_REG_SECONDS	0x01
+#define MCP795_REG_DAY		0x04
+#define MCP795_REG_MONTH	0x06
+#define MCP795_REG_CONTROL	0x08
+
+#define MCP795_ST_BIT		0x80
+#define MCP795_24_BIT		0x40
+#define MCP795_LP_BIT		0x20
+#define MCP795_EXTOSC_BIT	0x08
+#define MCP795_OSCON_BIT	0x20
 
 static int mcp795_rtcc_read(struct device *dev, u8 addr, u8 *buf, u8 count)
 {
@@ -94,14 +103,51 @@ static int mcp795_rtcc_set_bits(struct device *dev, u8 addr, u8 mask, u8 state)
 	return ret;
 }
 
+static int mcp795_stop_oscillator(struct device *dev)
+{
+	int retries = 5;
+	int ret;
+	u8 data;
+
+	ret = mcp795_rtcc_set_bits(dev, MCP795_REG_SECONDS, MCP795_ST_BIT, 0);
+	if (ret)
+		return ret;
+	ret = mcp795_rtcc_set_bits(dev, MCP795_REG_CONTROL, MCP795_EXTOSC_BIT, 0);
+	if (ret)
+		return ret;
+	do {
+		usleep_range(700, 800);
+		ret = mcp795_rtcc_read(dev, MCP795_REG_DAY,
+					&data, sizeof(data));
+		if (ret)
+			break;
+		if (!(data & MCP795_OSCON_BIT))
+			break;
+
+	} while (--retries);
+
+	return !retries ? -EIO : ret;
+}
+
+static int mcp795_start_oscillator(struct device *dev)
+{
+	return mcp795_rtcc_set_bits(dev, MCP795_REG_SECONDS,
+					MCP795_ST_BIT, MCP795_ST_BIT);
+}
+
 static int mcp795_set_time(struct device *dev, struct rtc_time *tim)
 {
 	int month;
 	int ret;
 	u8 data[7];
 
+	/* Stop RTC while updating the registers */
+	ret = mcp795_stop_oscillator(dev);
+	if (ret)
+		return ret;
+
 	/* Read first, so we can leave config bits untouched */
-	ret = mcp795_rtcc_read(dev, 0x01, data, sizeof(data));
+	ret = mcp795_rtcc_read(dev, MCP795_REG_SECONDS, data, sizeof(data));
 
 	if (ret)
 		return ret;
@@ -110,6 +156,16 @@ static int mcp795_set_time(struct device *dev, struct rtc_time *tim)
 	data[1] = (data[1] & 0x80) | ((tim->tm_min / 10) << 4) | (tim->tm_min % 10);
 	data[2] = ((tim->tm_hour / 10) << 4) | (tim->tm_hour % 10);
 	data[4] = ((tim->tm_mday / 10) << 4) | ((tim->tm_mday) % 10);
+
+	/* Always write the date and month using a separate Write command.
+	 * This is a workaround for a know silicon issue that some combinations
+	 * of date and month values may result in the date being reset to 1.
+	 */
+	ret = mcp795_rtcc_write(dev, MCP795_REG_SECONDS, data, 5);
+
+	if (ret)
+		return ret;
+
 	month = tim->tm_mon + 1;
 	data[5] = (data[5] & MCP795_LP_BIT) |
 			((month / 10) << 4) | (month % 10);
@@ -119,8 +175,13 @@ static int mcp795_set_time(struct device *dev, struct rtc_time *tim)
 
 	data[6] = ((tim->tm_year / 10) << 4) | (tim->tm_year % 10);
 
-	ret = mcp795_rtcc_write(dev, 0x01, data, sizeof(data));
+	ret = mcp795_rtcc_write(dev, MCP795_REG_MONTH, &data[5], 2);
+
+	if (ret)
+		return ret;
 
+	/* Start back RTC */
+	ret = mcp795_start_oscillator(dev);
 	if (ret)
 		return ret;
 
@@ -136,7 +197,7 @@ static int mcp795_read_time(struct device *dev, struct rtc_time *tim)
 	int ret;
 	u8 data[7];
 
-	ret = mcp795_rtcc_read(dev, 0x01, data, sizeof(data));
+	ret = mcp795_rtcc_read(dev, MCP795_REG_SECONDS, data, sizeof(data));
 
 	if (ret)
 		return ret;
@@ -174,7 +235,7 @@ static int mcp795_probe(struct spi_device *spi)
 	}
 
 	/* Start the oscillator */
-	mcp795_rtcc_set_bits(&spi->dev, 0x01, MCP795_ST_BIT, MCP795_ST_BIT);
+	mcp795_start_oscillator(&spi->dev);
 	/* Clear the 12 hour mode flag*/
 	mcp795_rtcc_set_bits(&spi->dev, 0x03, MCP795_24_BIT, 0);
 
-- 
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
