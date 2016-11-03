Return-Path: <rtc-linux+bncBDAYD2P3QYGRBS4T5XAAKGQEMKJO5JA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x22e.google.com (mail-wm0-x22e.google.com. [2a00:1450:400c:c09::22e])
        by gmr-mx.google.com with ESMTPS id g142si2832043wmd.2.2016.11.03.07.29.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Nov 2016 07:29:31 -0700 (PDT)
Received: by mail-wm0-x22e.google.com with SMTP id p190so336944919wmp.1
        for <rtc-linux@googlegroups.com>; Thu, 03 Nov 2016 07:29:31 -0700 (PDT)
From: Neil Armstrong <narmstrong@baylibre.com>
To: khilman@baylibre.com,
	carlo@caione.org,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: Neil Armstrong <narmstrong@baylibre.com>,
	rtc-linux@googlegroups.com,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [RFC PATCH 1/3] ARM64: meson: Add Amlogic Meson GX PM Suspend
Date: Thu,  3 Nov 2016 15:29:23 +0100
Message-Id: <1478183365-23708-2-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1478183365-23708-1-git-send-email-narmstrong@baylibre.com>
References: <1478183365-23708-1-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The Amlogic Meson GX SoCs uses a non-standard argument to the
PSCI CPU_SUSPEND call to enter system suspend.

Implement such call within platform_suspend_ops.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/meson/Kconfig       |  6 +++
 drivers/firmware/meson/Makefile      |  1 +
 drivers/firmware/meson/meson_gx_pm.c | 86 ++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 drivers/firmware/meson/meson_gx_pm.c

diff --git a/drivers/firmware/meson/Kconfig b/drivers/firmware/meson/Kconfig
index 170d7e8..5b3fea3 100644
--- a/drivers/firmware/meson/Kconfig
+++ b/drivers/firmware/meson/Kconfig
@@ -7,3 +7,9 @@ config MESON_SM
 	depends on ARM64_4K_PAGES
 	help
 	  Say y here to enable the Amlogic secure monitor driver
+
+config MESON_GX_PM
+	bool
+	default ARCH_MESON if ARM64
+	help
+	  Say y here to enable the Amlogic GX SoC Power Management
diff --git a/drivers/firmware/meson/Makefile b/drivers/firmware/meson/Makefile
index 9ab3884..b6e285d 100644
--- a/drivers/firmware/meson/Makefile
+++ b/drivers/firmware/meson/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_MESON_SM) +=	meson_sm.o
+obj-$(CONFIG_MESON_GX_PM) +=	meson_gx_pm.o
diff --git a/drivers/firmware/meson/meson_gx_pm.c b/drivers/firmware/meson/meson_gx_pm.c
new file mode 100644
index 0000000..c104c2e
--- /dev/null
+++ b/drivers/firmware/meson/meson_gx_pm.c
@@ -0,0 +1,86 @@
+/*
+ * Amlogic Meson GX Power Management
+ *
+ * Copyright (c) 2016 Baylibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/suspend.h>
+#include <linux/arm-smccc.h>
+
+#include <uapi/linux/psci.h>
+
+#include <asm/suspend.h>
+
+/*
+ * The Amlogic GX SoCs uses a special argument value to the
+ * PSCI CPU_SUSPEND method to enter SUSPEND_MEM.
+ */
+
+#define MESON_SUSPEND_PARAM	0x0010000
+#define PSCI_FN_NATIVE(version, name)	PSCI_##version##_FN64_##name
+
+static int meson_gx_suspend_finish(unsigned long arg)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(PSCI_FN_NATIVE(0_2, CPU_SUSPEND), arg,
+		      virt_to_phys(cpu_resume), 0, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+static int meson_gx_suspend_enter(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_MEM:
+		return cpu_suspend(MESON_SUSPEND_PARAM,
+				   meson_gx_suspend_finish);
+	}
+
+	return -EINVAL;
+}
+
+static const struct platform_suspend_ops meson_gx_pm_ops = {
+		.enter = meson_gx_suspend_enter,
+		.valid = suspend_valid_only_mem,
+};
+
+static const struct of_device_id meson_gx_pm_match[] = {
+	{ .compatible = "amlogic,meson-gx-pm", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, meson_gx_pm_match);
+
+static int meson_gx_pm_probe(struct platform_device *pdev)
+{
+	suspend_set_ops(&meson_gx_pm_ops);
+
+	return 0;
+}
+
+static struct platform_driver meson_gx_pm_driver = {
+	.probe = meson_gx_pm_probe,
+	.driver = {
+		.name = "meson-gx-pm",
+		.of_match_table = meson_gx_pm_match,
+	},
+};
+
+module_platform_driver(meson_gx_pm_driver);
+
+MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
+MODULE_DESCRIPTION("Amlogic Meson GX PM driver");
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
