Return-Path: <rtc-linux+bncBCNNJWF7RUMRBKWM5CYQKGQECOBP7OA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com. [2607:f8b0:400e:c03::232])
        by gmr-mx.google.com with ESMTPS id fa8si182608pab.1.2015.11.04.07.37.14
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2015 07:37:14 -0800 (PST)
Received: by mail-pa0-x232.google.com with SMTP id fh17so56007588pab.0
        for <rtc-linux@googlegroups.com>; Wed, 04 Nov 2015 07:37:14 -0800 (PST)
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Joshua Clayton <stillcompiling@gmail.com>
Subject: [rtc-linux] [PATCH 8/9] rtc-pcf2123: use sysfs groups
Date: Wed,  4 Nov 2015 07:36:39 -0800
Message-Id: <63d5284dfb9d04f1f0a33c02cd937e2ddd72fb9b.1446587705.git.stillcompiling@gmail.com>
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

Switch from manually creating all the sysfs attributes to
defining them mostly in the canonical way.
We are adding them to an spi driver, so we must still add and remove
the group manually, but everythig else is done by The Book(tm) .

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/rtc/rtc-pcf2123.c | 118 +++++++++++++++++++++-------------------------
 1 file changed, 55 insertions(+), 63 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index 6701e6d..d494638 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -84,16 +84,6 @@
 
 static struct spi_driver pcf2123_driver;
 
