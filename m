Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793625228;
	b=NwI85Y6jKaKzaD6wjqlUdwPMLIVYyUETMO4kKO3S0r29txFsIy6tRRsna3nXMu1eBEnz
	 cCj32JSfHdcvBMKKpD+Gupw7Z/cjPQVvYGM+rNjp4XGrGYyKlVp3sgxh5twc5a0v5WGfx
	 QrWfmS150QUfFzZg7+qD28GLMIl623f5gg9Kx5LiQv2A0tpFJ/+W65vFzKA3VEkzdq3Wk
	 /N9VuSsplK0/WaRxX0z9zt9LnFrdR2vE2ynmNQsKFeRg1zF4/hZ481aStmbNApgkKd96H
	 0tkHrXv1SaAjikknAlEu6FEucfkuc4W2imDELWAfsau7yoKFeFvc/jLKpsH2KUiGfGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625228;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ko7FKvtu3ihiy3PYiCR3H1vh1DEBVQZl612hAFBpWFM=;
	b=FHLoCp4eNFPg10F6fFkEsiHcaDecyELW2uCXKemqDNxaLIDVSuB4f79R8VRHmd1zMfcX
	 ktZ9PsG5dHQSI3vtwRqqYa4PhPKgNkqb0c+0DDZpVl/1SOsw2oiEvHsdBZ2CHqOBgYEWO
	 CNqlZHY1yuyQaaTIvrRC7NdG35Poiwl7O6rrAGzmpfet41BkLMJYssr2Kf0msTyrZR3Ca
	 H02TzXkrYyd9zvUSxJ9YVih1fa+xNE4qCoNsxIorvCHRFxSbFMY0sYN+nApdyPT0UZGK7
	 Q9ZXL7n3D/tu9raCX7pqaG9DvAE34BT475qUCC4jG3hVfELGyl/D0veeHsSA/HiE5hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WkiS5hde;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A189B606A326;
	Mon,  2 Nov 2026 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WkiS5hde
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37191F00A1A;
	Mon,  2 Nov 2026 13:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793625227;
	bh=ko7FKvtu3ihiy3PYiCR3H1vh1DEBVQZl612hAFBpWFM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WkiS5hde5sQU6oqEY8siiXU3Fr3tJKpfMMjmDvDhaEm0sgDGUNU7c3SwQaS+Tu21J
	 wWCfjZRZTXMl5G61xv4egWzKZjjbBRU0nr9Ej/KmjEAi3YA2QX9FYaXDY6OfiLO66j
	 ZBD4yCDU0oHEl9x0J8M5nZavp5w1/0aJW1sFKdg70WWY+XDRFFEoC54plVFvNB4AAb
	 3r9E2NcbMxYO6aLokcGQZXYDNR+66B1s+LFCJieJ4Whr8+bALW33Om+9kPrjY9lg45
	 0kS1zGMops4hbbkKtwNpcD1R5aip5Ol9QZJiUPQ+5Db2OoQqMNeg2ZXAJqj73Yy1L4
	 7vSWV1mNlnKzg==
Message-ID: <sashiko-outbox-193475@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] rtc: pcf2127: Add support for the clkout clock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261102130712.25104-3-herve.codina@bootlin.com>
References: <20261102130712.25104-1-herve.codina@bootlin.com>
 <20261102130712.25104-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 13:13:46 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] rtc: pcf2127: rate 0 in pcf2127_clkout_rate2cof() sets COF to HiZ
--

commit fd3d38a37715a1ab67448b3adb80c6b0ee46a7e2
Author: Herve Codina <herve.codina@bootlin.com>

rtc: pcf2127: Add support for the clkout clock

This commit adds common clock framework support for the CLKOUT output clock
on PCF2127, PCF2129, PCA2129, and PCF2131 RTC devices, allowing configurati=
on
of frequencies from 1 Hz to 32768 Hz and disabling the output into HiZ.

> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index ff2023908f5a3..2c442770ebc52 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c

[ ... ]

