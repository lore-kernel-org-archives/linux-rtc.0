Return-Path: <rtc-linux+bncBAABBXWH3W4AKGQELREXFIA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from emea01-am1-obe.outbound.protection.outlook.com (mail-am1on0104.outbound.protection.outlook.com. [157.56.112.104])
        by gmr-mx.google.com with ESMTPS id r4si7353971pfr.1.2016.04.20.04.11.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Apr 2016 04:11:26 -0700 (PDT)
From: Jeppe Ledet-Pedersen <jlp@gomspace.com>
To: <lee.jones@linaro.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<alexandre.belloni@free-electrons.com>, <a.zummo@towertech.it>,
	<robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>
CC: <rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jeppe Ledet-Pedersen <jlp@gomspace.com>
Subject: [rtc-linux] [PATCH 1/3] mfd: add Cypress FM33256B Processor Companion driver
Date: Wed, 20 Apr 2016 13:07:49 +0200
Message-ID: <1461150471-23163-2-git-send-email-jlp@gomspace.com>
In-Reply-To: <1461150471-23163-1-git-send-email-jlp@gomspace.com>
References: <1461150471-23163-1-git-send-email-jlp@gomspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This patch adds support for the Cypress Semiconductor FM33256B processor
companion. The device contains a 256 kbit FRAM, an RTC, a supply voltage
monitor, and a watchdog timer.

Signed-off-by: Jeppe Ledet-Pedersen <jlp@gomspace.com>
---
 Documentation/devicetree/bindings/mfd/fm33256b.txt |  30 ++
 MAINTAINERS                                        |   6 +
 drivers/mfd/Kconfig                                |  16 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/fm33256b.c                             | 488 +++++++++++++++++++++
 include/linux/mfd/fm33256b.h                       |  76 ++++
 6 files changed, 617 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/fm33256b.txt
 create mode 100644 drivers/mfd/fm33256b.c
 create mode 100644 include/linux/mfd/fm33256b.h

