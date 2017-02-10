Return-Path: <rtc-linux+bncBDM47J4M6QEBBFEF7DCAKGQECV3VMPI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from dukecmmtar03.coxmail.com (dukecmmtar03.coxmail.com. [68.99.120.44])
        by gmr-mx.google.com with ESMTP id z3si488134pfj.0.2017.02.10.10.12.36
        for <rtc-linux@googlegroups.com>;
        Fri, 10 Feb 2017 10:12:36 -0800 (PST)
From: H Hartley Sweeten <hsweeten@visionengravers.com>
To: rtc-linux@googlegroups.com
Cc: alex@digriz.org.uk,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 1/3] rtc: m48t86: shorten register name defines
Date: Fri, 10 Feb 2017 11:11:55 -0700
Message-Id: <20170210181157.6283-2-hsweeten@visionengravers.com>
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

For asthetics. shorten all the register names by removing '_REG' from all of them.
This helps fix all the checkpatch.pl issues.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alexander Clouter <alex@digriz.org.uk>
---
 drivers/rtc/rtc-m48t86.c | 127 +++++++++++++++++++++++------------------------
 1 file changed, 63 insertions(+), 64 deletions(-)

diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index 0eeb571..30648ea 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -19,25 +19,24 @@
 #include <linux/platform_data/rtc-m48t86.h>
 #include <linux/bcd.h>
 
-#define M48T86_REG_SEC		0x00
-#define M48T86_REG_SECALRM	0x01
-#define M48T86_REG_MIN		0x02
-#define M48T86_REG_MINALRM	0x03
-#define M48T86_REG_HOUR		0x04
-#define M48T86_REG_HOURALRM	0x05
-#define M48T86_REG_DOW		0x06 /* 1 = sunday */
-#define M48T86_REG_DOM		0x07
-#define M48T86_REG_MONTH	0x08 /* 1 - 12 */
-#define M48T86_REG_YEAR		0x09 /* 0 - 99 */
-#define M48T86_REG_A		0x0A
-#define M48T86_REG_B		0x0B
-#define M48T86_REG_C		0x0C
-#define M48T86_REG_D		0x0D
-
-#define M48T86_REG_B_H24	(1 << 1)
-#define M48T86_REG_B_DM		(1 << 2)
-#define M48T86_REG_B_SET	(1 << 7)
-#define M48T86_REG_D_VRT	(1 << 7)
+#define M48T86_SEC		0x00
+#define M48T86_SECALRM		0x01
+#define M48T86_MIN		0x02
+#define M48T86_MINALRM		0x03
+#define M48T86_HOUR		0x04
+#define M48T86_HOURALRM		0x05
+#define M48T86_DOW		0x06 /* 1 = sunday */
+#define M48T86_DOM		0x07
+#define M48T86_MONTH		0x08 /* 1 - 12 */
+#define M48T86_YEAR		0x09 /* 0 - 99 */
+#define M48T86_A		0x0a
+#define M48T86_B		0x0b
+#define M48T86_B_SET		BIT(7)
+#define M48T86_B_DM		BIT(2)
+#define M48T86_B_H24		BIT(1)
+#define M48T86_C		0x0c
+#define M48T86_D		0x0d
+#define M48T86_D_VRT		BIT(7)
 
 static int m48t86_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
@@ -45,33 +44,33 @@ static int m48t86_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct m48t86_ops *ops = dev_get_platdata(&pdev->dev);
 
-	reg = ops->readbyte(M48T86_REG_B);
+	reg = ops->readbyte(M48T86_B);
 
