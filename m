Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B4D235C01;
	Fri, 31 Jul 2026 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524499; cv=none; b=TWqnCD3ph6HeM+mJEi9/rv84aDbcyMxORFCUjmjQog/0z4wC8QxSOMKsEPr3CdlN4ou8UAw1DdaTpt/3HsRrKGxQAYvrB6WvAWuxJPYO3mH9aSOWA0ldvuWUtkQBOT0VxmiQc6rBHGGxkKg18ciWMtOPaEqnpUsewEfV0P+l+1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524499; c=relaxed/simple;
	bh=9GLLHzsTfJigUS0zqfCNf+86JZyFFYopOd2tGdliGtg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eA6QY2+1oM7llsrr6J34auj2x2flPVJLchcXLmswtfUQDLw2MDkuHqYdeAXSfckfDhvjp0WBYlhrQMYOCKP8E71qLF4NnRqfefOWwpgTRfiGpgaR5oAfeCNkJlxF998IrbtBLgssqepOT12tdDnqrceWRj724pUA8X79TyTCT1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfktNlKO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfktNlKO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A701F00AC4;
	Fri, 31 Jul 2026 19:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785524498;
	bh=pZ1Skw9pKfCEbi7HOBKopma+0u9toGNjtMTUYYh/IkI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dfktNlKOzlI5oMoLVmwJtdErXSybwrCzTbu+tBKkMu1roL4us85Wq0oqphTAQX7+T
	 zXiC31RL85lBrJ7VIaC3O94wrLe4I5UVRofvAObJN7isQHtoMwVJ0RHSdfXZuUYRdq
	 GlaYAU3vnXES7SnvQzGUTZXVODP1oRJZhxg4YAwddx0AIfqN6YrzUrb1injG0p8vrg
	 YDtY6IQ1wYuqkBXf/6PKrynFlTp5Z5wtAMIEL/2ODKnOBa7WX1FWI2mhplR9X+PLid
	 uJPZvTpFEBGj8qwTYDux2yq8C7+eavlTk8COHn0PmkvTfCtoTORDH1whjGTbOcuQ79
	 9F6PDj8g5YahQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/8] rtc: abx80x: replace read-modify-write pattern
 with regmap helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org
In-Reply-To: <20260731184831.44037-7-apokusinski01@gmail.com>
References: <20260731184831.44037-1-apokusinski01@gmail.com>
 <20260731184831.44037-7-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 19:01:37 +0000
Message-Id: <20260731190137.E8A701F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Using `guard(mutex)` inside a `switch` statement case without an e=
nclosing block causes a compilation failure (or uninitialized cleanup execu=
tion).
- [High] Configuration Key unlock sequence is broken by unprotected concurr=
ent reads and newly introduced read-modify-write regmap helpers.
--

--- Patch [6]: [PATCH v3 6/8] rtc: abx80x: replace read-modify-write patter=
n with regmap helpers ---
commit 68e1add63890d6b130ad7ce142d172f06e590b90
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: replace read-modify-write pattern with regmap helpers

This commit replaces manual read-modify-write register operations in the=20
rtc-abx80x driver with regmap_update_bits() and regmap_write_bits()=20
functions to simplify the code.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 23823fc2f5458..52f958e2aecd2 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
[ ... ]
> @@ -371,7 +364,7 @@ static int abx80x_rtc_set_autocalibration(struct devi=
ce *dev,
>  					  int autocalibration)
>  {
[ ... ]
>  	/* Unlock write access to Oscillator Control Register */
>  	if (abx80x_write_config_key(dev, ABX8XX_CFG_KEY_OSC) < 0)
>  		return -EIO;
> =20
> -	retval =3D regmap_write(priv->regmap, ABX8XX_REG_OSC, flags);
> -
> -	return retval;
> +	return regmap_write_bits(priv->regmap, ABX8XX_REG_OSC,
> +				 ABX8XX_OSC_ACAL_1024 | ABX8XX_OSC_ACAL_512,
> +				 flags);
>  }

[Severity: High]
Does switching to regmap_write_bits() break the configuration key unlock
sequence here?

The hardware requires writing the configuration key immediately before=20
writing a protected register. If any other register is accessed in between,=
=20
the unlock state is cleared.=20

Because regmap_write_bits() performs a read operation internally before=20
writing, does that read happen after the configuration key is written,
causing the hardware to relock itself before the write can execute?

Additionally, can an unlocked concurrent read sequence interleave here and
clear the unlock state? Looking at abx80x_rtc_read_time(), it performs I2C=
=20
reads without taking priv->lock:

abx80x_rtc_read_time() {
    ...
    err =3D regmap_bulk_read(priv->regmap, ABX8XX_REG_HTH, buf, sizeof(buf)=
);
    ...
}

[ ... ]
> @@ -566,17 +545,8 @@ static int abx80x_ioctl(struct device *dev, unsigned=
 int cmd, unsigned long arg)
>  	case RTC_VL_CLR:
>  		guard(mutex)(&priv->lock);
> =20
> -		err =3D regmap_read(priv->regmap, ABX8XX_REG_STATUS, &status);
> -		if (err < 0)
> -			return err;
> -
> -		status &=3D ~ABX8XX_STATUS_BLF;
> -
> -		err =3D regmap_write(priv->regmap, ABX8XX_REG_STATUS, status);
> -		if (err < 0)
> -			return err;
> -
> -		return 0;
> +		return regmap_update_bits(priv->regmap, ABX8XX_REG_STATUS,
> +					  ABX8XX_STATUS_BLF, 0);
> =20
>  	default:
>  		return -ENOIOCTLCMD;
>  	}

[Severity: High]
Will this cause a compiler error or undefined behavior?

The guard(mutex) is declared inside the case block, but without an=20
enclosing scope. If cmd is an unhandled ioctl, the switch statement jumps=20
to the default label, bypassing the initialization of the guard(mutex)=20
variable.=20

Does this require adding braces around the RTC_VL_CLR case to restrict the=
=20
lifetime of the guard?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731184831.4403=
7-1-apokusinski01@gmail.com?part=3D6
