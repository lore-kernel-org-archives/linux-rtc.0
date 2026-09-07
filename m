Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B41363C64;
	Mon,  7 Sep 2026 20:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814038; cv=none; b=lFv2WTO5jXtEyinrHk9vB57262kl0l1F9R0jzYPRkUbthEPxY5k/2Gn/qFZGHuJjEBcjz7sC3F2451zy8WvUVYhI2np8fV2/NX/xtcCo99PkOy0EdqiJKuKRBp3h4vsilD/Fkuownt4bqeuIiGwNkpUvg2cDi/tSQcDiPplPZW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814038; c=relaxed/simple;
	bh=/bmybFEm5YjDagVOoaNxFMI8w1C78mM9nTLPZhKGBj0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OHsXZTkU79mY+9ia021alKY3UC7O3RfGVE3x7KU7YsKUwuT/R/p5jDJuact+abKN7oxYvR97CdFVxhCCzVu1gJWYYHAr3uE9cYb4DRO4ODGHRuzalJCZ17jSC7Ee1bz8cYm1D6Pps9D3CldQFyg73BvFeQOPUzEp8hUni3MMENk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUKlt+eQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUKlt+eQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152FA1F00A3A;
	Mon,  7 Sep 2026 20:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788814036;
	bh=u+F27C5+SpcVrSZ8nKpa+QFsMlsvRBPRuzgEX7932Bk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MUKlt+eQYe7xKR405usRh7dBNPtFDbjH15W13vVIJxnRyd1izvqPB+l2HKv+Fy2Nm
	 DNQ7UyU/aRfJ4NhiOlD+xM319t0ugBstL/vtjZr/XsGKMnLVu4UlnhXaSHNPNH0ls2
	 yplYTUiKStxt2wexYM1C7wyXZF7crfd7sBhgFHy0C3IuSCFgqs4VCAH7Ph5RsseXWZ
	 QBrd9wEohJNmqIVGKWC+uhbK53yTuXjfb9SqVzFll6aAynBY1sv5YyB0Og5uba/5u1
	 tg7YkRD3jJBSdzvbLxGEkezaYpi9HbEI3vpHMcxpeT6sOe6euHe9BL9PLiij0Af7Ct
	 1AJ7sJ2NAP4Ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/9] rtc: abx80x: use regmap instead of I2C specific
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260907203216.53192-7-apokusinski01@gmail.com>
References: <20260907203216.53192-1-apokusinski01@gmail.com>
 <20260907203216.53192-7-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 20:47:15 +0000
Message-Id: <20260907204716.152FA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] abx80x_read_alarm() unconditionally fails and returns -EIO because=
 of a leftover partial-read check.
--

commit 927241f9edd452c16c2bc8ee202f13c63e681b56
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: use regmap instead of I2C specific API

This commit refactors the abx80x RTC driver to use the regmap API
instead of the i2c_smbus_* functions. This abstraction prepares the
driver for future SPI support for ABX81X RTCs.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
> @@ -305,25 +308,24 @@ static irqreturn_t abx80x_handle_irq(int irq, void =
*dev_id)
> =20
>  static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
>  {
> -	struct i2c_client *client =3D to_i2c_client(dev);
> -	struct abx80x_priv *priv =3D i2c_get_clientdata(client);
> +	struct abx80x_priv *priv =3D dev_get_drvdata(dev);
>  	unsigned char buf[7];
> =20
> -	int irq_mask, err;
> +	unsigned int irq_mask;
> +	int err;
> =20
>  	if (priv->irq <=3D 0)
>  		return -EINVAL;
> =20
> -	err =3D i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_ASC,
> -					    sizeof(buf), buf);
> -	if (err < 0)
> +	err =3D regmap_bulk_read(priv->regmap, ABX8XX_REG_ASC, buf, sizeof(buf)=
);
> +	if (err)
>  		return err;
>  	if (err < ARRAY_SIZE(buf))
>  		return -EIO;

[Severity: High]
Does this inadvertently fail on all successful reads?

The legacy i2c_smbus_read_i2c_block_data() function returned the number of
bytes read, but regmap_bulk_read() returns 0 on success. Because
ARRAY_SIZE(buf) is 7, a successful regmap read where err =3D=3D 0 will sati=
sfy
the err < ARRAY_SIZE(buf) condition, causing abx80x_read_alarm() to always
return -EIO.

Should this partial-read check be removed entirely now that the driver uses
regmap_bulk_read()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907203216.5319=
2-1-apokusinski01@gmail.com?part=3D6
