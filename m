Received: from mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D463E5A2B
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 06:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539152; cv=none; b=Kl14VMGaOmigRJ/qEqBZlJZ7u+UiX5Mxq5vWHmgMMbULU67FXAeW1I0NpOvvirU/aMTvDz1QIRFY4TuQQcyGz+o/vz834Vod3WMoSrcuoba31/94dZH2SXuLX2nrkdRdDJVZz0e83sqUvqTSZAoMetZHVYlhpsaWRFYZqUuZ0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539152; c=relaxed/simple;
	bh=Ouhj/3w+OL/UbtbRQ7dyvcMtClh+PuXCWYzpsxYFYiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDXu8F7AlVXUXQNooDLwboaT8vV00HuLTsH2yWeubdeNdlPwBO8UnqnFRwf4B965qH2lWAdtq0uUuSjlJj55W9n2Xk+d+n44Z4FKOTePqa0IGfjkdmyVJ8M6jbtMUroFOVzyh2frHVdkFusy09sOAIL/0kirEgfAXR98Zb/Ub5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P1YC44PB; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P1YC44PB"
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Ouhj/3w+OL/UbtbRQ7dyvcMtClh+PuXCWYzpsxYFYiw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789539146; v=1; x=1790143946;
 b=P1YC44PB96kWufBJw6fZkABen/gXIld5x12wjSSP4l5Tif4xSQJRxjF3ao3kXq1rjLJ5LHGB
 AhUit/KR1mo/o7xSucgfrqCJp01+GbJqkXoMwqdDrez0UKm5/r/yKmaWx+6TVf8eAKW8WYpRoCz
 dtpHuc3O5+PdAQrePUFzmHLU=
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 6481a474ed78b246;
	Wed, 16 Sep 2026 06:12:26 +0000
X-Mizu-Trace-ID: 6481a474ed78b246
X-Migadu-Flow: FLOW_OUT
Date: Wed, 16 Sep 2026 09:12:18 +0300
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Michael Walle <mwalle@kernel.org>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org, Sverdlin@mva-rohm,
	Alexander <alexander.sverdlin@siemens.com>
Subject: [PATCH v4 09/10] gpio: bd73800: Support ROHM BD73800 PMIC GPIOs
Message-ID: <e3e6ac712519326cc25fcdd0a0c8e3cc42ef55ab.1789538455.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1789538455.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+XAbpSQSxw7OcDn6"
Content-Disposition: inline
In-Reply-To: <cover.1789538455.git.mazziesaccount@gmail.com>

--+XAbpSQSxw7OcDn6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The ROHM BD73800 PMIC has 4 pins (named GPIO1, CLKOUT, FAULT_B and
EXTEN_OUT) which might have been set to operate as a GPI or GPO when OTP
(One Time Programmable memory) is written at device manufacturing.
Support the GPI/GPO use-case via GPIO framework.

The default OTP for these pins is to not use any of them as GPI or GPO.
(The GPIO1 defaults as an ADC input regardless the naming). Hence the
driver assumes none of these pins is a GPI/GPO unless explicitly pointed
as GPI or GPO via device tree.

Furthermore, pin's direction can't be changed after OTP configuration is
done. Also the default drive type for a GPO (CMOS / Open Drain) is set
by the OTP configuration. The BD73800 has a set of undocumented test
registers which should allow changing the drive type. Access to the test
register area or the test registers aren't documented and so this driver
does not support configuring the drive type even though it might be
doable.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

---
Revision history:
 v3 =3D> v4:
  - styling, mostly as suggested by Bartosz
 v2 =3D> v3:
  - Use gpio-regmap as was suggested by Linus W.
 v1 =3D> v2:
  - Return -ENODEV when no GPIO pins are found
  - Drop useless comment
  - Use 'data' instead of 'g' as a name of the private data struct. Do so
    consistently (change also the 'bdgpio' to 'data').
  - Use device_property_... instead of the fwnode_property_...
  - fix fault_b pin property name (re-use existing name)
---
 drivers/gpio/Kconfig        |  12 +++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-bd73800.c | 209 ++++++++++++++++++++++++++++++++++++
 3 files changed, 222 insertions(+)
 create mode 100644 drivers/gpio/gpio-bd73800.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index a48586bb8edb..64127740a248 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1385,6 +1385,18 @@ config GPIO_BD72720
 	  be configured to GPO on the ROHM PMIC. The pin configuration is done
 	  on OTP at manufacturing.
=20
+config GPIO_BD73800
+	tristate "ROHM BD73800 GPIO support"
+	depends on MFD_ROHM_BD71828
+	select GPIO_REGMAP
+	help
+	  Support for GPIOs on ROHM BD73800 PMIC. There can be up to 4
+	  GPI or GPO pins available on the PMIC in total. The purpose of
+	  the pins is decided at the device manufacturing by OTP
+	  configuration and can't be reconfigured later. Enable this
+	  if your PMIC has pins set as GPIs or GPOs and if you wish to
+	  control the pins via the GPIO framework.
+
 config GPIO_BD9571MWV
 	tristate "ROHM BD9571 GPIO support"
 	depends on MFD_BD9571MWV
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index dc9e6d643b5b..dc5e0583e328 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_GPIO_BCM_XGS_IPROC)	+=3D gpio-xgs-iproc.o
 obj-$(CONFIG_GPIO_BD71815)		+=3D gpio-bd71815.o
 obj-$(CONFIG_GPIO_BD71828)		+=3D gpio-bd71828.o
 obj-$(CONFIG_GPIO_BD72720)		+=3D gpio-bd72720.o
