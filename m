Return-Path: <rtc-linux+bncBCNNJWF7RUMRBJ6M5CYQKGQEU5GEL3Q@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com. [2607:f8b0:400e:c03::22f])
        by gmr-mx.google.com with ESMTPS id iz5si155846pbc.2.2015.11.04.07.37.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2015 07:37:11 -0800 (PST)
Received: by mail-pa0-x22f.google.com with SMTP id dm15so31850593pac.3
        for <rtc-linux@googlegroups.com>; Wed, 04 Nov 2015 07:37:11 -0800 (PST)
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Joshua Clayton <stillcompiling@gmail.com>
Subject: [rtc-linux] [PATCH 5/9] rtc-pcf2123: put the chip reset into a function
Date: Wed,  4 Nov 2015 07:36:36 -0800
Message-Id: <dd040a11817f2caac1db13ec49c64f603013b982.1446587705.git.stillcompiling@gmail.com>
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

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/rtc/rtc-pcf2123.c | 64 ++++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index 257ce7d..d3c1447 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -260,6 +260,40 @@ static int pcf2123_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
+static int pcf2123_reset(struct device *dev)
+{
+	int ret;
+	u8  rxbuf[2];
+
+	ret = pcf2123_write_reg(dev, PCF2123_REG_CTRL1, CTRL1_SW_RESET);
+	if (ret < 0)
+		return ret;
+
+	/* Stop the counter */
+	dev_dbg(dev, "stopping RTC\n");
+	ret = pcf2123_write_reg(dev, PCF2123_REG_CTRL1, CTRL1_STOP);
+	if (ret < 0)
+		return ret;
+
+	/* See if the counter was actually stopped */
+	dev_dbg(dev, "checking for presence of RTC\n");
+	ret = pcf2123_read(dev, PCF2123_REG_CTRL1, rxbuf, sizeof(rxbuf));
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(dev, "received data from RTC (0x%02X 0x%02X)\n",
+			rxbuf[0], rxbuf[1]);
+	if (!(rxbuf[0] & CTRL1_STOP))
+		return -ENODEV;
+
+	/* Start the counter */
+	ret = pcf2123_write_reg(dev, PCF2123_REG_CTRL1, CTRL1_CLEAR);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static const struct rtc_class_ops pcf2123_rtc_ops = {
 	.read_time	= pcf2123_rtc_read_time,
 	.set_time	= pcf2123_rtc_set_time,
@@ -269,7 +303,6 @@ static int pcf2123_probe(struct spi_device *spi)
 {
 	struct rtc_device *rtc;
 	struct pcf2123_plat_data *pdata;
-	u8  rxbuf[2];
 	int ret, i;
 
 	pdata = devm_kzalloc(&spi->dev, sizeof(struct pcf2123_plat_data),
@@ -278,29 +311,9 @@ static int pcf2123_probe(struct spi_device *spi)
 		return -ENOMEM;
 	spi->dev.platform_data = pdata;
 
-	/* Send a software reset command */
-	dev_dbg(&spi->dev, "resetting RTC\n");
-	ret = pcf2123_write_reg(&spi->dev, PCF2123_REG_CTRL1, CTRL1_SW_RESET);
-	if (ret < 0)
-		goto kfree_exit;
-
-	/* Stop the counter */
-	dev_dbg(&spi->dev, "stopping RTC\n");
-	ret = pcf2123_write_reg(&spi->dev, PCF2123_REG_CTRL1, CTRL1_STOP);
-	if (ret < 0)
-		goto kfree_exit;
-
-	/* See if the counter was actually stopped */
-	dev_dbg(&spi->dev, "checking for presence of RTC\n");
-	ret = pcf2123_read(&spi->dev, PCF2123_REG_CTRL1, rxbuf, sizeof(rxbuf));
-	dev_dbg(&spi->dev, "received data from RTC (0x%02X 0x%02X)\n",
-			rxbuf[0], rxbuf[1]);
-	if (ret < 0)
-		goto kfree_exit;
-
-	if (!(rxbuf[0] & CTRL1_STOP)) {
+	ret = pcf2123_reset(&spi->dev);
+	if (ret < 0) {
 		dev_err(&spi->dev, "chip not found\n");
-		ret = -ENODEV;
 		goto kfree_exit;
 	}
 
@@ -308,11 +321,6 @@ static int pcf2123_probe(struct spi_device *spi)
 	dev_info(&spi->dev, "spiclk %u KHz.\n",
 			(spi->max_speed_hz + 500) / 1000);
 
-	/* Start the counter */
-	ret = pcf2123_write_reg(&spi->dev, PCF2123_REG_CTRL1, CTRL1_CLEAR);
-	if (ret < 0)
-		goto kfree_exit;
-
 	/* Finalize the initialization */
 	rtc = devm_rtc_device_register(&spi->dev, pcf2123_driver.driver.name,
 			&pcf2123_rtc_ops, THIS_MODULE);
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
