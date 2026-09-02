Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17DA449B1A
	for <linux-rtc@vger.kernel.org>; Wed,  2 Sep 2026 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353936; cv=none; b=OJxJnH2vInNJ6bxPSY8IfoEIfJ4TLYhKmcVo3UxsqB1P6KWtmozLcc5azugtnyhmmZCGC0rdjg5wQ6XWz+dd/obAetXB9jnd4JIWIDVebCmXeKVlL1xuZIVTQL0BnSr7UK6sqjasTeaOFsT5zoZ3blrS40LbHwho4P/+lzfKEqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353936; c=relaxed/simple;
	bh=wXB0yB3JHMWnhParRKgUZUgpS2HHlI6DFVAtYGvh7tY=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=blaPu6vz0zAQA86bqip8PIQZOZNDSpY0Ik2Iu42Z0Qp4xt4XQnIq2bmAnX7+MzzgDYWqGrqBxhqyutElWCS6Tcffm9zFA/tdvExsGA8jEGUfJqfRc6ygW0Sap/J5Q3IYR/lkiZmOSt87Gl+Tmkc5LBeIJay4BsbTnMLaMNil2Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEKGa3mT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEKGa3mT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2E81F000E9
	for <linux-rtc@vger.kernel.org>; Wed,  2 Sep 2026 12:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788353934;
	bh=B1CbO2PZnJ3H1eNmWsPKoQlArKovTxICa+Lu4t9uMR4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=hEKGa3mTLvoMJudIZX0qtTLr3PUe5Qb/ANBHTuaj3X3sAA8ieeNnK2axKAlakCXR+
	 ggOXOMjEZMeUD1O+rUXJdkquOgxeaTUD2yGlR/ncOcf7wat3rLyvoYywkiO4fOP+g1
	 99UTp/iOsh/c7VKiUXSq4bQ/tBh+Kms39gtqZOGnZ7SJ4JYOfp7HJMEXPV7bj4dozf
	 XKg5THvCAV9qkp2n7E8a+PifWfyPyPAlj2vSAasBR20ddTzy16aLIBl83GOJrz3VUl
	 VB8tR3fpV84jriU8CnfhSUr+h8oAhaT8gRRGlY7xiA0JYfsD4WWduweB2cXWtmT6wu
	 WjCYnRZUyavkA==
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1a4c62804so1070325a12.3
        for <linux-rtc@vger.kernel.org>; Wed, 02 Sep 2026 05:58:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByr8aCDKM1j40Uv+2YMuONCrcPUO3F7bh+6KQDczI+Tj2pGJMN4wLn8ewLL1YIawkKvqA8dIN3CltM=@vger.kernel.org
X-Gm-Message-State: AFuF++ladxy0Yb4Nk2qkPnWyQ6X9PMnYoz9eCx7Mze5mJWt6SOvTYiEQ
	7mLoEZWnd37IdVKiDNevzFoaVlFkb1zvkv9uPfSUoSh/eZA5owvfnuH9gCacM+9LZf/7Q96DOPw
	i5VWNT/H0neuKIgO9QrKEUHG9qsCKEWIjnY/x+z7c3w==
X-Received: by 2002:a17:90b:2687:b0:398:9c0c:7c71 with SMTP id
 98e67ed59e1d1-39aee1f9788mr7884101a91.24.1788353933859; Wed, 02 Sep 2026
 05:58:53 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 08:58:50 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 08:58:50 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <5eb294e68b8d5d2c1d3a12b14a55dd2a9c075a09.1788346553.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788346553.git.mazziesaccount@gmail.com> <5eb294e68b8d5d2c1d3a12b14a55dd2a9c075a09.1788346553.git.mazziesaccount@gmail.com>
