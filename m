Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33256 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbeARUK4 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 18 Jan 2018 15:10:56 -0500
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: alexandre.belloni@free-electrons.com, a.zummo@towertech.it,
        egtvedt@samfundet.no
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH] rtc: remove rtc-at32ap700x
Date: Thu, 18 Jan 2018 21:08:46 +0100
Message-Id: <20180118200846.14368-1-clabbe.montjoie@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Since PLATFORM_AT32AP is an AVR32 platform which was removed, the
rtc driver rtc-at32ap700x is useless.
This patch remove it.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/rtc/Kconfig          |   7 --
 drivers/rtc/Makefile         |   1 -
 drivers/rtc/rtc-at32ap700x.c | 287 -------------------------------------------
 3 files changed, 295 deletions(-)
 delete mode 100644 drivers/rtc/rtc-at32ap700x.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index b71cc7b5fbc9..8ab5f0a5d323 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1402,13 +1402,6 @@ config RTC_DRV_PL031
 	  To compile this driver as a module, choose M here: the
 	  module will be called rtc-pl031.
 
-config RTC_DRV_AT32AP700X
-	tristate "AT32AP700X series RTC"
-	depends on PLATFORM_AT32AP || COMPILE_TEST
-	help
-	  Driver for the internal RTC (Realtime Clock) on Atmel AVR32
-	  AT32AP700x family processors.
-
 config RTC_DRV_AT91RM9200
 	tristate "AT91RM9200 or some AT91SAM9 RTC"
 	depends on ARCH_AT91 || COMPILE_TEST
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 6dfbbe9cd8a2..4fbf87e45a7c 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -33,7 +33,6 @@ obj-$(CONFIG_RTC_DRV_AC100)	+= rtc-ac100.o
 obj-$(CONFIG_RTC_DRV_ARMADA38X)	+= rtc-armada38x.o
 obj-$(CONFIG_RTC_DRV_AS3722)	+= rtc-as3722.o
 obj-$(CONFIG_RTC_DRV_ASM9260)	+= rtc-asm9260.o
-obj-$(CONFIG_RTC_DRV_AT32AP700X)+= rtc-at32ap700x.o
 obj-$(CONFIG_RTC_DRV_AT91RM9200)+= rtc-at91rm9200.o
 obj-$(CONFIG_RTC_DRV_AT91SAM9)	+= rtc-at91sam9.o
 obj-$(CONFIG_RTC_DRV_AU1XXX)	+= rtc-au1xxx.o