-	if (reg & M48T86_REG_B_DM) {
+	if (reg & M48T86_B_DM) {
 		/* data (binary) mode */
-		tm->tm_sec	= ops->readbyte(M48T86_REG_SEC);
-		tm->tm_min	= ops->readbyte(M48T86_REG_MIN);
-		tm->tm_hour	= ops->readbyte(M48T86_REG_HOUR) & 0x3F;
-		tm->tm_mday	= ops->readbyte(M48T86_REG_DOM);
+		tm->tm_sec	= ops->readbyte(M48T86_SEC);
+		tm->tm_min	= ops->readbyte(M48T86_MIN);
+		tm->tm_hour	= ops->readbyte(M48T86_HOUR) & 0x3f;
+		tm->tm_mday	= ops->readbyte(M48T86_DOM);
 		/* tm_mon is 0-11 */
-		tm->tm_mon	= ops->readbyte(M48T86_REG_MONTH) - 1;
-		tm->tm_year	= ops->readbyte(M48T86_REG_YEAR) + 100;
-		tm->tm_wday	= ops->readbyte(M48T86_REG_DOW);
+		tm->tm_mon	= ops->readbyte(M48T86_MONTH) - 1;
+		tm->tm_year	= ops->readbyte(M48T86_YEAR) + 100;
+		tm->tm_wday	= ops->readbyte(M48T86_DOW);
 	} else {
 		/* bcd mode */
-		tm->tm_sec	= bcd2bin(ops->readbyte(M48T86_REG_SEC));
-		tm->tm_min	= bcd2bin(ops->readbyte(M48T86_REG_MIN));
-		tm->tm_hour	= bcd2bin(ops->readbyte(M48T86_REG_HOUR) & 0x3F);
-		tm->tm_mday	= bcd2bin(ops->readbyte(M48T86_REG_DOM));
+		tm->tm_sec	= bcd2bin(ops->readbyte(M48T86_SEC));
+		tm->tm_min	= bcd2bin(ops->readbyte(M48T86_MIN));
+		tm->tm_hour	= bcd2bin(ops->readbyte(M48T86_HOUR) & 0x3f);
+		tm->tm_mday	= bcd2bin(ops->readbyte(M48T86_DOM));
 		/* tm_mon is 0-11 */
-		tm->tm_mon	= bcd2bin(ops->readbyte(M48T86_REG_MONTH)) - 1;
-		tm->tm_year	= bcd2bin(ops->readbyte(M48T86_REG_YEAR)) + 100;
-		tm->tm_wday	= bcd2bin(ops->readbyte(M48T86_REG_DOW));
+		tm->tm_mon	= bcd2bin(ops->readbyte(M48T86_MONTH)) - 1;
+		tm->tm_year	= bcd2bin(ops->readbyte(M48T86_YEAR)) + 100;
+		tm->tm_wday	= bcd2bin(ops->readbyte(M48T86_DOW));
 	}
 
 	/* correct the hour if the clock is in 12h mode */
-	if (!(reg & M48T86_REG_B_H24))
-		if (ops->readbyte(M48T86_REG_HOUR) & 0x80)
+	if (!(reg & M48T86_B_H24))
+		if (ops->readbyte(M48T86_HOUR) & 0x80)
 			tm->tm_hour += 12;
 
 	return rtc_valid_tm(tm);
@@ -83,35 +82,35 @@ static int m48t86_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct m48t86_ops *ops = dev_get_platdata(&pdev->dev);
 
-	reg = ops->readbyte(M48T86_REG_B);
+	reg = ops->readbyte(M48T86_B);
 
 	/* update flag and 24h mode */
-	reg |= M48T86_REG_B_SET | M48T86_REG_B_H24;
-	ops->writebyte(reg, M48T86_REG_B);
+	reg |= M48T86_B_SET | M48T86_B_H24;
+	ops->writebyte(reg, M48T86_B);
 
-	if (reg & M48T86_REG_B_DM) {
+	if (reg & M48T86_B_DM) {
 		/* data (binary) mode */
-		ops->writebyte(tm->tm_sec, M48T86_REG_SEC);
-		ops->writebyte(tm->tm_min, M48T86_REG_MIN);
-		ops->writebyte(tm->tm_hour, M48T86_REG_HOUR);
-		ops->writebyte(tm->tm_mday, M48T86_REG_DOM);
-		ops->writebyte(tm->tm_mon + 1, M48T86_REG_MONTH);
-		ops->writebyte(tm->tm_year % 100, M48T86_REG_YEAR);
-		ops->writebyte(tm->tm_wday, M48T86_REG_DOW);
+		ops->writebyte(tm->tm_sec, M48T86_SEC);
+		ops->writebyte(tm->tm_min, M48T86_MIN);
+		ops->writebyte(tm->tm_hour, M48T86_HOUR);
+		ops->writebyte(tm->tm_mday, M48T86_DOM);
+		ops->writebyte(tm->tm_mon + 1, M48T86_MONTH);
+		ops->writebyte(tm->tm_year % 100, M48T86_YEAR);
+		ops->writebyte(tm->tm_wday, M48T86_DOW);
 	} else {
 		/* bcd mode */
-		ops->writebyte(bin2bcd(tm->tm_sec), M48T86_REG_SEC);
-		ops->writebyte(bin2bcd(tm->tm_min), M48T86_REG_MIN);
-		ops->writebyte(bin2bcd(tm->tm_hour), M48T86_REG_HOUR);
-		ops->writebyte(bin2bcd(tm->tm_mday), M48T86_REG_DOM);
-		ops->writebyte(bin2bcd(tm->tm_mon + 1), M48T86_REG_MONTH);
-		ops->writebyte(bin2bcd(tm->tm_year % 100), M48T86_REG_YEAR);
-		ops->writebyte(bin2bcd(tm->tm_wday), M48T86_REG_DOW);
+		ops->writebyte(bin2bcd(tm->tm_sec), M48T86_SEC);
+		ops->writebyte(bin2bcd(tm->tm_min), M48T86_MIN);
+		ops->writebyte(bin2bcd(tm->tm_hour), M48T86_HOUR);
+		ops->writebyte(bin2bcd(tm->tm_mday), M48T86_DOM);
+		ops->writebyte(bin2bcd(tm->tm_mon + 1), M48T86_MONTH);
+		ops->writebyte(bin2bcd(tm->tm_year % 100), M48T86_YEAR);
+		ops->writebyte(bin2bcd(tm->tm_wday), M48T86_DOW);
 	}
 
 	/* update ended */
-	reg &= ~M48T86_REG_B_SET;
-	ops->writebyte(reg, M48T86_REG_B);
+	reg &= ~M48T86_B_SET;
+	ops->writebyte(reg, M48T86_B);
 
 	return 0;
 }
@@ -122,15 +121,15 @@ static int m48t86_rtc_proc(struct device *dev, struct seq_file *seq)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct m48t86_ops *ops = dev_get_platdata(&pdev->dev);
 
-	reg = ops->readbyte(M48T86_REG_B);
+	reg = ops->readbyte(M48T86_B);
 
 	seq_printf(seq, "mode\t\t: %s\n",
-		 (reg & M48T86_REG_B_DM) ? "binary" : "bcd");
+		   (reg & M48T86_B_DM) ? "binary" : "bcd");
 
