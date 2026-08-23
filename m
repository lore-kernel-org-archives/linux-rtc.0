Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C9015C14F;
	Sun, 23 Aug 2026 22:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787523973; cv=none; b=qi4uz4M4nAzBhpgCYbtgN84XCvq2qVx1QTO4JJt3UKwkH2HrPCjZoRsA02kAIMWvvChB2rIZL4wUNe4LYxdA3DSQ/aIDfKFQqdOeQZ/XxPlHV5I04HGuhAs9V3ZEmGkPr7prHKSx27qAfiu+Tf1I35eJ9xVa2eiIisuonczpDn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787523973; c=relaxed/simple;
	bh=fUe415RR23MHXIp5/fjmdp8ZELdAlSWnF5D0QvAa+4s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NEi35bfl+gePDZf+Be531thSKibfJcqONBIcx2g2/4+BY/kwEfoDo9t1gQ0XJyyGX+y63kxmYS0+vc04M6zrD65J50j9eVFPByaNE9Xlsb9yKaOnKqlx90BUv/Ii+oBVuGEO+PGzOpFGEoywkOX1yA8hM2wSOpdSy+VjREv0Hc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWMy+vMf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWMy+vMf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B176B1F000E9;
	Sun, 23 Aug 2026 22:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787523972;
	bh=q+ODLCHyap1XWKH3/xYI3rzmya17lA2xHmMYSQJ/2fA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DWMy+vMfJJLNHcao2QBWlkmMAbqwYTbSz7+5rNG+QllwEDuJl9PztY3egwkcejBuf
	 TRW8Sc1G4dl9QWYpl43My/5UUfsEveftoXSWWQzsTPMg742L8bGeb38AMvoErQqc6u
	 WwqplhUVIrWkTHZxRHqtRW3hq/0mvTwbhJYbGw8q2X4QvW2uC6aMxbi6RFc1/AiGoo
	 gJWaCZxlowCPaIsoo09n+lD1F0r5cTL4j/BKGQQEcjUdoCYwSOV4y42LcWjNAtI8JC
	 jWO3PjITC2veLyjW4fjONz4Nmg3ZEXLjokv/gU9p5An3Dy+crt8yR1VIA9SwIarV/n
	 1Mka9/Ky7iRvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/6] rtc: s35390a: Add pinctrl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260824-rtc_s35390a_int1-v6-5-df96569e3412@posteo.de>
References: <20260824-rtc_s35390a_int1-v6-0-df96569e3412@posteo.de>
 <20260824-rtc_s35390a_int1-v6-5-df96569e3412@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 22:26:11 +0000
Message-Id: <20260823222611.B176B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unconditional dependency on PINCTRL removes the RTC driver on non-=
pinctrl platforms.
- [Medium] The 'clock' pin function is advertised but silently falls back t=
o disabling the pin rather than returning an error.
- [Medium] TOCTOU race in `s35390a_probe` when reading `pinfunction` withou=
t lock after `pinctrl_enable`.
--

--- Patch [5]: [PATCH v6 5/6] rtc: s35390a: Add pinctrl ---
commit 73fe5a984406c6bfdc0258a390d1f790625e1082
Author: Markus Probst <markus.probst@posteo.de>

rtc: s35390a: Add pinctrl

This commit adds pinctrl support to the S35390A RTC driver, allowing
configuration of pin functions like wake up, disabled, and periodic
interrupts. If no function is configured, it falls back to the previous
behavior.

> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 01def82318731..2d79710c48375 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -668,7 +668,9 @@ config RTC_DRV_RC5T619
> =20
>  config RTC_DRV_S35390A
>  	tristate "Seiko Instruments S-35390A"
> +	depends on PINCTRL

[Severity: High]
Will this unconditional dependency cause the RTC driver to be silently drop=
ped
on platforms without PINCTRL enabled?

This could break backwards compatibility for existing driver users by chang=
ing
an optional feature into a hard dependency.

>  	select BITREVERSE
> +	select GENERIC_PINCONF
>  	help
>  	  If you say yes here you will get support for the Seiko

> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index 8e3616c65d2c0..a2ddce91ef7ac 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c
[ ... ]
> @@ -458,13 +520,170 @@ static int s35390a_nvmem_write(void *priv, unsigne=
d int offset, void *val,
[ ... ]
> +static int s35390a_pinctrl_set_mux(struct pinctrl_dev *pctldev, unsigned=
 int function,
> +				   unsigned int group)
> +{
[ ... ]
> +	switch (function) {
> +	case S35390A_FUNC_DISABLE:
> +	case S35390A_FUNC_CLOCK: /* not implemented */
> +		status2 =3D (status2 & ~mask) | S35390A_INT_MODE_NOINTR;
> +		break;

[Severity: Medium]
Since the clock function is not implemented, should this return an error
instead of silently disabling the pin?

Users specifying the 'clock' function in the device tree might assume the p=
in
is outputting a clock signal, but it will be disabled instead.

> +	case S35390A_FUNC_WAKEUP:
> +		flag =3D group =3D=3D 0 ? S35390A_INT1_MODE_ALARM : S35390A_INT2_MODE_=
ALARM;
[ ... ]
> @@ -533,9 +758,33 @@ static int s35390a_probe(struct i2c_client *client)
[ ... ]
> +	err =3D pinctrl_enable(pctl);
> +	if (err)
> +		return dev_err_probe(dev, err, "pinctrl enable failed\n");
> +
> +	/* If no pinmux function is defined in DT, fallback to previous behavio=
ur */
> +	fallback[0] =3D S35390A_FUNC_IGNORE;
> +	fallback[1] =3D S35390A_FUNC_WAKEUP;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(s35390a_pin_groups); i++) {
> +		if (s35390a->pinfunction[i] =3D=3D -1) {

[Severity: Medium]
Is there a data race here since the pinfunction array is accessed locklessly
after pinctrl_enable() has made the pinctrl device available?

If another consumer requests the pins concurrently right after pinctrl_enab=
le()
modifying pinfunction, could their configuration be overwritten by this
fallback logic?

> +			err =3D s35390a_pinctrl_set_mux(pctl, fallback[i], i);
> +			if (err)
> +				return err;
> +		}
> +	}
> +
>  	nvmem_cfg.priv =3D s35390a;
>  	err =3D devm_rtc_nvmem_register(rtc, &nvmem_cfg);
>  	if (err)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-rtc_s35390=
a_int1-v6-0-df96569e3412@posteo.de?part=3D5
