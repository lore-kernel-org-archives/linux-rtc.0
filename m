Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:36787 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751791AbdIVDdl (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 21 Sep 2017 23:33:41 -0400
From: <sean.wang@mediatek.com>
To: <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 2/4] rtc: mediatek: add driver for RTC on MT7622 SoC
Date: Fri, 22 Sep 2017 11:33:15 +0800
Message-ID: <5b2a7e5c9c5bc179f89e48fb614b2ae789be4254.1506049341.git.sean.wang@mediatek.com>
In-Reply-To: <cover.1506049341.git.sean.wang@mediatek.com>
References: <cover.1506049341.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

This patch introduces the driver for the RTC on MT7622 SoC.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/rtc/Kconfig        |  10 ++
 drivers/rtc/Makefile       |   1 +
 drivers/rtc/rtc-mediatek.c | 398 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 409 insertions(+)
 create mode 100644 drivers/rtc/rtc-mediatek.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e0e58f3..4226295 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1705,6 +1705,16 @@ config RTC_DRV_MOXART
 	   This driver can also be built as a module. If so, the module
 	   will be called rtc-moxart
 
+config RTC_DRV_MEDIATEK
+	tristate "MediaTek SoC based RTC"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	help
+	  This enables support for the real time clock built in the MediaTek
+	  SoCs.
+
+	  This drive can also be built as a module. If so, the module
+	  will be called rtc-mediatek.
+
 config RTC_DRV_MT6397
 	tristate "Mediatek Real Time Clock driver"
 	depends on MFD_MT6397 || (COMPILE_TEST && IRQ_DOMAIN)
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 7230014..ba0206a 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -101,6 +101,7 @@ obj-$(CONFIG_RTC_DRV_MOXART)	+= rtc-moxart.o
 obj-$(CONFIG_RTC_DRV_MPC5121)	+= rtc-mpc5121.o
 obj-$(CONFIG_RTC_DRV_VRTC)	+= rtc-mrst.o
 obj-$(CONFIG_RTC_DRV_MSM6242)	+= rtc-msm6242.o
+obj-$(CONFIG_RTC_DRV_MEDIATEK)	+= rtc-mediatek.o
 obj-$(CONFIG_RTC_DRV_MT6397)	+= rtc-mt6397.o
 obj-$(CONFIG_RTC_DRV_MV)	+= rtc-mv.o
 obj-$(CONFIG_RTC_DRV_MXC)	+= rtc-mxc.o
