Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533AD3CFF73;
	Wed,  5 Aug 2026 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963113; cv=none; b=QSrMe4Tf3KqW/hNAGS4e5YPH8V3/pezKwoJuWo+DEpd88UWPnH1GoOy8NSn8lhDBswdd/3GThCFZgPie2ukhQhrkqHSZn2YSztMAsQdnEmea2LJ3z3llgxhEhuyhpIfCh+SbwlF96Njgg2BfD2bqIst3L7DzL55Vct4agumIRBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963113; c=relaxed/simple;
	bh=nSDv6gsYU/zE/ra5Y7FbphgIXT3Dv2ggh9xnaji/iqQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rvcO1XNhIE47+8Ft+c9n4U6uKDnxt/KWNqaZcuiFEEUfjf+gM+LffKFv6Zs0GNvy8wm+vNAGtT36bA4xlXMYeUuJdAHBdi72LVTExJ4d7F8NIfNPMHnLMQPgLLS3njWlLOpW52UoK5kWVepqiMRdVp4tQrbx/MtFxVhtTzEpuYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Osl062HF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Osl062HF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F3A1F000E9;
	Wed,  5 Aug 2026 20:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785963112;
	bh=eki0lefN3M9oEKKaIqzHxa+VXo1saiYqEzzNKI5+fjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Osl062HFS47jMFLo0qsAj5oY6h6E7o7pU/wVQ8tpltaOnJbwR6stN3Q+fsQorbRFC
	 dpR0w+EHpoQxRg/FS7ecrHINzxRrhAul34wAmlzPMcjstS4ttNG6cUq5tLuNAcwBf8
	 tSpskp8R/6ZgorPRXtdw8dyD1JSiatJofnCelsVS9qG24LQKZaz5to2G1kNdhny+mm
	 l8+4Y+kbiWOMBAbzk6aqFFe/6f1T1NsW02RdBST7BKoVbTRQN2/Xfp+mW+0Ta5PZsi
	 juEy9ba4ipmStyLqb4TkzfwOBndoY4GtY5OBwUepwcsMb55rRjTJllU9WNSN8WosIu
	 RFXK/vAp1ZanQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] rtc: s35390a: Add pinctrl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260805-rtc_s35390a_int1-v3-4-e836faba3e25@posteo.de>
References: <20260805-rtc_s35390a_int1-v3-0-e836faba3e25@posteo.de>
 <20260805-rtc_s35390a_int1-v3-4-e836faba3e25@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 20:51:48 +0000
Message-Id: <20260805205149.E9F3A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The driver initiates I2C communication with the hardware before ho=
noring the required Power-On Circuit (POC) delay, violating the initializat=
ion sequence.
- [High] The pinctrl driver cannot parse device tree pin configuration node=
s because it is missing the `dt_node_to_map` callback.
- [High] Reading the `STATUS1` register to check or clear pending alarms in=
advertently clears the alarm flags for both pins, causing lost wakeup event=
s.
- [Medium] The driver introduces a hard dependency on `CONFIG_PINCTRL`, bre=
aking existing kernel configurations.
--

--- Patch [4]: [PATCH v3 4/5] rtc: s35390a: Add pinctrl ---
commit f348aaf86d41faa0c844cc513c01b349d5a5d4e3
Author: Markus Probst <markus.probst@posteo.de>
Subject: rtc: s35390a: Add pinctrl

Allow configuration of pin functions, including keeping previous config,
disabling output, waking up, and minute periodical interrupt. Fallback to
previous behavior if not configured.

> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 01def82318731..4e0374129a4ed 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -668,6 +668,7 @@ config RTC_DRV_RC5T619
> =20
>  config RTC_DRV_S35390A
>  	tristate "Seiko Instruments S-35390A"
> +	depends on PINCTRL

[Severity: Medium]
Since the kernel pinctrl subsystem provides dummy stubs when CONFIG_PINCTRL=
 is
