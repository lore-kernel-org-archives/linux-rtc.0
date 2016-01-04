Return-Path: <rtc-linux+bncBCNNJWF7RUMRBCPVVK2AKGQEJ4U5ATI@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com. [2607:f8b0:400e:c03::242])
        by gmr-mx.google.com with ESMTPS id jj4si7959505pac.2.2016.01.04.10.31.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2016 10:31:37 -0800 (PST)
Received: by mail-pa0-x242.google.com with SMTP id pv5so16478606pac.0
        for <rtc-linux@googlegroups.com>; Mon, 04 Jan 2016 10:31:37 -0800 (PST)
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Joshua Clayton <stillcompiling@gmail.com>
Subject: [rtc-linux] [PATCH v2 2/8] rtc-pcf2123: clean up reads from the chip
Date: Mon,  4 Jan 2016 10:31:20 -0800
Message-Id: <d4add810d4260d2d741e6b2960e44e664f7898c9.1451929910.git.stillcompiling@gmail.com>
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

Put read operations into a function.
This improves modularity and readability.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/rtc/rtc-pcf2123.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index be3ec83..4c4b3fc 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -128,12 +128,23 @@ static inline void pcf2123_delay_trec(void)
 	ndelay(30);
 }
 
+static int pcf2123_read(struct device *dev, u8 reg, u8 *rxbuf, size_t size)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	int ret;
+
+	reg |= PCF2123_READ;
+	ret = spi_write_then_read(spi, &reg, 1, rxbuf, size);
+	pcf2123_delay_trec();
+
+	return ret;
+}
+
 static ssize_t pcf2123_show(struct device *dev, struct device_attribute *attr,
 			    char *buffer)
 {
-	struct spi_device *spi = to_spi_device(dev);
 	struct pcf2123_sysfs_reg *r;
-	u8 txbuf[1], rxbuf[1];
+	u8 rxbuf[1];
 	unsigned long reg;
 	int ret;
 
@@ -143,11 +154,10 @@ static ssize_t pcf2123_show(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	txbuf[0] = PCF2123_READ | reg;
-	ret = spi_write_then_read(spi, txbuf, 1, rxbuf, 1);
+	ret = pcf2123_read(dev, reg, rxbuf, 1);
 	if (ret < 0)
 		return -EIO;
-	pcf2123_delay_trec();
+
 	return sprintf(buffer, "0x%x\n", rxbuf[0]);
 }
 
@@ -182,16 +192,12 @@ static ssize_t pcf2123_store(struct device *dev, struct device_attribute *attr,
 
 static int pcf2123_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	struct spi_device *spi = to_spi_device(dev);
-	u8 txbuf[1], rxbuf[7];
+	u8 rxbuf[7];
 	int ret;
 
-	txbuf[0] = PCF2123_READ | PCF2123_REG_SC;
-	ret = spi_write_then_read(spi, txbuf, sizeof(txbuf),
-			rxbuf, sizeof(rxbuf));
+	ret = pcf2123_read(dev, PCF2123_REG_SC, rxbuf, sizeof(rxbuf));
 	if (ret < 0)
 		return ret;
-	pcf2123_delay_trec();
 
 	tm->tm_sec = bcd2bin(rxbuf[0] & 0x7F);
 	tm->tm_min = bcd2bin(rxbuf[1] & 0x7F);
@@ -297,16 +303,12 @@ static int pcf2123_probe(struct spi_device *spi)
 	pcf2123_delay_trec();
 
 	/* See if the counter was actually stopped */
-	txbuf[0] = PCF2123_READ | PCF2123_REG_CTRL1;
-	dev_dbg(&spi->dev, "checking for presence of RTC (0x%02X)\n",
-			txbuf[0]);
-	ret = spi_write_then_read(spi, txbuf, 1 * sizeof(u8),
-					rxbuf, 2 * sizeof(u8));
+	dev_dbg(&spi->dev, "checking for presence of RTC\n");
+	ret = pcf2123_read(&spi->dev, PCF2123_REG_CTRL1, rxbuf, sizeof(rxbuf));
 	dev_dbg(&spi->dev, "received data from RTC (0x%02X 0x%02X)\n",
 			rxbuf[0], rxbuf[1]);
 	if (ret < 0)
 		goto kfree_exit;
-	pcf2123_delay_trec();
 
 	if (!(rxbuf[0] & 0x20)) {
 		dev_err(&spi->dev, "chip not found\n");
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
