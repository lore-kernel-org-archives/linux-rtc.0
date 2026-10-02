Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716563CE0A0;
	Fri,  2 Oct 2026 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971888; cv=none; b=VTlGQJ41pDa5oNNPBv+wQUegZax0kvqAiHKMdsmLJCmF5YsJF+yA1Jng9/YAMYqBriKBWEy19HYIClvji+lxAw0fhmMLJutbCZKVy03y12rhjYuLKVzWMvZw6CkzhMuK48kQOWttVFrk1HR/UC0T+EGCmMChnHIloaWwbLtz3F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971888; c=relaxed/simple;
	bh=Rw5Uu0KrSKLS+d/Mu6Jr2TEg/SfyIU04JlJVcwVp/RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbriIU/79sp+I+KUu7XSLXuz6DNMvrKNTHHSclKLBaBIIfFagJsbMCCOOXGUyME5WNcKeK6T6TC8F7mEUD+38swdVMYyxnQxPmcymOrgPr8rD95bDoJbg3pcMuOA9Sgr6tIVUcY2OwPulQzIUb9hDZxark+9KH/oLaQkudCZ7sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SF95Crev; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oYuZtst9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SF95Crev";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oYuZtst9"
Date: Fri, 2 Oct 2026 22:11:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790971884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TqB+RxFLCfImZ6UmkKViGK5qwzMQHfvLRhF4fTXgNjw=;
	b=SF95Crev/XuD1MCbySkyccf7KRssYxWaZq0cvpTjZQkacZHbmRXLpwviB3vOX50MHp+L5M
	xwLeAgSy/6SqavW7hYNFrR0sv4DcvzGs4yKHT0ULfNMs5cN7PWer+8CeYwBpOGRgX/35Ii
	VwchqZitPNL6mzYQyZIn0mg6rqQ1xCBBKvQrrUf5/ABB+92q8gMeYNkRhj1wnE8aR3oaNW
	YFFg5R6HpPkET1hobHHabYawCkDsn44LU9VJNiH+KhdLTeEQIaS6+A8NVOw5WnNYoCMrbQ
	TOv1yfTkahf9JEsglyVQaPUVR9Wbx/G97fjjUgvyYhk5ZYP5QVmfTN031CKKrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790971884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TqB+RxFLCfImZ6UmkKViGK5qwzMQHfvLRhF4fTXgNjw=;
	b=oYuZtst9XgU2a9UGd+kRieoVN2nRc2Z1EcUR9tvs51mjoXRe7NQMr0KvktCznuJh1lKIVN
	ZlAOG5BCqT66s1Cg==
From: Gregor Herburger <gregor.herburger@linutronix.de>
To: Sander Speetjens <sander.speetjens@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Jonathan Bell <jonathan@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, pbrobinson@gmail.com
Subject: Re: [PATCH v10 3/3] rtc: Add Raspberry Pi 5 RTC driver
Message-ID: <jpyqdcsn6jm355rbbmu4z5ungtmrnt2xlewbrxspry7dkxdwfl@obpofquubbny>
References: <20261002102419.830595-1-sander.speetjens@gmail.com>
 <20261002102419.830595-4-sander.speetjens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002102419.830595-4-sander.speetjens@gmail.com>

Hi,

On Fri, Oct 02, 2026 at 12:24:19PM +0200, Sander Speetjens wrote:
...
>  
> +static void rpi_register_rtc_driver(struct device *dev)
> +{
> +	struct device_node *firmware;
> +
> +	// Check if our model of Raspberry Pi board is from the 5th gen
> +	// as the RTC is only present on that model.
Multiline comments should be /* */.
> +	if (!of_machine_is_compatible("brcm,bcm2712"))
> +		return;
> +
> +	firmware = of_get_compatible_child(dev->of_node,
> +					   "raspberrypi,firmware-rtc");
If you don't have a "raspberrypi,firmware-rtc" compatible this is not needed.
For the other drivers this is here because it needs to be compatible with old devicetrees.
> +	if (firmware) {
> +		of_node_put(firmware);
> +		return;
> +	}
> +
> +	rpi_rtc = platform_device_register_data(dev, "raspberrypi-rtc",
> +						-1, NULL, 0);
> +}
...
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 05b9233b9418..6dae4c069be2 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1999,6 +1999,18 @@ config RTC_DRV_R7301
>  	   This driver can also be built as a module. If so, the module
>  	   will be called rtc-r7301.
>  
> +config RTC_DRV_RPI
> +	tristate "Raspberry Pi RTC"
> +	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
> +	depends on ARCH_BRCMSTB || COMPILE_TEST
> +	default ARCH_BRCMSTB
> +	help
> +		If you say yes here you get support for the RTC found on
> +		Raspberry Pi devices.
You should mention here on which Raspberry devices.
> +
> +		This driver can also be built as a module. If so, the module
> +		will be called rtc-raspberrypi.
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
> index 000000000000..0496851cfc30
> --- /dev/null
> +++ b/drivers/rtc/rtc-raspberrypi.c
> @@ -0,0 +1,276 @@
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
> +#define	RTC_TIME 		0
There is a space before a tab. You should run the scripts/checkpatch.pl script
before sending patches.
> +#define	RTC_ALARM		1
> +#define	RTC_ALARM_PENDING	2
> +#define	RTC_ALARM_ENABLE	3
> +#define	RTC_BBAT_CHG_VOLTS	4
> +#define	RTC_BBAT_CHG_VOLTS_MIN	5
> +#define	RTC_BBAT_CHG_VOLTS_MAX	6
> +#define	RTC_BBAT_VOLTS		7
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
I find the name vrtc confusing. It is probably a leftover of that above
mentioned rtc-meson-vrtc driver.

...
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
Without dt-compatible this is not needed. Checkpatch also complains about this
undocumented compatible string.

I think this should be:

static const struct platform_device_id raspberrypi_rtc_id[] = {
	{ "raspberrypi-rtc" },
	{ /* sentinel */ }
};
MODULE_DEVICE_TABLE(platform, raspberrypi_rtc_id);
This should also construct your alias and you can remove the MODULE_ALIAS.
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
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_ALIAS("platform:raspberrypi-rtc");
> diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
> index 975bef529854..e13994d8281c 100644
> --- a/include/soc/bcm2835/raspberrypi-firmware.h
> +++ b/include/soc/bcm2835/raspberrypi-firmware.h
> @@ -75,6 +75,8 @@ enum rpi_firmware_property_tag {
>  	RPI_FIRMWARE_GET_THROTTLED =                          0x00030046,
>  	RPI_FIRMWARE_GET_CLOCK_MEASURED =                     0x00030047,
>  	RPI_FIRMWARE_NOTIFY_REBOOT =                          0x00030048,
> +	RPI_FIRMWARE_GET_RTC_REG =                            0x00030087,
> +	RPI_FIRMWARE_SET_RTC_REG =                            0x00038087,
>  	RPI_FIRMWARE_SET_CLOCK_STATE =                        0x00038001,
>  	RPI_FIRMWARE_SET_CLOCK_RATE =                         0x00038002,
>  	RPI_FIRMWARE_SET_VOLTAGE =                            0x00038003,

Best regards
Gregor Herburger
