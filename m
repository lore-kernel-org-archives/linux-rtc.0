Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFB43F54BF;
	Mon, 24 Aug 2026 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570067; cv=none; b=dVJgPhaYJvGTzyL8VkRGiFmbMImIA0k6O8HUzFBeMTXqYRrCPKyIM8yjuqNzUGY6Mlb29m3owlppxcFl8PGOiEfjTaAh28r03XdmYUNFPNim24C+ZmoB8B62rDnEwStH7L2m9zvhq6MVKRdfvGPc9TvAv5fKA5LUlS55sKmKcqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570067; c=relaxed/simple;
	bh=dVdUsBxh+Nf+XIJpvuJ4eJBu+cwfa0EXC60r+4bgLlw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LC+cLkDsbAKSLpeNQt1iPkiuxOmrnD3RolFthjsnJThCx4yQDib1MgOGbPQHy09uAeXE3lfqPSqXA+4CY2lSG7eHwK4PP6knbmY+nQsz2f0pZAgY7gZ/RBiJMKK/uuKD98GvkZWehxKLKnPeuq8gYntxMhF4zO1jNle2DHN3VBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bK/tD7vV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bK/tD7vV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABB51F000E9;
	Mon, 24 Aug 2026 11:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787570065;
	bh=19UYL/DTLYmf+6p7uxMkM1QyiJ6HqAEH7Afr+QOKQls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bK/tD7vVrTlxhrEHL+vJ6fl7HEzuv34HJCynnOZpOWa8JafZyKVNcJ4IgeI8GhStP
	 khHuU7sW52f50p//R3E4uOVq9jm5Dr5tlR1mUOu06k/Em8U8uV4/fUtDkjhIlIb0hX
	 0PDZUQoUICKlzTKmfiIne85JwJQE4J/ziKH+ixCehAkFj0IlnDjpXC2nQv3mcCp5ir
	 uLVjHrMTyQwBHBcCdRP7Upb8rHaK7XVRbu22QMBjx/IIzcw7K3AxBMbKxtu898LECd
	 eh9t5pyBs3GWiqJmJXqyEgGlf0m5iaoq7/66Y4TAArdyATQXOBvOTsPAnPgXuw/k2+
	 TPCzfaJkwfn/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/3] rtc: rs5c372: add support for Ricoh R2223x
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Schocher" <hs@nabladev.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260824110452.4038870-3-hs@nabladev.com>
References: <20260824110452.4038870-1-hs@nabladev.com>
 <20260824110452.4038870-3-hs@nabladev.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:14:25 +0000
Message-Id: <20260824111425.9ABB51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The new RTC type `rtc_r2223x` is missing from the switch stateme=
nts in `rs5c372_ioctl()`, `rs5c372_read_offset()`, and `rs5c372_set_offset(=
)`.
--

--- Patch [2]: [PATCH v1 2/3] rtc: rs5c372: add support for Ricoh R2223x ---
commit f8cda87e08814c0d84a3917bdc200d86363e7127
Author: Heiko Schocher <hs@nabladev.com>

rtc: rs5c372: add support for Ricoh R2223x
   =20
The R2223x is an I2C RTC from the same family as the r2025sd and r2221tl
that this driver already handles. It shares the R2x2x control register
layout, so treat it like the r2221tl.

> diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
> index 24bd795d9d95d..30e272d650219 100644
> --- a/drivers/rtc/rtc-rs5c372.c
> +++ b/drivers/rtc/rtc-rs5c372.c
[ ... ]
> @@ -221,8 +227,10 @@ static int rs5c372_rtc_read_time(struct device *dev,=
 struct rtc_time *tm)
>  	switch (rs5c->type) {
>  	case rtc_r2025sd:
>  	case rtc_r2221tl:
> +	case rtc_r2223x:
>  		if ((rs5c->type =3D=3D rtc_r2025sd && !(ctrl2 & R2x2x_CTRL2_XSTP)) ||
> -		    (rs5c->type =3D=3D rtc_r2221tl &&  (ctrl2 & R2x2x_CTRL2_XSTP))) {
> +		    ((rs5c->type =3D=3D rtc_r2221tl || rs5c->type =3D=3D rtc_r2223x) &&
> +		     (ctrl2 & R2x2x_CTRL2_XSTP))) {

[Severity: Medium]
Since rtc_r2223x shares the register layout with rtc_r2221tl, should it als=
o be
added to the switch statements in rs5c372_ioctl(), rs5c372_read_offset(), a=
nd
rs5c372_set_offset()?

Without it, RTC_VL_READ falls into the default path, ignoring VDET and
returning incorrect XSTP bits. RTC_VL_CLR also fails to clear the VDET hard=
ware
flag:

	case RTC_VL_CLR:
		/* clear VDET bit */
		if (rs5c->type =3D=3D rtc_r2025sd || rs5c->type =3D=3D rtc_r2221tl) {
			ctrl2 &=3D ~R2x2x_CTRL2_VDET;
			...

Additionally, rs5c372_read_offset() and rs5c372_set_offset() will skip using
the higher resolution DEV mode for rtc_r2223x, falling back to the default =
low
resolution calculations:

	switch (rs5c->type) {
	case rtc_r2221tl:
		ppb_per_step =3D val & R2221TL_TRIM_DEV ? 1017 : 3051;
		break;
	...

>  			dev_warn(&client->dev, "rtc oscillator interruption detected. Please =
reset the rtc clock.\n");
>  			return -EINVAL;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824110452.4038=
870-1-hs@nabladev.com?part=3D2
