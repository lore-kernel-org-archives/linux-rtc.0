Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E117443711D
	for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225948; cv=none; b=BY2c7hS4U75X6Z7xackwk8A5g66m1htXja/7NgY5wSQdX/kPXq0mZZ+yxFN9fHSYwELeBaIWLqNYXLFD2HKT/aOWubTinG+cV2WeTPdmIZpbSseNUws2bdI01NmQrS1CRbabvjQ/2Ev3p5gZiAONsWoMGY77vOpO8CUSRHck9Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225948; c=relaxed/simple;
	bh=EiOiqIcqiUe976EE7fvSDs0Zo+bkPq8VqiPQ5c6UvlY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PZqLB7dZzqDPJJJ6cG+7qyz8K0jhOomY1X0xdM5ToqRuWDG+UrwZVOUEWMATGNPGL3vKv5uPAL+Z2PMEWwlil/9GBE5RIatFHCKuVRlNRLVIpWua+B7ZSO2szXEbuPKpAI6UHokkH3UrEX5KvtWrMArDfHOvUWTHjGMhgBBDsvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuD9/8Jv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuD9/8Jv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD991F00A3A;
	Thu, 20 Aug 2026 11:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787225946;
	bh=6t7qksiiTdDquXtVd0EnOpZJGDAlNmRAhBXS3Qc/eCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JuD9/8JvoGZ9DFXC1z/+ijgVWESXm/zh9ly/kdKGkCn+ojZj0E8mqOtDldgYADlkf
	 QT0u1bYd/LcRiY/z3iaeuK3WLj8zCl23in6+DvIp76AfXP2HLgHbkA3YcV0I60jQs+
	 lom8aaTd2VEZoZf4oy2NFbOPfRcoNWGcFppRfuQ27Y2Cz3fQB7GCxiAKAlB7uPbFP0
	 MSFALqeobQvJV/IpPAWNk5XKX8qHjTMsnh+5YaEp6V8oA/ML4DKo/XYix4M3tNUtAu
	 pQJx8Ta6FT4ONdFDgBgVOl3QwpkisWlEXdRXuFU/oIoPJN7jWl6ul41Org+YAZsFpU
	 oIHyzZ7YsULlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rtc: pcf85063: add 1 Hz update interrupt (UIE)
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260820112437.3715237-1-alexander.sverdlin@siemens.com>
References: <20260820112437.3715237-1-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 11:39:06 +0000
Message-Id: <20260820113906.9BD991F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Read-modify-write operations on CTRL2 inadvertently clear Write-0-=
to-Clear (W0C) TF and AF interrupt flags, causing dropped interrupts.
- [High] A non-atomic read-modify-write sequence in the IRQ handler causes =
a data race that overwrites concurrent register updates.

Pre-existing issues:
- [High] Requesting the threaded IRQ before registering the RTC device crea=
tes a devres ordering inversion leading to a Use-After-Free.
- [High] Missing of_clk_del_provider() cleanup causes a Use-After-Free of t=
he OF clock provider on driver unbind.
--

--- Patch [1]: [PATCH v2] rtc: pcf85063: add 1 Hz update interrupt (UIE) su=
pport ---
commit 79dacfbe2c0fd3c5e8261fd4569fedb1fe4b32a5
Author: Alexander Sverdlin <alexander.sverdlin@siemens.com>

rtc: pcf85063: add 1 Hz update interrupt (UIE) support
   =20
The PCF85063A/RV8263 have no dedicated 1 Hz update interrupt, but their
countdown timer can be sourced from a 1 Hz clock to generate a periodic
interrupt. This patch offloads UIE to the hardware by enabling this timer
when uie_rtctimer is active, reporting RTC_UF when the timer flag is set.

> diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
> --- a/drivers/rtc/rtc-pcf85063.c
> +++ b/drivers/rtc/rtc-pcf85063.c

[ ... ]

> @@ -212,22 +274,31 @@ static int pcf85063_rtc_set_alarm(struct device *de=
v, struct rtc_wkalrm *alrm)
> =20
>  	return regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
>  				  PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF,
> -				  alrm->enabled ? PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF : PCF85063_=
CTRL2_AF);
> +				  pcf85063->rtc->aie_timer.enabled ?
> +				  PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF : PCF85063_CTRL2_AF);
>  }

[Severity: High]
Does this code inadvertently drop the TF interrupt flag when updating the
alarm?

If PCF85063_CTRL2_TF is a write-0-to-clear bit, excluding it from the
regmap_update_bits() mask means it will be written back as 0 if it was
already set in the register, clearing any pending timer interrupt.

[ ... ]

> @@ -274,22 +287,31 @@ static int pcf85063_rtc_alarm_irq_enable(struct dev=
ice *dev,
>  					 unsigned int enabled)
>  {
>  	struct pcf85063 *pcf85063 =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D pcf85063_set_timer_1hz(pcf85063, pcf85063->rtc->uie_rtctimer.en=
abled);
> +	if (ret)
> +		return ret;
> =20
>  	return regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
>  				  PCF85063_CTRL2_AIE,
> -				  enabled ? PCF85063_CTRL2_AIE : 0);
> +				  pcf85063->rtc->aie_timer.enabled ?
> +				  PCF85063_CTRL2_AIE : 0);
>  }

