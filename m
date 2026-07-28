Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133A2224AF9
	for <linux-rtc@vger.kernel.org>; Tue, 28 Jul 2026 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200502; cv=none; b=p1EMY8/GQtLEd7jd/IjIJbkeXe0q53QEacxB0B7Izv1jI53AgwuecL1B0xQbX0FgAYlrs1yCrRLHWqFKGHmhESOnT6uiFYfL2C6zDsvvj5U4Jme0K7duugKHYQTVPyAbB0/eeKsfBe/W677Vzyaa6m+mPYluRbdXR/qXnEs83d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200502; c=relaxed/simple;
	bh=rlFSjW3Y5Es4qgPq8Ara/6CET6aAWyWjHgJiKmGKEcQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kSAXTPaMq2BHLgsoR1Nxf89w0aJPacbDN6n41z9ZSjiIXjsMm0gdHwOuOi6HRxuzzgQ0Jx6Dn+Jy3bZHe/f1iG6GCc6cJRDB++hp7vAk1zFDCa0hLAIHLPKuLwBDZPKptnbgDBLRqXDoRdVkhfx9JC1G/M2koTjZrg1aBSkTlGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpOsT5FL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpOsT5FL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60B01F000E9;
	Tue, 28 Jul 2026 01:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785200500;
	bh=rlFSjW3Y5Es4qgPq8Ara/6CET6aAWyWjHgJiKmGKEcQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bpOsT5FL6FrqZmbuKba/J1AfCj+/u1gOMd6kJB20l80zD4f91bj9XEfSB73dUZvwC
	 eYROtQ4BIPJ/rOFc2NsKmcAj6D+qjlDM2qhNtFTHHO9NUGdxJ5eQbfMGjtPBl4331F
	 8esy0rrMT93F6A7ybfQifLPSEdKJqXjb7xvKcsr2EzU6FWABMlAWfzMTChD7ioJeDP
	 1Is7Ad9nvbAwQkNRz05IC7Ym9SqijdcCL5aEG9jR1NVsZVQEEZI7v2SzE4NRLpSbJj
	 qLesyNQJqYE8lhnM9nR2aaR+aoh/PMVJDEJ8LBuqratvwlIQJpMn+daSz0Se7lAVyZ
	 PiuDeIjsZJoZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: msm6242: use devm_platform_ioremap_resource()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260728005610.575268-1-rosenp@gmail.com>
References: <20260728005610.575268-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 01:01:40 +0000
Message-Id: <20260728010140.A60B01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Replace the open-coded platform_get_resource() plus devm_ioremap()
> sequence with a single devm_platform_ioremap_resource() call, which folds
> the resource lookup and mapping into one step and returns an ERR_PTR on
> failure, checked with IS_ERR() and propagated via PTR_ERR().
>=20
> The rtc-msm6242 platform device (arch/m68k/amiga/platform.c) provides a
> single IORESOURCE_MEM window (0x00dc0000-0x00dcffff). It shares that
> resource definition with rtc-rp5c01, but the two are registered under the
> mutually exclusive A2000_CLK and A3000_CLK hardware flags, so only one
> RTC device exists on a given machine. The region reservation now
> performed by devm_platform_ioremap_resource() therefore introduces no
> conflict.
>=20
> Assisted-by: opencode:hy3-free
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728005610.5752=
68-1-rosenp@gmail.com?part=3D1

