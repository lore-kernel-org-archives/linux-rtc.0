Return-Path: <rtc-linux+bncBDM47J4M6QEBBFEF7DCAKGQECV3VMPI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from dukecmmtar03.coxmail.com (dukecmmtar03.coxmail.com. [68.99.120.44])
        by gmr-mx.google.com with ESMTP id z73si477103pfa.2.2017.02.10.10.12.36
        for <rtc-linux@googlegroups.com>;
        Fri, 10 Feb 2017 10:12:36 -0800 (PST)
From: H Hartley Sweeten <hsweeten@visionengravers.com>
To: rtc-linux@googlegroups.com
Cc: alex@digriz.org.uk,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 2/3] rtc: m48t86: allow driver to manage it's resources
Date: Fri, 10 Feb 2017 11:11:56 -0700
Message-Id: <20170210181157.6283-3-hsweeten@visionengravers.com>
In-Reply-To: <20170210181157.6283-1-hsweeten@visionengravers.com>
References: <20170210181157.6283-1-hsweeten@visionengravers.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Allow this driver to, optionally, manage it's own resources and do the
read/write operations if the platform does not provide them.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alexander Clouter <alex@digriz.org.uk>
---
 drivers/rtc/rtc-m48t86.c | 153 +++++++++++++++++++++++++++++++----------------
 1 file changed, 102 insertions(+), 51 deletions(-)

diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index 30648ea..4dcdbd2 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/rtc-m48t86.h>
 #include <linux/bcd.h>
+#include <linux/io.h>
 
 #define M48T86_SEC		0x00
 #define M48T86_SECALRM		0x01
@@ -38,39 +39,72 @@
 #define M48T86_D		0x0d
 #define M48T86_D_VRT		BIT(7)
 
+struct m48t86_rtc_info {
+	void __iomem *index_reg;
+	void __iomem *data_reg;
+	struct rtc_device *rtc;
+	struct m48t86_ops *ops;
+};
+
+static unsigned char m48t86_readb(struct device *dev, unsigned long addr)
+{
+	struct m48t86_rtc_info *info = dev_get_drvdata(dev);
+	unsigned char value;
+
+	if (info->ops) {
+		value = info->ops->readbyte(addr);
+	} else {
+		writeb(addr, info->index_reg);
+		value = readb(info->data_reg);
+	}
+	return value;
+}
+
+static void m48t86_writeb(struct device *dev,
+			  unsigned char value, unsigned long addr)
+{
+	struct m48t86_rtc_info *info = dev_get_drvdata(dev);
+
+	if (info->ops) {
+		info->ops->writebyte(value, addr);
+	} else {
+		writeb(addr, info->index_reg);
+		writeb(value, info->data_reg);
+	}
+}
+
 static int m48t86_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	unsigned char reg;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct m48t86_ops *ops = dev_get_platdata(&pdev->dev);
 
