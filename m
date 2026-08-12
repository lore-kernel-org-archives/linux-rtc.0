Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40513203B6;
	Wed, 12 Aug 2026 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521166; cv=none; b=MaAvV4S6n4uiOYBDeJYls2F4KZ2yxLLPJVMRfbemT786oDQKj2Qxz5njSBSEbHr8aqqjTmwewbsCWJ9JsF/wE+8Vk8wom4GPU8Tq8dWe/uvzivI4JvyyU0DhpxGERhDcabSXIe0g2pQ6+zp61hBoA9S1sqgrNy80vlOPxiQ/3d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521166; c=relaxed/simple;
	bh=O33Ri7wNc/k+XoHeCKNID9eUnWwrdNbstaea58etEYg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fz10fbIUjtg6GtRAUe21f+FlBy4h3bIXG0z9TDbbG1VLPMPbzPgmyaAzIs0pDkjj823RqiDFd2QB0p72rbh7koTqhPHwB0IiJ+brVkejGFVjuR9taX7alxpzYBfaXY5Non9P3yGeJmzlBmyZ+VUmJ+LSLkg+jFBABxsPzJ7H2Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzrfi7r5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzrfi7r5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA651F000E9;
	Wed, 12 Aug 2026 07:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786521164;
	bh=+eyDz/5NvFv8MIRP6FMmSfLJyile2rVDlrcuRf6nwlg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mzrfi7r59H1s6qvANb2b1da4fWuhoxUcKODNH4G+lpNSXL9IP755CKypkS/cyMh+3
	 JQ8EG+S++tGZwtLq/tcyCZYQlrT5BczlMl6rydCILh/d/Dlvg+DSGOgZaVdt4vHvCV
	 iix9hBRgBJysrahbnXTAVQZTdzVukVgg31bxVCLDQOz8CrIJQ2HR+m5PRACxk+F44u
	 Sdd40ZVrqoMiPC9jDqfnPkdVOMn0ToLX2rnjJyacm9Ke/mOAf8yv1TRHV2AI/gHs3K
	 yXAXMUc9zG2M6wyWcidv/FxvxDk7dAu5FkvGjSmUgiMV7OnjEZMZWWCIY3Rv3/x0Yv
	 4LM7Pa2q6UF3g==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND v7 2/2] rtc: Add NXP PCF85053 driver support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, linux-rtc@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260812073552.3542956-2-lakshay.piplani@nxp.com>
References: <20260812073552.3542956-1-lakshay.piplani@nxp.com>
 <20260812073552.3542956-2-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 07:52:43 +0000
Message-Id: <20260812075244.4AA651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The OF clock provider registered with `of_clk_add_provider()` is n=
ever unregistered, leading to a resource leak and use-after-free on driver =
unbind or probe failure.
- [High] `pcf85053_rtc_set_time()` unconditionally zeroes out the interleav=
ed alarm registers, destroying any configured alarm when setting the time.
- [High] Forcing 24-hour and binary mode in `set_time` and `set_alarm` corr=
upts existing timekeeping and writes binary data to a BCD-configured second=
ary interface.
- [Medium] The Oscillator Fail (OF) bit is never cleared after setting a va=
lid time, permanently locking the RTC in an invalid state after a power los=
s.
- [Medium] `pcf85053_rtc_read_time()` reads the status register but ignores=
 the result, failing to check the Oscillator Fail (OF) bit for invalid time.
--

--- Patch [2]: [RESEND v7 2/2] rtc: Add NXP PCF85053 driver support ---
commit 9c8ab988d6c43472440d6251d1c52f7cbe264dbb
Author: Lakshay Piplani <lakshay.piplani@nxp.com>

rtc: Add NXP PCF85053 driver support

This commit adds support for the NXP PCF85053 I2C RTC, which supports timer
and calendar functionality. It introduces the driver code, Kconfig options,
and Makefile updates.

