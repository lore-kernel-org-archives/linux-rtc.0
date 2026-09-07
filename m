Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7017363C64;
	Mon,  7 Sep 2026 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813997; cv=none; b=GeVkCxCEDZ4sejt6dvMjfGPhOpFHnazHgZghFrW7F+QGOUouRGLBTS94fOZWV3Yncb0TOhEkwpeHZZ2nAEm+YQ32QWChQZMtTF+m4i1qpnDcMpauaOsdoRW+SXiOfZUxPvvY8ULZh3jImfg/mUlFRDEvUwymhRfDz0UKUjRd6eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813997; c=relaxed/simple;
	bh=52rIw1CjFvsfvVSsAYDm86GRydXnAExOLhaTYDyI9U8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZH0AuDkecOrRSpfQrKJYiqdZO3X/aJ5hEqWpXhnANJbMF5f0VDUHILqjawUspfonAmaGtT2eJR1zbrMqPlKrZ8Vco+HBwhYHEw3rcTHiSzbaFXJoU59oecRGfQW2PpXBapW2W83boNF458Cr74VTsyeDtwTrnlrTnDbkkhsTdHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCOWlXQh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCOWlXQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AB71F00A3D;
	Mon,  7 Sep 2026 20:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788813995;
	bh=nXFt35lqAZbTvPiyJSDk9KCVW6Z1ZF0Wlel1HnUtupA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gCOWlXQhvrk5XySCMfYzpfqW9vvK33EFV7VSnMlSy7myOZvJCn80BMyP5X4c/OO3x
	 xZ4Q+JuA/7QaYMV3Z5k+JPUWi8zJjk+sSLu0p9niKkRv36KpG2yPYEAg9Ax3StuzD0
	 ObTLWLCeJ55Uf8XvA4jbZIcACuv3SlGq3fu5+C7UY5QHixi27VmfMAgQE9fliZRdtZ
	 T/TUkWXvdKkeHqBRHVqwdDXXIq4aDzGjvV32jR5VxNnYYrA0chjPzNpgaJRA+r5iHf
	 CxYNVdqXHk5Ue5403FhZ/VisK6NrpyeX8lIVld2KErY5bAJh+yXyFKgo42ptMcZe0Q
	 LDEDlt6U+w8lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/9] rtc: abx80x: replace read-modify-write pattern
 with regmap helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260907203216.53192-8-apokusinski01@gmail.com>
References: <20260907203216.53192-1-apokusinski01@gmail.com>
 <20260907203216.53192-8-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 20:46:34 +0000
Message-Id: <20260907204635.27AB71F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Refactoring to `regmap_write_bits()` and `regmap_update_bits()` br=
eaks the hardware register unlock sequence by inserting an implicit I2C rea=
d transaction.
--

commit 46c86d8ff37edcfaf17e15de29d0c3426614da35
Author: Antoni Pokusinski <apokusinski01@gmail.com>
Date:   Mon Sep 7 20:32:14 2026 +0000

    rtc: abx80x: replace read-modify-write pattern with regmap helpers
   =20
    Before introducing the regmap usage in the driver, updating specific
    bits of a register was performed using the read-modify-write pattern.
    Now, the functions regmap_update_bits() and regmap_write_bits() can
    be used to simplify the code.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 7b8e6546ccffc..b1d8d5a5ddcf0 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
[ ... ]
> @@ -405,13 +390,15 @@ static int abx80x_rtc_set_autocalibration(struct de=
vice *dev,
>  		flags |=3D (ABX8XX_OSC_ACAL_1024 | ABX8XX_OSC_ACAL_512);
>  	}
> =20
> +	guard(mutex)(&priv->lock);
> +
>  	/* Unlock write access to Oscillator Control Register */
>  	if (abx80x_write_config_key(dev, ABX8XX_CFG_KEY_OSC) < 0)
>  		return -EIO;
> =20
> -	retval =3D regmap_write(priv->regmap, ABX8XX_REG_OSC, flags);
> -
> -	return retval;
> +	return regmap_write_bits(priv->regmap, ABX8XX_REG_OSC,
> +				 ABX8XX_OSC_ACAL_1024 | ABX8XX_OSC_ACAL_512,
> +				 flags);
>  }

