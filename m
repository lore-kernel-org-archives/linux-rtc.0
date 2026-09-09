Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9105633F58D;
	Wed,  9 Sep 2026 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967231; cv=none; b=Fj5f0wJqBvK0QtcZJd6oISwTwbFPwQ4MeCyFa5hgtZC1Z1Z6r4rKm7wPTYGlH69fJF8L6r9mFjrnIroEMRtbrGw/JlnNzeY6ptwq2nabce6Tn+oIVdcFDkw4cBJ+HUyekh2tj+Ai30oVxE98KCK2b2Ig/3vtiuaFiGbnz6FYPBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967231; c=relaxed/simple;
	bh=Co5zOMjQTCyErtwY7oOxqYQ7eK0SAUY4lWzBiHS49SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oG42wDZU/Ahn0Z22ineRQUtNiG9oaFUn0owACDN2+At2p9etnB4KRfCpBrOP6Q7htoxs8yBNssEw6zWFKs5uJNFQJ9yzI0jqMAjUA8VZaogXJFuUVEwqWSL6Ev0hzJxFwL5wC+7Yhvub77DcCdrXqCmD/jMgX1/vR3MktrAi0Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X9Y1Q3gX; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X9Y1Q3gX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 389CD1A1A65;
	Wed,  9 Sep 2026 15:20:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0C09060448;
	Wed,  9 Sep 2026 15:20:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B516D11C7AF93;
	Wed,  9 Sep 2026 17:20:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788967223; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=kesk8yMquyK/iFqs9zh4zemiMGA4tCXi/axrzkwTfrU=;
	b=X9Y1Q3gXqwnZba7FRw4u/4bu8grOnVHyrYtMX92BP0M6QqBuZk33WUtiLCqJ38mzJcUupF
	5dkqUkAHKjy8dMwoShJauU50tmOvxReIpD6nvCEIdA+vE1/4fMGt43BpXGivi9oYJG7CmT
	uOqjYKAWgyI2PucmA2cMfnK2g2TJWBjgEfFJvi3X9p/7CbQUyCowUX2FyRIi8JOhj4TAzy
	WGUARjKIRxckSGljMF6oEZhvrS64VpnUxDimMnz5Gp/rs2zS69GyV9aEFihtB4UnT1iu3J
	M28spE9sdGY/TevV/3HwBdF7IXq+JtY/xiLC771c596qPcrzLyiZG5qsS6xuKg==
Date: Wed, 9 Sep 2026 17:20:19 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Sander Speetjens <sander.speetjens@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Dom Cobley <popcornmix@gmail.com>
Subject: Re: [PATCH 2/3] rtc: Add Raspberry Pi 5 RTC driver
Message-ID: <202609091520190d6592ee@mail.local>
References: <20260909141300.1368790-1-sander.speetjens@gmail.com>
 <20260909141300.1368790-3-sander.speetjens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909141300.1368790-3-sander.speetjens@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On 09/09/2026 16:12:59+0200, Sander Speetjens wrote:
