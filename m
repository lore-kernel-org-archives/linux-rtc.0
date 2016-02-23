Return-Path: <ynvich@gmail.com>
From: Sergei Ianovich <ynvich@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Sergei Ianovich <ynvich@gmail.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	rtc-linux@googlegroups.com (open list:REAL TIME CLOCK RTC SUBSYSTEM)
Subject: [PATCH v7] rtc: rewrite DS1302 using SPI
Date: Tue, 23 Feb 2016 13:54:57 +0300
Message-Id: <1456224900-4877-1-git-send-email-ynvich@gmail.com>
In-Reply-To: <1456105286-28598-1-git-send-email-ynvich@gmail.com>
References: <1456105286-28598-1-git-send-email-ynvich@gmail.com>
List-ID: <rtc-linux.googlegroups.com>

DS1302 is half-duplex SPI device. The driver respects this fact now.

Pin configurations should be implemented using SPI subsystem.

Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Rob Herring <robh@kernel.org>

   v6..v7
   * change binding and doc file names

   v5..v6
   * rewrite the driver as an SPI slave device
   * use "maxim" for vendor name per Kconfig
   * stop changing device RAM in device presence test
   * only return time from device if valid
   * use burst mode for reading/writing time
   * dropped charging control. I cannot test it, and it looks broken

   v4..v5
   * drop THIS_MODULE from struct platform driver
   * use "dallas" for vendor name per vendor-prefixes.txt

   v3..v4
   * move DTS bindings to a different patch

   v2..v3
   * use usleep_range instead of custom nsleep
   * number change (07/16 -> 09/21)

   v0..v2
   * use device tree
   * use devm helpers where possible
---
 .../devicetree/bindings/rtc/maxim-ds1302.txt       |  46 +++
 drivers/rtc/Kconfig                                |  15 +-
 drivers/rtc/rtc-ds1302.c                           | 348 ++++++++++-----------
 3 files changed, 212 insertions(+), 197 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/maxim-ds1302.txt

diff --git a/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt b/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
new file mode 100644
index 0000000..ba470c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
@@ -0,0 +1,46 @@
+* Maxim/Dallas Semiconductor DS-1302 RTC
+
+Simple device which could be used to store date/time between reboots.
+
+The device uses the standard MicroWire half-duplex transfer timing.
+Master output is set on low clock and sensed by the RTC on the rising
+edge. Master input is set by the RTC on the trailing edge and is sensed
+by the master on low clock.
+
+Required properties:
+
+- compatible : Should be "maxim,ds1302"
+
+Required SPI properties:
+
+- reg : Should be address of the device chip select within
+  the controller.
+
+- spi-max-frequency : DS-1302 has 500 kHz if powered at 2.2V,
+  and 2MHz if powered at 5V.
+
+- spi-3wire : The device has a shared signal IN/OUT line.
+
+- spi-lsb-first : DS-1302 requires least significant bit first
+  transfers.
+
+- spi-cs-high: DS-1302 has active high chip select line. This is
+  required unless inverted in hardware.
+
+Example:
+
+spi@901c {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "icpdas,lp8841-spi-rtc";
+	reg = <0x901c 0x1>;
+
+	rtc@0 {
+		compatible = "maxim,ds1302";
+		reg = <0>;
+		spi-max-frequency = <500000>;
+		spi-3wire;
+		spi-lsb-first;
+		spi-cs-high;
+	};
+};
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 376322f..e20e804 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -646,6 +646,15 @@ config RTC_DRV_M41T94
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-m41t94.
 
+config RTC_DRV_DS1302
+	tristate "Dallas/Maxim DS1302"
+	depends on SPI
+	help
+	  If you say yes here you get support for the Dallas DS1302 RTC chips.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-ds1302.
+
 config RTC_DRV_DS1305
 	tristate "Dallas/Maxim DS1305/DS1306"
 	help
@@ -811,12 +820,6 @@ config RTC_DRV_DS1286
 	help
 	  If you say yes here you get support for the Dallas DS1286 RTC chips.
 
