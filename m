Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43514 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752189AbdI2KXr (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 29 Sep 2017 06:23:47 -0400
From: Russell King <rmk+kernel@armlinux.org.uk>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Subject: [PATCH] rtc: pcf8523: add support for trimming the RTC oscillator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1dxsSG-0006RT-3r@rmk-PC.armlinux.org.uk>
Date: Fri, 29 Sep 2017 11:23:36 +0100
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Add support for reading and writing the RTC offset register, converting
it to the corresponding parts-per-billion value.

When setting the drift, the PCF8523 has two modes: one applies the
adjustment every two hours, the other applies the adjustment every
minute.  We select between these two modes according to which ever
gives the closest PPB value to the one requested.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/rtc/rtc-pcf8523.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
index 28c48b3c1946..c312af0db729 100644
--- a/drivers/rtc/rtc-pcf8523.c
+++ b/drivers/rtc/rtc-pcf8523.c
@@ -35,6 +35,9 @@
 #define REG_MONTHS   0x08
 #define REG_YEARS    0x09
 
+#define REG_OFFSET   0x0e
+#define REG_OFFSET_MODE BIT(7)
+
 struct pcf8523 {
 	struct rtc_device *rtc;
 };
@@ -272,10 +275,47 @@ static int pcf8523_rtc_ioctl(struct device *dev, unsigned int cmd,
 #define pcf8523_rtc_ioctl NULL
 #endif
 
+static int pcf8523_rtc_read_offset(struct device *dev, long *offset)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int err;
+	u8 value;
+	s8 val;
+
+	err = pcf8523_read(client, REG_OFFSET, &value);
+	if (err < 0)
+		return err;
+
+	/* sign extend the 7-bit offset value */
+	val = value << 1;
+	*offset = (value & REG_OFFSET_MODE ? 4069 : 4340) * (val >> 1);
+
+	return 0;
+}
+
+static int pcf8523_rtc_set_offset(struct device *dev, long offset)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	long reg_m0, reg_m1;
+	u8 value;
+
+	reg_m0 = clamp(DIV_ROUND_CLOSEST(offset, 4340), -64L, 63L);
+	reg_m1 = clamp(DIV_ROUND_CLOSEST(offset, 4069), -64L, 63L);
+
+	if (abs(reg_m0 * 4340 - offset) < abs(reg_m1 * 4069 - offset))
+		value = reg_m0 & 0x7f;
+	else
+		value = (reg_m1 & 0x7f) | REG_OFFSET_MODE;
+
+	return pcf8523_write(client, REG_OFFSET, value);
+}
+
 static const struct rtc_class_ops pcf8523_rtc_ops = {
 	.read_time = pcf8523_rtc_read_time,
 	.set_time = pcf8523_rtc_set_time,
 	.ioctl = pcf8523_rtc_ioctl,
+	.read_offset = pcf8523_rtc_read_offset,
+	.set_offset = pcf8523_rtc_set_offset,
 };
 
 static int pcf8523_probe(struct i2c_client *client,
-- 
2.7.4
