Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0823624BF
	for <linux-rtc@vger.kernel.org>; Fri, 24 Jul 2026 02:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784861350; cv=none; b=iyxSKSU8I2VmK8lHSQVU6sDcLCcnYBw9v7hw3vSJFQDdDDpEIQM4aMO30/64F0uWalm3M8gvs8kfAkQ61fOc8/dnNVG+kr298IYAK93uhDc0M5LimgwcJ0fY3pVjz53cmN+zzVOXtT48P7z+62lamwCZC/Pd0Dm5QJpz6Z+3azA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784861350; c=relaxed/simple;
	bh=5IftMrd8WyQ9Wd3tzBXMC2+Hq2syjJS+Bu0Jz6EjtAk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kXWG9zaY7lCwvEd9hDiiT19Mc9NDx0YMIklSAXjDJlPIJvrJZnUVYQ1ZbKEI/2YS0aI9Q2727rWzwBptqXu7SbA9QX9ecp+1jqk2r03k1AeFJApM2x7dbCuJ9o+ooAVUzD6gFnmuQufinhaTfIawnnW6EF9LLD6WbWDbS5pH5Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNnCLW2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNnCLW2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4291F000E9;
	Fri, 24 Jul 2026 02:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784861338;
	bh=bAvG1aIZmBv2ttu55dq9r7XTdSPtuUJq2RF3e7KJ9H0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nNnCLW2H4bzH+mrwaHfXlQdlyLx/DkTS2wKUpzLd6yR+ysslWrD0gRxPLcAjiUE0u
	 mj8vGET73jclymwMLJkiaHbhW4963X/R/Wlj0l3zviHI/zytAqkAoKxbURNe9Z3I8F
	 +ZcoBYvfqTinmE8bNKPLzowMY8lcNAkrxJ4dEDymyv+y+b7pJuCUPISiHcHi9cNUcU
	 DmUw5mVGxAQgKkm0/fZUyBVWwg81Pf5W9Naj68l+KUunn6wWbuJTepuyUCOZm9UFKx
	 0Nl1sFoo0LImrngfpL6MHZSSTa1ve7rl0hXbpU7lAkKGuI03sDQtfZMKP2DZZYJZ8t
	 C1qsaGtChihMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: spacemit: handle regmap_test_bits() error return
Reply-To: sashiko-reviews@lists.linux.dev
To: kr494167@gmail.com
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260724024220.10113-1-kr494167@gmail.com>
References: <20260724024220.10113-1-kr494167@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 02:48:57 +0000
Message-Id: <20260724024857.CA4291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The anti-tearing retry loop in `p1_rtc_read_time()` is flawed and =
can silently accept corrupted time readings because it only compares the se=
conds byte between reads.
--

--- Patch [1]: [PATCH] rtc: spacemit: handle regmap_test_bits() error retur=
n ---
commit 8fa251c335a9b68b25f44d335129e65501d1e159
Author: Surendra Singh Chouhan <kr494167@gmail.com>

rtc: spacemit: handle regmap_test_bits() error return

This commit fixes the error handling when reading the RTC control register.
It ensures that if regmap_test_bits() returns a negative error code, that
error is propagated instead of being incorrectly treated as boolean false.

> diff --git a/drivers/rtc/rtc-spacemit-p1.c b/drivers/rtc/rtc-spacemit-p1.c
> index 43ab62494bb4b..c1820c920ba3d 100644
> --- a/drivers/rtc/rtc-spacemit-p1.c
> +++ b/drivers/rtc/rtc-spacemit-p1.c
> @@ -57,8 +57,9 @@ static int p1_rtc_read_time(struct device *dev, struct =
rtc_time *t)
>  	u8 time[6];
>  	int ret;
> =20
> -	if (!regmap_test_bits(regmap, RTC_CTRL, RTC_EN))
> -		return -EINVAL;		/* RTC is disabled */
> +	ret =3D regmap_test_bits(regmap, RTC_CTRL, RTC_EN);
> +	if (ret <=3D 0)
> +		return ret ? ret : -EINVAL;	/* RTC is disabled or error */
> =20
>  	ret =3D regmap_bulk_read(regmap, RTC_TIME, time, sizeof(time));
>  	if (ret)

[Severity: High]
This is a pre-existing issue, but does the anti-tearing retry loop in
p1_rtc_read_time() fully protect against corrupted time readings?

Looking just below this diff in p1_rtc_read_time(), the loop checks for time
tearing by only comparing the seconds byte:

	do {
		seconds =3D time[0];
		ret =3D regmap_bulk_read(regmap, RTC_TIME, time, sizeof(time));
		if (ret)
			return ret;
	} while (time[0] !=3D seconds && --count);

If a hardware time rollover occurs exactly after the seconds byte (time[0])
is read during the second regmap_bulk_read(), the read could return the
pre-rollover seconds but post-rollover minutes, hours, or days.=20

Since the seconds byte matches the previous read, the loop would incorrectly
terminate and accept the torn time array. Can this lead to corrupted time
being returned to the RTC subsystem?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724024220.1011=
3-1-kr494167@gmail.com?part=3D1
