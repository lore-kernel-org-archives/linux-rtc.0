Return-Path: <rtc-linux+bncBCEPJZEDQIBBBBOMSS6AKGQE643C2DY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from rainbowdash.ducie.codethink.co.uk (82-70-136-246.dsl.in-addr.zen.co.uk. [82.70.136.246])
        by gmr-mx.google.com with ESMTPS id o10si150149wme.0.2016.07.12.10.16.53
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jul 2016 10:16:53 -0700 (PDT)
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-kernel@lists.codethink.co.uk,
	linux-amlogic@lists.infradead.org,
	rtc-linux@googlegroups.com
Cc: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	devicetree@vger.kernel.org,
	narmstrong@baylibre.com,
	khilman@baylibre.com,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [rtc-linux] [PATCH v4 1/2] rtc: support for amlogic meson rtc
Date: Tue, 12 Jul 2016 18:16:38 +0100
Message-Id: <1468343799-12844-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1468343799-12844-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1468343799-12844-1-git-send-email-ben.dooks@codethink.co.uk>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Add support for the AMLogic meson8b/meson6 RTC block.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Tested-by: Kevin Hilman <khilman@baylibre.com>
---
V4:
- Added Kevin Hilman's tested-by
V3..V1:
 - Fixed alpha-ordering in Kconfig
 - Fixed checkpatch errors
 - Added basic driver information
 - Re-organised static-register access functions above rtc driver layer

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/rtc/Kconfig     |   9 ++
 drivers/rtc/Makefile    |   1 +
 drivers/rtc/rtc-meson.c | 349 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 359 insertions(+)
 create mode 100644 drivers/rtc/rtc-meson.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 18639e0..6f4097e 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1181,6 +1181,15 @@ config RTC_DRV_ASM9260
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-asm9260.
 
+config RTC_DRV_MESON
+	tristate "AMLogic Meson Real Time Clock"
+	depends on ARCH_MESON || COMPILE_TEST
+	help
+	   Support for AMLogic Meson RTC block.
+
+	   This driver can also be built as a module, if so, the module
+	   will be called "rtc-meson".
+
 config RTC_DRV_DAVINCI
 	tristate "TI DaVinci RTC"
 	depends on ARCH_DAVINCI_DM365 || COMPILE_TEST
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index ea28337..0b4f106 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_RTC_DRV_MAX8997)	+= rtc-max8997.o
 obj-$(CONFIG_RTC_DRV_MAX8998)	+= rtc-max8998.o
 obj-$(CONFIG_RTC_DRV_MC13XXX)	+= rtc-mc13xxx.o
 obj-$(CONFIG_RTC_DRV_MCP795)	+= rtc-mcp795.o
+obj-$(CONFIG_RTC_DRV_MESON)	+= rtc-meson.o
 obj-$(CONFIG_RTC_DRV_MOXART)	+= rtc-moxart.o
 obj-$(CONFIG_RTC_DRV_MPC5121)	+= rtc-mpc5121.o
 obj-$(CONFIG_RTC_DRV_VRTC)	+= rtc-mrst.o