+obj-$(CONFIG_GPIO_BD73800)		+=3D gpio-bd73800.o
 obj-$(CONFIG_GPIO_BD9571MWV)		+=3D gpio-bd9571mwv.o
 obj-$(CONFIG_GPIO_BLZP1600)		+=3D gpio-blzp1600.o
 obj-$(CONFIG_GPIO_BRCMSTB)		+=3D gpio-brcmstb.o
diff --git a/drivers/gpio/gpio-bd73800.c b/drivers/gpio/gpio-bd73800.c
new file mode 100644
index 000000000000..2be2a885820e
--- /dev/null
+++ b/drivers/gpio/gpio-bd73800.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Support to GPIOs on ROHM BD73800
+ * Copyright 2024 ROHM Semiconductors.
+ * Author: Matti Vaittinen <mazziesaccount@gmail.com>
+ */
+
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio/regmap.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/rohm-bd73800.h>
+
+#define BD73800_GPIO_MAX_PINS 4
+/*
+ * The BD73800 has several "one time programmable" (OTP) configurations wh=
ich
+ * can be set at manufacturing phase. Some of these options allow using
+ * individual pins as GPI or GPO (not both at the same time). The OTP
+ * configuration can't be read at run-time, so drivers rely on device-tree=
 to
+ * advertise the OTP programmed in manufacturing.
+ *
+ * The pins which can be used as GPIO are:
+ * GPIO1, CLKOUT (GPIO2), FAULT_B, EXTEN_OUT.
+ *
+ * The OTP options 2 and 3 state for all the pins:
+ *  - OTP2: GPI (also IRQ source)
+ *  - OTP3: GPO (NOTE: This is actually 2 different OTP options. Either a
+ *    register controllable output or a power-sequence controlled output.
+ *    The "gpo" referred here means only the register controllable output.)
+ *    The datasheet refers to this as: "<pin> output is controlled by
+ *    GPIO<N>_OUT or power on/off sequencer to control external VRs. ON/OFF
+ *    sequence timing is configurable."
+ *
+ * The data-sheet further says that the GPI/GPO is not a default OTP
+ * configuration for any of the pins. Hence the GPIO driver defaults to a =
pin
+ * not being a GPI or GPO, but requires the pin to be explicitly marked as=
 a
+ * GPI or GPO in the device-tree.
+ *
+ * DT properties:
+ * "rohm,pin-gpio1", "rohm,pin-clkout", "rohm,pin-fault_b", "rohm,pin-exte=
n"
+ * can be set to one of the values "gpi" or "gpo" to enable them to be use=
d as
+ * GPIO.
+ *
+ * The amount of GPIO lines the chip exposes to the user-space (chip.ngpio=
) is
+ * always the same, regardless of the OTP variant in use. The lines which =
are
+ * not usable as GPIO on a given OTP variant are marked invalid via the GP=
IO
+ * valid_mask. This way the user-space always sees a constant amount of GP=
IO
+ * lines, where numbering (relative to the chip's base) stays also the sam=
e.
+ * Users can then use the valid_mask to find out which of the lines are us=
able.
+ */
+
+struct bd73800_gpio {
+	/* dev points to the platform device for devm and prints */
+	struct device *dev;
+	struct regmap *regmap;
+	/* Pins which have been OTP configured as GPI or GPO */
+	DECLARE_BITMAP(valid_mask, BD73800_GPIO_MAX_PINS);
+	/* Subset of valid_mask - pins which have been OTP configured as GPO */
+	DECLARE_BITMAP(output_mask, BD73800_GPIO_MAX_PINS);
+};
+
+static const char * const bd73800_gpio_properties[BD73800_GPIO_MAX_PINS] =
=3D {
+	"rohm,pin-gpio1",
+	"rohm,pin-clkout",
+	"rohm,pin-fault_b",
+	"rohm,pin-exten"
+};
+
+static int bd73800_gpio_get_pins(struct bd73800_gpio *data)
+{
+	struct device *parent =3D data->dev->parent;
+	const char *val;
+	int i, ret;
+
+	for (i =3D 0; i < BD73800_GPIO_MAX_PINS; i++) {
+		ret =3D device_property_read_string(parent,
+						  bd73800_gpio_properties[i],
+						  &val);
+		if (ret) {
+			if (ret =3D=3D -EINVAL)
+				continue;
+
+			return dev_err_probe(data->dev, ret,
+					"pin %d (%s), bad configuration\n", i,
+					bd73800_gpio_properties[i]);
+		}
+
+		if (!strcmp(val, "gpi")) {
+			__set_bit(i, data->valid_mask);
+		} else if (!strcmp(val, "gpo")) {
+			__set_bit(i, data->valid_mask);
+			__set_bit(i, data->output_mask);
+		} else {
+			dev_warn(data->dev,
+				 "pin %d (%s), unknown value '%s' ignored\n", i,
+				 bd73800_gpio_properties[i], val);
+		}
+	}
+
+	return 0;
+}
+
+static int bd73800_gpio_init_valid_mask(struct gpio_chip *gc,
+					unsigned long *valid_mask,
+					unsigned int ngpios)
+{
+	struct gpio_regmap *gpio =3D gpiochip_get_data(gc);
+	struct bd73800_gpio *data =3D gpio_regmap_get_drvdata(gpio);
+
+	bitmap_copy(valid_mask, data->valid_mask, ngpios);
+
+	return 0;
+}
+
+/*
+ * The used register depends on OTP:
+ *  - If OTP has set pin as GPO, only the GPO_OUT register is valid.
+ *  - If OTP has set pin as GPI, only the INT_5_SRC register is valid.
+ */
+static int bd73800_gpio_reg_mask_xlate(struct gpio_regmap *gpio,
+				       enum gpio_regmap_operation op,
+				       unsigned int base, unsigned int offset,
+				       unsigned int *reg, unsigned int *mask)
+{
+	struct bd73800_gpio *data =3D gpio_regmap_get_drvdata(gpio);
+	bool is_output =3D test_bit(offset, data->output_mask);
+
+	if (is_output)
+		*reg =3D BD73800_REG_GPO_OUT;
+	else
+		*reg =3D base;
+
+	*mask =3D BIT(offset);
+
+	return 0;
+}
+
+static int gpo_bd73800_probe(struct platform_device *pdev)
+{
+	struct gpio_regmap_config config =3D { };
+	struct bd73800_gpio *data;
+	struct device *parent, *dev;
+	int ret;
+
+	dev =3D &pdev->dev;
+	/* The device-tree and regmap come from MFD =3D> use parent for that */
+	parent =3D dev->parent;
+
+	data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev =3D dev;
+	data->regmap =3D dev_get_regmap(parent, NULL);
+	if (!data->regmap)
+		return dev_err_probe(dev, -ENODEV, "no parent regmap\n");
+
+	ret =3D bd73800_gpio_get_pins(data);
+	if (ret)
+		return ret;
+
+	if (bitmap_empty(data->valid_mask, BD73800_GPIO_MAX_PINS)) {
+		/*
+		 * The BD73800 may or may not have pins allocated for GPIO
+		 * depending on the OTP used at manufacturing.
+		 * If there are no pins, then we have nothing to do.
+		 */
+		dev_dbg(dev, "no GPIO pins\n");
+		return -ENODEV;
+	}
+
+	config.parent =3D parent;
+	config.regmap =3D data->regmap;
+	config.label =3D "bd73800";
+	config.ngpio =3D BD73800_GPIO_MAX_PINS;
+	config.reg_dat_base =3D BD73800_REG_INT_5_SRC;
+	config.reg_set_base =3D BD73800_REG_GPO_OUT;
+	config.reg_mask_xlate =3D bd73800_gpio_reg_mask_xlate;
+	config.init_valid_mask =3D bd73800_gpio_init_valid_mask;
+	/* All pins that are valid GPIO lines also have a fixed direction */
+	config.fixed_direction_mask =3D data->valid_mask;
+	config.fixed_direction_output =3D data->output_mask;
+	config.drvdata =3D data;
+
+	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &config));
+}
+
+static const struct platform_device_id bd73800_gpio_id[] =3D {
+	{ "bd73800-gpio" },
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, bd73800_gpio_id);
+
+static struct platform_driver gpo_bd73800_driver =3D {
+	.driver =3D {
+		.name =3D "bd73800-gpio",
+		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe =3D gpo_bd73800_probe,
+	.id_table =3D bd73800_gpio_id,
+};
+module_platform_driver(gpo_bd73800_driver);
+
+MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
+MODULE_DESCRIPTION("GPIO interface for BD73800");
+MODULE_LICENSE("GPL");
--=20
2.55.0


--+XAbpSQSxw7OcDn6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqqM0IACgkQeFA3/03a
ocUp6gf/YNqNJy838HMt5pkGm4jI2NNV/n1J4JK2XCqcbBNr6e7LR5f8O4JM28Yh
Mymrs3zwV9ZFFna4JBTpdbKaAJLVwa0MyLQztXidrhzY2a7G4shqVeJO1qSCLwSr
XouHHp7FxN9ZuDIQszNDF4R1Phr2BLmuI+M0b/ajQaTlBknhuRh16j8d2XF+kNGb
3VACzTSI/QHN7K3LantRTNUmnDlI8c+0DnNfW4fKQiYrNVJfwC4tHU4+Wt/21jp+
BIMy5RAeq3uClJaIel3ITmlsh9MJOf1WovfQCc3I3da3wuIf51rvJoa7u8dDA+rg
Z8jkdpwC60knNeP/d7EX1uUE7fw+Sw==
=GiQl
-----END PGP SIGNATURE-----

--+XAbpSQSxw7OcDn6--
