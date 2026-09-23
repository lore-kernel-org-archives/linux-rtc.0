Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A65F52F286
	for <linux-rtc@vger.kernel.org>; Wed, 23 Sep 2026 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169229; cv=none; b=q0U5m5eOF1vde0BxUyBsbC3QWzdUlznDAC5+YVaSiqN7d0ibueQ8ZIc3S7Ym5d+M7YvZE/VZyZDy2Rw8CNrHMsiDAiF4j8Ts8x+fyQGxkGbv/lAsq+8uQ5rEcNjxJSdvS2xYpEFbe9wsxc5iZCKH9blHAVOzhaMmlHKRY+FSGyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169229; c=relaxed/simple;
	bh=FnlSZ0yUKbyivxQJDoZQIyPPx+FpIkB4KKaU08sImQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlYeCcqpIM/NuU/rsAhKEtLJ5COvilEO9kLAqKN2xrjHcY1AKhplMcqGLnI7i1a0eosr5eJtal6ilXDGwCeftThM3lJd3ut/+/OgKZzQrLF6KbTmG7lNdvqshikkjK7zQsTl7izhgL/4RF7tWt7WZAKItnYZw2bOkWY4/QM4R2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3DvTS22; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3DvTS22"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso7751985e9.1
        for <linux-rtc@vger.kernel.org>; Wed, 23 Sep 2026 06:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169225; x=1790774025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=slzyTwicRG2x+1smgIS8YIiwRQ+ZNY+zJFdtpnpz9zk=;
        b=h3DvTS22FXLgHuqTA+uTX0Ug4cxLm4BySZCRwB3mwjQcSa4s6DC0d4bQ4IkutUQGgl
         +ZyjNcHUnS+Nm0QhPrDbcJluUby4otTm88CHUL0qJlpuPymuKofx2ShCWwTaOi9GHBNM
         tI5jFBHZP+BJ3XJaAJVxNe5DUdOuQfjmfz7qq91YuSvKpudWeDU5pIKoq70FM+06RpkB
         FPv+jCqSgEx3Hu82jLm3VhvUifdTOMoweWxdqIyl3pH/zwULJ249CPTysF9jpsmHWrmA
         5zb5EhZZegxsI7DAIPFv9+w/J9o/WRZmPIaPWeBAGOkllH0Tf6Ev5um5JeEC6XSj0dQy
         86vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169225; x=1790774025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=slzyTwicRG2x+1smgIS8YIiwRQ+ZNY+zJFdtpnpz9zk=;
        b=aI6gtPi+vHcqF+U86sWouAyk68wnlw0dASGeNPnp6ihnHdcg2XNkjxoyabL4BiEBxM
         BvTTU5p5lgL10izRL/098m+7NKVplH5IkZ29mUUsBq4x392nhC77MBI7cK9dcwlROWap
         SovTDRiFKgk3ACsUszFeeN+uMNIsa9KDJyhC+tit+Uw/0lldwNoHaIMHxfDw8EqgYRwO
         AJH7zBWNtgRg3kHcR1x54Zt6JL8NmhknMT5IZuuf7hN1rI5fwWF05deYSqyi0jShzWOv
         8vlaxzsXy09F5H0L6NWM5gNmsANlpzEWLOmQezxl/PMYTRiHAXKyqrJjRAGosV9+8a6n
         IIEA==
X-Forwarded-Encrypted: i=1; AKwUvBxiKugs+jaBxbO8cjhva593ewu89v2Rl1bJj/5NH2NRWNpq5OGI3vBVMZgkytdS51+Cjmjx/+Rg7I8=@vger.kernel.org
X-Gm-Message-State: AFuF++nXQ0dcSVFTQyOSpShXpTx766h5I98GLo9coXGzdEEo3wYLPHjW
	s0S7nVApH7mr0D3wXijlSQsAN4qvdiE/eSHtlCITKk6U+3y3EXvlvKVg
