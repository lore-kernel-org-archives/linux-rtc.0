Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEAE47A860
	for <linux-rtc@vger.kernel.org>; Fri,  7 Aug 2026 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108514; cv=none; b=YL/gNWZ05+jQd2arMvb72bzPzmwInsmcsGxzDeDM7kCT6VT80osyNXcDOFTULLwH4SuHhZsj6hOKqc3qwglZOvbZDbEyh3EBOth0AG5lguIrWUFir6rG6T7jJgMo3u2UEuHFIRhgs4fcPhoiFW3rF+D9c7Vw4Qdc0Rs081rmVuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108514; c=relaxed/simple;
	bh=GDr6CXzVYo0R9GDvqTJcjK8oD67Y/PVUMRqy08JanZ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g+V+iqYs7XwrDxyRWq9rYnTZseRqt59KjCoB6v0SRnYOZJO4L8tfezRo/gJJFYHvXQIffnH5i/gR2jLNWd9NMV88GYOZ45xZLENGovKZ8P78aEizQ1M6RFdAvAoscnmOsxgdUR4lFTbzv4ex3Ugd5ff5EDw2J+SxeWt3sSofJjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eb7/bXlw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eb7/bXlw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6A41F000E9;
	Fri,  7 Aug 2026 13:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786108504;
	bh=NnpX4no2d0HEYYFelbZn2XeYncMnLuTf0/dgVuXADJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eb7/bXlwKv8EqWWx7/I5ZHOQKqWw95Fp2EpXvvLUKi+lIO/fIp4UjrPqdOrjyza3z
	 6cRs1iBNTjD/CrZIMLvglKMaiqis02LmzwKyBJmUz41j3JKdrfhcNQpQF40qQ6qAWp
	 34mEaoY93yMCb6qOk8iMDhUtnsL4apqHn8bf9Hg+BcdaP3+GT5Cb+O/HRwXIsfDLqX
	 lU4Qg/4e6N9+4xbL1KwVZVSGBeMY6lCpm2nhvYy+7PEIog9pEsgiCV6sDUeCkRJCl+
	 a1bU5w0dvsdOjqX4G9hJLwVC4BpJG8vB2GZG9WlOQkVFrTx5cE0M742+3V+d3xJT1n
	 Tp4EqbSDslh1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: pcf85063: add 1 Hz update interrupt (UIE) support
Reply-To: sashiko-reviews@lists.linux.dev
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260807125757.2908175-1-alexander.sverdlin@siemens.com>
References: <20260807125757.2908175-1-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 13:15:03 +0000
Message-Id: <20260807131504.5C6A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Naive read-modify-write operations on the CTRL2 register can drop =
the write-0-to-clear AF and TF interrupt flags.
- [High] The UIE timer interrupt is configured in pulse mode (`TI_TP =3D 1`=
), causing an interrupt storm with level-triggered IRQs.

Pre-existing issues:
- [High] Time-of-check to time-of-use (TOCTOU) race in the threaded IRQ han=
dler clobbers concurrent alarm enable operations.
--

--- Patch [1]: [PATCH] rtc: pcf85063: add 1 Hz update interrupt (UIE) suppo=
rt ---
commit 283190d20c79bb78192c9f090cf19e5f426cb933
Author: Alexander Sverdlin <alexander.sverdlin@siemens.com>

rtc: pcf85063: add 1 Hz update interrupt (UIE) support

The PCF85063A/RV8263 have no dedicated 1 Hz update interrupt, but their
countdown timer can be sourced from a 1 Hz clock to generate a periodic
interrupt. Use it to offload UIE to the hardware.

> diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
> index 01e209d88f5f3..76675b75388e4 100644
> --- a/drivers/rtc/rtc-pcf85063.c
> +++ b/drivers/rtc/rtc-pcf85063.c
[ ... ]
> @@ -188,12 +197,64 @@ static int pcf85063_rtc_read_alarm(struct device *d=
ev, struct rtc_wkalrm *alrm)
>  	return 0;
>  }
> =20
> +/*
> + * The chip has no dedicated 1 Hz update interrupt. Drive the countdown =
timer
> + * at 1 Hz to emulate it, so the RTC core can offload UIE to the hardware
> + * instead of polling. A free-running timer is left untouched to preserv=
e its
> + * phase across the per-second re-arming done by the core.
> + */
> +static int pcf85063_set_timer_1hz(struct pcf85063 *pcf85063, bool enable)
> +{
> +	unsigned int mask =3D PCF85063_TIMER_MODE_TCF_MASK |
> +			    PCF85063_TIMER_MODE_TIE |
> +			    PCF85063_TIMER_MODE_TI_TP |
> +			    PCF85063_TIMER_MODE_TE;
> +	unsigned int mode =3D 0;
> +	unsigned int cur;
> +	int ret;
> +
> +	if (enable)
> +		mode =3D PCF85063_TIMER_MODE_TCF_1HZ | PCF85063_TIMER_MODE_TIE |
> +		       PCF85063_TIMER_MODE_TI_TP | PCF85063_TIMER_MODE_TE;

[Severity: High]
Does configuring the timer in pulse mode (PCF85063_TIMER_MODE_TI_TP =3D 1) =
cause
an interrupt storm on platforms using level-triggered interrupts?

If the hardware emits a fixed-width pulse on the INT pin instead of followi=
ng
the TF flag, when the threaded handler clears TF and returns, the INT pin m=
ight
remain physically low for the remainder of the pulse.

Upon unmasking, would the level-triggered IRQ controller immediately fire a=
gain,
leading to repeated IRQ_NONE returns and eventually disabling the IRQ?

> +
> +	ret =3D regmap_read(pcf85063->regmap, PCF85063_REG_TIMER_MODE, &cur);
> +	if (ret)
> +		return ret;
[ ... ]
> +	if (enable) {
> +		ret =3D regmap_write(pcf85063->regmap, PCF85063_REG_TIMER_VALUE, 1);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
> +					 PCF85063_CTRL2_TF, 0);

[Severity: High]
Can this read-modify-write operation drop write-0-to-clear interrupt flags?

If the AF flag was read as 0 internally by regmap_update_bits(), but asserts
in the hardware before the write, wouldn't the write of 0 to the unmasked b=
its
inadvertently clear the newly arrived alarm interrupt?

> +		if (ret)
> +			return ret;
> +	}
> +
> +	return regmap_update_bits(pcf85063->regmap, PCF85063_REG_TIMER_MODE,
> +				  mask, mode);
> +}
[ ... ]
> @@ -236,14 +307,23 @@ static irqreturn_t pcf85063_rtc_handle_irq(int irq,=
 void *dev_id)
>  		return IRQ_NONE;
> =20
>  	if (val & PCF85063_CTRL2_AF) {
> -		rtc_update_irq(pcf85063->rtc, 1, RTC_IRQF | RTC_AF);
> -		regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
> -				   PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF,
> -				   0);
> -		return IRQ_HANDLED;
> +		events |=3D RTC_AF;
> +		mask |=3D PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF;

[Severity: High]
This is a pre-existing issue, but does caching the decision to clear AIE he=
re
create a time-of-check to time-of-use race that clobbers concurrent alarm
enable operations?

If a concurrent thread sets a new alarm (e.g., writing AIE=3D1) after CTRL2=
 was
read at the start of this handler, wouldn't the delayed regmap_update_bits()
at the end of the handler overwrite AIE back to 0, discarding the user's
alarm request?

> +		ret =3D IRQ_HANDLED;
> +	}
> +
> +	if (val & PCF85063_CTRL2_TF) {
> +		events |=3D RTC_UF;
> +		mask |=3D PCF85063_CTRL2_TF;
> +		ret =3D IRQ_HANDLED;
> +	}
> +
> +	if (ret =3D=3D IRQ_HANDLED) {
> +		regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2, mask, 0);

[Severity: High]
Can this read-modify-write operation lose interrupts that assert during the
RMW window?

Since both AF and TF are write-0-to-clear flags, if an interrupt arrives af=
ter
the regmap_update_bits() read step but before the write step, the unmasked =
bits
will be written back as 0, permanently losing the interrupt.

> +		rtc_update_irq(pcf85063->rtc, 1, events);
>  	}
> =20
> -	return IRQ_NONE;
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807125757.2908=
175-1-alexander.sverdlin@siemens.com?part=3D1
