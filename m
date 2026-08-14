Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9076A3644B3;
	Fri, 14 Aug 2026 02:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673222; cv=none; b=Ud3P3sCONyRGoqcXKREm3x1fkcBgliXU023jx9Twx1eztECgdul4eucrv4rPtDJqHJ6saw9dtVlTQUzkgoguIvE+Syl4fwmLeaeKIQsYHQz4IL2l1PjoY6RY2oPZr18brHhQJgEoY3FrwPRmcdhvd62W6QDcdfpXZkGLwg+KcsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673222; c=relaxed/simple;
	bh=igiOZ7yxZzxux1kocLeNwzKssuUhs66vlxE3DT/TM4g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HF94gNtDJRhJ0Kwwnxdvwco88r8AtVS7NK0t15oV3S+0NFbJxNLaystv4g9BZHmd5I2jbINmZIXiR/TM6wFexIKK9F9MFZpXHAfcjm8ap/2wMRHTj0kANeg+jo31dH9ugryhLp/QGM2THPmVk2KMlHzy6z80VU9m/6FfybBb0/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apYfVO2S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apYfVO2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CE51F000E9;
	Fri, 14 Aug 2026 02:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786673221;
	bh=zjzDW3sIJ5djjF79pRM8tUgqOBXOdugvzk5nL/mD4AM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=apYfVO2SCULrffiRA+/xWBGar1ZPU7uSyf7kVh4DUko/SHmPah76Jr9bnYRPfsjhP
	 SnlFyBvtYVNuYEuV2C2jjnQzUO7l5Ou5YT7Up5biNsn1R2iqQTbBauFEJp7v+VH4yl
	 HkbI5KZmTqsTURebYPSk9Qpo1uGvDFl7H4zKEweFHEi4McZbcyuOlGoJDQWJ1Nce5/
	 HiBDorlMIrGMG6s54ju35RFJ+JO1kUBIH7MR9nc7cmhrl/xzBnumHHQe1SFxYJsvVH
	 Aq19agzLGvHisi8C/xyCzRGhYk9qcPZL9EFRNcw68D88l0vxvdan6d+nmIxLV8RFNa
	 PcLA0Ej3nN+ZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/9] rtc: abx80x: replace read-modify-write pattern
 with regmap helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260810193826.210683-8-apokusinski01@gmail.com>
References: <20260810193826.210683-1-apokusinski01@gmail.com>
 <20260810193826.210683-8-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 02:07:00 +0000
Message-Id: <20260814020700.D9CE51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Using regmap_update_bits() or regmap_write_bits() breaks the hardw=
are Configuration Key unlock sequence by injecting an I2C read between the =
unlock write and the protected register write.
--

--- Patch [7]: [PATCH v4 7/9] rtc: abx80x: replace read-modify-write patter=
n with regmap helpers ---
commit 9a313450ff6d4e2395638f901f9fccf926bd1dda
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: replace read-modify-write pattern with regmap helpers

This commit replaces manual read-modify-write sequences with
regmap_update_bits() and regmap_write_bits() to simplify the code.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 5d41882f3c704..ab88af43b4fa0 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c

[ ... ]

> @@ -403,13 +389,15 @@ static int abx80x_rtc_set_autocalibration(struct de=
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
Does using regmap_write_bits() here break the hardware Configuration Key un=
lock
sequence?

Since regmap_write_bits() performs a read-modify-write cycle, it injects an
I2C read between the unlock write (abx80x_write_config_key) and the actual
register write.

If the hardware resets the key on any intervening I2C access, this might lo=
ck
the register again, causing the subsequent write to fail silently.

[ ... ]

> @@ -486,24 +473,14 @@ static ssize_t oscillator_store(struct device *dev,
[ ... ]
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

[Severity: High]
Will this read-modify-write cycle also invalidate the unlock key before the
write occurs, similar to the issue in abx80x_rtc_set_autocalibration()?

[ ... ]

> @@ -946,8 +890,14 @@ static int abx80x_probe(struct i2c_client *client)
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
Could the implicit I2C read inside regmap_write_bits() invalidate the MISC
unlock key here as well, causing the EXTI disable write to fail on RV1805
chips and leading to extra power leakage?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810193826.2106=
83-1-apokusinski01@gmail.com?part=3D7
