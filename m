Return-Path: <rtc-linux+bncBAABB3WTWXAAKGQELLSOFCA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (mail-dm3nam03on0067.outbound.protection.outlook.com. [104.47.41.67])
        by gmr-mx.google.com with ESMTPS id 7si2011585par.0.2016.10.23.18.54.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Oct 2016 18:54:54 -0700 (PDT)
From: Meng Yi <meng.yi@nxp.com>
To: <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>
CC: <rtc-linux@googlegroups.com>, <linux-kernel@vger.kernel.org>, Meng Yi
	<meng.yi@nxp.com>
Subject: [rtc-linux] [RFC PATCH] rtc/nxp: add FTM alarm driver as the wakeup source
Date: Mon, 24 Oct 2016 09:42:16 +0800
Message-ID: <1477273336-48449-1-git-send-email-meng.yi@nxp.com>
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

For the platforms including LS1021A, LS1043A that has the
flextimer module, implementing alarm functions within RTC
subsystem to wakeup the system when system going to sleep.
Only Ftm0 can be used to wakeup the system.

Signed-off-by: Meng Yi <meng.yi@nxp.com>
---
 drivers/rtc/Kconfig       |   9 ++
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/rtc-nxp-ftm.c | 255 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 265 insertions(+)
 create mode 100644 drivers/rtc/rtc-nxp-ftm.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e859d14..0ba52b3 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1243,6 +1243,15 @@ config RTC_DRV_IMXDI
 	   This driver can also be built as a module, if so, the module
 	   will be called "rtc-imxdi".
 
+config RTC_DRV_NXP
+	tristate "NXP flextimer Real Time Alarm "
+	help
+	For the FlexTimer on LS1021A, LS1043A, we can use FTM0 as the wakeup
+	source.
+	Say y here to enable FTM alarm support.  The FTM alarm provides
+	alarm functions for wakeup system from deep sleep.  There is only
+	one FTM can be used in ALARM(FTM 0).
+
 config RTC_DRV_OMAP
 	tristate "TI OMAP Real Time Clock"
 	depends on ARCH_OMAP || ARCH_DAVINCI || COMPILE_TEST
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 1ac694a..abbf22c 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_RTC_DRV_GENERIC)	+= rtc-generic.o
 obj-$(CONFIG_RTC_DRV_HID_SENSOR_TIME) += rtc-hid-sensor-time.o
 obj-$(CONFIG_RTC_DRV_HYM8563)	+= rtc-hym8563.o
 obj-$(CONFIG_RTC_DRV_IMXDI)	+= rtc-imxdi.o
+obj-$(CONFIG_RTC_DRV_NXP)	+= rtc-nxp-ftm.o
 obj-$(CONFIG_RTC_DRV_ISL12022)	+= rtc-isl12022.o
 obj-$(CONFIG_RTC_DRV_ISL1208)	+= rtc-isl1208.o
 obj-$(CONFIG_RTC_DRV_JZ4740)	+= rtc-jz4740.o
