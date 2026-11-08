Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794173801;
	b=rAuuYVT1RUE6qdI9cO495mNoBGHm+7HZU9l7BZLq4GOZH+k1S+EQRrjjrfUzn0efWosY
	 Iedf2L0CYXpO93oeWL5jYbb+R8jAlHilLSr4XJR6OfCcbmtwXN7XA7u8N65+8zK027ZId
	 VCr9IjsuajTaXJXtg8uulcR75YJZgBBQFfJkvKzuZ0Ptpd69SK5yDoga/UYoFghzArHKr
	 mDb2ORDDklUwPx7QzzyJavlnLKtFPPhpfqhsxWtkkweCGnDq6Si952ZZTdyvcrvG9+c0z
	 Dvpp53yRKFm/EaiLxzNB5/ur00MHgaAdyBGDahIv3FEOtI7HjhED61pQsd35Ut7c0dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794173801;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=egfl87lfIsLqS7mixGpwXbC+W9xzWtdKLS2j6FORViE=;
	b=iWDrM5ohS0EwMdrP6toDczGcC4Sf9AQpCB87Bqdct+yGtKvlGx+oIrn/mESOQRy2dP0O
	 Q8nYvDR5SrJ+5Z3/5e8zIsiSAYv5lfzIGULR6blffkT5aiX0xMnBgRBJUgOnJdaq4VBGk
	 2G9npa4AnyiIL/OXZ93DbmQwLOzfM9f3nSTeCEaF2Jeo9Ze4gNx+5u4BLv+Z3VM8eRjm2
	 jstUA1mSZa1ffn92IeL1QEXsJKJmfJ6eAM5cH1yzORn+VyGVgf+dwlqCa7Ds+y/l8sU2s
	 VgVMAQzy0X1AFnL/fS7wpUcYKb1lqul9ysV6V7IU9iYRIvX2XRc4U5iUTmdLZE1SWmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QYX8867m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB13606A31C
	for <linux-rtc@vger.kernel.org>; Sun,  8 Nov 2026 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QYX8867m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427F21F0089F;
	Sun,  8 Nov 2026 21:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794173801;
	bh=egfl87lfIsLqS7mixGpwXbC+W9xzWtdKLS2j6FORViE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QYX8867mGsMzuLFZC4rStMnTmNwo721jlwWNuxa+Gfq0HOs+ey6Mkgrbmpz9YRZzv
	 /IfJX9Ss6VJ69y1KgBrYv7N0RqolOQrhuuRKBqJ6juG81wLmI9Gv8kslJVacZiB1y3
	 605mDiC9NcpJoOG+lWg/VDtSaf+K+5TNDbhzQr+6gmt5iYtbIpDE6LL2hXcpNXrI/A
	 ak3P4A8M5N3d89oDC08FkA5o4BImyWAEiM1lQwg0h1TiSUWxXj8PohI+kRTdyotZvY
	 cFut5vuH+uGTypVKbrzAF0dPs5WgpFn8MGVBrl6NdDDUkv9Q0/p6qhioDIah4yFT5F
	 70Rz/wx8wADRA==
Message-ID: <sashiko-outbox-204085@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] rtc: Add StarFive JH7110 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?T3dlbiBPJ0hlaGly?= <oo.hehir@gmail.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261108212826.15890-3-oo.hehir@gmail.com>
References: <20261108212826.15890-1-oo.hehir@gmail.com>
 <20261108212826.15890-3-oo.hehir@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 21:36:40 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: "ziv.xu" <ziv.xu@starfivetech.com>
>=20
> Add a driver for the RTC in the always-on domain of the StarFive JH7110
> SoC. It supports time, alarm with wakeup, and the frequency offset.
>=20
> Signed-off-by: ziv.xu <ziv.xu@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> [Owen: rework of the StarFive vendor driver for mainline: drop hardware
>  calibration & the default time set in probe, use the generic wake IRQ
>  helpers, wait for the update bit in set_time, re-read a time that rolls
>  over during the read, round the offset to the nearest step & follow the
>  sysfs offset sign, enable the 32k counter clock]
> Co-developed-by: Owen O'Hehir <oo.hehir@gmail.com>
> Signed-off-by: Owen O'Hehir <oo.hehir@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108212826.1589=
0-1-oo.hehir@gmail.com?part=3D2

