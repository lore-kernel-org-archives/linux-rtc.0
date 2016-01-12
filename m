Return-Path: <rtc-linux+bncBD2OLRXW4ABBBUUO2O2AKGQEGM3KITI@googlegroups.com>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com. [216.228.121.143])
        by gmr-mx.google.com with ESMTPS id a76si2337836pfj.2.2016.01.12.01.28.50
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2016 01:28:50 -0800 (PST)
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
Subject: [rtc-linux] [PATCH V2 5/6] rtc: max77xxx: add RTC driver for Maxim
 MAX77xxx series RTC IP
Date: Tue, 12 Jan 2016 14:47:52 +0530
Message-ID: <1452590273-16421-6-git-send-email-ldewangan@nvidia.com>
In-Reply-To: <1452590273-16421-1-git-send-email-ldewangan@nvidia.com>
References: <1452590273-16421-1-git-send-email-ldewangan@nvidia.com>
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

Maxim Semiconductor's PMIC MAX77620, MAX77686, MAX20024 have
same RTC IP on these PMICs.

Add generic MAX77xxxx series RTC driver which can be used as
RTC driver for these PMIC and avoids duplication of RTC driver
for each PMICs. Their MFD driver can be different here.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Changes from V1: 
- Rename the file to rtc-max77xxx.c and make the generic implementation.
- Direct regmap apis are used for the register access.
- Decouped from max77620 driver.
- Taken care of cleanup comments form V1 version.

 drivers/rtc/Kconfig        |  10 +
 drivers/rtc/Makefile       |   1 +
 drivers/rtc/rtc-max77xxx.c | 500 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 511 insertions(+)
 create mode 100644 drivers/rtc/rtc-max77xxx.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 376322f..4972dd5 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -315,6 +315,16 @@ config RTC_DRV_MAX8997
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-max8997.
 
+config RTC_DRV_MAX77XXX
+	tristate "Maxim MAX77XXX series generic RTC driver"
+	help
+	  If you say yes here you will get support for the generic RTC driver
+	  for Maxim Semiconductor MAX77XXX series of PMIC like MAX77620.
+	  This also supports the RTC driver for Maxim PMIC MaX20024 which
+	  is almost same as MAX77620.
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-max77xxx.
+
 config RTC_DRV_MAX77686
 	tristate "Maxim MAX77686"
 	depends on MFD_MAX77686
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 62d61b2..e5aba30 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_RTC_DRV_M48T59)	+= rtc-m48t59.o
 obj-$(CONFIG_RTC_DRV_M48T86)	+= rtc-m48t86.o
 obj-$(CONFIG_RTC_DRV_MAX6900)	+= rtc-max6900.o
 obj-$(CONFIG_RTC_DRV_MAX6902)	+= rtc-max6902.o
+obj-$(CONFIG_RTC_DRV_MAX77XXX)	+= rtc-max77xxx.o
 obj-$(CONFIG_RTC_DRV_MAX77686)	+= rtc-max77686.o
 obj-$(CONFIG_RTC_DRV_MAX77802)	+= rtc-max77802.o
 obj-$(CONFIG_RTC_DRV_MAX8907)	+= rtc-max8907.o
