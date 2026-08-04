Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0329A4503F9
	for <linux-rtc@vger.kernel.org>; Tue,  4 Aug 2026 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785839021; cv=none; b=VZ2Wz1MpImQd7Fv4oBBELf2KOzJvdinuFvAZedGgsnErR9/a4RowNon/rlgjufCani/IPuXVJGGMKksWoKo+I8o0knimLYGUY9Lc01UwTjDonJiUps058xjzpi3B0ihbRn3W0S+cBNgfA6nI1VuK4Idg1jtCKm9W/2ql/9smkMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785839021; c=relaxed/simple;
	bh=QroUqRtls5c9WCNR2CO3o2fPv1CQsD1nlXgoe/8L8pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siYN7oWEqNYiKK0cN4Z+RobzqF6GL8LGUSmB5CP/1+AEgpw7snD1k3hvcV8Z/gL0jBhviwa6GeFxc+yAIc/bz0ZVD67Na2/dsRzhw/D3oGbHNJuEit9PP7po8GmVOqaTPfYVP2FCHWNOukUd0Q/nzJBqe0Qs47T2y+pVAmbZWTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L93Sd2iP; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L93Sd2iP"
Date: Tue, 4 Aug 2026 13:23:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785839016; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=l+SuECyvjZE9BFrhd+9VPl0lXX2ZxKAnTtgxx2qez0c=;
	b=L93Sd2iPshmMXS+CGpJGruNYNBhm9WQPsGyQE8eGlcYOAp8jM0FY48XAadSwHXQiDvXYw+
	B6egOwXVRT1tJyvVqQwBiB+k+vdGcbHuOJ1sibEnRL4W7l3J3uCNrPjgbrEQ1frIaZWs1F
	D5yZiG5Z3lduuw18NF0UDvcZYVYJTi4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
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
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH v2 09/10] gpio: bd73800: Support ROHM BD73800 PMIC GPIOs
Message-ID: <9774b8d6663ea55b1682b32f825ec5689be3e1d8.1785838585.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1785838584.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dtqU4lO2ZhY3CWs4"
Content-Disposition: inline
In-Reply-To: <cover.1785838584.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--dtqU4lO2ZhY3CWs4
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

---
Revision history:
 v1 =3D> v2:
  - Return -ENODEV when no GPIO pins are found
  - Drop useless comment
  - Use 'data' instead of 'g' as a name of the private data struct. Do so
    consistently (change also the 'bdgpio' to 'data').
  - Use device_property_... instead of the fwnode_property_...
  - fix fault_b pin property name (re-use existing name)
---
 drivers/gpio/Kconfig        |  11 ++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-bd73800.c | 227 ++++++++++++++++++++++++++++++++++++
 3 files changed, 239 insertions(+)
 create mode 100644 drivers/gpio/gpio-bd73800.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 28cf6d2e83c2..09d87c3b756f 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1363,6 +1363,17 @@ config GPIO_BD72720
 	  be configured to GPO on the ROHM PMIC. The pin configuration is done
 	  on OTP at manufacturing.
