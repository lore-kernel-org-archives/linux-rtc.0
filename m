Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4BF345EBF;
	Tue, 11 Aug 2026 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786478154; cv=none; b=OHEGNb50yWbcVVVg6ftDkC3gbs3Md4UZJTFhRGOGyPfvFQulu3w2U4Me5PczAqBGSsls4LmpeJqgJXQDYEEonJKPAjmxYCWpyn5Xo58UaGn0Fq0C29n/+uG+IfsoJQUUR5AMcK6zaWdrSG4I18tlOeLN/Kuxt4efzfYrINBu/f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786478154; c=relaxed/simple;
	bh=9nyu86UATwN1US+hbmcVVGIVBQVOw/1ujZ/3z6aGcZg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eXF0ZLXRlSxxiR1vt/Z7mzw4KDBB8V/NFqz29fNfn140TYWrfSZhROF23ePtH5Rzm8JrLEXxmsCtvRVM0E5M3lWhoxtFTb+2fJwRDx7cKUN5rjpYQuBYHerXFcGReyOYu66tidBRej/LMMGbFmMewIhaLzno4jzCu6IJzmExviM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCYV3Jm9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCYV3Jm9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BEF1F000E9;
	Tue, 11 Aug 2026 19:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786478152;
	bh=vXYpM9IQeuhclNFMlPibqWgM5F9O6bHqAJ20k9AMhLM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dCYV3Jm9X2kqzZkMUNW5QfPaIuOY2GtlBvvToNs518xlEL3DddEA1kFdc0t/Uum7C
	 tBBYDaupNbkZ9EzQIqgFqrr6GrLo3rDdxguaKrFBsW01KlGdnhutDhz5MlPoUr/3E0
	 bwunlBxsnCtsWthFCylyuKhPjk9ZkST/b+wz3WL28Hl9kjgiAZ9Ftgj3LOkVkxFW+b
	 J93kefeP6/oushP+gTVJLHlZK1wnheis3f7JjZyvHF7PzU6Qq8Zr/e4KXOukTozhTe
	 cs2EHdLnayNshyb49WUF53kNKbY6gHdyp51u0gRJBHwDGaS7FBRybGk3A6Ys5pRfqy
	 F11KsmS5HSQMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/9] rtc: abx80x: use regmap instead of I2C specific
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: linux-rtc@vger.kernel.org, conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260811194034.28937-7-apokusinski01@gmail.com>
References: <20260811194034.28937-1-apokusinski01@gmail.com>
 <20260811194034.28937-7-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 19:55:51 +0000
Message-Id: <20260811195552.45BEF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Passing an `int *` to `regmap_read()` triggers a `-Wpointer-sign` c=
ompiler warning.
--

--- Patch [6]: [PATCH v5 6/9] rtc: abx80x: use regmap instead of I2C specif=
ic API ---
commit 451b30314b8903deb9d330c3f8568f14d2e08147
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: use regmap instead of I2C specific API

This commit reworks the ABX80X RTC driver to use the regmap API for
device communication instead of I2C-specific functions. This prepares
the driver to support SPI-based ABX81X devices in the future.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 12a4dbfec6396..5d41882f3c704 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c

[ ... ]

> @@ -227,8 +230,7 @@ static int abx80x_rtc_read_time(struct device *dev, s=
truct rtc_time *tm)
> =20
>  static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
> -	struct i2c_client *client =3D to_i2c_client(dev);
> -	struct abx80x_priv *priv =3D i2c_get_clientdata(client);
> +	struct abx80x_priv *priv =3D dev_get_drvdata(dev);
>  	unsigned char buf[8];
>  	int err, flags;
> =20

[ ... ]

>  	/* Clear the OF bit of Oscillator Status Register */
> -	flags =3D i2c_smbus_read_byte_data(client, ABX8XX_REG_OSS);
> -	if (flags < 0)
> -		return flags;
> +	err =3D regmap_read(priv->regmap, ABX8XX_REG_OSS, &flags);

[Severity: Low]
Does passing an int pointer to regmap_read() here cause a -Wpointer-sign
compiler warning?=20

regmap_read() expects an unsigned int pointer for its val parameter, but
flags is declared as an int at the top of abx80x_rtc_set_time(). This might
break the build if CONFIG_WERROR is enabled.

> +	if (err < 0)
> +		return err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811194034.2893=
7-1-apokusinski01@gmail.com?part=3D6
