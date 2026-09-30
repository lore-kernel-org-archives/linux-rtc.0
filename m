Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7FF45FFC3
	for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768406; cv=none; b=OLJAtDnuCz0TdsCsqtbQ6c9wluU2qRcBxo14pDwuh2JHJiDIs7Jstrr4uOi2jimdxbTLPjhTeP2Vry0YtDHo8IzUkoB6y4lnNqxW5dNo3ZGZ5z5SQa5ljzYOsWxRhCfdqs3AxbJVu7QJx3u/lUqdbz/FNxuyNivCQpbzqtWC9fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768406; c=relaxed/simple;
	bh=Vw/rSv/Th0o6AUtKeRsllncK99g84c7wx6V2u0yExMU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cE+0sJ6FAaDjpKyY5xsz7YMBl/wy8jodnnsqc/j/z2E/GISsQad20hiM14nsDTtCWRhLJBOKghfPrvzlp8mVYeCqsKMdpYIg33Szc2iAHd9gf+xAWOI2256xtjBdna5nTYPbXaGg1WmUNhwW6B5mZMj4IZ1rY2b4zcwd3ZDxv8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cH1O+nah; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cH1O+nah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6661F000FF;
	Wed, 30 Sep 2026 11:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790768405;
	bh=rgvvPUfCgWOMZImeRfHm1/7rZTbM5B4DAk1buN9d+wA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cH1O+nahIq5jsc93rBNKwx7mtqCmz7mOlJx925F/UIQJYfGQf3Xi/id0+4MqyGVMD
	 hthLZ7dsAF2Go6FVJtIAnfO0yRk5yvSZD/ia1+JUME6GJb8fJ/MFj0ASYoef/KG8Py
	 o2XqcMAPvzy4gSALwR+1aE+/nkeMp9LoyiAn5tMAm+udoViV+fEmXyD2pwjhm6g/7J
	 M2ifuiiZJo/g+aDjBeKP+9YYq/91t99keJiJCXLSawgTsh1tdHk3BsVONgfgajpNR3
	 Jz5c+YyzgdFRWYPnvSKltC0XeaRIiK9vbkUFKwWqphNBLPPlLGKt2xZlUzExMFkYZ5
	 qFrv/4+oL9gNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: pcf8563: add SMBus support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Walle" <mwalle@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260930113126.720555-1-mwalle@kernel.org>
References: <20260930113126.720555-1-mwalle@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 11:40:04 +0000
Message-Id: <20260930114005.2C6661F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] rtc: pcf8563: time tearing on SMBus adapters lacking block read
--

commit 22b80c04bcdbffd7bde30f876c7c59ca8c532372
Author: Michael Walle <mwalle@kernel.org>

rtc: pcf8563: add SMBus support

This commit removes the restriction that the driver can only be used with
I2C controllers. It delegates bus compatibility checks to regmap, aiming
to allow the driver to work on SMBus controllers that support block
accesses.

> diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
> index 7eebdb0580674..eee9bc752b52a 100644
> --- a/drivers/rtc/rtc-pcf8563.c
> +++ b/drivers/rtc/rtc-pcf8563.c
> @@ -479,9 +479,6 @@ static int pcf8563_probe(struct i2c_client *client)
> =20
>  	dev_dbg(&client->dev, "%s\n", __func__);
> =20
> -	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> -		return -ENODEV;
> -
[Severity: High]
Could removing this check lead to time tearing on restricted SMBus adapters?

While the commit message mentions SMBus controllers supporting block
accesses, removing the check entirely delegates bus validation to regmap. If
the adapter only supports I2C_FUNC_SMBUS_BYTE_DATA and lacks block transfer
capabilities, regmap silently falls back to regmap_smbus_byte:

drivers/base/regmap/regmap-i2c.c:regmap_get_i2c_bus() {
    ...
    else if (config->val_bits =3D=3D 8 && config->reg_bits =3D=3D 8 &&
             i2c_check_functionality(i2c->adapter,
                                     I2C_FUNC_SMBUS_BYTE_DATA))
        bus =3D &regmap_smbus_byte;
    ...
}

Because of this fallback, when pcf8563_rtc_read_time() reads the time:

drivers/rtc/rtc-pcf8563.c:pcf8563_rtc_read_time() {
    ...
    err =3D regmap_bulk_read(pcf8563->regmap, PCF8563_REG_ST1, buf,
                           sizeof(buf));
    ...
}

The bulk read executes as a loop of separate single-byte SMBus reads instead
of an atomic transaction. Since each SMBus byte transaction issues its own
STOP condition, the RTC's internal register latch is released between reads.

Does this allow the hardware time to roll over mid-read and result in
corrupt time data?

>  	pcf8563 =3D devm_kzalloc(&client->dev, sizeof(struct pcf8563),
>  				GFP_KERNEL);
>  	if (!pcf8563)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930113126.7205=
55-1-mwalle@kernel.org?part=3D1
