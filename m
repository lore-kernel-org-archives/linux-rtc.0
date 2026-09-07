Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E84E34F49F;
	Mon,  7 Sep 2026 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777359; cv=none; b=k4Y3MSsFXF3THBqoCqbrLVEY4HVygovj6rNGAH7lTnhC9lukrMP0RwbuzQP5bYpf6xe8IYYZMbM/0l+BiKGf4jXgbq2sd1/HCrgyzh/eT62X78mJGR5apTajB3gP0AxuFQLM0wzYRZNFkScgDsqIhNI6MRrCvVzLfvbAWDAuptc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777359; c=relaxed/simple;
	bh=xMlub5BOQ25WNX7iAERpk+2bEZVIiDNos+jgmXK0FV4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OYVXVWUz7o/c66/2wX63JI/n1oKeSOrSIjk2v6kP+8JJmHfLydkv24BQZY/svSYpyJi4XE0ErmNoem5N+1RZn55nFCWs3gOC7XtWb+wBM2sSzvwxkVkt/prTlODkqqGfHN6uw1gIINmCLkYE5xV5O4AFH6iq2xtZSBU9Cs7maKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMHiXVVS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMHiXVVS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E8B1F00A3A;
	Mon,  7 Sep 2026 10:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788777357;
	bh=d7riazMQRpOtzjRkp35RRo2GrQE6IJIiQstt4o8gFq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kMHiXVVSi33A+xaHU3M2c8N/BCOOYeuIDP4W7PkLAkSzITZoJos6ZK74h/f7PbX4F
	 jJcXMW6VY/Vqq2M6a56MAIPXzQizV/jGZyA+Yp7HM9TPs5V/i6dJwkng0m2zM929tW
	 0R8OJ3bIQMn65pdUox42KCKGWolzBf8tEtoYjbUwnFv9tgAokyudw2f2GN7Cw9a6TH
	 R3v9gEazH3FZ9SeuGFCMV6jwrJGS4+pBGJbd1ProakwaGnpci1GNT0sbDUYTXvD2Xu
	 LiOfQlXCz/OdLI3UhuXL1l0FbLQNPqYlepISuZDwmDDT/GeXd60GjX16f2EO7yAjri
	 Q2qyNW95aqZOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/2] rtc: Add NXP PCF85053 driver support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260907102134.394717-2-lakshay.piplani@nxp.com>
References: <20260907102134.394717-1-lakshay.piplani@nxp.com>
 <20260907102134.394717-2-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:35:56 +0000
Message-Id: <20260907103557.16E8B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Inconsistent secondary interface checks cause hardware access viol=
ations and potential IRQ storms.
- [Medium] The driver ignores requested alarm dates and fails to bound alar=
m offsets, causing alarms far in the future to trigger within 24 hours.
- [Medium] Clearing the Alarm Flag (AF) after enabling the Alarm Interrupt =
Enable (AIE) bit causes a race that drops valid alarm interrupts.
- [Medium] Read-modify-write on the write-0-to-clear status register accide=
ntally drops concurrent hardware flags.
- [Low] The Kconfig entry for RTC_DRV_PCF85053 fails to `select REGMAP_I2C`=
, which will cause a build failure.
--

commit c573ac7ea41cfa02a273751465e9782324597723
Author: Lakshay Piplani <lakshay.piplani@nxp.com>

rtc: Add NXP PCF85053 driver support

This commit adds a new I2C-based RTC driver for the NXP PCF85053, supporting
time, alarms, wakeup, and clock output features on both primary and seconda=
ry
buses.

> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 05b9233b94189..ecd4832301867 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1005,6 +1005,16 @@ config RTC_DRV_PCF85063
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-pcf85063.
> =20
> +config RTC_DRV_PCF85053
> +	tristate "NXP PCF85053"
> +	depends on OF && I2C

[Severity: Low]
Is it intentional to not select REGMAP_I2C here? The driver code relies on
devm_regmap_init_i2c(), which requires REGMAP_I2C. If a kernel is built whe=
re
CONFIG_RTC_DRV_PCF85053=3Dy is selected but no other driver selects
CONFIG_REGMAP_I2C, it will cause a build failure.

> +	help
> +	  If you say yes here you get support for the NXP PCF85053 I2C Bootable=
 CPU RTC
> +	  chip.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called rtc-pcf85053.
> +

[ ... ]

> diff --git a/drivers/rtc/rtc-pcf85053.c b/drivers/rtc/rtc-pcf85053.c
> new file mode 100644
> index 0000000000000..811731bc6596a
> --- /dev/null
> +++ b/drivers/rtc/rtc-pcf85053.c

