Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B00E3DDDD9
	for <linux-rtc@vger.kernel.org>; Thu,  8 Oct 2026 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791443997; cv=none; b=RWJc3bAF9UIR48mkvTnb3/onTscR6cyY0UeBm/8fsFZWfktLhKmkdfpdP4eW3yL5bTt1Pu0KW0zse6Ldx3HhwsDJy7INYaXs/5zfBytN/aLgXg1hNoZWJHqTLzMizPLsRXVvR5rFtyLGgBvcxZBhjX3F1mVDK+/gO4bVpajrR/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791443997; c=relaxed/simple;
	bh=s5t3Z8KcBm2BEEUouLl3L8RHyg/8WrxUZjWRUcQzudY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=sqFz2+U48mGG6ifo8gAdGlmUNK+m7Ki7ZFQ2s0aDrJVf0TNGvS0jDapjKEcoJjMJ4vlH9V/a24H3I9Yy9txZRAnpY6WHe6HBDuk9mDZAmmwfipIDRYkL8EM1ilFynmUySrm9srO+4t/EdXRsLagEeWYDONqeANKamngil9YGjhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hP26kn8J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hP26kn8J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3701F000FF;
	Thu,  8 Oct 2026 07:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791443993;
	bh=s5t3Z8KcBm2BEEUouLl3L8RHyg/8WrxUZjWRUcQzudY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hP26kn8JsTYfJFjNqC90FKXouMLLZs8asKgoMT4aPxd9nw0P4kBqgx3rSq6Fe9aJx
	 SyscRNXfP6zMd7zsrhFF1IdhMEH5WsCKxbv4hH1rq9Ze3YQWjLzCj3HSFPGDxQTXAi
	 qgrXd82zvvBmgNhHHyh63YVfpGUTiUWKCGEfDQoOvqvxArUYZ7slcTSBNGSx+xYsX3
	 DMzaQVAfUVpx9mhnraUKa7boHLwIEpeyBlnyx6pbaZM3IwIOJ1qSm7oMmoNtjD5gbR
	 AoDxugSg/8FNLTMpo58+TH/DNnn+LL0nrPhg5HVGdkDMS7m3LWA8UnrlhKoO6ppcJi
	 /bccg6GcKLVEg==
Message-ID: <sashiko-outbox-163744@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rtc: pcf8563: add SMBus support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Walle" <mwalle@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261008071408.3548442-1-mwalle@kernel.org>
References: <20261008071408.3548442-1-mwalle@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 07:19:53 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Since commit 00f1bb9b8486 ("rtc: pcf8563: Switch to regmap") the driver
> uses regmap to access the RTC. Regmap itself will figure out if there is
> a suitable I2C or SMBus host controllers. Thus, don't restict the driver
> to just I2C controllers and make it work on SMBus controllers supporting
> i2c block accesses, too.
>=20
> This was tested on a custom x86 board.
>=20
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008071408.3548=
442-1-mwalle@kernel.org?part=3D1