X-Gm-Gg: AYBFou1hUj8QicGQCpPdWHTQ3Fu+/DMF5UgyEfSskE1i4crQNRhsPSvbog/aHETVuo8
	Zkw2oziY+RkjdYIXte0q9CXWoB4te3lAgAeltKqwlTlCE8BD0g3kkVdftCIkBHr+7DAtmX3WvOg
	762rIl/T8jU+xbBbo4lBpqjFyMUvnWOqn8MfdAAr4BtMx8UED5aZeaPTyJPJzsOOQRBE+Up1dWZ
	ehp6E74Hl/Iir/BuduvXrEFZReNB0xPhl33l8fdp7sEgDkMovETu+02tyltlwNOmOaacUAXn/c2
	qB8iI+wy4OsraxHH9jC+0yfzaPOBwsD45bgP0zACC45v4GwtbEnU2LfeEI7tnc6iaBBQl0fx62/
	B4l1RKZ4SykXAoJiAcA8d17dj0ChHZO/qLfTZY9nslCous1xOGx8gIaZA3aiIdKD1XfTm4z1EPY
	fwZ5VZEA9dJLHCcZRuP7IXkNr6cJpZAHLVI5serdvgCo0hy3AQ7vw+wbf7WBACmjvzt/QuD80ij
	LmAxUyJOj96y2eu/hwZvxbNQa6D/ROBDkarXaaI79Nqgw==
X-Received: by 2002:a05:600c:c493:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-49fdf1468e2mr30957675e9.26.1790169225418;
        Wed, 23 Sep 2026 06:13:45 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c3731fsm57230235e9.2.2026.09.23.06.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:13:44 -0700 (PDT)
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
Subject: [PATCH v4 2/2] rtc: Add Raspberry Pi 5 RTC driver
Date: Wed, 23 Sep 2026 15:13:23 +0200
Message-ID: <20260923131323.1099979-3-sander.speetjens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923131323.1099979-1-sander.speetjens@gmail.com>
References: <20260923131323.1099979-1-sander.speetjens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upstreaming the downstream Raspberry Pi 5 RTC driver.
This driver supports the custom DA9091,
which is accessed through the firmware mailbox.

Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
---
V3 -> V4:
- Fix Kconfig depends that disallows having Raspberrypi
firmware built as a module while the rtc driver is built in
- Remove sysfs
- Add limits from firmware properties and check in rpi_rtc_set_charge_voltage

V2 -> V3:
- Move platform check to firmware and abort before registering
a platform device if on another platform
- Add a dependency on the Raspberry Pi firmware to Kconfig
- Check return value of devm_device_init_wakeup
- Fix property name

V1 -> V2:
Instead of the original driver, which was directly bound to the device tree.
This driver is bound to the Raspberry Pi firmware device by creating
a child device in the firmware driver probe function.
The child device is then bound to this driver,
which uses the firmware mailbox to access the RTC.

A couple of minor changes have been made to the driver since it was originally written, including:
- Checking if the model is a Raspberry Pi 5, as the RTC is only present on that model.
- Using the new devm_rpi_firmware_get() and devm_init_wakeup() helper to get the firmware device and avoid leaking memory.
- Using millivolts instead of microvolts for the trickle charge voltage, to match the RTC standard.
- Instead of setting the trickle charge voltage to 0 to disable trickle charging, the property is now optional. If the property is not present, trickle charging is disabled, per the RTC standard.
- Renaming the driver dt match compatible to "raspberrypi,firmware-rtc" to match the other firmware bindings.
- Renaming the driver name to "raspberrypi-rtc" to match the other firmware drivers.

 drivers/firmware/raspberrypi.c |  25 ++++
 drivers/rtc/Kconfig            |  12 ++
 drivers/rtc/Makefile           |   1 +
 drivers/rtc/rtc-raspberrypi.c  | 242 +++++++++++++++++++++++++++++++++
 4 files changed, 280 insertions(+)
 create mode 100644 drivers/rtc/rtc-raspberrypi.c

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index 0aa322e9a2e7..a35f00c6fb2c 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -24,6 +24,7 @@
 
 static struct platform_device *rpi_hwmon;
 static struct platform_device *rpi_clk;
+static struct platform_device *rpi_rtc;
 
 struct rpi_firmware {
 	struct mbox_client cl;
@@ -231,6 +232,27 @@ static void rpi_register_clk_driver(struct device *dev)
 						-1, NULL, 0);
 }
 
