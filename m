Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284601ABEDE
	for <linux-rtc@vger.kernel.org>; Sun,  6 Sep 2026 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788693538; cv=none; b=Az7dfDWPVb5D+getLB5IyXX2f67J++Nmtmc+YeZ1ZJa8H8z72syqxFfGtG9tuuBdaydfLD10nvwV1+mP7SWSZtDoFJ7Ex8EHqxa/RwMn+hEq11dg+B6fPjlZXFh2U/7Pe6aneoMqwP5wnFsTZfmgiNkrSSQJKcdZYqRAX4TBrTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788693538; c=relaxed/simple;
	bh=taL0hFucwvwBeXtHgz+Phya0iNPQnVIj7EgLcrMXbR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jNhPpIvLTk+1Lmox7TuYJSwsXKmpS9cOEGMuAAzyEzGrn8HRGsNIodUIu2QYQP0xyVcLvxk9UHM441yz7dwF37bcZyUo+2wcuKnmV5Ye1Y8q8GBEVPVSunpz0Of09yM6pA7Umw/s+uwwCpr+FfPr/A4coOJL3MYDffSTD5pyn3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1bT4/hm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1bT4/hm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6E01F00A3A;
	Sun,  6 Sep 2026 11:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788693536;
	bh=Xau3BSCGziruM3TRULtqftxae3nuKAX1sKi7BmwqP2A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m1bT4/hm28Bu2XXzo4OlV/gt221OlvrIKm8j2nLeNyoGqdFSUn16Py8ma0yoVcnUq
	 KXZOFqf2mSU8eFvX4TbAVVIp3dMDLqWiTuoLaKLyvyKPYxgpMN6MKjwtgRdpeqgdHp
	 CDQxytaxoIRDV0E6A1kwVxZSJ0yd5sWapRd5F6YXD2gY+d21IguUvbbW49zG0AdnQy
	 CVEgoSiOCuua/hdJWMjh6cGI7aWVYVxFnHtCGquyCAq65dbjcEsAs5M+w08dharb1y
	 CREiuKSKv6p7AmVpaEqkQrwxqJ+dJe57ASEEN0k4r9IDmKPeS/3vHNxxNfLmu04x/P
	 2iRwlU+XkNKzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: mpfs: fix unchecked devm_clk_get() error pointer
 in probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manush Prajwal" <manushprajwal555@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <6a9d4b02.7d74b517.206c4c.75f8@mx.google.com>
References: <6a9d4b02.7d74b517.206c4c.75f8@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 11:18:56 +0000
Message-Id: <20260906111856.9C6E01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> devm_clk_get(&pdev->dev, "rtcref")'s return value was passed straight
> into clk_get_rate() without checking it for an error first, unlike the
> "rtc" clock a few lines above which is correctly checked with
> IS_ERR(). clk_get_rate() only guards against a NULL clk, not an error
> pointer:
>=20
> 	if (!clk)
> 		return 0;
> 	...
> 	rate =3D clk_core_get_rate_recalc(clk->core);
>=20
> so if devm_clk_get() ever returns an error pointer here (for example
> ERR_PTR(-EPROBE_DEFER), which is the normal, expected outcome if the
> clkcfg clock-provider this RTC depends on has not registered its
> clocks yet by the time this driver probes), clk_get_rate() dereferences
> that error pointer instead of returning 0, crashing instead of letting
> probe defer.
>=20
> Capture the clock in the existing 'clk' local and check it with
> IS_ERR() before calling clk_get_rate(), matching the handling already
> used for the "rtc" clock in this same function.
>=20
> Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6a9d4b02.7d74b517.2=
06c4c.75f8@mx.google.com?part=3D1

