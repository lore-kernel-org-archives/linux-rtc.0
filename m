Return-Path: <rtc-linux+bncBCNNJWF7RUMRBDHVVK2AKGQEYYDKVLQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com. [2607:f8b0:400e:c00::241])
        by gmr-mx.google.com with ESMTPS id p88si8636056pfi.0.2016.01.04.10.31.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2016 10:31:40 -0800 (PST)
Received: by mail-pf0-x241.google.com with SMTP id 78so20481790pfw.0
        for <rtc-linux@googlegroups.com>; Mon, 04 Jan 2016 10:31:40 -0800 (PST)
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Joshua Clayton <stillcompiling@gmail.com>
Subject: [rtc-linux] [PATCH v2 4/8] rtc-pcf2123: refactor chip reset into a function
Date: Mon,  4 Jan 2016 10:31:22 -0800
Message-Id: <d9c66693bdd714ea29aa432d9be3271b863d50f2.1451929910.git.stillcompiling@gmail.com>
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

Refactor chip reset items into its own function, isolating it from
the rest of the device probe.
Subsequent commits will avoid calling this code.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/rtc/rtc-pcf2123.c | 64 ++++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index 0f2ce45..2d886d4 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -272,6 +272,40 @@ static int pcf2123_rtc_set_time(struct device *dev, struct rtc_time *tm)
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
+		rxbuf[0], rxbuf[1]);
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
@@ -281,7 +315,6 @@ static int pcf2123_probe(struct spi_device *spi)
 {
 	struct rtc_device *rtc;
 	struct pcf2123_plat_data *pdata;
-	u8  rxbuf[2];
 	int ret, i;
 
 	pdata = devm_kzalloc(&spi->dev, sizeof(struct pcf2123_plat_data),
@@ -290,29 +323,9 @@ static int pcf2123_probe(struct spi_device *spi)
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
-	if (!(rxbuf[0] & 0x20)) {
+	ret = pcf2123_reset(&spi->dev);
+	if (ret < 0) {
 		dev_err(&spi->dev, "chip not found\n");
-		ret = -ENODEV;
 		goto kfree_exit;
 	}
 
@@ -320,11 +333,6 @@ static int pcf2123_probe(struct spi_device *spi)
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
