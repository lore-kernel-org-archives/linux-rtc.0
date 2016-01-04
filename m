Return-Path: <rtc-linux+bncBCNNJWF7RUMRBC7VVK2AKGQEN6WPFOA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com. [2607:f8b0:400e:c00::244])
        by gmr-mx.google.com with ESMTPS id ui7si3849854pab.0.2016.01.04.10.31.39
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2016 10:31:39 -0800 (PST)
Received: by mail-pf0-x244.google.com with SMTP id 65so16354733pff.1
        for <rtc-linux@googlegroups.com>; Mon, 04 Jan 2016 10:31:39 -0800 (PST)
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Joshua Clayton <stillcompiling@gmail.com>
Subject: [rtc-linux] [PATCH v2 3/8] rtc-pcf2123: clean up writes to the rtc chip
Date: Mon,  4 Jan 2016 10:31:21 -0800
Message-Id: <82c777d8bdfba44a20358fb77e68a08f6dc55bab.1451929910.git.stillcompiling@gmail.com>
In-Reply-To: <cover.1451928661.git.stillcompiling@gmail.com>
References: <cover.1451928661.git.stillcompiling@gmail.com>
In-Reply-To: <0000-cover-letter.patch>
References: <0000-cover-letter.patch>
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

Add new functions pcf2123_write(), and pcf2123_write_reg().
Use named defines for the values being written.

This improves modularity and readability, and reduces lines of code.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/rtc/rtc-pcf2123.c | 67 ++++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 35 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index 4c4b3fc..0f2ce45 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -140,6 +140,27 @@ static int pcf2123_read(struct device *dev, u8 reg, u8 *rxbuf, size_t size)
 	return ret;
 }
 