-config RTC_DRV_DS1302
-	tristate "Dallas DS1302"
-	depends on SH_SECUREEDGE5410
-	help
-	  If you say yes here you get support for the Dallas DS1302 RTC chips.
-
 config RTC_DRV_DS1511
 	tristate "Dallas DS1511"
 	depends on HAS_IOMEM
diff --git a/drivers/rtc/rtc-ds1302.c b/drivers/rtc/rtc-ds1302.c
index 6bef7a5..5cdc0f2 100644
--- a/drivers/rtc/rtc-ds1302.c
+++ b/drivers/rtc/rtc-ds1302.c
@@ -9,16 +9,17 @@
  * this archive for more details.
  */
 
+#include <linux/bcd.h>
 #include <linux/init.h>
-#include <linux/module.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/of.h>
 #include <linux/rtc.h>
-#include <linux/io.h>
-#include <linux/bcd.h>
+#include <linux/spi/spi.h>
 
 #define DRV_NAME	"rtc-ds1302"
-#define DRV_VERSION	"0.1.1"
+#define DRV_VERSION	"1.0.0"
 
 #define	RTC_CMD_READ	0x81		/* Read command */
 #define	RTC_CMD_WRITE	0x80		/* Write command */
@@ -28,6 +29,8 @@
 
 #define RTC_ADDR_RAM0	0x20		/* Address of RAM0 */
 #define RTC_ADDR_TCR	0x08		/* Address of trickle charge register */
+#define RTC_CLCK_BURST	0x1F		/* Address of clock burst */
+#define	RTC_CLCK_LEN	0x08		/* Size of clock burst */
 #define	RTC_ADDR_CTRL	0x07		/* Address of control register */
 #define	RTC_ADDR_YEAR	0x06		/* Address of year register */
 #define	RTC_ADDR_DAY	0x05		/* Address of day of week register */
@@ -37,217 +40,180 @@
 #define	RTC_ADDR_MIN	0x01		/* Address of minute register */
 #define	RTC_ADDR_SEC	0x00		/* Address of second register */
 
-#ifdef CONFIG_SH_SECUREEDGE5410
-#include <asm/rtc.h>
-#include <mach/secureedge5410.h>
-
-#define	RTC_RESET	0x1000
-#define	RTC_IODATA	0x0800
-#define	RTC_SCLK	0x0400
-
-#define set_dp(x)	SECUREEDGE_WRITE_IOPORT(x, 0x1c00)
-#define get_dp()	SECUREEDGE_READ_IOPORT()
-#define ds1302_set_tx()
-#define ds1302_set_rx()
-
-static inline int ds1302_hw_init(void)
+static int ds1302_rtc_set_time(struct device *dev, struct rtc_time *time)
 {
-	return 0;
+	struct spi_device	*spi = dev_get_drvdata(dev);
+	u8		buf[1 + RTC_CLCK_LEN];
+	u8		*bp = buf;
+	int		status;
+
+	/* Enable writing */
+	bp = buf;
+	*bp++ = RTC_ADDR_CTRL << 1 | RTC_CMD_WRITE;
+	*bp++ = RTC_CMD_WRITE_ENABLE;
+
+	status = spi_write_then_read(spi, buf, 2,
+			NULL, 0);
+	if (!status)
+		return status;
+
+	/* Write registers starting at the first time/date address. */
+	bp = buf;
+	*bp++ = RTC_CLCK_BURST << 1 | RTC_CMD_WRITE;
+
+	*bp++ = bin2bcd(time->tm_sec);
+	*bp++ = bin2bcd(time->tm_min);
+	*bp++ = bin2bcd(time->tm_hour);
+	*bp++ = bin2bcd(time->tm_mday);
+	*bp++ = bin2bcd(time->tm_mon + 1);
+	*bp++ = time->tm_wday;
+	*bp++ = bin2bcd(time->tm_year % 100);
+	*bp++ = RTC_CMD_WRITE_DISABLE;
+
+	/* use write-then-read since dma from stack is nonportable */
+	return spi_write_then_read(spi, buf, sizeof(buf),
+			NULL, 0);
 }
 