=20
+config GPIO_BD73800
+	tristate "ROHM BD73800 GPIO support"
+	depends on MFD_ROHM_BD71828
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
index 4d0e900402fc..3041c06aa933 100644
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
index 000000000000..03867f24e0dc
--- /dev/null
+++ b/drivers/gpio/gpio-bd73800.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Support to GPIOs on ROHM BD73800
+ * Copyright 2024 ROHM Semiconductors.
+ * Author: Matti Vaittinen <mazziesaccount@gmail.com>
+ */
+
+#include <linux/gpio/driver.h>
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
+ *    The "gpo" referred here means only the register controllable output.
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
+ */
+
+enum bd73800_gpio_state {
+	BD73800_PIN_UNKNOWN,
+	BD73800_PIN_GPI,
+	BD73800_PIN_GPO,
+};
+
+struct bd73800_gpio_pin_cfg {
+	enum bd73800_gpio_state state;
+	int mask; /* GPIO_OUT and INT_SRC have same bit offsets for GPIO */
+};
+
+struct bd73800_gpio {
+	/* chip.parent points the MFD which provides DT node and regmap */
+	struct gpio_chip chip;
+	struct bd73800_gpio_pin_cfg pin[BD73800_GPIO_MAX_PINS];
+	int num_pins;
+	/* dev points to the platform device for devm and prints */
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+static int bd73800_gpio_get_pins(struct bd73800_gpio *data)
+{
+	static const char * const properties[] =3D {"rohm,pin-gpio1",
+		"rohm,pin-clkout", "rohm,pin-fault_b", "rohm,pin-exten"};
+	const char *val;
+	int i, ret;
+
+	for (i =3D 0; i < ARRAY_SIZE(properties); i++) {
+		ret =3D device_property_read_string(data->dev->parent,
+						  properties[i], &val);
+
+		if (ret) {
+			if (ret =3D=3D -EINVAL)
+				continue;
+
+			return dev_err_probe(data->dev, ret,
+					"pin %d (%s), bad configuration\n", i,
+					properties[i]);
+		}
+
+		if (strcmp(val, "gpi") =3D=3D 0) {
+			data->pin[data->num_pins].state =3D BD73800_PIN_GPI;
+			data->pin[data->num_pins].mask =3D BIT(i);
+			data->num_pins++;
+		} else if (strcmp(val, "gpo") =3D=3D 0) {
+			data->pin[data->num_pins].state =3D BD73800_PIN_GPO;
+			data->pin[data->num_pins].mask =3D BIT(i);
+			data->num_pins++;
+		}
+	}
+
+	return 0;
+}
+
+static int bd73800gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct bd73800_gpio *data =3D gpiochip_get_data(chip);
+	struct bd73800_gpio_pin_cfg *pin =3D &data->pin[offset];
+	int ret, val;
+
+	/* Only pins configured as GPI via OTP can have their status read */
+	if (pin->state !=3D BD73800_PIN_GPI) {
+		dev_dbg(data->dev, "pin %d (%x) not input. State %d\n",	offset,
+			pin->mask, pin->state);
+		return -EINVAL;
+	}
+
+	ret =3D regmap_read(data->regmap, BD73800_REG_INT_5_SRC, &val);
+	if (ret)
+		return ret;
+
+	return val & pin->mask;
+}
+
+static int bd73800gpo_set(struct gpio_chip *chip, unsigned int offset,
+			  int value)
+{
+	struct bd73800_gpio *data =3D gpiochip_get_data(chip);
+	struct bd73800_gpio_pin_cfg *pin =3D &data->pin[offset];
+
+	if (pin->state !=3D BD73800_PIN_GPO) {
+		dev_dbg(data->dev, "pin %d (%d) not output. State %d\n",
+			offset, pin->mask, pin->state);
+
+		return -EINVAL;
+	}
+
+	if (value)
+		return regmap_set_bits(data->regmap, BD73800_REG_GPO_OUT,
+				       pin->mask);
+
+	return regmap_clear_bits(data->regmap, BD73800_REG_GPO_OUT, pin->mask);
+}
+
+static int bd73800gpio_direction_get(struct gpio_chip *chip,
+				     unsigned int offset)
+{
+	struct bd73800_gpio *data =3D gpiochip_get_data(chip);
+
+	if (data->pin[offset].state =3D=3D BD73800_PIN_GPO)
+		return GPIO_LINE_DIRECTION_OUT;
+
+	return GPIO_LINE_DIRECTION_IN;
+}
+
+/*
+ * Template for GPIO chip. The BD73800 GPO supports both CMOS and open dra=
in
+ * configurations. The default however depends on the OTP. The runtime con=
fig
+ * can be done via undocumented test registers - but at the moment there i=
s no
+ * support for this.
+ *
+ * NOTE: When the BD73800 GPIO pins are used as IRQ source, the users are
+ * expected to request them directly from the regmap_irq IRQ-chip (impleme=
nted
+ * in the MFD driver). This way we don't need to populate another IRQ-chip
+ * here.
+ */
+static const struct gpio_chip bd73800gpio_chip =3D {
+	.label			=3D "bd73800",
+	.owner			=3D THIS_MODULE,
+	.get			=3D bd73800gpio_get,
+	.get_direction		=3D bd73800gpio_direction_get,
+	.set			=3D bd73800gpo_set,
+	.can_sleep		=3D true,
+};
+
+static int gpo_bd73800_probe(struct platform_device *pdev)
+{
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
+	data->chip =3D bd73800gpio_chip;
+	data->chip.base =3D -1;
+	data->chip.parent =3D parent;
+	data->regmap =3D dev_get_regmap(parent, NULL);
+	data->dev =3D dev;
+
+	ret =3D bd73800_gpio_get_pins(data);
+	if (ret)
+		return ret;
+
+	if (!data->num_pins) {
+		/*
+		 * The BD73800 may or may not have pins allocated for GPIO
+		 * depending on the OTP used at manufacturing.
+		 * If there are no pins, then we have nothing to do.
+		 */
+		dev_dbg(dev, "no GPIO pins\n");
+		return -ENODEV;
+	}
+	data->chip.ngpio =3D data->num_pins;
+
+	return devm_gpiochip_add_data(dev, &data->chip, data);
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


--dtqU4lO2ZhY3CWs4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmpxvZ8ACgkQeFA3/03a
ocX3twgAheAx+kI9NMTXXHRfuabjwsYdZWDYHwAdPy6BzN+BbKUEuAPBmXuCMsG6
de/Nx0euMRG7SlZcWtb622OknUBBOwXHtGKaC363rfuLNQj8cD6rBekJduZXYGeq
e5hjb7YTmVuCWTbpTE72E7v2ay/IU//IgKpmCR5U/7xcgjw1cg0w45qDFjOCw67x
o+y1TKZjEA2J46xRPQ+hReX4mVRQe/CCG12Hu8qGa3UdtIMJZZPeyOfytQWpMrqM
qKF1BOrkuD4rgf9yuNcpjj8ok4QmI0sEPSX9R5XFAC1lyBAIR5X0HHkVTzSrCzCS
GH8M/DHxRFKpAj7obLtayr0p3Kgzww==
=8po8
-----END PGP SIGNATURE-----

--dtqU4lO2ZhY3CWs4--