+static void rpi_register_rtc_driver(struct device *dev)
+{
+	struct device_node *firmware;
+
+	// Check if our model is a Raspberry Pi 5, as the RTC is only present on that model.
+	const char *model = of_get_property(of_root, "model", NULL);
+
+	if (!model || strncmp(model, "Raspberry Pi 5", 14) != 0)
+		return;
+
+	firmware = of_get_compatible_child(dev->of_node,
+					   "raspberrypi,firmware-rtc");
+	if (firmware) {
+		of_node_put(firmware);
+		return;
+	}
+
+	rpi_rtc = platform_device_register_data(dev, "raspberrypi-rtc",
+						-1, NULL, 0);
+}
+
 unsigned int rpi_firmware_clk_get_max_rate(struct rpi_firmware *fw, unsigned int id)
 {
 	struct rpi_firmware_clk_rate_request msg =
@@ -305,6 +327,7 @@ static int rpi_firmware_probe(struct platform_device *pdev)
 	rpi_firmware_print_firmware_revision(fw);
 	rpi_register_hwmon_driver(dev, fw);
 	rpi_register_clk_driver(dev);
+	rpi_register_rtc_driver(dev);
 
 	return 0;
 }
@@ -327,6 +350,8 @@ static void rpi_firmware_remove(struct platform_device *pdev)
 	rpi_hwmon = NULL;
 	platform_device_unregister(rpi_clk);
 	rpi_clk = NULL;
+	platform_device_unregister(rpi_rtc);
+	rpi_rtc = NULL;
 
 	rpi_firmware_put(fw);
 }
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 05b9233b9418..88006f83d7bc 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1999,6 +1999,18 @@ config RTC_DRV_R7301
 	   This driver can also be built as a module. If so, the module
 	   will be called rtc-r7301.
 
+config RTC_DRV_RPI
+        tristate "Raspberry Pi RTC"
+	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
+        depends on ARCH_BRCMSTB || COMPILE_TEST
+        default ARCH_BRCMSTB
+        help
+          If you say yes here you get support for the RTC found on
+          Raspberry Pi devices.
+
+          This driver can also be built as a module. If so, the module
+          will be called rtc-raspberrypi.
+
 config RTC_DRV_STM32
 	tristate "STM32 RTC"
 	select REGMAP_MMIO
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 0347645b021f..46f1a0fc2416 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -144,6 +144,7 @@ obj-$(CONFIG_RTC_DRV_PS3)	+= rtc-ps3.o
 obj-$(CONFIG_RTC_DRV_PXA)	+= rtc-pxa.o
 obj-$(CONFIG_RTC_DRV_R7301)	+= rtc-r7301.o
 obj-$(CONFIG_RTC_DRV_R9701)	+= rtc-r9701.o
+obj-$(CONFIG_RTC_DRV_RPI)	+= rtc-raspberrypi.o
 obj-$(CONFIG_RTC_DRV_RC5T583)	+= rtc-rc5t583.o
 obj-$(CONFIG_RTC_DRV_RC5T619)	+= rtc-rc5t619.o
 obj-$(CONFIG_RTC_DRV_RK808)	+= rtc-rk808.o
