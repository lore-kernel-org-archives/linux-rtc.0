Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B6A351C11;
	Wed, 30 Sep 2026 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760547; cv=none; b=ljL9Vb5arwDaVbECz4p3c7qNYtOLdC4D+I0rDNoRaF4MLIALqJfVwJaGZu0ITFjDjgkRBrHyilUOZpbLf/A3j5m5QiwCwHkU19OuzrvmFcC23BH9hSmJoyTpy6ZECPZEkIuNgQs+RlW7KY9Cg4POMbveuGMECk5I+6x2Ji9n2X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760547; c=relaxed/simple;
	bh=x3F8PREM9ofdH6pisYz9yQdpqY4Bc3ELU2az9Y4Tpgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfE+snurQXf59P0Zu16/PI9+58l0THfj2mLcwzln/rlciXcJgPc4zQpAco0j/0R6v5W7eVH7gwGgOVz1K4gYItYk78VVX5PT5gBF+kpLSQJ13l3lmJuEb2ydThAIxhk9g9sMtxYrKcBRwx6JqapKYGJFkp2WlanzYgO4Cy+XVAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lmLrnyTs; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lmLrnyTs"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0D9F84E410D4;
	Wed, 30 Sep 2026 09:29:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BFE826074B;
	Wed, 30 Sep 2026 09:29:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E1CAD103292FD;
	Wed, 30 Sep 2026 11:28:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790760540; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=baX6O9uvy24kAKoq/5AiBsj43+HZszE5zQlIhk+MUm4=;
	b=lmLrnyTsJOl6QuHs6U3FqmeSbuTqsXfzHW/bjtFOj2zyN3wUvFsNCn2JiJSK6+X8n5maIY
	9tWw5NOIvqa3/5ufDSQDvDqVLHQzBdEuw6hkZYR6LK8QTwMsYmrbRpj/2AoDltupLnAeTA
	n7p8rsEwF6Rn31Zzr/xGcL2yhWAjFv23HJcdBwm2bSmmOcf2SJRLIpNXCOsBzx6WiBIm2b
	D0T6UKZpdIaeq/VTc85ueuXLhLhv3JsUZkG4iiWZ2ZOfHyQdvV+/HjTi4HyekDBJiIu/8q
	VfEYpcU/hHPyNAMO+k5A3ZPDtzZFdvDc8zPmfNbCnrQJfsKrNuiYHwc6R/VGzw==
Date: Wed, 30 Sep 2026 11:28:56 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Sander Speetjens <sander.speetjens@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, pbrobinson@gmail.com,
	Dom Cobley <popcornmix@gmail.com>
Subject: Re: [PATCH v7 2/2] rtc: Add Raspberry Pi 5 RTC driver
Message-ID: <2026093009285640969916@mail.local>
References: <20260930083922.484885-1-sander.speetjens@gmail.com>
 <20260930083922.484885-3-sander.speetjens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930083922.484885-3-sander.speetjens@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 30/09/2026 10:39:22+0200, Sander Speetjens wrote:
