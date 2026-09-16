Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62845277818;
	Wed, 16 Sep 2026 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575150; cv=none; b=FQkRvzZYumY1a7ISSy2yoK1gJbiJz4dp/0rFwAOmLBnsSGTKZ65eaDWR/jtSLlujChNQJQMYqhKRzP7MMSKnue6Pmf7IyCkdXYwHVFkgM7anY3T6Jyxn1wMbk0PBcxLzM6rTuV89L3PI8Y3Z2YLSBo+TZczQEQubFaAzIL9a/pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575150; c=relaxed/simple;
	bh=cPpmJirMJNv1hKl4s5iTltmoLKkry6RTh3eeYCDeuoc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lZMtl/kIUnE6F03vqjNvQhTFr3Sk4Gi4AhC3egRFwCJksXitaFs8YatBl/tGZT1CqPOwMP5V/OrzPXExz+YZG4yg75h73N50P0oodrLo0QNw1Yq7G8W5Gzb6YZEq7GUA03gMpBCVWddydKFzMgEveuwWgbMQs56S3xjGKmgyk9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzHfy1ys; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzHfy1ys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40061F00893;
	Wed, 16 Sep 2026 16:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789575148;
	bh=XNRWKCJdjTB6/+6G1RNisieWSH3/AJTGcYCa+LHle4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QzHfy1ys8xGzsVY4d64i7xR/Q7mpUSovQz3YZMaArIWpJO+TCSyyJfh5luapvsTDD
	 VYKMDme8oDP5VquwY+7Kt9+mLM2l8EVlmPGLyszLNXlLIDMFexxCozDE2cl2PBaMLx
	 Z2g0HEQ6wYCEIrJUvznNEXhZ28+SGDd2cbjJQEm1E/lxWu7D9pArDXSFQke4CAHYON
	 ct/5PqsMI514dNOnpTE27hqpfJo8+a1V1RQP3GLT3wD8s9E0WI8qxi8QjI4bwViWrU
	 TXl0rrRPO31lCSYZ68G1SoLON9047fSO2VAuDef1x3drfAJG3vXsMCfvDnmammeVpt
	 sy4m0VY7zK9FQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/6] rtc: s35390a: Add pinctrl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260916-rtc_s35390a_int1-v9-5-b2567a3e4959@posteo.de>
References: <20260916-rtc_s35390a_int1-v9-0-b2567a3e4959@posteo.de>
 <20260916-rtc_s35390a_int1-v9-5-b2567a3e4959@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:12:27 +0000
Message-Id: <20260916161227.E40061F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] pinctrl: 'clock' function is advertised but silently disables th=
e pin
- [Medium] rtc: probe unconditionally clobbers periodic pin configuration i=
f interrupt is pending
--

commit 8933a7b5fe72ca6a0ef2901f1d1c8bf6cbe6372f
Author: Markus Probst <markus.probst@posteo.de>

rtc: s35390a: Add pinctrl

This commit adds pinctrl support to the s35390a RTC driver, allowing
configuration of pin functions including keeping previous configuration,
disabling, waking up, and minute periodical interrupts.

> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index 12ed504db94d8..649d36d37f1f4 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c

[ ... ]

> @@ -464,13 +526,168 @@ static int s35390a_nvmem_write(void *priv, unsigne=
d int offset, void *val,

[ ... ]

> +	if (function !=3D S35390A_FUNC_IGNORE) {
> +		err =3D s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &status2, 1);
> +		if (err < 0) {
> +			dev_err(&s35390a->client[0]->dev, "error reading status\n");
> +			return err;
> +		}
> +
> +		switch (function) {
> +		case S35390A_FUNC_DISABLE:
> +		case S35390A_FUNC_CLOCK: /* not implemented */
> +			status2 =3D (status2 & ~mask) | S35390A_INT_MODE_NOINTR;
> +			break;

[Severity: Medium]
In s35390a_pinctrl_set_mux(), does this silently fail to implement the
requested clock behavior and disable the pin instead?

If a device tree configuration requests the advertised clock pin function,
should this return an error like -ENOTSUPP or -EINVAL instead of silently
disabling it?

[ ... ]

> @@ -504,33 +726,34 @@ static int s35390a_probe(struct i2c_client *client)

[ ... ]

> +	err =3D s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &status2, sizeof(=
status2));
> +	if (err < 0)
> +		return dev_err_probe(dev, err, "disabling alarm and test mode failed\n=
");
> +
> +	if (status1 & S35390A_FLAG_INT1) {
> +		status2 =3D (status2 & ~S35390A_INT1_MODE_MASK) | S35390A_INT_MODE_NOI=
NTR;
> +		irq =3D true;
>  	}

[Severity: Medium]
In s35390a_probe(), can this force the pin to NOINTR mode if an interrupt
was pending at boot, permanently destroying a periodic configuration before
the pinctrl 'keep previous' fallback can save it?

If the device is configured to generate periodic interrupts (like a 1-minute
wakeup), and the system boots while the interrupt flag happens to be set in
STATUS1, overwriting STATUS2 to NOINTR might cause the pinctrl subsystem's
IGNORE fallback to keep this overwritten state, leaving the pin permanently
disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-rtc_s35390=
a_int1-v9-0-b2567a3e4959@posteo.de?part=3D5