-struct pcf2123_sysfs_reg {
-	struct device_attribute attr;
-	char name[2];
-};
-
-struct pcf2123_plat_data {
-	struct rtc_device *rtc;
-	struct pcf2123_sysfs_reg regs[16];
-};
-
 /*
  * Causes a 30 nanosecond delay to ensure that the PCF2123 chip select
  * is released properly after an SPI write.  This function should be
@@ -146,17 +136,11 @@ static int pcf2123_write_reg(struct device *dev, u8 reg, u8 val)
 static ssize_t pcf2123_show(struct device *dev, struct device_attribute *attr,
 			    char *buffer)
 {
-	struct pcf2123_sysfs_reg *r;
 	u8 rxbuf[1];
 	unsigned long reg;
 	int ret;
 
-	r = container_of(attr, struct pcf2123_sysfs_reg, attr);
-
-	ret = kstrtoul(r->name, 16, &reg);
-	if (ret)
-		return ret;
-
+	reg = hex_to_bin(attr->attr.name[0]);
 	ret = pcf2123_read(dev, reg, rxbuf, 1);
 	if (ret < 0)
 		return -EIO;
@@ -166,25 +150,19 @@ static ssize_t pcf2123_show(struct device *dev, struct device_attribute *attr,
 
 static ssize_t pcf2123_store(struct device *dev, struct device_attribute *attr,
 			     const char *buffer, size_t count) {
-	struct pcf2123_sysfs_reg *r;
 	unsigned long reg;
 	unsigned long val;
-
 	int ret;
 
-	r = container_of(attr, struct pcf2123_sysfs_reg, attr);
-
-	ret = kstrtoul(r->name, 16, &reg);
-	if (ret)
-		return ret;
-
 	ret = kstrtoul(buffer, 0, &val);
 	if (ret)
 		return ret;
 
+	reg = hex_to_bin(attr->attr.name[0]);
 	pcf2123_write_reg(dev, reg, val);
 	if (ret < 0)
 		return -EIO;
+
 	return count;
 }
 
@@ -326,17 +304,56 @@ static const struct rtc_class_ops pcf2123_rtc_ops = {
 	.set_time	= pcf2123_rtc_set_time,
 };
 
+static DEVICE_ATTR(0, S_IRUGO | S_IWUSR, pcf2123_show, pcf2123_store);
+static DEVICE_ATTR(1, S_IRUGO | S_IWUSR, pcf2123_show, pcf2123_store);
+static DEVICE_ATTR(2, S_IRUGO | S_IWUSR, pcf2123_show, pcf2123_store);
+static DEVICE_ATTR(3, S_IRUGO | S_IWUSR, pcf2123_show, pcf2123_store);
+static DEVICE_ATTR(4, S_IRUGO | S_IWUSR, pcf2123_show, pcf2123_store);
+static DEVICE_ATTR(5, S_IRUGO | S_IWUSR, pcf2123_show, pcf2123_store);
+static DEVICE_ATTR(6, S_IRUGO | S_IWUSR, pcf2123_show, pcf2123_store);
+static DEVICE_ATTR(7, S_IRUGO | S_IWUSR, pcf2123_show, pcf2123_store);
+static DEVICE_ATTR(8, S_IRUGO | S_IWUSR, pcf2123_show, pcf2123_store);
+static DEVICE_ATTR(9, S_IRUGO | S_IWUSR, pcf2123_show, pcf2123_store);
+static DEVICE_ATTR(a, S_IRUGO | S_IWUSR, pcf2123_show, pcf2123_store);
+static DEVICE_ATTR(b, S_IRUGO | S_IWUSR, pcf2123_show, pcf2123_store);
+static DEVICE_ATTR(c, S_IRUGO | S_IWUSR, pcf2123_show, pcf2123_store);
+static DEVICE_ATTR(d, S_IRUGO | S_IWUSR, pcf2123_show, pcf2123_store);
+static DEVICE_ATTR(e, S_IRUGO | S_IWUSR, pcf2123_show, pcf2123_store);
+static DEVICE_ATTR(f, S_IRUGO | S_IWUSR, pcf2123_show, pcf2123_store);
+
+static struct attribute *pcf2123_attrs[] = {
+	&dev_attr_0.attr,
+	&dev_attr_1.attr,
+	&dev_attr_2.attr,
+	&dev_attr_3.attr,
+	&dev_attr_4.attr,
+	&dev_attr_5.attr,
+	&dev_attr_6.attr,
+	&dev_attr_7.attr,
+	&dev_attr_8.attr,
+	&dev_attr_9.attr,
+	&dev_attr_a.attr,
+	&dev_attr_b.attr,
+	&dev_attr_c.attr,
+	&dev_attr_d.attr,
+	&dev_attr_e.attr,
+	&dev_attr_f.attr,
+	NULL
+};
+
+static const struct attribute_group pcf2123_group = {
+	.attrs = pcf2123_attrs,
+};
+
+static const struct attribute_group *pcf2123_groups[] = {
+	&pcf2123_group,
+	NULL
+};
+
 static int pcf2123_probe(struct spi_device *spi)
 {
 	struct rtc_device *rtc;
-	struct pcf2123_plat_data *pdata;
-	int ret, i;
-
-	pdata = devm_kzalloc(&spi->dev, sizeof(struct pcf2123_plat_data),
-				GFP_KERNEL);
-	if (!pdata)
-		return -ENOMEM;
-	spi->dev.platform_data = pdata;
+	int ret;
 
 	if (!pcf2123_time_valid(&spi->dev)) {
 		ret = pcf2123_reset(&spi->dev);
@@ -360,29 +377,13 @@ static int pcf2123_probe(struct spi_device *spi)
 		goto kfree_exit;
 	}
 
-	pdata->rtc = rtc;
-
-	for (i = 0; i < 16; i++) {
-		sysfs_attr_init(&pdata->regs[i].attr.attr);
-		sprintf(pdata->regs[i].name, "%1x", i);
-		pdata->regs[i].attr.attr.mode = S_IRUGO | S_IWUSR;
-		pdata->regs[i].attr.attr.name = pdata->regs[i].name;
-		pdata->regs[i].attr.show = pcf2123_show;
-		pdata->regs[i].attr.store = pcf2123_store;
-		ret = device_create_file(&spi->dev, &pdata->regs[i].attr);
-		if (ret) {
-			dev_err(&spi->dev, "Unable to create sysfs %s\n",
-				pdata->regs[i].name);
-			goto sysfs_exit;
-		}
-	}
+	ret = sysfs_create_groups(&spi->dev.kobj, pcf2123_groups);
+	if (ret)
+		goto sysfs_exit;
 
 	return 0;
-
 sysfs_exit:
-	for (i--; i >= 0; i--)
-		device_remove_file(&spi->dev, &pdata->regs[i].attr);
-
+	sysfs_remove_groups(&spi->dev.kobj, pcf2123_groups);
 kfree_exit:
 	spi->dev.platform_data = NULL;
 	return ret;
@@ -390,16 +391,7 @@ kfree_exit:
 
 static int pcf2123_remove(struct spi_device *spi)
 {
-	struct pcf2123_plat_data *pdata = dev_get_platdata(&spi->dev);
-	int i;
-
-	if (pdata) {
-		for (i = 0; i < 16; i++)
-			if (pdata->regs[i].name[0])
-				device_remove_file(&spi->dev,
-						   &pdata->regs[i].attr);
-	}
-
+	sysfs_remove_groups(&spi->dev.kobj, pcf2123_groups);
 	return 0;
 }
 
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
