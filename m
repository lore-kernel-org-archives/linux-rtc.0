Return-Path: <rtc-linux+bncBDAYD2P3QYGRBTET5XAAKGQE6RAJXIA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x231.google.com (mail-wm0-x231.google.com. [2a00:1450:400c:c09::231])
        by gmr-mx.google.com with ESMTPS id h23si180216wmi.1.2016.11.03.07.29.32
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Nov 2016 07:29:32 -0700 (PDT)
Received: by mail-wm0-x231.google.com with SMTP id n67so104738360wme.1
        for <rtc-linux@googlegroups.com>; Thu, 03 Nov 2016 07:29:32 -0700 (PDT)
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
Subject: [rtc-linux] [RFC PATCH 2/3] rtc: Add Amlogic Virtual Wake RTC
Date: Thu,  3 Nov 2016 15:29:24 +0100
Message-Id: <1478183365-23708-3-git-send-email-narmstrong@baylibre.com>
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

The Amlogic Meson GX SoCs uses a special register to store the
time in seconds to wakeup after a system suspend.

In order to be able to reuse the RTC wakealarm feature, this
driver implements a fake RTC device which uses the system time
to deduce a suspend delay.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/rtc/Kconfig          |  10 +++
 drivers/rtc/Makefile         |   1 +
 drivers/rtc/rtc-meson-vrtc.c | 164 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+)
 create mode 100644 drivers/rtc/rtc-meson-vrtc.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e859d14..d0f65fb 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -351,6 +351,16 @@ config RTC_DRV_MAX77686
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-max77686.
 
+config RTC_DRV_MESON_VRTC
+	tristate "Amlogic Meson Virtual RTC"
+	depends on ARCH_MESON
+	help
+	  If you say yes here you will get support for the
+	  Virtual RTC of Amlogic SoCs.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-meson-vrtc.
+
 config RTC_DRV_RK808
 	tristate "Rockchip RK808/RK818 RTC"
 	depends on MFD_RK808
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 1ac694a..feb83ad 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_RTC_DRV_MAX8907)	+= rtc-max8907.o
 obj-$(CONFIG_RTC_DRV_MAX8925)	+= rtc-max8925.o
 obj-$(CONFIG_RTC_DRV_MAX8997)	+= rtc-max8997.o
 obj-$(CONFIG_RTC_DRV_MAX8998)	+= rtc-max8998.o
+obj-$(CONFIG_RTC_DRV_MESON_VRTC)+= rtc-meson-vrtc.o
 obj-$(CONFIG_RTC_DRV_MC13XXX)	+= rtc-mc13xxx.o
 obj-$(CONFIG_RTC_DRV_MCP795)	+= rtc-mcp795.o
 obj-$(CONFIG_RTC_DRV_MOXART)	+= rtc-moxart.o
diff --git a/drivers/rtc/rtc-meson-vrtc.c b/drivers/rtc/rtc-meson-vrtc.c
new file mode 100644
index 0000000..34c45bd
--- /dev/null
+++ b/drivers/rtc/rtc-meson-vrtc.c
@@ -0,0 +1,164 @@
+/*
+ * drivers/rtc/rtc-meson-vrtc.c
+ *
+ * Copyright (C) 2016 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/pm_wakeup.h>
+#include <linux/time64.h>
+
+struct meson_vrtc_data {
+	struct platform_device *pdev;
+	void __iomem *io_alarm;
+	struct rtc_device *rtc;
+	unsigned long alarm_time;
+};
+
+static int meson_vrtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	unsigned long local_time;
+	struct timeval time;
+
+	do_gettimeofday(&time);
+	local_time = time.tv_sec - (sys_tz.tz_minuteswest * 60);
+	rtc_time_to_tm(local_time, tm);
+
+	return 0;
+}
+
+static void meson_vrtc_set_wakeup_time(struct meson_vrtc_data *vrtc,
+				       unsigned long time)
+{
+	writel_relaxed(time, vrtc->io_alarm);
+
+	dev_dbg(&vrtc->pdev->dev, "set_wakeup_time: %lu\n", time);
+}
+
+static int meson_vrtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct meson_vrtc_data *vrtc = dev_get_drvdata(dev);
+	struct timeval time;
+	unsigned long local_time;
+	unsigned long alarm_secs;
+	int ret;
+
+	if (alarm->enabled) {
+		ret = rtc_tm_to_time(&alarm->time, &alarm_secs);
+		if (ret)
+			return ret;
+
+		do_gettimeofday(&time);
+		local_time = time.tv_sec - (sys_tz.tz_minuteswest * 60);
+
+		vrtc->alarm_time = alarm_secs;
+
+		if (alarm_secs >= local_time) {
+			alarm_secs = alarm_secs - local_time;
+
+			meson_vrtc_set_wakeup_time(vrtc, alarm_secs);
+
+			pr_debug("system will wakeup %lus later\n", alarm_secs);
+		}
+	} else {
+		vrtc->alarm_time = 0;
+		meson_vrtc_set_wakeup_time(vrtc, 0);
+	}
+
+	return 0;
+}
+
+static int meson_vrtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
+{
+	struct meson_vrtc_data *vrtc = dev_get_drvdata(dev);
+
+	if (!vrtc->alarm_time) {
+		alm->enabled = true;
+
+		rtc_time_to_tm(vrtc->alarm_time, &alm->time);
+	}
+
+	return 0;
+}
+
+static const struct rtc_class_ops meson_vrtc_ops = {
+	.read_time = meson_vrtc_read_time,
+	.set_alarm = meson_vrtc_set_alarm,
+	.read_alarm = meson_vrtc_read_alarm,
+};
+
+static int meson_vrtc_probe(struct platform_device *pdev)
+{
+	struct meson_vrtc_data *vrtc;
+	struct resource *res;
+
+	vrtc = devm_kzalloc(&pdev->dev, sizeof(*vrtc), GFP_KERNEL);
+	if (!vrtc)
+		return -ENOMEM;
+
+	vrtc->pdev = pdev;
+
+	/* Alarm registers */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	vrtc->io_alarm = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(vrtc->io_alarm))
+		return PTR_ERR(vrtc->io_alarm);
+
+	device_init_wakeup(&pdev->dev, 1);
+
+	platform_set_drvdata(pdev, vrtc);
+
+	vrtc->rtc = devm_rtc_device_register(&pdev->dev, "meson-vrtc",
+			&meson_vrtc_ops, THIS_MODULE);
+	if (IS_ERR(vrtc->rtc))
+		return PTR_ERR(vrtc->rtc);
+
+	return 0;
+}
+
+int meson_vrtc_resume(struct platform_device *pdev)
+{
+	struct meson_vrtc_data *vrtc = platform_get_drvdata(pdev);
+
+	meson_vrtc_set_wakeup_time(vrtc, 0);
+
+	return 0;
+}
+
+static const struct of_device_id meson_vrtc_dt_match[] = {
+	{ .compatible = "amlogic,meson-vrtc"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, meson_vrtc_dt_match);
+
+struct platform_driver meson_vrtc_driver = {
+	.driver = {
+		.name = "meson-vrtc",
+		.of_match_table = meson_vrtc_dt_match,
+	},
+	.probe = meson_vrtc_probe,
+	.resume = meson_vrtc_resume,
+};
+
+module_platform_driver(meson_vrtc_driver);
+
+MODULE_DESCRIPTION("Amlogic Virtual Wakeup RTC Timer driver");
+MODULE_LICENSE("GPL");
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
