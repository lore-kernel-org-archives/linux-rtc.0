Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B50545D95
	for <linux-rtc@vger.kernel.org>; Wed,  9 Sep 2026 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963203; cv=none; b=r6oe/RzwW6IAqfaXeI6aJF84SHLdyVJvjNoRU6eFqeRsREcM2yGc0XmmmOYmsI3pC9xZUW/RepFxbMUMpPF2keioOGqjKiXIA9hm62mwkSm6V1qbPTYD6eo9uvquppei1aTkwzDq68QTFqaZg3lo9ZXsSvTVx+eAv07G7U8CnmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963203; c=relaxed/simple;
	bh=VIV5KmYnIo29PwS5f0qzlxSGIMjv1IKIgpsN71cNdmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=geVK5Bw44sETCad3thmN1ZySBc0b9gIRkKw6IMw3NLPkRJHaCRNHNufMGjP5+43928AemGelYtKNtER5bWy6uG9EwioKvxIqc+YMJw+uTmveOFn+s3cZaB/FrgUiFxKtTXPnvs3J1Y00VgNE0JIqGoWgR77SqBVnyx+8k41XFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rdn8cNK0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdn8cNK0"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4859b45abadso521646f8f.2
        for <linux-rtc@vger.kernel.org>; Wed, 09 Sep 2026 07:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788963199; x=1789567999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/8u8VJpPTCQW06OMcbNJMSceQi2D6H3mdsBS77V+NZc=;
        b=rdn8cNK03iaRsy/NzQaYt0kY1z6Pm7EWzTw4EgiEqJ4zBkbF80tAjUfELdjWnKfcXR
         mLgPwUKK5C5PAPG9hL4NCXQCgSzcDxSL2k3kSBATbzNsFtHPmXjHmoxmE9xFgHEJZKTX
         +V3C4JOWx6a1qeGYK8gM4/wV/OoO42xaeIKw8FnwlrT/BCaOmASpcdz9qvnOxGZs6c/3
         okeF8oTRXI3o8t3F8maDQXEGqqnaaXEDtntx0/3OLMgIs8SHyUf2ch3iKtr3Or9x57gO
         oFB37rKlaUDt8AC9mAxBsaZRv978xNhQIfMVGwmZR3D4zvKyMQ7QaxjEByMexSX/Jt7O
         X+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788963199; x=1789567999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/8u8VJpPTCQW06OMcbNJMSceQi2D6H3mdsBS77V+NZc=;
        b=Db9m/KNmYa6px64AvQM+r4kIhX8XzCj5xriJbi9+ySXBSbyFAxH9vfM2gqwrKD3NKw
         FQIhJopO5Pl/Wbr9qkSP4BEugmTBK7MNO4XKL/qq0o2oudJPStayPGzZ1zSm7rEP8g1m
         gltuokMDHHzjUZfzPxCkkRtPdpd00V5E1rWijLcArkXiNqlhdRK4wSEGh+bNzYtv2uyC
         5GdQ1/LsD3spLs+19z0GHGKOA/wlf0U0rjPSf4vScdi50op2LNJe074JsFoNcck9smZY
         1Wtz/Rx9IThYAyZ9iF8aQ89mcOOD6sCY3Z1BZS9BhT7BT/ADLgMIEVfZUZljnIQr3dOr
         uRlw==
X-Forwarded-Encrypted: i=1; AKwUvBwcsfGbRQQl5pIIEpTAnrq6MuXeEBKAOa5RkhmeADxnVTklGp0aXQlH2j6wBb3nOyWaN+dQfvjqLEI=@vger.kernel.org
X-Gm-Message-State: AFuF++l3ALi9mxYf/rzrPUrALqOlNXFb4OpWOhn9s/rvOWkiK+joBrD2
	58ZhaNtoyaaGw4lNbkjyafQFEmpZbj3NR3BNM2qlPaRAV7IzVk9fMpx7
