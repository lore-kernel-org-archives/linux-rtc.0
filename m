Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030803749F6;
	Wed, 30 Sep 2026 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783195; cv=none; b=h9K2q6tlq8UFkH5eOjPr9/zEz9JB9RHwM23aHyQMYDwz8b7UI/DR9TUTpuTfiSQ2WJU+whWxJl3vI0UO3diEVpq5dL+4mBmW8vu+/y5D0wTB9D/9HbNEcHT3WhOnQjwUqfKMn2pT+PeFbm9Nf3WUYynWZlu5QQV9zwhXuzK+Umo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783195; c=relaxed/simple;
	bh=XLQXimJESwGJoxHJcSuFJfpi8B36Xr2hYevUwxyatkE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ixfvYY/BqKV35826LRWaeajmEcq1PBzYw0nIOa3Ng9A1O3z7H9S/aJA/I5i2xZtpWX3RxigGlN5c6xGFz1mPJeS3U+BB9ancQz1SdJk94hDu/+O6JBE9aJ3suvLnrC6KU4TqWt5uu22LTf8U3sWSoZD6pjnEwTuP1bQtJNLxXho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glAjG27H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glAjG27H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEA21F00898;
	Wed, 30 Sep 2026 15:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790783188;
	bh=vaXXBPfqxAwItTvW9ejyDZg5LEp2nEJjgBenWwPvGSI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=glAjG27Hh57m+gGeR1aHFAA/AL2hJcU5Sb6lCc+T8fh6SQIbN6f3p/Hq4xCZSBoD2
	 OA3hsZ27ei+cRsLazkO84rxPyI+JLZH1Q61t01/6SqXosGwHXcEKIuZ3INdlrw9Gnr
	 kIHbuiPTY9tAzhFUGtkCHnO3rSS0DZYzXaIWFpZnpUAZCz/Xr4Tc97zv73mZbmNpC4
	 A8R67snxW0ny0N3dKIMV8c0GF62/hBEiDG3KfzPkM1t71FRPpcWg1IjeX1sQiqEAPf
	 w23FfaaQvhm2NzkHjme518RdW6A+LxjpfsTGOgkNvNUBYsdykhXUG/w2xP4EEUPDrR
	 G96psTCn271ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 5/6] rtc: s35390a: Add pinctrl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260930-rtc_s35390a_int1-v10-5-e7b1cbc50a7b@posteo.de>
References: <20260930-rtc_s35390a_int1-v10-0-e7b1cbc50a7b@posteo.de>
 <20260930-rtc_s35390a_int1-v10-5-e7b1cbc50a7b@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 15:46:27 +0000
Message-Id: <20260930154628.5AEA21F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] rtc: s35390a: RTC hardware reset silently destroys pinctrl configu=
rations
- [Medium] rtc: s35390a: silent failure when setting alarm without WAKEUP p=
in
- [Medium] rtc: s35390a: 'clock' pin function silently behaves as 'disable'
--

commit 45e9a4cae015f35a25fbac259c1165bae0a8f0fd
Author: Markus Probst <markus.probst@posteo.de>
Subject: rtc: s35390a: Add pinctrl

This commit adds pinctrl support to the s35390a RTC driver, allowing
configuration of the INT1 and INT2 pin functions. It supports functions
like wakeup, clock, pmin1, pmin2, disable, and ignore.

> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index 12ed504db94d8..649d36d37f1f4 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c
> @@ -142,12 +142,12 @@ static int s35390a_init(struct s35390a *s35390a, u8=
 *sts)
>  	 * The 24H bit is kept over reset, so set it already here.
>  	 */
>  initialize:
> -	buf =3D S35390A_FLAG_RESET | S35390A_FLAG_24H;
> -	ret =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS1, &buf, 1);
> +	*sts =3D S35390A_FLAG_RESET | S35390A_FLAG_24H;
> +	ret =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS1, sts, 1);

[Severity: High]
If the RTC has the BLD (Battery Low Detection) flag set, calling
s35390a_rtc_set_time() triggers s35390a_init(), which resets the chip via
S35390A_FLAG_RESET. This clears the STATUS2 register in hardware, stopping
all pin outputs.