+static int pcf2123_write(struct device *dev, u8 *txbuf, size_t size)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	int ret;
+
+	txbuf[0] |= PCF2123_WRITE;
+	ret = spi_write(spi, txbuf, size);
+	pcf2123_delay_trec();
+
+	return ret;
+}
+
+static int pcf2123_write_reg(struct device *dev, u8 reg, u8 val)
+{
+	u8 txbuf[2];
+
+	txbuf[0] = reg;
+	txbuf[1] = val;
+	return pcf2123_write(dev, txbuf, sizeof(txbuf));
+}
+
 static ssize_t pcf2123_show(struct device *dev, struct device_attribute *attr,
 			    char *buffer)
 {
@@ -163,9 +184,7 @@ static ssize_t pcf2123_show(struct device *dev, struct device_attribute *attr,
 
 static ssize_t pcf2123_store(struct device *dev, struct device_attribute *attr,
 			     const char *buffer, size_t count) {
-	struct spi_device *spi = to_spi_device(dev);
 	struct pcf2123_sysfs_reg *r;
-	u8 txbuf[2];
 	unsigned long reg;
 	unsigned long val;
 
@@ -181,12 +200,9 @@ static ssize_t pcf2123_store(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	txbuf[0] = PCF2123_WRITE | reg;
-	txbuf[1] = val;
-	ret = spi_write(spi, txbuf, sizeof(txbuf));
+	pcf2123_write_reg(dev, reg, val);
 	if (ret < 0)
 		return -EIO;
-	pcf2123_delay_trec();
 	return count;
 }
 
@@ -220,7 +236,6 @@ static int pcf2123_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 static int pcf2123_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct spi_device *spi = to_spi_device(dev);
 	u8 txbuf[8];
 	int ret;
 
@@ -231,15 +246,12 @@ static int pcf2123_rtc_set_time(struct device *dev, struct rtc_time *tm)
 			tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
 
 	/* Stop the counter first */
-	txbuf[0] = PCF2123_WRITE | PCF2123_REG_CTRL1;
-	txbuf[1] = 0x20;
-	ret = spi_write(spi, txbuf, 2);
+	ret = pcf2123_write_reg(dev, PCF2123_REG_CTRL1, CTRL1_STOP);
 	if (ret < 0)
 		return ret;
-	pcf2123_delay_trec();
 
 	/* Set the new time */
-	txbuf[0] = PCF2123_WRITE | PCF2123_REG_SC;
+	txbuf[0] = PCF2123_REG_SC;
 	txbuf[1] = bin2bcd(tm->tm_sec & 0x7F);
 	txbuf[2] = bin2bcd(tm->tm_min & 0x7F);
 	txbuf[3] = bin2bcd(tm->tm_hour & 0x3F);
@@ -248,18 +260,14 @@ static int pcf2123_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	txbuf[6] = bin2bcd((tm->tm_mon + 1) & 0x1F); /* rtc mn 1-12 */
 	txbuf[7] = bin2bcd(tm->tm_year < 100 ? tm->tm_year : tm->tm_year - 100);
 
-	ret = spi_write(spi, txbuf, sizeof(txbuf));
+	ret = pcf2123_write(dev, txbuf, sizeof(txbuf));
 	if (ret < 0)
 		return ret;
-	pcf2123_delay_trec();
 
 	/* Start the counter */
-	txbuf[0] = PCF2123_WRITE | PCF2123_REG_CTRL1;
-	txbuf[1] = 0x00;
-	ret = spi_write(spi, txbuf, 2);
+	ret = pcf2123_write_reg(dev, PCF2123_REG_CTRL1, CTRL1_CLEAR);
 	if (ret < 0)
 		return ret;
-	pcf2123_delay_trec();
 
 	return 0;
 }
@@ -273,7 +281,7 @@ static int pcf2123_probe(struct spi_device *spi)
 {
 	struct rtc_device *rtc;
 	struct pcf2123_plat_data *pdata;
-	u8 txbuf[2], rxbuf[2];
+	u8  rxbuf[2];
 	int ret, i;
 
 	pdata = devm_kzalloc(&spi->dev, sizeof(struct pcf2123_plat_data),
@@ -283,24 +291,16 @@ static int pcf2123_probe(struct spi_device *spi)
 	spi->dev.platform_data = pdata;
 
 	/* Send a software reset command */
-	txbuf[0] = PCF2123_WRITE | PCF2123_REG_CTRL1;
-	txbuf[1] = 0x58;
-	dev_dbg(&spi->dev, "resetting RTC (0x%02X 0x%02X)\n",
-			txbuf[0], txbuf[1]);
-	ret = spi_write(spi, txbuf, 2 * sizeof(u8));
+	dev_dbg(&spi->dev, "resetting RTC\n");
+	ret = pcf2123_write_reg(&spi->dev, PCF2123_REG_CTRL1, CTRL1_SW_RESET);
 	if (ret < 0)
 		goto kfree_exit;
-	pcf2123_delay_trec();
 
 	/* Stop the counter */
-	txbuf[0] = PCF2123_WRITE | PCF2123_REG_CTRL1;
-	txbuf[1] = 0x20;
-	dev_dbg(&spi->dev, "stopping RTC (0x%02X 0x%02X)\n",
-			txbuf[0], txbuf[1]);
-	ret = spi_write(spi, txbuf, 2 * sizeof(u8));
+	dev_dbg(&spi->dev, "stopping RTC\n");
+	ret = pcf2123_write_reg(&spi->dev, PCF2123_REG_CTRL1, CTRL1_STOP);
 	if (ret < 0)
 		goto kfree_exit;
-	pcf2123_delay_trec();
 
 	/* See if the counter was actually stopped */
 	dev_dbg(&spi->dev, "checking for presence of RTC\n");
@@ -321,12 +321,9 @@ static int pcf2123_probe(struct spi_device *spi)
 			(spi->max_speed_hz + 500) / 1000);
 
 	/* Start the counter */
-	txbuf[0] = PCF2123_WRITE | PCF2123_REG_CTRL1;
-	txbuf[1] = 0x00;
-	ret = spi_write(spi, txbuf, sizeof(txbuf));
+	ret = pcf2123_write_reg(&spi->dev, PCF2123_REG_CTRL1, CTRL1_CLEAR);
 	if (ret < 0)
 		goto kfree_exit;
-	pcf2123_delay_trec();
 
 	/* Finalize the initialization */
 	rtc = devm_rtc_device_register(&spi->dev, pcf2123_driver.driver.name,
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