[Severity: High]
Could this function also clear pending interrupts?

Similar to pcf85063_rtc_set_alarm(), both AF and TF are excluded from the
mask here. If they are write-0-to-clear flags, regmap_update_bits() will
write them back as read (0), neutralizing any concurrent assertions.

[ ... ]

> @@ -236,14 +307,26 @@ static irqreturn_t pcf85063_rtc_handle_irq(int irq,=
 void *dev_id)
>  {
>  	struct pcf85063 *pcf85063 =3D dev_id;
> +	unsigned long events =3D RTC_IRQF;
> +	irqreturn_t ret =3D IRQ_NONE;
>  	unsigned int val;
>  	int err;
> =20
>  	err =3D regmap_read(pcf85063->regmap, PCF85063_REG_CTRL2, &val);
>  	if (err)
>  		return IRQ_NONE;
> =20
>  	if (val & PCF85063_CTRL2_AF) {
> -		rtc_update_irq(pcf85063->rtc, 1, RTC_IRQF | RTC_AF);
> -		regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
> -				   PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF,
> -				   0);
> -		return IRQ_HANDLED;
> +		events |=3D RTC_AF;
> +		val &=3D ~(PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF);
> +		ret =3D IRQ_HANDLED;
> +	} else {
> +		/* Preserve AF if it comes after the above regmap_read() */
> +		val |=3D PCF85063_CTRL2_AF;
> +	}
> +
> +	if (val & PCF85063_CTRL2_TF) {
> +		events |=3D RTC_UF;
> +		val &=3D ~PCF85063_CTRL2_TF;
> +		ret =3D IRQ_HANDLED;
> +	}

[Severity: High]
Does this code risk clearing an unhandled UIE interrupt if TF asserts
after the register read?

If TF asserts post-read, the read value will have it as 0. Because there is
no else branch to preserve TF (like the one preserving AF), the subsequent
regmap_write() will commit a 0 for TF, clearing the flag before it is
handled.

> +	if (ret =3D=3D IRQ_HANDLED) {
> +		regmap_write(pcf85063->regmap, PCF85063_REG_CTRL2, val);
> +		rtc_update_irq(pcf85063->rtc, 1, events);
>  	}
> =20
> -	return IRQ_NONE;
> +	return ret;
>  }

[Severity: High]
Is there a data race in this read-modify-write sequence?

pcf85063_rtc_handle_irq() drops the regmap lock between regmap_read() and
regmap_write(). If a process-context change happens in this unlocked window,
such as AIE toggling via pcf85063_rtc_alarm_irq_enable(), will it be
overwritten and lost when the IRQ handler commits its stale read data?

[ ... ]

> @@ -607,6 +690,7 @@ static int pcf85063_probe(struct device *dev, struct =
regmap *regmap, int irq,
>  		err =3D devm_request_threaded_irq(dev, irq,
>  						NULL, pcf85063_rtc_handle_irq,
>  						irqflags | IRQF_ONESHOT,
>  						"pcf85063", pcf85063);
>  		if (err) {
>  			dev_warn(&pcf85063->rtc->dev,
>  				 "unable to request IRQ, alarms disabled\n");
>  		} else {
> +			set_bit(RTC_FEATURE_UPDATE_INTERRUPT, pcf85063->rtc->features);
>  			set_bit(RTC_FEATURE_ALARM, pcf85063->rtc->features);

[Severity: High]
This is a pre-existing issue, but does the devres allocation order here cau=
se
a use-after-free on teardown?

Earlier in pcf85063_probe(), devm_request_threaded_irq() is called before
devm_rtc_register_device(). During teardown, rtc_device_unregister() runs
first, but the IRQ remains active.

If the timer fires at this time, pcf85063_rtc_handle_irq() executes and
rtc_update_irq() re-schedules the irqwork. Devres will subsequently free the
rtc structure, leaving the system workqueue to dereference freed memory.

[ ... ]

>  	nvmem_cfg.priv =3D pcf85063->regmap;
>  	devm_rtc_nvmem_register(pcf85063->rtc, &nvmem_cfg);
> =20
>  #ifdef CONFIG_COMMON_CLK
>  	/* register clk in common clk framework */
>  	pcf85063_clkout_register_clk(pcf85063);
>  #endif
> =20
>  	return devm_rtc_register_device(pcf85063->rtc);
>  }

[Severity: High]
This is a pre-existing issue, but is there a missing cleanup for the OF clo=
ck
provider?

In pcf85063_clkout_register_clk(), of_clk_add_provider() is invoked but the=
re
appears to be no matching of_clk_del_provider(). When devres frees the clock
structure during driver unbind, does the global OF list retain a dangling
pointer, triggering a use-after-free on the next device tree clock
resolution?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820112437.3715=
237-1-alexander.sverdlin@siemens.com?part=3D1