X-Gm-Gg: AYBFou36K8GSmI3gx7aE+ygPw6RucErqZEBUXSrQ/eQPfRhYRafOxVxVYWOgyVvUI9I
	gzPcyV9gDbwCKcACUwi3Au4D0JG0gavhXetfe5oZrMobRblh7PNdmm0S6zha+9RH8KBf91e/wbo
	UN7r6hR9d603PaMe7QOh1D9Ukv53xdhuVD1MUKIJRsk9rSjYU0CCuTm4LMRg6RJGm1ODJdhSBf9
	l+al7q4UoNCqx3+jaPgU1NfUx3X75+cPzNZMM0tFJlr8oB20CY5TZ+S8iRED7GB/9deDJU0on6u
	P4+n+QRHQczM7CpmN29dE1ZGRhoH+pPBjS3PDMk79uBrN9mlIkZ5sVxdqo8azm9FhKro2Le4wJ3
	t4udZgUFOoRtdB/evTT9izAmFlT8E655o/bTbdNtBimaZQYe31VMGVw0W4thcs6WGsMkC93E9/+
	2FQBDVYGDXzw/hAsiw9fcIU6RlUBJtma3swk/R0/IeGZnYf5Pde1gEymdMB5D4t9/77so8thoYG
	hLBAUFc62QYF/gkilWJ+ubxyNvTeYgCOj43DUh7cVhEJw==
X-Received: by 2002:a05:6000:186d:b0:485:ac0e:6fb2 with SMTP id ffacd0b85a97d-485ac0e70a4mr5799917f8f.18.1788963199268;
        Wed, 09 Sep 2026 07:13:19 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c074asm43273521f8f.23.2026.09.09.07.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:13:18 -0700 (PDT)
From: Sander Speetjens <sander.speetjens@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	sander.speetjens@gmail.com,
	Dom Cobley <popcornmix@gmail.com>
Subject: [PATCH 2/3] rtc: Add Raspberry Pi 5 RTC driver
Date: Wed,  9 Sep 2026 16:12:59 +0200
Message-ID: <20260909141300.1368790-3-sander.speetjens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909141300.1368790-1-sander.speetjens@gmail.com>
References: <20260909141300.1368790-1-sander.speetjens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Bell <jonathan@raspberrypi.com>

Upstreaming the downstream Raspberry Pi 5 RTC driver.
This driver supports the custom DA9091, which is accessed through the firmware mailbox.

Co-developed-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
---
 drivers/rtc/Kconfig   |  11 ++
 drivers/rtc/Makefile  |   1 +
 drivers/rtc/rtc-rpi.c | 277 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 289 insertions(+)
 create mode 100644 drivers/rtc/rtc-rpi.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 05b9233b9418..382973d46e06 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1999,6 +1999,17 @@ config RTC_DRV_R7301
 	   This driver can also be built as a module. If so, the module
 	   will be called rtc-r7301.
 
+config RTC_DRV_RPI
+        tristate "Raspberry Pi RTC"
+        depends on ARCH_BRCMSTB || COMPILE_TEST
+        default ARCH_BRCMSTB
+        help
+          If you say yes here you get support for the RTC found on
+          Raspberry Pi devices.
+
+          This driver can also be built as a module. If so, the module
+          will be called rtc-rpi.
+
 config RTC_DRV_STM32
 	tristate "STM32 RTC"
 	select REGMAP_MMIO
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 0347645b021f..78551bb04c5c 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -148,6 +148,7 @@ obj-$(CONFIG_RTC_DRV_RC5T583)	+= rtc-rc5t583.o
 obj-$(CONFIG_RTC_DRV_RC5T619)	+= rtc-rc5t619.o
 obj-$(CONFIG_RTC_DRV_RK808)	+= rtc-rk808.o
 obj-$(CONFIG_RTC_DRV_RP5C01)	+= rtc-rp5c01.o
+obj-$(CONFIG_RTC_DRV_RPI)	+= rtc-rpi.o
 obj-$(CONFIG_RTC_DRV_RS5C313)	+= rtc-rs5c313.o
 obj-$(CONFIG_RTC_DRV_RS5C348)	+= rtc-rs5c348.o
 obj-$(CONFIG_RTC_DRV_RS5C372)	+= rtc-rs5c372.o
