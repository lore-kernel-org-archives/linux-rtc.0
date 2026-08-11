Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26786175A72;
	Tue, 11 Aug 2026 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477986; cv=none; b=mGkb/1scpkpx+1c2xCwDMkUc/e8KLj2Zc5uBpFv5MkFFSdrEjJdEFbFnWAhSioox1WwsrNv8V4AB0pD/AWq236Azafx2yW/edfnsYogB2U829QLBlkfU/01aYkScJT+fp571+OfuMSHrXsOwTIlG4WztsWqMnWjESjdDEJzLKMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477986; c=relaxed/simple;
	bh=trQqgjrCol3C+98g478hh/Ln0MUHsfxI29DFzvIHxwk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kbAvnzDYqkINOreyqPeSewmte0X24l17vT5ljvy6uODP78QJlKoE/e3Idq3RK38kXFdO1GVYVg8hEYM3ELxztDYhVv+0m55SYPVOy1eC1CGjUt4aNTVoLWD7Ljzalvna5QMs739bzzF41DB373IVCJR03mKzrDelGbGU+rAbj8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5lg3gRI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5lg3gRI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7301F000E9;
	Tue, 11 Aug 2026 19:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786477984;
	bh=7srWlmk1NgQ+3s0UePrUXPjFJZpsWG1pgVkJIgIngw0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O5lg3gRIl9TYGqjw8KrzNg2VdnWjK7pjPHu7VVGamwSKOXCiqDomXnza0AIcdT21p
	 rwpFyvY6XGQzpjAbU99QDp5bSNlN29qG1crY+sXpUA1/t8gCDYFJmLTwgYJrcl7xrv
	 4J9NciERuNuUdAhRhhcukbo89897xV/FYrYskYJD0iO9UX706DDvBqeH77So1g/awI
	 YTf06rDW3bAsE6Sn1qI+4KscSM9XrmiEDuCJGISRxALzc4kTVMtLb85O1Q2qL9yuEn
	 GMNcUZfBBT3/Kn0oC4Xcy2UFFCvuxYU81SzBy06dMZv9EyQZB1+Cr/Nu6XhEy2UjFn
	 x1R6Xon/8kkdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/9] rtc: abx80x: properly handle shared IRQs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260811194034.28937-5-apokusinski01@gmail.com>
References: <20260811194034.28937-1-apokusinski01@gmail.com>
 <20260811194034.28937-5-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 19:53:03 +0000
Message-Id: <20260811195303.CD7301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The write to the Oscillator Control Register (ABX8XX_REG_OSC) in `=
abx80x_probe` is silently ignored by the hardware because the required conf=
iguration key (`ABX8XX_CFG_KEY_OSC`) is not written to the Configuration Ke=
y Register beforehand. If the RTC has previously enabled interrupts like Au=
to Calibration or Oscillator Fail (e.g., from the bootloader or prior syste=
m state), they will remain enabled. When these interrupts trigger, the newl=
y modified `abx80x_handle_irq` returns `IRQ_NONE` without clearing the inte=
rrupt status bits, leading to an interrupt storm that will eventually cause=
 the kernel to disable the shared IRQ line.
--

--- Patch [4]: [PATCH v5 4/9] rtc: abx80x: properly handle shared IRQs ---
commit 7460b93d807b8ac0b8ec90945bfa5691c0f9cd26
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: properly handle shared IRQs

This patch modifies the abx80x interrupt handler to support shared IRQs by
only returning IRQ_HANDLED when alarm or watchdog events occur. It also
updates the probe function to disable unused interrupts.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 0c8d3416fd5a9..485d1ea08030d 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c

[ ... ]

> @@ -950,6 +963,37 @@ static int abx80x_probe(struct i2c_client *client)
>  	if (err)
>  		return err;
> =20
> +	/* Disable unused interrupts */

[ ... ]

> +	data =3D i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
> +	if (data < 0) {
> +		dev_err(&client->dev, "Unable to read Oscillator Control register\n");
> +		return -EIO;
> +	}
> +
> +	err =3D i2c_smbus_write_byte_data(client, ABX8XX_REG_OSC,
> +					data & ~(ABX8XX_OSC_ACIE |
> +						 ABX8XX_OSC_OFIE));

[Severity: High]
Will this write to ABX8XX_REG_OSC be silently ignored by the hardware?

It appears that writing to the Oscillator Control Register requires an unlo=
ck
key to be written to the Configuration Key Register first.

If this write fails and the RTC was previously left with ACIE or OFIE
interrupts enabled (e.g., from the bootloader), could it lead to an interru=
pt
storm?

When those interrupts fire, the updated abx80x_handle_irq() will now skip
them and return IRQ_NONE without clearing the status bits:

	if (status & ABX8XX_STATUS_AF) {
		rtc_update_irq(rtc, 1, RTC_AF | RTC_IRQF);
		handled =3D IRQ_HANDLED;
	}
        ...
	if (handled =3D=3D IRQ_HANDLED)
		i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS,
					  status & ~(ABX8XX_STATUS_AF | ABX8XX_STATUS_WDT));

	return handled;

Since the status bits are not cleared for unhandled events, the IRQ control=
ler
would continually retrigger and eventually disable the shared IRQ line.

> +	if (err < 0) {
> +		dev_err(&client->dev, "Unable to write Oscillator Control register\n");
> +		return -EIO;
> +	}
> +
>  	if (client->irq > 0) {
>  		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
>  		err =3D devm_request_threaded_irq(&client->dev, client->irq, NULL,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811194034.2893=
7-1-apokusinski01@gmail.com?part=3D4