[ ... ]

> +static int pcf85053_set_alarm_mode(struct regmap *regmap, bool on)
> +{
> +	unsigned int val;
> +	int err;
> +
> +	val =3D on ? PCF85053_BIT_AIE : 0;
> +
> +	err =3D regmap_update_bits(regmap, PCF85053_REG_CTRL,
> +				 PCF85053_BIT_AIE,
> +				 val);
> +	if (err)
> +		return err;
> +
> +	return regmap_update_bits(regmap, PCF85053_REG_ST,
> +				  PCF85053_BIT_AF, 0);

[Severity: Medium]
Could this sequence drop valid alarm interrupts?

By clearing the Alarm Flag (AF) after enabling the Alarm Interrupt Enable
(AIE) bit, if the RTC time matches the alarm concurrently (or it was already
pending), the hardware asserts AF and triggers the IRQ. The subsequent write
clears AF and deasserts the IRQ before the threaded handler executes. The
handler will then read AF=3D0 and return IRQ_NONE, causing the alarm event =
to
be permanently lost.

> +}

[ ... ]

> +static irqreturn_t pcf85053_irq(int irq, void *dev_id)
> +{
> +	struct device *dev =3D dev_id;
> +	struct pcf85053 *pcf85053 =3D dev_get_drvdata(dev);
> +	bool changed;
> +	int err;
> +
> +	err =3D regmap_update_bits_check(pcf85053->regmap,
> +				       PCF85053_REG_ST,
> +				       PCF85053_BIT_AF, 0,
> +				       &changed);

[Severity: Medium]
Can this read-modify-write on the status register accidentally drop concurr=
ent
hardware flags like OF or RTCF?

The status register (PCF85053_REG_ST) uses write-0-to-clear semantics. Using
regmap_update_bits_check() performs a read-modify-write, writing 0 to the
targeted bits but writing back the read values (which could be 0) for the
other bits. If a non-targeted flag is read as 0 but asserted by the hardware
before the write, the write of 0 will unintentionally clear it.

> +
> +	if (err || !changed)
> +		return IRQ_NONE;
> +
> +	rtc_update_irq(pcf85053->rtc, 1, RTC_IRQF | RTC_AF);
> +	return IRQ_HANDLED;
> +}

[ ... ]

