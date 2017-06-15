Return-Path: <rtc-linux+bncBCH67JWTV4DBBL6ORPFAKGQEQRNBD6Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com. [2a00:1450:400c:c09::241])
        by gmr-mx.google.com with ESMTPS id j201si32187wmg.5.2017.06.15.12.59.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 12:59:25 -0700 (PDT)
Received: by mail-wm0-x241.google.com with SMTP id f90so1518015wmh.0
        for <rtc-linux@googlegroups.com>; Thu, 15 Jun 2017 12:59:25 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Brian Norris <computersforpeace@gmail.com>,
	Markus Mayer <mmayer@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Gregory Fong <gregory.0xf0@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE),
	rtc-linux@googlegroups.com (open list:REAL TIME CLOCK (RTC) SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE)
Subject: [rtc-linux] [PATCH 2/2] rtc: brcmstb-waketimer: Add Broadcom STB wake-timer
Date: Thu, 15 Jun 2017 12:59:04 -0700
Message-Id: <20170615195904.12653-3-f.fainelli@gmail.com>
In-Reply-To: <20170615195904.12653-1-f.fainelli@gmail.com>
References: <20170615195904.12653-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Brian Norris <computersforpeace@gmail.com>

This adds support for the Broadcom STB wake-timer which is a timer in
the chip's 27Mhz clock domain that offers the ability to wake the system
(wake-up source) from suspend states (S2, S3, S5). It is supported using
the rtc framework allowing us to configure alarms for system wake-up.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Markus Mayer <mmayer@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/rtc/Kconfig                 |  11 ++
 drivers/rtc/Makefile                |   1 +
 drivers/rtc/rtc-brcmstb-waketimer.c | 345 ++++++++++++++++++++++++++++++++=
++++
 3 files changed, 357 insertions(+)
 create mode 100644 drivers/rtc/rtc-brcmstb-waketimer.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 8d3b95728326..8e1aa67fe533 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -197,6 +197,17 @@ config RTC_DRV_AC100
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-ac100.
=20
+config RTC_DRV_BRCMSTB
+	tristate "Broadcom STB wake-timer"
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
+	default ARCH_BRCMSTB || BMIPS_GENERIC
+	help
+	  If you say yes here you get support for the wake-timer found on
+	  Broadcom STB SoCs (BCM7xxx).
+
+	  This driver can also be built as a module. If so, the module will
+	  be called rtc-brcmstb-waketimer.
+
 config RTC_DRV_AS3722
 	tristate "ams AS3722 RTC driver"
 	depends on MFD_AS3722
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 13857d2fce09..df89cac1f9ae 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_RTC_DRV_AT91RM9200)+=3D rtc-at91rm9200.o
 obj-$(CONFIG_RTC_DRV_AT91SAM9)	+=3D rtc-at91sam9.o
 obj-$(CONFIG_RTC_DRV_AU1XXX)	+=3D rtc-au1xxx.o
 obj-$(CONFIG_RTC_DRV_BFIN)	+=3D rtc-bfin.o
+obj-$(CONFIG_RTC_DRV_BRCMSTB)	+=3D rtc-brcmstb-waketimer.o
 obj-$(CONFIG_RTC_DRV_BQ32K)	+=3D rtc-bq32k.o
 obj-$(CONFIG_RTC_DRV_BQ4802)	+=3D rtc-bq4802.o
 obj-$(CONFIG_RTC_DRV_CMOS)	+=3D rtc-cmos.o
diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-=
waketimer.c
new file mode 100644
index 000000000000..c7f166e39f5e
--- /dev/null
+++ b/drivers/rtc/rtc-brcmstb-waketimer.c
@@ -0,0 +1,345 @@
+/*
+ * Copyright =C2=A9 2014-2017 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irqreturn.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/pm_wakeup.h>
+#include <linux/reboot.h>
+#include <linux/rtc.h>
+#include <linux/stat.h>
+#include <linux/suspend.h>
+
+struct brcmstb_waketmr {
+	struct rtc_device *rtc;
+	struct device *dev;
+	void __iomem *base;
+	int irq;
+	struct notifier_block reboot_notifier;
+	struct clk *clk;
+	u32 rate;
+};
+
+#define BRCMSTB_WKTMR_EVENT		0x00
+#define BRCMSTB_WKTMR_COUNTER		0x04
+#define BRCMSTB_WKTMR_ALARM		0x08
+#define BRCMSTB_WKTMR_PRESCALER		0x0C
+#define BRCMSTB_WKTMR_PRESCALER_VAL	0x10
+
+#define BRCMSTB_WKTMR_DEFAULT_FREQ	27000000
+
+static inline void brcmstb_waketmr_clear_alarm(struct brcmstb_waketmr *tim=
er)
+{
+	writel_relaxed(1, timer->base + BRCMSTB_WKTMR_EVENT);
+	(void)readl_relaxed(timer->base + BRCMSTB_WKTMR_EVENT);
+}
+
+static void brcmstb_waketmr_set_alarm(struct brcmstb_waketmr *timer,
+				      unsigned int secs)
+{
+	brcmstb_waketmr_clear_alarm(timer);
+
+	writel_relaxed(secs + 1, timer->base + BRCMSTB_WKTMR_ALARM);
+}
+
+static irqreturn_t brcmstb_waketmr_irq(int irq, void *data)
+{
+	struct brcmstb_waketmr *timer =3D data;
+
+	pm_wakeup_event(timer->dev, 0);
+
+	return IRQ_HANDLED;
+}
+
+struct wktmr_time {
+	u32 sec;
+	u32 pre;
+};
+
+static void wktmr_read(struct brcmstb_waketmr *timer,
+		       struct wktmr_time *t)
+{
+	u32 tmp;
+
+	do {
+		t->sec =3D readl_relaxed(timer->base + BRCMSTB_WKTMR_COUNTER);
+		tmp =3D readl_relaxed(timer->base + BRCMSTB_WKTMR_PRESCALER_VAL);
+	} while (tmp >=3D timer->rate);
+
+	t->pre =3D timer->rate - tmp;
+}
+
+static int brcmstb_waketmr_prepare_suspend(struct brcmstb_waketmr *timer)
+{
+	struct device *dev =3D timer->dev;
+	int ret =3D 0;
+
+	if (device_may_wakeup(dev)) {
+		dev_dbg(dev, "enable wake IRQ\n");
+		ret =3D enable_irq_wake(timer->irq);
+		if (ret) {
+			dev_err(dev, "failed to enable wake-up interrupt\n");
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+/* If enabled as a wakeup-source, arm the timer when powering off */
+static int brcmstb_waketmr_reboot(struct notifier_block *nb,
+		unsigned long action, void *data)
+{
+	struct brcmstb_waketmr *timer;
+
+	timer =3D container_of(nb, struct brcmstb_waketmr, reboot_notifier);
+
+	/* Set timer for cold boot */
+	if (action =3D=3D SYS_POWER_OFF)
+		brcmstb_waketmr_prepare_suspend(timer);
+
+	return NOTIFY_DONE;
+}
+
+static int brcmstb_waketmr_gettime(struct device *dev,
+				   struct rtc_time *tm)
+{
+	struct brcmstb_waketmr *timer =3D dev_get_drvdata(dev);
+	struct wktmr_time now;
+
+	wktmr_read(timer, &now);
+
+	rtc_time_to_tm(now.sec, tm);
+
+	return 0;
+}
+
+static int brcmstb_waketmr_settime(struct device *dev,
+				   struct rtc_time *tm)
+{
+	struct brcmstb_waketmr *timer =3D dev_get_drvdata(dev);
+	unsigned long sec;
+	int ret;
+
+	ret =3D rtc_valid_tm(tm);
+	if (ret)
+		return ret;
+
+	rtc_tm_to_time(tm, &sec);
+
+	dev_dbg(dev, "%s: sec=3D%ld\n", __func__, sec);
+	writel_relaxed(sec, timer->base + BRCMSTB_WKTMR_COUNTER);
+
+	return 0;
+}
+
+static int brcmstb_waketmr_getalarm(struct device *dev,
+				    struct rtc_wkalrm *alarm)
+{
+	struct brcmstb_waketmr *timer =3D dev_get_drvdata(dev);
+	unsigned long sec;
+	u32 reg;
+
+	sec =3D readl_relaxed(timer->base + BRCMSTB_WKTMR_ALARM);
+	if (sec =3D=3D 0) {
+		/* Alarm is disabled */
+		alarm->enabled =3D 0;
+		alarm->time.tm_mon =3D -1;
+		alarm->time.tm_mday =3D -1;
+		alarm->time.tm_year =3D -1;
+		alarm->time.tm_hour =3D -1;
+		alarm->time.tm_min =3D -1;
+		alarm->time.tm_sec =3D -1;
+		dev_dbg(dev, "%s: alarm is disabled\n", __func__);
+	} else {
+		/* Alarm is enabled */
+		alarm->enabled =3D 1;
+		rtc_time_to_tm(sec, &alarm->time);
+		dev_dbg(dev, "%s: alarm is enabled\n", __func__);
+	}
+
+	reg =3D readl_relaxed(timer->base + BRCMSTB_WKTMR_EVENT);
+	alarm->pending =3D !!(reg & 1);
+	dev_dbg(dev, "%s: alarm pending=3D%d\n", __func__, alarm->pending);
+
+	return 0;
+}
+
+static int brcmstb_waketmr_setalarm(struct device *dev,
+				     struct rtc_wkalrm *alarm)
+{
+	struct brcmstb_waketmr *timer =3D dev_get_drvdata(dev);
+	unsigned long sec;
+
+	if (alarm->enabled)
+		rtc_tm_to_time(&alarm->time, &sec);
+	else
+		sec =3D 0;
+
+	dev_dbg(dev, "%s: timeout=3D%ld\n", __func__, sec);
+	brcmstb_waketmr_set_alarm(timer, sec);
+
+	return 0;
+}
+
+/*
+ * Does not do much but keep the RTC class happy. We always support
+ * alarms.
+ */
+static int brcmstb_waketmr_alarm_enable(struct device *dev,
+					unsigned int enabled)
+{
+	dev_dbg(dev, "%s: enabled=3D%d\n", __func__, enabled);
+	return 0;
+}
+
+static const struct rtc_class_ops brcmstb_waketmr_ops =3D {
+	.read_time	=3D brcmstb_waketmr_gettime,
+	.set_time	=3D brcmstb_waketmr_settime,
+	.read_alarm	=3D brcmstb_waketmr_getalarm,
+	.set_alarm	=3D brcmstb_waketmr_setalarm,
+	.alarm_irq_enable =3D brcmstb_waketmr_alarm_enable,
+};
+
+static int brcmstb_waketmr_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct brcmstb_waketmr *timer;
+	struct resource *res;
+	int ret;
+
+	timer =3D devm_kzalloc(dev, sizeof(*timer), GFP_KERNEL);
+	if (!timer)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, timer);
+	timer->dev =3D dev;
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	timer->base =3D devm_ioremap_resource(dev, res);
+	if (IS_ERR(timer->base))
+		return PTR_ERR(timer->base);
+
+	/*
+	 * Set wakeup capability before requesting wakeup interrupt, so we can
+	 * process boot-time "wakeups" (e.g., from S5 soft-off)
+	 */
+	device_set_wakeup_capable(dev, true);
+	device_wakeup_enable(dev);
+
+	timer->irq =3D platform_get_irq(pdev, 0);
+	if (timer->irq < 0)
+		return -ENODEV;
+
+	timer->clk =3D devm_clk_get(dev, NULL);
+	if (!IS_ERR(timer->clk)) {
+		ret =3D clk_prepare_enable(timer->clk);
+		if (ret)
+			return ret;
+		timer->rate =3D clk_get_rate(timer->clk);
+		if (!timer->rate)
+			timer->rate =3D BRCMSTB_WKTMR_DEFAULT_FREQ;
+	} else {
+		timer->rate =3D BRCMSTB_WKTMR_DEFAULT_FREQ;
+		timer->clk =3D NULL;
+	}
+
+	ret =3D devm_request_irq(dev, timer->irq, brcmstb_waketmr_irq, 0,
+			       "brcmstb-waketimer", timer);
+	if (ret < 0)
+		return ret;
+
+	timer->reboot_notifier.notifier_call =3D brcmstb_waketmr_reboot;
+	register_reboot_notifier(&timer->reboot_notifier);
+
+	timer->rtc =3D rtc_device_register("brcmstb-waketmr", dev,
+					 &brcmstb_waketmr_ops, THIS_MODULE);
+	if (IS_ERR(timer->rtc)) {
+		dev_err(dev, "unable to register device\n");
+		unregister_reboot_notifier(&timer->reboot_notifier);
+		return PTR_ERR(timer->rtc);
+	}
+
+	dev_info(dev, "registered, with irq %d\n", timer->irq);
+
+	return ret;
+}
+
+static int brcmstb_waketmr_remove(struct platform_device *pdev)
+{
+	struct brcmstb_waketmr *timer =3D dev_get_drvdata(&pdev->dev);
+
+	unregister_reboot_notifier(&timer->reboot_notifier);
+	rtc_device_unregister(timer->rtc);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int brcmstb_waketmr_suspend(struct device *dev)
+{
+	struct brcmstb_waketmr *timer =3D dev_get_drvdata(dev);
+
+	return brcmstb_waketmr_prepare_suspend(timer);
+}
+
+static int brcmstb_waketmr_resume(struct device *dev)
+{
+	struct brcmstb_waketmr *timer =3D dev_get_drvdata(dev);
+	int ret;
+
+	if (!device_may_wakeup(dev))
+		return 0;
+
+	ret =3D disable_irq_wake(timer->irq);
+
+	brcmstb_waketmr_clear_alarm(timer);
+
+	return ret;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static SIMPLE_DEV_PM_OPS(brcmstb_waketmr_pm_ops,
+			 brcmstb_waketmr_suspend, brcmstb_waketmr_resume);
+
+static const struct of_device_id brcmstb_waketmr_of_match[] =3D {
+	{ .compatible =3D "brcm,brcmstb-waketimer" },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver brcmstb_waketmr_driver =3D {
+	.probe			=3D brcmstb_waketmr_probe,
+	.remove			=3D brcmstb_waketmr_remove,
+	.driver =3D {
+		.name		=3D "brcmstb-waketimer",
+		.pm		=3D &brcmstb_waketmr_pm_ops,
+		.of_match_table	=3D of_match_ptr(brcmstb_waketmr_of_match),
+	}
+};
+module_platform_driver(brcmstb_waketmr_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Brian Norris");
+MODULE_AUTHOR("Markus Mayer");
+MODULE_DESCRIPTION("Wake-up timer driver for STB chips");
--=20
2.9.3

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
