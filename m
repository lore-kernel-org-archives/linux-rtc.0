Return-Path: <rtc-linux+bncBDA7X7F2WUEBBD5UWCVQKGQEMCLAPZA@googlegroups.com>
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com. [74.125.82.48])
        by gmr-mx.google.com with ESMTPS id k10si492577wia.1.2015.06.01.01.38.39
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2015 01:38:39 -0700 (PDT)
Received: by mail-wg0-f48.google.com with SMTP id gq6so107837128wgb.3
        for <rtc-linux@googlegroups.com>; Mon, 01 Jun 2015 01:38:39 -0700 (PDT)
Date: Mon, 1 Jun 2015 09:38:35 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, sameo@linux.intel.com,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	Chao Xie <chao.xie@marvell.com>
Subject: [rtc-linux] Re: [PATCH 1/4] mfd: 88pm800: add device tree support
Message-ID: <20150601083835.GE3329@x1>
References: <1432937962-4537-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432937962-4537-2-git-send-email-vaibhav.hiremath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1432937962-4537-2-git-send-email-vaibhav.hiremath@linaro.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Sat, 30 May 2015, Vaibhav Hiremath wrote:

> Add DT support to the 88pm800 driver along with below properties
> 	- marvell,88pm800-irq-write-clear :
> 	  Idicates whether interrupt status is cleared by write
>=20
> Also, creates the DT binding text file,
> Documentation/devicetree/bindings/mfd/88pm800.txt
>=20
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/88pm800.txt | 57 +++++++++++++++++=
++++++
>  drivers/mfd/88pm800.c                             | 39 ++++++++++++++++

These should be submitted separately.

>  2 files changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/88pm800.txt
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/88pm800.txt b/Document=
ation/devicetree/bindings/mfd/88pm800.txt
> new file mode 100644
> index 0000000..094951b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/88pm800.txt
> @@ -0,0 +1,57 @@
> +* Marvell 88PM800 Power Management IC
> +
> +Required parent device properties:
> +- compatible : "marvell,88pm800"
> +- reg : the I2C slave address for the 88pm800 chip
> +- interrupts : IRQ line for the 88pm800 chip
> +- interrupt-controller: describes the 88pm800 as an interrupt controller
> +- #interrupt-cells : should be 1.
> +		- The cell is the 88pm800 local IRQ number
> +
> +Optional parent device properties:
> +- marvell,88pm800-irq-write-clr: indicates whether interrupt status is c=
leared by write

Drop the device name.  These bindings should be as generic as possible.

Also describe what the absence of the property means.

> +88pm800 consists of a large and varied group of sub-devices:

3?

> +Device			 Supply Names	 Description
> +------			 ------------	 -----------
> +88pm80x-onkey		:		: On key
> +88pm80x-rtc		:		: RTC
> +88pm80x			:		: Regulators

Surely regulators is 88pm80x-regulator, no?

