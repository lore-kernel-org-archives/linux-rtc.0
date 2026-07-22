Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FA742E8E6;
	Wed, 22 Jul 2026 20:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784751408; cv=none; b=ksPerKf0ibUY11z+pPNUUoKNKwKUe9DfleOJE7CuaV+jKTa+yR5Euabt4qaXpqDoVzuWA+FkLtBa8+ena6BKAgcRjDu/2ULfGDoXgby+BGkziXQ9QqV7JjxJWNs6f715Z7a04h4j7QyxKLFyjpvwAYDEmkfnfV45F6MNmRrSDyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784751408; c=relaxed/simple;
	bh=7RdMja2o6aBE8DMCKT/IytXIlBaoZGD/c/87vnXI0zQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c6vaX7Zgsw/XvHKpmoQyuAmAPj/y1IsV4Rgu6yGLroBhddQSz/tnu7NNZlco6cho+ySvGiDW5HoUr9BAYJsw4fGrSokIR1ZyOfYlJ/zf6TSDU1auhIQMTO3LcNUi1LX/vGMhB0iv9/9yvVJRdlyiC5h4WDtT8u4aI+exkDM5YCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJ8jMgsE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJ8jMgsE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115101F000E9;
	Wed, 22 Jul 2026 20:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784751406;
	bh=AggazJ/29P+kNP3VWSeM7VIpedUdMOM0/kipo+bGSac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GJ8jMgsE324LDCBcEcPCyF4N+r2RmMd7yoqUDpsUKV3cG8mvy2LsCkBIje5XkSOn6
	 xoyDTNUU1N3bo25Hkp++vaP/nD5/bop2K0GkGfO6nrLdbUJ27qQi8A7wkk5+rNoUaT
	 PYndSKWOdoSTsYJ5PJsyu2k9uRnBH/2263lfkBiPJAEs0+uYUOarqz16c7zaPiZU89
	 5nMsuUd3XbBNHnQkqxF52ptT6miIPa41gfYm/gBk8pJXUZBa2snz+nsdpQn4ekJHpv
	 94NTBb5vSYvCUxUt8d/zikJrUHL+c4FdM7FRMplt/AVI9a6lr8rWgP+wq8B3PKX8K6
	 3Bs/rtgnEapAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] rtc: abx80x: use regmap instead of I2C specific API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: linux-rtc@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org
In-Reply-To: <20260722195814.298552-4-apokusinski01@gmail.com>
References: <20260722195814.298552-1-apokusinski01@gmail.com>
 <20260722195814.298552-4-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 20:16:45 +0000
Message-Id: <20260722201646.115101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hardware unlock sequence is broken by read-modify-write inversion
- [Low] Incompatible pointer types passed to regmap_read()
--

--- Patch [3]: [PATCH 3/6] rtc: abx80x: use regmap instead of I2C specific =
API ---
commit 97cd1f33d168c96f848a8f59ba284bfe9c5f89fe
Author: Antoni Pokusinski <apokusinski01@gmail.com>
Date:   Wed Jul 22 19:58:11 2026 +0000

    rtc: abx80x: use regmap instead of I2C specific API
   =20
    Rework the driver so that it uses regmap_* functions for communication
    with the device instead of the i2c_smbus_* API. This way the support for
    ABX81X RTCs which use SPI can be added later.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 9b0e1d48d9ba3..e5ba821a67689 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
