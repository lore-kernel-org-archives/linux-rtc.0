Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA3C2110E;
	Sat, 25 Jul 2026 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784992379; cv=none; b=rqRlr7jxBMzkrz8dpABKsDd6pNhBTjJs7ndI8Bl9+v6MIn5ujQO1J47e/aWAUcNbzap57uZfdpNF4nuYHQSUt7m5PmoFhqA2n889ZT4LKZXEzIVncrFDr3jFAsrE1Enl2yFgHY+lBCeM3/8ZQ72ty/xKExgu9khhYTTxQbeU+nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784992379; c=relaxed/simple;
	bh=KROef9QDWbhYEfjjM/IHcgySYHHs8bn/KgyeQbIM5CM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EjeVyypzKbRMwvOVoBRaOgCz3KLeBCH1TsbLn26puWZSDl18sfGRVXfILrIh3E2LXFCqP5tyhXlEyi8YzjJXTl3q/HDWO3KDPNhKeUapbrMVVsqQHRq8Pd5rjxamk4nfOm/T978ewg3apfho40j5cD2HKyz4rWZwKBI/H+/+vx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlI29VEo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlI29VEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3931E1F000E9;
	Sat, 25 Jul 2026 15:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784992378;
	bh=bvbC17CGRklQAWBYuJCSkR6wohe5u37E7bKlvE3oejM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TlI29VEowFPNmtGCRqa18Qw8qmhXC6+mc/oqHdmFtimUPTF5TQpRGFw+92i6nO1Fu
	 aamreD3iagy2tsip2VUSwaHUKQpCl5sDRqPQuEc8e3msPTPUWC7gNKPEzvlKVxBpCg
	 j/aUCo0zqADzZOgjzUMMeiMfYfvWWMlf4NtP62ELrVIkTFR+4iCAnHsFA9yJ3KNPkJ
	 8vJKcfNfh4Fu5EJthdCjazKBALWyki1rDJPegConKDasKOQGrybif3K/sAaN/c+toY
	 5riYDbl5hwcISDINbmyr+2q8wyRfo+fATTHFakLwdQuaKda6WA9Th1PZc/+T56giZV
	 nl05afI9fFbuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] rtc: abx80x: add irq to struct abx80x_priv
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: robh@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260725145718.14733-5-apokusinski01@gmail.com>
References: <20260725145718.14733-1-apokusinski01@gmail.com>
 <20260725145718.14733-5-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 15:12:57 +0000
Message-Id: <20260725151258.3931E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The interrupt handler indiscriminately clears unrelated and newly =
arrived interrupts due to a read-modify-write race condition.
--

--- Patch [4]: [PATCH v2 4/8] rtc: abx80x: add irq to struct abx80x_priv ---
commit c9bf7d6c99deb7b828f721f449db552d3b1510a0
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: add irq to struct abx80x_priv

This patch adds an irq field to the abx80x_priv struct to decouple the
interrupt number from the i2c_client. This enables the irq to be easily
accessed for both i2c and spi variants. It also updates the interrupt
handler to selectively clear status bits.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 5486d9d0b1e5d..b83c789e213d6 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
[ ... ]
> @@ -261,35 +262,43 @@ static irqreturn_t abx80x_handle_irq(int irq, void =
*dev_id)
>  	struct i2c_client *client =3D dev_id;
>  	struct abx80x_priv *priv =3D i2c_get_clientdata(client);
>  	struct rtc_device *rtc =3D priv->rtc;
> +	irqreturn_t handled =3D IRQ_NONE;
>  	int status;
> =20
>  	status =3D i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
>  	if (status < 0)
> -		return IRQ_NONE;
> +		return handled;
> =20
> -	if (status & ABX8XX_STATUS_AF)
> +	if (status & ABX8XX_STATUS_AF) {
>  		rtc_update_irq(rtc, 1, RTC_AF | RTC_IRQF);
> +		handled =3D IRQ_HANDLED;
> +	}
> =20
>  	/*
>  	 * It is unclear if we'll get an interrupt before the external
>  	 * reset kicks in.
>  	 */
> -	if (status & ABX8XX_STATUS_WDT)
> +	if (status & ABX8XX_STATUS_WDT) {
>  		dev_alert(&client->dev, "watchdog timeout interrupt.\n");
> +		handled =3D IRQ_HANDLED;
> +	}
> =20
> -	i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS, 0);
> +	if (handled =3D=3D IRQ_HANDLED)
> +		i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS,
> +					  status & ~(ABX8XX_STATUS_AF | ABX8XX_STATUS_WDT));

[Severity: High]
Does this status write introduce a race condition that could cause us to lo=
se
newly arrived interrupts?

If a new interrupt (such as a watchdog or alarm event) triggers immediately
after the status register is read, its corresponding hardware bit becomes 1,
but it remains 0 in the local status variable.

When writing back status & ~(ABX8XX_STATUS_AF | ABX8XX_STATUS_WDT), this
writes 0 to the newly triggered interrupt's bit. Since this chip appears to
use write-0-to-clear semantics, writing 0 clears the new interrupt before it
can be handled, effectively losing the hardware event.

Would it be better to write ~(ABX8XX_STATUS_AF | ABX8XX_STATUS_WDT) directly
to ensure any unhandled bits remain untouched?

> -	return IRQ_HANDLED;
> +	return handled;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725145718.1473=
3-1-apokusinski01@gmail.com?part=3D4