diff --git a/Documentation/devicetree/bindings/mfd/fm33256b.txt b/Documentation/devicetree/bindings/mfd/fm33256b.txt
new file mode 100644
index 0000000..6591c94
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/fm33256b.txt
@@ -0,0 +1,30 @@
+Device-tree bindings for Cypress Semiconductor FM33256B Processor Companion
+---------------------------------------------------------------------------
+
+Required properties:
+- compatible: must be "cypress,fm33256b".
+- reg: SPI chip select
+- spi-max-frequency: Max SPI frequency to use (< 16000000)
+
+Optional properties:
+- cypress,charge-enabled: enable trickle charger
+- cypress,charge-fast: enable fast (1 mA) charging
+
+The MFD exposes two subdevices:
+- The FRAM: "cypress,fm33256b-fram"
+- The RTC: "cypress,fm33256b-rtc"
+
+Example:
+
+spi1: spi@f800800 {
+	status = "okay";
+	cs-gpios = <&pioC 25 0>;
+
+	fm33256b@0 {
+		compatible = "cypress,fm33256b";
+		spi-max-frequency = <10000000>;
+		cypress,charge-enabled;
+		cypress,charge-fast;
+		reg = <0>;
+	};
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 1d5b4be..87b5023 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3382,6 +3382,12 @@ T:	git git://linuxtv.org/anttip/media_tree.git
 S:	Maintained
 F:	drivers/media/common/cypress_firmware*
 
+CYPRESS FM33256B PROCESSOR COMPANION DRIVER
+M:	Jeppe Ledet-Pedersen <jlp@gomspace.com>
+S:	Maintained
+F:	include/linux/mfd/fm33256b.h
+F:	drivers/mfd/fm33256b.c
+
 CYTTSP TOUCHSCREEN DRIVER
 M:	Ferruh Yigit <fery@cypress.com>
 L:	linux-input@vger.kernel.org
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index eea61e3..3a0d3a3 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -93,6 +93,22 @@ config MFD_ATMEL_HLCDC
 	  additional drivers must be enabled in order to use the
 	  functionality of the device.
 
+config MFD_FM33256B
+	tristate "Cypress FM33256 Processor Companion support"
+	select MFD_CORE
+	select REGMAP_SPI
+	depends on OF
+	help
+	  If you say yes here you get support for the Cypress FM33256B
+	  Processor Companion device.
+
+	  This driver provides common support for accessing the device,
+	  additional drivers must be enabled in order to use the
+	  functionality of the device.
+
+	  This driver can also be built as a module. If so the module
+	  will be called fm33256b.
+
 config MFD_BCM590XX
 	tristate "Broadcom BCM590xx PMUs"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 5eaa6465d..a13728d 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -203,3 +203,4 @@ intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
 intel-soc-pmic-$(CONFIG_INTEL_PMC_IPC)	+= intel_soc_pmic_bxtwc.o
 obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
 obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
+obj-$(CONFIG_MFD_FM33256B)	+= fm33256b.o
diff --git a/drivers/mfd/fm33256b.c b/drivers/mfd/fm33256b.c
new file mode 100644
index 0000000..880ccdd
--- /dev/null
+++ b/drivers/mfd/fm33256b.c
@@ -0,0 +1,488 @@
+/*
+ * Cypress FM33256B Processor Companion Driver
+ *
+ * Copyright (C) 2016 GomSpace ApS
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/mfd/fm33256b.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/device.h>
+#include <linux/of.h>
+
+static const struct mfd_cell fm33256b_cells[] = {
+	{
+		.name = "fm33256b-rtc",
+		.of_compatible = "cypress,fm33256b-rtc",
+	},
+	{
+		.name = "fm33256b-fram",
+		.of_compatible = "cypress,fm33256b-fram",
+	},
+};
+
+static int fm33256b_io(struct spi_device *spi, bool write_enable,
+		       uint8_t *out, uint8_t *in, size_t len)
+{
+	struct spi_message m;
+	struct fm33256b *fm33256b = dev_get_drvdata(&spi->dev);
+
+	uint8_t write_out[1] = {FM33256B_OP_WREN};
+
+	/* Payload transfer */
+	struct spi_transfer t = {
+		.tx_buf = out,
+		.rx_buf = in,
+		.len = len,
+	};
+
+	mutex_lock(&fm33256b->lock);
+
+	/* CS must go high for the write enable latch to be enabled,
+	 * so we have to split this in two transfers.
+	 */
+	if (write_enable)
+		spi_write(spi, write_out, 1);
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+	spi_sync(spi, &m);
+
+	mutex_unlock(&fm33256b->lock);
+
+	return 0;
+}
+
+static int fm33256b_read_status(struct spi_device *spi, uint8_t *status)
+{
+	int ret;
+	uint8_t out[2] = {FM33256B_OP_RDSR, 0xff};
+	uint8_t in[2];
+
+	ret = fm33256b_io(spi, false, out, in, 2);
+	if (ret < 0)
+		return ret;
+
+	*status = in[1];
+
+	return 0;
+}
+
+static int fm33256b_write_status(struct spi_device *spi, uint8_t status)
+{
+	uint8_t out[2] = {FM33256B_OP_WRSR, status};
+	uint8_t in[2];
+
+	return fm33256b_io(spi, true, out, in, 2);
+}
+
+static int fm33256b_write_fram(struct spi_device *spi, uint16_t addr,
+			       const uint8_t *data, size_t len)
+{
+	int ret;
+	uint8_t *out = NULL, *in = NULL;
+
+	out = devm_kzalloc(&spi->dev, 3 + len, GFP_KERNEL);
+	in = devm_kzalloc(&spi->dev, 3 + len, GFP_KERNEL);
+	if (!out || !in) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	out[0] = FM33256B_OP_WRITE;
+	out[1] = (addr >> 8) & 0xff;
+	out[2] = addr & 0xff;
+	memcpy(&out[3], data, len);
+
+	ret = fm33256b_io(spi, true, out, in, 3 + len);
+
+out:
+	devm_kfree(&spi->dev, out);
+	devm_kfree(&spi->dev, in);
+
+	return ret;
+}
+
+static int fm33256b_read_fram(struct spi_device *spi, uint16_t addr,
+			      uint8_t *data, size_t len)
+{
+	int ret;
+	uint8_t *out = NULL, *in = NULL;
+
+	out = devm_kzalloc(&spi->dev, 3 + len, GFP_KERNEL);
+	in = devm_kzalloc(&spi->dev, 3 + len, GFP_KERNEL);
+	if (!out || !in) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	out[0] = FM33256B_OP_READ;
+	out[1] = (addr >> 8) & 0xff;
+	out[2] = addr & 0xff;
+	memset(&out[3], 0xff, len);
+
+	ret = fm33256b_io(spi, false, out, in, 3 + len);
+	if (ret == 0)
+		memcpy(data, &in[3], len);
+
+out:
+	devm_kfree(&spi->dev, out);
+	devm_kfree(&spi->dev, in);
+
+	return ret;
+}
+
+static int fm33256b_write_pc(struct spi_device *spi, uint8_t reg,
+			     const uint8_t *data, size_t len)
+{
+	int ret;
+	uint8_t *out = NULL, *in = NULL;
+
+	out = devm_kzalloc(&spi->dev, 2 + len, GFP_KERNEL);
+	in = devm_kzalloc(&spi->dev, 2 + len, GFP_KERNEL);
+	if (!out || !in) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	out[0] = FM33256B_OP_WRPC;
+	out[1] = reg;
+	memcpy(&out[2], data, len);
+
+	ret = fm33256b_io(spi, true, out, in, 2 + len);
+
+out:
+	devm_kfree(&spi->dev, out);
+	devm_kfree(&spi->dev, in);
+
+	return ret;
+}
+
+static int fm33256b_read_pc(struct spi_device *spi, uint8_t reg,
+			    uint8_t *data, size_t len)
+{
+	int ret;
+	uint8_t *out = NULL, *in = NULL;
+
+	out = devm_kzalloc(&spi->dev, 2 + len, GFP_KERNEL);
+	in = devm_kzalloc(&spi->dev, 2 + len, GFP_KERNEL);
+	if (!out || !in) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	out[0] = FM33256B_OP_RDPC;
+	out[1] = reg;
+	memset(&out[2], 0xff, len);
+
+	ret = fm33256b_io(spi, false, out, in, 2 + len);
+	if (ret == 0)
+		memcpy(data, &in[2], len);
+
+out:
+	devm_kfree(&spi->dev, out);
+	devm_kfree(&spi->dev, in);
+
+	return ret;
+}
+
+static int fm33256b_pc_regmap_read(void *context, const void *reg,
+				   size_t reg_size, void *val,
+				   size_t val_size)
+{
+	struct device *dev = context;
+	struct spi_device *spi = to_spi_device(dev);
+
+	if (reg_size != 1)
+		return -ENOTSUPP;
+
+	return fm33256b_read_pc(spi, *(uint8_t *)reg, val, val_size);
+}
+
+static int fm33256b_pc_regmap_write(void *context, const void *data,
+				    size_t count)
+{
+	struct device *dev = context;
+	struct spi_device *spi = to_spi_device(dev);
+
+	const uint8_t *out = data;
+	const uint8_t *val = &out[1];
+
+	uint8_t reg = out[0];
+
+	return fm33256b_write_pc(spi, reg, val, count - sizeof(reg));
+}
+
+static int fm33256b_fram_regmap_read(void *context, const void *reg,
+				     size_t reg_size, void *val,
+				     size_t val_size)
+{
+	struct device *dev = context;
+	struct spi_device *spi = to_spi_device(dev);
+
+	const uint8_t *addrp = reg;
+
+	uint16_t addr = ((uint16_t)addrp[0] << 8) | addrp[1];
+
+	if (reg_size != 2)
+		return -ENOTSUPP;
+
+	return fm33256b_read_fram(spi, addr, val, val_size);
+}
+
+static int fm33256b_fram_regmap_write(void *context, const void *data,
+				      size_t count)
+{
+	struct device *dev = context;
+	struct spi_device *spi = to_spi_device(dev);
+
+	const uint8_t *out = data;
+	const uint8_t *val = &out[2];
+
+	uint16_t addr = ((uint16_t)out[0] << 8) | out[1];
+
+	return fm33256b_write_fram(spi, addr, val, count - sizeof(addr));
+}
+
+static ssize_t fm33256b_bp_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	int ret;
+	uint8_t status, bp;
+
+	ret = fm33256b_read_status(spi, &status);
+	if (ret < 0)
+		return ret;
+
+	bp = (status & 0x0c) >> 2;
+
+	return snprintf(buf, PAGE_SIZE, "%hhu\n", bp);
+}
+
+static ssize_t fm33256b_bp_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	int ret;
+	uint8_t status, bp;
+	unsigned long input;
+
+	ret = kstrtoul(buf, 10, &input);
+	if (ret < 0)
+		return ret;
+
+	if (input > 3)
+		return -EINVAL;
+
+	bp = (uint8_t)input << 2;
+
+	ret = fm33256b_read_status(spi, &status);
+	if (ret < 0)
+		return ret;
+
+	status = (status & 0xf3) | bp;
+
+	ret = fm33256b_write_status(spi, status);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t fm33256b_serial_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	char serial[9];
+	int ret;
+
+	ret = fm33256b_read_pc(spi, FM33256B_SERIAL_BYTE0_REG, serial, 8);
+	if (ret < 0)
+		return ret;
+
+	serial[8] = '\0';
+
+	return snprintf(buf, PAGE_SIZE, "%-8s\n", serial);
+}
+
+static ssize_t fm33256b_serial_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	char serial[9];
+	int ret;
+
+	if (sscanf(buf, "%8s", serial) != 1)
+		return -EINVAL;
+
+	ret = fm33256b_write_pc(spi, FM33256B_SERIAL_BYTE0_REG, serial, 8);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+DEVICE_ATTR(bp, S_IWUSR | S_IRUGO,
+	    fm33256b_bp_show, fm33256b_bp_store);
+DEVICE_ATTR(serial, S_IWUSR | S_IRUGO,
+	    fm33256b_serial_show, fm33256b_serial_store);
+
+/* Processor Companion Register Map */
+static const struct regmap_config fm33256b_pc_regmap_conf = {
+	.name = "pc",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = FM33256B_MAX_REGISTER,
+};
+
+static struct regmap_bus fm33256b_pc_regmap_bus = {
+	.write = fm33256b_pc_regmap_write,
+	.read = fm33256b_pc_regmap_read,
+};
+
+/* FRAM Register Map */
+static const struct regmap_config fm33256b_fram_regmap_conf = {
+	.name = "fram",
+	.reg_bits = 16,
+	.val_bits = 8,
+	.max_register = FM33256B_MAX_FRAM,
+};
+
+static struct regmap_bus fm33256b_fram_regmap_bus = {
+	.write = fm33256b_fram_regmap_write,
+	.read = fm33256b_fram_regmap_read,
+};
+
+static int fm33256b_setup(struct spi_device *spi, struct fm33256b *fm33256b)
+{
+	int ret;
+	uint8_t companion_ctl = FM33256B_ALSW, rtc_alarm_ctl = 0;
+
+	/* Setup charger control from DT */
+	if (of_get_property(spi->dev.of_node, "cypress,charge-enabled", NULL))
+		companion_ctl |= FM33256B_VBC;
+
+	if (of_get_property(spi->dev.of_node, "cypress,charge-fast", NULL))
+		companion_ctl |= FM33256B_FC;
+
+	/* Setup charging if enabled */
+	ret = regmap_write(fm33256b->regmap_pc,
+			   FM33256B_COMPANION_CONTROL_REG,
+			   companion_ctl);
+	if (ret < 0)
+		return ret;
+
+	/* Enable 32 kHz oscillator */
+	ret = regmap_write(fm33256b->regmap_pc,
+			   FM33256B_RTC_ALARM_CONTROL_REG,
+			   rtc_alarm_ctl);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int fm33256b_probe(struct spi_device *spi)
+{
+	int ret;
+	struct device *dev = &spi->dev;
+	struct fm33256b *fm33256b;
+
+	fm33256b = devm_kzalloc(dev, sizeof(*fm33256b), GFP_KERNEL);
+	if (!fm33256b)
+		return -ENOMEM;
+
+	mutex_init(&fm33256b->lock);
+
+	spi->mode = SPI_MODE_0;
+	spi->max_speed_hz = spi->max_speed_hz ? : 8000000;
+
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return ret;
+
+	/* Setup processor companion regmap */
+	fm33256b->regmap_pc =
+		devm_regmap_init(dev, &fm33256b_pc_regmap_bus,
+				 dev, &fm33256b_pc_regmap_conf);
+	if (IS_ERR(fm33256b->regmap_pc))
+		return PTR_ERR(fm33256b->regmap_pc);
+
+	/* Setup FRAM regmap */
+	fm33256b->regmap_fram =
+		devm_regmap_init(dev, &fm33256b_fram_regmap_bus,
+				 dev, &fm33256b_fram_regmap_conf);
+	if (IS_ERR(fm33256b->regmap_fram))
+		return PTR_ERR(fm33256b->regmap_fram);
+
+	dev_set_drvdata(dev, fm33256b);
+
+	ret = fm33256b_setup(spi, fm33256b);
+	if (ret < 0)
+		return ret;
+
+	/* Create sysfs entries */
+	ret = device_create_file(&spi->dev, &dev_attr_bp);
+	if (ret < 0)
+		return ret;
+
+	ret = device_create_file(&spi->dev, &dev_attr_serial);
+	if (ret < 0) {
+		device_remove_file(&spi->dev, &dev_attr_bp);
+		return ret;
+	}
+
+	return mfd_add_devices(dev, -1, fm33256b_cells,
+			       ARRAY_SIZE(fm33256b_cells),
+			       NULL, 0, NULL);
+}
+
+static int fm33256b_remove(struct spi_device *spi)
+{
+	mfd_remove_devices(&spi->dev);
+	device_remove_file(&spi->dev, &dev_attr_serial);
+	device_remove_file(&spi->dev, &dev_attr_bp);
+
+	return 0;
+}
+
+static const struct of_device_id fm33256b_dt_ids[] = {
+	{ .compatible = "cypress,fm33256b" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, fm33256b_dt_ids);
+
+static struct spi_driver fm33256b_spi_driver = {
+	.driver = {
+		.name = "fm33256b",
+		.owner = THIS_MODULE,
+		.of_match_table = fm33256b_dt_ids,
+	},
+	.probe = fm33256b_probe,
+	.remove = fm33256b_remove,
+};
+module_spi_driver(fm33256b_spi_driver);
+
+MODULE_ALIAS("spi:fm33256b");
+MODULE_DESCRIPTION("Cypress FM33256B Processor Companion Driver");
+MODULE_AUTHOR("Jeppe Ledet-Pedersen <jlp@gomspace.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/fm33256b.h b/include/linux/mfd/fm33256b.h
new file mode 100644
index 0000000..cd1e37a
--- /dev/null
+++ b/include/linux/mfd/fm33256b.h
@@ -0,0 +1,76 @@
+/*
+ * Cypress FM33256B Processor Companion Driver
+ *
+ * Copyright (C) 2016 GomSpace ApS
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __LINUX_MFD_FM33256B_H
+#define __LINUX_MFD_FM33256B_H
+
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+/* Opcodes */
+#define FM33256B_OP_WREN		0x06
+#define FM33256B_OP_WRDI		0x04
+#define FM33256B_OP_RDSR		0x05
+#define FM33256B_OP_WRSR		0x01
+#define FM33256B_OP_READ		0x03
+#define FM33256B_OP_WRITE		0x02
+#define FM33256B_OP_RDPC		0x13
+#define FM33256B_OP_WRPC		0x12
+
+/* RTC/Processor Companion Register Map */
+#define FM33256B_ALARM_MONTH		0x1D
+#define FM33256B_COMPANION_CONTROL_REG	0x18
+#define FM33256B_SERIAL_BYTE0_REG	0x10
+#define FM33256B_YEARS_REG		0x08
+#define FM33256B_MONTH_REG		0x07
+#define FM33256B_DATE_REG		0x06
+#define FM33256B_DAY_REG		0x05
+#define FM33256B_HOURS_REG		0x04
+#define FM33256B_MINUTES_REG		0x03
+#define FM33256B_SECONDS_REG		0x02
+#define FM33256B_CAL_CONTROL_REG	0x01
+#define FM33256B_RTC_ALARM_CONTROL_REG	0x00
+
+/* Companion Control bits */
+#define FM33256B_ALSW			BIT(6)
+#define FM33256B_VBC			BIT(3)
+#define FM33256B_FC			BIT(2)
+
+/* RTC/Alarm Control bits */
+#define FM33256B_R			BIT(0)
+#define FM33256B_W			BIT(1)
+#define FM33256B_CAL			BIT(2)
+#define FM33256B_OSCEN			BIT(7)
+
+/* Limits */
+#define FM33256B_MAX_REGISTER		FM33256B_ALARM_MONTH
+#define FM33256B_MAX_FRAM		(32 * 1024) /* 256 kb */
+
+/**
+ * Structure shared by the MFD device and its subdevices.
+ *
+ * @regmap: register map used to access registers
+ */
+struct fm33256b {
+	struct mutex lock;
+	struct regmap *regmap_pc;
+	struct regmap *regmap_fram;
+};
+
+#endif /* __LINUX_MFD_FM33256B_H */
-- 
2.1.4

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
