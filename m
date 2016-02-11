Return-Path: <rtc-linux+bncBD2OLRXW4ABBBZPT6G2QKGQE4LUBRHA@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id tn7si925141pac.1.2016.02.11.04.09.09
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Feb 2016 04:09:09 -0800 (PST)
From: Laxman Dewangan <ldewangan@nvidia.com>
To: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linus.walleij@linaro.org>, <gnurou@gmail.com>, <lee.jones@linaro.org>,
	<broonie@kernel.org>, <a.zummo@towertech.it>,
	<alexandre.belloni@free-electrons.com>
CC: <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, <swarren@nvidia.com>, <treding@nvidia.com>,
	<k.kozlowski@samsung.com>, Laxman Dewangan <ldewangan@nvidia.com>
Subject: [rtc-linux] [PATCH V8 6/8] gpio: max77620: add gpio driver for MAX77620/MAX20024
Date: Thu, 11 Feb 2016 17:26:32 +0530
Message-ID: <1455191794-6065-7-git-send-email-ldewangan@nvidia.com>
In-Reply-To: <1455191794-6065-1-git-send-email-ldewangan@nvidia.com>
References: <1455191794-6065-1-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

MAXIM Semiconductor's PMIC, MAX77620/MAX20024 has 8 GPIO
pins. It also supports interrupts from these pins.

Add GPIO driver for these pins to control via GPIO APIs.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

---
Changes from V1:
- Use the gpiochip_add_data and get the chip data from core APIs.
- Cleanups based on comment received on mfd/rtc.
- Avoid duplication on error message.

Changes form V2:
- Run coccicheck and checkpatch in strict mode for the alignment.
- update based on api changes from core.

Changes from V3:
- Change all sys initcall to module driver.
- change the max77620_read argument to unisgned int from u8.

Changes from V4:
- Added DT binding document as devicetree/bindings/gpio/gpio-max77620.txt

Changes from V5:
- Separate out DT binding doc for gpio.
- Added reviewed by for Linus W

Changes from V6/V7:
- None

 drivers/gpio/Kconfig         |   9 ++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-max77620.c | 263 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 273 insertions(+)
 create mode 100644 drivers/gpio/gpio-max77620.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 77df866..0b172ce 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -824,6 +824,15 @@ config GPIO_LP3943
 	  LP3943 can be used as a GPIO expander which provides up to 16 GPIOs.
 	  Open drain outputs are required for this usage.
 
+config GPIO_MAX77620
+	bool "GPIO support for PMIC MAX77620 and MAX20024"
+	depends on MFD_MAX77620
+	help
+	  GPIO driver for MAX77620 and MAX20024 PMIC from Maxim Semiconductor.
+	  MAX77620 PMIC has 8 pins that can be configured as GPIOs. The
+	  driver also provides interrupt support for each of the gpios.
+	  Say yes here to enable the max77620 to be used as gpio controller.
+
 config GPIO_MSIC
 	bool "Intel MSIC mixed signal gpio support"
 	depends on MFD_INTEL_MSIC
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 2f5852d..cec4285 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_GPIO_MAX730X)	+= gpio-max730x.o
 obj-$(CONFIG_GPIO_MAX7300)	+= gpio-max7300.o
 obj-$(CONFIG_GPIO_MAX7301)	+= gpio-max7301.o
 obj-$(CONFIG_GPIO_MAX732X)	+= gpio-max732x.o
+obj-$(CONFIG_GPIO_MAX77620)	+= gpio-max77620.o
 obj-$(CONFIG_GPIO_MB86S7X)	+= gpio-mb86s7x.o
 obj-$(CONFIG_GPIO_MC33880)	+= gpio-mc33880.o
 obj-$(CONFIG_GPIO_MC9S08DZ60)	+= gpio-mc9s08dz60.o
