Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E714925B0A2
	for <linux-rtc@vger.kernel.org>; Fri, 24 Jul 2026 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784901995; cv=none; b=KxKtYTmtxMJbSQ0c8Ziy477gW6UnNFvIJuMiKnoMar7Or+lfB9JRR0Zvldukxg4DmZz9DJQJyUfospG6O8XYH1BhVVEyNAHGNLF6Md2hWRFEF/VuCDRStxdl0uzKIe0DC1gup1TDDGMm82t5Tg0PCotHLP/opbM4F/6BYp3vtEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784901995; c=relaxed/simple;
	bh=xF++BcqLMQd1ARKwcMzkHP1FeqGXuUBzf5+K6s1ttzI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZJvVpzL7z+tGdsEvORx97HahhvOdXM7HbKiPMMnd6QetFZW54G0AZaB1hCo3qBIi1RVgq4Zdl/I9/GnJgp++Wz/j06eWWJPCR1tRzIr3D9/t38cnFNiAQbK+S3RriZuC2SLgUQ/L46QpS/MAn5AixrM14Gr320ukbzPGVh5MpRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPqlKv98; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPqlKv98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FED41F000E9;
	Fri, 24 Jul 2026 14:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784901993;
	bh=aFdnaExgQ2PlkI4AMOUdCPPqovMGNBRi6Lec6DGl+V0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XPqlKv98OnsP0ynQEAKXDW1cDiqXWMRoDHsVzsnlBmcg+PVGFTzfdUl8+GPcQHMo6
	 /sgUwRZVnyYDB6TcGPNWAEPpvU6B6IDlzgT/kizUj2907pBFOoJK1v7aY1TdpSTt4M
	 9O/EJCrolp6Jm9cg/DQqLkyiswNUWK76idHxhrYdBH50pzjxn9XNtV+FUqMUEa3YpY
	 ccMiVR0/zlF0J7iLrBjk/E35ZhhFdUtqaxs+CeDMKvskwBd+e3t5mMEaBi8xiK20MB
	 YoHL3SwKAXYeLZM3ifwNg8ldjfepiK3SrTcDVlaK2DFv+3fdffOmnYDMpFMEaSJk76
	 FYU5CcqWzgw8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rtc: spacemit: handle regmap_test_bits() error
 return
Reply-To: sashiko-reviews@lists.linux.dev
To: kr494167@gmail.com
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260724135803.81223-1-kr494167@gmail.com>
References: <20260724135803.81223-1-kr494167@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 14:06:33 +0000
Message-Id: <20260724140633.8FED41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The RTC time read retry loop in `p1_rtc_read_time` is vulnerable t=
o a torn read (time corruption) if a time roll-over occurs during the regis=
ter read.
--

--- Patch [1]: [PATCH v2] rtc: spacemit: handle regmap_test_bits() error re=
turn ---
commit a044092d776fab1e96ae2f8b48ace64aa0ab2325
Author: Surendra Singh Chouhan <kr494167@gmail.com>

rtc: spacemit: handle regmap_test_bits() error return

p1_rtc_read_time() called if (!regmap_test_bits(regmap, RTC_CTRL, RTC_EN))
to check if the RTC was enabled. This evaluates negative error codes as
boolean false, causing read failures to be ignored. Fix this by capturing
the return value of regmap_test_bits() and returning the error code.

> diff --git a/drivers/rtc/rtc-spacemit-p1.c b/drivers/rtc/rtc-spacemit-p1.c
> index 43ab62494bb4b..1de7bd995d296 100644
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
> +		return ret ?: -EINVAL;	/* RTC is disabled or error */
> =20
>  	ret =3D regmap_bulk_read(regmap, RTC_TIME, time, sizeof(time));
>  	if (ret)
>  		return ret;
> =20
>  	do {
>  		seconds =3D time[0];
>  		ret =3D regmap_bulk_read(regmap, RTC_TIME, time, sizeof(time));
>  		if (ret)
>  			return ret;
>  	} while (time[0] !=3D seconds && --count);

[Severity: High]
This is a pre-existing issue, but does this loop correctly detect time
roll-overs that happen during the read?

If a time roll-over occurs during the second regmap_bulk_read() in
p1_rtc_read_time(), specifically after reading time[0] (seconds) but before
reading higher units, time[0] will match the seconds from the previous read.

This would cause the loop to terminate early and accept the newly read time
array.

Could this return a torn time from the RTC (for example, 14:00:59 instead of
13:59:59 or 14:00:00)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724135803.8122=
3-1-kr494167@gmail.com?part=3D1
