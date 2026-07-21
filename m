Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B2C3BCD21
	for <linux-rtc@vger.kernel.org>; Tue, 21 Jul 2026 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784622623; cv=none; b=TVq6MI9MvErtc0a1LThP4n2zheETWcNw6XkrayGri00VUceptVXGTjKaN46dNQcgg4520OUqGL10xLetSwT2SCbd1a9Z/BxaPUsc7zlJHjTagrmHRMZSLQ4S6Y0SuxF9J9MB6A1UYeN7rVwwmGUZkxm1uqYXumg6Qn3Pc7Yg5W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784622623; c=relaxed/simple;
	bh=HdAOIPWWmYVLpVTcPwx+JHfEsxCqWWqqROKIIgowyPw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SMOY+C1V3ZjBg87Ogbhx3uBrMM4rLxzTBFnW4AcURe1I1lXqNkeN1rPJe+KOb4pGtnR1N/RZGndOidjchEwIxd9bc1Ea7Wk4wiRCKp60ubhOZudCMm/3lUi44NiAn0YgKUk7PaBktlsRfJJTzMngZi1GAsgL5AgjN+VFUJ13LHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahrvA48z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahrvA48z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2921F000E9;
	Tue, 21 Jul 2026 08:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784622621;
	bh=Z+s59T7T8k8I4qyxC3+/xMtd5AHx9EYgIqZ4XNrICC8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ahrvA48zAXMvoUErjepceO3w8C/IwiLoDRvrK/v2WUOB+98/O5V5r26zvuTFq/o5T
	 YJXOdjh1URQdxomjCHCpgSMRIm+lE6HlAEXgo5D8R/rsdzT7rV1URp0JK2mruvMP6j
	 gRYA3UHUQhhyMsap9XvnpwoMMCDRxP3DFa/744ZxK23iTiOwU93qr5jO2ex6YCvuzj
	 sXu92jYDViwIkXnXkGSBqmKk8IDQ1zfS2KVhxF0wtNvli32E5ljmGqsUCWl3D1exkG
	 xyROdHsspFSMqrVo3Mzn9Ev5Zv++xfM1NGvw7CUXxR6DzGhwQhpsEu9sOaLUkfpxSs
	 AqR2BjlRJXROw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: ds1307: fix RX8130 wakeup alarm WADA bit for
 day-of-month mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robert Leussler" <robert.leussler@leica-geosystems.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260721081907.3518648-1-robert.leussler@leica-geosystems.com>
References: <20260721081907.3518648-1-robert.leussler@leica-geosystems.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 08:30:21 +0000
Message-Id: <20260721083021.7D2921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Read-modify-write on the write-0-to-clear FLAG register can silent=
ly clear asynchronous hardware flags.
--

--- Patch [1]: [PATCH] rtc: ds1307: fix RX8130 wakeup alarm WADA bit for da=
y-of-month mode ---
commit 8a134031395cee2cc4d889ef300ebcec83e18b1b
Author: Robert Leussler <robert.leussler@leica-geosystems.com>
Subject: rtc: ds1307: fix RX8130 wakeup alarm WADA bit for day-of-month mode

This commit fixes the RX8130 wakeup alarm by setting the WADA bit in the
Extension register so the day-of-month alarm works correctly, rather than
failing as an out-of-range day-of-week alarm.

> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -656,13 +656,13 @@ static int rx8130_set_alarm(struct device *dev, str=
uct rtc_wkalrm *t)
> =20
>  	/* Read control registers. */
>  	ret =3D regmap_bulk_read(ds1307->regmap, RX8130_REG_EXTENSION, ctl,
>  			       sizeof(ctl));
>  	if (ret < 0)
>  		return ret;
> =20
> -	ctl[0] &=3D RX8130_REG_EXTENSION_WADA;
> +	ctl[0] |=3D RX8130_REG_EXTENSION_WADA;
>  	ctl[1] &=3D ~RX8130_REG_FLAG_AF;

[Severity: High]
This is a pre-existing issue, but could this read-modify-write sequence on=
=20
the FLAG register (ctl[1]) silently clear asynchronous hardware flags like=
=20
the Voltage Low Flag (VLF)?

Because the FLAG register uses write-0-to-clear semantics, any bits that
are read as 0 will be written back as 0. If a hardware flag like VLF is
asserted in the slow I2C window between regmap_bulk_read() and
regmap_bulk_write(), wouldn't writing back a 0 accidentally clear it and
potentially hide an oscillator failure from userspace?

This same read-modify-write pattern also appears to be present during
interrupt handling in rx8130_irq().

>  	ctl[2] &=3D ~RX8130_REG_CONTROL0_AIE;
> =20
>  	ret =3D regmap_bulk_write(ds1307->regmap, RX8130_REG_EXTENSION, ctl,
>  				sizeof(ctl));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721081907.3518=
648-1-robert.leussler@leica-geosystems.com?part=3D1
