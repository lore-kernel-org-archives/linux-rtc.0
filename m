Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C73A1EE7C6;
	Mon,  7 Sep 2026 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813985; cv=none; b=hCAl0Bs8bf91c1jV6yrbMM4uqW4SQRwAxsLN4bnMONh9KQM00SuDBSicRdBX693uNjf3Dl5rykx/9rPKzDkijLONM4ygtUbnb+sEedAP8g1IO3UMQWRI2Cfwk0HvZSzary3TlUJ6V2iFwI9AePK5fC5E/tJ+FOCZs60S1H2ccHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813985; c=relaxed/simple;
	bh=dnzOAh+dZKgVPeI25JnzRKe+9mewNldSaHJuFF7F0Bo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m3OVd5fOcD7ujVobZQENt3/8RD2VA6y2jAyvFlbOamWKl6WRdd8eB4iVv5ty17D3CJsaWnAmgvHEmfDpQLX1dX2uHkFGH79wrnuw+W7r/GxXUEaMEZrUOVDN4ecsXMcD3iJ/lFbG89EXEjnBNqWX5wk9akDYE7d4ExTgsHxgMdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfChq3j3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfChq3j3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8B11F00A3A;
	Mon,  7 Sep 2026 20:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788813983;
	bh=AXUVjro0ru+tUmSf3IRnh7M1CiJlNQ3LvpgosSxB1cM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XfChq3j30/TcjcFckU0cdu8afFjTT+QAsTOmsXzB06X9FLKNp0gRaR5itr3kfq13r
	 6HLbgoOHbBhw33sbl9akVo1aOdtKzNjbnV7jxaWqVPHbrxHTyACMx/Cvyv6PbBN28j
	 vjgwLnjmGgleuTm2TYKA4nzd98UhjVeVq0swzRCiyJ+3I2Q4wecGn3HUR3BXsU3lnM
	 a47naSw5NgnFcOC+uI6Tzs6rdZ2WVw+gBUp9XM/5kZnBJ3I0g5uEm7SMTDZKIi0h03
	 C1siFDcrnx0Nu8FSuyfnu/k7l/sjbgUeQ+QfS3yoAZiXe//pOhBsN6Idnxyb9KIbNO
	 B3X6rB3tOABDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/9] rtc: abx80x: properly handle shared IRQs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260907203216.53192-5-apokusinski01@gmail.com>
References: <20260907203216.53192-1-apokusinski01@gmail.com>
 <20260907203216.53192-5-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 20:46:22 +0000
Message-Id: <20260907204623.4A8B11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Multi-step configuration key unlock and register write in `abx80x_=
probe` is unprotected by a mutex, leading to a race condition with concurre=
ntly registered userspace interfaces.

Pre-existing issues:
- [High] Read-modify-write of the W0C status register in `abx80x_ioctl` (`R=
TC_VL_CLR`) can silently clear and drop concurrently set interrupt flags li=
ke the Alarm Flag.
--

commit c2d2310ab46eb6d5c2902acd74a3eb39a0bda185
Author: Antoni Pokusinski <apokusinski01@gmail.com>

    rtc: abx80x: properly handle shared IRQs
   =20
    The abx80x RTC driver registers its interrupt handler with IRQF_SHARED,
    but the handler always returned IRQ_HANDLED and cleared the status
    register even when no interrupt source from the RTC was active.
   =20
    This could cause the driver to claim interrupts belonging to other
    devices sharing the same IRQ line and could also clear unrelated status
    bits in the RTC status register.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 44de234efecf7..8f9211bfb7e24 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c

[ ... ]

> @@ -952,6 +965,41 @@ static int abx80x_probe(struct i2c_client *client)
>  	if (err)
>  		return err;
> =20
> +	/* Disable unused interrupts */
> +	data =3D i2c_smbus_read_byte_data(client, ABX8XX_REG_IRQ);
> +	if (data < 0) {
> +		dev_err(&client->dev, "Unable to read irq register\n");
> +		return -EIO;
> +	}
> +
> +	err =3D i2c_smbus_write_byte_data(client, ABX8XX_REG_IRQ,
> +					data & ~(ABX8XX_IRQ_EX1E |
> +						 ABX8XX_IRQ_EX2E |
> +						 ABX8XX_IRQ_TIE |
> +						 ABX8XX_IRQ_BLIE));
> +	if (err < 0) {
> +		dev_err(&client->dev, "Unable to write irq register\n");
> +		return -EIO;
> +	}
> +
> +	data =3D i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
> +	if (data < 0) {
> +		dev_err(&client->dev, "Unable to read Oscillator Control register\n");
> +		return -EIO;
> +	}
> +
> +	/* Unlock write access to Oscillator Control Register */
> +	if (abx80x_write_config_key(client, ABX8XX_CFG_KEY_OSC) < 0)
> +		return -EIO;
> +
> +	err =3D i2c_smbus_write_byte_data(client, ABX8XX_REG_OSC,
> +					data & ~(ABX8XX_OSC_ACIE |
> +						 ABX8XX_OSC_OFIE));

[Severity: High]
Since this unlocked two-step I2C transaction in abx80x_probe() occurs after
the watchdog is exposed to userspace, is it vulnerable to concurrent aborts?

If a concurrent userspace process opens and pings the watchdog, it
acquires priv->lock and issues an I2C write. This would interleave and
abort the configuration key sequence, causing the subsequent write to
ABX8XX_REG_OSC to be silently ignored.

This would leave unwanted hardware interrupts (ACIE, OFIE) enabled. If
these fire, the newly updated IRQ handler returns IRQ_NONE without
clearing them, causing an interrupt storm that forces the kernel to
permanently disable the RTC IRQ line.

> +	if (err < 0) {
> +		dev_err(&client->dev, "Unable to write Oscillator Control register\n");
> +		return -EIO;
> +	}
> +
>  	if (client->irq > 0) {
>  		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
>  		err =3D devm_request_threaded_irq(&client->dev, client->irq, NULL,


This isn't a bug introduced by this patch, but looking at the RTC_VL_CLR
handling in abx80x_ioctl():

drivers/rtc/rtc-abx80x.c:abx80x_ioctl() {
    ...
	case RTC_VL_CLR:
		scoped_guard(mutex, &priv->lock) {
			status =3D i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
			if (status < 0)
				return status;

			status &=3D ~ABX8XX_STATUS_BLF;

			tmp =3D i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS,
							status);
    ...
}

[Severity: High]
Can this read-modify-write pattern silently clear and drop concurrently
set interrupt flags like the Alarm Flag?

Because ABX8XX_REG_STATUS is a Write-0-to-Clear (W0C) register, any bit
that was 0 during the read is written back as 0. If the hardware asserts
a new flag in the window between the read and the write, the write of 0
will accidentally clear it before the IRQ handler can process it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907203216.5319=
2-1-apokusinski01@gmail.com?part=3D4