> From: Jonathan Bell <jonathan@raspberrypi.com>
> 
> Upstreaming the downstream Raspberry Pi 5 RTC driver.
> This driver supports the custom DA9091, which is accessed through the firmware mailbox.
> 
> Co-developed-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
> ---
>  drivers/rtc/Kconfig   |  11 ++
>  drivers/rtc/Makefile  |   1 +
>  drivers/rtc/rtc-rpi.c | 277 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 289 insertions(+)
>  create mode 100644 drivers/rtc/rtc-rpi.c
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 05b9233b9418..382973d46e06 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1999,6 +1999,17 @@ config RTC_DRV_R7301
>  	   This driver can also be built as a module. If so, the module
>  	   will be called rtc-r7301.
>  
> +config RTC_DRV_RPI
> +        tristate "Raspberry Pi RTC"
> +        depends on ARCH_BRCMSTB || COMPILE_TEST
> +        default ARCH_BRCMSTB
> +        help
> +          If you say yes here you get support for the RTC found on
> +          Raspberry Pi devices.
> +
> +          This driver can also be built as a module. If so, the module
> +          will be called rtc-rpi.
> +
>  config RTC_DRV_STM32
>  	tristate "STM32 RTC"
>  	select REGMAP_MMIO
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 0347645b021f..78551bb04c5c 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -148,6 +148,7 @@ obj-$(CONFIG_RTC_DRV_RC5T583)	+= rtc-rc5t583.o
>  obj-$(CONFIG_RTC_DRV_RC5T619)	+= rtc-rc5t619.o
>  obj-$(CONFIG_RTC_DRV_RK808)	+= rtc-rk808.o
>  obj-$(CONFIG_RTC_DRV_RP5C01)	+= rtc-rp5c01.o
> +obj-$(CONFIG_RTC_DRV_RPI)	+= rtc-rpi.o
>  obj-$(CONFIG_RTC_DRV_RS5C313)	+= rtc-rs5c313.o
>  obj-$(CONFIG_RTC_DRV_RS5C348)	+= rtc-rs5c348.o
>  obj-$(CONFIG_RTC_DRV_RS5C372)	+= rtc-rs5c372.o
> diff --git a/drivers/rtc/rtc-rpi.c b/drivers/rtc/rtc-rpi.c
> new file mode 100644
> index 000000000000..e455b4116957
> --- /dev/null
> +++ b/drivers/rtc/rtc-rpi.c
> @@ -0,0 +1,277 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/**
> + * rtc-rpi.c
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
> +struct rpi_rtc_data {
> +	struct rtc_device *rtc;
> +	struct rpi_firmware *fw;
> +	u32 bbat_vchg_microvolts;
> +};
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
> +static int rpi_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
> +	u32 data[2] = {RTC_TIME};
> +	int err;
> +
> +	err = rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
> +				    &data, sizeof(data));
> +	rtc_time64_to_tm(data[1], tm);
> +	return err;
> +}
> +
> +static int rpi_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
> +	u32 data[2] = {RTC_TIME, rtc_tm_to_time64(tm)};
> +
> +	return rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
> +				     &data, sizeof(data));
> +}
> +
> +static int rpi_rtc_alarm_irq_is_enabled(struct device *dev, unsigned char *enabled)
> +{
> +	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
> +	u32 data[2] = {RTC_ALARM_ENABLE};
> +	s32 err = 0;
> +
> +	err = rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
> +				    &data, sizeof(data));
> +	*enabled = data[1] & 0x1;
> +	return err;
> +}
> +
> +static int rpi_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
> +{
> +	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
> +	u32 data[2] = {RTC_ALARM_ENABLE, enabled};
> +
> +	return rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
> +				     &data, sizeof(data));
> +}
> +
> +static int rpi_rtc_alarm_clear_pending(struct device *dev)
> +{
> +	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
> +	u32 data[2] = {RTC_ALARM_PENDING, 1};
> +
> +	return rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
> +				     &data, sizeof(data));
> +}
> +
> +static int rpi_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
> +{
> +	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
> +	u32 data[2] = {RTC_ALARM};
> +	s32 err = 0;
> +
> +	err = rpi_rtc_alarm_irq_is_enabled(dev, &alarm->enabled);
> +	if (!err)
> +		err = rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
> +					    &data, sizeof(data));
> +	rtc_time64_to_tm(data[1], &alarm->time);
> +
> +	return err;
> +}
> +
> +static int rpi_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
> +{
> +	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
> +	u32 data[2] = {RTC_ALARM, rtc_tm_to_time64(&alarm->time)};
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
> +static int rpi_rtc_set_charge_voltage(struct device *dev)
> +{
> +	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev);
> +	u32 data[2] = {RTC_BBAT_CHG_VOLTS, vrtc->bbat_vchg_microvolts};
> +	int err;
> +
> +	err = rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
> +				    &data, sizeof(data));
> +
> +	if (err)
> +		dev_err(dev, "failed to set trickle charge voltage to %uuV: %d\n",
> +			vrtc->bbat_vchg_microvolts, err);
> +	else if (vrtc->bbat_vchg_microvolts)
> +		dev_info(dev, "trickle charging enabled at %uuV\n",
> +			 vrtc->bbat_vchg_microvolts);
> +
> +	return err;
> +}
> +
> +static ssize_t rpi_rtc_print_uint_reg(struct device *dev, char *buf, u32 reg)
> +{
> +	struct rpi_rtc_data *vrtc = dev_get_drvdata(dev->parent);
> +	u32 data[2] = {reg, 0};
> +	int ret = 0;
> +
> +	ret = rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
> +				    &data, sizeof(data));
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%u\n", data[1]);
> +}
> +
> +static ssize_t charging_voltage_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	return rpi_rtc_print_uint_reg(dev, buf, RTC_BBAT_CHG_VOLTS);
> +}
> +static DEVICE_ATTR_RO(charging_voltage);
> +
> +static ssize_t charging_voltage_min_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	return rpi_rtc_print_uint_reg(dev, buf, RTC_BBAT_CHG_VOLTS_MIN);
> +}
> +static DEVICE_ATTR_RO(charging_voltage_min);
> +
> +static ssize_t charging_voltage_max_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	return rpi_rtc_print_uint_reg(dev, buf, RTC_BBAT_CHG_VOLTS_MAX);
> +}
> +static DEVICE_ATTR_RO(charging_voltage_max);
> +
> +static ssize_t battery_voltage_show(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	return rpi_rtc_print_uint_reg(dev, buf, RTC_BBAT_VOLTS);
> +}
> +static DEVICE_ATTR_RO(battery_voltage);
> +
> +static struct attribute *rpi_rtc_attrs[] = {
> +	&dev_attr_charging_voltage.attr,
> +	&dev_attr_charging_voltage_min.attr,
> +	&dev_attr_charging_voltage_max.attr,
> +	&dev_attr_battery_voltage.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group rpi_rtc_sysfs_files = {
> +	.attrs = rpi_rtc_attrs,
> +};

This undocumented sysfs interface has to be removed.

> +
> +static int rpi_rtc_probe(struct platform_device *pdev)
> +{
> +	struct rpi_rtc_data *vrtc;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *fw_node;
> +	struct rpi_firmware *fw;
> +	int ret;
> +
> +	fw_node = of_parse_phandle(np, "firmware", 0);
> +	if (!fw_node) {
> +		dev_err(dev, "Missing firmware node\n");
> +		return -ENOENT;
> +	}
> +
> +	fw = rpi_firmware_get(fw_node);
> +	if (!fw)
> +		return -EPROBE_DEFER;
> +
> +	vrtc = devm_kzalloc(&pdev->dev, sizeof(*vrtc), GFP_KERNEL);
> +	if (!vrtc)
> +		return -ENOMEM;
> +
> +	vrtc->fw = fw;
> +
> +	device_init_wakeup(&pdev->dev, 1);
> +
> +	platform_set_drvdata(pdev, vrtc);
> +
> +	vrtc->rtc = devm_rtc_allocate_device(&pdev->dev);
> +	if (IS_ERR(vrtc->rtc))
> +		return PTR_ERR(vrtc->rtc);
> +
> +	set_bit(RTC_FEATURE_ALARM_WAKEUP_ONLY, vrtc->rtc->features);
> +	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, vrtc->rtc->features);
> +
> +	vrtc->rtc->ops = &rpi_rtc_ops;
> +	ret = rtc_add_group(vrtc->rtc, &rpi_rtc_sysfs_files);
> +	if (ret)
> +		return ret;
> +
> +	rpi_rtc_alarm_clear_pending(dev);
> +
> +	/*
> +	 * Optionally enable trickle charging - if the property isn't
> +	 * present (or set to zero), trickle charging is disabled.
> +	 */
> +	of_property_read_u32(np, "trickle-charge-microvolt",
> +			     &vrtc->bbat_vchg_microvolts);
> +
> +	rpi_rtc_set_charge_voltage(dev);
> +
> +	return devm_rtc_register_device(vrtc->rtc);
> +}
> +
> +static const struct of_device_id rpi_rtc_dt_match[] = {
> +	{ .compatible = "raspberrypi,rpi-rtc"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rpi_rtc_dt_match);
> +
> +static struct platform_driver rpi_rtc_driver = {
> +	.probe = rpi_rtc_probe,
> +	.driver = {
> +		.name = "rpi-rtc",
> +		.of_match_table = rpi_rtc_dt_match,
> +	},
> +};
> +
> +module_platform_driver(rpi_rtc_driver);
> +
> +MODULE_DESCRIPTION("Raspberry Pi RTC driver");
> +MODULE_LICENSE("GPL");
> \ No newline at end of file
> -- 
> 2.55.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
