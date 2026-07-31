Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0715B4457CC;
	Fri, 31 Jul 2026 19:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524761; cv=none; b=j1RQixjSLGmK5EOLxZUqv4g+VF042y/SBvfvF35MzNZWJopTGNXlxGuAxXCOBHtBJjM9X7cEAxQkzKhy/IyB+r3CGgZ7wAsa6TEBJSXN6NAeqGwYc7WmQr4ph3fTbYiLQyvrAa9L//LUAj+sjllZxJln9ZHO1hzfObRtaOPy9TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524761; c=relaxed/simple;
	bh=ZatPeAdYctub94Bw6iPqInWQ0rkgn/DS43hecBMvsH8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z/EU/0icBGTbzqHsggev4VTdwmTN470PFK83OQgtSo7HEz2Loe2yFdz4MMKbt9r2CEGNzxLqjzlO6DPXZITCkdE3SKt5KTAG/2a8uiPtJPFkQUf9gGnYISD2RstPY50yyBm/P+CecBEZFuQZGeF05bGrST4GaZ1aSkq1RCXMDAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlliRdjz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlliRdjz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CCB1F00AC4;
	Fri, 31 Jul 2026 19:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785524759;
	bh=SpN7yCiOwtiXMfkBD6i6j7uZxFlOHws8G5uJ8XND5/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VlliRdjzj9couzRZmBoGpE+OUkvC2pfXYI9hvQb2etmRmep5dzCbADXMgWzVlhe7M
	 rxY1OPPWpLC2cwWzbTPkJL3dlkbhvnuLAB6n0IS5bWJf9QzlQRPDZfRHIyihK/hf1H
	 Ul32NdT2gI8/N+oa+FLwV70q46oflXgf86flUDSEPi19Sy5MOkXDD/BKl+X1NeHVOF
	 5KGUXNq0gxbzlOt1pIQmM+xy7tweQqizE80MxYBwq/OIb8gl+L+9VLp1TetasKyaxD
	 Ty2v5VfBuLBqoi07o1rV/9a0Qlvz+UekndVYL8kIxtWHE/OhQIqnTeFM8wFYBMx+0t
	 8JR3o3kD5PkXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/8] rtc: abx80x: use regmap instead of I2C specific
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260731184831.44037-6-apokusinski01@gmail.com>
References: <20260731184831.44037-1-apokusinski01@gmail.com>
 <20260731184831.44037-6-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 19:05:58 +0000
Message-Id: <20260731190559.39CCB1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Variables declared as `int` are passed by reference to `regmap_read=
`, which expects an `unsigned int *`.
--

--- Patch [5]: [PATCH v3 5/8] rtc: abx80x: use regmap instead of I2C specif=
ic API ---
commit 5bae78c37282c7d7693255ad432126ac7e8c51f8
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: use regmap instead of I2C specific API

This commit reworks the abx80x RTC driver to use regmap API instead of=20
i2c_smbus functions. This prepares the driver for future ABX81X SPI support.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 4ac3ace687a1e..23823fc2f5458 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c

[ ... ]

> @@ -221,8 +224,7 @@ static int abx80x_rtc_read_time(struct device *dev, s=
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
Will this cause a compiler error on GCC 14+ due to incompatible pointer typ=
es?

The regmap_read() function expects an "unsigned int *" for its third argume=
nt,
but "flags" is declared as an "int" here.

It looks like this same issue with passing an "int *" to regmap_read() also
happens with the "flags" variable in abx80x_rtc_set_autocalibration() and
oscillator_store(), as well as with the "data" variable in abx80x_probe().

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731184831.4403=
7-1-apokusinski01@gmail.com?part=3D5
