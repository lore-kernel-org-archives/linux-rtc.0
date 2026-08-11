Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C936E48C;
	Tue, 11 Aug 2026 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786478216; cv=none; b=DnfIUHGkF2Rg/N2Fg2y1hajs8u87ulJjNZvES+l7uTw3wkMIeS8eXC3G33JzMAR90FSKy0iY/AYFH1/TeyGiKVY515UjMFIuk6ZhKPfLCs5a02kSpSGQM4EZJqmDw9kpsxunvO0fbeXTeeP43hhY9hqVOgAi3R6exAghC+jh/zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786478216; c=relaxed/simple;
	bh=1fD1eD836MjEjgGK8O4QIR1VqFR5Laycopv4LnDE48Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f7uzGxFGNiOYI46KH+hPV+PK8TKK7EzEN4Za/YmBvV8/j5HBfQUL7nTyGpky7wbKK3wklEzxAJCN5nlx/62DLV/nth4u5skqcG9ShmJe+stNhIwAlw4mP9qwcaEnSTJHrhjkYTCp0Vwoygw2glnHHXi9DEnKY0ZE63TddQxjBsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiZcjd8O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiZcjd8O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8590A1F000E9;
	Tue, 11 Aug 2026 19:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786478215;
	bh=sUEd55h3jtDGDUEfFE0mNeIVplk+nwDwRLPhIavml20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZiZcjd8OtKm6Yjxy3gL+7pQwaC68HXgE2TuLpoztCwqOzspYzyk9D00yk4Ue0MUSG
	 5D8suM/9wkRyNUT7oARFt60WqQoQhwOXQpQzmTrg4NDkMqc6zisLJeouQcINET+8E7
	 NrxmEs3Z6kcdFY1WccM7/NVM1PJYKM4B+oCIZuMjSeB3iIjKUG4qy32bfBGLDpP8gp
	 BZ/X3Kg1Ew0+E2uPssbG6XvbOgFVVQNNsJQuhUEukZnscPNgsVoezo/vfRv9F/bGDG
	 T4Zmq4Rttt5xFpRZC4FEgkE5nF3aoK1F/Bu2nT581b0Icl2Xzu2/OzFPNl1uMjL7DG
	 nKKn1lyyOfWuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/9] rtc: abx80x: replace read-modify-write pattern
 with regmap helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: linux-rtc@vger.kernel.org, robh@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260811194034.28937-8-apokusinski01@gmail.com>
References: <20260811194034.28937-1-apokusinski01@gmail.com>
 <20260811194034.28937-8-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 19:56:53 +0000
Message-Id: <20260811195654.8590A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch replaces read-modify-write sequences with `regmap_write_=
bits()` after writing the hardware configuration key, breaking the write-pr=
otection unlock sequence.

Pre-existing issues:
- [High] The probe function attempts to clear interrupt enable bits (`ABX8X=
X_OSC_ACIE` and `ABX8XX_OSC_OFIE`) in the protected Oscillator Control Regi=
ster (`ABX8XX_REG_OSC`) without first writing the required configuration ke=
y (`ABX8XX_CFG_KEY_OSC`).
--

--- Patch [7]: [PATCH v5 7/9] rtc: abx80x: replace read-modify-write patter=
n with regmap helpers ---
commit 6808e36654fbc0a72e9b540a05e0f2557530aa65
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: replace read-modify-write pattern with regmap helpers

This commit replaces read-modify-write sequences with regmap_update_bits()
and regmap_write_bits() to simplify register updates.

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
Does this change break the configuration key unlock sequence?

The configuration key unlock only allows a single I2C write operation. Beca=
use
regmap_write_bits() internally performs a read-modify-write sequence, it
initiates an I2C read transaction before the actual write. Will this insert=
ed
read consume the unlock key and cause the subsequent data write to be silen=
tly
rejected by the hardware?

The original code explicitly read the register before unlocking it to avoid
this sequence.

[ ... ]

> @@ -486,24 +473,14 @@ static ssize_t oscillator_store(struct device *dev,
> =20
>  	guard(mutex)(&priv->lock);
> =20
> -	retval =3D regmap_read(priv->regmap, ABX8XX_REG_OSC, &flags);
> -	if (retval < 0)
> -		return retval;
> -
> -	if (rc_mode =3D=3D 0)
> -		flags &=3D ~(ABX8XX_OSC_OSEL);
> -	else
> -		flags |=3D (ABX8XX_OSC_OSEL);
> -
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
> -		return retval;
> -	}
> =20
>  	return retval ? retval : count;
>  }

[Severity: High]
Will this regmap_write_bits() call also fail for the same reason?=20

Since it follows abx80x_write_config_key(), the implicit read operation will
likely consume the unlock key before the write occurs.

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
Similar to the above, does the implicit read inside regmap_write_bits()
consume the configuration key unlock for the MISC register before the actual
write happens?

[ ... ]

> -	err =3D regmap_read(regmap, ABX8XX_REG_OSC, &data);
> +	err =3D regmap_update_bits(regmap, ABX8XX_REG_IRQ,
> +				 ABX8XX_IRQ_EX1E | ABX8XX_IRQ_EX2E |
> +				 ABX8XX_IRQ_TIE | ABX8XX_IRQ_BLIE, 0);
>  	if (err < 0) {
> -		dev_err(&client->dev, "Unable to read Oscillator Control register\n");
> +		dev_err(&client->dev, "Unable to update irq register\n");
>  		return -EIO;
>  	}
> =20
> -	err =3D regmap_write(regmap, ABX8XX_REG_OSC,
> -			   data & ~(ABX8XX_OSC_ACIE |
> -				    ABX8XX_OSC_OFIE));
> +	err =3D regmap_update_bits(regmap, ABX8XX_REG_OSC,
> +				 ABX8XX_OSC_ACIE | ABX8XX_OSC_OFIE, 0);
>  	if (err < 0) {
> -		dev_err(&client->dev, "Unable to write Oscillator Control register\n");
> +		dev_err(&client->dev, "Unable to update Oscillator Control register\n"=
);
>  		return -EIO;
>  	}

[Severity: High]
This is a pre-existing issue, but does this register update require unlocki=
ng
first?

It appears the probe function attempts to clear the interrupt enable bits i=
n the
Oscillator Control Register without first writing the required configuratio=
n key
(ABX8XX_CFG_KEY_OSC).

If the configuration key is not written first, will the hardware silently i=
gnore
this write, leaving interrupts enabled if they were previously set by the
bootloader?

If an unhandled interrupt (like Autocalibration or Oscillator Failure) fire=
s,
could it cause an interrupt storm? The IRQ handler abx80x_handle_irq() only
checks for AF and WDT flags. Since the IRQ is requested with IRQF_SHARED, an
unhandled interrupt might result in the kernel disabling the shared IRQ line
and breaking unrelated devices.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811194034.2893=
7-1-apokusinski01@gmail.com?part=3D7
