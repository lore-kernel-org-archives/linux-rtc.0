Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED73D3C1D73;
	Fri, 14 Aug 2026 23:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786749028; cv=none; b=Weg6/4XyLlVgQUlf09SAF+enYUlpAqxlyoP01SokF37lmxbV4kR9VMveP2Zwt0WBc8V+DE1hAGUqJajq+airo3Sf+hGZbg/21q+gNlDUcMR2vS6u1fI8Jjjp99ZIHl2Src3YOxBaqcPHn5YJq/w74UkssdKCBQ4kRM1Ea3YG/Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786749028; c=relaxed/simple;
	bh=2H8/OkLkWbkww1eyhym1RxClUsi2YLshgz2dyZR1XjQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V8zY4+WplkMqA8a5C0GwgFhTen6QT/XpQRtS3t1fOdtPdLR6LfSxgLPkrsLlJV5igg6Hn1Ged/wwCMIph6/xXEHg+sFiSw5wxCpkjq4MH2MTfcGd0qEz+tIj1YwEyD4VomCsyQWdW6WfeWowPXya6IGhT3fTqKjcfMhJAy0A5hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFxWwhAm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFxWwhAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB151F000E9;
	Fri, 14 Aug 2026 23:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786749026;
	bh=7aG6KceIRFAzwd4MERgf+iTci1Sfz/9h5xr5EHwEII0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VFxWwhAmVLSmGtB2mA+jb5tg8KsrdC2COdH6NPW+bate9F0JAM3W0OzhW7TdOfUsd
	 bIiKwwgW9Rt4i0+M3tcn9/DSPXSjJ0t7U2td43+YDARdqyTxzAvPBkJ2tU+f9X6E1w
	 eFsCyrZxDxCTkbijNZTr33+HNl/l8DeceuNBQD2RezyRkSm3xohwzysE3B2XgQKNJG
	 7AbjbeGZphit9yYo4FC13wKzR7JJpppAZpw//sbGVyBcaDXHdDmTpo3oYmXNqtJeI3
	 EQzoqj75fcR+74vQ1ic32VTYb2VjfFJeAjnM8Kq2OinQAw+vcWGY7zZ788zMD9UECI
	 1hIHudfKExOIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/6] rtc: s35390a: Add pinctrl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-rtc@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260815-rtc_s35390a_int1-v4-5-3133309c365f@posteo.de>
References: <20260815-rtc_s35390a_int1-v4-0-3133309c365f@posteo.de>
 <20260815-rtc_s35390a_int1-v4-5-3133309c365f@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 23:10:25 +0000
Message-Id: <20260814231026.1EB151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Adding a hard dependency on `PINCTRL` silently breaks the build fo=
r existing platforms that do not use the pin control subsystem.
- [High] The driver references `pinconf_generic_dt_node_to_map_all` without=
 selecting `GENERIC_PINCONF`, causing link errors on some configurations.
- [High] The `s35390a->pinfunction[i]` array is accessed without holding `p=
infunction_lock` during the probe fallback loop, leading to a TOCTOU race w=
ith concurrent pinmux requests.
- [Medium] The 'clock' pin function is advertised to pinctrl consumers but =
is unimplemented and silently disables the pin.
- [Low] The driver calls `dmi_match()` without including `<linux/dmi.h>`.
--

--- Patch [5]: [PATCH v4 5/6] rtc: s35390a: Add pinctrl ---
commit 6a8ad7f9ce8fcaad7659431462d18b19a8eded67
Author: Markus Probst <markus.probst@posteo.de>

rtc: s35390a: Add pinctrl

Allow configuration of pin functions, including:
- keeping the previous configured function
- disabling output
- waking up the system
- minute periodical interrupt (1: 50% duty, 2: 7.81 ms)

If no function has been configured, fallback to previous behaviour.

> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 01def82318731..4e0374129a4ed 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -668,6 +668,7 @@ config RTC_DRV_RC5T619
> =20
>  config RTC_DRV_S35390A
>  	tristate "Seiko Instruments S-35390A"
> +	depends on PINCTRL

[Severity: High]
Will adding this hard dependency on PINCTRL silently break the build or
drop the driver for existing platforms that do not use the pin control
subsystem? Since the driver worked previously without it, should the pin
control features be optional or structured to avoid dropping the driver
entirely on existing configurations?

>  	select BITREVERSE
>  	help
>  	  If you say yes here you will get support for the Seiko

[ ... ]

> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index 4d7fecfbe38e8..80e5413289ac0 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c

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
Does this silently intercept the unimplemented clock function, configure the
hardware incorrectly, and then return success? If a device tree requests the
clock function, shouldn't this return an error instead of falling through
to the disable case?

[ ... ]

> +static const struct pinctrl_ops s35390a_pinctrl_ops =3D {
> +	.get_groups_count =3D s35390a_pinctrl_get_groups_count,
> +	.get_group_name =3D s35390a_pinctrl_get_group_name,
> +	.get_group_pins =3D s35390a_pinctrl_get_group_pins,
> +#if IS_ENABLED(CONFIG_OF)
> +	.dt_node_to_map =3D pinconf_generic_dt_node_to_map_all,
> +	.dt_free_map =3D pinconf_generic_dt_free_map
> +#endif
> +};

[Severity: High]
Does this cause link errors when CONFIG_OF is enabled but CONFIG_GENERIC_PI=
NCONF
is not?

pinconf_generic_dt_node_to_map_all calls pinconf_generic_dt_node_to_map(),
which does not provide an empty inline stub in
include/linux/pinctrl/pinconf-generic.h.

Should the driver Kconfig select GENERIC_PINCONF and PINMUX to prevent this?

[ ... ]

> +	err =3D pinctrl_enable(pctl);
> +	if (err)
> +		return dev_err_probe(dev, err, "pinctrl enable failed\n");
> +
> +	/* If no pinmux function is defined in DT, fallback to previous behavio=
ur */

[Severity: Low]
Does the fallback logic here (or added in a later commit) use dmi_match()
without including <linux/dmi.h>? If so, could this cause an implicit
declaration build failure depending on the architecture and include order?

> +	fallback[0] =3D S35390A_FUNC_IGNORE;
> +	fallback[1] =3D S35390A_FUNC_WAKEUP;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(s35390a_pin_groups); i++) {
> +		if (s35390a->pinfunction[i] =3D=3D -1) {
> +			err =3D s35390a_pinctrl_set_mux(pctl, fallback[i], i);

[Severity: High]
Is there a race condition here since pinctrl_enable() has already exposed
the pin controller to consumers?

If a concurrent consumer requests a pin and securely updates the hardware
and s35390a->pinfunction[i] under pinfunction_lock in
s35390a_pinctrl_set_mux(), couldn't this fallback loop read a stale -1
because it accesses s35390a->pinfunction[i] without holding the lock?

If it reads the stale -1, won't it invoke s35390a_pinctrl_set_mux() and
overwrite the consumer's established hardware state?

> +			if (err)
> +				return err;
> +		}
> +	}
> +
>  	nvmem_cfg.priv =3D s35390a;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815-rtc_s35390=
a_int1-v4-0-3133309c365f@posteo.de?part=3D5
