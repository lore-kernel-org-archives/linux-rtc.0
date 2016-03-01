Return-Path: <rtc-linux+bncBDS7HNEFSALRBA4X3C3AKGQEU7U4MLY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w197si53102wmw.3.2016.03.01.13.37.07
        for <rtc-linux@googlegroups.com>;
        Tue, 01 Mar 2016 13:37:07 -0800 (PST)
Date: Tue, 1 Mar 2016 22:36:55 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc-rv3029c2: Add trickle charger
Message-ID: <20160301213655.GG23985@piout.net>
References: <20160301213322.661fe771@wiggum>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160301213322.661fe771@wiggum>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 01/03/2016 at 21:33:22 +0100, Michael B=C3=BCsch wrote :
> This adds a device tree property to enable the tricke charger at
> some to be configured resistance.
> If the property is left out, the trickle charger is disabled.
>=20
> The kconfig name is also changed to include the chip number as
> there are other MicroCrystal RTCs.
>=20

This should have been another patch and will conflict with my patch
doing exactly that, see rtc-next.

> Also a "rv3029" device ID was added, because the C2 suffix does
> not appear in latest chip versions and datasheet versions.
>=20

This change should also be part of another patch.

You may as well stop adding that suffix to newly added functions and
macros.
I'd also take a preliminary patch removing the c2 prefix from current
functions and macros.

Unfortunately, we can't rename the file because this will break scripts
loading modules.

>  /* Register map */
>  /* control section */
>  #define RV3029C2_ONOFF_CTRL		0x00
> +#define RV3029C2_ONOFF_CTRL_WE		(1 << 0)
> +#define RV3029C2_ONOFF_CTRL_TE		(1 << 1)
> +#define RV3029C2_ONOFF_CTRL_TAR		(1 << 2)
> +#define RV3029C2_ONOFF_CTRL_EERE	(1 << 3)
> +#define RV3029C2_ONOFF_CTRL_SRON	(1 << 4)
> +#define RV3029C2_ONOFF_CTRL_TD0		(1 << 5)
> +#define RV3029C2_ONOFF_CTRL_TD1		(1 << 6)
> +#define RV3029C2_ONOFF_CTRL_CLKINT	(1 << 7)

You didn't use --strict for checkpatch, please use BIT() and also
correct the alignments issues.

>  #define RV3029C2_IRQ_CTRL		0x01
>  #define RV3029C2_IRQ_CTRL_AIE		(1 << 0)
> +#define RV3029C2_IRQ_CTRL_TIE		(1 << 1)
> +#define RV3029C2_IRQ_CTRL_V1IE		(1 << 2)
> +#define RV3029C2_IRQ_CTRL_V2IE		(1 << 3)
> +#define RV3029C2_IRQ_CTRL_SRIE		(1 << 4)

I'm pretty sure many you are adding many of those but not using them
yet.

>  /* user ram section */
>  #define RV3029C2_USR1_RAM_PAGE		0x38
> @@ -84,6 +111,7 @@
>  #define RV3029C2_USR2_RAM_PAGE		0x3C
>  #define RV3029C2_USR2_SECTION_LEN	0x04
> =20
> +

spurious blank line

>  static int
>  rv3029c2_i2c_read_regs(struct i2c_client *client, u8 reg, u8 *buf,
>  	unsigned len)
> @@ -114,6 +142,24 @@ rv3029c2_i2c_write_regs(struct i2c_client *client, u=
8 reg, u8 const buf[],
>  }
> =20
>  static int
> +rv3029c2_i2c_maskset_reg(struct i2c_client *client, u8 reg, u8 mask, u8 =
set)

I'd prefer that function named _update_bits

