Return-Path: <rtc-linux+bncBCNNJWF7RUMRBIWM5CYQKGQERX2GCGI@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com. [2607:f8b0:400e:c03::232])
        by gmr-mx.google.com with ESMTPS id fa8si182608pab.1.2015.11.04.07.37.05
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2015 07:37:05 -0800 (PST)
Received: by mail-pa0-x232.google.com with SMTP id fh17so56007588pab.0
        for <rtc-linux@googlegroups.com>; Wed, 04 Nov 2015 07:37:05 -0800 (PST)
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Joshua Clayton <stillcompiling@gmail.com>
Subject: [rtc-linux] [PATCH 2/9] rtc-pcf2123: clean up reads from the chip
Date: Wed,  4 Nov 2015 07:36:33 -0800
Message-Id: <d13636dfaabcaf43d4409068bdd6b579d34b0de4.1446587705.git.stillcompiling@gmail.com>
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

put read operations into a function.
This makes the starting register more prominent and hides the delay.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/rtc/rtc-pcf2123.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index 7756210..648cb74 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -104,12 +104,26 @@ static inline void pcf2123_delay_trec(void)
 	ndelay(30);
 }
 
+static int pcf2123_read(struct device *dev, u8 reg, u8 *rxbuf, size_t size)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	int ret;
+
+	if (reg > PCF2123_REG_MAX)
+		return -EFAULT;
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
 
@@ -119,11 +133,10 @@ static ssize_t pcf2123_show(struct device *dev, struct device_attribute *attr,
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
 
@@ -158,16 +171,12 @@ static ssize_t pcf2123_store(struct device *dev, struct device_attribute *attr,
 
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
@@ -279,16 +288,12 @@ static int pcf2123_probe(struct spi_device *spi)
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