-	reg = ops->readbyte(M48T86_B);
+	reg = m48t86_readb(dev, M48T86_B);
 
 	if (reg & M48T86_B_DM) {
 		/* data (binary) mode */
-		tm->tm_sec	= ops->readbyte(M48T86_SEC);
-		tm->tm_min	= ops->readbyte(M48T86_MIN);
-		tm->tm_hour	= ops->readbyte(M48T86_HOUR) & 0x3f;
-		tm->tm_mday	= ops->readbyte(M48T86_DOM);
+		tm->tm_sec	= m48t86_readb(dev, M48T86_SEC);
+		tm->tm_min	= m48t86_readb(dev, M48T86_MIN);
+		tm->tm_hour	= m48t86_readb(dev, M48T86_HOUR) & 0x3f;
+		tm->tm_mday	= m48t86_readb(dev, M48T86_DOM);
 		/* tm_mon is 0-11 */
-		tm->tm_mon	= ops->readbyte(M48T86_MONTH) - 1;
-		tm->tm_year	= ops->readbyte(M48T86_YEAR) + 100;
-		tm->tm_wday	= ops->readbyte(M48T86_DOW);
+		tm->tm_mon	= m48t86_readb(dev, M48T86_MONTH) - 1;
+		tm->tm_year	= m48t86_readb(dev, M48T86_YEAR) + 100;
+		tm->tm_wday	= m48t86_readb(dev, M48T86_DOW);
 	} else {
 		/* bcd mode */
-		tm->tm_sec	= bcd2bin(ops->readbyte(M48T86_SEC));
-		tm->tm_min	= bcd2bin(ops->readbyte(M48T86_MIN));
-		tm->tm_hour	= bcd2bin(ops->readbyte(M48T86_HOUR) & 0x3f);
-		tm->tm_mday	= bcd2bin(ops->readbyte(M48T86_DOM));
+		tm->tm_sec	= bcd2bin(m48t86_readb(dev, M48T86_SEC));
+		tm->tm_min	= bcd2bin(m48t86_readb(dev, M48T86_MIN));
+		tm->tm_hour	= bcd2bin(m48t86_readb(dev, M48T86_HOUR) &
+					  0x3f);
+		tm->tm_mday	= bcd2bin(m48t86_readb(dev, M48T86_DOM));
 		/* tm_mon is 0-11 */
-		tm->tm_mon	= bcd2bin(ops->readbyte(M48T86_MONTH)) - 1;
-		tm->tm_year	= bcd2bin(ops->readbyte(M48T86_YEAR)) + 100;
-		tm->tm_wday	= bcd2bin(ops->readbyte(M48T86_DOW));
+		tm->tm_mon	= bcd2bin(m48t86_readb(dev, M48T86_MONTH)) - 1;
+		tm->tm_year	= bcd2bin(m48t86_readb(dev, M48T86_YEAR)) + 100;
+		tm->tm_wday	= bcd2bin(m48t86_readb(dev, M48T86_DOW));
 	}
 
 	/* correct the hour if the clock is in 12h mode */
 	if (!(reg & M48T86_B_H24))
-		if (ops->readbyte(M48T86_HOUR) & 0x80)
+		if (m48t86_readb(dev, M48T86_HOUR) & 0x80)
 			tm->tm_hour += 12;
 
 	return rtc_valid_tm(tm);
@@ -79,38 +113,36 @@ static int m48t86_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int m48t86_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	unsigned char reg;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct m48t86_ops *ops = dev_get_platdata(&pdev->dev);
 
-	reg = ops->readbyte(M48T86_B);
+	reg = m48t86_readb(dev, M48T86_B);
 
 	/* update flag and 24h mode */
 	reg |= M48T86_B_SET | M48T86_B_H24;
-	ops->writebyte(reg, M48T86_B);
+	m48t86_writeb(dev, reg, M48T86_B);
 
 	if (reg & M48T86_B_DM) {
 		/* data (binary) mode */
-		ops->writebyte(tm->tm_sec, M48T86_SEC);
-		ops->writebyte(tm->tm_min, M48T86_MIN);
-		ops->writebyte(tm->tm_hour, M48T86_HOUR);
-		ops->writebyte(tm->tm_mday, M48T86_DOM);
-		ops->writebyte(tm->tm_mon + 1, M48T86_MONTH);
-		ops->writebyte(tm->tm_year % 100, M48T86_YEAR);
-		ops->writebyte(tm->tm_wday, M48T86_DOW);
+		m48t86_writeb(dev, tm->tm_sec, M48T86_SEC);
+		m48t86_writeb(dev, tm->tm_min, M48T86_MIN);
+		m48t86_writeb(dev, tm->tm_hour, M48T86_HOUR);
+		m48t86_writeb(dev, tm->tm_mday, M48T86_DOM);
+		m48t86_writeb(dev, tm->tm_mon + 1, M48T86_MONTH);
+		m48t86_writeb(dev, tm->tm_year % 100, M48T86_YEAR);
+		m48t86_writeb(dev, tm->tm_wday, M48T86_DOW);
 	} else {
 		/* bcd mode */
-		ops->writebyte(bin2bcd(tm->tm_sec), M48T86_SEC);
-		ops->writebyte(bin2bcd(tm->tm_min), M48T86_MIN);
-		ops->writebyte(bin2bcd(tm->tm_hour), M48T86_HOUR);
-		ops->writebyte(bin2bcd(tm->tm_mday), M48T86_DOM);
-		ops->writebyte(bin2bcd(tm->tm_mon + 1), M48T86_MONTH);
-		ops->writebyte(bin2bcd(tm->tm_year % 100), M48T86_YEAR);
-		ops->writebyte(bin2bcd(tm->tm_wday), M48T86_DOW);
+		m48t86_writeb(dev, bin2bcd(tm->tm_sec), M48T86_SEC);
+		m48t86_writeb(dev, bin2bcd(tm->tm_min), M48T86_MIN);
+		m48t86_writeb(dev, bin2bcd(tm->tm_hour), M48T86_HOUR);
+		m48t86_writeb(dev, bin2bcd(tm->tm_mday), M48T86_DOM);
+		m48t86_writeb(dev, bin2bcd(tm->tm_mon + 1), M48T86_MONTH);
+		m48t86_writeb(dev, bin2bcd(tm->tm_year % 100), M48T86_YEAR);
+		m48t86_writeb(dev, bin2bcd(tm->tm_wday), M48T86_DOW);
 	}
 
 	/* update ended */
 	reg &= ~M48T86_B_SET;