-static inline void ds1302_reset(void)
+static int ds1302_rtc_get_time(struct device *dev, struct rtc_time *time)
 {
-	set_dp(get_dp() & ~(RTC_RESET | RTC_IODATA | RTC_SCLK));
+	struct spi_device	*spi = dev_get_drvdata(dev);
+	u8		addr = RTC_CLCK_BURST << 1 | RTC_CMD_READ;
+	u8		buf[RTC_CLCK_LEN - 1];
+	int		status;
+
+	/* Use write-then-read to get all the date/time registers
+	 * since dma from stack is nonportable
+	 */
+	status = spi_write_then_read(spi, &addr, sizeof(addr),
+			buf, sizeof(buf));
+	if (status < 0)
+		return status;
+
+	/* Decode the registers */
+	time->tm_sec = bcd2bin(buf[RTC_ADDR_SEC]);
+	time->tm_min = bcd2bin(buf[RTC_ADDR_MIN]);
+	time->tm_hour = bcd2bin(buf[RTC_ADDR_HOUR]);
+	time->tm_wday = buf[RTC_ADDR_DAY] - 1;
+	time->tm_mday = bcd2bin(buf[RTC_ADDR_DATE]);
+	time->tm_mon = bcd2bin(buf[RTC_ADDR_MON]) - 1;
+	time->tm_year = bcd2bin(buf[RTC_ADDR_YEAR]) + 100;
+
+	/* Time may not be set */
+	return rtc_valid_tm(time);
 }
 
-static inline void ds1302_clock(void)
-{
-	set_dp(get_dp() | RTC_SCLK);	/* clock high */
-	set_dp(get_dp() & ~RTC_SCLK);	/* clock low */
-}
-
-static inline void ds1302_start(void)
-{
-	set_dp(get_dp() | RTC_RESET);
-}
-
-static inline void ds1302_stop(void)
-{
-	set_dp(get_dp() & ~RTC_RESET);
-}
-
-static inline void ds1302_txbit(int bit)
-{
-	set_dp((get_dp() & ~RTC_IODATA) | (bit ? RTC_IODATA : 0));
-}
-
-static inline int ds1302_rxbit(void)
-{
-	return !!(get_dp() & RTC_IODATA);
-}
-
-#else
-#error "Add support for your platform"
-#endif
+static struct rtc_class_ops ds1302_rtc_ops = {
+	.read_time	= ds1302_rtc_get_time,
+	.set_time	= ds1302_rtc_set_time,
+};
 
