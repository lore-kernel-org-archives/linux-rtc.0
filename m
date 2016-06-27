Return-Path: <rtc-linux+bncBCPM5SUWUYIRBUMXYS5QKGQEJDX3JOY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com. [2607:f8b0:400e:c00::241])
        by gmr-mx.google.com with ESMTPS id 62si2342137pfx.1.2016.06.27.04.19.45
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2016 04:19:45 -0700 (PDT)
Received: by mail-pf0-x241.google.com with SMTP id i123so15562516pfg.3
        for <rtc-linux@googlegroups.com>; Mon, 27 Jun 2016 04:19:45 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Sergey Yanovich <ynvich@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH v2 1/2] rtc: ds1302: add register access
 abstraction layer
Date: Mon, 27 Jun 2016 20:19:21 +0900
Message-Id: <1467026362-29446-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1467026362-29446-1-git-send-email-akinobu.mita@gmail.com>
References: <1467026362-29446-1-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The rtc-ds1302 driver now implemented using SPI 3wire mode.
But I would like to access it with using three wires connected to GPIO
lines.

This adds abstraction layer for DS1302 register access in order to
prepare to support for using GPIO lines.  This enables to share common
code between SPI driver and GPIO driver.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Sergey Yanovich <ynvich@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-ds1302.c | 199 +++++++++++++++++++++++++++++++----------------
 1 file changed, 130 insertions(+), 69 deletions(-)

diff --git a/drivers/rtc/rtc-ds1302.c b/drivers/rtc/rtc-ds1302.c
index f5dd09f..635288d 100644
--- a/drivers/rtc/rtc-ds1302.c
+++ b/drivers/rtc/rtc-ds1302.c
@@ -7,6 +7,8 @@
  * This file is subject to the terms and conditions of the GNU General Public
  * License version 2. See the file "COPYING" in the main directory of
  * this archive for more details.
+ *
+ * Datasheet: https://datasheets.maximintegrated.com/en/ds/DS1302.pdf
  */
 
 #include <linux/bcd.h>
@@ -39,27 +41,61 @@
 #define	RTC_ADDR_MIN	0x01		/* Address of minute register */
 #define	RTC_ADDR_SEC	0x00		/* Address of second register */
 
