Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5D21C5D72;
	Sat, 29 Aug 2026 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013940; cv=none; b=AzRXfPI+b/DiDl0dRAd+MJ38/Lhe2pV7LbqKdUhWe5I1JfaJWKCkvYOZD0EtrhZweURAvsk2yCRm4E+mqc30thLD4mEK7q0TMC1s+9y+S61Mb9P+eXoa/H5in+ojSIbwwkHRn8c9UO8rNUs6xOBHQNxhVqQ/RbUG00t+Xokt1kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013940; c=relaxed/simple;
	bh=p/mwdg1J6VVqYZrQqeKXegT8s2sG/WHA9h4a2Pdnups=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q8inYoH1pxOZ8nuWz4P5FkQMs0O84K+eYPBzg3KphfK2HDie4VMQJNh6ycxbMVBCNFIV48KZTHvw3PAPucR4EKGqkAIPuaeC5X/4wTHk5Fu458x9GlbC4/p72EfPw4bDK6ZZkmAc6glLeHXAG7jdvzcCNx1GBRrS88I+iiT8jcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6Qis4Ep; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6Qis4Ep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB181F000E9;
	Sat, 29 Aug 2026 14:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788013938;
	bh=vznTKrvyOuiMnauVQeeBzySeYn0LqTMOgbecjVKB96o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M6Qis4Epic93KjDwCjc7hohxN1Tv7unWv7Jyr7s1YUUP8hdTSY2pTbBqQjD3T8Zas
	 CxZ6/ZzHHM9B25h/cQDeDWg740vft7Q0nrvpW4kSMpBsj4EXEomy0plCacTVJ30Luw
	 gTbsT9zyarUWHKGwUb6hIQpVEo0rKWWGSJDQUSKaA7FWxfByjIpaXsn8lSwvjKjQPI
	 dFfXMbS+ZX3XJgDLpQtAcmnG5TXKBIADrWP5UeuKH+pJxO5VuAsPQnM/wK0DJdkLVl
	 BjAcfGAKsu5JlvPhIOY1rAchdwFDWGSLCwTvGWgvojRA9h0bDsY5ZTvDzfJJizCgV6
	 dZaQ5FK4o29LA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/6] rtc: s35390a: Add pinctrl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: robh@kernel.org, devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260829-rtc_s35390a_int1-v7-5-debcd31143ae@posteo.de>
References: <20260829-rtc_s35390a_int1-v7-0-debcd31143ae@posteo.de>
 <20260829-rtc_s35390a_int1-v7-5-debcd31143ae@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 14:32:17 +0000
Message-Id: <20260829143218.3AB181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Mixing goto-based control flow with guard() cleanup in the same fun=
ction.
--

commit dd254d343ff68630c82771ba28746846db1164dd
Author: Markus Probst <markus.probst@posteo.de>

rtc: s35390a: Add pinctrl

Allow configuration of pin functions, including keeping the previous=20
configured function, disabling output, waking up the system, or=20
minute periodical interrupt.

> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index 12ed504db94d8..66ae58ac06ddd 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c

[ ... ]

> +static int s35390a_pinctrl_set_mux(struct pinctrl_dev *pctldev, unsigned=
 int function,
> +				   unsigned int group)
> +{
> +	int err;
> +	u8 status2, flag, mask;
> +	struct s35390a *s35390a =3D pinctrl_dev_get_drvdata(pctldev);
> +
> +	mask =3D group =3D=3D 0 ? S35390A_INT1_MODE_MASK : S35390A_INT2_MODE_MA=
SK;
> +
> +	guard(mutex)(&s35390a->pinfunction_lock);
> +
> +	dev_dbg(&s35390a->client[0]->dev, "%s: function=3D%d group=3D%d\n",
> +		__func__, function, group);
> +
> +	if (function =3D=3D s35390a->pinfunction[group])
> +		return 0;
> +
> +	if (function =3D=3D S35390A_FUNC_IGNORE)
> +		goto end;

[Severity: Low]
Does mixing goto-based control flow with guard() cleanup in the same functi=
on
violate the cleanup subsystem guidelines?

The cleanup subsystem explicitly discourages mixing goto statements with
scope-based cleanups like guard() in the same function to prevent ownership
ambiguity.

While the lock will still be correctly released here when going out of scope
at the target label, would it be better to avoid the goto and rely complete=
ly
on scope-based returns?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829-rtc_s35390=
a_int1-v7-0-debcd31143ae@posteo.de?part=3D5