-static void ds1302_sendbits(unsigned int val)
+static int ds1302_probe(struct spi_device *spi)
 {
-	int i;
-
-	ds1302_set_tx();
-
-	for (i = 8; (i); i--, val >>= 1) {
-		ds1302_txbit(val & 0x1);
-		ds1302_clock();
+	struct rtc_device	*rtc;
+	u8		addr;
+	u8		buf[4];
+	u8		*bp = buf;
+	int		status;
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
 	}
-}
-
-static unsigned int ds1302_recvbits(void)
-{
-	unsigned int val;
-	int i;
-
-	ds1302_set_rx();
 
-	for (i = 0, val = 0; (i < 8); i++) {
-		val |= (ds1302_rxbit() << i);
-		ds1302_clock();
+	addr = RTC_ADDR_CTRL << 1 | RTC_CMD_READ;
+	status = spi_write_then_read(spi, &addr, sizeof(addr), buf, 1);
+	if (status < 0) {
+		dev_err(&spi->dev, "control register read error %d\n",
+				status);
+		return status;
 	}
 
-	return val;
-}
-
-static unsigned int ds1302_readbyte(unsigned int addr)
-{
-	unsigned int val;
-
-	ds1302_reset();
-
-	ds1302_start();
-	ds1302_sendbits(((addr & 0x3f) << 1) | RTC_CMD_READ);
-	val = ds1302_recvbits();
-	ds1302_stop();
-
-	return val;
-}
-
-static void ds1302_writebyte(unsigned int addr, unsigned int val)
-{
-	ds1302_reset();
-
-	ds1302_start();
-	ds1302_sendbits(((addr & 0x3f) << 1) | RTC_CMD_WRITE);
-	ds1302_sendbits(val);
-	ds1302_stop();
-}
-
-static int ds1302_rtc_read_time(struct device *dev, struct rtc_time *tm)
-{
-	tm->tm_sec	= bcd2bin(ds1302_readbyte(RTC_ADDR_SEC));
-	tm->tm_min	= bcd2bin(ds1302_readbyte(RTC_ADDR_MIN));
-	tm->tm_hour	= bcd2bin(ds1302_readbyte(RTC_ADDR_HOUR));
-	tm->tm_wday	= bcd2bin(ds1302_readbyte(RTC_ADDR_DAY));
-	tm->tm_mday	= bcd2bin(ds1302_readbyte(RTC_ADDR_DATE));
-	tm->tm_mon	= bcd2bin(ds1302_readbyte(RTC_ADDR_MON)) - 1;
-	tm->tm_year	= bcd2bin(ds1302_readbyte(RTC_ADDR_YEAR));
-
-	if (tm->tm_year < 70)
-		tm->tm_year += 100;
-
-	dev_dbg(dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
-		"mday=%d, mon=%d, year=%d, wday=%d\n",
-		__func__,
-		tm->tm_sec, tm->tm_min, tm->tm_hour,
-		tm->tm_mday, tm->tm_mon + 1, tm->tm_year, tm->tm_wday);
-
-	return rtc_valid_tm(tm);
-}
-
-static int ds1302_rtc_set_time(struct device *dev, struct rtc_time *tm)
-{
-	ds1302_writebyte(RTC_ADDR_CTRL, RTC_CMD_WRITE_ENABLE);
-	/* Stop RTC */
-	ds1302_writebyte(RTC_ADDR_SEC, ds1302_readbyte(RTC_ADDR_SEC) | 0x80);
-
-	ds1302_writebyte(RTC_ADDR_SEC, bin2bcd(tm->tm_sec));
-	ds1302_writebyte(RTC_ADDR_MIN, bin2bcd(tm->tm_min));
-	ds1302_writebyte(RTC_ADDR_HOUR, bin2bcd(tm->tm_hour));
-	ds1302_writebyte(RTC_ADDR_DAY, bin2bcd(tm->tm_wday));
-	ds1302_writebyte(RTC_ADDR_DATE, bin2bcd(tm->tm_mday));
-	ds1302_writebyte(RTC_ADDR_MON, bin2bcd(tm->tm_mon + 1));
-	ds1302_writebyte(RTC_ADDR_YEAR, bin2bcd(tm->tm_year % 100));
+	if ((buf[0] & ~RTC_CMD_WRITE_DISABLE) != 0) {
+		status = spi_write_then_read(spi, &addr, sizeof(addr), buf, 1);
+		if (status < 0) {
+			dev_err(&spi->dev, "control register read error %d\n",
+					status);
+			return status;
+		}
+
+		if ((buf[0] & ~RTC_CMD_WRITE_DISABLE) != 0) {
+			dev_err(&spi->dev, "junk in control register\n");
+			return -ENODEV;
+		}
+	}
+	if (buf[0] == 0) {
+		bp = buf;
+		*bp++ = RTC_ADDR_CTRL << 1 | RTC_CMD_WRITE;
+		*bp++ = RTC_CMD_WRITE_DISABLE;
+
+		status = spi_write_then_read(spi, buf, 2, NULL, 0);
+		if (status < 0) {
+			dev_err(&spi->dev, "control register write error %d\n",
+					status);
+			return status;
+		}
+
+		addr = RTC_ADDR_CTRL << 1 | RTC_CMD_READ;
+		status = spi_write_then_read(spi, &addr, sizeof(addr), buf, 1);
+		if (status < 0) {
+			dev_err(&spi->dev,
+					"error %d reading control register\n",
+					status);
+			return status;
+		}
+
+		if (buf[0] != RTC_CMD_WRITE_DISABLE) {
+			dev_err(&spi->dev, "failed to detect chip\n");
+			return -ENODEV;
+		}
+	}
 
-	/* Start RTC */
-	ds1302_writebyte(RTC_ADDR_SEC, ds1302_readbyte(RTC_ADDR_SEC) & ~0x80);
+	spi_set_drvdata(spi, spi);
 
-	ds1302_writebyte(RTC_ADDR_CTRL, RTC_CMD_WRITE_DISABLE);
+	rtc = devm_rtc_device_register(&spi->dev, "ds1302",
+			&ds1302_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc)) {
+		status = PTR_ERR(rtc);
+		dev_err(&spi->dev, "error %d registering rtc\n", status);
+		return status;
+	}
 
 	return 0;
 }
 