diff --git a/drivers/rtc/rtc-raspberrypi.c b/drivers/rtc/rtc-raspberrypi.c
new file mode 100644
index 000000000000..f67ab156dc46
--- /dev/null
+++ b/drivers/rtc/rtc-raspberrypi.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/**
+ * rtc-raspberrypi.c
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
+struct rpi_rtc_data {
+	struct rtc_device *rtc;
+	struct rpi_firmware *fw;
+	u32 bbat_vchg_millivolts;
+	u32 bbat_vchg_min_millivolts;
+	u32 bbat_vchg_max_millivolts;
+};
+
+static int rpi_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
+	u32 data[2] = { RTC_TIME };
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
+	u32 data[2] = { RTC_TIME, rtc_tm_to_time64(tm) };
+
+	return rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
+				     &data, sizeof(data));
+}
+
+static int rpi_rtc_alarm_irq_is_enabled(struct device *dev, unsigned char *enabled)
+{
+	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
+	u32 data[2] = { RTC_ALARM_ENABLE };
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
+	u32 data[2] = { RTC_ALARM_ENABLE, enabled };
+
+	return rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
+				     &data, sizeof(data));
+}
+
+static int rpi_rtc_alarm_clear_pending(struct device *dev)
+{
+	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
+	u32 data[2] = { RTC_ALARM_PENDING, 1 };
+
+	return rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
+				     &data, sizeof(data));
+}
+
+static int rpi_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
+	u32 data[2] = { RTC_ALARM };
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
+	u32 data[2] = { RTC_ALARM, rtc_tm_to_time64(&alarm->time) };
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
+static void rpi_rtc_set_limits(struct device *dev)
+{
+	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
+	u32 data[2] = { RTC_BBAT_CHG_VOLTS_MIN };
+
+	int err = rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
+					&data, sizeof(data));
+	if (err == 0)
+		vrtc->bbat_vchg_min_millivolts = data[1] / 1000U;
+
+	data[0] = RTC_BBAT_CHG_VOLTS_MAX;
+	data[1] = 0;
+	err = rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
+				    &data, sizeof(data));
+	if (err == 0)
+		vrtc->bbat_vchg_max_millivolts = data[1] / 1000U;
+}
+
+static int rpi_rtc_set_charge_voltage(struct device *dev)
+{
+	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
+	u32 data[2] = { RTC_BBAT_CHG_VOLTS, vrtc->bbat_vchg_millivolts * 1000U };
+	int err;
+
+	if (vrtc->bbat_vchg_millivolts != 0 &&
+	    (vrtc->bbat_vchg_millivolts < vrtc->bbat_vchg_min_millivolts ||
+	    vrtc->bbat_vchg_millivolts > vrtc->bbat_vchg_max_millivolts)) {
+		dev_warn(dev, "trickle charge voltage %umV is outside of the supported range (%umV - %umV)\n",
+			 vrtc->bbat_vchg_millivolts,
+			 vrtc->bbat_vchg_min_millivolts,
+			 vrtc->bbat_vchg_max_millivolts);
+		return -EINVAL;
+	}
+
+	err = rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
+				    &data, sizeof(data));
+
+	if (err)
+		dev_err(dev, "failed to set trickle charge voltage to %umV: %d\n",
+			vrtc->bbat_vchg_millivolts, err);
+	else if (vrtc->bbat_vchg_millivolts)
+		dev_info(dev, "trickle charging enabled at %umV\n",
+			 vrtc->bbat_vchg_millivolts);
+
+	return err;
+}
+
+static int rpi_rtc_probe(struct platform_device *pdev)
+{
+	struct rpi_rtc_data *vrtc;
+	struct device *dev = &pdev->dev;
+	struct rpi_firmware *firmware;
+	int ret;
+
+	// Get the firmware device from the parent device
+	firmware = devm_rpi_firmware_get(dev, dev->parent->of_node);
+
+	if (!firmware)
+		return -EPROBE_DEFER;
+
+	vrtc = devm_kzalloc(dev, sizeof(*vrtc), GFP_KERNEL);
+	if (!vrtc)
+		return -ENOMEM;
+
+	vrtc->fw = firmware;
+
+	ret = devm_device_init_wakeup(dev);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, vrtc);
+
+	vrtc->rtc = devm_rtc_allocate_device(dev);
+	if (IS_ERR(vrtc->rtc))
+		return PTR_ERR(vrtc->rtc);
+
+	vrtc->rtc->range_max = U32_MAX;           /* 2106-02-07 */
+
+	set_bit(RTC_FEATURE_ALARM_WAKEUP_ONLY, vrtc->rtc->features);
+	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, vrtc->rtc->features);
+
+	vrtc->rtc->ops = &rpi_rtc_ops;
+
+	rpi_rtc_alarm_clear_pending(dev);
+
+	vrtc->bbat_vchg_millivolts = 0;
+	of_property_read_u32(dev->parent->of_node, "trickle-voltage-millivolt",
+			     &vrtc->bbat_vchg_millivolts);
+
+	rpi_rtc_set_limits(dev);
+	rpi_rtc_set_charge_voltage(dev);
+
+	return devm_rtc_register_device(vrtc->rtc);
+}
+
+static const struct of_device_id rpi_rtc_dt_match[] = {
+	{ .compatible = "raspberrypi,firmware-rtc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rpi_rtc_dt_match);
+
+static struct platform_driver rpi_rtc_driver = {
+	.driver = {
+		.name = "raspberrypi-rtc",
+		.of_match_table = of_match_ptr(rpi_rtc_dt_match),
+	},
+	.probe = rpi_rtc_probe
+};
+
+module_platform_driver(rpi_rtc_driver);
+
+MODULE_AUTHOR("Jonathan Bell <jonathan@raspberrypi.com>");
+MODULE_AUTHOR("Sander Speetjens <sander.speetjens@gmail.com>");
+MODULE_DESCRIPTION("Raspberry Pi RTC driver");
+MODULE_LICENSE("GPL");
-- 
2.55.0