> +static int pcf85053_rtc_set_alarm(struct device *dev, struct rtc_wkalrm =
*tm)
> +{
> +	struct pcf85053 *pcf85053 =3D dev_get_drvdata(dev);
> +	bool is_24h, is_bin;
> +	unsigned int ctrl;
> +	u8 sec, min, hr;
> +	int err;
> +
> +	/*
> +	 * Only primary can set alarm, as secondary have read only access
> +	 * to alarm, control and status registers
> +	 */
> +	if (!pcf85053->is_primary)
> +		return -EACCES;
> +
> +	err =3D regmap_read(pcf85053->regmap, PCF85053_REG_CTRL, &ctrl);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Do not force the hour format (HF) or data mode (DM). Rewriting these
> +	 * bits without converting the stored time would corrupt the running
> +	 * clock. Format the alarm values to match the mode the device is
> +	 * currently configured for instead.
> +	 */
> +	is_24h =3D !!(ctrl & PCF85053_BIT_HF);
> +	is_bin =3D !!(ctrl & PCF85053_BIT_DM);
> +
> +	err =3D regmap_update_bits(pcf85053->regmap, PCF85053_REG_ST,
> +				 PCF85053_BIT_AF, 0);
> +	if (err)
> +		return err;
> +
> +	sec =3D pcf85053_encode_val(tm->time.tm_sec, is_bin) & 0x7F;
> +	min =3D pcf85053_encode_val(tm->time.tm_min, is_bin) & 0x7F;
> +	hr  =3D pcf85053_encode_hour(tm->time.tm_hour, is_24h, is_bin);

[Severity: Medium]
Does this ignore requested alarm dates?

Since the date constraints are ignored entirely during encoding and only
HH:MM:SS are programmed, an alarm requested more than 24 hours in the future
(via /dev/rtc0 or alarmtimer) will be silently truncated and arm a <24h ala=
rm.
This can cause the system to wake up prematurely.

> +
> +	err =3D regmap_write(pcf85053->regmap, PCF85053_REG_SCA, sec);
> +	if (err)
> +		return err;

[ ... ]

> +static int pcf85053_ioctl(struct device *dev, unsigned int cmd, unsigned=
 long arg)
> +{
> +	struct pcf85053 *pcf85053 =3D dev_get_drvdata(dev);
> +	unsigned int val =3D 0, vl_status =3D 0;
> +	unsigned int bvl;
> +	int status;
> +
> +	switch (cmd) {
> +	case RTC_VL_READ:
> +		status =3D regmap_read(pcf85053->regmap, PCF85053_REG_ST, &val);
> +		if (status)
> +			return status;
> +
> +		if (val & (PCF85053_BIT_OF | PCF85053_BIT_RTCF))
> +			vl_status |=3D RTC_VL_DATA_INVALID;
> +
> +		bvl =3D val & PCF85053A_BVL_MASK;
> +
> +		if (bvl =3D=3D 0x00)
> +			vl_status |=3D RTC_VL_BACKUP_EMPTY;
> +		else if (bvl <=3D PCF85053A_BVL_LOW_THRESHOLD)
> +			vl_status |=3D RTC_VL_BACKUP_LOW;
> +
> +		return put_user(vl_status, (unsigned int __user *)arg);
> +
> +	case RTC_VL_CLR:
> +		/* Only the primary interface may write the status register. */
> +		if (!pcf85053->is_primary)
> +			return -EACCES;
> +
> +		return regmap_update_bits(pcf85053->regmap, PCF85053_REG_ST,
> +					  PCF85053_BIT_OF |
> +					  PCF85053_BIT_RTCF, 0);

[Severity: Medium]
Similar to the IRQ handler, can this read-modify-write clear an incoming al=
arm?

Clearing OF and RTCF using regmap_update_bits() writes 0 to AF if it was re=
ad
as 0, which can accidentally drop a concurrent alarm flag.

> +
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +}

[ ... ]

> +static int pcf85053_clkout_set_rate(struct clk_hw *hw, unsigned long rat=
e,
> +				    unsigned long parent_rate)
> +{
> +	struct pcf85053 *pcf85053 =3D clkout_hw_to_pcf85053(hw);
> +	unsigned int val =3D 0;
> +	int err, i;

[Severity: High]
Is it safe to omit the is_primary validation here?

The secondary interface lacks write access to the control registers. Without
this check, writes on the secondary interface could silently fail.

> +
> +	err =3D regmap_read(pcf85053->regmap, PCF85053_REG_CLKO, &val);
> +	if (err)
> +		return err;

[ ... ]

> +static int pcf85053_probe(struct i2c_client *client)
> +{
> +	const struct pcf85053_config *config;
> +	struct device *dev =3D &client->dev;
> +	const char *iface =3D NULL;
> +	struct pcf85053 *pcf85053;
> +	int err;

[ ... ]

> +	/*
> +	 * The year register stores 00-99 and the RTC treats any value where
> +	 * (year % 4) =3D=3D 0 as a leap year, with no special handling for the
> +	 * centuries. Mapping 00-99 to 2000-2099 keeps the leap-year logic
> +	 * correct over the whole usable range.
> +	 */
> +	pcf85053->rtc->ops =3D &pcf85053_rtc_ops;
> +	pcf85053->rtc->range_min =3D RTC_TIMESTAMP_BEGIN_2000;
> +	pcf85053->rtc->range_max =3D RTC_TIMESTAMP_END_2099;
> +	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, pcf85053->rtc->features);

[Severity: Medium]
Should pcf85053->rtc->alarm_offset_max be initialized here to enforce the
24-hour hardware limitation?

Bounding the alarm offset to 24 * 60 * 60 ensures that alarmtimer requests =
are
properly bounded, preventing the truncation issue during set_alarm.

> +	clear_bit(RTC_FEATURE_ALARM, pcf85053->rtc->features);
> +
> +	if (config->has_alarms && client->irq > 0) {
> +		err =3D devm_request_threaded_irq(dev, client->irq,

[Severity: High]
Should this probe unconditionally configure alarm IRQs regardless of
primary/secondary ownership?

If the driver is bound as secondary but the device tree has an irq specifie=
d,
it will unconditionally register the alarm IRQ. Since the secondary interfa=
ce
lacks write access to control registers, when an alarm fires, the IRQ handl=
er's
attempt to clear AF by writing 0 will be silently ignored. This leaves the
level-triggered IRQ asserted, potentially causing an infinite interrupt sto=
rm
that hangs the CPU.

> +						NULL, pcf85053_irq,
> +						IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
> +						"pcf85053", dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907102134.3947=
17-1-lakshay.piplani@nxp.com?part=3D2