-static int ds1302_rtc_ioctl(struct device *dev, unsigned int cmd,
-			    unsigned long arg)
+static int ds1302_remove(struct spi_device *spi)
 {
-	switch (cmd) {
-#ifdef RTC_SET_CHARGE
-	case RTC_SET_CHARGE:
-	{
-		int tcs_val;
-
-		if (copy_from_user(&tcs_val, (int __user *)arg, sizeof(int)))
-			return -EFAULT;
-
-		ds1302_writebyte(RTC_ADDR_TCR, (0xa0 | tcs_val * 0xf));
-		return 0;
-	}
-#endif
-	}
-
-	return -ENOIOCTLCMD;
+	spi_set_drvdata(spi, NULL);
+	return 0;
 }
 
-static struct rtc_class_ops ds1302_rtc_ops = {
-	.read_time	= ds1302_rtc_read_time,
-	.set_time	= ds1302_rtc_set_time,
-	.ioctl		= ds1302_rtc_ioctl,
+#ifdef CONFIG_OF
+static const struct of_device_id ds1302_dt_ids[] = {
+	{ .compatible = "maxim,ds1302", },
+	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, ds1302_dt_ids);
+#endif
 
-static int __init ds1302_rtc_probe(struct platform_device *pdev)
-{
-	struct rtc_device *rtc;
-
-	if (ds1302_hw_init()) {
-		dev_err(&pdev->dev, "Failed to init communication channel");
-		return -EINVAL;
-	}
-
-	/* Reset */
-	ds1302_reset();
-
-	/* Write a magic value to the DS1302 RAM, and see if it sticks. */
-	ds1302_writebyte(RTC_ADDR_RAM0, 0x42);
-	if (ds1302_readbyte(RTC_ADDR_RAM0) != 0x42) {
-		dev_err(&pdev->dev, "Failed to probe");
-		return -ENODEV;
-	}
-
-	rtc = devm_rtc_device_register(&pdev->dev, "ds1302",
-					   &ds1302_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
-
-	platform_set_drvdata(pdev, rtc);
-
-	return 0;
-}
-
-static struct platform_driver ds1302_platform_driver = {
-	.driver		= {
-		.name	= DRV_NAME,
-	},
+static struct spi_driver ds1302_driver = {
+	.driver.name	= "rtc-ds1302",
+	.driver.of_match_table = of_match_ptr(ds1302_dt_ids),
+	.probe		= ds1302_probe,
+	.remove		= ds1302_remove,
 };
 
-module_platform_driver_probe(ds1302_platform_driver, ds1302_rtc_probe);
+module_spi_driver(ds1302_driver);
 
 MODULE_DESCRIPTION("Dallas DS1302 RTC driver");
 MODULE_VERSION(DRV_VERSION);
-- 
2.7.0