Date: Wed, 2 Sep 2026 08:58:50 -0400
X-Gmail-Original-Message-ID: <CAMRc=MchpaOib+jgMniG7=BBYwB1yqLvJG1sMkjXfRaMFPodgA@mail.gmail.com>
X-Gm-Features: AcwNN1VyZmAG5rLNE0B6usivEWtMn_kVVfXT2LpTUvDGxtpaucui1WdKpaUuwFs
Message-ID: <CAMRc=MchpaOib+jgMniG7=BBYwB1yqLvJG1sMkjXfRaMFPodgA@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] gpio: bd73800: Support ROHM BD73800 PMIC GPIOs
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@linux.dev>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Michael Walle <mwalle@kernel.org>, mfd@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org, 
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Sep 2026 13:07:32 +0200, Matti Vaittinen
<matti.vaittinen@linux.dev> said:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
>
> The ROHM BD73800 PMIC has 4 pins (named GPIO1, CLKOUT, FAULT_B and
> EXTEN_OUT) which might have been set to operate as a GPI or GPO when OTP
> (One Time Programmable memory) is written at device manufacturing.
> Support the GPI/GPO use-case via GPIO framework.
>
> The default OTP for these pins is to not use any of them as GPI or GPO.
> (The GPIO1 defaults as an ADC input regardless the naming). Hence the
> driver assumes none of these pins is a GPI/GPO unless explicitly pointed
> as GPI or GPO via device tree.
>
> Furthermore, pin's direction can't be changed after OTP configuration is
> done. Also the default drive type for a GPO (CMOS / Open Drain) is set
> by the OTP configuration. The BD73800 has a set of undocumented test
> registers which should allow changing the drive type. Access to the test
> register area or the test registers aren't documented and so this driver
> does not support configuring the drive type even though it might be
> doable.
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>

Looks good, just a couple nits.