diff --git a/drivers/gpio/gpio-max77620.c b/drivers/gpio/gpio-max77620.c
new file mode 100644
index 0000000..54fe5ff
--- /dev/null
+++ b/drivers/gpio/gpio-max77620.c
@@ -0,0 +1,263 @@
+/*
+ * MAXIM MAX77620 GPIO driver
+ *
+ * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/max77620.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define GPIO_REG_ADDR(offset) (MAX77620_REG_GPIO0 + offset)
+
+struct max77620_gpio {
+	struct gpio_chip	gpio_chip;
+	struct regmap		*rmap;
+	struct device		*dev;
+	int			gpio_irq;
+	int			irq_base;
+	int			gpio_base;
+};
+
+static const struct regmap_irq max77620_gpio_irqs[] = {
+	REGMAP_IRQ_REG(0, 0, MAX77620_IRQ_LVL2_GPIO_EDGE0),
+	REGMAP_IRQ_REG(1, 0, MAX77620_IRQ_LVL2_GPIO_EDGE1),
+	REGMAP_IRQ_REG(2, 0, MAX77620_IRQ_LVL2_GPIO_EDGE2),
+	REGMAP_IRQ_REG(3, 0, MAX77620_IRQ_LVL2_GPIO_EDGE3),
+	REGMAP_IRQ_REG(4, 0, MAX77620_IRQ_LVL2_GPIO_EDGE4),
+	REGMAP_IRQ_REG(5, 0, MAX77620_IRQ_LVL2_GPIO_EDGE5),
+	REGMAP_IRQ_REG(6, 0, MAX77620_IRQ_LVL2_GPIO_EDGE6),
+	REGMAP_IRQ_REG(7, 0, MAX77620_IRQ_LVL2_GPIO_EDGE7),
+};
+
+static struct regmap_irq_chip max77620_gpio_irq_chip = {
+	.name = "max77620-gpio",
+	.irqs = max77620_gpio_irqs,
+	.num_irqs = ARRAY_SIZE(max77620_gpio_irqs),
+	.num_regs = 1,
+	.irq_reg_stride = 1,
+	.status_base = MAX77620_REG_IRQ_LVL2_GPIO,
+};
+
+static int max77620_gpio_dir_input(struct gpio_chip *gc, unsigned offset)
+{
+	struct max77620_gpio *mgpio = gpiochip_get_data(gc);
+	int ret;
+
+	ret = regmap_update_bits(mgpio->rmap, GPIO_REG_ADDR(offset),
+				 MAX77620_CNFG_GPIO_DIR_MASK,
+				 MAX77620_CNFG_GPIO_DIR_INPUT);
+	if (ret < 0)
+		dev_err(mgpio->dev, "CNFG_GPIOx dir update failed: %d\n", ret);
+
+	return ret;
+}
+
+static int max77620_gpio_get(struct gpio_chip *gc, unsigned offset)
+{
+	struct max77620_gpio *mgpio = gpiochip_get_data(gc);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(mgpio->rmap, GPIO_REG_ADDR(offset), &val);
+	if (ret < 0) {
+		dev_err(mgpio->dev, "CNFG_GPIOx read failed: %d\n", ret);
+		return ret;
+	}
+
+	return !!(val & MAX77620_CNFG_GPIO_INPUT_VAL_MASK);
+}
+
+static int max77620_gpio_dir_output(struct gpio_chip *gc, unsigned offset,
+				    int value)
+{
+	struct max77620_gpio *mgpio = gpiochip_get_data(gc);
+	u8 val;
+	int ret;
+
+	val = (value) ? MAX77620_CNFG_GPIO_OUTPUT_VAL_HIGH :
+				MAX77620_CNFG_GPIO_OUTPUT_VAL_LOW;
+
+	ret = regmap_update_bits(mgpio->rmap, GPIO_REG_ADDR(offset),
+				 MAX77620_CNFG_GPIO_OUTPUT_VAL_MASK, val);
+	if (ret < 0) {
+		dev_err(mgpio->dev, "CNFG_GPIOx val update failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(mgpio->rmap, GPIO_REG_ADDR(offset),
+				 MAX77620_CNFG_GPIO_DIR_MASK,
+				 MAX77620_CNFG_GPIO_DIR_OUTPUT);
+	if (ret < 0)
+		dev_err(mgpio->dev, "CNFG_GPIOx dir update failed: %d\n", ret);
+
+	return ret;
+}
+
+static int max77620_gpio_set_debounce(struct gpio_chip *gc,
+				      unsigned offset, unsigned debounce)
+{
+	struct max77620_gpio *mgpio = gpiochip_get_data(gc);
+	u8 val;
+	int ret;
+
+	switch (debounce) {
+	case 0:
+		val = MAX77620_CNFG_GPIO_DBNC_None;
+		break;
+	case 1 ... 8:
+		val = MAX77620_CNFG_GPIO_DBNC_8ms;
+		break;
+	case 9 ... 16:
+		val = MAX77620_CNFG_GPIO_DBNC_16ms;
+		break;
+	case 17 ... 32:
+		val = MAX77620_CNFG_GPIO_DBNC_32ms;
+		break;
+	default:
+		dev_err(mgpio->dev, "Illegal value %u\n", debounce);
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(mgpio->rmap, GPIO_REG_ADDR(offset),
+				 MAX77620_CNFG_GPIO_DBNC_MASK, val);
+	if (ret < 0)
+		dev_err(mgpio->dev, "CNFG_GPIOx_DBNC update failed: %d\n", ret);
+
+	return ret;
+}
+
+static void max77620_gpio_set(struct gpio_chip *gc, unsigned offset,
+			      int value)
+{
+	struct max77620_gpio *mgpio = gpiochip_get_data(gc);
+	u8 val;
+	int ret;
+
+	val = (value) ? MAX77620_CNFG_GPIO_OUTPUT_VAL_HIGH :
+				MAX77620_CNFG_GPIO_OUTPUT_VAL_LOW;
+
+	ret = regmap_update_bits(mgpio->rmap, GPIO_REG_ADDR(offset),
+				 MAX77620_CNFG_GPIO_OUTPUT_VAL_MASK, val);
+	if (ret < 0)
+		dev_err(mgpio->dev, "CNFG_GPIO_OUT update failed: %d\n", ret);
+}
+
+static int max77620_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
+{
+	struct max77620_gpio *mgpio = gpiochip_get_data(gc);
+	struct max77620_chip *chip = dev_get_drvdata(mgpio->dev->parent);
+
+	return regmap_irq_get_virq(chip->gpio_irq_data, offset);
+}
+
+static void max77620_gpio_irq_remove(struct max77620_gpio *mgpio)
+{
+	struct max77620_chip *chip = dev_get_drvdata(mgpio->dev->parent);
+
+	regmap_del_irq_chip(mgpio->gpio_irq, chip->gpio_irq_data);
+	chip->gpio_irq_data = NULL;
+}
+
+static int max77620_gpio_probe(struct platform_device *pdev)
+{
+	struct max77620_chip *chip =  dev_get_drvdata(pdev->dev.parent);
+	struct max77620_gpio *mgpio;
+	int gpio_irq;
+	int ret;
+
+	gpio_irq = platform_get_irq(pdev, 0);
+	if (gpio_irq <= 0) {
+		dev_err(&pdev->dev, "GPIO irq not available %d\n", gpio_irq);
+		return -ENODEV;
+	}
+
+	mgpio = devm_kzalloc(&pdev->dev, sizeof(*mgpio), GFP_KERNEL);
+	if (!mgpio)
+		return -ENOMEM;
+
+	mgpio->rmap = chip->rmap;
+	mgpio->dev = &pdev->dev;
+	mgpio->gpio_irq = gpio_irq;
+
+	mgpio->gpio_chip.label = pdev->name;
+	mgpio->gpio_chip.parent = &pdev->dev;
+	mgpio->gpio_chip.direction_input = max77620_gpio_dir_input;
+	mgpio->gpio_chip.get = max77620_gpio_get;
+	mgpio->gpio_chip.direction_output = max77620_gpio_dir_output;
+	mgpio->gpio_chip.set_debounce = max77620_gpio_set_debounce;
+	mgpio->gpio_chip.set = max77620_gpio_set;
+	mgpio->gpio_chip.to_irq = max77620_gpio_to_irq;
+	mgpio->gpio_chip.ngpio = MAX77620_GPIO_NR;
+	mgpio->gpio_chip.can_sleep = 1;
+	mgpio->gpio_chip.base = -1;
+	mgpio->irq_base = -1;
+#ifdef CONFIG_OF_GPIO
+	mgpio->gpio_chip.of_node = pdev->dev.parent->of_node;
+#endif
+
+	platform_set_drvdata(pdev, mgpio);
+
+	ret = gpiochip_add_data(&mgpio->gpio_chip, mgpio);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "gpio_init: Failed to add max77620_gpio\n");
+		return ret;
+	}
+	mgpio->gpio_base = mgpio->gpio_chip.base;
+
+	ret = regmap_add_irq_chip(chip->rmap, mgpio->gpio_irq, IRQF_ONESHOT,
+				  mgpio->irq_base,
+				  &max77620_gpio_irq_chip,
+				  &chip->gpio_irq_data);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to add gpio irq_chip %d\n", ret);
+		goto fail;
+	}
+
+	return 0;
+
+fail:
+	gpiochip_remove(&mgpio->gpio_chip);
+
+	return ret;
+}
+
+static int max77620_gpio_remove(struct platform_device *pdev)
+{
+	struct max77620_gpio *mgpio = platform_get_drvdata(pdev);
+
+	max77620_gpio_irq_remove(mgpio);
+	gpiochip_remove(&mgpio->gpio_chip);
+
+	return 0;
+}
+
+static const struct platform_device_id max77620_gpio_devtype[] = {
+	{ .name = "max77620-gpio", },
+	{ .name = "max20024-gpio", },
+	{},
+};
+MODULE_DEVICE_TABLE(platform, max77620_gpio_devtype);
+
+static struct platform_driver max77620_gpio_driver = {
+	.driver.name	= "max77620-gpio",
+	.driver.owner	= THIS_MODULE,
+	.probe		= max77620_gpio_probe,
+	.remove		= max77620_gpio_remove,
+	.id_table	= max77620_gpio_devtype,
+};
+
+module_platform_driver(max77620_gpio_driver);
+
+MODULE_DESCRIPTION("GPIO interface for MAX77620 and MAX20024 PMIC");
+MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
+MODULE_AUTHOR("Chaitanya Bandi <bandik@nvidia.com>");
+MODULE_ALIAS("platform:max77620-gpio");
+MODULE_LICENSE("GPL v2");
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