> @@ -626,6 +634,180 @@ static int pcf2127_watchdog_init(struct device *dev=
, struct pcf2127 *pcf2127)
>  	return devm_watchdog_register_device(dev, &pcf2127->wdd);
>  }
> =20
> +#ifdef CONFIG_COMMON_CLK
> +#define clkout_hw_to_pcf2127(_hw) container_of(_hw, struct pcf2127, clko=
ut_hw)
> +
> +/* Rates indexed by COF values */
> +static int pcf2127_clkout_rates[] =3D {
> +	32768,
> +	16384,
> +	8192,
> +	4096,
> +	2048,
> +	1024,
> +	1,
> +	0, /* 0Hz (COF 0b111) will put the clockout signal to HiZ */
> +};
> +
> +static u32 pcf2127_clkout_rate2cof(unsigned long rate)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(pcf2127_clkout_rates); i++) {
> +		if (pcf2127_clkout_rates[i] <=3D rate)
> +			return i;
> +	}
> +
> +	return 0; /* Maximum output clock rate */
> +}
> +
> +static int pcf2127_clkout_cof2rate(u32 cof)
> +{
> +	return pcf2127_clkout_rates[cof];
> +}
> +
> +static unsigned long pcf2127_clkout_recalc_rate(struct clk_hw *hw,
> +						unsigned long parent_rate)
> +{
> +	struct pcf2127 *pcf2127 =3D clkout_hw_to_pcf2127(hw);
> +
> +	return pcf2127_clkout_cof2rate(pcf2127->clkout_cof);
> +}
> +
> +static int pcf2127_clkout_determine_rate(struct clk_hw *hw,
> +					 struct clk_rate_request *req)
> +{
> +	u32 cof;
> +
> +	cof =3D pcf2127_clkout_rate2cof(req->rate);
> +	req->rate =3D pcf2127_clkout_cof2rate(cof);
> +
> +	return 0;
> +}
> +
> +static int pcf2127_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
> +				   unsigned long parent_rate)
> +{
> +	struct pcf2127 *pcf2127 =3D clkout_hw_to_pcf2127(hw);
> +	u32 cof;
> +	int ret;
> +
> +	cof =3D pcf2127_clkout_rate2cof(rate);
> +
> +	/*
> +	 * Setting COF will enable the clock (i.e. output not in HiZ anymore)
> +	 * Perform the operation only if already enabled.
> +	 * Otherwise, do nothing. The expected COF will be set on prepare()
> +	 */
> +	if (pcf2127->clkout_enabled) {
> +		ret =3D regmap_update_bits(pcf2127->regmap, pcf2127->cfg->reg_clkout,
> +					 PCF2127_CLKOUT_COF,
> +					 FIELD_PREP(PCF2127_CLKOUT_COF, cof));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	pcf2127->clkout_cof =3D cof;
> +	return 0;
> +}

[Severity: Medium]
Since rate is an unsigned long and pcf2127_clkout_rates[7] is 0, the condit=
ion
pcf2127_clkout_rates[i] <=3D rate in pcf2127_clkout_rate2cof() will always =
match
at index 7 (PCF2127_CLKOUT_COF_HIZ) when rate is 0, making the fallback
return 0 unreachable.

If a consumer passes rate =3D=3D 0 to pcf2127_clkout_determine_rate() or
pcf2127_clkout_set_rate(), pcf2127_clkout_rate2cof(0) returns 7
(PCF2127_CLKOUT_COF_HIZ). In pcf2127_clkout_set_rate(), this writes
PCF2127_CLKOUT_COF_HIZ to reg_clkout if pcf2127->clkout_enabled is true
(putting the CLKOUT pin into HiZ while pcf2127->clkout_enabled remains true=
),
and caches PCF2127_CLKOUT_COF_HIZ in pcf2127->clkout_cof so subsequent calls
to pcf2127_clkout_prepare() -> pcf2127_clkout_control(hw, true) will also
leave the pin in HiZ.

Should the 0 entry be removed from pcf2127_clkout_rates[] (or skipped in
pcf2127_clkout_rate2cof()) so that pcf2127->clkout_cof only ever holds acti=
ve
clock divider values (0..6)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102130712.2510=
4-1-herve.codina@bootlin.com?part=3D2