-	ops->writebyte(reg, M48T86_B);
+	m48t86_writeb(dev, reg, M48T86_B);
 
 	return 0;
 }
@@ -118,15 +150,13 @@ static int m48t86_rtc_set_time(struct device *dev, struct rtc_time *tm)
 static int m48t86_rtc_proc(struct device *dev, struct seq_file *seq)
 {
 	unsigned char reg;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct m48t86_ops *ops = dev_get_platdata(&pdev->dev);
 
-	reg = ops->readbyte(M48T86_B);
+	reg = m48t86_readb(dev, M48T86_B);
 
 	seq_printf(seq, "mode\t\t: %s\n",
 		   (reg & M48T86_B_DM) ? "binary" : "bcd");
 
-	reg = ops->readbyte(M48T86_D);
+	reg = m48t86_readb(dev, M48T86_D);
 
 	seq_printf(seq, "battery\t\t: %s\n",
 		   (reg & M48T86_D_VRT) ? "ok" : "exhausted");
@@ -140,23 +170,44 @@ static const struct rtc_class_ops m48t86_rtc_ops = {
 	.proc		= m48t86_rtc_proc,
 };
 
-static int m48t86_rtc_probe(struct platform_device *dev)
+static int m48t86_rtc_probe(struct platform_device *pdev)
 {
+	struct m48t86_rtc_info *info;
 	unsigned char reg;
-	struct m48t86_ops *ops = dev_get_platdata(&dev->dev);
-	struct rtc_device *rtc;
 
-	rtc = devm_rtc_device_register(&dev->dev, "m48t86",
-				       &m48t86_rtc_ops, THIS_MODULE);
+	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->ops = dev_get_platdata(&pdev->dev);
+	if (!info->ops) {
+		struct resource *res;
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!res)
+			return -ENODEV;
+		info->index_reg = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(info->index_reg))
+			return PTR_ERR(info->index_reg);
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (!res)
+			return -ENODEV;
+		info->data_reg = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(info->data_reg))
+			return PTR_ERR(info->data_reg);
+	}
 
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
+	dev_set_drvdata(&pdev->dev, info);
 
-	platform_set_drvdata(dev, rtc);
+	info->rtc = devm_rtc_device_register(&pdev->dev, "m48t86",
+					     &m48t86_rtc_ops, THIS_MODULE);
+	if (IS_ERR(info->rtc))
+		return PTR_ERR(info->rtc);
 
 	/* read battery status */
-	reg = ops->readbyte(M48T86_D);
-	dev_info(&dev->dev, "battery %s\n",
+	reg = m48t86_readb(&pdev->dev, M48T86_D);
+	dev_info(&pdev->dev, "battery %s\n",
 		 (reg & M48T86_D_VRT) ? "ok" : "exhausted");
 
 	return 0;
-- 
2.10.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
