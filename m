Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mx2.rt-rk.com ([89.216.37.149]:59579 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751267AbdHRNLu (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 18 Aug 2017 09:11:50 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: linux-mips@linux-mips.org
Cc: Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Bo Hu <bohu@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4 2/8] rtc: goldfish: Add RTC driver for Android emulator
Date: Fri, 18 Aug 2017 15:08:54 +0200
Message-Id: <1503061833-26563-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1503061833-26563-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1503061833-26563-1-git-send-email-aleksandar.markovic@rt-rk.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Miodrag Dinic <miodrag.dinic@imgtec.com>

Add device driver for a virtual RTC device in Android emulator.

The compatible string used by OS for binding the driver is defined
as "google,goldfish-rtc".

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 MAINTAINERS                |   1 +
 drivers/rtc/Kconfig        |   8 ++
 drivers/rtc/Makefile       |   1 +
 drivers/rtc/rtc-goldfish.c | 237 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 247 insertions(+)
 create mode 100644 drivers/rtc/rtc-goldfish.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f64c81b..3d105be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -844,6 +844,7 @@ ANDROID GOLDFISH RTC DRIVER
 M:	Miodrag Dinic <miodrag.dinic@imgtec.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
+F:	drivers/rtc/rtc-goldfish.c
 
 ANDROID ION DRIVER
 M:	Laura Abbott <labbott@redhat.com>
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 72419ac..0101dba 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1780,5 +1780,13 @@ config RTC_DRV_HID_SENSOR_TIME
 	  If this driver is compiled as a module, it will be named
 	  rtc-hid-sensor-time.
 
+config RTC_DRV_GOLDFISH
+	tristate "Goldfish Real Time Clock"
+	depends on MIPS && (GOLDFISH || COMPILE_TEST)
+	help
+	  Say yes to enable RTC driver for the Goldfish based virtual platform.
+
+	  Goldfish is a code name for the virtual platform developed by Google
+	  for Android emulation.
 
 endif # RTC_CLASS
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index acd366b..d995d49 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -170,3 +170,4 @@ obj-$(CONFIG_RTC_DRV_WM8350)	+= rtc-wm8350.o
 obj-$(CONFIG_RTC_DRV_X1205)	+= rtc-x1205.o
 obj-$(CONFIG_RTC_DRV_XGENE)	+= rtc-xgene.o
 obj-$(CONFIG_RTC_DRV_ZYNQMP)	+= rtc-zynqmp.o
+obj-$(CONFIG_RTC_DRV_GOLDFISH)	+= rtc-goldfish.o
diff --git a/drivers/rtc/rtc-goldfish.c b/drivers/rtc/rtc-goldfish.c
new file mode 100644
index 0000000..d677692
--- /dev/null
+++ b/drivers/rtc/rtc-goldfish.c
@@ -0,0 +1,237 @@
+/* drivers/rtc/rtc-goldfish.c
+ *
+ * Copyright (C) 2007 Google, Inc.
+ * Copyright (C) 2017 Imagination Technologies Ltd.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+#include <linux/io.h>
+
+#define TIMER_TIME_LOW		0x00	/* get low bits of current time  */
+					/*   and update TIMER_TIME_HIGH  */
+#define TIMER_TIME_HIGH	0x04	/* get high bits of time at last */
+					/*   TIMER_TIME_LOW read         */
+#define TIMER_ALARM_LOW	0x08	/* set low bits of alarm and     */
+					/*   activate it                 */
+#define TIMER_ALARM_HIGH	0x0c	/* set high bits of next alarm   */
+#define TIMER_IRQ_ENABLED	0x10
+#define TIMER_CLEAR_ALARM	0x14
+#define TIMER_ALARM_STATUS	0x18
+#define TIMER_CLEAR_INTERRUPT	0x1c
+
+struct goldfish_rtc {
+	void __iomem *base;
+	int irq;
+	struct rtc_device *rtc;
+};
+
+static int goldfish_rtc_read_alarm(struct device *dev,
+				   struct rtc_wkalrm *alrm)
+{
+	u64 rtc_alarm;
+	u64 rtc_alarm_low;
+	u64 rtc_alarm_high;
+	void __iomem *base;
+	struct goldfish_rtc *rtcdrv;
+
+	rtcdrv = dev_get_drvdata(dev);
+	base = rtcdrv->base;
+
+	rtc_alarm_low = readl(base + TIMER_ALARM_LOW);
+	rtc_alarm_high = readl(base + TIMER_ALARM_HIGH);
+	rtc_alarm = (rtc_alarm_high << 32) | rtc_alarm_low;
+
+	do_div(rtc_alarm, NSEC_PER_SEC);
+	memset(alrm, 0, sizeof(struct rtc_wkalrm));
+
+	rtc_time_to_tm(rtc_alarm, &alrm->time);
+
+	if (readl(base + TIMER_ALARM_STATUS))
+		alrm->enabled = 1;
+	else
+		alrm->enabled = 0;
+
+	return 0;
+}
+
+static int goldfish_rtc_set_alarm(struct device *dev,
+				  struct rtc_wkalrm *alrm)
+{
+	struct goldfish_rtc *rtcdrv;
+	unsigned long rtc_alarm;
+	u64 rtc_alarm64;
+	u64 rtc_status_reg;
+	void __iomem *base;
+	int ret = 0;
+
+	rtcdrv = dev_get_drvdata(dev);
+	base = rtcdrv->base;
+
+	if (alrm->enabled) {
+		ret = rtc_tm_to_time(&alrm->time, &rtc_alarm);
+		if (ret != 0)
+			return ret;
+
+		rtc_alarm64 = rtc_alarm * NSEC_PER_SEC;
+		writel((rtc_alarm64 >> 32), base + TIMER_ALARM_HIGH);
+		writel(rtc_alarm64, base + TIMER_ALARM_LOW);
+	} else {
+		/*
+		 * if this function was called with enabled=0
+		 * then it could mean that the application is
+		 * trying to cancel an ongoing alarm
+		 */
+		rtc_status_reg = readl(base + TIMER_ALARM_STATUS);
+		if (rtc_status_reg)
+			writel(1, base + TIMER_CLEAR_ALARM);
+	}
+
+	return ret;
+}
+
+static int goldfish_rtc_alarm_irq_enable(struct device *dev,
+					 unsigned int enabled)
+{
+	void __iomem *base;
+	struct goldfish_rtc *rtcdrv;
+
+	rtcdrv = dev_get_drvdata(dev);
+	base = rtcdrv->base;
+
+	if (enabled)
+		writel(1, base + TIMER_IRQ_ENABLED);
+	else
+		writel(0, base + TIMER_IRQ_ENABLED);
+
+	return 0;
+}
+
+static irqreturn_t goldfish_rtc_interrupt(int irq, void *dev_id)
+{
+	struct goldfish_rtc *rtcdrv = dev_id;
+	void __iomem *base = rtcdrv->base;
+
+	writel(1, base + TIMER_CLEAR_INTERRUPT);
+
+	rtc_update_irq(rtcdrv->rtc, 1, RTC_IRQF | RTC_AF);
+
+	return IRQ_HANDLED;
+}
+
+static int goldfish_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct goldfish_rtc *rtcdrv;
+	void __iomem *base;
+	u64 time_high;
+	u64 time_low;
+	u64 time;
+
+	rtcdrv = dev_get_drvdata(dev);
+	base = rtcdrv->base;
+
+	time_low = readl(base + TIMER_TIME_LOW);
+	time_high = readl(base + TIMER_TIME_HIGH);
+	time = (time_high << 32) | time_low;
+
+	do_div(time, NSEC_PER_SEC);
+
+	rtc_time_to_tm(time, tm);
+
+	return 0;
+}
+
+static int goldfish_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct goldfish_rtc *rtcdrv;
+	void __iomem *base;
+	unsigned long now;
+	u64 now64;
+	int ret;
+
+	rtcdrv = dev_get_drvdata(dev);
+	base = rtcdrv->base;
+
+	ret = rtc_tm_to_time(tm, &now);
+	if (ret == 0) {
+		now64 = now * NSEC_PER_SEC;
+		writel((now64 >> 32), base + TIMER_TIME_HIGH);
+		writel(now64, base + TIMER_TIME_LOW);
+	}
+
+	return ret;
+}
+
+static const struct rtc_class_ops goldfish_rtc_ops = {
+	.read_time	= goldfish_rtc_read_time,
+	.set_time	= goldfish_rtc_set_time,
+	.read_alarm	= goldfish_rtc_read_alarm,
+	.set_alarm	= goldfish_rtc_set_alarm,
+	.alarm_irq_enable = goldfish_rtc_alarm_irq_enable
+};
+
+static int goldfish_rtc_probe(struct platform_device *pdev)
+{
+	struct goldfish_rtc *rtcdrv;
+	struct resource *r;
+	int err;
+
+	rtcdrv = devm_kzalloc(&pdev->dev, sizeof(*rtcdrv), GFP_KERNEL);
+	if (!rtcdrv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, rtcdrv);
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		return -ENODEV;
+
+	rtcdrv->base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(rtcdrv->base))
+		return -ENODEV;
+
+	rtcdrv->irq = platform_get_irq(pdev, 0);
+	if (rtcdrv->irq < 0)
+		return -ENODEV;
+
+	rtcdrv->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
+					       &goldfish_rtc_ops,
+					       THIS_MODULE);
+	if (IS_ERR(rtcdrv->rtc))
+		return PTR_ERR(rtcdrv->rtc);
+
+	err = devm_request_irq(&pdev->dev, rtcdrv->irq,
+			       goldfish_rtc_interrupt,
+			       0, pdev->name, rtcdrv);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static const struct of_device_id goldfish_rtc_of_match[] = {
+	{ .compatible = "google,goldfish-rtc", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, goldfish_rtc_of_match);
+
+static struct platform_driver goldfish_rtc = {
+	.probe = goldfish_rtc_probe,
+	.driver = {
+		.name = "goldfish_rtc",
+		.of_match_table = goldfish_rtc_of_match,
+	}
+};
+
+module_platform_driver(goldfish_rtc);
-- 
2.7.4