diff --git a/drivers/rtc/rtc-mediatek.c b/drivers/rtc/rtc-mediatek.c
new file mode 100644
index 0000000..c6c06fe
--- /dev/null
+++ b/drivers/rtc/rtc-mediatek.c
@@ -0,0 +1,398 @@
+/*
+ * Driver for MediaTek SoC based RTC
+ *
+ * Copyright (C) 2017 Sean Wang <sean.wang@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+
+#define MTK_RTC_DEV KBUILD_MODNAME
+
+#define MTK_RTC_PWRCHK1		0x4
+#define	RTC_PWRCHK1_MAGIC	0xc6
+
+#define MTK_RTC_PWRCHK2		0x8
+#define	RTC_PWRCHK2_MAGIC	0x9a
+
+#define MTK_RTC_KEY		0xc
+#define	RTC_KEY_MAGIC		0x59
+
+#define MTK_RTC_PROT1		0x10
+#define	RTC_PROT1_MAGIC		0xa3
+
+#define MTK_RTC_PROT2		0x14
+#define	RTC_PROT2_MAGIC		0x57
+
+#define MTK_RTC_PROT3		0x18
+#define	RTC_PROT3_MAGIC		0x67
+
+#define MTK_RTC_PROT4		0x1c
+#define	RTC_PROT4_MAGIC		0xd2
+
+#define MTK_RTC_CTL		0x20
+#define	RTC_RC_STOP		BIT(0)
+
+#define MTK_RTC_DEBNCE		0x2c
+#define	RTC_DEBNCE_MASK		GENMASK(2, 0)
+
+#define MTK_RTC_INT		0x30
+#define RTC_INT_AL_STA		BIT(4)
+
+/* Ranges from 0x40 to 0x78 provide RTC time setup for year, month,
+ * day of month, day of week, hour, minute and second.
+ */
+#define MTK_RTC_TREG(_t, _f)	(0x40 + (0x4 * (_f)) + ((_t) * 0x20))
+
+#define MTK_RTC_AL_CTL		0x7c
+#define	RTC_AL_EN		BIT(0)
+#define	RTC_AL_ALL		GENMASK(7, 0)
+
+/* Types of the function the RTC provides are time counter and alarm. */
+enum {
+	MTK_TC,
+	MTK_AL
+};
+
+/* Indexes are used for the pointer to relevant registers in MTK_RTC_TREG */
+enum {
+	MTK_YEA,
+	MTK_MON,
+	MTK_DOM,
+	MTK_DOW,
+	MTK_HOU,
+	MTK_MIN,
+	MTK_SEC
+};
+
+struct mtk_rtc {
+	struct rtc_device *rtc;
+	void __iomem *base;
+	int irq;
+	struct clk *clk;
+};
+
+static void mtk_w32(struct mtk_rtc *rtc, u32 reg, u32 val)
+{
+	__raw_writel(val, rtc->base + reg);
+}
+
+static u32 mtk_r32(struct mtk_rtc *rtc, u32 reg)
+{
+	return __raw_readl(rtc->base + reg);
+}
+
+static void mtk_rmw(struct mtk_rtc *rtc, u32 reg, u32 mask, u32 set)
+{
+	u32 val;
+
+	val = mtk_r32(rtc, reg);
+	val &= ~mask;
+	val |= set;
+	mtk_w32(rtc, reg, val);
+}
+
+static void mtk_set(struct mtk_rtc *rtc, u32 reg, u32 val)
+{
+	mtk_rmw(rtc, reg, 0, val);
+}
+
+static void mtk_clr(struct mtk_rtc *rtc, u32 reg, u32 val)
+{
+	mtk_rmw(rtc, reg, val, 0);
+}
+
+static void mtk_rtc_hw_init(struct mtk_rtc *hw)
+{
+	/* The setup of the init sequence is for allowing RTC got to work */
+	mtk_w32(hw, MTK_RTC_PWRCHK1, RTC_PWRCHK1_MAGIC);
+	mtk_w32(hw, MTK_RTC_PWRCHK2, RTC_PWRCHK2_MAGIC);
+	mtk_w32(hw, MTK_RTC_KEY, RTC_KEY_MAGIC);
+	mtk_w32(hw, MTK_RTC_PROT1, RTC_PROT1_MAGIC);
+	mtk_w32(hw, MTK_RTC_PROT2, RTC_PROT2_MAGIC);
+	mtk_w32(hw, MTK_RTC_PROT3, RTC_PROT3_MAGIC);
+	mtk_w32(hw, MTK_RTC_PROT4, RTC_PROT4_MAGIC);
+	mtk_rmw(hw, MTK_RTC_DEBNCE, RTC_DEBNCE_MASK, 0);
+	mtk_clr(hw, MTK_RTC_CTL, RTC_RC_STOP);
+}
+
+static void mtk_rtc_get_alarm_or_time(struct mtk_rtc *hw, struct rtc_time *tm,
+				      int time_alarm)
+{
+	u32 year, mon, mday, wday, hour, min, sec;
+
+	/*
+	 * Read again until all fields are not changed for all fields in the
+	 * consistent state.
+	 */
+	do {
+		year = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_YEA));
+		mon = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_MON));
+		wday = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_DOW));
+		mday = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_DOM));
+		hour = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_HOU));
+		min = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_MIN));
+		sec = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_SEC));
+	} while (year != mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_YEA)) ||
+		 mon != mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_MON))  ||
+		 mday != mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_DOM))	||
+		 wday != mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_DOW))	||
+		 hour != mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_HOU))	||
+		 min != mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_MIN))	||
+		 sec != mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_SEC))
+		);
+
+	tm->tm_sec  = sec;
+	tm->tm_min  = min;
+	tm->tm_hour = hour;
+	tm->tm_wday = wday;
+	tm->tm_mday = mday;
+	tm->tm_mon  = mon - 1;
+	tm->tm_year = year;
+	tm->tm_year += 100;
+}
+
+static void mtk_rtc_set_alarm_or_time(struct mtk_rtc *hw, struct rtc_time *tm,
+				      int time_alarm)
+{
+	mtk_w32(hw, MTK_RTC_TREG(time_alarm, MTK_YEA), tm->tm_year - 100);
+	mtk_w32(hw, MTK_RTC_TREG(time_alarm, MTK_MON), tm->tm_mon + 1);
+	mtk_w32(hw, MTK_RTC_TREG(time_alarm, MTK_DOW), tm->tm_wday);
+	mtk_w32(hw, MTK_RTC_TREG(time_alarm, MTK_DOM), tm->tm_mday);
+	mtk_w32(hw, MTK_RTC_TREG(time_alarm, MTK_HOU), tm->tm_hour);
+	mtk_w32(hw, MTK_RTC_TREG(time_alarm, MTK_MIN), tm->tm_min);
+	mtk_w32(hw, MTK_RTC_TREG(time_alarm, MTK_SEC), tm->tm_sec);
+}
+
+static irqreturn_t mtk_rtc_alarmirq(int irq, void *id)
+{
+	struct mtk_rtc *hw = (struct mtk_rtc *)id;
+	u32 irq_sta;
+
+	/* Stop alarm also implicitly disable the alarm interrupt */
+	mtk_w32(hw, MTK_RTC_AL_CTL, 0);
+	irq_sta = mtk_r32(hw, MTK_RTC_INT);
+	if (irq_sta & RTC_INT_AL_STA) {
+		rtc_update_irq(hw->rtc, 1, RTC_IRQF | RTC_AF);
+
+		/* Ack alarm interrupt status */
+		mtk_w32(hw, MTK_RTC_INT, RTC_INT_AL_STA);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int mtk_rtc_gettime(struct device *dev, struct rtc_time *tm)
+{
+	struct mtk_rtc *hw = dev_get_drvdata(dev);
+
+	mtk_rtc_get_alarm_or_time(hw, tm, MTK_TC);
+
+	return rtc_valid_tm(tm);
+}
+
+static int mtk_rtc_settime(struct device *dev, struct rtc_time *tm)
+{
+	struct mtk_rtc *hw = dev_get_drvdata(dev);
+
+	/* Stop time counter before setting a new one*/
+	mtk_set(hw, MTK_RTC_CTL, RTC_RC_STOP);
+
+	/* Epoch == 1900 */
+	if (tm->tm_year < 100 || tm->tm_year > 199)
+		return -EINVAL;
+
+	mtk_rtc_set_alarm_or_time(hw, tm, MTK_TC);
+
+	/* Restart the time counter */
+	mtk_clr(hw, MTK_RTC_CTL, RTC_RC_STOP);
+
+	return 0;
+}
+
+static int mtk_rtc_getalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
+{
+	struct mtk_rtc *hw = dev_get_drvdata(dev);
+	struct rtc_time *alrm_tm = &wkalrm->time;
+
+	mtk_rtc_get_alarm_or_time(hw, alrm_tm, MTK_AL);
+
+	wkalrm->enabled = !!(mtk_r32(hw, MTK_RTC_AL_CTL) & RTC_AL_EN);
+	wkalrm->pending = !!(mtk_r32(hw, MTK_RTC_INT) & RTC_INT_AL_STA);
+
+	return 0;
+}
+
+static int mtk_rtc_setalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
+{
+	struct mtk_rtc *hw = dev_get_drvdata(dev);
+	struct rtc_time *alrm_tm = &wkalrm->time;
+
+	/* Epoch == 1900 */
+	if (alrm_tm->tm_year < 100 || alrm_tm->tm_year > 199)
+		return -EINVAL;
+
+	/*
+	 * Stop the alarm also implicitly including disables interrupt before
+	 * setting a new one.
+	 */
+	mtk_clr(hw, MTK_RTC_AL_CTL, RTC_AL_EN);
+
+	/*
+	 * Avoid contention between mtk_rtc_setalarm and IRQ handler so that
+	 * disabling the interrupt and awaiting for pending IRQ handler to
+	 * complete.
+	 */
+	synchronize_irq(hw->irq);
+
+	mtk_rtc_set_alarm_or_time(hw, alrm_tm, MTK_AL);
+
+	/* Restart the alarm with the new setup */
+	mtk_w32(hw, MTK_RTC_AL_CTL, RTC_AL_ALL);
+
+	return 0;
+}
+
+static const struct rtc_class_ops mtk_rtc_ops = {
+	.read_time		= mtk_rtc_gettime,
+	.set_time		= mtk_rtc_settime,
+	.read_alarm		= mtk_rtc_getalarm,
+	.set_alarm		= mtk_rtc_setalarm,
+};
+
+static const struct of_device_id mtk_rtc_match[] = {
+	{ .compatible = "mediatek,mt7622-rtc" },
+	{ .compatible = "mediatek,soc-rtc" },
+	{},
+};
+
+static int mtk_rtc_probe(struct platform_device *pdev)
+{
+	struct mtk_rtc *hw;
+	struct resource *res;
+	int ret;
+
+	hw = devm_kzalloc(&pdev->dev, sizeof(*hw), GFP_KERNEL);
+	if (!hw)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, hw);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	hw->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(hw->base))
+		return PTR_ERR(hw->base);
+
+	hw->clk = devm_clk_get(&pdev->dev, "rtc");
+	if (IS_ERR(hw->clk)) {
+		dev_err(&pdev->dev, "No clock\n");
+		return PTR_ERR(hw->clk);
+	}
+
+	ret = clk_prepare_enable(hw->clk);
+	if (ret)
+		return ret;
+
+	hw->irq = platform_get_irq(pdev, 0);
+	if (hw->irq < 0) {
+		dev_err(&pdev->dev, "No IRQ resource\n");
+		ret = hw->irq;
+		goto err;
+	}
+
+	ret = devm_request_irq(&pdev->dev, hw->irq, mtk_rtc_alarmirq,
+			       0, dev_name(&pdev->dev), hw);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't request IRQ\n");
+		goto err;
+	}
+
+	mtk_rtc_hw_init(hw);
+
+	device_init_wakeup(&pdev->dev, true);
+
+	hw->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
+					   &mtk_rtc_ops, THIS_MODULE);
+	if (IS_ERR(hw->rtc)) {
+		ret = PTR_ERR(hw->rtc);
+		dev_err(&pdev->dev, "Unable to register device\n");
+		goto err;
+	}
+
+	dev_info(&pdev->dev, "MediaTek SoC based RTC enabled\n");
+
+	return 0;
+err:
+	clk_disable_unprepare(hw->clk);
+
+	return ret;
+}
+
+static int mtk_rtc_remove(struct platform_device *pdev)
+{
+	struct mtk_rtc *hw = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(hw->clk);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int mtk_rtc_suspend(struct device *dev)
+{
+	struct mtk_rtc *hw = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(hw->irq);
+
+	return 0;
+}
+
+static int mtk_rtc_resume(struct device *dev)
+{
+	struct mtk_rtc *hw = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(hw->irq);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(mtk_rtc_pm_ops, mtk_rtc_suspend, mtk_rtc_resume);
+
+#define MTK_RTC_PM_OPS (&mtk_rtc_pm_ops)
+#else	/* CONFIG_PM */
+#define MTK_RTC_PM_OPS NULL
+#endif	/* CONFIG_PM */
+
+static struct platform_driver mtk_rtc_driver = {
+	.probe	= mtk_rtc_probe,
+	.remove	= mtk_rtc_remove,
+	.driver = {
+		.name = MTK_RTC_DEV,
+		.of_match_table = mtk_rtc_match,
+		.pm = MTK_RTC_PM_OPS,
+	},
+};
+
+module_platform_driver(mtk_rtc_driver);
+
+MODULE_DESCRIPTION("MediaTek SoC based RTC Driver");
+MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
+MODULE_LICENSE("GPL");
-- 
2.7.4
