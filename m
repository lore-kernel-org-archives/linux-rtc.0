Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB55E3BBA05;
	Sat,  1 Aug 2026 18:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785610728; cv=none; b=I0W5CVClPKh963xTV5jOPeLRWnq5dBqHKozaUwsJZHPa697J+0IwuUV2njMSDN8zZ8MFgF5Ks664Fb0ORr6KZKmFp1XT2+gtP6vBBTl0p3qCLS6908MZobFgXqqTEqZ/b35DEzdRhRotxY3KCflaK8iGbEPqnUuQeIro7ON9JcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785610728; c=relaxed/simple;
	bh=q0gFf5oH+FUlOE4+sKO8WvJcjUlt+BpYPpbAtuPP7Ug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rP0wBEeiR+k2bswmsYPyZVbOpdi7fofBycBR5+tkcKvWHmNXjwwWxq1JCenyI03LodKVL1lzNaRyM99MY2wcjDL5trhkAs9wmhZh3hR/41XDIsl0wXbRkCwzxrLRK7rfPAwvEpHBP+14F5OSXBLntRMZtE+tGF1ZplcUSeiGcXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIbAQvLw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIbAQvLw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143EE1F00AC4;
	Sat,  1 Aug 2026 18:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785610726;
	bh=DP51TKr3nmmL6zgztCO0ocgXhv9SeuJXb3ox4z7mXxg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fIbAQvLw4uCM353UyfpAKcfPFUsEIzOIQlcnxob6TNwrThy5cjEhsM3PgskRb/mKO
	 4uBr5B1mXjOAl6puxB6YaWn//dC9k49gt5kmZIOPiIt8J9QvpuG9BK7AZiGv6frYzH
	 DP2zoHXMpMua4lqLc7vAe4RaOLuaNgGDIWRdTrp16YH1eJcQmYwqnH9WLrwwIMON/A
	 Oi8KXfFzk/GS+KYz7PI2zvngUunsWA2nQQdj/MpGferQ5X8f9SXJI7SNhsYgwQlj3I
	 DCRE0AwOG6t5eKfDaqOwLm98KVlyDmFmj2kYNSFibNn78NuRSiB4kogkaujIeSTKih
	 T2xLGD8azSncw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] rtc: s35390a: Add pinctrl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260801-rtc_s35390a_int1-v2-4-f10c99ad1d6c@posteo.de>
References: <20260801-rtc_s35390a_int1-v2-0-f10c99ad1d6c@posteo.de>
 <20260801-rtc_s35390a_int1-v2-4-f10c99ad1d6c@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:58:45 +0000
Message-Id: <20260801185846.143EE1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Missing `pinctrl_enable()` call after `devm_pinctrl_register_and_i=
nit()`.
- [High] Adding `depends on OF` breaks the driver on ACPI-based x86 systems.
- [High] Hardcoded array index `configs[0]` inside loop in `s35390a_pinconf=
_set` ignores multiple configurations.
- [High] Information leak due to uninitialized stack variable in `s35390a_r=
tc_alarm_irq_enable()`.
- [High] Hardware pending interrupt flag is no longer cleared, breaking sub=
sequent alarm wakeups.
- [High] Alarm interrupts notify the PM core before the device is configure=
d as wakeup capable, causing lost wake events.
- [Medium] Software state caching updates before hardware programming succe=
eds, causing permanent desynchronization on I2C failure.
--

--- Patch [4]: [PATCH v2 4/5] rtc: s35390a: Add pinctrl ---
commit 58cfab3a8ceba177a47650a06a107e0c784e6fff
Author: Markus Probst <markus.probst@posteo.de>
Subject: rtc: s35390a: Add pinctrl

Allow configuration of other output modes than wake alarm, including:
keeping the previous configured mode, disabling output, custom frequency,
minute periodical interrupt, and raw 32.768 kHz output.

> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -668,7 +668,10 @@ config RTC_DRV_RC5T619
> =20
>  config RTC_DRV_S35390A
>  	tristate "Seiko Instruments S-35390A"
> +	depends on OF

[Severity: High]
Does adding the strict OF dependency here break the driver for ACPI-based x=
86
systems?=20

The driver explicitly supports DMI quirks for such systems, and this might
prevent compilation for previously supported non-OF hardware like Synology =
NAS
platforms.

> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c
[ ... ]
> @@ -283,33 +309,33 @@ static int s35390a_rtc_set_alarm(struct device *dev=
, struct rtc_wkalrm *alm)
>  		alm->time.tm_min, alm->time.tm_hour, alm->time.tm_mday,
>  		alm->time.tm_mon, alm->time.tm_year, alm->time.tm_wday);
> =20
> -	/* disable interrupt (which deasserts the irq line) */
> -	err =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts)=
);
> -	if (err < 0)
> -		return err;
> +	guard(mutex)(&s35390a->mode_lock);
> =20
> -	/* clear pending interrupt (in STATUS1 only), if any */
> -	err =3D s35390a_get_reg(s35390a, S35390A_CMD_STATUS1, &sts, sizeof(sts)=
);
> +	err =3D s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts)=
);
>  	if (err < 0)
>  		return err;

