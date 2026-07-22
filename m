Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB7942669E;
	Wed, 22 Jul 2026 20:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784751235; cv=none; b=CSG57A39bKgBOjKHg2/mtUAKORYlZ01xlj+pvUPQmMv3XZxyji+lsOXIV4w+BsOQ+hUZbRYQ5HMJv8UMMKqBXzgGykHY7xbDuO5jIwqQ4v41YM1h0tRu6Yi9LWdSg3GYtrOM2Qi2EsfhLdCSIczMGa5jhKaApcsxjF7xxgkOvGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784751235; c=relaxed/simple;
	bh=ZmAYaHQ9iDHh+GcjRMXyAlaRyu0IcIMTI8hhsqmgkZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CTicX6hYtZ2XZX2co0CD9tuAcz3SJ/xZwXozP++7TNZcHnYntppslNRnaocu/SpWQ18baCdfaf53j4pP8PXw29WRN9WhDjxCQFHdeJV1FJXfPaHzTNSttEC92Sq4y+SM/yCkNs+MzNULzJue88UrlWrvBNmqVDm+qSm9OaorFzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UapRAq61; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UapRAq61"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDA11F000E9;
	Wed, 22 Jul 2026 20:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784751234;
	bh=ylUR6OIduykRQkdadb/51xcyO42K82iV/6FKoGeuMKo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UapRAq61G8PEMOUPtDeauCenlevzKIOLNd/4m7815XaWPJ2zXntjDn97eV4UA9Rx2
	 8WTCLibRvGJxHO51ebTiGkAyaidv4DLvTmyn7KoWRMlm5AqfKEdJDOv9MEPMVOnaU4
	 YgAeXLxCUjywx5P1Khz4YDZHY8QYSlM68cLXD4lu7XdvI8vUJpBOwUd04ogojhfm9g
	 Pie0gNzfVzpZszz42b4dazYKcMW9c05PAZRFY3Yvc5uOOpbJjDWtLdSZ3HEMO42Afs
	 2b6k9ZUwwbQTRoEE+YFaNmtHTExS22X6UiNttxuzt+oMiqbbWuZO1hmQlGQLZZ1rhT
	 v0itu4nEskxyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] rtc: abx80x: add irq to struct abx80x_priv
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260722195814.298552-3-apokusinski01@gmail.com>
References: <20260722195814.298552-1-apokusinski01@gmail.com>
 <20260722195814.298552-3-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 20:13:53 +0000
Message-Id: <20260722201354.3BDA11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The shared IRQ handler unconditionally returns IRQ_HANDLED and ina=
dvertently clears all status bits.
- [High] The `abx80x_read_alarm` function fails unconditionally on success =
due to incorrect error checking.
--

--- Patch [2]: [PATCH 2/6] rtc: abx80x: add irq to struct abx80x_priv ---
commit ccef71986338cc749e8440b88d073968d465ea5c
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: add irq to struct abx80x_priv
   =20
This patch moves the irq number into struct abx80x_priv so that it
is no longer tied to the i2c_client. This allows the irq number to
be accessed in the case of ABX81X SPI clocks.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 5486d9d0b1e5d..9b0e1d48d9ba3 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
[ ... ]
> @@ -285,11 +286,12 @@ static irqreturn_t abx80x_handle_irq(int irq, void =
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
This is a pre-existing issue, but doesn't i2c_smbus_read_i2c_block_data()=20
return the number of bytes read on success?

Looking at drivers/rtc/rtc-abx80x.c:abx80x_read_alarm():

	err =3D i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_ASC,
					    sizeof(buf), buf);
	if (err)
		return err;

Since it returns 7 on success, will this unconditionally fail and return
early with an error code, leaving the alarm structure uninitialized?

[ ... ]
> @@ -921,19 +925,19 @@ static int abx80x_probe(struct i2c_client *client)
>  	if (err)
>  		return err;
> =20
> -	if (client->irq > 0) {
> -		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
> -		err =3D devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +	if (priv->irq > 0) {
> +		dev_info(&client->dev, "IRQ %d supplied\n", priv->irq);
> +		err =3D devm_request_threaded_irq(&client->dev, priv->irq, NULL,
>  						abx80x_handle_irq,
>  						IRQF_SHARED | IRQF_ONESHOT,

[Severity: High]
This isn't a bug introduced by this patch, but since the IRQ is registered
here with IRQF_SHARED, does abx80x_handle_irq() correctly handle shared
interrupts?

Looking at drivers/rtc/rtc-abx80x.c:abx80x_handle_irq():

static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
{
	[ ... ]
	status =3D i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
	if (status < 0)
		return IRQ_NONE;
	[ ... ]
	i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS, 0);

	return IRQ_HANDLED;
}

If no relevant interrupt flags are set for this device, it still returns
IRQ_HANDLED and writes 0 to ABX8XX_REG_STATUS, clearing all status bits
including non-IRQ bits like BLF. Can this break other devices sharing the
interrupt line and silently drop hardware status flags?

>  						"abx8xx",
>  						client);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722195814.2985=
52-1-apokusinski01@gmail.com?part=3D2
