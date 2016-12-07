Return-Path: <rtc-linux+bncBCW4XG6ATMLBB6VVULBAKGQEUDYC7VA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com. [2a00:1450:400c:c09::242])
        by gmr-mx.google.com with ESMTPS id f71si1044505wmf.2.2016.12.07.15.27.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 15:27:54 -0800 (PST)
Received: by mail-wm0-x242.google.com with SMTP id u144so30972916wmu.0
        for <rtc-linux@googlegroups.com>; Wed, 07 Dec 2016 15:27:54 -0800 (PST)
From: Emil Bartczak <emilbart@gmail.com>
To: a.zummo@towertech.it
Cc: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Emil Bartczak <emilbart@gmail.com>
Subject: [rtc-linux] [PATCH v2 4/6] rtc: mcp795: fix month write resetting
 date to 1.
Date: Thu,  8 Dec 2016 00:27:40 +0100
Message-Id: <c9457d2a0b5270ef109a37d7e6dc2ef035b22c79.1481151278.git.emilbart@gmail.com>
In-Reply-To: <cover.1481151278.git.emilbart@gmail.com>
References: <cover.1481151278.git.emilbart@gmail.com>
In-Reply-To: <cover.1481151278.git.emilbart@gmail.com>
References: <cover.1481151278.git.emilbart@gmail.com>
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

Signed-off-by: Emil Bartczak <emilbart@gmail.com>
---
 drivers/rtc/rtc-mcp795.c | 86 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index 4618f4f..89b0ffa 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -22,6 +22,7 @@
 #include <linux/rtc.h>
 #include <linux/of.h>
 #include <linux/bcd.h>
+#include <linux/delay.h>
 
 /* MCP795 Instructions, see datasheet table 3-1 */
 #define MCP795_EEREAD	0x03
@@ -38,9 +39,17 @@
 #define MCP795_CLRWDT	0x44
 #define MCP795_CLRRAM	0x54
 
+/* MCP795 RTCC registers, see datasheet table 4-1 */
+#define MCP795_REG_SECONDS	0x01
+#define MCP795_REG_DAY		0x04
+#define MCP795_REG_MONTH	0x06
+#define MCP795_REG_CONTROL	0x08
+
 #define MCP795_ST_BIT	0x80
 #define MCP795_24_BIT	0x40
 #define MCP795_LP_BIT	BIT(5)
+#define MCP795_EXTOSC_BIT	BIT(3)
+#define MCP795_OSCON_BIT	BIT(5)
 
 static int mcp795_rtcc_read(struct device *dev, u8 addr, u8 *buf, u8 count)
 {
@@ -95,13 +104,65 @@ static int mcp795_rtcc_set_bits(struct device *dev, u8 addr, u8 mask, u8 state)
 	return ret;
 }
 
+static int mcp795_stop_oscillator(struct device *dev, bool *extosc)
+{
+	int retries = 5;
+	int ret;
+	u8 data;
+
+	ret = mcp795_rtcc_set_bits(dev, MCP795_REG_SECONDS, MCP795_ST_BIT, 0);
+	if (ret)
+		return ret;
+	ret = mcp795_rtcc_read(dev, MCP795_REG_CONTROL, &data, 1);
+	if (ret)
+		return ret;
+	*extosc = !!(data & MCP795_EXTOSC_BIT);
+	ret = mcp795_rtcc_set_bits(
+				dev, MCP795_REG_CONTROL, MCP795_EXTOSC_BIT, 0);
+	if (ret)
+		return ret;
+	/* wait for the OSCON bit to clear */
+	do {
+		usleep_range(700, 800);
+		ret = mcp795_rtcc_read(dev, MCP795_REG_DAY, &data, 1);
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
+static int mcp795_start_oscillator(struct device *dev, bool *extosc)
+{
+	if (extosc) {
+		u8 data = *extosc ? MCP795_EXTOSC_BIT : 0;
+		int ret;
+
+		ret = mcp795_rtcc_set_bits(
+			dev, MCP795_REG_CONTROL, MCP795_EXTOSC_BIT, data);
+		if (ret)
+			return ret;
+	}
+	return mcp795_rtcc_set_bits(
+			dev, MCP795_REG_SECONDS, MCP795_ST_BIT, MCP795_ST_BIT);
+}
+
 static int mcp795_set_time(struct device *dev, struct rtc_time *tim)
 {
 	int ret;
 	u8 data[7];
+	bool extosc;
+
+	/* Stop RTC and store current value of EXTOSC bit */
+	ret = mcp795_stop_oscillator(dev, &extosc);
+	if (ret)
+		return ret;
 
 	/* Read first, so we can leave config bits untouched */
-	ret = mcp795_rtcc_read(dev, 0x01, data, sizeof(data));
+	ret = mcp795_rtcc_read(dev, MCP795_REG_SECONDS, data, sizeof(data));
 
 	if (ret)
 		return ret;
@@ -117,8 +178,23 @@ static int mcp795_set_time(struct device *dev, struct rtc_time *tim)
 
 	data[6] = bin2bcd(tim->tm_year);
 
-	ret = mcp795_rtcc_write(dev, 0x01, data, sizeof(data));
+	/* Always write the date and month using a separate Write command.
+	 * This is a workaround for a know silicon issue that some combinations
+	 * of date and month values may result in the date being reset to 1.
+	 */
+	ret = mcp795_rtcc_write(dev, MCP795_REG_SECONDS, data, 5);
+	if (ret)
+		return ret;
+
+	ret = mcp795_rtcc_write(dev, MCP795_REG_MONTH, &data[5], 2);
+	if (ret)
+		return ret;
 
+	/* Start back RTC and restore previous value of EXTOSC bit.
+	 * There is no need to clear EXTOSC bit when the previous value was 0
+	 * because it was already cleared when stopping the RTC oscillator.
+	 */
+	ret = mcp795_start_oscillator(dev, extosc ? &extosc : NULL);
 	if (ret)
 		return ret;
 
@@ -134,7 +210,7 @@ static int mcp795_read_time(struct device *dev, struct rtc_time *tim)
 	int ret;
 	u8 data[7];
 
-	ret = mcp795_rtcc_read(dev, 0x01, data, sizeof(data));
+	ret = mcp795_rtcc_read(dev, MCP795_REG_SECONDS, data, sizeof(data));
 
 	if (ret)
 		return ret;
@@ -171,8 +247,8 @@ static int mcp795_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	/* Start the oscillator */
-	mcp795_rtcc_set_bits(&spi->dev, 0x01, MCP795_ST_BIT, MCP795_ST_BIT);
+	/* Start the oscillator but don't set the value of EXTOSC bit */
+	mcp795_start_oscillator(&spi->dev, NULL);
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
