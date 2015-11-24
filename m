Return-Path: <rtc-linux+bncBAABBVH42CZAKGQEJI5FQCY@googlegroups.com>
MIME-Version: 1.0
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id g21si719109wmd.3.2015.11.24.02.39.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Nov 2015 02:39:16 -0800 (PST)
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	devicetree@vger.kernel.org,
	rtc-linux@googlegroups.com,
	kernel@pengutronix.de,
	Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [rtc-linux] [PATCH 2/2] rtc: add driver for RX6110SA real time clock
Date: Tue, 24 Nov 2015 11:38:53 +0100
Message-Id: <1448361533-10728-2-git-send-email-s.trumtrar@pengutronix.de>
In-Reply-To: <1448361533-10728-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1448361533-10728-1-git-send-email-s.trumtrar@pengutronix.de>
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

The RX6110 comes in two different variants: SPI and I2C.
This driver only supports the SPI variant.

If the need ever arises to also support the I2C variant, this driver
could easily be refactured to support both cases.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
The original driver from Epson also has support for alarms.
My hardware setup is "uncommon" however and I can not test this.
That is why I decided to leave the code out of the driver for now
and only added the code that I could test with my setup.

Rebased onto rtc-for-4.5

 drivers/rtc/Kconfig      |   9 +
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-rx6110.c | 423 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 433 insertions(+)
 create mode 100644 drivers/rtc/rtc-rx6110.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 57c2dbc4f438..832d436944fe 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -725,6 +725,15 @@ config RTC_DRV_RX4581
 	  This driver can also be built as a module. If so the module
 	  will be called rtc-rx4581.
 
+config RTC_DRV_RX6110
+	tristate "Epson RX-6110"
+	select REGMAP_SPI
+	help
+	  If you say yes here you will get support for the Epson RX-6610.
+
+	  This driver can also be built as a module. If so the module
+	  will be called rtc-rx6110.
+
 config RTC_DRV_MCP795
 	tristate "Microchip MCP795"
 	help
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index e491eb524434..a36fef669d2a 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -127,6 +127,7 @@ obj-$(CONFIG_RTC_DRV_RS5C348)	+= rtc-rs5c348.o
 obj-$(CONFIG_RTC_DRV_RS5C372)	+= rtc-rs5c372.o
 obj-$(CONFIG_RTC_DRV_RV3029C2)	+= rtc-rv3029c2.o
 obj-$(CONFIG_RTC_DRV_RX4581)	+= rtc-rx4581.o
+obj-$(CONFIG_RTC_DRV_RX6110)	+= rtc-rx6110.o
 obj-$(CONFIG_RTC_DRV_RX8025)	+= rtc-rx8025.o
 obj-$(CONFIG_RTC_DRV_RX8581)	+= rtc-rx8581.o
 obj-$(CONFIG_RTC_DRV_S35390A)	+= rtc-s35390a.o