disabled, should this be a hard dependency? This will prevent building the
driver on platforms without pinctrl support, breaking existing configuratio=
ns.

> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index 575bb256eb258..d63bdeff8cdbc 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c
[ ... ]
> @@ -343,33 +343,35 @@ static int s35390a_rtc_set_alarm(struct device *dev=
, struct rtc_wkalrm *alm)
[ ... ]
> +	err =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts)=
);
> +	if (err < 0)
> +		return err;
> +
> +	/* clear pending interrupt (in STATUS1 only), if any */
> +	err =3D s35390a_get_reg(s35390a, S35390A_CMD_STATUS1, &tmp, sizeof(tmp)=
);
> +	if (err < 0)
> +		return err;

[Severity: High]
Since reading STATUS1 acts as a clear-on-read for both INT1 and INT2 interr=
upt
flags, won't this unconditional read wipe out any pending interrupts for the
other pin?

[ ... ]
> @@ -453,13 +528,181 @@ static int s35390a_nvmem_write(void *priv, unsigne=
d int offset, void *val,
[ ... ]
> +	case S35390A_FUNC_WAKEUP:
> +		flag =3D group =3D=3D 0 ? S35390A_INT1_MODE_ALARM : S35390A_INT2_MODE_=
ALARM;
> +		if ((buf & mask) !=3D flag) {
> +			buf =3D (buf & ~mask) | S35390A_INT_MODE_NOINTR;
> +			break;
> +		}
> +
> +		err =3D s35390a_read_status(s35390a, &status1);

[Severity: High]
Similarly, if s35390a_pinctrl_set_mux() is called twice during initializati=
on
(once for each pin), won't the first call to s35390a_read_status() clear the
flags for both pins, causing the second call to lose any pending wakeup eve=
nt?

[ ... ]
> +static const struct pinctrl_ops s35390a_pinctrl_ops =3D {
> +	.get_groups_count =3D s35390a_pinctrl_get_groups_count,
> +	.get_group_name =3D s35390a_pinctrl_get_group_name,
> +	.get_group_pins =3D s35390a_pinctrl_get_group_pins,
> +};

[Severity: High]
Is this struct missing the dt_node_to_map callback (e.g.,
pinconf_generic_dt_node_to_map_all)? Without it, the pinctrl subsystem will=
 fail
with -ENODEV during pinctrl_dt_to_map(), which ignores any custom pin
multiplexing requested via device tree.

[ ... ]
> @@ -493,39 +741,16 @@ static int s35390a_probe(struct i2c_client *client)
[ ... ]
> +	err =3D s35390a_disable_test_mode(s35390a);
> +	if (err < 0) {
> +		dev_err(dev, "error disabling test mode\n");
> +		return err;
> +	}
[ ... ]
> +	err =3D devm_pinctrl_register_and_init(dev, &s35390a_pinctrl_desc, s353=
90a, &pctl);
> +	if (err)
> +		return dev_err_probe(dev, err, "pinctrl register failed\n");
> +
> +	err =3D pinctrl_enable(pctl);
> +	if (err)
> +		return dev_err_probe(dev, err, "pinctrl enable failed\n");
[ ... ]
> +	err =3D s35390a_read_status(s35390a, &status1);
> +	if (err < 0) {
> +		dev_err(dev, "error resetting chip\n");
> +		return err;
> +	}

[Severity: High]
Does moving the s35390a_read_status() call to later in the probe sequence v=
iolate
the Power-On Circuit delay?

The s35390a_disable_test_mode() and pinctrl_enable() calls both trigger I2C
communication. If the hardware is still in the 0.5-second POC delay period,
communicating with it before checking the POC flag in s35390a_read_status()
might lead to I2C bus hangs or silent failures on cold boot.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-rtc_s35390=
a_int1-v3-0-e836faba3e25@posteo.de?part=3D4