> diff --git a/drivers/rtc/rtc-pcf85053.c b/drivers/rtc/rtc-pcf85053.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/rtc/rtc-pcf85053.c
[ ... ]
> +static int pcf85053_rtc_read_time(struct device *dev, struct rtc_time *t=
m)
> +{
> +	struct pcf85053 *pcf85053 =3D dev_get_drvdata(dev);
> +	unsigned int ctrl, st, h12;
> +	bool is_24h, is_bin;
> +	u8 regs[10], hr;
> +	int err;
> +
> +	err =3D regmap_read(pcf85053->regmap, PCF85053_REG_CTRL, &ctrl);
> +	if (err)
> +		return err;
> +
> +	err =3D regmap_read(pcf85053->regmap, PCF85053_REG_ST, &st);
> +	if (err)
> +		return err;
> +
> +	if (ctrl & PCF85053_BIT_ST)
> +		return -EINVAL;

[Severity: Medium]
Is it intentional that the st variable is read but never evaluated here?

Because st is ignored, the driver doesn't check the PCF85053_BIT_OF flag.
Would this allow the system to boot and blindly use a corrupted time from a
failed oscillator instead of returning -EINVAL?

[ ... ]
> +static int pcf85053_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +
> +{
> +	struct pcf85053 *pcf85053 =3D dev_get_drvdata(dev);
> +	unsigned int ctrl;
> +	int err, ret;
> +	u8 buf[10];
> +
> +	/*
> +	 * By default, secondary have write access to time registers as TWO
> +	 * bit is 0 by default, if we set nxp,interface =3D "primary" and the
> +	 * nxp,write-access in device tree, then TWO bits gets set and primary
> +	 * gets write access to time registers.
> +	 */
> +	if (!pcf85053_time_write_access(pcf85053))
> +		return -EACCES;
> +
> +	err =3D regmap_read(pcf85053->regmap, PCF85053_REG_CTRL, &ctrl);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * HF =3D 1, 24-hour mode
> +	 * DM =3D 1, binary (not BCD)
> +	 */
> +	if (!(ctrl & PCF85053_BIT_HF) ||
> +	    !(ctrl & PCF85053_BIT_DM)) {
> +		err =3D regmap_update_bits(pcf85053->regmap, PCF85053_REG_CTRL,
> +					 PCF85053_BIT_HF | PCF85053_BIT_DM,
> +					 PCF85053_BIT_HF | PCF85053_BIT_DM);
> +		if (err)
> +			return err;
> +	}

[Severity: High]
Does forcing 24-hour and binary mode here corrupt existing timekeeping?

If the hardware is currently configured in BCD mode, updating the control
register without converting the current time registers would instantly cause
the hardware to interpret the existing BCD values as binary.

Additionally, since the secondary interface has read-only access to control
registers, this regmap_update_bits() call will be ignored by the hardware w=
hen
invoked from a secondary interface. However, the driver will still proceed =
to
write binary-formatted time values. Could this break the clock by writing
binary values that the hardware will interpret as BCD?

> +
> +	buf[0] =3D tm->tm_sec & 0x7F;
> +	buf[1] =3D 0;
> +	buf[2] =3D tm->tm_min & 0x7F;
> +	buf[3] =3D 0;
> +	buf[4] =3D tm->tm_hour & PCF85053_HR_24H_MASK;
> +	buf[5] =3D 0;
> +	buf[6] =3D tm->tm_wday & 0x07;
> +	buf[7] =3D tm->tm_mday & 0x3F;
> +	buf[8] =3D (tm->tm_mon + 1) & 0x1F;
> +	buf[9] =3D (tm->tm_year - 100) & 0xFF;
> +
> +	if (pcf85053->is_primary) {
> +		err =3D regmap_update_bits(pcf85053->regmap, PCF85053_REG_CTRL,
> +					 PCF85053_BIT_ST, PCF85053_BIT_ST);
> +		if (err)
> +			return err;
> +
> +		ret =3D regmap_bulk_write(pcf85053->regmap, PCF85053_REG_SC, buf, size=
of(buf));
> +		err =3D regmap_update_bits(pcf85053->regmap, PCF85053_REG_CTRL,
> +					 PCF85053_BIT_ST, 0);
> +		return ret ? ret : err;
> +	}
> +
> +	return regmap_bulk_write(pcf85053->regmap, PCF85053_REG_SC, buf, sizeof=
(buf));
> +}

[Severity: High]
Does this bulk write unconditionally destroy any configured alarms?

The hardware interleaves time and alarm registers. By hardcoding 0 at the
alarm register indices (buf[1], buf[3], buf[5]) and doing a 10-byte bulk
write, calling set_time will clobber any pending alarm previously configure=
d.

[ ... ]
> +static int pcf85053_rtc_set_alarm(struct device *dev, struct rtc_wkalrm =
*tm)
> +{
> +	struct pcf85053 *pcf85053 =3D dev_get_drvdata(dev);
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
> +	 * HF =3D 1, 24-hour mode
> +	 * DM =3D 1, binary (not BCD)
> +	 */
> +	if (!(ctrl & PCF85053_BIT_HF) ||
> +	    !(ctrl & PCF85053_BIT_DM)) {
> +		err =3D regmap_update_bits(pcf85053->regmap, PCF85053_REG_CTRL,
> +					 PCF85053_BIT_HF | PCF85053_BIT_DM,
> +					 PCF85053_BIT_HF | PCF85053_BIT_DM);
> +		if (err)
> +			return err;
> +	}

[Severity: High]
Just like in pcf85053_rtc_set_time(), does flipping the mode bits here with=
out
updating the time registers cause the hardware to incorrectly interpret exi=
sting
time data?

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
> +		if (val & PCF85053_BIT_OF)
> +			vl_status |=3D RTC_VL_DATA_INVALID;

[Severity: Medium]
Is there a missing mechanism to clear the Oscillator Fail (OF) bit?

The OF bit is reported here, but neither pcf85053_rtc_set_time() nor the io=
ctl
handler clears it. Since the hardware does not auto-clear this bit, will the
RTC permanently report invalid data to userspace after a power loss?

[ ... ]
> +static struct clk *pcf85053_clkout_register_clk(struct pcf85053 *pcf8505=
3)
> +{
> +	struct device *dev =3D pcf85053->rtc->dev.parent;
> +	struct device_node *node =3D dev->of_node;
> +	struct clk *clk;
> +	struct clk_init_data init;
> +
> +	init.name =3D "pcf85053-clkout";
> +	init.ops =3D &pcf85053_clkout_ops;
> +	init.flags =3D 0;
> +	init.parent_names =3D NULL;
> +	init.num_parents =3D 0;
> +	pcf85053->clkout_hw.init =3D &init;
> +
> +	/* optional override of the clockname */
> +	of_property_read_string(node, "clock-output-names", &init.name);
> +
> +	/* register the clock */
> +	clk =3D devm_clk_register(dev, &pcf85053->clkout_hw);
> +
> +	if (!IS_ERR(clk))
> +		of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +
> +	return clk;
> +}

[Severity: High]
Does this leak the OF clock provider?

The of_clk_add_provider() is called to register the clock, but there is no
corresponding teardown mechanism (like a devm action or a remove callback
calling of_clk_del_provider()).

If the driver is unbound or if devm_rtc_register_device() fails in
pcf85053_probe(), the clock hardware structure is freed by devres, leaving a
dangling pointer in the global of_clk_providers list. Any subsequent device
tree clock resolution could access freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812073552.3542=
956-1-lakshay.piplani@nxp.com?part=3D2