> +{
> +	u8 buf[1];

couldn't that be u8 buf?

> +	int ret;
> +
> +	ret =3D rv3029c2_i2c_read_regs(client, reg, buf, 1);
> +	if (ret < 0)
> +		return ret;
> +	buf[0] &=3D mask;
> +	buf[0] |=3D set;
> +	ret =3D rv3029c2_i2c_write_regs(client, reg, buf, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int
>  rv3029c2_i2c_get_sr(struct i2c_client *client, u8 *buf)
>  {
>  	int ret =3D rv3029c2_i2c_read_regs(client, RV3029C2_STATUS, buf, 1);
> @@ -138,6 +184,128 @@ rv3029c2_i2c_set_sr(struct i2c_client *client, u8 v=
al)
>  	return 0;
>  }
> =20
> +static int rv3029c2_eeprom_busywait(struct i2c_client *client)
> +{
> +	int i, ret;
> +	u8 sr;
> +
> +	for (i =3D 100; i > 0; i--) {
> +		ret =3D rv3029c2_i2c_get_sr(client, &sr);
> +		if (ret < 0)
> +			break;
> +		if (!(sr & RV3029C2_STATUS_EEBUSY))
> +			break;
> +		usleep_range(1000, 10000);
> +	}
> +	if (i <=3D 0) {
> +		dev_err(&client->dev, "EEPROM busy wait timeout.\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return ret;
> +}
> +
> +static int rv3029c2_eeprom_exit(struct i2c_client *client)
> +{
> +	/* Re-enable eeprom refresh */
> +	return rv3029c2_i2c_maskset_reg(client, RV3029C2_ONOFF_CTRL,
> +					0xFF, RV3029C2_ONOFF_CTRL_EERE);
> +}
> +
> +static int rv3029c2_eeprom_enter(struct i2c_client *client)
> +{
> +	int i, ret;
> +	u8 sr;
> +
> +	/* Check whether we are in the allowed voltage range. */
> +	for (i =3D 100; i > 0; i--) {
> +		ret =3D rv3029c2_i2c_get_sr(client, &sr);
> +		if (ret < 0)
> +			return ret;
> +		if (!(sr & (RV3029C2_STATUS_VLOW1 | RV3029C2_STATUS_VLOW2)))
> +			break;
> +
> +		sr &=3D ~RV3029C2_STATUS_VLOW1;
> +		sr &=3D ~RV3029C2_STATUS_VLOW2;
> +		ret =3D rv3029c2_i2c_set_sr(client, sr);
> +		if (ret < 0)
> +			return ret;

I wouldn't reset the VLOW1 and VLOW2 flags here. Just bail out if the
voltage is not sufficient. I don't think that condition will actually
get better simply by waiting.

Proper VLOW1 and VLOW2 handling for that RTC is something I have in the
pipe.

> +		usleep_range(1000, 10000);
> +	}
> +	if (i <=3D 0) {
> +		dev_err(&client->dev, "EEPROM voltage wait timeout.\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	/* Disable eeprom refresh. */
> +	ret =3D rv3029c2_i2c_maskset_reg(client, RV3029C2_ONOFF_CTRL,
> +				       (u8)~RV3029C2_ONOFF_CTRL_EERE, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Wait for previous eeprom accesses to finish. */
> +	ret =3D rv3029c2_eeprom_busywait(client);
> +	if (ret < 0)
> +		rv3029c2_eeprom_exit(client);
> +
> +	return ret;
> +}
> +
> +static int rv3029c2_eeprom_read(struct i2c_client *client, u8 reg,
> +				u8 buf[], size_t len)
> +{
> +	int ret, err;
> +	size_t i;
> +
> +	ret =3D rv3029c2_eeprom_enter(client);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i =3D 0; i < len; i++) {
> +		ret =3D rv3029c2_i2c_read_regs(client, reg, &buf[i], 1);
> +		if (ret < 0)
> +			break;
> +	}
> +
> +	err =3D rv3029c2_eeprom_exit(client);
> +	if (err < 0)
> +		return err;
> +
> +	return ret;
> +}
> +
> +static int rv3029c2_eeprom_write(struct i2c_client *client, u8 reg,
> +				 u8 const buf[], size_t len)
> +{
> +	int ret, err;
> +	size_t i;
> +	u8 tmp;
> +
> +	ret =3D rv3029c2_eeprom_enter(client);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i =3D 0; i < len; i++) {
> +		ret =3D rv3029c2_i2c_read_regs(client, reg, &tmp, 1);
> +		if (ret < 0)
> +			break;
> +		if (tmp !=3D buf[i]) {
> +			ret =3D rv3029c2_i2c_write_regs(client, reg, &buf[i], 1);
> +			if (ret < 0)
> +				break;
> +		}
> +		ret =3D rv3029c2_eeprom_busywait(client);
> +		if (ret < 0)
> +			break;
> +	}
> +
> +	err =3D rv3029c2_eeprom_exit(client);
> +	if (err < 0)
> +		return err;
> +
> +	return ret;
> +}
> +
>  static int
>  rv3029c2_i2c_read_time(struct i2c_client *client, struct rtc_time *tm)
>  {
> @@ -230,22 +398,13 @@ static int rv3029c2_rtc_i2c_alarm_set_irq(struct i2=
c_client *client,
>  					int enable)
>  {
>  	int ret;
> -	u8 buf[1];
> -
> -	/* enable AIE irq */
> -	ret =3D rv3029c2_i2c_read_regs(client, RV3029C2_IRQ_CTRL,	buf, 1);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "can't read INT reg\n");
> -		return ret;
> -	}
> -	if (enable)
> -		buf[0] |=3D RV3029C2_IRQ_CTRL_AIE;
> -	else
> -		buf[0] &=3D ~RV3029C2_IRQ_CTRL_AIE;
> =20
> -	ret =3D rv3029c2_i2c_write_regs(client, RV3029C2_IRQ_CTRL, buf, 1);
> +	/* enable/disable AIE irq */
> +	ret =3D rv3029c2_i2c_maskset_reg(client, RV3029C2_IRQ_CTRL,
> +				       (u8)~RV3029C2_IRQ_CTRL_AIE,
> +				       (enable ? RV3029C2_IRQ_CTRL_AIE : 0));
>  	if (ret < 0) {
> -		dev_err(&client->dev, "can't set INT reg\n");
> +		dev_err(&client->dev, "can't update INT reg\n");

I would also put that particular change in a separate patch, with the
_update_bits addition.

>  		return ret;
>  	}
> =20
> @@ -286,20 +445,11 @@ static int rv3029c2_rtc_i2c_set_alarm(struct i2c_cl=
ient *client,
>  		return ret;
> =20
>  	if (alarm->enabled) {
> -		u8 buf[1];
> -
>  		/* clear AF flag */
> -		ret =3D rv3029c2_i2c_read_regs(client, RV3029C2_IRQ_FLAGS,
> -						buf, 1);
> -		if (ret < 0) {
> -			dev_err(&client->dev, "can't read alarm flag\n");
> -			return ret;
> -		}
> -		buf[0] &=3D ~RV3029C2_IRQ_FLAGS_AF;
> -		ret =3D rv3029c2_i2c_write_regs(client, RV3029C2_IRQ_FLAGS,
> -						buf, 1);
> +		ret =3D rv3029c2_i2c_maskset_reg(client, RV3029C2_IRQ_FLAGS,
> +					       (u8)~RV3029C2_IRQ_FLAGS_AF, 0);
>  		if (ret < 0) {
> -			dev_err(&client->dev, "can't set alarm flag\n");
> +			dev_err(&client->dev, "can't clear alarm flag\n");

Ditto.

>  			return ret;
>  		}
>  		/* enable AIE irq */
> @@ -372,6 +522,109 @@ static int rv3029c2_rtc_set_time(struct device *dev=
, struct rtc_time *tm)
>  	return rv3029c2_i2c_set_time(to_i2c_client(dev), tm);
>  }
> =20
> +static const struct rv3029c2_trickle_tab_elem {
> +	u32 r;		/* resistance in ohms */
> +	u8 conf;	/* trickle config bits */
> +} rv3029c2_trickle_tab[] =3D {
> +	{
> +		.r	=3D 1076,
> +		.conf	=3D RV3029C2_TRICKLE_1K | RV3029C2_TRICKLE_5K |
> +			  RV3029C2_TRICKLE_20K | RV3029C2_TRICKLE_80K,
> +	}, {
> +		.r	=3D 1091,
> +		.conf	=3D RV3029C2_TRICKLE_1K | RV3029C2_TRICKLE_5K |
> +			  RV3029C2_TRICKLE_20K,
> +	}, {
> +		.r	=3D 1137,
> +		.conf	=3D RV3029C2_TRICKLE_1K | RV3029C2_TRICKLE_5K |
> +			  RV3029C2_TRICKLE_80K,
> +	}, {
> +		.r	=3D 1154,
> +		.conf	=3D RV3029C2_TRICKLE_1K | RV3029C2_TRICKLE_5K,
> +	}, {
> +		.r	=3D 1371,
> +		.conf	=3D RV3029C2_TRICKLE_1K | RV3029C2_TRICKLE_20K |
> +			  RV3029C2_TRICKLE_80K,
> +	}, {
> +		.r	=3D 1395,
> +		.conf	=3D RV3029C2_TRICKLE_1K | RV3029C2_TRICKLE_20K,
> +	}, {
> +		.r	=3D 1472,
> +		.conf	=3D RV3029C2_TRICKLE_1K | RV3029C2_TRICKLE_80K,
> +	}, {
> +		.r	=3D 1500,
> +		.conf	=3D RV3029C2_TRICKLE_1K,
> +	}, {
> +		.r	=3D 3810,
> +		.conf	=3D RV3029C2_TRICKLE_5K | RV3029C2_TRICKLE_20K |
> +			  RV3029C2_TRICKLE_80K,
> +	}, {
> +		.r	=3D 4000,
> +		.conf	=3D RV3029C2_TRICKLE_5K | RV3029C2_TRICKLE_20K,
> +	}, {
> +		.r	=3D 4706,
> +		.conf	=3D RV3029C2_TRICKLE_5K | RV3029C2_TRICKLE_80K,
> +	}, {
> +		.r	=3D 5000,
> +		.conf	=3D RV3029C2_TRICKLE_5K,
> +	}, {
> +		.r	=3D 16000,
> +		.conf	=3D RV3029C2_TRICKLE_20K | RV3029C2_TRICKLE_80K,
> +	}, {
> +		.r	=3D 20000,
> +		.conf	=3D RV3029C2_TRICKLE_20K,
> +	}, {
> +		.r	=3D 80000,
> +		.conf	=3D RV3029C2_TRICKLE_80K,
> +	},
> +};
> +
> +static int rv3029c2_of_init(struct i2c_client *client)

I'd name that function rv3029_trickle_config or so. Other features
parsed from DT can be implemented using other functions.

> +{
> +	struct device_node *of_node =3D client->dev.of_node;
> +	const struct rv3029c2_trickle_tab_elem *elem;
> +	int i, err;
> +	u32 ohms;
> +	u8 eectrl;
> +
> +	if (!of_node)
> +		return 0;
> +
> +	/* Configure the trickle charger. */
> +	err =3D rv3029c2_eeprom_read(client, RV3029C2_CONTROL_E2P_EECTRL,
> +				   &eectrl, 1);
> +	if (err < 0) {
> +		dev_err(&client->dev, "Failed to read trickle "
> +			"charger config\n");
> +		return err;
> +	}
> +	err =3D of_property_read_u32(of_node, "trickle-resistor-ohms", &ohms);
> +	if (err) {
> +		/* Disable trickle charger. */
> +		eectrl &=3D ~RV3029C2_TRICKLE_MASK;

I wouldn't touch it at all, some people may set it in the bootloader and
don't expect linux to change the value.

> +	} else {
> +		/* Enable trickle charger. */
> +		for (i =3D 0; i < ARRAY_SIZE(rv3029c2_trickle_tab); i++) {
> +			elem =3D &rv3029c2_trickle_tab[i];
> +			if (elem->r >=3D ohms)
> +				break;
> +		}
> +		eectrl &=3D ~RV3029C2_TRICKLE_MASK;
> +		eectrl |=3D elem->conf;
> +		dev_info(&client->dev, "Trickle charger enabled at %d ohms "
> +			 "resistance.\n", elem->r);
> +	}
> +	err =3D rv3029c2_eeprom_write(client, RV3029C2_CONTROL_E2P_EECTRL,
> +				    &eectrl, 1);
> +	if (err < 0) {
> +		dev_err(&client->dev, "Failed to write trickle "
> +			"charger config\n");

Those strings should be only on one line to stay greppable.

> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct rtc_class_ops rv3029c2_rtc_ops =3D {
>  	.read_time	=3D rv3029c2_rtc_read_time,
>  	.set_time	=3D rv3029c2_rtc_set_time,
> @@ -381,6 +634,7 @@ static const struct rtc_class_ops rv3029c2_rtc_ops =
=3D {
> =20
>  static struct i2c_device_id rv3029c2_id[] =3D {
>  	{ "rv3029c2", 0 },
> +	{ "rv3029", 0 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, rv3029c2_id);
> @@ -401,6 +655,12 @@ static int rv3029c2_probe(struct i2c_client *client,
>  		return rc;
>  	}
> =20
> +	rc =3D rv3029c2_of_init(client);
> +	if (rc < 0) {
> +		dev_err(&client->dev, "OF init failed.\n");
> +		return rc;

I don't think this should be a hard failure, the RTC can function
without that particular configuration, the previous error message is
enough (no need for two messages).


--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
