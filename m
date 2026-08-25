Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CD735AC00;
	Tue, 25 Aug 2026 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787643304; cv=none; b=mlifwGb7811jFXFms4e3xMkmOocydwgokBxmjbuSfCI5csZUXUsk4yIgA94t1rl13W4W972wSoZyNguivUlvBgtPttnPjFKr/sMSNiqst77zHNFZWQFWIzi9+f4quNBieo/IifDMph1cDwa2sZHl38StfBe3LUL0uQnJnzFwy24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787643304; c=relaxed/simple;
	bh=ynSBguqbPFM+GOyR7eMk8ZvNjEBerTw+GvdgHYH4FhY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ANbQPiscSjqzS+keZc9NUhNV2ylePBJUn8hfPr3C03/7Aa2qJpFMvjrGFUGe95ecN4hf7nYecwsLvbdqITutNSdNea6P+LQR5n7X6GNolBkbQUgcLiD4rO26sH2pKxNgc/ToFOXgqtxXJEkxTokUhN7/3soHKRd6/5cb3dvmJDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlYJvdsc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlYJvdsc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110241F000E9;
	Tue, 25 Aug 2026 07:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787643302;
	bh=mH94sGEMJPsNhggBOC7qtfA/DNqu2LXswLRYxpEnlb0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IlYJvdscU8drerYJ2fZvhTxAUdilMv5p/HyCDDdFhxZZqWXy3JtfYZWh7ctvKkPvl
	 i/limCe+FaqY4vmrC6l51DHTDq8fUZKMQ9UZr2pc39YgUR+IeVz2tsfZmzAB6uufzj
	 WKmxIpeCtQeJhdzDbkM7TpSdue0JwRWs6a6SIR62ogag6L3ipFr/SmARPIDnMxH3de
	 erdH0PD+pP/fWqaddWoEWf78XeHrYfBSLBhShkz3w6f0ZcLexQdA2WtbUQzOOpafA5
	 XeJftDlinHFMHRk6Emy1ceD4zJWEukILaN7XazcOMxIC8z5rLqxh0LisrKWj8ecb1m
	 EOkPqazZ4MUMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] rtc: rs5c372: add support for Ricoh R2223x
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Schocher" <hs@nabladev.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260825071927.4090460-3-hs@nabladev.com>
References: <20260825071927.4090460-1-hs@nabladev.com>
 <20260825071927.4090460-3-hs@nabladev.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 07:35:01 +0000
Message-Id: <20260825073502.110241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver assigns the `s32` return value of `i2c_smbus_read_byte_=
data()` directly to an `unsigned char` without checking for negative error =
codes, which can silently corrupt the control register.
- [High] Stale cached register value is modified and written back in `rs5c_=
rtc_alarm_irq_enable()`, clobbering hardware state.
- [High] The probe function silently succeeds without registering the RTC d=
evice if the RTC type is unknown.
- [Medium] In `rs5c_set_alarm()`, a failed I2C write when enabling the alar=
m is ignored, resulting in an inconsistent cached state.
--

--- Patch [2]: [PATCH v2 2/3] rtc: rs5c372: add support for Ricoh R2223x ---
commit 8a1878e4309e6f90ca5c0f1dc3f2411879befd7b
Author: Heiko Schocher <hs@nabladev.com>
Subject: rtc: rs5c372: add support for Ricoh R2223x

This commit adds support for the Ricoh R2223x I2C RTC device to the rs5c372
driver. It updates the driver's type definitions, device ID tables, and mat=
ch
tables, treating the R2223x similarly to the r2221tl and r2025sd models for
time setting, reading, and control register handling.

Closes: https://sashiko.dev/#/patchset/20260824110452.4038870-1-hs@nabladev=
.com?part=3D2
Closes: https://sashiko.dev/#/patchset/20260824110452.4038870-1-hs@nabladev=
.com?part=3D3

> diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
> index 24bd795d9d95d..c65b76cc0dc66 100644
> --- a/drivers/rtc/rtc-rs5c372.c
> +++ b/drivers/rtc/rtc-rs5c372.c
[ ... ]
> @@ -292,6 +300,7 @@ static int rs5c372_rtc_set_time(struct device *dev, s=
truct rtc_time *tm)
>  	switch (rs5c->type) {
>  	case rtc_r2025sd:
>  	case rtc_r2221tl:
> +	case rtc_r2223x:
>  		ctrl2 &=3D ~(R2x2x_CTRL2_VDET | R2x2x_CTRL2_PON);
>  		if (rs5c->type =3D=3D rtc_r2025sd)
>  			ctrl2 |=3D R2x2x_CTRL2_XSTP;

[Severity: High]
This is a pre-existing issue, but does rs5c372_rtc_set_time() handle negati=
ve
error codes from i2c_smbus_read_byte_data() correctly here?

Just above this switch statement, the return value is assigned directly to =
an
unsigned char:

	ctrl2 =3D i2c_smbus_read_byte_data(client, addr);

If this read fails (e.g., returning -EIO), the negative error code is
truncated into an unsigned char. The driver then masks and modifies this
corrupted value before writing it back to the device, which could silently
corrupt the control register.

[ ... ]
> @@ -511,8 +520,10 @@ static int rs5c372_ioctl(struct device *dev, unsigne=
d int cmd, unsigned long arg
>  		switch (rs5c->type) {
>  		case rtc_r2025sd:
>  		case rtc_r2221tl:
> +		case rtc_r2223x:
>  			if ((rs5c->type =3D=3D rtc_r2025sd && !(ctrl2 & R2x2x_CTRL2_XSTP)) ||
> -				(rs5c->type =3D=3D rtc_r2221tl &&  (ctrl2 & R2x2x_CTRL2_XSTP))) {
> +			    ((rs5c->type =3D=3D rtc_r2221tl || rs5c->type =3D=3D rtc_r2223x) =
&&
> +			     (ctrl2 & R2x2x_CTRL2_XSTP))) {
>  				flags |=3D RTC_VL_DATA_INVALID;

[Severity: High]
This is a pre-existing issue, but similar to the set_time function, does
rs5c372_ioctl() suffer from the same truncation problem?

On the RTC_VL_CLR path, the read value is assigned to an unsigned char:

	ctrl2 =3D i2c_smbus_read_byte_data(rs5c->client, addr);

If this read fails, the unhandled negative error code is truncated and
subsequently written back to the device, potentially clobbering the registe=
r.

[ ... ]
> @@ -847,6 +863,7 @@ static int rs5c372_probe(struct i2c_client *client)
>  		break;
>  	case rtc_r2025sd:
>  	case rtc_r2221tl:
> +	case rtc_r2223x:
>  	case rtc_rv5c386:
>  	case rtc_rv5c387a:
>  		if (rs5c372->regs[RS5C_REG_CTRL1] & RV5C387_CTRL1_24)

[Severity: High]
This is a pre-existing issue, but does rs5c372_probe() silently succeed if
the RTC type is unknown?

If the device type doesn't match the known cases, the switch falls through =
to
the default case:

	default:
		dev_err(&client->dev, "unknown RTC type\n");
		goto exit;

At this point, the 'err' variable is 0 because the preceding rs5c_get_regs()
call succeeded. This causes the driver probe to incorrectly return 0 (succe=
ss)
instead of a negative error code like -ENODEV, leading to an incorrectly
bound but non-functional driver.

While reviewing the above changes, a few other pre-existing issues were
noticed in this file:

[Severity: High]
This is a pre-existing issue, but does rs5c_rtc_alarm_irq_enable() overwrite
hardware state changes with stale cached values?

The function initializes 'buf' from the old cache before fetching the new
state:

	buf =3D rs5c->regs[RS5C_REG_CTRL1];

	if (!rs5c->has_irq)
		return -EINVAL;

	status =3D rs5c_get_regs(rs5c);

The rs5c_get_regs() call updates the local cache (rs5c->regs) with the
latest hardware state. However, the function then modifies the stale 'buf'
variable and writes it back to the hardware. Any state changes that occurred
between the previous cache update and the rs5c_get_regs() call could be
silently overwritten with the old values.

[Severity: Medium]
This is a pre-existing issue, but does rs5c_set_alarm() incorrectly sync the
local register cache to an enabled state if the I2C write fails?

When enabling the alarm:

	if (i2c_smbus_write_byte_data(client, addr, buf[0]) < 0)
		dev_warn(dev, "can't enable alarm\n");
	rs5c->regs[RS5C_REG_CTRL1] =3D buf[0];

If the I2C write fails, the driver logs a warning but proceeds to update the
software cache (rs5c->regs) as if the operation succeeded, returning 0. This
leaves the software state reporting the alarm as active while the hardware
is not actually configured.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825071927.4090=
460-1-hs@nabladev.com?part=3D2