diff --git a/drivers/rtc/rtc-rpi.c b/drivers/rtc/rtc-rpi.c
new file mode 100644
index 000000000000..e455b4116957
--- /dev/null
+++ b/drivers/rtc/rtc-rpi.c
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/**
+ * rtc-rpi.c
+ *
+ * RTC driver using firmware mailbox
+ * Supports battery backed RTC and wake alarms
+ *
+ * Based on rtc-meson-vrtc by Neil Armstrong
+ *
+ * Copyright (c) 2023, Raspberry Pi Ltd.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+#include <linux/of.h>
+#include <soc/bcm2835/raspberrypi-firmware.h>
+
+struct rpi_rtc_data {
+	struct rtc_device *rtc;
+	struct rpi_firmware *fw;
+	u32 bbat_vchg_microvolts;
+};
+
+#define RPI_FIRMWARE_GET_RTC_REG 0x00030087
+#define RPI_FIRMWARE_SET_RTC_REG 0x00038087
+
+enum {
+	RTC_TIME,
+	RTC_ALARM,
+	RTC_ALARM_PENDING,
+	RTC_ALARM_ENABLE,
+	RTC_BBAT_CHG_VOLTS,
+	RTC_BBAT_CHG_VOLTS_MIN,
+	RTC_BBAT_CHG_VOLTS_MAX,
+	RTC_BBAT_VOLTS
+};
+
+static int rpi_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
+	u32 data[2] = {RTC_TIME};
+	int err;
+
+	err = rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
+				    &data, sizeof(data));
+	rtc_time64_to_tm(data[1], tm);
+	return err;
+}
+
+static int rpi_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
+	u32 data[2] = {RTC_TIME, rtc_tm_to_time64(tm)};
+
+	return rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
+				     &data, sizeof(data));
+}
+
+static int rpi_rtc_alarm_irq_is_enabled(struct device *dev, unsigned char *enabled)
+{
+	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
+	u32 data[2] = {RTC_ALARM_ENABLE};
+	s32 err = 0;
+
+	err = rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
+				    &data, sizeof(data));
+	*enabled = data[1] & 0x1;
+	return err;
+}
+
+static int rpi_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
+	u32 data[2] = {RTC_ALARM_ENABLE, enabled};
+
+	return rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
+				     &data, sizeof(data));
+}
+
+static int rpi_rtc_alarm_clear_pending(struct device *dev)
+{
+	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
+	u32 data[2] = {RTC_ALARM_PENDING, 1};
+
+	return rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
+				     &data, sizeof(data));
+}
+
+static int rpi_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
+	u32 data[2] = {RTC_ALARM};
+	s32 err = 0;
+
+	err = rpi_rtc_alarm_irq_is_enabled(dev, &alarm->enabled);
+	if (!err)
+		err = rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
+					    &data, sizeof(data));
+	rtc_time64_to_tm(data[1], &alarm->time);
+
+	return err;
+}
+
+static int rpi_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
+	u32 data[2] = {RTC_ALARM, rtc_tm_to_time64(&alarm->time)};
+	int err;
+
+	err = rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
+				    &data, sizeof(data));
+
+	if (err == 0)
+		err = rpi_rtc_alarm_irq_enable(dev, alarm->enabled);
+
+	return err;
+}
+
+static const struct rtc_class_ops rpi_rtc_ops = {
+	.read_time = rpi_rtc_read_time,
+	.set_time = rpi_rtc_set_time,
+	.read_alarm = rpi_rtc_read_alarm,
+	.set_alarm = rpi_rtc_set_alarm,
+	.alarm_irq_enable = rpi_rtc_alarm_irq_enable,
+};
+
+static int rpi_rtc_set_charge_voltage(struct device *dev)
+{
+	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
+	u32 data[2] = {RTC_BBAT_CHG_VOLTS, vrtc->bbat_vchg_microvolts};
+	int err;
+
+	err = rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
+				    &data, sizeof(data));
+
+	if (err)
+		dev_err(dev, "failed to set trickle charge voltage to %uuV: %d\n",
+			vrtc->bbat_vchg_microvolts, err);
+	else if (vrtc->bbat_vchg_microvolts)
+		dev_info(dev, "trickle charging enabled at %uuV\n",
+			 vrtc->bbat_vchg_microvolts);
+
+	return err;
+}
+
+static ssize_t rpi_rtc_print_uint_reg(struct device *dev, char *buf, u32 reg)
+{
+	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev->parent);
+	u32 data[2] = {reg, 0};
+	int ret = 0;
+
+	ret = rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
+				    &data, sizeof(data));
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%u\n", data[1]);
+}
+
+static ssize_t charging_voltage_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	return rpi_rtc_print_uint_reg(dev, buf, RTC_BBAT_CHG_VOLTS);
+}
+static DEVICE_ATTR_RO(charging_voltage);
+
+static ssize_t charging_voltage_min_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return rpi_rtc_print_uint_reg(dev, buf, RTC_BBAT_CHG_VOLTS_MIN);
+}
+static DEVICE_ATTR_RO(charging_voltage_min);
+
+static ssize_t charging_voltage_max_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return rpi_rtc_print_uint_reg(dev, buf, RTC_BBAT_CHG_VOLTS_MAX);
+}
+static DEVICE_ATTR_RO(charging_voltage_max);
+
+static ssize_t battery_voltage_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	return rpi_rtc_print_uint_reg(dev, buf, RTC_BBAT_VOLTS);
+}
+static DEVICE_ATTR_RO(battery_voltage);
+
+static struct attribute *rpi_rtc_attrs[] = {
+	&dev_attr_charging_voltage.attr,
+	&dev_attr_charging_voltage_min.attr,
+	&dev_attr_charging_voltage_max.attr,
+	&dev_attr_battery_voltage.attr,
+	NULL
+};
+
+static const struct attribute_group rpi_rtc_sysfs_files = {
+	.attrs = rpi_rtc_attrs,
+};
+
+static int rpi_rtc_probe(struct platform_device *pdev)
+{
+	struct rpi_rtc_data *vrtc;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *fw_node;
+	struct rpi_firmware *fw;
+	int ret;
+
+	fw_node = of_parse_phandle(np, "firmware", 0);
+	if (!fw_node) {
+		dev_err(dev, "Missing firmware node\n");
+		return -ENOENT;
+	}
+
+	fw = rpi_firmware_get(fw_node);
+	if (!fw)
+		return -EPROBE_DEFER;
+
+	vrtc = devm_kzalloc(&pdev->dev, sizeof(*vrtc), GFP_KERNEL);
+	if (!vrtc)
+		return -ENOMEM;
+
+	vrtc->fw = fw;
+
+	device_init_wakeup(&pdev->dev, 1);
+
+	platform_set_drvdata(pdev, vrtc);
+
+	vrtc->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(vrtc->rtc))
+		return PTR_ERR(vrtc->rtc);
+
+	set_bit(RTC_FEATURE_ALARM_WAKEUP_ONLY, vrtc->rtc->features);
+	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, vrtc->rtc->features);
+
+	vrtc->rtc->ops = &rpi_rtc_ops;
+	ret = rtc_add_group(vrtc->rtc, &rpi_rtc_sysfs_files);
+	if (ret)
+		return ret;
+
+	rpi_rtc_alarm_clear_pending(dev);
+
+	/*
+	 * Optionally enable trickle charging - if the property isn't
+	 * present (or set to zero), trickle charging is disabled.
+	 */
+	of_property_read_u32(np, "trickle-charge-microvolt",
+			     &vrtc->bbat_vchg_microvolts);
+
+	rpi_rtc_set_charge_voltage(dev);
+
+	return devm_rtc_register_device(vrtc->rtc);
+}
+
+static const struct of_device_id rpi_rtc_dt_match[] = {
+	{ .compatible = "raspberrypi,rpi-rtc"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, rpi_rtc_dt_match);
+
+static struct platform_driver rpi_rtc_driver = {
+	.probe = rpi_rtc_probe,
+	.driver = {
+		.name = "rpi-rtc",
+		.of_match_table = rpi_rtc_dt_match,
+	},
+};
+
+module_platform_driver(rpi_rtc_driver);
+
+MODULE_DESCRIPTION("Raspberry Pi RTC driver");
+MODULE_LICENSE("GPL");
\ No newline at end of file
-- 
2.55.0