> ---
> Revision history:
>  v2 => v3:
>   - Use gpio-regmap as was suggested by Linus W.
>  v1 => v2:
>   - Return -ENODEV when no GPIO pins are found
>   - Drop useless comment
>   - Use 'data' instead of 'g' as a name of the private data struct. Do so
>     consistently (change also the 'bdgpio' to 'data').
>   - Use device_property_... instead of the fwnode_property_...
>   - fix fault_b pin property name (re-use existing name)
> ---
>  drivers/gpio/Kconfig        |  12 +++
>  drivers/gpio/Makefile       |   1 +
>  drivers/gpio/gpio-bd73800.c | 209 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 222 insertions(+)
>  create mode 100644 drivers/gpio/gpio-bd73800.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index a48586bb8edb..64127740a248 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1385,6 +1385,18 @@ config GPIO_BD72720
>  	  be configured to GPO on the ROHM PMIC. The pin configuration is done
>  	  on OTP at manufacturing.
>
> +config GPIO_BD73800
> +	tristate "ROHM BD73800 GPIO support"
> +	depends on MFD_ROHM_BD71828
> +	select GPIO_REGMAP
> +	help
> +	  Support for GPIOs on ROHM BD73800 PMIC. There can be up to 4
> +	  GPI or GPO pins available on the PMIC in total. The purpose of
> +	  the pins is decided at the device manufacturing by OTP
> +	  configuration and can't be reconfigured later. Enable this
> +	  if your PMIC has pins set as GPIs or GPOs and if you wish to
> +	  control the pins via the GPIO framework.
> +
>  config GPIO_BD9571MWV
>  	tristate "ROHM BD9571 GPIO support"
>  	depends on MFD_BD9571MWV
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index dc9e6d643b5b..dc5e0583e328 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -45,6 +45,7 @@ obj-$(CONFIG_GPIO_BCM_XGS_IPROC)	+= gpio-xgs-iproc.o
>  obj-$(CONFIG_GPIO_BD71815)		+= gpio-bd71815.o
>  obj-$(CONFIG_GPIO_BD71828)		+= gpio-bd71828.o
>  obj-$(CONFIG_GPIO_BD72720)		+= gpio-bd72720.o
> +obj-$(CONFIG_GPIO_BD73800)		+= gpio-bd73800.o
>  obj-$(CONFIG_GPIO_BD9571MWV)		+= gpio-bd9571mwv.o
>  obj-$(CONFIG_GPIO_BLZP1600)		+= gpio-blzp1600.o
>  obj-$(CONFIG_GPIO_BRCMSTB)		+= gpio-brcmstb.o
> diff --git a/drivers/gpio/gpio-bd73800.c b/drivers/gpio/gpio-bd73800.c
> new file mode 100644
> index 000000000000..824901859a61
> --- /dev/null
> +++ b/drivers/gpio/gpio-bd73800.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Support to GPIOs on ROHM BD73800
> + * Copyright 2024 ROHM Semiconductors.
> + * Author: Matti Vaittinen <mazziesaccount@gmail.com>
> + */
> +
> +#include <linux/bitmap.h>
> +#include <linux/bitops.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/gpio/regmap.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/rohm-bd73800.h>
> +
> +#define BD73800_GPIO_MAX_PINS 4
> +/*
> + * The BD73800 has several "one time programmable" (OTP) configurations which
> + * can be set at manufacturing phase. Some of these options allow using
> + * individual pins as GPI or GPO (not both at the same time). The OTP
> + * configuration can't be read at run-time, so drivers rely on device-tree to
> + * advertise the OTP programmed in manufacturing.
> + *
> + * The pins which can be used as GPIO are:
> + * GPIO1, CLKOUT (GPIO2), FAULT_B, EXTEN_OUT.
> + *
> + * The OTP options 2 and 3 state for all the pins:
> + *  - OTP2: GPI (also IRQ source)
> + *  - OTP3: GPO (NOTE: This is actually 2 different OTP options. Either a
> + *    register controllable output or a power-sequence controlled output.
> + *    The "gpo" referred here means only the register controllable output.)
> + *    The datasheet refers to this as: "<pin> output is controlled by
> + *    GPIO<N>_OUT or power on/off sequencer to control external VRs. ON/OFF
> + *    sequence timing is configurable."
> + *
> + * The data-sheet further says that the GPI/GPO is not a default OTP
> + * configuration for any of the pins. Hence the GPIO driver defaults to a pin
> + * not being a GPI or GPO, but requires the pin to be explicitly marked as a
> + * GPI or GPO in the device-tree.
> + *
> + * DT properties:
> + * "rohm,pin-gpio1", "rohm,pin-clkout", "rohm,pin-fault_b", "rohm,pin-exten"
> + * can be set to one of the values "gpi" or "gpo" to enable them to be used as
> + * GPIO.
> + *
> + * The amount of GPIO lines the chip exposes to the user-space (chip.ngpio) is
> + * always the same, regardless of the OTP variant in use. The lines which are
> + * not usable as GPIO on a given OTP variant are marked invalid via the GPIO
> + * valid_mask. This way the user-space always sees a constant amount of GPIO
> + * lines, where numbering (relative to the chip's base) stays also the same.
> + * Users can then use the valid_mask to find out which of the lines are usable.
> + */
> +
> +struct bd73800_gpio {
> +	/* dev points to the platform device for devm and prints */
> +	struct device *dev;
> +	struct regmap *regmap;
> +	/* Pins which have been OTP configured as GPI or GPO */
> +	DECLARE_BITMAP(valid_mask, BD73800_GPIO_MAX_PINS);
> +	/* Subset of valid_mask - pins which have been OTP configured as GPO */
> +	DECLARE_BITMAP(output_mask, BD73800_GPIO_MAX_PINS);
> +};
> +
> +static const char * const bd73800_gpio_properties[BD73800_GPIO_MAX_PINS] = {
> +	"rohm,pin-gpio1", "rohm,pin-clkout", "rohm,pin-fault_b", "rohm,pin-exten"

Can you put the properties on separate lines?

> +};
> +
> +static int bd73800_gpio_get_pins(struct bd73800_gpio *data)
> +{
> +	struct device *parent = data->dev->parent;
> +	const char *val;
> +	int i, ret;
> +
> +	for (i = 0; i < BD73800_GPIO_MAX_PINS; i++) {
> +		ret = device_property_read_string(parent,
> +						  bd73800_gpio_properties[i],
> +						  &val);
> +		if (ret) {
> +			if (ret == -EINVAL)
> +				continue;
> +
> +			return dev_err_probe(data->dev, ret,
> +					"pin %d (%s), bad configuration\n", i,
> +					bd73800_gpio_properties[i]);
> +		}
> +
> +		if (!strcmp(val, "gpi")) {
> +			__set_bit(i, data->valid_mask);
> +		} else if (!strcmp(val, "gpo")) {
> +			__set_bit(i, data->valid_mask);
> +			__set_bit(i, data->output_mask);
> +		} else {
> +			dev_warn(data->dev,
> +				"pin %d (%s), unknown value '%s' ignored\n", i,
> +				bd73800_gpio_properties[i], val);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int bd73800_gpio_init_valid_mask(struct gpio_chip *gc,
> +					unsigned long *valid_mask,
> +					unsigned int ngpios)
> +{
> +	struct gpio_regmap *gpio = gpiochip_get_data(gc);
> +	struct bd73800_gpio *data = gpio_regmap_get_drvdata(gpio);
> +
> +	bitmap_copy(valid_mask, data->valid_mask, ngpios);
> +
> +	return 0;
> +}
> +
> +/*
> + * The used register depends on OTP:
> + *  - If OTP has set pin as GPO, only the GPO_OUT register is valid.
> + *  - If OTP has set pin as GPI, only the INT_5_SRC register is valid.
> + */
> +static int bd73800_gpio_reg_mask_xlate(struct gpio_regmap *gpio,
> +				       enum gpio_regmap_operation op,
> +				       unsigned int base, unsigned int offset,
> +				       unsigned int *reg, unsigned int *mask)
> +{
> +	struct bd73800_gpio *data = gpio_regmap_get_drvdata(gpio);
> +	bool is_output = test_bit(offset, data->output_mask);
> +
> +	if (is_output)
> +		*reg = BD73800_REG_GPO_OUT;
> +	else
> +		*reg = base;
> +
> +	*mask = BIT(offset);
> +
> +	return 0;
> +}
> +
> +static int gpo_bd73800_probe(struct platform_device *pdev)
> +{
> +	struct gpio_regmap_config config = { };
> +	struct bd73800_gpio *data;
> +	struct device *parent, *dev;
> +	struct gpio_regmap *gpio;
> +	int ret;
> +
> +	dev = &pdev->dev;
> +	/* The device-tree and regmap come from MFD => use parent for that */
> +	parent = dev->parent;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->dev = dev;
> +	data->regmap = dev_get_regmap(parent, NULL);
> +	if (!data->regmap)
> +		return dev_err_probe(dev, -ENODEV, "no parent regmap\n");
> +
> +	ret = bd73800_gpio_get_pins(data);
> +	if (ret)
> +		return ret;
> +
> +	if (bitmap_empty(data->valid_mask, BD73800_GPIO_MAX_PINS)) {
> +		/*
> +		 * The BD73800 may or may not have pins allocated for GPIO
> +		 * depending on the OTP used at manufacturing.
> +		 * If there are no pins, then we have nothing to do.
> +		 */
> +		dev_dbg(dev, "no GPIO pins\n");
> +		return -ENODEV;
> +	}
> +
> +	config.parent = parent;
> +	config.regmap = data->regmap;
> +	config.label = "bd73800";
> +	config.ngpio = BD73800_GPIO_MAX_PINS;
> +	config.reg_dat_base = BD73800_REG_INT_5_SRC;
> +	config.reg_set_base = BD73800_REG_GPO_OUT;
> +	config.reg_mask_xlate = bd73800_gpio_reg_mask_xlate;
> +	config.init_valid_mask = bd73800_gpio_init_valid_mask;
> +	/* All pins that are valid GPIO lines also have a fixed direction */
> +	config.fixed_direction_mask = data->valid_mask;
> +	config.fixed_direction_output = data->output_mask;
> +	config.drvdata = data;
> +
> +	gpio = devm_gpio_regmap_register(dev, &config);
> +
> +	return PTR_ERR_OR_ZERO(gpio);

Why not return PTR_ERR_OR_ZERO(devm_gpio_regmap_register())?

> +}
> +
> +static const struct platform_device_id bd73800_gpio_id[] = {
> +	{ "bd73800-gpio" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(platform, bd73800_gpio_id);
> +
> +static struct platform_driver gpo_bd73800_driver = {
> +	.driver = {
> +		.name = "bd73800-gpio",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.probe = gpo_bd73800_probe,
> +	.id_table = bd73800_gpio_id,
> +};
> +module_platform_driver(gpo_bd73800_driver);
> +
> +MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
> +MODULE_DESCRIPTION("GPIO interface for BD73800");
> +MODULE_LICENSE("GPL");
> --
> 2.55.0
>
>

With that:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
