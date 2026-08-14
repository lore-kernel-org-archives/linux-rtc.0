Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8955F3C9EDD;
	Fri, 14 Aug 2026 01:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672641; cv=none; b=tI+0EHq4kbCa2j90yyE+nTgm5S4hI3byeXxpPAOnXmzvWTfuZPrBG6dUkQtir4WUI0OPx8NkUpGDbnRprrBmp1y99njzP0IF5FQtv5CMa1fw47QoBe1cmz55p3eFRsRpg2D2Fd17kTgpMJPmFhIp3cOC5d8yuvInToU+jBk2e9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672641; c=relaxed/simple;
	bh=j20M0Oua+6LQWMnCacxrzHwMX4t9YOY90fkinzTw7a8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ty/7xrVP5AXVhQ12e6xev17ULwrNvKRybgEPSVctAHFsCISzMXEWS5qXxia6l6Gn4Yk2fRGHG6y755i7YuPQr/QPThIt2AOloVLBnBhmgrHqHyqegGwzy++jqIKtf8wOG12Naxps2NGJslbeXIYwvJLsO4Hf8xzFcSLNOJfebBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQ6bmwM/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQ6bmwM/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7101F000E9;
	Fri, 14 Aug 2026 01:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786672640;
	bh=PGKzsdsZVW4zqkgNvmuAyW55mO8VOa3XQ+TY4FW8cdM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lQ6bmwM/g1UH6yOW2aSEsMJXRqaY4Al8GZuhnARoGK+10OTKPQvrd/kuuq5z8qpBq
	 bNv6HsCEdERRFlAejgGWMcWNmetQxQB9r2klHNB08m+JLJhV6LAkXT9G+IZLFSFsB0
	 5vBFiurK5GTZfT/9RczeawFeLJ00WYVH1/JEz9RzWlpvIoXGy4A9p7roP5vrs3G48b
	 6BAqTZ6BUFPVMyNG8tGqJ8yCyzqaO7uWevaEFVmMVXo9TAKhov2BLvg3ievf1wVFKx
	 UIr1I6wKy3k7aE8Y11MP+/EeWqGXEHJD/o4/Z0tLMSI0EPyPm1oUeYHS78XnzstNzn
	 A1uTYcD24umVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/9] rtc: abx80x: use regmap instead of I2C specific
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260810193826.210683-7-apokusinski01@gmail.com>
References: <20260810193826.210683-1-apokusinski01@gmail.com>
 <20260810193826.210683-7-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:57:14 +0000
Message-Id: <20260814015720.2C7101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Pointer target signedness mismatch due to passing `int *` to `regma=
p_read()`.
--

--- Patch [6]: [PATCH v4 6/9] rtc: abx80x: use regmap instead of I2C specif=
ic API ---
commit 2c13ab934066f6ede54c1bee1c9c8966213b138d
Author: Antoni Pokusinski <apokusinski01@gmail.com>
Subject: rtc: abx80x: use regmap instead of I2C specific API

This commit converts the ABX80x RTC driver to use regmap instead of i2c_smb=
us
functions. This enables future support for ABX81X SPI-based variants.

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

[ ... ]

> @@ -246,22 +248,22 @@ static int abx80x_rtc_set_time(struct device *dev, =
struct rtc_time *tm)
> =20
>  	guard(mutex)(&priv->lock);
> =20
[ ... ]
> =20
>  	/* Clear the OF bit of Oscillator Status Register */
> -	flags =3D i2c_smbus_read_byte_data(client, ABX8XX_REG_OSS);
> -	if (flags < 0)
> -		return flags;
> +	err =3D regmap_read(priv->regmap, ABX8XX_REG_OSS, &flags);

[Severity: Low]
This isn't a bug, but could passing a pointer to the signed int flags into
regmap_read() trigger a pointer target signedness mismatch warning?=20

Since regmap_read() expects an unsigned int pointer for its value parameter,
would it be better to change the declaration of flags in abx80x_rtc_set_tim=
e()
to unsigned int to avoid cluttering the build output?

> +	if (err < 0)
> +		return err;
> =20
> -	err =3D i2c_smbus_write_byte_data(client, ABX8XX_REG_OSS,
> -					flags & ~ABX8XX_OSS_OF);
> +	err =3D regmap_write(priv->regmap, ABX8XX_REG_OSS,
> +			   flags & ~ABX8XX_OSS_OF);
>  	if (err < 0) {
> -		dev_err(&client->dev, "Unable to write oscillator status register\n");
> +		dev_err(dev, "Unable to write oscillator status register\n");
>  		return err;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810193826.2106=
83-1-apokusinski01@gmail.com?part=3D6
