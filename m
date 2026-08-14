Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4528B361DAE;
	Fri, 14 Aug 2026 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786671878; cv=none; b=P6seiuQDmxMCB2sJKXlr48MzTiuQOaVEBDS7c/+k7qElauo9KO4Vu5slvxrfPE9KEzc5CrrJa6sQ6qCGxY81NR17fCsW2iSh4JbnBjsqZ/nE7xfWB+n+WpUoNYHUqRYtwM5yGN5E74kvwUCRAaF53pyBn6HXL48tte4wp/wMQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786671878; c=relaxed/simple;
	bh=v59VheVSCt+jH3mp1k0ic2aNX/TxxMJXT0fA8lUuw+8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QqR6mY+k4M+9ndBDwTGL4RwqeS0evTkh4eFSpGJ6j2ok2BFmZIZojm9KTVZIuZ1B78Bp1oeROqnFatTZ1A38zVcwpcJ9MUSZRJwnv958QFV4J+x0OxT6JK/ouQ5D0aEf3d3fnCDkS1SYwpD7htd49FRSnFsSpNYf4lySTRAPNa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8SSVybs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8SSVybs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D8C1F000E9;
	Fri, 14 Aug 2026 01:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786671876;
	bh=Z5x8Ib9GQfE7DxkYErfqFDplZ5qD9IHtBho26SZXAOE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b8SSVybscKf63zH5aVqcEno/trNTvry2tPzYAtsvIjsPmlt5/yq97KIsZi/1ExyeR
	 k7PY3GYQu7Z+F/7I6qeEan0lCveYGuOzFWZP+UmAeU/JhR/ODerKg4Vo+iHzc1nTR+
	 UPjHp2kn+PCXguHRqSygQQhroBF1r6jCKJitUNEcyqx9vEwL/gzHbI7WSYu4hDc1gZ
	 OzGenticG5lN235jA0TNjAXNMZBTuAdyW1DhXXdPv0c1SX/FgbCSme2q8frVhUSOUd
	 eqk9UGUZingSbJjKUpcmoPijZ+QIBaRKCDphCE1MZIsV5426C4LUTJDJX+6+sNiLwY
	 R0KZtvhIlqTEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/9] rtc: abx80x: add irq to struct abx80x_priv
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260810193826.210683-6-apokusinski01@gmail.com>
References: <20260810193826.210683-1-apokusinski01@gmail.com>
 <20260810193826.210683-6-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:44:36 +0000
Message-Id: <20260814014436.82D8C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Short reads from I2C block transfers leave stack buffers partially=
 uninitialized, leading to a kernel information leak.
--

--- Patch [5]: [PATCH v4 5/9] rtc: abx80x: add irq to struct abx80x_priv ---
commit efc6d887b1cb64fa6fee7b2ea258d8477f65792a
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: add irq to struct abx80x_priv
   =20
This way the irq number is not tied to the i2c_client and can be
easily accessed also in the case of ABX81X SPI clocks.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 485d1ea08030d..12a4dbfec6396 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
[ ... ]
> @@ -305,11 +306,12 @@ static irqreturn_t abx80x_handle_irq(int irq, void =
*dev_id)
>  static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
>  {
>  	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct abx80x_priv *priv =3D i2c_get_clientdata(client);
>  	unsigned char buf[7];
> =20
>  	int irq_mask, err;
> =20
> -	if (client->irq <=3D 0)
> +	if (priv->irq <=3D 0)
>  		return -EINVAL;
> =20
>  	err =3D i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_ASC,

[Severity: High]
Does the error check following this read adequately handle short reads?

Because i2c_smbus_read_i2c_block_data() returns the number of bytes read on
success, a short read will return a positive value less than sizeof(buf).
With the error check changed to if (err < 0) in this patch series, it fails
to catch short reads.

This bypasses the check and leaves the stack-allocated buf partially
uninitialized. When this uninitialized memory is parsed and eventually expo=
sed
to userspace via RTC ioctls, it introduces a kernel information leak.

This is a pre-existing issue in other functions as well, but I wanted to
point it out since it affects this code path now:

drivers/rtc/rtc-abx80x.c:abx80x_rtc_read_time() {
    ...
	err =3D i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_HTH,
					    sizeof(buf), buf);
	if (err < 0) {
		dev_err(&client->dev, "Unable to read date\n");
		return -EIO;
	}
    ...
}

and:

drivers/rtc/rtc-abx80x.c:abx80x_probe() {
    ...
	err =3D i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_ID0,
					    sizeof(buf), buf);
	if (err < 0) {
		dev_err(&client->dev, "Unable to read partnumber\n");
		return -EIO;
	}
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810193826.2106=
83-1-apokusinski01@gmail.com?part=3D5
