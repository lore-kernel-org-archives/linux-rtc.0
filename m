Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF742A160;
	Wed, 22 Jul 2026 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784751120; cv=none; b=S9dpFs7rF7W4VEdMTmfAbK02V4nlolCnG+H6eI9GsNgzSPi4x6VDjcuDcHSa8/uCr8RZ33xHSGReKT+KK4yqcr3/F7B/h8EOiB5VIO4WdNXrY2aJyT9o0ZgGzJhuMBA2fnpNM6oJ0y+n2sLy7gScQc1Bvl6H7Rrq/FWILsKmIrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784751120; c=relaxed/simple;
	bh=htsgLIgb0niogrRZGpaj90SVaK2NA7ZEAF7U1dP9dq4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LcymUXupjAGnfVUsCJYL1Y5RN0z1gpIjt8oaSrN80nBUsg6hdMKgYspTcS6kGVCVl5++OAK0+YesSXHx7FOEqT0PLWxX1npA66iI7ak3etKFuq/p4xbE9YWbX/RjX6Svqm1NBytEv31R2EQct/zfbHPMSUUF9BQROR2mZx9qYa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxS716fB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxS716fB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB0A1F000E9;
	Wed, 22 Jul 2026 20:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784751118;
	bh=Qo0IDwWvQGBxHi3kJU4g+Bfr2P0ICPjq8CKBIxjzc18=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NxS716fBXkx7uRjv255Gby0ctNkGNb2kG5BMqhnqMlMfAzqw+4mFW2UdcQqSKAggX
	 5pk4I+fRnKIJWrAet70IXaHRqth3krmBuMwtUrx4VKNxlRJ/RzlSVuYfvXtqIEdugA
	 Xca1wpf+XAlAdDOpjHYKMcFT+cbWSLBSZcgPA2kWUIYy/MrPmz2MUKKsijaOs4mA/Q
	 r1lScCLqVYD1GU0CQm6cPqemiloH9Bskcd3dYE7+RHO7iha6LNcjgCCNRC0Ipfxn8p
	 Lb9oxNjf+YD1eZ+RRMcKDcZkxzPM9R7sSLPcXVjWhOWcRw0OjEdTvfoGAktBK/U3Z0
	 Z90T3W4A6pgag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] rtc: abx80x: replace read-modify-write pattern with
 regmap helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260722195814.298552-5-apokusinski01@gmail.com>
References: <20260722195814.298552-1-apokusinski01@gmail.com>
 <20260722195814.298552-5-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 20:11:57 +0000
Message-Id: <20260722201158.3FB0A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Replacing manual read-modify-write patterns with `regmap_write_bit=
s()` or `regmap_update_bits()` breaks the hardware's unlock sequence becaus=
e they inject an implicit I2C read between unlocking the configuration key =
and the actual write, causing the hardware to re-lock the register.
--

--- Patch [4]: [PATCH 4/6] rtc: abx80x: replace read-modify-write pattern w=
ith regmap helpers ---
commit ac40d4eea0cf607d67d28eb1332803662646f9c2
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: replace read-modify-write pattern with regmap helpers
   =20
This patch refactors the driver to use regmap_update_bits() and
regmap_write_bits() instead of manually reading, modifying, and writing
registers. The goal is to simplify the codebase.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index e5ba821a67689..7761cb353994e 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
[ ... ]
> @@ -379,9 +368,9 @@ static int abx80x_rtc_set_autocalibration(struct devi=
ce *dev,
>  	if (abx80x_write_config_key(dev, ABX8XX_CFG_KEY_OSC) < 0)
>  		return -EIO;
> =20
> -	retval =3D regmap_write(priv->regmap, ABX8XX_REG_OSC, flags);
> -
> -	return retval;
> +	return regmap_write_bits(priv->regmap, ABX8XX_REG_OSC,
> +				 ABX8XX_OSC_ACAL_1024 | ABX8XX_OSC_ACAL_512,
> +				 flags);

[Severity: High]
Does replacing regmap_write() with regmap_write_bits() here break the hardw=
are's
unlock sequence?

The regmap_write_bits() function performs an implicit read before writing.
Because it is called immediately after abx80x_write_config_key(), this inje=
cts
an I2C read between unlocking the configuration key and the actual write.

Since the AB08XX/RV1805 RTC requires the protected register write to be the
very next transaction after the configuration key write, won't this read
clear the unlock state and cause the hardware to silently discard the write?

>  }
> =20
>  static int abx80x_rtc_get_autocalibration(struct device *dev)
[ ... ]
> @@ -454,24 +443,14 @@ static ssize_t oscillator_store(struct device *dev,
>  		return -EINVAL;
>  	}
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

[Severity: High]
Could the implicit read introduced by regmap_write_bits() cause the
hardware to re-lock the register?

As with abx80x_rtc_set_autocalibration(), the injected read operation occurs
after unlocking the configuration key with abx80x_write_config_key(), which
disrupts the sequence required to successfully write to the Oscillator Cont=
rol
register.

> +	if (retval < 0)
>  		dev_err(dev, "Failed to write Oscillator Control register\n");
> -		return retval;
> -	}
> =20
>  	return retval ? retval : count;
>  }
[ ... ]
> @@ -901,8 +846,14 @@ static int abx80x_probe(struct i2c_client *client)
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

[Severity: High]
Is it possible that the OUT_CTRL EXDS bit configuration silently fails here?

Since regmap_write_bits() performs a read under the hood, placing it direct=
ly
after the abx80x_write_config_key() unlock command interrupts the required
write sequence, causing the hardware to discard the write operation.

>  		if (err < 0) {
>  			dev_err(&client->dev,
>  				"Unable to write output control register\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722195814.2985=
52-1-apokusinski01@gmail.com?part=3D4