-	reg = ops->readbyte(M48T86_REG_D);
+	reg = ops->readbyte(M48T86_D);
 
 	seq_printf(seq, "battery\t\t: %s\n",
-		 (reg & M48T86_REG_D_VRT) ? "ok" : "exhausted");
+		   (reg & M48T86_D_VRT) ? "ok" : "exhausted");
 
 	return 0;
 }
@@ -148,7 +147,7 @@ static int m48t86_rtc_probe(struct platform_device *dev)
 	struct rtc_device *rtc;
 
 	rtc = devm_rtc_device_register(&dev->dev, "m48t86",
-				&m48t86_rtc_ops, THIS_MODULE);
+				       &m48t86_rtc_ops, THIS_MODULE);
 
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
@@ -156,9 +155,9 @@ static int m48t86_rtc_probe(struct platform_device *dev)
 	platform_set_drvdata(dev, rtc);
 
 	/* read battery status */
-	reg = ops->readbyte(M48T86_REG_D);
+	reg = ops->readbyte(M48T86_D);
 	dev_info(&dev->dev, "battery %s\n",
-		(reg & M48T86_REG_D_VRT) ? "ok" : "exhausted");
+		 (reg & M48T86_D_VRT) ? "ok" : "exhausted");
 
 	return 0;
 }
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
