Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FE139A4DF;
	Tue, 11 Aug 2026 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477891; cv=none; b=nOP2ewghbio/fmtq1pqOX9FjWYk6smRYfKeO2xZLywpQUdL+Sj+X4+32Fq0G8fSJ3JsPkdNS5G4TrVtXdl1QmvlPL+uD1UnOdsn16mZaP330r7hs6MTHUzo/zuh862PCvmrLw8+ieIDhsGiJOx82eS0p406VA2r59r4mUemIFog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477891; c=relaxed/simple;
	bh=NNbvjE2NXF34remWttMfflIt9KHZC6heLZzx2SHpJjM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I9pD2lsbi9cb1VaxJb5wAIVpuR6b0RmfXJs7FJiAP/s9KxcL8NbcEaSgE+Z2yZGbBRbw2dDEe9pHCDiGIzu26G+MOyhZFH+NwJsSQgIGxG1fpLEMxBNI3v4KAevr3gYEEnuDeXJMrYETEAROaaFY0UxeekTS9FwM/78y3y/5GJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DM3UPr0C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM3UPr0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013C31F000E9;
	Tue, 11 Aug 2026 19:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786477890;
	bh=Sv2t5yKPgDkMXnGvbGyXa1PdaKt6DNWZkGaMRHxSOJw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DM3UPr0CO2OgxicuPfdZWHOax9hCAP3BCTeKNgjiwZOaJue9gKKtTC/AcVVpyj4g6
	 SHy+uyN3D7WAMq94L3xTh7KNGxm8efsAX6+0aDKW0kpCABwESkh8gGF1793u0fySWN
	 +nId0jB9Isfge00a2CuFgO0aaFAET2PCbCDQecb4MKWzvlKLRzglceoh26m5jY/Kh/
	 wdJ4KnjugEStdM55BcemurlTsjfzQGza9QtV4BW0UW2oMU1VmYvsrYORPFMDWfVLJr
	 xlJ1oXhAvePgyGobX2CP8hTyhJxkh0BEydURaXNlpeikExXB0YX6D0URyFSjVE4KqW
	 g07UPFnZUVJxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/9] rtc: abx80x: add irq to struct abx80x_priv
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260811194034.28937-6-apokusinski01@gmail.com>
References: <20260811194034.28937-1-apokusinski01@gmail.com>
 <20260811194034.28937-6-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 19:51:28 +0000
Message-Id: <20260811195130.013C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Failure to clear client->irq on IRQ request error leaves a dangl=
ing positive IRQ value that is erroneously disabled during system shutdown.
--

--- Patch [5]: [PATCH v5 5/9] rtc: abx80x: add irq to struct abx80x_priv ---
commit e5e02251b0d732530fe4bd8df1edc078a44d0fe3
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: add irq to struct abx80x_priv
   =20
This commit adds the irq number to struct abx80x_priv so it is not tied
to the i2c_client. This allows the irq to be easily accessed in the case
of ABX81X SPI clocks.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 485d1ea08030d..12a4dbfec6396 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c

[ ... ]

> @@ -994,19 +997,19 @@ static int abx80x_probe(struct i2c_client *client)
>  		return -EIO;
>  	}
> =20
> -	if (client->irq > 0) {
> -		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
> -		err =3D devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +	if (priv->irq > 0) {
> +		dev_info(&client->dev, "IRQ %d supplied\n", priv->irq);
> +		err =3D devm_request_threaded_irq(&client->dev, priv->irq, NULL,
>  						abx80x_handle_irq,
>  						IRQF_SHARED | IRQF_ONESHOT,
>  						"abx8xx",
>  						client);
>  		if (err) {
>  			dev_err(&client->dev, "unable to request IRQ, alarms disabled\n");
> -			client->irq =3D 0;
> +			priv->irq =3D 0;
[Severity: Medium]
By removing the client->irq =3D 0 assignment here, doesn't this leave a
dangling positive IRQ value in the I2C client if the request fails?

If devm_request_threaded_irq() fails, the driver gracefully falls back to
running with alarms disabled. However, during system shutdown, the I2C core
in i2c_device_shutdown() relies on client->irq to disable interrupts:

drivers/i2c/i2c-core-base.c:i2c_device_shutdown() {
    ...
    if (client->irq > 0)
        disable_irq(client->irq);
    ...
}

Since this driver uses IRQF_SHARED and has no .shutdown callback to
override the default behavior, leaving client->irq > 0 means the I2C core
will unconditionally call disable_irq() on an IRQ line the driver failed
to acquire.

Could this erroneously mask the shared IRQ line for other active devices
during system shutdown?

>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811194034.2893=
7-1-apokusinski01@gmail.com?part=3D5