diff --git a/drivers/rtc/rtc-at32ap700x.c b/drivers/rtc/rtc-at32ap700x.c
deleted file mode 100644
index de8bf56a41e7..000000000000
--- a/drivers/rtc/rtc-at32ap700x.c
+++ /dev/null
@@ -1,287 +0,0 @@
-/*
- * An RTC driver for the AVR32 AT32AP700x processor series.
- *
- * Copyright (C) 2007 Atmel Corporation
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published
- * by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/rtc.h>
-#include <linux/io.h>
-
-/*
- * This is a bare-bones RTC. It runs during most system sleep states, but has
- * no battery backup and gets reset during system restart.  It must be
- * initialized from an external clock (network, I2C, etc) before it can be of
- * much use.
- *
- * The alarm functionality is limited by the hardware, not supporting
- * periodic interrupts.
- */
-
-#define RTC_CTRL		0x00
-#define RTC_CTRL_EN		   0
-#define RTC_CTRL_PCLR		   1
-#define RTC_CTRL_TOPEN		   2
-#define RTC_CTRL_PSEL		   8
-
-#define RTC_VAL			0x04
-
-#define RTC_TOP			0x08
-
-#define RTC_IER			0x10
-#define RTC_IER_TOPI		   0
-
-#define RTC_IDR			0x14
-#define RTC_IDR_TOPI		   0
-
-#define RTC_IMR			0x18
-#define RTC_IMR_TOPI		   0
-
-#define RTC_ISR			0x1c
-#define RTC_ISR_TOPI		   0
-
-#define RTC_ICR			0x20
-#define RTC_ICR_TOPI		   0
-
-#define RTC_BIT(name)		(1 << RTC_##name)
-#define RTC_BF(name, value)	((value) << RTC_##name)
-
-#define rtc_readl(dev, reg)				\
-	__raw_readl((dev)->regs + RTC_##reg)
-#define rtc_writel(dev, reg, value)			\
-	__raw_writel((value), (dev)->regs + RTC_##reg)
-
-struct rtc_at32ap700x {
-	struct rtc_device	*rtc;
-	void __iomem		*regs;
-	unsigned long		alarm_time;
-	unsigned long		irq;
-	/* Protect against concurrent register access. */
-	spinlock_t		lock;
-};
-
-static int at32_rtc_readtime(struct device *dev, struct rtc_time *tm)
-{
-	struct rtc_at32ap700x *rtc = dev_get_drvdata(dev);
-	unsigned long now;
-
-	now = rtc_readl(rtc, VAL);
-	rtc_time_to_tm(now, tm);
-
-	return 0;
-}
-
-static int at32_rtc_settime(struct device *dev, struct rtc_time *tm)
-{
-	struct rtc_at32ap700x *rtc = dev_get_drvdata(dev);
-	unsigned long now;
-	int ret;
-
-	ret = rtc_tm_to_time(tm, &now);
-	if (ret == 0)
-		rtc_writel(rtc, VAL, now);
-
-	return ret;
-}
-
-static int at32_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
-{
-	struct rtc_at32ap700x *rtc = dev_get_drvdata(dev);
-
-	spin_lock_irq(&rtc->lock);
-	rtc_time_to_tm(rtc->alarm_time, &alrm->time);
-	alrm->enabled = rtc_readl(rtc, IMR) & RTC_BIT(IMR_TOPI) ? 1 : 0;
-	alrm->pending = rtc_readl(rtc, ISR) & RTC_BIT(ISR_TOPI) ? 1 : 0;
-	spin_unlock_irq(&rtc->lock);
-
-	return 0;
-}
-
-static int at32_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
-{
-	struct rtc_at32ap700x *rtc = dev_get_drvdata(dev);
-	unsigned long rtc_unix_time;
-	unsigned long alarm_unix_time;
-	int ret;
-
-	rtc_unix_time = rtc_readl(rtc, VAL);
-
-	ret = rtc_tm_to_time(&alrm->time, &alarm_unix_time);
-	if (ret)
-		return ret;
-
-	if (alarm_unix_time < rtc_unix_time)
-		return -EINVAL;
-
-	spin_lock_irq(&rtc->lock);
-	rtc->alarm_time = alarm_unix_time;
-	rtc_writel(rtc, TOP, rtc->alarm_time);
-	if (alrm->enabled)
-		rtc_writel(rtc, CTRL, rtc_readl(rtc, CTRL)
-				| RTC_BIT(CTRL_TOPEN));
-	else
-		rtc_writel(rtc, CTRL, rtc_readl(rtc, CTRL)
-				& ~RTC_BIT(CTRL_TOPEN));
-	spin_unlock_irq(&rtc->lock);
-
-	return ret;
-}
-
-static int at32_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
-{
-	struct rtc_at32ap700x *rtc = dev_get_drvdata(dev);
-	int ret = 0;
-
-	spin_lock_irq(&rtc->lock);
-
-	if (enabled) {
-		if (rtc_readl(rtc, VAL) > rtc->alarm_time) {
-			ret = -EINVAL;
-			goto out;
-		}
-		rtc_writel(rtc, CTRL, rtc_readl(rtc, CTRL)
-				| RTC_BIT(CTRL_TOPEN));
-		rtc_writel(rtc, ICR, RTC_BIT(ICR_TOPI));
-		rtc_writel(rtc, IER, RTC_BIT(IER_TOPI));
-	} else {
-		rtc_writel(rtc, CTRL, rtc_readl(rtc, CTRL)
-				& ~RTC_BIT(CTRL_TOPEN));
-		rtc_writel(rtc, IDR, RTC_BIT(IDR_TOPI));
-		rtc_writel(rtc, ICR, RTC_BIT(ICR_TOPI));
-	}
-out:
-	spin_unlock_irq(&rtc->lock);
-
-	return ret;
-}
-
-static irqreturn_t at32_rtc_interrupt(int irq, void *dev_id)
-{
-	struct rtc_at32ap700x *rtc = (struct rtc_at32ap700x *)dev_id;
-	unsigned long isr = rtc_readl(rtc, ISR);
-	unsigned long events = 0;
-	int ret = IRQ_NONE;
-
-	spin_lock(&rtc->lock);
-
-	if (isr & RTC_BIT(ISR_TOPI)) {
-		rtc_writel(rtc, ICR, RTC_BIT(ICR_TOPI));
-		rtc_writel(rtc, IDR, RTC_BIT(IDR_TOPI));
-		rtc_writel(rtc, CTRL, rtc_readl(rtc, CTRL)
-				& ~RTC_BIT(CTRL_TOPEN));
-		rtc_writel(rtc, VAL, rtc->alarm_time);
-		events = RTC_AF | RTC_IRQF;
-		rtc_update_irq(rtc->rtc, 1, events);
-		ret = IRQ_HANDLED;
-	}
-
-	spin_unlock(&rtc->lock);
-
-	return ret;
-}
-
-static const struct rtc_class_ops at32_rtc_ops = {
-	.read_time	= at32_rtc_readtime,
-	.set_time	= at32_rtc_settime,
-	.read_alarm	= at32_rtc_readalarm,
-	.set_alarm	= at32_rtc_setalarm,
-	.alarm_irq_enable = at32_rtc_alarm_irq_enable,
-};
-
-static int __init at32_rtc_probe(struct platform_device *pdev)
-{
-	struct resource	*regs;
-	struct rtc_at32ap700x *rtc;
-	int irq;
-	int ret;
-
-	rtc = devm_kzalloc(&pdev->dev, sizeof(struct rtc_at32ap700x),
-			   GFP_KERNEL);
-	if (!rtc)
-		return -ENOMEM;
-
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!regs) {
-		dev_dbg(&pdev->dev, "no mmio resource defined\n");
-		return -ENXIO;
-	}
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_dbg(&pdev->dev, "could not get irq\n");
-		return -ENXIO;
-	}
-
-	rtc->irq = irq;
-	rtc->regs = devm_ioremap(&pdev->dev, regs->start, resource_size(regs));
-	if (!rtc->regs) {
-		dev_dbg(&pdev->dev, "could not map I/O memory\n");
-		return -ENOMEM;
-	}
-	spin_lock_init(&rtc->lock);
-
-	/*
-	 * Maybe init RTC: count from zero at 1 Hz, disable wrap irq.
-	 *
-	 * Do not reset VAL register, as it can hold an old time
-	 * from last JTAG reset.
-	 */
-	if (!(rtc_readl(rtc, CTRL) & RTC_BIT(CTRL_EN))) {
-		rtc_writel(rtc, CTRL, RTC_BIT(CTRL_PCLR));
-		rtc_writel(rtc, IDR, RTC_BIT(IDR_TOPI));
-		rtc_writel(rtc, CTRL, RTC_BF(CTRL_PSEL, 0xe)
-				| RTC_BIT(CTRL_EN));
-	}
-
-	ret = devm_request_irq(&pdev->dev, irq, at32_rtc_interrupt, IRQF_SHARED,
-				"rtc", rtc);
-	if (ret) {
-		dev_dbg(&pdev->dev, "could not request irq %d\n", irq);
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, rtc);
-
-	rtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-				&at32_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc->rtc)) {
-		dev_dbg(&pdev->dev, "could not register rtc device\n");
-		return PTR_ERR(rtc->rtc);
-	}
-
-	device_init_wakeup(&pdev->dev, 1);
-
-	dev_info(&pdev->dev, "Atmel RTC for AT32AP700x at %08lx irq %ld\n",
-			(unsigned long)rtc->regs, rtc->irq);
-
-	return 0;
-}
-
-static int __exit at32_rtc_remove(struct platform_device *pdev)
-{
-	device_init_wakeup(&pdev->dev, 0);
-
-	return 0;
-}
-
-MODULE_ALIAS("platform:at32ap700x_rtc");
-
-static struct platform_driver at32_rtc_driver = {
-	.remove		= __exit_p(at32_rtc_remove),
-	.driver		= {
-		.name	= "at32ap700x_rtc",
-	},
-};
-
-module_platform_driver_probe(at32_rtc_driver, at32_rtc_probe);
-
-MODULE_AUTHOR("Hans-Christian Egtvedt <egtvedt@samfundet.no>");
-MODULE_DESCRIPTION("Real time clock for AVR32 AT32AP700x");
-MODULE_LICENSE("GPL");
-- 
2.13.6