diff --git a/drivers/rtc/rtc-max77xxx.c b/drivers/rtc/rtc-max77xxx.c
new file mode 100644
index 0000000..c5ada63
--- /dev/null
+++ b/drivers/rtc/rtc-max77xxx.c
@@ -0,0 +1,500 @@
+/*
+ * Max77xxx(MAX77620, MAX77686 etc) RTC driver
+ *
+ * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/regmap.h>
+#include <linux/rtc.h>
+
+/* RTC Registers */
+#define MAX77XXX_REG_RTCINT			0x00
+#define MAX77XXX_REG_RTCINTM			0x01
+#define MAX77XXX_REG_RTCCNTLM			0x02
+#define MAX77XXX_REG_RTCCNTL			0x03
+#define MAX77XXX_REG_RTCUPDATE0			0x04
+#define MAX77XXX_REG_RTCUPDATE1			0x05
+#define MAX77XXX_REG_RTCSMPL			0x06
+#define MAX77XXX_REG_RTCSEC			0x07
+#define MAX77XXX_REG_RTCMIN			0x08
+#define MAX77XXX_REG_RTCHOUR			0x09
+#define MAX77XXX_REG_RTCDOW			0x0A
+#define MAX77XXX_REG_RTCMONTH			0x0B
+#define MAX77XXX_REG_RTCYEAR			0x0C
+#define MAX77XXX_REG_RTCDOM			0x0D
+#define MAX77XXX_REG_RTCSECA1			0x0E
+#define MAX77XXX_REG_RTCMINA1			0x0F
+#define MAX77XXX_REG_RTCHOURA1			0x10
+#define MAX77XXX_REG_RTCDOWA1			0x11
+#define MAX77XXX_REG_RTCMONTHA1			0x12
+#define MAX77XXX_REG_RTCYEARA1			0x13
+#define MAX77XXX_REG_RTCDOMA1			0x14
+#define MAX77XXX_REG_RTCSECA2			0x15
+#define MAX77XXX_REG_RTCMINA2			0x16
+#define MAX77XXX_REG_RTCHOURA2			0x17
+#define MAX77XXX_REG_RTCDOWA2			0x18
+#define MAX77XXX_REG_RTCMONTHA2			0x19
+#define MAX77XXX_REG_RTCYEARA2			0x1A
+#define MAX77XXX_REG_RTCDOMA2			0x1B
+
+#define MAX77XXX_RTC60S_MASK			BIT(0)
+#define MAX77XXX_RTCA1_MASK			BIT(1)
+#define MAX77XXX_RTCA2_MASK			BIT(2)
+#define MAX77XXX_RTC_SMPL_MASK			BIT(3)
+#define MAX77XXX_RTC_RTC1S_MASK			BIT(4)
+#define MAX77XXX_RTC_ALL_IRQ_MASK		0x1F
+
+#define MAX77XXX_BCDM_MASK			BIT(0)
+#define MAX77XXX_HRMODEM_MASK			BIT(1)
+
+#define WB_UPDATE_MASK				BIT(0)
+#define FLAG_AUTO_CLEAR_MASK			BIT(1)
+#define FREEZE_SEC_MASK				BIT(2)
+#define RTC_WAKE_MASK				BIT(3)
+#define RB_UPDATE_MASK				BIT(4)
+
+#define MAX77XXX_UDF_MASK			BIT(0)
+#define MAX77XXX_RBUDF_MASK			BIT(1)
+
+#define SEC_MASK				0x7F
+#define MIN_MASK				0x7F
+#define HOUR_MASK				0x3F
+#define WEEKDAY_MASK				0x7F
+#define MONTH_MASK				0x1F
+#define YEAR_MASK				0xFF
+#define MONTHDAY_MASK				0x3F
+
+#define ALARM_EN_MASK				0x80
+#define ALARM_EN_SHIFT				7
+
+#define RTC_YEAR_BASE				100
+#define RTC_YEAR_MAX				99
+
+#define ONOFF_WK_ALARM1_MASK			BIT(2)
+
+enum {
+	RTC_SEC,
+	RTC_MIN,
+	RTC_HOUR,
+	RTC_WEEKDAY,
+	RTC_MONTH,
+	RTC_YEAR,
+	RTC_MONTHDAY,
+	RTC_NR
+};
+
+struct max77xxx_rtc_info {
+	struct rtc_device *rtc;
+	struct device *dev;
+	struct regmap *rmap;
+	struct mutex io_lock;
+	int irq;
+	u8 irq_mask;
+};
+
+static int max77xxx_rtc_update_buffer(struct max77xxx_rtc_info *rinfo,
+		bool write)
+{
+	u8 val = FLAG_AUTO_CLEAR_MASK | RTC_WAKE_MASK;
+	int ret;
+
+	if (write)
+		val |= WB_UPDATE_MASK;
+	else
+		val |= RB_UPDATE_MASK;
+
+	ret = regmap_write(rinfo->rmap, MAX77XXX_REG_RTCUPDATE0, val);
+	if (ret < 0) {
+		dev_err(rinfo->dev, "Reg RTCUPDATE0 write failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Must wait 16ms for buffer update */
+	usleep_range(16000, 17000);
+
+	return 0;
+}
+
+static int max77xxx_rtc_write(struct max77xxx_rtc_info *rinfo, u8 addr,
+			void *vals, u32 len)
+{
+	int ret;
+	int i;
+	u8 *src = vals;
+
+	mutex_lock(&rinfo->io_lock);
+	for (i = 0; i < len; ++i) {
+		ret = regmap_write(rinfo->rmap, addr + i, *src++);
+		if (ret < 0) {
+			dev_err(rinfo->dev, "Reg 0x%02x write failed: %d\n",
+				addr + i, ret);
+			goto out;
+		}
+	}
+	ret = max77xxx_rtc_update_buffer(rinfo, true);
+out:
+	mutex_unlock(&rinfo->io_lock);
+
+	return ret;
+}
+
+static int max77xxx_rtc_read(struct max77xxx_rtc_info *rinfo, u8 addr,
+			void *vals, u32 len, bool update_buffer)
+{
+	int ret;
+
+	mutex_lock(&rinfo->io_lock);
+	if (update_buffer) {
+		ret = max77xxx_rtc_update_buffer(rinfo, false);
+		if (ret < 0)
+			goto out;
+	}
+
+	ret = regmap_bulk_read(rinfo->rmap, addr, vals, len);
+	if (ret < 0)
+		dev_err(rinfo->dev, "Reg 0x%02x read failed: %d\n", addr, ret);
+out:
+	mutex_unlock(&rinfo->io_lock);
+
+	return ret;
+}
+
+static int max77xxx_rtc_reg_to_tm(struct max77xxx_rtc_info *rinfo, u8 *buf,
+			 struct rtc_time *tm)
+{
+	int wday = buf[RTC_WEEKDAY] & WEEKDAY_MASK;
+
+	if (!wday) {
+		dev_err(rinfo->dev, "Invalid day of week, %d\n", wday);
+		return -EINVAL;
+	}
+
+	tm->tm_sec = (int)(buf[RTC_SEC] & SEC_MASK);
+	tm->tm_min = (int)(buf[RTC_MIN] & MIN_MASK);
+	tm->tm_hour = (int)(buf[RTC_HOUR] & HOUR_MASK);
+	tm->tm_mday = (int)(buf[RTC_MONTHDAY] & MONTHDAY_MASK);
+	tm->tm_mon = (int)(buf[RTC_MONTH] & MONTH_MASK) - 1;
+	tm->tm_year = (int)(buf[RTC_YEAR] & YEAR_MASK) + RTC_YEAR_BASE;
+	tm->tm_wday = ffs(wday) - 1;
+
+	return 0;
+}
+
+static int max77xxx_rtc_tm_to_reg(struct max77xxx_rtc_info *rinfo, u8 *buf,
+			 struct rtc_time *tm, int alarm)
+{
+	u8 alarm_mask = alarm ? ALARM_EN_MASK : 0;
+
+	if ((tm->tm_year < RTC_YEAR_BASE) ||
+			(tm->tm_year > (RTC_YEAR_BASE + RTC_YEAR_MAX))) {
+		dev_err(rinfo->dev, "Invalid year, %d\n", tm->tm_year);
+		return -EINVAL;
+	}
+
+	buf[RTC_SEC] = tm->tm_sec | alarm_mask;
+	buf[RTC_MIN] = tm->tm_min | alarm_mask;
+	buf[RTC_HOUR] = tm->tm_hour | alarm_mask;
+	buf[RTC_MONTHDAY] = tm->tm_mday | alarm_mask;
+	buf[RTC_MONTH] = (tm->tm_mon + 1) | alarm_mask;
+	buf[RTC_YEAR] = (tm->tm_year - RTC_YEAR_BASE) | alarm_mask;
+
+	/* The wday is configured only when disabled alarm. */
+	buf[RTC_WEEKDAY] = (alarm) ? 0x01 : (1 << tm->tm_wday);
+
+	return 0;
+}
+
+static int max77xxx_rtc_irq_mask(struct max77xxx_rtc_info *rinfo, u8 irq)
+{
+	u8 irq_mask = rinfo->irq_mask | irq;
+	int ret;
+
+	ret = max77xxx_rtc_write(rinfo, MAX77XXX_REG_RTCINTM, &irq_mask, 1);
+	if (ret < 0)
+		return ret;
+	rinfo->irq_mask = irq_mask;
+
+	return ret;
+}
+
+static int max77xxx_rtc_irq_unmask(struct max77xxx_rtc_info *rinfo, u8 irq)
+{
+	u8 irq_mask = rinfo->irq_mask & ~irq;
+	int ret;
+
+	ret = max77xxx_rtc_write(rinfo, MAX77XXX_REG_RTCINTM, &irq_mask, 1);
+	if (ret < 0)
+		return ret;
+	rinfo->irq_mask = irq_mask;
+
+	return ret;
+}
+
+static int max77xxx_rtc_do_irq(struct max77xxx_rtc_info *rinfo)
+{
+	unsigned int irq_status;
+	int ret;
+
+	ret = regmap_read(rinfo->rmap, MAX77XXX_REG_RTCINT, &irq_status);
+	if (ret < 0) {
+		dev_err(rinfo->dev, "RTCINT read failed: %d\n", ret);
+		return ret;
+	}
+
+	if (!(rinfo->irq_mask & MAX77XXX_RTCA1_MASK) &&
+			(irq_status & MAX77XXX_RTCA1_MASK))
+		rtc_update_irq(rinfo->rtc, 1, RTC_IRQF | RTC_AF);
+
+	if (!(rinfo->irq_mask & MAX77XXX_RTC_RTC1S_MASK) &&
+			(irq_status & MAX77XXX_RTC_RTC1S_MASK))
+		rtc_update_irq(rinfo->rtc, 1, RTC_IRQF | RTC_UF);
+
+	return ret;
+}
+
+static irqreturn_t max77xxx_rtc_irq(int irq, void *data)
+{
+	struct max77xxx_rtc_info *rinfo = (struct max77xxx_rtc_info *)data;
+
+	max77xxx_rtc_do_irq(rinfo);
+
+	return IRQ_HANDLED;
+}
+
+static int max77xxx_rtc_alarm_irq_enable(struct device *dev,
+					 unsigned int enabled)
+{
+	struct max77xxx_rtc_info *rinfo = dev_get_drvdata(dev);
+	int ret;
+
+	if (rinfo->irq < 0)
+		return -ENXIO;
+
+	/* Handle pending interrupt */
+	ret = max77xxx_rtc_do_irq(rinfo);
+	if (ret < 0)
+		return ret;
+
+	/* Configure alarm interrupt */
+	if (enabled)
+		ret = max77xxx_rtc_irq_unmask(rinfo, MAX77XXX_RTCA1_MASK);
+	else
+		ret = max77xxx_rtc_irq_mask(rinfo, MAX77XXX_RTCA1_MASK);
+
+	return ret;
+}
+
+static int max77xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct max77xxx_rtc_info *rinfo = dev_get_drvdata(dev);
+	u8 buf[RTC_NR];
+	int ret;
+
+	ret = max77xxx_rtc_read(rinfo, MAX77XXX_REG_RTCSEC, buf, RTC_NR, true);
+	if (ret < 0)
+		return ret;
+
+	return max77xxx_rtc_reg_to_tm(rinfo, buf, tm);
+}
+
+static int max77xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct max77xxx_rtc_info *rinfo = dev_get_drvdata(dev);
+	u8 buf[RTC_NR];
+	int ret;
+
+	ret = max77xxx_rtc_tm_to_reg(rinfo, buf, tm, 0);
+	if (ret < 0)
+		return ret;
+
+	return max77xxx_rtc_write(rinfo, MAX77XXX_REG_RTCSEC, buf, RTC_NR);
+}
+
+static int max77xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct max77xxx_rtc_info *rinfo = dev_get_drvdata(dev);
+	u8 buf[RTC_NR];
+	int ret;
+
+	ret = max77xxx_rtc_read(rinfo, MAX77XXX_REG_RTCSECA1, buf, RTC_NR, 1);
+	if (ret < 0)
+		return ret;
+
+	buf[RTC_YEAR] &= ~ALARM_EN_MASK;
+	ret = max77xxx_rtc_reg_to_tm(rinfo, buf, &alrm->time);
+	if (ret < 0)
+		return ret;
+
+	alrm->enabled = (rinfo->irq_mask & MAX77XXX_RTCA1_MASK) ? 0 : 1;
+
+	return 0;
+}
+
+static int max77xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct max77xxx_rtc_info *rinfo = dev_get_drvdata(dev);
+	u8 buf[RTC_NR];
+	int ret;
+
+	ret = max77xxx_rtc_tm_to_reg(rinfo, buf, &alrm->time, 1);
+	if (ret < 0)
+		return ret;
+
+	ret = max77xxx_rtc_write(rinfo, MAX77XXX_REG_RTCSECA1, buf, RTC_NR);
+	if (ret < 0)
+		return ret;
+
+	ret = max77xxx_rtc_alarm_irq_enable(dev, alrm->enabled);
+	if (ret < 0)
+		return ret;
+
+	return ret;
+}
+
+static const struct rtc_class_ops max77xxx_rtc_ops = {
+	.read_time = max77xxx_rtc_read_time,
+	.set_time = max77xxx_rtc_set_time,
+	.read_alarm = max77xxx_rtc_read_alarm,
+	.set_alarm = max77xxx_rtc_set_alarm,
+	.alarm_irq_enable = max77xxx_rtc_alarm_irq_enable,
+};
+
+static int max77xxx_rtc_preinit(struct max77xxx_rtc_info *rinfo)
+{
+	u8 val;
+	int ret;
+
+	/* Mask all interrupts */
+	rinfo->irq_mask = 0xFF;
+	ret = max77xxx_rtc_write(rinfo, MAX77XXX_REG_RTCINTM,
+			&rinfo->irq_mask, 1);
+	if (ret < 0)
+		return ret;
+
+	max77xxx_rtc_read(rinfo, MAX77XXX_REG_RTCINT, &val, 1, false);
+
+	/* Configure Binary mode and 24hour mode */
+	val = MAX77XXX_HRMODEM_MASK;
+	return max77xxx_rtc_write(rinfo, MAX77XXX_REG_RTCCNTL, &val, 1);
+}
+
+static int max77xxx_rtc_probe(struct platform_device *pdev)
+{
+	static struct max77xxx_rtc_info *rinfo;
+	int ret;
+
+	rinfo = devm_kzalloc(&pdev->dev, sizeof(*rinfo), GFP_KERNEL);
+	if (!rinfo)
+		return -ENOMEM;
+
+	dev_set_drvdata(&pdev->dev, rinfo);
+	rinfo->dev = &pdev->dev;
+	mutex_init(&rinfo->io_lock);
+	rinfo->rmap = dev_get_regmap(pdev->dev.parent, "rtc-slave");
+	if (!rinfo->rmap) {
+		dev_err(&pdev->dev, "Regmap for RTC device not found\n");
+		return -ENODEV;
+	}
+
+	ret = max77xxx_rtc_preinit(rinfo);
+	if (ret < 0)
+		goto fail_preinit;
+
+	device_init_wakeup(&pdev->dev, 1);
+
+	rinfo->rtc = devm_rtc_device_register(&pdev->dev, "max77xxx-rtc",
+				&max77xxx_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rinfo->rtc)) {
+		ret = PTR_ERR(rinfo->rtc);
+		dev_err(&pdev->dev, "RTC registration failed: %d\n", ret);
+		goto fail_preinit;
+	}
+
+	rinfo->irq = platform_get_irq(pdev, 0);
+	ret = devm_request_threaded_irq(&pdev->dev, rinfo->irq, NULL,
+			max77xxx_rtc_irq, IRQF_ONESHOT, "max77xxx-rtc", rinfo);
+	if (ret < 0) {
+		dev_err(rinfo->dev, "Failed to request irq %d\n", rinfo->irq);
+		goto fail_preinit;
+	}
+
+	enable_irq_wake(rinfo->irq);
+
+	return 0;
+
+fail_preinit:
+	mutex_destroy(&rinfo->io_lock);
+
+	return ret;
+}
+
+static int max77xxx_rtc_remove(struct platform_device *pdev)
+{
+	struct max77xxx_rtc_info *rinfo = dev_get_drvdata(&pdev->dev);
+
+	mutex_destroy(&rinfo->io_lock);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int max77xxx_rtc_suspend(struct device *dev)
+{
+	struct max77xxx_rtc_info *rinfo = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(rinfo->irq);
+
+	return 0;
+}
+
+static int max77xxx_rtc_resume(struct device *dev)
+{
+	struct max77xxx_rtc_info *rinfo = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(rinfo->irq);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops max77xxx_rtc_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(max77xxx_rtc_suspend, max77xxx_rtc_resume)
+};
+
+static const struct platform_device_id max77xxx_rtc_devtype[] = {
+	{ .name = "max77xxx-rtc", },
+	{ .name = "max77620-rtc", },
+	{ .name = "max20024-rtc", },
+};
+
+static struct platform_driver max77xxx_rtc_driver = {
+	.probe = max77xxx_rtc_probe,
+	.remove = max77xxx_rtc_remove,
+	.id_table = max77xxx_rtc_devtype,
+	.driver = {
+			.name = "max77xxx-rtc",
+			.pm = &max77xxx_rtc_pm_ops,
+	},
+};
+
+module_platform_driver(max77xxx_rtc_driver);
+
+MODULE_DESCRIPTION("max77xxx RTC driver");
+MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
+MODULE_ALIAS("platform:max77xxx-rtc");
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
