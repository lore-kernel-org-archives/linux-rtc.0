Return-Path: <rtc-linux+bncBCNNJWF7RUMRBE7MZC2QKGQEOMGWY6Q@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com. [2607:f8b0:400e:c03::243])
        by gmr-mx.google.com with ESMTPS id ui7si968552pab.0.2016.02.03.09.17.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 09:17:07 -0800 (PST)
Received: by mail-pa0-x243.google.com with SMTP id yy13so1198652pab.1
        for <rtc-linux@googlegroups.com>; Wed, 03 Feb 2016 09:17:07 -0800 (PST)
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Joshua Clayton <stillcompiling@gmail.com>
Subject: [rtc-linux] [PATCH v3 3/3] rtc-pcf2123: implement read_offset and set_offset
Date: Wed,  3 Feb 2016 09:16:44 -0800
Message-Id: <1454519804-13770-3-git-send-email-stillcompiling@gmail.com>
In-Reply-To: <1454519804-13770-1-git-send-email-stillcompiling@gmail.com>
References: <1454519804-13770-1-git-send-email-stillcompiling@gmail.com>
References: <20160202104111.GU20165@piout.net>
In-Reply-To: <20160202104111.GU20165@piout.net>
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

pcf2123 has an offset register, which can be used to make minor
adjustments to the clock rate to compensate for temperature or
a crystal that is not exactly right.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/rtc/rtc-pcf2123.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index d9a44ad..da27738 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -100,6 +100,7 @@
 /* PCF2123_REG_OFFSET BITS */
 #define OFFSET_SIGN_BIT		BIT(6)	/* 2's complement sign bit */
 #define OFFSET_COARSE		BIT(7)	/* Coarse mode offset */
+#define OFFSET_STEP		(2170)	/* Offset step in parts per billion */
 
 /* READ/WRITE ADDRESS BITS */
 #define PCF2123_WRITE		BIT(4)
@@ -206,6 +207,59 @@ static ssize_t pcf2123_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
+static int pcf2123_read_offset(struct device *dev, long *offset)
+{
+	int ret;
+	s8 reg;
+
+	ret = pcf2123_read(dev, PCF2123_REG_OFFSET, &reg, 1);
+	if (ret < 0)
+		return ret;
+
+	if (reg & OFFSET_COARSE)
+		reg <<= 1; /* multiply by 2 and sign extend */
+	else
+		reg |= (reg & OFFSET_SIGN_BIT) << 1; /* sign extend only */
+
+	*offset = ((long)reg) * OFFSET_STEP;
+
+	return 0;
+}
+
+/*
+ * The offset register is a 7 bit signed value with a coarse bit in bit 7.
+ * The main difference between the two is normal offset adjusts the first
+ * second of n minutes every other hour, with 61, 62 and 63 being shoved
+ * into the 60th minute.
+ * The coarse adjustment does the same, but every hour.
+ * the two overlap, with every even normal offset value corresponding
+ * to a coarse offset. Based on this algorithm, it seems that despite the
+ * name, coarse offset is a better fit for overlapping values.
+ */
+static int pcf2123_set_offset(struct device *dev, long offset)
+{
+	s8 reg;
+
+	if (offset > OFFSET_STEP * 127)
+		reg = 127;
+	else if (offset < OFFSET_STEP * -128)
+		reg = -128;
+	else
+		reg = (s8)((offset + (OFFSET_STEP >> 1)) / OFFSET_STEP);
+
+	/* choose fine offset only for odd values in the normal range */
+	if (reg & 1 && reg <= 63 && reg >= -64) {
+		/* Normal offset. Clear the coarse bit */
+		reg &= ~OFFSET_COARSE;
+	} else {
+		/* Coarse offset. Divide by 2 and set the coarse bit */
+		reg >>= 1;
+		reg |= OFFSET_COARSE;
+	}
+
+	return pcf2123_write_reg(dev, PCF2123_REG_OFFSET, reg);
+}
+
 static int pcf2123_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	u8 rxbuf[7];
@@ -314,6 +368,9 @@ static int pcf2123_reset(struct device *dev)
 static const struct rtc_class_ops pcf2123_rtc_ops = {
 	.read_time	= pcf2123_rtc_read_time,
 	.set_time	= pcf2123_rtc_set_time,
+	.read_offset	= pcf2123_read_offset,
+	.set_offset	= pcf2123_set_offset,
+
 };
 
 static int pcf2123_probe(struct spi_device *spi)
-- 
2.5.0

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