> @@ -125,52 +126,53 @@ static struct abx80x_cap abx80x_caps[] =3D {
[ ... ]
> -static int abx80x_is_rc_mode(struct i2c_client *client)
> +static int abx80x_is_rc_mode(struct device *dev)
>  {
> -	int flags =3D 0;
> +	struct abx80x_priv *priv =3D dev_get_drvdata(dev);
> +	int err, flags =3D 0;
> =20
> -	flags =3D  i2c_smbus_read_byte_data(client, ABX8XX_REG_OSS);
> -	if (flags < 0) {
> -		dev_err(&client->dev,
> -			"Failed to read autocalibration attribute\n");
> -		return flags;
> +	err =3D regmap_read(priv->regmap, ABX8XX_REG_OSS, &flags);

[Severity: Low]
Does this pass an incompatible pointer type to regmap_read()?

The API signature of regmap_read() expects an unsigned int * for its third
argument, but the address of a local int variable (&flags) is passed here.
While this may not cause memory corruption since int and unsigned int are
the same size, it violates the function signature and generates
-Wincompatible-pointer-types warnings, which can break builds compiling with
-Werror.

> +	if (err < 0) {
> +		dev_err(dev, "Failed to read autocalibration attribute\n");
> +		return err;
>  	}
[ ... ]
> @@ -259,13 +260,13 @@ static int abx80x_rtc_set_time(struct device *dev, =
struct rtc_time *tm)
> =20
>  static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
>  {
> -	struct i2c_client *client =3D dev_id;
> -	struct abx80x_priv *priv =3D i2c_get_clientdata(client);
> +	struct device *dev =3D dev_id;
> +	struct abx80x_priv *priv =3D dev_get_drvdata(dev);
>  	struct rtc_device *rtc =3D priv->rtc;
> -	int status;
> +	int err, status;
> =20
> -	status =3D i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
> -	if (status < 0)
> +	err =3D regmap_read(priv->regmap, ABX8XX_REG_STATUS, &status);

[Severity: Low]
Does this pass an incompatible pointer type to regmap_read()?

Similar to abx80x_is_rc_mode() above, this passes an int pointer (&status)
instead of an unsigned int pointer.

> +	if (err < 0)
>  		return IRQ_NONE;
[ ... ]
> @@ -294,14 +294,13 @@ static int abx80x_read_alarm(struct device *dev, st=
ruct rtc_wkalrm *t)
>  	if (priv->irq <=3D 0)
>  		return -EINVAL;
> =20
> -	err =3D i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_ASC,
> -					    sizeof(buf), buf);
> +	err =3D regmap_bulk_read(priv->regmap, ABX8XX_REG_ASC, buf, sizeof(buf)=
);
>  	if (err)
>  		return err;
> =20
> -	irq_mask =3D i2c_smbus_read_byte_data(client, ABX8XX_REG_IRQ);
> -	if (irq_mask < 0)
> -		return irq_mask;
> +	err =3D regmap_read(priv->regmap, ABX8XX_REG_IRQ, &irq_mask);

[Severity: Low]
Does this pass an incompatible pointer type to regmap_read()?

This passes an int pointer (&irq_mask) instead of an unsigned int pointer.

> +	if (err < 0)
> +		return err;
[ ... ]
> @@ -379,22 +376,22 @@ static int abx80x_rtc_set_autocalibration(struct de=
vice *dev,
>  	}
> =20
>  	/* Unlock write access to Oscillator Control Register */
> -	if (abx80x_write_config_key(client, ABX8XX_CFG_KEY_OSC) < 0)
> +	if (abx80x_write_config_key(dev, ABX8XX_CFG_KEY_OSC) < 0)
>  		return -EIO;
> =20
> -	retval =3D i2c_smbus_write_byte_data(client, ABX8XX_REG_OSC, flags);
> +	retval =3D regmap_write(priv->regmap, ABX8XX_REG_OSC, flags);

[Severity: High]
Does this hardware unlock sequence get broken by read-modify-write inversio=
n?

According to the datasheet, any subsequent I2C access (read or write) resets
the configuration key to zero. If this sequence uses a read-modify-write
operation (such as regmap_write_bits()), a hardware read is performed after
the unlock key is written. This read resets the configuration key, causing =
the
hardware to ignore the subsequent write and breaking features like
autocalibration.

> =20
>  	return retval;
>  }
> =20
>  static int abx80x_rtc_get_autocalibration(struct device *dev)
>  {
> -	struct i2c_client *client =3D to_i2c_client(dev);
> -	int flags =3D 0, autocalibration;
> +	struct abx80x_priv *priv =3D dev_get_drvdata(dev);
> +	int flags =3D 0, autocalibration, err;
> =20
> -	flags =3D  i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
> -	if (flags < 0)
> -		return flags;
> +	err =3D regmap_read(priv->regmap, ABX8XX_REG_OSC, &flags);

[Severity: Low]
Does this pass an incompatible pointer type to regmap_read()?

This passes an int pointer (&flags) instead of an unsigned int pointer.

> +	if (err < 0)
> +		return err;
[ ... ]
> @@ -467,10 +464,10 @@ static ssize_t oscillator_store(struct device *dev,
>  		flags |=3D (ABX8XX_OSC_OSEL);
> =20
>  	/* Unlock write access on Oscillator Control register */
> -	if (abx80x_write_config_key(client, ABX8XX_CFG_KEY_OSC) < 0)
> +	if (abx80x_write_config_key(dev->parent, ABX8XX_CFG_KEY_OSC) < 0)
>  		return -EIO;
> =20
> -	retval =3D i2c_smbus_write_byte_data(client, ABX8XX_REG_OSC, flags);
> +	retval =3D regmap_write(priv->regmap, ABX8XX_REG_OSC, flags);

[Severity: High]
Does this hardware unlock sequence get broken by read-modify-write inversio=
n?

As noted in abx80x_rtc_set_autocalibration() above, a hardware read perform=
ed
after the unlock key is written clears the key. This resets the key before =
the
protected write if a read-modify-write operation like regmap_write_bits() is
used.

>  	if (retval < 0) {
>  		dev_err(dev, "Failed to write Oscillator Control register\n");
[ ... ]
> @@ -513,45 +509,43 @@ static const struct attribute_group rtc_calib_attr_=
group =3D {
> =20
>  static int abx80x_alarm_irq_enable(struct device *dev, unsigned int enab=
led)
>  {
[ ... ]
>  static int abx80x_ioctl(struct device *dev, unsigned int cmd, unsigned l=
ong arg)
>  {
> -	struct i2c_client *client =3D to_i2c_client(dev);
> -	int status, tmp;
> +	struct abx80x_priv *priv =3D dev_get_drvdata(dev);
> +	int err, status, tmp;
> =20
>  	switch (cmd) {
>  	case RTC_VL_READ:
> -		status =3D i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
> -		if (status < 0)
> -			return status;
> +		err =3D regmap_read(priv->regmap, ABX8XX_REG_STATUS, &status);

[Severity: Low]
Does this pass an incompatible pointer type to regmap_read()?

This passes an int pointer (&status) instead of an unsigned int pointer.

> +		if (err < 0)
> +			return err;
[ ... ]
> @@ -856,11 +898,11 @@ static int abx80x_probe(struct i2c_client *client)
>  		 * Write the configuration key register to enable access to
>  		 * the config2 register
>  		 */
> -		if (abx80x_write_config_key(client, ABX8XX_CFG_KEY_MISC) < 0)
> +		if (abx80x_write_config_key(&client->dev, ABX8XX_CFG_KEY_MISC) < 0)
>  			return -EIO;
> =20
> -		err =3D i2c_smbus_write_byte_data(client, ABX8XX_REG_OUT_CTRL,
> -						data | ABX8XX_OUT_CTRL_EXDS);
> +		err =3D regmap_write(regmap, ABX8XX_REG_OUT_CTRL,
> +				   data | ABX8XX_OUT_CTRL_EXDS);

[Severity: High]
Does this hardware unlock sequence get broken by read-modify-write inversio=
n?

For RV1805, the key is written, but if a read-modify-write operation like
regmap_write_bits() is used here, it performs a read before writing the EXTI
disable bit. This read clears the key, leaving the write ineffective and
defeating the extra power leakage workaround.

>  		if (err < 0) {
>  			dev_err(&client->dev,
>  				"Unable to write output control register\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722195814.2985=
52-1-apokusinski01@gmail.com?part=3D3