> +Note: More device list will follow
> +
> +Example:
> +
> +	pmic: 88pm800@30 {
> +		compatible =3D "marvell,88pm800";
> +		reg =3D <0x30>;
> +		interrupts =3D <0 77 0x4>;

Please use the #defines in include/dt-bindings/

> +		interrupt-parent =3D <&gic>;
> +		interrupt-controller;
> +		#interrupt-cells =3D <1>;
> +
> +		marvell,88pm800-irq-write-clr;
> +
> +		regulators {
> +			compatible =3D "marvell,88pm80x-regulator";
> +
> +			buck1a: BUCK1A {
> +				regulator-compatible =3D "88PM800-BUCK1A";
> +				regulator-min-microvolt =3D <600000>;
> +				regulator-max-microvolt =3D <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +			ldo1: LDO1 {
> +				regulator-compatible =3D "88PM800-LDO1";
> +				regulator-min-microvolt =3D <1700000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};

'\n' here.

> +		rtc {
> +			compatible =3D "marvell,88pm80x-rtc";
> +		};
> +	};
> diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
> index 841717a..06ee058 100644
> --- a/drivers/mfd/88pm800.c
> +++ b/drivers/mfd/88pm800.c
> @@ -27,6 +27,7 @@
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/88pm80x.h>
>  #include <linux/slab.h>
> +#include <linux/of_device.h>
> =20
>  /* Interrupt Registers */
>  #define PM800_INT_STATUS1		(0x05)
> @@ -121,6 +122,11 @@ static const struct i2c_device_id pm80x_id_table[] =
=3D {
>  };
>  MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
> =20
> +static const struct of_device_id pm80x_of_match_table[] =3D {
> +	{ .compatible =3D "marvell,88pm800", },
> +	{},
> +};
> +
>  static struct resource rtc_resources[] =3D {
>  	{
>  	 .name =3D "88pm80x-rtc",
> @@ -133,6 +139,7 @@ static struct resource rtc_resources[] =3D {
>  static struct mfd_cell rtc_devs[] =3D {
>  	{
>  	 .name =3D "88pm80x-rtc",
> +	 .of_compatible =3D "marvell,88pm80x-rtc",
>  	 .num_resources =3D ARRAY_SIZE(rtc_resources),
>  	 .resources =3D &rtc_resources[0],
>  	 .id =3D -1,
> @@ -151,6 +158,7 @@ static struct resource onkey_resources[] =3D {
>  static const struct mfd_cell onkey_devs[] =3D {
>  	{
>  	 .name =3D "88pm80x-onkey",
> +	 .of_compatible =3D "marvell,88pm80x-onkey",
>  	 .num_resources =3D 1,
>  	 .resources =3D &onkey_resources[0],
>  	 .id =3D -1,
> @@ -160,6 +168,7 @@ static const struct mfd_cell onkey_devs[] =3D {
>  static const struct mfd_cell regulator_devs[] =3D {
>  	{
>  	 .name =3D "88pm80x-regulator",
> +	 .of_compatible =3D "marvell,88pm80x-regulator",
>  	 .id =3D -1,
>  	},
>  };
> @@ -538,14 +547,43 @@ out:
>  	return ret;
>  }
> =20
> +static int pm800_probe_dt(struct device_node *np,
> +			 struct device *dev,

Do you even use dev?

> +			 struct pm80x_platform_data *pdata)
> +{
> +	pdata->irq_mode =3D
> +		of_property_read_bool(np, "marvell,88pm800-irq-write-clear");

You write a new function for this?

> +	return 0;
> +}
> +
> +

Superfluous '\n'.

>  static int pm800_probe(struct i2c_client *client,
>  				 const struct i2c_device_id *id)
>  {
>  	int ret =3D 0;
>  	struct pm80x_chip *chip;
>  	struct pm80x_platform_data *pdata =3D dev_get_platdata(&client->dev);
> +	struct device_node *node =3D client->dev.of_node;

It's more common to use 'np'.

>  	struct pm80x_subchip *subchip;
> =20
> +	if (!pdata && !node) {
> +		dev_err(&client->dev,
> +			"pm80x requires platform data or of_node\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!pdata) {
> +		pdata =3D devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
> +		if (!pdata) {
> +			dev_err(&client->dev, "failed to allocaate memory\n");
> +			return -ENOMEM;
> +		}
> +		ret =3D pm800_probe_dt(node, &client->dev, pdata);
> +		if (ret)
> +			return ret;
> +	}

All this for a single attribute?  Please simplify.

>  	ret =3D pm80x_init(client);
>  	if (ret) {
>  		dev_err(&client->dev, "pm800_init fail\n");
> @@ -611,6 +649,7 @@ static struct i2c_driver pm800_driver =3D {
>  		.name =3D "88PM800",
>  		.owner =3D THIS_MODULE,
>  		.pm =3D &pm80x_pm_ops,
> +		.of_match_table	=3D pm80x_of_match_table,
>  		},
>  	.probe =3D pm800_probe,
>  	.remove =3D pm800_remove,

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
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