diff --git a/drivers/rtc/rtc-rx6110.c b/drivers/rtc/rtc-rx6110.c
new file mode 100644
index 000000000000..01417b019563
--- /dev/null
+++ b/drivers/rtc/rtc-rx6110.c
@@ -0,0 +1,423 @@
+/*
+ * Driver for the Epson RTC module RX-6110 SA
+ *
+ * Copyright(C) 2015 Pengutronix, Steffen Trumtrar <kernel@pengutronix.de>
+ * Copyright(C) SEIKO EPSON CORPORATION 2013. All rights reserved.
+ *
+ * Derived from RX-8025 driver:
+ * Copyright (C) 2009 Wolfgang Grandegger <wg@grandegger.com>
+ *
+ * Copyright (C) 2005 by Digi International Inc.
+ * All rights reserved.
+ *
+ * Modified by fengjh at rising.com.cn
+ * <http://lists.lm-sensors.org/mailman/listinfo/lm-sensors>
+ * 2006.11
+ *
+ * Code cleanup by Sergei Poselenov, <sposelenov@emcraft.com>
+ * Converted to new style by Wolfgang Grandegger <wg@grandegger.com>
+ * Alarm and periodic interrupt added by Dmitry Rakhchev <rda@emcraft.com>
+ *
+ *
+ * This driver software is distributed as is, without any warranty of any kind,
+ * either express or implied as further specified in the GNU Public License.
+ * This software may be used and distributed according to the terms of the GNU
+ * Public License, version 2 as published by the Free Software Foundation.
+ * See the file COPYING in the main directory of this archive for more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/bcd.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/regmap.h>
+#include <linux/rtc.h>
+#include <linux/spi/spi.h>
+
+/* RX-6110 Register definitions */
+#define RX6110_REG_SEC		0x10
+#define RX6110_REG_MIN		0x11
+#define RX6110_REG_HOUR		0x12
+#define RX6110_REG_WDAY		0x13
+#define RX6110_REG_MDAY		0x14
+#define RX6110_REG_MONTH	0x15
+#define RX6110_REG_YEAR		0x16
+#define RX6110_REG_RES1		0x17
+#define RX6110_REG_ALMIN	0x18
+#define RX6110_REG_ALHOUR	0x19
+#define RX6110_REG_ALWDAY	0x1A
+#define RX6110_REG_TCOUNT0	0x1B
+#define RX6110_REG_TCOUNT1	0x1C
+#define RX6110_REG_EXT		0x1D
+#define RX6110_REG_FLAG		0x1E
+#define RX6110_REG_CTRL		0x1F
+#define RX6110_REG_USER0	0x20
+#define RX6110_REG_USER1	0x21
+#define RX6110_REG_USER2	0x22
+#define RX6110_REG_USER3	0x23
+#define RX6110_REG_USER4	0x24
+#define RX6110_REG_USER5	0x25
+#define RX6110_REG_USER6	0x26
+#define RX6110_REG_USER7	0x27
+#define RX6110_REG_USER8	0x28
+#define RX6110_REG_USER9	0x29
+#define RX6110_REG_USERA	0x2A
+#define RX6110_REG_USERB	0x2B
+#define RX6110_REG_USERC	0x2C
+#define RX6110_REG_USERD	0x2D
+#define RX6110_REG_USERE	0x2E
+#define RX6110_REG_USERF	0x2F
+#define RX6110_REG_RES2		0x30
+#define RX6110_REG_RES3		0x31
+#define RX6110_REG_IRQ		0x32
+
+/* Extension Register (1Dh) bit positions */
+#define RX6110_BIT_EXT_TSEL		(7 << 0)
+#define RX6110_BIT_EXT_WADA		(1 << 3)
+#define RX6110_BIT_EXT_TE		(1 << 4)
+#define RX6110_BIT_EXT_USEL		(1 << 5)
+#define RX6110_BIT_EXT_FSEL		(3 << 6)
+
+/* Flag Register (1Eh) bit positions */
+#define RX6110_BIT_FLAG_VLF		(1 << 1)
+#define RX6110_BIT_FLAG_AF		(1 << 3)
+#define RX6110_BIT_FLAG_TF		(1 << 4)
+#define RX6110_BIT_FLAG_UF		(1 << 5)
+
+/* Control Register (1Fh) bit positions */
+#define RX6110_BIT_CTRL_TSTP		(1 << 2)
+#define RX6110_BIT_CTRL_AIE		(1 << 3)
+#define RX6110_BIT_CTRL_TIE		(1 << 4)
+#define RX6110_BIT_CTRL_UIE		(1 << 5)
+#define RX6110_BIT_CTRL_STOP		(1 << 6)
+#define RX6110_BIT_CTRL_TEST		(1 << 7)
+
+static struct spi_driver rx6110_driver;
+
+struct rx6110_data {
+	struct rtc_device *rtc;
+	struct regmap *regmap;
+	int ctrlreg;
+};
+
+/**
+ * rx6110_get_week_day - translate reg_week_day to tm_wday
+ * @reg_week_day: weekday register value
+ *
+ * Return: an integer representing the tm_wday
+ */
+static int rx6110_get_week_day(u8 reg_week_day)
+{
+	int tm_wday = -1;
+	int i;
+
+	for (i = 0; i < 7; i++) {
+		if (reg_week_day & 1) {
+			tm_wday = i;
+			break;
+		}
+		reg_week_day >>= 1;
+	}
+
+	return tm_wday;
+}
+
+/**
+ * rx6110_get_time - get the current time from the rx6110 registers
+ * @dev: the rtc device in use
+ * @tm: holds date and time
+ */
+static int rx6110_get_time(struct device *dev, struct rtc_time *tm)
+{
+	struct rx6110_data *rx6110 = dev_get_drvdata(dev);
+	unsigned char date[7];
+	int ret;
+
+	/* read registers to date */
+	ret = regmap_bulk_read(rx6110->regmap, RX6110_REG_SEC, date, 7);
+	if (ret)
+		return ret;
+
+	/*
+	 * Note: need to subtract 0x10 for index as register offset starts
+	 * at 0x10
+	 */
+	tm->tm_sec = bcd2bin(date[0] & 0x7f);
+	tm->tm_min = bcd2bin(date[1] & 0x7f);
+	/* only 24-hour clock */
+	tm->tm_hour = bcd2bin(date[2] & 0x3f);
+	tm->tm_wday = rx6110_get_week_day(date[3] & 0x7f);
+	tm->tm_mday = bcd2bin(date[4] & 0x3f);
+	tm->tm_mon = bcd2bin(date[5] & 0x1f) - 1;
+	tm->tm_year = bcd2bin(date[6]);
+
+	if (tm->tm_year < 70)
+		tm->tm_year += 100;
+
+	dev_dbg(dev, "%s: date %ds %dm %dh %dmd %dm %dy\n", __func__,
+		tm->tm_sec, tm->tm_min, tm->tm_hour,
+		tm->tm_mday, tm->tm_mon, tm->tm_year);
+
+	return rtc_valid_tm(tm);
+}
+
+/**
+ * rx6110_set_time - set the current time in the rx6110 registers
+ *
+ * @dev: the rtc device in use
+ * @tm: holds date and time
+ *
+ * BUG: The HW assumes every year that is a multiple of 4 to be a leap
+ * year. Next time this is wrong is 2100, which will not be a leap year
+ *
+ * Note: If STOP is not set/cleared, the clock will start when the seconds
+ *       register is written
+ *
+ */
+static int rx6110_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct rx6110_data *rx6110 = dev_get_drvdata(dev);
+	int ret;
+
+	/* set STOP bit before changing clock/calendar */
+	ret = regmap_update_bits(rx6110->regmap, RX6110_REG_CTRL,
+				 RX6110_BIT_CTRL_STOP, RX6110_BIT_CTRL_STOP);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(rx6110->regmap, RX6110_REG_SEC,
+			   bin2bcd(tm->tm_sec));
+	if (ret)
+		return ret;
+	ret = regmap_write(rx6110->regmap, RX6110_REG_MIN,
+			   bin2bcd(tm->tm_min));
+	if (ret)
+		return ret;
+	ret = regmap_write(rx6110->regmap, RX6110_REG_HOUR,
+			   bin2bcd(tm->tm_hour));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(rx6110->regmap, RX6110_REG_MDAY,
+			   bin2bcd(tm->tm_mday));
+	if (ret)
+		return ret;
+	ret = regmap_write(rx6110->regmap, RX6110_REG_MONTH,
+			   bin2bcd(tm->tm_mon + 1));
+	if (ret)
+		return ret;
+	ret = regmap_write(rx6110->regmap, RX6110_REG_YEAR,
+			   bin2bcd(tm->tm_year % 100));
+	if (ret)
+		return ret;
+	ret = regmap_write(rx6110->regmap, RX6110_REG_WDAY,
+			   1 << bin2bcd(tm->tm_wday));
+	if (ret)
+		return ret;
+
+	/* clear STOP bit after changing clock/calendar */
+	ret = regmap_update_bits(rx6110->regmap, RX6110_REG_CTRL,
+				 RX6110_BIT_CTRL_STOP, 0);
+
+	return ret;
+}
+
+/**
+ * rx6110_init - initialize the rx6110 registers
+ *
+ * @rx6110: pointer to the rx6110 struct in use
+ *
+ */
+static int rx6110_init(struct rx6110_data *rx6110)
+{
+	struct rtc_device *rtc = rx6110->rtc;
+	int need_clear = 0;
+	int need_reset = 0;
+	int ext;
+	int flags;
+	int ctrl;
+	int ret;
+
+	/* set reserved register 0x17 with specified value of 0xB8 */
+	ret = regmap_write(rx6110->regmap, RX6110_REG_RES1, 0xB8);
+	if (ret)
+		goto out;
+
+	/* set reserved register 0x30 with specified value of 0x00 */
+	ret = regmap_write(rx6110->regmap, RX6110_REG_RES1, 0x00);
+	if (ret)
+		goto out;
+
+	/* set reserved register 0x31 with specified value of 0x10 */
+	ret = regmap_write(rx6110->regmap, RX6110_REG_RES1, 0x10);
+	if (ret)
+		goto out;
+
+	ret = regmap_write(rx6110->regmap, RX6110_REG_IRQ, 0x0);
+	if (ret)
+		goto out;
+
+	/* get current extension, flag, control register values */
+	ret = regmap_read(rx6110->regmap, RX6110_REG_EXT, &ext);
+	if (ret)
+		goto out;
+
+	ret = regmap_read(rx6110->regmap, RX6110_REG_FLAG, &flags);
+	if (ret)
+		goto out;
+
+	ret = regmap_read(rx6110->regmap, RX6110_REG_CTRL, &ctrl);
+	if (ret)
+		goto out;
+
+	dev_dbg(&rtc->dev, "ext: %x, flag: %x, ctrl: %x\n", ext, flags, ctrl);
+
+	/* check for VLF Flag (set at power-on) */
+	if ((flags & RX6110_BIT_FLAG_VLF)) {
+		dev_warn(&rtc->dev, "Frequency stop was detected, probably due to a supply voltage drop\n");
+		need_reset = 1;
+	}
+
+	/* check for Alarm Flag */
+	if (flags & RX6110_BIT_FLAG_AF) {
+		dev_warn(&rtc->dev, "Alarm was detected\n");
+		need_clear = 1;
+	}
+
+	/* check for Periodic Timer Flag */
+	if (flags & RX6110_BIT_FLAG_TF) {
+		dev_warn(&rtc->dev, "Periodic timer was detected\n");
+		need_clear = 1;
+	}
+
+	/* check for Update Timer Flag */
+	if (flags & RX6110_BIT_FLAG_UF) {
+		dev_warn(&rtc->dev, "Update timer was detected\n");
+		need_clear = 1;
+	}
+
+	/* reset or clear needed? */
+	if (need_reset) {
+		/* clear ext register */
+		ret = regmap_write(rx6110->regmap, RX6110_REG_EXT, 0);
+		if (ret)
+			goto out;
+
+		/* clear ctrl register */
+		ret = regmap_write(rx6110->regmap, RX6110_REG_CTRL, 0);
+		if (ret)
+			goto out;
+
+		ctrl = 0;
+	}
+
+	if (need_clear) {
+		ret = regmap_write(rx6110->regmap, RX6110_REG_FLAG, 0);
+		if (ret)
+			goto out;
+	}
+
+	if (need_reset) {
+		struct rtc_time tm;
+
+		rx6110_set_time(&rtc->dev, &tm);
+		dev_warn(&rtc->dev, "time reset to 1970/1/1\n");
+	}
+
+
+	/* set "test bit" and reserved bits of control register zero */
+	rx6110->ctrlreg = ctrl & ~RX6110_BIT_CTRL_TEST;
+out:
+	return ret;
+
+}
+
+static struct rtc_class_ops rx6110_rtc_ops = {
+	.read_time = rx6110_get_time,
+	.set_time = rx6110_set_time,
+};
+
+static struct regmap_config regmap_spi_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RX6110_REG_IRQ,
+	.read_flag_mask = 0x80,
+};
+
+/**
+ * rx6110_probe - initialize rtc driver
+ * @spi: pointer to spi device
+ */
+static int rx6110_probe(struct spi_device *spi)
+{
+	struct rx6110_data *rx6110;
+	int err;
+
+	if ((spi->bits_per_word && spi->bits_per_word != 8)
+	    || (spi->max_speed_hz > 2000000)
+	    || (spi->mode != (SPI_CS_HIGH | SPI_CPOL | SPI_CPHA))) {
+		dev_warn(&spi->dev, "SPI settings: bits_per_word: %d, max_speed_hz: %d, mode: %xh\n",
+			spi->bits_per_word, spi->max_speed_hz, spi->mode);
+		dev_warn(&spi->dev, "driving device in an unsupported mode");
+	}
+
+	rx6110 = devm_kzalloc(&spi->dev, sizeof(*rx6110), GFP_KERNEL);
+	if (!rx6110)
+		return -ENOMEM;
+
+	rx6110->regmap = devm_regmap_init_spi(spi, &regmap_spi_config);
+	if (IS_ERR(rx6110->regmap)) {
+		dev_err(&spi->dev, "regmap init failed for rtc rx6110\n");
+		return PTR_ERR(rx6110->regmap);
+	}
+
+	spi_set_drvdata(spi, rx6110);
+
+	rx6110->rtc = devm_rtc_device_register(&spi->dev,
+					       rx6110_driver.driver.name,
+					       &rx6110_rtc_ops, THIS_MODULE);
+
+	if (IS_ERR(rx6110->rtc))
+		return PTR_ERR(rx6110->rtc);
+
+	err = rx6110_init(rx6110);
+	if (err)
+		return err;
+
+	rx6110->rtc->max_user_freq = 1;
+
+	return 0;
+}
+
+static int rx6110_remove(struct spi_device *spi)
+{
+	return 0;
+}
+
+static const struct spi_device_id rx6110_id[] = {
+	{ "rtc-rx6110", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, rx6110_id);
+
+static struct spi_driver rx6110_driver = {
+	.driver = {
+		.name = "rtc-rx6110",
+		.owner = THIS_MODULE,
+	},
+	.probe		= rx6110_probe,
+	.remove		= rx6110_remove,
+	.id_table	= rx6110_id,
+};
+
+module_spi_driver(rx6110_driver);
+
+MODULE_AUTHOR("Val Krutov <val.krutov@erd.epson.com>");
+MODULE_DESCRIPTION("RX-6110 SA RTC driver");
+MODULE_LICENSE("GPL");
-- 
2.6.2

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