Because the driver's software cache (s35390a->pinfunction) is not cleared,
does this permanently disable hardware outputs (like PMIN1) until userspace
bypasses the cache check by setting a different dummy function first?

[ ... ]
> @@ -370,18 +370,30 @@ static int s35390a_rtc_set_alarm(struct device *dev=
, struct rtc_wkalrm *alm)
>  	for (i =3D 0; i < 3; ++i)
>  		buf[i] =3D bitrev8(buf[i]);
> =20
> -	err =3D s35390a_set_reg(s35390a, S35390A_CMD_INT2_REG1, buf,
> -								sizeof(buf));
> +	if (alm->enabled) {
> +		/* set interrupt mode */
> +		if (s35390a->pinfunction[0] =3D=3D S35390A_FUNC_WAKEUP)
> +			status2 =3D (status2 & ~S35390A_INT1_MODE_MASK) | S35390A_INT1_MODE_A=
LARM;
> =20
> -	return err;
> +		if (s35390a->pinfunction[1] =3D=3D S35390A_FUNC_WAKEUP)
> +			status2 =3D (status2 & ~S35390A_INT2_MODE_MASK) | S35390A_INT2_MODE_A=
LARM;
> +
> +		err =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &status2, sizeof=
(status2));
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	if (s35390a->pinfunction[0] =3D=3D S35390A_FUNC_WAKEUP) {
> +		err =3D s35390a_set_reg(s35390a, S35390A_CMD_INT1_REG1, buf, sizeof(bu=
f));
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	if (s35390a->pinfunction[1] =3D=3D S35390A_FUNC_WAKEUP) {
> +		err =3D s35390a_set_reg(s35390a, S35390A_CMD_INT2_REG1, buf, sizeof(bu=
f));
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return 0;
>  }

[Severity: Medium]
If neither pin is configured with the WAKEUP function via pinctrl (e.g., bo=
th
are set to PMIN1 or DISABLE), does calling set_alarm skip writing the
INT1/INT2 registers and return 0 (success) without actually arming the alar=
m?

Could this mislead the RTC subsystem and userspace into believing an alarm =
was
successfully programmed when the hardware is not configured to trigger it?

[ ... ]
> @@ -528,6 +528,162 @@ static int s35390a_nvmem_write(void *priv, unsigned=
 int offset, void *val,
> +static const struct pinfunction s35390a_functions[] =3D {
> +	[S35390A_FUNC_IGNORE] =3D PINCTRL_PINFUNCTION("ignore", all_groups, ARR=
AY_SIZE(all_groups)),
> +	[S35390A_FUNC_DISABLE] =3D PINCTRL_PINFUNCTION("disable", all_groups, A=
RRAY_SIZE(all_groups)),
> +	[S35390A_FUNC_WAKEUP] =3D PINCTRL_PINFUNCTION("wakeup", all_groups, ARR=
AY_SIZE(all_groups)),
> +	[S35390A_FUNC_CLOCK] =3D PINCTRL_PINFUNCTION("clock", all_groups, ARRAY=
_SIZE(all_groups)),

[Severity: Medium]
Does exposing the unsupported 'clock' function to the pinctrl subsystem as a
valid option violate the API contract?

> +	[S35390A_FUNC_PMIN1] =3D PINCTRL_PINFUNCTION("pmin1", all_groups, ARRAY=
_SIZE(all_groups)),
> +	[S35390A_FUNC_PMIN2] =3D PINCTRL_PINFUNCTION("pmin2", int1_groups, ARRA=
Y_SIZE(int1_groups)),
> +};
> +
[ ... ]
> +static int s35390a_pinctrl_set_mux(struct pinctrl_dev *pctldev, unsigned=
 int function,
> +				   unsigned int group)
> +{
[ ... ]
> +		switch (function) {
> +		case S35390A_FUNC_DISABLE:
> +		case S35390A_FUNC_CLOCK: /* not implemented */
> +			status2 =3D (status2 & ~mask) | S35390A_INT_MODE_NOINTR;
> +			break;

If userspace or devicetree requests the 'clock' function expecting a clock
output, it appears this silently configures the pin to disable the interrupt
output instead. Should it return an error instead of silently behaving as
'disable'?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-rtc_s35390=
a_int1-v10-0-e7b1cbc50a7b@posteo.de?part=3D5