[Severity: High]
Is it intentional to remove the read of S35390A_CMD_STATUS1 here?

By removing this read, the RTC chip's internal pending interrupt flag might=
=20
never be cleared when a new alarm is set. Can this cause the physical WAKEU=
P=20
pin to remain asserted, preventing the host from detecting subsequent alarm=
=20
edges?

[ ... ]
> @@ -388,10 +445,10 @@ static int s35390a_rtc_alarm_irq_enable(struct devi=
ce *dev, unsigned int enabled
>  	struct s35390a *s35390a =3D dev_get_drvdata(dev);
>  	struct rtc_wkalrm alm;
> =20
> -	alm.enabled =3D enabled;
> -
>  	if (enabled)
> -		alm.time =3D s35390a->tm_alarm;
> +		alm =3D s35390a->alarm;
> +
> +	alm.enabled =3D enabled;
> =20
>  	return s35390a_rtc_set_alarm(dev, &alm);
>  }

[Severity: High]
If enabled is 0, is the stack-allocated alm struct left uninitialized except
for the enabled field?

If RTC_AIE_OFF is called, this uninitialized memory is passed to
s35390a_rtc_set_alarm() where it is copied into the permanent device state
s35390a->alarm. A subsequent RTC_ALM_READ could then copy this uninitialized
kernel stack memory to userspace via s35390a_rtc_read_alarm(). Does this
create an information leak?

[ ... ]
> +static int s35390a_update_mode(struct s35390a *s35390a, int pin, int mod=
e, int freq)
> +{
[ ... ]
> +	if (mode =3D=3D s35390a->mode[pin] && freq =3D=3D s35390a->freq[pin])
> +		return 0;
> +
> +	s35390a->mode[pin] =3D mode;
> +	s35390a->freq[pin] =3D freq;
> +
> +	if (mode =3D=3D S35390A_MODE_IGNORE)
> +		return 0;
> +
> +	err =3D s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &buf, 1);
> +	if (err < 0) {
> +		dev_err(&s35390a->client[0]->dev, "error reading status\n");
> +		return err;
> +	}

[Severity: Medium]
Is it safe to update the software state (s35390a->mode and freq) before
confirming the hardware configuration via I2C succeeds?

If s35390a_get_reg() or a later I2C operation fails, the driver state will
incorrectly reflect the new mode. Future attempts to set this same mode wou=
ld
then be skipped by the check above, permanently desynchronizing the software
state from the hardware until a different mode is applied. Should the state
update happen at the end of the function after hardware success?

[ ... ]
> +static int s35390a_pinconf_set(struct pinctrl_dev *pctldev,
> +			       unsigned int pin, unsigned long *configs,
> +			       unsigned int num_configs)
> +{
[ ... ]
> +	for (i =3D 0; i < num_configs; i++) {
> +		param =3D pinconf_to_config_param(configs[0]);
> +		param_val =3D pinconf_to_config_argument(configs[0]);

[Severity: High]
Does this loop intend to use configs[i] instead of configs[0]?

As written, when multiple pin configurations are defined in the device tree,
the loop will repeatedly process the first configuration while ignoring all
subsequent properties.

[ ... ]
> @@ -477,7 +762,10 @@ static int s35390a_probe(struct i2c_client *client)
[ ... ]
> +	err =3D devm_pinctrl_register_and_init(dev, &s35390a_pinctrl_desc, s353=
90a,
> +					     &s35390a->pinctrl);
> +	if (err)
> +		return err;

[Severity: High]
Is a call to pinctrl_enable() missing here?

After devm_pinctrl_register_and_init(), the pinctrl device remains in the
initialization state. Without pinctrl_enable(), it may never be fully
registered or exposed to the pinctrl core, rendering the feature
non-functional.

> +
> +	/* If no pinctrl config is defined in DT, fallback to previous behaviou=
r */
> +	if (!s35390a->mode_init) {
> +		err =3D s35390a_update_mode(s35390a, 1, S35390A_MODE_WAKEUP, 0);
> +		if (err)
> +			return err;
> +	}
> +
>  	err_read =3D s35390a_read_status(s35390a, &status1);
>  	if (err_read < 0) {
>  		dev_err(dev, "error resetting chip\n");
> @@ -507,34 +822,8 @@ static int s35390a_probe(struct i2c_client *client)
>  	else
>  		s35390a->twentyfourhour =3D 0;
> =20
>  	device_set_wakeup_capable(dev, 1);

[Severity: High]
Can s35390a_update_mode() trigger rtc_update_irq() prematurely in the probe
sequence?

If an alarm fired while the system was off, s35390a_update_mode() calls
rtc_update_irq(), which relies on pm_stay_awake(). However, since
device_set_wakeup_capable(dev, 1) hasn't been called yet, the PM core may
drop the wakeup notification. Additionally, the queued IRQ work might read
the time before s35390a->twentyfourhour is initialized.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801-rtc_s35390=
a_int1-v2-0-f10c99ad1d6c@posteo.de?part=3D4
