Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8753A8755;
	Fri, 14 Aug 2026 01:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786671241; cv=none; b=U4tOJKPc5f8JydKY58ikEmJLae0NU/rqJ+10267NXwRkhklidYgdUDCQbHOGtgoSR5RZ62RhBdTovVtNQrLysxNFdNY5a+npuKbklv+rdJRyuPjJ9++XJS2GnqHtAVd5sVHRp5TOhDoh483WsgVx98LOsxxrq7CxRO3N+hUq5ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786671241; c=relaxed/simple;
	bh=KBD//6Scv2TKBkhRByIuuYP7Iwx6Nrr4OhZova+QHSs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pEF+wAtppne7HiRkz7xeg+Vm2XXM//TmEgIHg8QZIlWgD1p9NGPY4Xg3OGz1WF17MKhCyfV5xTdz1RnhoZg82A0yqiy0N+aRX/olGX1Zw4d3TIHdypsBYwO5p2FclkUpa0eoe8JQHj0YbyslyDLLSEHTnadMimpTfGWdAU441LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZxdPgnH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZxdPgnH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5616F1F00A3A;
	Fri, 14 Aug 2026 01:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786671232;
	bh=sXFGTijSguJv5OaWL9/1lefDIgxcYbNscimeoAgVQzU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RZxdPgnHJkTqnNmWqfd5r64eiMfHgo7BFmaSJUexBkh/s+6M0NskQlekhKvgyrcxR
	 lIYsfaQ/fz8nam0P269iRk6C5erDrpS893QGCfrnhBBljCW+0Z6OTUBUnTNvcKbm4L
	 ipaJaikwhJw8kQ0Ym4SiExfIN5S6ULArXMvD24ewAgOqzIw/xFFmNN0TVkTxOH2F0a
	 YqIlePZ5gjeFQ8B9QtqyTBIb9YRSCXx4hYpBPQ6UJGfG0VMayQYVYSxPNh7wyBpSxN
	 QzokV5oVlDUPyBkTnDDe3BKG8zpXynbhV60xYCNomykxoAkPBjvGGae5bypEjisn6B
	 EJ2FrVuFx0QpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/9] rtc: abx80x: properly handle shared IRQs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260810193826.210683-5-apokusinski01@gmail.com>
References: <20260810193826.210683-1-apokusinski01@gmail.com>
 <20260810193826.210683-5-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:33:46 +0000
Message-Id: <20260814013347.5616F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe read-modify-write on the W0C status register clears unhandl=
ed and newly asserted interrupts.
- [High] The shared interrupt handler incorrectly claims interrupts without=
 verifying if the alarm interrupt is enabled, risking interrupt storms or l=
ost IRQs for other devices.
--

--- Patch [4]: [PATCH v4 4/9] rtc: abx80x: properly handle shared IRQs ---
commit 973a5c08e9e5b0f99ad16fb217339890d12578f8
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: properly handle shared IRQs

The abx80x RTC driver registers its interrupt handler with IRQF_SHARED,
but the handler always returned IRQ_HANDLED and cleared the status
register even when no interrupt source from the RTC was active.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 0c8d3416fd5a9..485d1ea08030d 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
[ ... ]
> @@ -266,27 +272,34 @@ static irqreturn_t abx80x_handle_irq(int irq, void =
*dev_id)
>  	struct i2c_client *client =3D dev_id;
>  	struct abx80x_priv *priv =3D i2c_get_clientdata(client);
>  	struct rtc_device *rtc =3D priv->rtc;
> +	irqreturn_t handled =3D IRQ_NONE;
>  	int status;
> =20
>  	guard(mutex)(&priv->lock);
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

[Severity: High]
This is a pre-existing issue, but since this patch aims to properly handle
shared IRQs, should this also check if the Alarm Interrupt Enable (AIE)
bit is set?

In many RTCs, the Alarm Flag (AF) is set upon a match regardless of whether
the interrupt is actually enabled. If AIE is disabled but AF is set, could
this incorrectly assume the RTC generated the interrupt, claim it from
other devices sharing the IRQ line, and emit a spurious RTC alarm event?

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
This isn't a bug introduced by this patch, as the original code wrote 0 to
clear all bits, but does this new read-modify-write operation still leave a
race condition for write-0-to-clear (W0C) registers?

If an unhandled interrupt asserts between reading ABX8XX_REG_STATUS and
writing it back, wouldn't writing back the read status (where the new
interrupt's bit was 0) write a 0 to that newly asserted bit, inadvertently
clearing it before it can be handled?

Additionally, does status & ~(ABX8XX_STATUS_AF | ABX8XX_STATUS_WDT)
unconditionally write 0 to the WDT bit, even if only the AF bit was
handled?

> =20
> -	return IRQ_HANDLED;
> +	return handled;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810193826.2106=
83-1-apokusinski01@gmail.com?part=3D4
