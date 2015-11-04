Return-Path: <rtc-linux+bncBCNNJWF7RUMRBLGM5CYQKGQEQB7ZZMY@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com. [2607:f8b0:400e:c03::230])
        by gmr-mx.google.com with ESMTPS id vy6si183800pbc.1.2015.11.04.07.37.15
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2015 07:37:15 -0800 (PST)
Received: by mail-pa0-x230.google.com with SMTP id hx2so47777846pad.1
        for <rtc-linux@googlegroups.com>; Wed, 04 Nov 2015 07:37:15 -0800 (PST)
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Joshua Clayton <stillcompiling@gmail.com>
Subject: [rtc-linux] [PATCH 9/9] rtc-pcf2123: adjust the clock rate via sysfs
Date: Wed,  4 Nov 2015 07:36:40 -0800
Message-Id: <e06c88aded2d6f06103d73a1020576e3e0772331.1446587705.git.stillcompiling@gmail.com>
In-Reply-To: <cover.1446587705.git.stillcompiling@gmail.com>
References: <cover.1446587705.git.stillcompiling@gmail.com>
In-Reply-To: <cover.1446587705.git.stillcompiling@gmail.com>
References: <cover.1446587705.git.stillcompiling@gmail.com>
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

pcf2123 has an offset register, which can be used to make minor
adjustments to the clock rate to compensate for temperature or
a crystal that is not exactly right.

The adjustment is calculated in parts per billion. The data sheet
uses parts per million (as do some others), but with 2 digits of
precision. Since floating point is forbidden, parts per billion is
a better fit.

Add a pair of sysfs files to seetand retrieve the offset in ppm.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/rtc/rtc-pcf2123.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index d494638..6d70860 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -77,11 +77,17 @@
 /* PCF2123_REG_SC BITS */
 #define OSC_HAS_STOPPED		(0x80)	/* Clock has been stopped */
 
+/* PCF2123_REG_OFFSET BITS */
+#define OFFSET_COARSE		(0x80)	/* Coarse Mode Offset */
+
 /* READ/WRITE ADDRESS BITS */
 #define PCF2123_SUBADDR		(1 << 4)
 #define PCF2123_WRITE		((0 << 7) | PCF2123_SUBADDR)
 #define PCF2123_READ		((1 << 7) | PCF2123_SUBADDR)
 
+/* offset granularity in parts per billion in fine mode */
+#define OFFSET_STEP		(2170)
+
 static struct spi_driver pcf2123_driver;
 
 /*
@@ -166,6 +172,65 @@ static ssize_t pcf2123_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
+static ssize_t pcf2123_adjust_show(struct device *dev,
+				   struct device_attribute *attr, char *buffer)
+{
+	ssize_t ret;
+	s8 reg;
+
+	ret = pcf2123_read(dev, PCF2123_REG_OFFSET, &reg, 1);
+	if (ret < 0)
+		return -EIO;
+
+	if (reg & OFFSET_COARSE) {
+		reg <<= 1;
+	} else {
+		reg &= ~OFFSET_COARSE;
+		reg |= (reg & 0x40) << 1; /* sign extend */
+	}
+
+	return sprintf(buffer, "%ld\n", ((long)reg) * OFFSET_STEP);
+}
+
+static ssize_t pcf2123_adjust_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buffer, size_t count)
+{
+	ssize_t ret;
+	long val;
+	s8 reg;
+
+	ret = kstrtol(buffer, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val > OFFSET_STEP * 127)
+		reg = 127;
+	else if (val < OFFSET_STEP * -128)
+		reg = -128;
+	else
+		reg = (s8)((val + (OFFSET_STEP >> 1)) / OFFSET_STEP);
+
+/*
+ * Each even value of the fine adjust overlaps with a value of the coarse
+ * adjustment, and since the coarse adjsutment will spread the adjustments
+ * over both hours, we use coarse for all even values, as well as values
+ * that are beyond the range of fine adjustment
+ */
+	if (reg <= 63 && reg >= -64 && reg & 1) {
+		reg &= ~OFFSET_COARSE;
+	} else {
+		reg >>= 1;
+		reg |= OFFSET_COARSE;
+	}
+
+	pcf2123_write_reg(dev, PCF2123_REG_OFFSET, reg);
+	if (ret < 0)
+		return -EIO;
+
+	return count;
+}
+
 static int pcf2123_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	u8 rxbuf[7];
@@ -320,6 +385,8 @@ static DEVICE_ATTR(c, S_IRUGO | S_IWUSR, pcf2123_show, pcf2123_store);
 static DEVICE_ATTR(d, S_IRUGO | S_IWUSR, pcf2123_show, pcf2123_store);
 static DEVICE_ATTR(e, S_IRUGO | S_IWUSR, pcf2123_show, pcf2123_store);
 static DEVICE_ATTR(f, S_IRUGO | S_IWUSR, pcf2123_show, pcf2123_store);
+static DEVICE_ATTR(adjust, S_IRUGO | S_IWUSR, pcf2123_adjust_show,
+		   pcf2123_adjust_store);
 
 static struct attribute *pcf2123_attrs[] = {
 	&dev_attr_0.attr,
@@ -338,6 +405,7 @@ static struct attribute *pcf2123_attrs[] = {
 	&dev_attr_d.attr,
 	&dev_attr_e.attr,
 	&dev_attr_f.attr,
+	&dev_attr_adjust.attr,
 	NULL
 };
 
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
