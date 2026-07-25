Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C78B3161A4;
	Sat, 25 Jul 2026 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784993434; cv=none; b=p0l633evVvrMR3g7EnjkyYNoHG0k1JV3ZziGde5P3jYp3JLsQrO8/kErRCSB4XpYnAqeuFzRLNmLZ1SGFUCk9RZKzXfu5aMl9SIlGmOpYaQhJoUjenK+XVl0scv70hMMA15RULe/XShaqUwkIGE/0WAcpirtQL5KBu24jNFz6l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784993434; c=relaxed/simple;
	bh=oBJycsy0sUro2C/rmciLM5IJiZk+jgTVaVlaYTI8Fa4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fD16AkASrpMGXlt5KXwB4BYQdyxLg0LFtkj+IyKJpNRZBkCB9VlTgJY5K2kmL9enDycpaNK8ziTQWsTNo7vikiFKcZ8ur9K4cFaFvFZo4D5/KQUC1OFJ5Widr1Ip+wYhuuAuw3YPXjM2Co/aTW3ccxYgSW9pYkMQxzjcD4XWJP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gm9zylQe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gm9zylQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874311F000E9;
	Sat, 25 Jul 2026 15:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784993432;
	bh=mqy0l78NoQI6twNVFfQX1EKCUQHdCcvFKE6CxUX5VSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gm9zylQeImuOkdxsCcjF1jY/y+D6/SiESvbuZ7fmEscg/HrNHfYUXEZQlY4P0U6ek
	 Lf/Osey4Hsi2NFGo4bqFOomh+rN2iR4aLD6aNchfk0frSND8QIw22ZadwKL1Ag+NPr
	 DG9vI3cPW6CiyxdiXCTqjM8k5SSW0/BbstXtC/C0iJ9XsFvYIOWrVgTrYlHwl+XurL
	 ZHpPFRvWl+6aC7++fRl23grykJXj1BfrrBopCL0jfk8/xn27Ir4PWgojlyR6MhrRq3
	 1jmuZHRte3h679nwB2YOjMtafZJheG7fZy6Ns51caNos9419F7yUsCdf6b22YlY7L5
	 fabDu0yvJ3x4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/8] rtc: abx80x: add support for ABX81X
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260725145718.14733-9-apokusinski01@gmail.com>
References: <20260725145718.14733-1-apokusinski01@gmail.com>
 <20260725145718.14733-9-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 15:30:32 +0000
Message-Id: <20260725153032.874311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Incorrect SPI read/write flag masks invert SPI commands.
- [Medium] Masking of valid error codes from `devm_regmap_init_*()`.
--

--- Patch [8]: [PATCH v2 8/8] rtc: abx80x: add support for ABX81X ---
commit f05e60a6ab0d5bdeb5665a7f2de3be7428abd444
Author: Antoni Pokusinski <apokusinski01@gmail.com>
Subject: rtc: abx80x: add support for ABX81X

This commit adds SPI support for the Abracon ABX81X family of RTCs. It
introduces the required regmap configuration and SPI driver probe logic.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 7cba72656d094..46434f05a1f7a 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
[ ... ]
> @@ -1026,14 +1029,107 @@ static void abx80x_unregister_driver(void)
> =20
>  #endif /* IS_ENABLED(CONFIG_I2C) */
> =20
> +#if IS_ENABLED(CONFIG_SPI_MASTER)
> +
> +static const struct regmap_config abx80x_regmap_config_spi =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D ABX8XX_SRAM_BASE + ABX8XX_SRAM_WIN_SIZE - 1,
> +
> +	.rd_table =3D &abx80x_read_table,
> +	.wr_table =3D &abx80x_write_table,
> +
> +	.write_flag_mask =3D BIT(7),
> +};

[Severity: Medium]
Does the hardware expect MSB=3D1 for writes and MSB=3D0 for reads? Since
.read_flag_mask is omitted, regmap defaults it to 0. If the device expects
the opposite (MSB=3D1 for reads), the SPI commands could be inverted.

[ ... ]
> +static int abx81x_spi_probe(struct spi_device *spi)
> +{
> +	unsigned int part =3D (uintptr_t)spi_get_device_match_data(spi);
> +	struct regmap *regmap;
> +
> +	regmap =3D devm_regmap_init_spi(spi, &abx80x_regmap_config_spi);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Unable to allocate regmap\n");
> +		return -EIO;
> +	}

[Severity: Medium]
Should this return PTR_ERR(regmap) instead of a hardcoded -EIO? Returning
-EIO here masks the true error code from devm_regmap_init_spi() (like -ENOM=
EM
or -EPROBE_DEFER), which could disrupt probe deferral logic. (It looks like
the existing abx80x_i2c_probe() might have the same behavior.)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725145718.1473=
3-1-apokusinski01@gmail.com?part=3D8
