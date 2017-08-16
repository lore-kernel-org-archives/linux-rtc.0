Return-Path: <rtc-linux+bncBAABBOOPZ3GAKGQEZ3FZE6A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from regular1.263xmail.com (regular1.263xmail.com. [211.150.99.130])
        by gmr-mx.google.com with ESMTPS id u66si698529itd.1.2017.08.15.19.02.32
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 19:02:33 -0700 (PDT)
From: Joseph Chen <chenjh@rock-chips.com>
To: gnurou@gmail.com,
	linus.walleij@linaro.org,
	dmitry.torokhov@gmail.com,
	lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org,
	huangtao@rock-chips.com,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	broonie@kernel.org,
	zhangqing@rock-chips.com,
	robh+dt@kernel.org,
	lgirdwood@gmail.com,
	linux-rockchip@lists.infradead.org,
	wdc@rock-chips.com,
	tony.xie@rock-chips.com,
	linux-input@vger.kernel.org,
	mark.rutland@arm.com,
	w.egorov@phytec.de,
	linux-clk@vger.kernel.org,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	Joseph Chen <chenjh@rock-chips.com>
Subject: [rtc-linux] [RESEND v9 09/12] Input: Add power key driver for
 Rockchip RK805 PMIC
Date: Wed, 16 Aug 2017 10:01:34 +0800
Message-Id: <1502848894-29511-1-git-send-email-chenjh@rock-chips.com>
In-Reply-To: <1502848628-27757-1-git-send-email-chenjh@rock-chips.com>
References: <1502848628-27757-1-git-send-email-chenjh@rock-chips.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This driver provides a input driver for the power
key on the Rockchip RK805 PMIC.

Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
---
 drivers/input/misc/Kconfig        |   6 +++
 drivers/input/misc/Makefile       |   1 +
 drivers/input/misc/rk805-pwrkey.c | 111 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+)
 create mode 100644 drivers/input/misc/rk805-pwrkey.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 5b6c522..72dc4f5 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -571,6 +571,12 @@ config INPUT_PWM_BEEPER
 	  To compile this driver as a module, choose M here: the module will be
 	  called pwm-beeper.
 
+config INPUT_RK805_PWRKEY
+	tristate "Rockchip RK805 PMIC power key support"
+	depends on MFD_RK808
+	help
+	  Select this option to enable power key driver for RK805.
+
 config INPUT_GPIO_ROTARY_ENCODER
 	tristate "Rotary encoders connected to GPIO pins"
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index b10523f..c27052a 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_INPUT_REGULATOR_HAPTIC)	+= regulator-haptic.o
 obj-$(CONFIG_INPUT_RETU_PWRBUTTON)	+= retu-pwrbutton.o
 obj-$(CONFIG_INPUT_AXP20X_PEK)		+= axp20x-pek.o
 obj-$(CONFIG_INPUT_GPIO_ROTARY_ENCODER)	+= rotary_encoder.o
+obj-$(CONFIG_INPUT_RK805_PWRKEY)	+= rk805-pwrkey.o
 obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
 obj-$(CONFIG_INPUT_SIRFSOC_ONKEY)	+= sirfsoc-onkey.o
 obj-$(CONFIG_INPUT_SOC_BUTTON_ARRAY)	+= soc_button_array.o
diff --git a/drivers/input/misc/rk805-pwrkey.c b/drivers/input/misc/rk805-pwrkey.c
new file mode 100644
index 0000000..e0fc66e
--- /dev/null
+++ b/drivers/input/misc/rk805-pwrkey.c
@@ -0,0 +1,111 @@
+/*
+ * Rockchip RK805 PMIC Power Key driver
+ *
+ * Copyright (c) 2017, Fuzhou Rockchip Electronics Co., Ltd
+ *
+ * Author: Joseph Chen <chenjh@rock-chips.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under  the terms of the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ */
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+static irqreturn_t pwrkey_fall_irq(int irq, void *_pwr)
+{
+	struct input_dev *pwr = _pwr;
+
+	input_report_key(pwr, KEY_POWER, 1);
+	input_sync(pwr);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t pwrkey_rise_irq(int irq, void *_pwr)
+{
+	struct input_dev *pwr = _pwr;
+
+	input_report_key(pwr, KEY_POWER, 0);
+	input_sync(pwr);
+
+	return IRQ_HANDLED;
+}
+
+static int rk805_pwrkey_probe(struct platform_device *pdev)
+{
+	struct input_dev *pwr;
+	int fall_irq, rise_irq;
+	int err;
+
+	pwr = devm_input_allocate_device(&pdev->dev);
+	if (!pwr) {
+		dev_err(&pdev->dev, "Can't allocate power button\n");
+		return -ENOMEM;
+	}
+
+	pwr->name = "rk805 pwrkey";
+	pwr->phys = "rk805_pwrkey/input0";
+	pwr->dev.parent = &pdev->dev;
+	input_set_capability(pwr, EV_KEY, KEY_POWER);
+
+	fall_irq = platform_get_irq(pdev, 0);
+	if (fall_irq < 0) {
+		dev_err(&pdev->dev, "Can't get fall irq: %d\n", fall_irq);
+		return fall_irq;
+	}
+
+	rise_irq = platform_get_irq(pdev, 1);
+	if (rise_irq < 0) {
+		dev_err(&pdev->dev, "Can't get rise irq: %d\n", rise_irq);
+		return rise_irq;
+	}
+
+	err = devm_request_any_context_irq(&pwr->dev, fall_irq,
+					   pwrkey_fall_irq,
+					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					   "rk805_pwrkey_fall", pwr);
+	if (err < 0) {
+		dev_err(&pdev->dev, "Can't register fall irq: %d\n", err);
+		return err;
+	}
+
+	err = devm_request_any_context_irq(&pwr->dev, rise_irq,
+					   pwrkey_rise_irq,
+					   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					   "rk805_pwrkey_rise", pwr);
+	if (err < 0) {
+		dev_err(&pdev->dev, "Can't register rise irq: %d\n", err);
+		return err;
+	}
+
+	err = input_register_device(pwr);
+	if (err) {
+		dev_err(&pdev->dev, "Can't register power button: %d\n", err);
+		return err;
+	}
+
+	platform_set_drvdata(pdev, pwr);
+	device_init_wakeup(&pdev->dev, true);
+
+	return 0;
+}
+
+static struct platform_driver rk805_pwrkey_driver = {
+	.probe	= rk805_pwrkey_probe,
+	.driver	= {
+		.name = "rk805-pwrkey",
+	},
+};
+module_platform_driver(rk805_pwrkey_driver);
+
+MODULE_AUTHOR("Joseph Chen <chenjh@rock-chips.com>");
+MODULE_DESCRIPTION("RK805 PMIC Power Key driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1


-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