> Upstreaming the downstream Raspberry Pi 5 RTC driver.
> This driver supports the custom DA9091,
> which is accessed through the firmware mailbox.
> 
> Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
> ---
> V6 -> V7:
> - Move from u32 array to struct
> - Fix encapsulation as mentioned by sashiko-bot
> 
> V5 -> V6:
> - Add MODULE_ALIAS, as mentioned by sashiko-bot
> - Encapsulate the mailbox data in le32_to_cpu or cpu_to_le32, as
>   mentioned by sashiko-bot. For good practice
> 
> V4 -> V5: No changes
> 
> V3 -> V4:
> - Fix Kconfig depends that disallows having Raspberrypi
> firmware built as a module while the rtc driver is built in
> - Remove sysfs
> - Add limits from firmware properties and check in rpi_rtc_set_charge_voltage
> 
> V2 -> V3:
> - Move platform check to firmware and abort before registering
> a platform device if on another platform
> - Add a dependency on the Raspberry Pi firmware to Kconfig
> - Check return value of devm_device_init_wakeup
> - Fix property name
> 
> V1 -> V2:
> Instead of the original driver, which was directly bound to the device tree.
> This driver is bound to the Raspberry Pi firmware device by creating
> a child device in the firmware driver probe function.
> The child device is then bound to this driver,
> which uses the firmware mailbox to access the RTC.
> 
> A couple of minor changes have been made to the driver since it was originally written, including:
> - Checking if the model is a Raspberry Pi 5, as the RTC is only present on that model.
> - Using the new devm_rpi_firmware_get() and devm_init_wakeup() helper to get the firmware device and avoid leaking memory.
> - Using millivolts instead of microvolts for the trickle charge voltage, to match the RTC standard.
> - Instead of setting the trickle charge voltage to 0 to disable trickle charging, the property is now optional. If the property is not present, trickle charging is disabled, per the RTC standard.
> - Renaming the driver dt match compatible to "raspberrypi,firmware-rtc" to match the other firmware bindings.
> - Renaming the driver name to "raspberrypi-rtc" to match the other firmware drivers.
> 
>  drivers/firmware/raspberrypi.c |  25 +++
>  drivers/rtc/Kconfig            |  12 ++
>  drivers/rtc/Makefile           |   1 +
>  drivers/rtc/rtc-raspberrypi.c  | 279 +++++++++++++++++++++++++++++++++
>  4 files changed, 317 insertions(+)
>  create mode 100644 drivers/rtc/rtc-raspberrypi.c
> 
> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
> index 0aa322e9a2e7..a35f00c6fb2c 100644
> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
> @@ -24,6 +24,7 @@
>  
>  static struct platform_device *rpi_hwmon;
>  static struct platform_device *rpi_clk;
> +static struct platform_device *rpi_rtc;
>  
>  struct rpi_firmware {
>  	struct mbox_client cl;
> @@ -231,6 +232,27 @@ static void rpi_register_clk_driver(struct device *dev)
>  						-1, NULL, 0);
>  }
>  
> +static void rpi_register_rtc_driver(struct device *dev)
> +{
> +	struct device_node *firmware;
> +
> +	// Check if our model is a Raspberry Pi 5, as the RTC is only present on that model.
> +	const char *model = of_get_property(of_root, "model", NULL);
> +
> +	if (!model || strncmp(model, "Raspberry Pi 5", 14) != 0)
> +		return;
> +
> +	firmware = of_get_compatible_child(dev->of_node,
> +					   "raspberrypi,firmware-rtc");
> +	if (firmware) {
> +		of_node_put(firmware);
> +		return;
> +	}
> +
> +	rpi_rtc = platform_device_register_data(dev, "raspberrypi-rtc",
> +						-1, NULL, 0);
> +}
> +
>  unsigned int rpi_firmware_clk_get_max_rate(struct rpi_firmware *fw, unsigned int id)
>  {
>  	struct rpi_firmware_clk_rate_request msg =
> @@ -305,6 +327,7 @@ static int rpi_firmware_probe(struct platform_device *pdev)
>  	rpi_firmware_print_firmware_revision(fw);
>  	rpi_register_hwmon_driver(dev, fw);
>  	rpi_register_clk_driver(dev);
> +	rpi_register_rtc_driver(dev);
>  
>  	return 0;
>  }
> @@ -327,6 +350,8 @@ static void rpi_firmware_remove(struct platform_device *pdev)
>  	rpi_hwmon = NULL;
>  	platform_device_unregister(rpi_clk);
>  	rpi_clk = NULL;
> +	platform_device_unregister(rpi_rtc);
> +	rpi_rtc = NULL;
>  
>  	rpi_firmware_put(fw);
>  }
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 05b9233b9418..4dbe20bcace8 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1999,6 +1999,18 @@ config RTC_DRV_R7301
>  	   This driver can also be built as a module. If so, the module
>  	   will be called rtc-r7301.
>  
> +config RTC_DRV_RPI
> +        tristate "Raspberry Pi RTC"
> +	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
> +        depends on ARCH_BRCMSTB || COMPILE_TEST
> +        default ARCH_BRCMSTB
> +        help
> +          If you say yes here you get support for the RTC found on
> +          Raspberry Pi devices.
> +
> +          This driver can also be built as a module. If so, the module
> +          will be called rtc-raspberrypi.
> +
>  config RTC_DRV_STM32
>  	tristate "STM32 RTC"
>  	select REGMAP_MMIO
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 0347645b021f..46f1a0fc2416 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -144,6 +144,7 @@ obj-$(CONFIG_RTC_DRV_PS3)	+= rtc-ps3.o
>  obj-$(CONFIG_RTC_DRV_PXA)	+= rtc-pxa.o
>  obj-$(CONFIG_RTC_DRV_R7301)	+= rtc-r7301.o
>  obj-$(CONFIG_RTC_DRV_R9701)	+= rtc-r9701.o
> +obj-$(CONFIG_RTC_DRV_RPI)	+= rtc-raspberrypi.o
>  obj-$(CONFIG_RTC_DRV_RC5T583)	+= rtc-rc5t583.o
>  obj-$(CONFIG_RTC_DRV_RC5T619)	+= rtc-rc5t619.o
>  obj-$(CONFIG_RTC_DRV_RK808)	+= rtc-rk808.o
> diff --git a/drivers/rtc/rtc-raspberrypi.c b/drivers/rtc/rtc-raspberrypi.c
> new file mode 100644
> index 000000000000..9f3f5d7683be
> --- /dev/null
> +++ b/drivers/rtc/rtc-raspberrypi.c
> @@ -0,0 +1,279 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/**
> + * rtc-raspberrypi.c
> + *
> + * RTC driver using firmware mailbox
> + * Supports battery backed RTC and wake alarms
> + *
> + * Based on rtc-meson-vrtc by Neil Armstrong
> + *
> + * Copyright (c) 2023, Raspberry Pi Ltd.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/rtc.h>
> +#include <linux/of.h>
> +#include <soc/bcm2835/raspberrypi-firmware.h>
> +
> +#define RPI_FIRMWARE_GET_RTC_REG 0x00030087
> +#define RPI_FIRMWARE_SET_RTC_REG 0x00038087
> +
> +enum {
> +	RTC_TIME,
> +	RTC_ALARM,
> +	RTC_ALARM_PENDING,
> +	RTC_ALARM_ENABLE,
> +	RTC_BBAT_CHG_VOLTS,
> +	RTC_BBAT_CHG_VOLTS_MIN,
> +	RTC_BBAT_CHG_VOLTS_MAX,
> +	RTC_BBAT_VOLTS
> +};
> +
> +struct rpi_rtc_data {
> +	struct rtc_device *rtc;
> +	struct rpi_firmware *fw;
> +	u32 bbat_vchg_millivolts;
> +	u32 bbat_vchg_min_millivolts;
> +	u32 bbat_vchg_max_millivolts;
> +};
> +
> +struct rpi_rtc_reg {
> +	__le32 reg;
> +	__le32 val;
> +} __packed;
> +
> +static int rpi_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
> +	struct rpi_rtc_reg data = {
> +		.reg = cpu_to_le32(RTC_TIME)
> +	};
> +	int err;
> +
> +	err = rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
> +				    &data, sizeof(data));
> +	rtc_time64_to_tm(le32_to_cpu(data.val), tm);
> +	return err;
> +}
> +
> +static int rpi_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
> +	struct rpi_rtc_reg data = {
> +		.reg = cpu_to_le32(RTC_TIME),
> +		.val = cpu_to_le32(rtc_tm_to_time64(tm))
> +	};
> +
> +	return rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
> +				     &data, sizeof(data));
> +}
> +
> +static int rpi_rtc_alarm_irq_is_enabled(struct device *dev, unsigned char *enabled)
> +{
> +	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
> +	struct rpi_rtc_reg data = {
> +		.reg = cpu_to_le32(RTC_ALARM_ENABLE)
> +        };
> +	s32 err = 0;
> +
> +	err = rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
> +				    &data, sizeof(data));
> +	*enabled = le32_to_cpu(data.val) & 0x1;
> +	return err;
> +}
> +
> +static int rpi_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
> +{
> +	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
> +	struct rpi_rtc_reg data = {
> +		.reg = cpu_to_le32(RTC_ALARM_ENABLE),
> +		.val = cpu_to_le32(enabled)
> +       	};

checkpatch complains about whitespaces in multiple locations, please use
checkpatch.pl --strict and fix.

> +
> +	return rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
> +				     &data, sizeof(data));
> +}
> +
> +static int rpi_rtc_alarm_clear_pending(struct device *dev)
> +{
> +	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
> +	struct rpi_rtc_reg data = {
> +		.reg = cpu_to_le32(RTC_ALARM_PENDING),
> +		.val = cpu_to_le32(1)
> +	};
> +
> +	return rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
> +				     &data, sizeof(data));
> +}
> +
> +static int rpi_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
> +{
> +	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
> +	struct rpi_rtc_reg data = {
> +		.reg = cpu_to_le32(RTC_ALARM)
> +       	};
> +	s32 err = 0;
> +
> +	err = rpi_rtc_alarm_irq_is_enabled(dev, &alarm->enabled);
> +	if (!err)
> +		err = rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
> +					    &data, sizeof(data));
> +	rtc_time64_to_tm(le32_to_cpu(data.val), &alarm->time);
> +
> +	return err;
> +}
> +
> +static int rpi_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
> +{
> +	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
> +	struct rpi_rtc_reg data = {
> +		.reg = cpu_to_le32(RTC_ALARM),
> +	       	.val = cpu_to_le32(rtc_tm_to_time64(&alarm->time))
> +	};
> +	int err;
> +
> +	err = rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
> +				    &data, sizeof(data));
> +
> +	if (err == 0)
> +		err = rpi_rtc_alarm_irq_enable(dev, alarm->enabled);
> +
> +	return err;
> +}
> +
> +static const struct rtc_class_ops rpi_rtc_ops = {
> +	.read_time = rpi_rtc_read_time,
> +	.set_time = rpi_rtc_set_time,
> +	.read_alarm = rpi_rtc_read_alarm,
> +	.set_alarm = rpi_rtc_set_alarm,
> +	.alarm_irq_enable = rpi_rtc_alarm_irq_enable,
> +};
> +
> +static void rpi_rtc_set_limits(struct device *dev)
> +{
> +	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
> +	struct rpi_rtc_reg data = {
> +		.reg = cpu_to_le32(RTC_BBAT_CHG_VOLTS_MIN)
> +	};
> +
> +	int err = rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
> +					&data, sizeof(data));
> +	if (err == 0)
> +		vrtc->bbat_vchg_min_millivolts = le32_to_cpu(data.val) / 1000U;
> +
> +	data.reg = cpu_to_le32(RTC_BBAT_CHG_VOLTS_MAX);
> +	data.val = cpu_to_le32(0);
> +	err = rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
> +				    &data, sizeof(data));
> +	if (err == 0)
> +		vrtc->bbat_vchg_max_millivolts = le32_to_cpu(data.val) / 1000U;
> +}
> +
> +static int rpi_rtc_set_charge_voltage(struct device *dev)
> +{
> +	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
> +	struct rpi_rtc_reg data = {
> +		.reg = cpu_to_le32(RTC_BBAT_CHG_VOLTS),
> +		.val = cpu_to_le32(vrtc->bbat_vchg_millivolts * 1000U)
> +	};
> +	int err;
> +
> +	if (vrtc->bbat_vchg_millivolts != 0 &&
> +	    (vrtc->bbat_vchg_millivolts < vrtc->bbat_vchg_min_millivolts ||
> +	    vrtc->bbat_vchg_millivolts > vrtc->bbat_vchg_max_millivolts)) {
> +		dev_warn(dev, "trickle charge voltage %umV is outside of the supported range (%umV - %umV)\n",
> +			 vrtc->bbat_vchg_millivolts,
> +			 vrtc->bbat_vchg_min_millivolts,
> +			 vrtc->bbat_vchg_max_millivolts);
> +		return -EINVAL;
> +	}
> +
> +	err = rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
> +				    &data, sizeof(data));
> +
> +	if (err)
> +		dev_err(dev, "failed to set trickle charge voltage to %umV: %d\n",
> +			vrtc->bbat_vchg_millivolts, err);
> +	else if (vrtc->bbat_vchg_millivolts)
> +		dev_info(dev, "trickle charging enabled at %umV\n",
> +			 vrtc->bbat_vchg_millivolts);
> +
> +	return err;
> +}
> +
> +static int rpi_rtc_probe(struct platform_device *pdev)
> +{
> +	struct rpi_rtc_data *vrtc;
> +	struct device *dev = &pdev->dev;
> +	struct rpi_firmware *firmware;
> +	int ret;
> +
> +	// Get the firmware device from the parent device
> +	firmware = devm_rpi_firmware_get(dev, dev->parent->of_node);
> +
> +	if (!firmware)
> +		return -EPROBE_DEFER;
> +
> +	vrtc = devm_kzalloc(dev, sizeof(*vrtc), GFP_KERNEL);
> +	if (!vrtc)
> +		return -ENOMEM;
> +
> +	vrtc->fw = firmware;
> +
> +	ret = devm_device_init_wakeup(dev);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, vrtc);
> +
> +	vrtc->rtc = devm_rtc_allocate_device(dev);
> +	if (IS_ERR(vrtc->rtc))
> +		return PTR_ERR(vrtc->rtc);
> +
> +	vrtc->rtc->range_max = U32_MAX;           /* 2106-02-07 */
> +
> +	set_bit(RTC_FEATURE_ALARM_WAKEUP_ONLY, vrtc->rtc->features);
> +	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, vrtc->rtc->features);
> +
> +	vrtc->rtc->ops = &rpi_rtc_ops;
> +
> +	rpi_rtc_alarm_clear_pending(dev);
> +
> +	/*
> +	 * The trickle-voltage property lives on the parent firmware node
> +	 * because we deliberately do not create a DT child node just to
> +	 * instantiate this driver (see DT maintainer guidance).
> +	 * The firmware driver registers us as a platform device at runtime.
> +	 */
> +	vrtc->bbat_vchg_millivolts = 0;
> +	of_property_read_u32(dev->parent->of_node, "trickle-voltage-millivolt",
> +			     &vrtc->bbat_vchg_millivolts);
> +
> +	rpi_rtc_set_limits(dev);
> +	rpi_rtc_set_charge_voltage(dev);
> +
> +	return devm_rtc_register_device(vrtc->rtc);
> +}
> +
> +static const struct of_device_id rpi_rtc_dt_match[] = {
> +	{ .compatible = "raspberrypi,firmware-rtc" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, rpi_rtc_dt_match);
> +
> +static struct platform_driver rpi_rtc_driver = {
> +	.driver = {
> +		.name = "raspberrypi-rtc",
> +		.of_match_table = of_match_ptr(rpi_rtc_dt_match),
> +	},
> +	.probe = rpi_rtc_probe
> +};
> +
> +module_platform_driver(rpi_rtc_driver);
> +
> +MODULE_AUTHOR("Jonathan Bell <jonathan@raspberrypi.com>");
> +MODULE_AUTHOR("Sander Speetjens <sander.speetjens@gmail.com>");
> +MODULE_DESCRIPTION("Raspberry Pi RTC driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:raspberrypi-rtc");
> -- 
> 2.55.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