+struct ds1302 {
+	const struct ds1302_ops *ops;
+	struct device *dev;
+};
+
+struct ds1302_ops {
+	int (*read)(struct ds1302 *, u8, u8 *, int);
+	int (*write)(struct ds1302 *, u8, const u8 *, int);
+};
+
+static int ds1302_readbyte(struct ds1302 *ds1302, u8 addr)
+{
+	u8 val;
+	int err;
+
+	err = ds1302->ops->read(ds1302, addr, &val, 1);
+
+	return err ? err : val;
+}
+
+static int ds1302_writebyte(struct ds1302 *ds1302, u8 addr, u8 val)
+{
+	return ds1302->ops->write(ds1302, addr, &val, 1);
+}
+
+static int ds1302_readburst(struct ds1302 *ds1302, u8 addr, u8 *buf, int size)
+{
+	if (addr != RTC_CLCK_BURST)
+		return -EINVAL;
+
+	return ds1302->ops->read(ds1302, addr, buf, size);
+}
+
+static int ds1302_writeburst(struct ds1302 *ds1302, u8 addr, const u8 *buf,
+			     int size)
+{
+	if (addr != RTC_CLCK_BURST)
+		return -EINVAL;
+
+	return ds1302->ops->write(ds1302, addr, buf, size);
+}
+
 static int ds1302_rtc_set_time(struct device *dev, struct rtc_time *time)
 {
-	struct spi_device	*spi = dev_get_drvdata(dev);
-	u8		buf[1 + RTC_CLCK_LEN];
+	struct ds1302	*ds1302 = dev_get_drvdata(dev);
+	u8		buf[RTC_CLCK_LEN];
 	u8		*bp = buf;
 	int		status;
 
 	/* Enable writing */
-	bp = buf;
-	*bp++ = RTC_ADDR_CTRL << 1 | RTC_CMD_WRITE;
-	*bp++ = RTC_CMD_WRITE_ENABLE;
-
-	status = spi_write_then_read(spi, buf, 2,
-			NULL, 0);
+	status = ds1302_writebyte(ds1302, RTC_ADDR_CTRL, RTC_CMD_WRITE_ENABLE);
 	if (status)
 		return status;
 
 	/* Write registers starting at the first time/date address. */
-	bp = buf;
-	*bp++ = RTC_CLCK_BURST << 1 | RTC_CMD_WRITE;
-
 	*bp++ = bin2bcd(time->tm_sec);
 	*bp++ = bin2bcd(time->tm_min);
 	*bp++ = bin2bcd(time->tm_hour);
@@ -69,23 +105,16 @@ static int ds1302_rtc_set_time(struct device *dev, struct rtc_time *time)
 	*bp++ = bin2bcd(time->tm_year % 100);
 	*bp++ = RTC_CMD_WRITE_DISABLE;
 
-	/* use write-then-read since dma from stack is nonportable */
-	return spi_write_then_read(spi, buf, sizeof(buf),
-			NULL, 0);
+	return ds1302_writeburst(ds1302, RTC_CLCK_BURST, buf, sizeof(buf));
 }
 
 static int ds1302_rtc_get_time(struct device *dev, struct rtc_time *time)
 {
-	struct spi_device	*spi = dev_get_drvdata(dev);
-	u8		addr = RTC_CLCK_BURST << 1 | RTC_CMD_READ;
+	struct ds1302	*ds1302 = dev_get_drvdata(dev);
 	u8		buf[RTC_CLCK_LEN - 1];
 	int		status;
 
-	/* Use write-then-read to get all the date/time registers
-	 * since dma from stack is nonportable
-	 */
-	status = spi_write_then_read(spi, &addr, sizeof(addr),
-			buf, sizeof(buf));
+	status = ds1302_readburst(ds1302, RTC_CLCK_BURST, buf, sizeof(buf));
 	if (status < 0)
 		return status;
 
@@ -107,94 +136,127 @@ static struct rtc_class_ops ds1302_rtc_ops = {
 	.set_time	= ds1302_rtc_set_time,
 };
 
-static int ds1302_probe(struct spi_device *spi)
+static int ds1302_probe(struct ds1302 *ds1302)
 {
 	struct rtc_device	*rtc;
-	u8		addr;
-	u8		buf[4];
-	u8		*bp = buf;
 	int		status;
 
-	/* Sanity check board setup data.  This may be hooked up
-	 * in 3wire mode, but we don't care.  Note that unless
-	 * there's an inverter in place, this needs SPI_CS_HIGH!
-	 */
-	if (spi->bits_per_word && (spi->bits_per_word != 8)) {
-		dev_err(&spi->dev, "bad word length\n");
-		return -EINVAL;
-	} else if (spi->max_speed_hz > 2000000) {
-		dev_err(&spi->dev, "speed is too high\n");
-		return -EINVAL;
-	} else if (spi->mode & SPI_CPHA) {
-		dev_err(&spi->dev, "bad mode\n");
-		return -EINVAL;
-	}
+	dev_set_drvdata(ds1302->dev, ds1302);
 
-	addr = RTC_ADDR_CTRL << 1 | RTC_CMD_READ;
-	status = spi_write_then_read(spi, &addr, sizeof(addr), buf, 1);
+	status = ds1302_readbyte(ds1302, RTC_ADDR_CTRL);
 	if (status < 0) {
-		dev_err(&spi->dev, "control register read error %d\n",
+		dev_err(ds1302->dev, "control register read error %d\n",
 				status);
 		return status;
 	}
 
-	if ((buf[0] & ~RTC_CMD_WRITE_DISABLE) != 0) {
-		status = spi_write_then_read(spi, &addr, sizeof(addr), buf, 1);
+	if (status & ~RTC_CMD_WRITE_DISABLE) {
+		status = ds1302_readbyte(ds1302, RTC_ADDR_CTRL);
 		if (status < 0) {
-			dev_err(&spi->dev, "control register read error %d\n",
+			dev_err(ds1302->dev, "control register read error %d\n",
 					status);
 			return status;
 		}
 
-		if ((buf[0] & ~RTC_CMD_WRITE_DISABLE) != 0) {
-			dev_err(&spi->dev, "junk in control register\n");
+		if (status & ~RTC_CMD_WRITE_DISABLE) {
+			dev_err(ds1302->dev, "junk in control register\n");
 			return -ENODEV;
 		}
 	}
-	if (buf[0] == 0) {
-		bp = buf;
-		*bp++ = RTC_ADDR_CTRL << 1 | RTC_CMD_WRITE;
-		*bp++ = RTC_CMD_WRITE_DISABLE;
-
-		status = spi_write_then_read(spi, buf, 2, NULL, 0);
+	if (status == 0) {
+		status = ds1302_writebyte(ds1302, RTC_ADDR_CTRL,
+					  RTC_CMD_WRITE_DISABLE);
 		if (status < 0) {
-			dev_err(&spi->dev, "control register write error %d\n",
-					status);
+			dev_err(ds1302->dev,
+				"control register write error %d\n", status);
 			return status;
 		}
 
-		addr = RTC_ADDR_CTRL << 1 | RTC_CMD_READ;
-		status = spi_write_then_read(spi, &addr, sizeof(addr), buf, 1);
+		status = ds1302_readbyte(ds1302, RTC_ADDR_CTRL);
 		if (status < 0) {
-			dev_err(&spi->dev,
+			dev_err(ds1302->dev,
 					"error %d reading control register\n",
 					status);
 			return status;
 		}
 
-		if (buf[0] != RTC_CMD_WRITE_DISABLE) {
-			dev_err(&spi->dev, "failed to detect chip\n");
+		if (status != RTC_CMD_WRITE_DISABLE) {
+			dev_err(ds1302->dev, "failed to detect chip\n");
 			return -ENODEV;
 		}
 	}
 
-	spi_set_drvdata(spi, spi);
-
-	rtc = devm_rtc_device_register(&spi->dev, "ds1302",
+	rtc = devm_rtc_device_register(ds1302->dev, "ds1302",
 			&ds1302_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc)) {
 		status = PTR_ERR(rtc);
-		dev_err(&spi->dev, "error %d registering rtc\n", status);
+		dev_err(ds1302->dev, "error %d registering rtc\n", status);
 		return status;
 	}
 
 	return 0;
 }
 
-static int ds1302_remove(struct spi_device *spi)
+static int ds1302_spi_read(struct ds1302 *ds1302, u8 addr, u8 *buf, int size)
 {
-	spi_set_drvdata(spi, NULL);
-	return 0;
+	struct spi_device *spi = to_spi_device(ds1302->dev);
+
+	addr = addr << 1 | RTC_CMD_READ;
+
+	/* Use write-then-read to get all the date/time registers
+	 * since dma from stack is nonportable
+	 */
+	return spi_write_then_read(spi, &addr, sizeof(addr), buf, size);
+}
+
+static int ds1302_spi_write(struct ds1302 *ds1302, u8 addr, const u8 *buf,
+			    int size)
+{
+	struct spi_device *spi = to_spi_device(ds1302->dev);
+	u8 write_buf[RTC_CLCK_LEN + 1];
+
+	if (size + 1 > sizeof(write_buf))
+		return -EINVAL;
+
+	write_buf[0] = addr << 1 | RTC_CMD_WRITE;
+	memcpy(write_buf + 1, buf, size);
+
+	/* use write-then-read since dma from stack is nonportable */
+	return spi_write_then_read(spi, write_buf, size + 1, NULL, 0);
+}
+
+static const struct ds1302_ops ds1302_spi_ops = {
+	.read = ds1302_spi_read,
+	.write = ds1302_spi_write,
+};
+
+static int ds1302_spi_probe(struct spi_device *spi)
+{
+	struct ds1302		*ds1302;
+
+	/* Sanity check board setup data.  This may be hooked up
+	 * in 3wire mode, but we don't care.  Note that unless
+	 * there's an inverter in place, this needs SPI_CS_HIGH!
+	 */
+	if (spi->bits_per_word && (spi->bits_per_word != 8)) {
+		dev_err(&spi->dev, "bad word length\n");
+		return -EINVAL;
+	} else if (spi->max_speed_hz > 2000000) {
+		dev_err(&spi->dev, "speed is too high\n");
+		return -EINVAL;
+	} else if (spi->mode & SPI_CPHA) {
+		dev_err(&spi->dev, "bad mode\n");
+		return -EINVAL;
+	}
+
+	ds1302 = devm_kzalloc(&spi->dev, sizeof(*ds1302), GFP_KERNEL);
+	if (!ds1302)
+		return -ENOMEM;
+
+	ds1302->ops = &ds1302_spi_ops;
+	ds1302->dev = &spi->dev;
+
+	return ds1302_probe(ds1302);
 }
 
 #ifdef CONFIG_OF
@@ -208,8 +270,7 @@ MODULE_DEVICE_TABLE(of, ds1302_dt_ids);
 static struct spi_driver ds1302_driver = {
 	.driver.name	= "rtc-ds1302",
 	.driver.of_match_table = of_match_ptr(ds1302_dt_ids),
-	.probe		= ds1302_probe,
-	.remove		= ds1302_remove,
+	.probe		= ds1302_spi_probe,
 };
 
 module_spi_driver(ds1302_driver);
-- 
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