diff --git a/drivers/rtc/rtc-meson.c b/drivers/rtc/rtc-meson.c
new file mode 100644
index 0000000..b40b0c9
--- /dev/null
+++ b/drivers/rtc/rtc-meson.c
@@ -0,0 +1,349 @@
+/* drivers/rtc/rtc-meson.c
+ *
+ * RTC driver for the interal RTC block in the AMlogic SoCs.
+ *
+ * The RTC is split in to two parts, the AHB front end and a simple serial
+ * connection to the actual registers. This driver manages both parts.
+ *
+ * Copyright (c) 2015 Codethink Ltd
+ *	 Ben Dooks <ben.dooks@codethink.co.uk>
+ * Based on origin by Carlo Caione <carlo@endlessm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/reset.h>
+#include <linux/rtc.h>
+#include <linux/io.h>
+#include <linux/of.h>
+
+/* registers accessed from cpu bus */
+#define RTC_REG(x)		((x) * 4)	/* rtc registers 0-4 */
+
+#define LINE_SDI		(1 << 2)
+#define LINE_SEN		(1 << 1)
+#define LINE_SCLK		(1 << 0)
+
+#define RTCREG0_START_SER	BIT(17)
+#define RTCREG0_WAIT_SER	BIT(22)
+#define RTC_REG0_DATA(__data)	((__data) << 24)
+
+#define RTCREG1_READY		BIT(1)
+
+/* rtc registers accessed via rtc-serial interface */
+#define RTC_COUNTER		(0)
+#define RTC_SEC_ADJ		(2)
+
+#define RTC_ADDR_BITS		(3)	/* number of address bits to send */
+#define RTC_DATA_BITS		(32)	/* number of data bits to tx/rx */
+
+#define MESON_STATIC_BIAS_CUR	(0x5 << 1)
+#define MESON_STATIC_VOLTAGE	(0x3 << 11)
+#define MESON_STATIC_DEFAULT    (MESON_STATIC_BIAS_CUR | MESON_STATIC_VOLTAGE)
+
+struct meson_rtc {
+	struct rtc_device	*rtc;	/* rtc device we created */
+	struct device		*dev;	/* device we bound from */
+	struct reset_control	*reset;	/* reset source */
+	struct mutex		lock;	/* rtc lock */
+	void __iomem		*regs;	/* rtc register access */
+};
+
+/* RTC front-end serialiser controls */
+
+static void meson_rtc_setline(struct meson_rtc *rtc,
+			      unsigned int bit, unsigned int to)
+{
+	u32 reg0;
+
+	reg0 = readl(rtc->regs + RTC_REG(0));
+	if (to)
+		reg0 |= bit;
+	else
+		reg0 &= ~bit;
+	writel(reg0, rtc->regs + RTC_REG(0));
+}
+
+static void meson_rtc_sclk_pulse(struct meson_rtc *rtc)
+{
+	udelay(5);
+	meson_rtc_setline(rtc, LINE_SCLK, 0);
+	udelay(5);
+	meson_rtc_setline(rtc, LINE_SCLK, 1);
+}
+
+static void meson_rtc_send_bit(struct meson_rtc *rtc, unsigned int bit)
+{
+	meson_rtc_setline(rtc, LINE_SDI, bit ? 1 : 0);
+	meson_rtc_sclk_pulse(rtc);
+}
+
+static void meson_rtc_send_bits(struct meson_rtc *rtc,
+				u32 data, unsigned int nr)
+{
+	u32 bit = 1 << (nr - 1);
+
+	while (bit) {
+		meson_rtc_send_bit(rtc, data & bit);
+		bit >>= 1;
+	}
+}
+
+static void meson_rtc_set_dir(struct meson_rtc *rtc, u32 mode)
+{
+	meson_rtc_setline(rtc, LINE_SEN, 0);
+	meson_rtc_setline(rtc, LINE_SDI, 0);
+	meson_rtc_send_bit(rtc, mode);
+	meson_rtc_setline(rtc, LINE_SDI, 0);
+}
+
+static u32 meson_rtc_read_sdo(struct meson_rtc *rtc)
+{
+	return readl(rtc->regs + RTC_REG(1)) & BIT(0);
+}
+
+static u32 meson_rtc_get_data(struct meson_rtc *rtc)
+{
+	u32 val = 0;
+	int bit;
+
+	for (bit = 0; bit < RTC_DATA_BITS; bit++) {
+		meson_rtc_sclk_pulse(rtc);
+		val <<= 1;
+		val |= meson_rtc_read_sdo(rtc);
+	}
+
+	return val;
+}
+
+static int meson_rtc_wait_bus(struct meson_rtc *rtc, unsigned int timeout_ms)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
+	u32 val;
+
+	while (time_before(jiffies, timeout)) {
+		val = readl(rtc->regs + RTC_REG(1));
+		if (val & RTCREG1_READY)
+			return 1;
+
+		dev_dbg(rtc->dev, "%s: reg0=%08x reg1=%08x\n",
+			__func__, readl(rtc->regs + RTC_REG(0)), val);
+		msleep(10);
+	}
+
+	return 0;
+}
+
+static int meson_rtc_get_bus(struct meson_rtc *rtc)
+{
+	int ret, retries = 3;
+	u32 val;
+
+	/* prepare bus for transfers, set all lines low */
+	val = readl(rtc->regs + RTC_REG(0));
+	val &= ~(LINE_SDI | LINE_SEN | LINE_SCLK);
+	writel(val, rtc->regs + RTC_REG(0));
+
+	while (retries) {
+		if (meson_rtc_wait_bus(rtc, 300))
+			return 0;
+
+		dev_warn(rtc->dev, "failed to get bus, re-setting\n");
+
+		retries--;
+		ret = reset_control_reset(rtc->reset);
+		if (ret)
+			return ret;
+	}
+
+	dev_err(rtc->dev, "%s: bus is not ready\n", __func__);
+	return -ETIMEDOUT;
+}
+
+static int meson_rtc_read(struct meson_rtc *rtc, unsigned int reg, u32 *data)
+{
+	int ret;
+
+	ret = meson_rtc_get_bus(rtc);
+	if (ret)
+		return ret;
+
+	meson_rtc_setline(rtc, LINE_SEN, 1);
+	meson_rtc_send_bits(rtc, reg, RTC_ADDR_BITS);
+	meson_rtc_set_dir(rtc, 0);
+	*data = meson_rtc_get_data(rtc);
+
+	return 0;
+}
+
+static int meson_rtc_write(struct meson_rtc *rtc, unsigned int reg, u32 data)
+{
+	int ret;
+
+	dev_dbg(rtc->dev, "%s: reg %d val %08x)\n", __func__, reg, data);
+
+	ret = meson_rtc_get_bus(rtc);
+	if (ret)
+		return ret;
+
+	meson_rtc_setline(rtc, LINE_SEN, 1);
+	meson_rtc_send_bits(rtc, data, RTC_DATA_BITS);
+	meson_rtc_send_bits(rtc, reg, RTC_ADDR_BITS);
+	meson_rtc_set_dir(rtc, 1);
+
+	return 0;
+}
+
+static int meson_rtc_wait_serialiser(struct meson_rtc *rtc)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(100);
+
+	while (time_before(jiffies, timeout)) {
+		if (!(readl(rtc->regs + RTC_REG(0)) & RTCREG0_WAIT_SER))
+			return 0;
+		msleep(10);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int meson_rtc_write_static(struct meson_rtc *rtc, u32 data)
+{
+	u32 tmp;
+	int ret = 0;
+
+	mutex_lock(&rtc->lock);
+
+	writel(data >> 8, rtc->regs + RTC_REG(4));
+
+	tmp = readl(rtc->regs + RTC_REG(0));
+	tmp &= ~RTC_REG0_DATA(0xff);
+	tmp |= RTC_REG0_DATA(data);
+	tmp |= RTCREG0_START_SER;
+	writel(tmp, rtc->regs + RTC_REG(0));
+
+	if (meson_rtc_wait_serialiser(rtc))
+		ret = -ETIMEDOUT;
+
+	dev_dbg(rtc->dev, "%s: ret=%d, rtc_reg0 = %08x\n",
+		__func__, ret, readl(rtc->regs + RTC_REG(0)));
+	mutex_unlock(&rtc->lock);
+
+	return ret;
+}
+
+/* RTC interface layer functions */
+
+static int meson_rtc_gettime(struct device *dev, struct rtc_time *tm)
+{
+	struct meson_rtc *rtc = dev_get_drvdata(dev);
+	int ret;
+	u32 time;
+
+	mutex_lock(&rtc->lock);
+
+	ret = meson_rtc_read(rtc, RTC_COUNTER, &time);
+	if (!ret) {
+		rtc_time_to_tm(time, tm);
+		dev_dbg(dev, "read time %lu\n", (unsigned long)time);
+	}
+
+	mutex_unlock(&rtc->lock);
+	return ret;
+}
+
+static int meson_rtc_settime(struct device *dev, struct rtc_time *tm)
+{
+	struct meson_rtc *rtc = dev_get_drvdata(dev);
+	unsigned long time;
+	int ret;
+
+	mutex_lock(&rtc->lock);
+
+	rtc_tm_to_time(tm, &time);
+	ret = meson_rtc_write(rtc, RTC_COUNTER, time);
+
+	mutex_unlock(&rtc->lock);
+	return ret;
+}
+
+static const struct rtc_class_ops meson_rtc_ops = {
+	.read_time	= meson_rtc_gettime,
+	.set_time	= meson_rtc_settime,
+};
+
+static int meson_rtc_probe(struct platform_device *pdev)
+{
+	struct meson_rtc *rtc;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	u32 tm;
+	int ret;
+
+	rtc = devm_kzalloc(dev, sizeof(struct meson_rtc), GFP_KERNEL);
+	if (!rtc)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	rtc->regs = devm_ioremap_resource(dev, res);
+	rtc->dev = dev;
+
+	if (IS_ERR(rtc->regs))
+		return PTR_ERR(rtc->regs);
+
+	mutex_init(&rtc->lock);
+	platform_set_drvdata(pdev, rtc);
+
+	ret = meson_rtc_write_static(rtc, MESON_STATIC_DEFAULT);
+	if (ret) {
+		dev_err(dev, "failed to set static values\n");
+		return ret;
+	}
+
+	rtc->reset = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(rtc->reset))
+		dev_warn(dev, "no reset available, rtc may not work\n");
+
+	/* check if we can read RTC counter, if not then the RTC is probably
+	 * not functional. If it isn't probably best to not bind.
+	 */
+	ret = meson_rtc_read(rtc, RTC_COUNTER, &tm);
+	if (ret) {
+		dev_err(dev, "cannot read RTC counter, RTC not functional\n");
+		return ret;
+	}
+
+	rtc->rtc = devm_rtc_device_register(dev, "meson",
+					    &meson_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc->rtc))
+		return PTR_ERR(rtc->rtc);
+
+	return 0;
+}
+
+static const struct of_device_id meson_rtc_dt_match[] = {
+	{ .compatible = "amlogic,meson6-rtc", },
+	{ .compatible = "amlogic,meson8-rtc", },
+	{ .compatible = "amlogic,meson8b-rtc", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, meson_rtc_dt_match);
+
+static struct platform_driver meson_rtc_driver = {
+	.probe		= meson_rtc_probe,
+	.driver		= {
+		.name	= "meson-rtc",
+		.of_match_table	= of_match_ptr(meson_rtc_dt_match),
+	},
+};
+module_platform_driver(meson_rtc_driver);
+
+MODULE_DESCRIPTION("AMLogic MESON RTC Driver");
+MODULE_AUTHOR("Ben Dooks <ben.doosk@codethink.co.uk>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:meson-rtc");
-- 
2.8.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
