Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7563C1082;
	Wed, 16 Sep 2026 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592738; cv=none; b=Y52pb73flFGKB/b4FTwSSeh+zRUSujQaehbaL4nlBabj12EWfjb90t0ca0qe+Q7MCel6WMe6qQv93TGOo5HukUKT5hCtSeDYYLx67+wWbyEEkoh6mvNtVc5aofOyOwyIGOmWjxiEs+wYREQZtn9rV20cg18JsyDWzjguupLU74g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592738; c=relaxed/simple;
	bh=ym8Mn69WwsoUw+FEJrRP/a/gIZFRUAApM5SNiDbIZfs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AIaQRG80GUeW2hTKOM1x4D8a1SHlMuxJ+K/jqraawam9uH2lDRAwYq3MUjHQG7rsHDiINoUYDvFgYooPfyjOk/AMxzWMF+Xn6ddB7iLL5bazciQt5kqFYe8xqXg/OUTOg1EqXUSNBhTKYZEzxEFgcaswP0dxe9YRIsRci5ho7ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7c2NGLp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7c2NGLp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B6A1F000FF;
	Wed, 16 Sep 2026 21:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789592720;
	bh=bUixq2NWUuTmrM/rpny4As14DsG1jrVEKpVkZkXCu4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C7c2NGLpXs4Mdfk5pK0rbmhjF7/CQCYxU9gDdejcpVTHY568ZqJcFx+TBR5L4blPH
	 FvfDs0CpKfHpmEN0obyE+jwcd3FcOjVauiPCnw9wDSe6Xi0FBHFrHNOO1yholvUC/j
	 BPEsKxbGdEhKdCsSRTemXyYFKNlI640s1PLMtV3X/Edi02jb45TuVDNMPYHX73KHgw
	 B+70SToksSn0VgyYgieur0thTGkPWVAVvyFQ7eCec5hF9IhOFhiBVIC4TqPRtXosz9
	 5uxHJGd9YapE4bomqz+O434t4+0iErTdxQ7s7xDtfuJtIhC/7vS6uSkRIxhjATPhVH
	 L21EU5Caprd0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/9] rtc: abx80x: replace read-modify-write pattern
 with regmap helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260916205138.16771-8-apokusinski01@gmail.com>
References: <20260916205138.16771-1-apokusinski01@gmail.com>
 <20260916205138.16771-8-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:05:20 +0000
Message-Id: <20260916210520.96B6A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] rtc: abx80x: hardware unlock broken by regmap RMW helpers
--

commit aad0cc39d854acf9e4ccd3b1fa7b17484a428c9a
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: replace read-modify-write pattern with regmap helpers

This commit refactors the driver to replace open-coded read-modify-write
sequences with the regmap_update_bits() and regmap_write_bits() helpers to
simplify the code.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
[ ... ]
> @@ -403,13 +388,15 @@ static int abx80x_rtc_set_autocalibration(struct de=
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
Since regmap_write_bits() performs an internal read-modify-write cycle, will
the initial read operation consume the configuration key unlock?=20

It looks like writing the configuration key only unlocks the very next=20
transaction. If the regmap helper reads first, the actual write might fail=
=20
silently and the hardware would reject the autocalibration settings.

[ ... ]
> @@ -486,24 +472,14 @@ static ssize_t oscillator_store(struct device *dev,
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

[Severity: High]
Does the same issue apply here in oscillator_store()? The internal read=20
within regmap_write_bits() may consume the unlock key, preventing the=20
oscillator selection from being properly updated.

[ ... ]
> @@ -946,8 +889,14 @@ static int abx80x_probe(struct i2c_client *client)
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

[Severity: High]
Could this cause the power leakage mitigation write in abx80x_probe() to be=
=20
rejected by the hardware because the unlock transaction was already consume=
d=20
by the regmap_write_bits() read phase?

[ ... ]
> @@ -1014,11 +949,10 @@ static int abx80x_probe(struct i2c_client *client)
>  	if (abx80x_write_config_key(client, ABX8XX_CFG_KEY_OSC) < 0)
>  		return -EIO;
> =20
> -	err =3D regmap_write(regmap, ABX8XX_REG_OSC,
> -			   data & ~(ABX8XX_OSC_ACIE |
> -				    ABX8XX_OSC_OFIE));
> +	err =3D regmap_write_bits(regmap, ABX8XX_REG_OSC,
> +				ABX8XX_OSC_ACIE | ABX8XX_OSC_OFIE, 0);
>  	if (err < 0) {

[Severity: High]
Will the interrupt disable write also fail silently here due to the unlock=
=20
being consumed by the regmap read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916205138.1677=
1-1-apokusinski01@gmail.com?part=3D7
