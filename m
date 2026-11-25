Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591921;
	b=goqjjwOwRqaU8m6qgx1TZPjgUWv6zKTWt/AI1YkbNG0ejVLCgoYeKl1x6+1bRUKs5b/n
	 xo1dir/5SZ5+epVmO7MZ5hL9vGVSjirMELp6+7BOB+zA2uFHOdlo5vEbbAcPXVukTs1e4
	 VlbWzM7Hxb+Qvl3JMkqlDighV5x/9wawyci0GoP6KOFLshsAFRPmxGmpwz8ng8ui4teLV
	 mon3udsLzTO7DTUwV0gx+K8tSen2jmbxUyVQUdCw0ih46fRqhU8o0CtiAGK4JvWrqEeI5
	 hpY8oD71LiBadZ4pMgo/6Hua3cHPJ6b5jzrM17UDUw5IrAv4/UaqG0mKt5k6jWL1/Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591921;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NU/4o9q3V0aHbwo9ssrlKEkz1UQA1sOdA9uTJGuKs/k=;
	b=zvPthfimEYHEGlewOAfAs6PyyNEgzB4qPDFo+cr1R778sonZpGd6Q/TG3nvm9/ZgDCwD
	 Ej2EJcH/kterQcPu1n7HcKroDZjCChdBqw/A2IV0oDDy0GIjHJveEQETixz+uOdBsX5RQ
	 o4jyCA+k+wbpj5kAR/KKTdtIjarPxPNrGTq7POFwTW/Zp06Vagtr/IFM5WaA3VvIJ4WS7
	 N0y0T8gyNlo26oZhMV5w3PgKsH0Pn1Zvj8OYsBfN9uugvY7klWHV1k/XBivhaemRLZXTr
	 hbLJLyvdwcpWIxTWgrNtphLCmY73MxQUiRVglaI5JuCglNOprtxF9I/h6x3FgK+kbBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gBOCreGE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6652606A321;
	Wed, 25 Nov 2026 07:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gBOCreGE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AECB1F000CA;
	Wed, 25 Nov 2026 07:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795591921;
	bh=NU/4o9q3V0aHbwo9ssrlKEkz1UQA1sOdA9uTJGuKs/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gBOCreGEEPcKbfgjcXrSfYH/HXxGTeuVBjR2RZBBxSbdeFD2mVxRwiPIitNHo0gif
	 hblQUmotW/3wDFS3VJxkxQUPmLD/MJCd8aD3n2Wk57Xl6D+G/TRjhsZ6J2SIwnL1Ft
	 CDX7UkEQjTn8lnLUEMn2M77cMhPhLmMeRud5RZRxEd5lpdj5S08lPJ07h5Y6rym4qf
	 uQkZDLMoFYnAP7Zc+g2ErAHYIr5Cz84wHXKK+zU2FAzEPJoE/jqLJRMEeL1PEoObHE
	 hpBd5UhgRbCGNJNGVYYdatCS5Eyh+lMENHBFlnjprLv8Rz0UROJNaqvDG1uUaNgBas
	 QOWN74W+eM1Rg==
Message-ID: <sashiko-outbox-232807@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/12] rtc: rv8803: clear the wake IRQ on unbind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Prasanth R" <ragaprasanth@gmail.com>, linux-rtc@vger.kernel.org
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261125072026.2997493-13-prasanth.r@lineo.co.jp>
References: <20261125072026.2997493-1-prasanth.r@lineo.co.jp>
 <20261125072026.2997493-13-prasanth.r@lineo.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 07:32:00 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] rtc: rv8803: redundant devm wakeup cleanup in rv8803_probe()
--

commit 3a55bfc9ac0b1aa7bcd9e1d8fb75ae431e24df8c
Author: Prasanth R <ragaprasanth@gmail.com>

rtc: rv8803: clear the wake IRQ on unbind

This commit replaces device_init_wakeup() and dev_pm_set_wake_irq() in
rv8803_probe() with devm_device_init_wakeup() and devm_pm_set_wake_irq()
to release the wake IRQ and wakeup source on unbind.

> diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
> index 7445c81510560..9dbbaffcd489b 100644
> --- a/drivers/rtc/rtc-rv8803.c
> +++ b/drivers/rtc/rtc-rv8803.c
> @@ -700,14 +700,14 @@ static int rv8803_probe(struct i2c_client *client)
>  			dev_warn(&client->dev, "unable to request IRQ, alarms disabled\n");
>  			client->irq =3D 0;
>  		} else {
> -			device_init_wakeup(&client->dev, true);
> -			err =3D dev_pm_set_wake_irq(&client->dev, client->irq);
> +			devm_device_init_wakeup(&client->dev);
> +			err =3D devm_pm_set_wake_irq(&client->dev, client->irq);
>  			if (err)
>  				dev_err(&client->dev, "failed to set wake IRQ\n");
>  		}
>  	} else {
>  		if (device_property_read_bool(&client->dev, "wakeup-source"))
> -			device_init_wakeup(&client->dev, true);
> +			devm_device_init_wakeup(&client->dev);
>  		else
>  			clear_bit(RTC_FEATURE_ALARM, rv8803->rtc->features);
>  	}

[Severity: Medium]
Can unbinding rv8803 actually leave the wake IRQ or wakeup source behind?

i2c_bus_type uses i2c_device_remove() as its bus remove callback, which
runs unconditionally on unbind even when the i2c_driver has no .remove
callback (and i2c_device_probe() runs the same cleanup on probe failure):

drivers/i2c/i2c-core-base.c:i2c_device_remove() {
	...
	devres_release_group(&client->dev, client->devres_group_id);

	dev_pm_clear_wake_irq(&client->dev);
	device_init_wakeup(&client->dev, false);
	...
}

Switching to devm_device_init_wakeup() and devm_pm_set_wake_irq() only
registers redundant devres actions on top of what the I2C core already
tears down.

Note that if "wake irq already initialized" (-EEXIST) is seen during
probe, that happens on initial bind when I2C_CLIENT_WAKE is set (for
example, when "wakeup-source" is specified alongside an interrupt in DT),
because i2c_device_probe() already calls device_init_wakeup() and
dev_pm_set_wake_irq() before invoking the driver's probe callback.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125072026.2997=
493-1-prasanth.r@lineo.co.jp?part=3D12
