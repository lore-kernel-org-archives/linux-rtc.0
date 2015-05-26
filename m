Return-Path: <rtc-linux+bncBDA7X7F2WUEBBFGTSGVQKGQENRZWQAA@googlegroups.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com. [209.85.212.175])
        by gmr-mx.google.com with ESMTPS id u10si511118wif.1.2015.05.26.05.39.48
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2015 05:39:48 -0700 (PDT)
Received: by wicmx19 with SMTP id mx19so63524434wic.0
        for <rtc-linux@googlegroups.com>; Tue, 26 May 2015 05:39:48 -0700 (PDT)
Date: Tue, 26 May 2015 13:39:43 +0100
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
	tglx@linutronix.de, wim@iguana.be, a.zummo@towertech.it,
	linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com,
	linux@roeck-us.net
Cc: kernel@stlinux.com
Subject: [rtc-linux] [PATCH v2.1 02/12] clocksource: sti: Provide support for
 the ST LPC Clocksource IP
Message-ID: <20150526123943.GI11677@x1>
References: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
 <1431435500-22899-3-git-send-email-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1431435500-22899-3-git-send-email-lee.jones@linaro.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

clocksource: sti: Provide support for the ST LPC Clocksource IP

This IP is shared with Watchdog and RTC functionality.  All 3 of
these devices are mutually exclusive from one another i.e. Only 1
IP can be used at any given time.  We use the device-driver model
combined with a DT 'mode' property to enforce this.

The ST LPC Clocksource IP can be used as the system (tick) timer.

Signed-off-by: Lee Jones <lee.jones@linaro.org>

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 68161f7..01a07a6 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -250,4 +250,13 @@ config CLKSRC_PXA
 	help
 	  This enables OST0 support available on PXA and SA-11x0
 	  platforms.
+
+config CLKSRC_ST_LPC
+	bool
+	depends on ARCH_STI
+	select CLKSRC_OF if OF
+	help
+	  Enable this option to use the Low Power controller timer
+	  as clocksource.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 752d5c7..e08da4d 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -51,3 +51,4 @@ obj-$(CONFIG_ARCH_INTEGRATOR_AP)	+=3D timer-integrator-ap=
.o
 obj-$(CONFIG_CLKSRC_VERSATILE)		+=3D versatile.o
 obj-$(CONFIG_CLKSRC_MIPS_GIC)		+=3D mips-gic-timer.o
 obj-$(CONFIG_ASM9260_TIMER)		+=3D asm9260_timer.o
+obj-$(CONFIG_CLKSRC_ST_LPC)		+=3D clksrc_st_lpc.o
diff --git a/drivers/clocksource/clksrc_st_lpc.c b/drivers/clocksource/clks=
rc_st_lpc.c
new file mode 100644
index 0000000..f38cf33
--- /dev/null
+++ b/drivers/clocksource/clksrc_st_lpc.c
@@ -0,0 +1,123 @@
+/*
+ * Clocksource using the Low Power Timer found in the Low Power Controller=
 (LPC)
+ *
+ * Copyright (C) 2015 STMicroelectronics =E2=80=93 All Rights Reserved
+ *
+ * Author(s): Francesco Virlinzi <francesco.virlinzi@st.com>
+ *	      Ajit Pal Singh <ajitpal.singh@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/clocksource.h>
+#include <linux/init.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/mfd/st-lpc.h>
+
+/* Low Power Timer */
+#define LPC_LPT_LSB_OFF		0x400
+#define LPC_LPT_MSB_OFF		0x404
+#define LPC_LPT_START_OFF	0x408
+
+static struct st_clksrc_ddata {
+	struct clk		*clk;
+	void __iomem		*base;
+} ddata;
+
+static void __init st_clksrc_reset(void)
+{
+	writel_relaxed(0, ddata.base + LPC_LPT_START_OFF);
+	writel_relaxed(0, ddata.base + LPC_LPT_MSB_OFF);
+	writel_relaxed(0, ddata.base + LPC_LPT_LSB_OFF);
+	writel_relaxed(1, ddata.base + LPC_LPT_START_OFF);
+}
+
+static int __init st_clksrc_init(void)
+{
+	unsigned long rate;
+	int ret;
+
+	st_clksrc_reset();
+
+	rate =3D clk_get_rate(ddata.clk);
+
+	ret =3D clocksource_mmio_init(ddata.base + LPC_LPT_LSB_OFF,
+				    "clksrc-st-lpc", rate, 300, 32,
+				    clocksource_mmio_readl_up);
+	if (ret) {
+		pr_err("clksrc-st-lpc: Failed to register clocksource\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __init st_clksrc_setup_clk(struct device_node *np)
+{
+	struct clk *clk;
+
+	clk =3D of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("clksrc-st-lpc: Failed to get LPC clock\n");
+		return PTR_ERR(clk);
+	}
+
+	if (clk_prepare_enable(clk)) {
+		pr_err("clksrc-st-lpc: Failed to enable LPC clock\n");
+		return -EINVAL;
+	}
+
+	if (!clk_get_rate(clk)) {
+		pr_err("clksrc-st-lpc: Failed to get LPC clock rate\n");
+		clk_disable_unprepare(clk);
+		return -EINVAL;
+	}
+
+	ddata.clk =3D clk;
+
+	return 0;
+}
+
+static void __init st_clksrc_of_register(struct device_node *np)
+{
+	int ret;
+	uint32_t mode;
+
+	ret =3D of_property_read_u32(np, "st,lpc-mode", &mode);
+	if (ret) {
+		pr_err("clksrc-st-lpc: An LPC mode must be provided\n");
+		return;
+	}
+
+	/* LPC can either run as a Clocksource or in RTC or WDT mode */
+	if (mode !=3D ST_LPC_MODE_CLKSRC)
+		return;
+
+	ddata.base =3D of_iomap(np, 0);
+	if (!ddata.base) {
+		pr_err("clksrc-st-lpc: Unable to map iomem\n");
+		return;
+	}
+
+	if (st_clksrc_setup_clk(np)) {
+		iounmap(ddata.base);
+		return;
+	}
+
+	if (st_clksrc_init()) {
+		clk_disable_unprepare(ddata.clk);
+		clk_put(ddata.clk);
+		iounmap(ddata.base);
+		return;
+	}
+
+	pr_info("clksrc-st-lpc: clocksource initialised - running @ %luHz\n",
+		clk_get_rate(ddata.clk));
+}
+CLOCKSOURCE_OF_DECLARE(ddata, "st,stih407-lpc", st_clksrc_of_register);

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