[Severity: High]
Does this implicit read within regmap_write_bits() reset the hardware unlock
key?

Because the driver does not use a regmap cache (REGCACHE_NONE), calling
regmap_write_bits() or regmap_update_bits() will perform an implicit I2C
read before the write.=20

In abx80x_rtc_set_autocalibration(), any I2C transaction occurring after the
unlock key is written might reset the hardware protection state machine, ca=
using
the subsequent write to fail.

[ ... ]
> @@ -488,24 +474,14 @@ static ssize_t oscillator_store(struct device *dev,
> =20
>  	guard(mutex)(&priv->lock);
> =20
>  	/* Unlock write access on Oscillator Control register */
>  	if (abx80x_write_config_key(dev->parent, ABX8XX_CFG_KEY_OSC) < 0)
>  		return -EIO;
> =20
> -	retval =3D regmap_write(priv->regmap, ABX8XX_REG_OSC, flags);
> -	if (retval < 0) {
> +	retval =3D regmap_write_bits(priv->regmap, ABX8XX_REG_OSC, ABX8XX_OSC_O=
SEL,
> +				   rc_mode =3D=3D 0 ? 0 : (ABX8XX_OSC_OSEL));
> +	if (retval < 0)
>  		dev_err(dev, "Failed to write Oscillator Control register\n");
> =20
>  	return retval ? retval : count;

[Severity: High]
Does this have the same issue with the implicit read voiding the unlock
sequence?=20

The sysfs update to ABX8XX_REG_OSC might silently fail here.

[ ... ]
> @@ -948,8 +891,14 @@ static int abx80x_probe(struct i2c_client *client)
>  		if (abx80x_write_config_key(&client->dev, ABX8XX_CFG_KEY_MISC) < 0)
>  			return -EIO;
> =20
> -		err =3D regmap_write(regmap, ABX8XX_REG_OUT_CTRL,
> -				   data | ABX8XX_OUT_CTRL_EXDS);
> +		/*
> +		 * Avoid extra power leakage. The RV1805 uses smaller
> +		 * 10pin package and the EXTI input is not present.
> +		 * Disable it to avoid leakage.
> +		 */
> +		err =3D regmap_write_bits(regmap, ABX8XX_REG_OUT_CTRL,
> +					ABX8XX_OUT_CTRL_EXDS,
> +					ABX8XX_OUT_CTRL_EXDS);
>  		if (err < 0) {
>  			dev_err(&client->dev,
>  				"Unable to write output control register\n");

[Severity: High]
Can the RV1805 specific output control configuration fail here?

Similar to the oscillator register, writing to ABX8XX_REG_OUT_CTRL requires=
 an
unlock key sequence that could be broken by the implicit I2C read.

[ ... ]
> @@ -1026,11 +961,10 @@ static int abx80x_probe(struct i2c_client *client)
>  	if (abx80x_write_config_key(client, ABX8XX_CFG_KEY_OSC) < 0)
>  		return -EIO;
> =20
> -	err =3D regmap_write(regmap, ABX8XX_REG_OSC,
> -			   data & ~(ABX8XX_OSC_ACIE |
> -				    ABX8XX_OSC_OFIE));
> +	err =3D regmap_write_bits(regmap, ABX8XX_REG_OSC,
> +				ABX8XX_OSC_ACIE | ABX8XX_OSC_OFIE, 0);
>  	if (err < 0) {
> -		dev_err(&client->dev, "Unable to write Oscillator Control register\n");
> +		dev_err(&client->dev, "Unable to update Oscillator Control register\n"=
);
>  		return -EIO;
>  	}

[Severity: High]
Will oscillator control initialization at probe time fail due to the inject=
ed
read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907203216.5319=
2-1-apokusinski01@gmail.com?part=3D7