diff --git a/drivers/rtc/rtc-nxp-ftm.c b/drivers/rtc/rtc-nxp-ftm.c
new file mode 100644
index 0000000..74c4358
--- /dev/null
+++ b/drivers/rtc/rtc-nxp-ftm.c
@@ -0,0 +1,255 @@
+/*
+ * Copyright 2016 NXP Semiconductor, Inc.
+ *
+ * NXP FTM alarm device driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/rtc.h>
+#include <linux/bcd.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/of_irq.h>
+
+#define FTM_SC			0x00
+#define FTM_SC_CLK_SHIFT	3
+#define FTM_SC_CLK_MASK		(0x3 << FTM_SC_CLK_SHIFT)
+#define FTM_SC_CLK(c)		((c) << FTM_SC_CLK_SHIFT)
+#define FTM_SC_PS_MASK		0x7
+#define FTM_SC_TOIE		BIT(6)
+#define FTM_SC_TOF		BIT(7)
+
+#define FTM_SC_CLKS_FIXED_FREQ	0x02
+
+#define FTM_CNT			0x04
+#define FTM_MOD			0x08
+#define FTM_CNTIN		0x4C
+
+#define FIXED_FREQ_CLK		32000
+#define MAX_FREQ_DIV		(1 << FTM_SC_PS_MASK)
+#define MAX_COUNT_VAL		0xffff
+
+struct ftm_rtc {
+	struct rtc_device *rtc_dev;
+	void __iomem *base;
+	bool endian;
+	u32 alarm_freq;
+};
+
+static struct ftm_rtc rtc;
+
+static inline u32 ftm_readl(void __iomem *addr)
+{
+	return rtc.endian ? ioread32be(addr) : ioread32(addr);
+}
+
+static inline void ftm_writel(u32 val, void __iomem *addr)
+{
+	return rtc.endian ? iowrite32be(val, addr) : iowrite32(val, addr);
+}
+
+static inline void ftm_counter_enable(bool enabled)
+{
+	u32 val;
+
+	/* select and enable counter clock source */
+	val = ftm_readl(rtc.base + FTM_SC);
+	if (enabled) {
+		val &= ~(FTM_SC_PS_MASK | FTM_SC_CLK_MASK);
+		val |= (FTM_SC_PS_MASK | FTM_SC_CLK(FTM_SC_CLKS_FIXED_FREQ));
+	} else
+		val &= ~(FTM_SC_PS_MASK | FTM_SC_CLK_MASK);
+	ftm_writel(val, rtc.base + FTM_SC);
+}
+
+static int ftm_irq_enable(bool enabled)
+{
+	u32 val;
+
+	val = ftm_readl(rtc.base + FTM_SC);
+	if (enabled)
+		val |= FTM_SC_TOIE;
+	else
+		val &= ~FTM_SC_TOIE;
+	ftm_writel(val, rtc.base + FTM_SC);
+
+	return 0;
+}
+
+static inline void ftm_irq_clear(void)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(100);
+
+	while ((FTM_SC_TOF & ftm_readl(rtc.base + FTM_SC)) &&
+		time_before(jiffies, timeout))
+		ftm_writel(ftm_readl(rtc.base + FTM_SC) & (~FTM_SC_TOF),
+			   rtc.base + FTM_SC);
+}
+
+static void ftm_clean_alarm(void)
+{
+	ftm_counter_enable(false);
+
+	ftm_writel(0x00, rtc.base + FTM_CNTIN);
+	ftm_writel(~0x00, rtc.base + FTM_MOD);
+
+	/*
+	 * The CNT register contains the FTM counter value.
+	 * Reset clears the CNT register. Writing any value to COUNT
+	 * updates the counter with its initial value, CNTIN.
+	 */
+	ftm_writel(0x00, rtc.base + FTM_CNT);
+}
+
+static irqreturn_t ftm_alarm_interrupt(int irq, void *dev_id)
+{
+	rtc_alarm_irq_enable(rtc.rtc_dev, false);
+	ftm_irq_clear();
+	ftm_irq_enable(false);
+	ftm_clean_alarm();
+
+	return IRQ_HANDLED;
+}
+
+static int ftm_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	if (enabled)
+		ftm_irq_enable(true);
+	else
+		ftm_irq_enable(false);
+
+	return 0;
+}
+
+static int nxp_ftm_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct timeval time;
+	unsigned long local_time;
+
+	do_gettimeofday(&time);
+	local_time = (u32)(time.tv_sec - (sys_tz.tz_minuteswest * 60));
+	rtc_time_to_tm(local_time, tm);
+
+	return 0;
+}
+
+/*250Hz, 65536 / 250 = 262 second max*/
+static int nxp_ftm_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
+{
+	struct rtc_time tm;
+	unsigned long now, alm_time, cycle;
+
+	nxp_ftm_rtc_read_time(dev, &tm);
+	rtc_tm_to_time(&tm, &now);
+	rtc_tm_to_time(&alm->time, &alm_time);
+
+	ftm_clean_alarm();
+	cycle = (alm_time - now) * rtc.alarm_freq;
+	if (cycle > MAX_COUNT_VAL) {
+		pr_err("Out of alarm range.\n");
+		return -EINVAL;
+	}
+
+	ftm_irq_enable(false);
+	/*
+	 * The counter increments until the value of MOD is reached,
+	 * at which point the counter is reloaded with the value of CNTIN.
+	 * The TOF (the overflow flag) bit is set when the FTM counter
+	 * changes from MOD to CNTIN. So we should using the cycle - 1.
+	 */
+	ftm_writel(cycle - 1, rtc.base + FTM_MOD);
+
+	ftm_counter_enable(true);
+	ftm_irq_enable(true);
+
+	return 0;
+}
+
+static int nxp_ftm_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
+{
+	return 0;
+}
+
+const struct rtc_class_ops nxp_ftm_rtc_ops = {
+	.read_time	= nxp_ftm_rtc_read_time,
+	.set_alarm	= nxp_ftm_rtc_set_alarm,
+	.read_alarm	= nxp_ftm_rtc_read_alarm,
+	.alarm_irq_enable	= ftm_alarm_irq_enable
+};
+
+static const struct of_device_id nxp_ftm_rtc_of_match[] = {
+	{
+		.compatible	= "fsl,ftm-clock",
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, nxp_ftm_rtc_of_match);
+
+static int nxp_ftm_rtc_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct resource *r;
+	int irq;
+	int ret;
+
+	rtc.alarm_freq = (u32)FIXED_FREQ_CLK / (u32)MAX_FREQ_DIV;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		return -ENODEV;
+
+	rtc.base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(rtc.base))
+		return PTR_ERR(rtc.base);
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (irq <= 0) {
+		pr_err("ftm: unable to get IRQ from DT, %d\n", irq);
+		return -EINVAL;
+	}
+
+	rtc.endian = of_property_read_bool(np, "big-endian");
+
+	ret = devm_request_irq(&pdev->dev, irq, ftm_alarm_interrupt,
+			       IRQF_NO_SUSPEND, dev_name(&pdev->dev), NULL);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to request irq\n");
+		return ret;
+	}
+
+	device_init_wakeup(&pdev->dev, true);
+	rtc.rtc_dev = devm_rtc_device_register(&pdev->dev, "nxp-ftm",
+					       &nxp_ftm_rtc_ops,
+			THIS_MODULE);
+
+	ftm_clean_alarm();
+
+	return ret;
+}
+
+static struct platform_driver nxp_ftm_rtc_driver = {
+	.probe		= nxp_ftm_rtc_probe,
+	.driver		= {
+		.name	= "nxp_ftm_rtc",
+		.of_match_table = nxp_ftm_rtc_of_match,
+	},
+};
+
+module_platform_driver(nxp_ftm_rtc_driver);
+
+MODULE_DESCRIPTION("NXP/Freescale Flextimer RTC Driver");
+MODULE_LICENSE("GPL");
-- 
2.1.0.27.g96db324

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
