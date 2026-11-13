Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609384;
	b=dXWbKL64cK3z4WF5F3VKGpTcuLSQvCr0iarPpPoyKzd06+HaX9ikSdkZgwtybUhHmFfi
	 116n3eJdUB4saNqJEjAE2w7iasIWUENaNyl2vFB1GlH+zR3mt+pwV/OJX+UMx9EO8NqhE
	 c8kRRQxNyUXlcVNGclP/ZIxP0xFiL2mRJm6WCod6WrzddeBBwYkDaYy7lSSD/r7gjMKg/
	 Ylb3I8QvjreYsoLWszWELFQfJNKqZFAaC+YAyJ0rBIPqFpWu2m7RNZc6O/TV5GAP3W+r8
	 mhfTOFBT0UXHVXqkbEDv9Dn9t2ST33QQUew4gADzwvd+J5g18EW9Ir+2mY9cO584KKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609384;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TJyAec8hW4umr1rcbDjg1BeFoEsWbty+WimQ3jgRSrQ=;
	b=tgEFNNH6NAP+CSXc9hx5U1vWWyEEHlUUOQSUKgPSWWt+bR8qJ4h+lRmF8euz3WAXJ917
	 0snHGcBK5cORrKpnX7wjpHqUQvZkNlcc4HLYF8QPWSTa7/EBQa4NYAXC/B0os33YhSXHC
	 hf6cX8WAtYp1T7Jk6UYzQs2Xev8hiBCtlfvWFnDPLesYlG51DsNlsDmsiYR5lhKJIcxT/
	 hAruFKxhQzaGIWJWSRWDTq3YNsoP6kY0FG0ucBBcEr80z9LwRW8jAQvLU9dCbfhvMwOmj
	 pEEfubdcPlstME1S977zx7XiJHdt2gyd26rXurUePZ9PU8avWlWNGVXgTdyI5Ko4r6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QeQ7IvMl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23D0606A32D
	for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QeQ7IvMl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3F21F000C4;
	Fri, 13 Nov 2026 22:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609384;
	bh=TJyAec8hW4umr1rcbDjg1BeFoEsWbty+WimQ3jgRSrQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QeQ7IvMl4IJNHmmiKC0a7gUIrHK02TiV0YEUq+gJ6WRRXE4Iv1AuP3Yyy3Eyb+fHP
	 KZB42+FFreruO0W2eV9ZjUMzAfnw2URcYELoVgteydSu5ITzt7FpvYVCLW1esSA3Z9
	 485389HeAA/Wg2yPZh+powT4jdobz9B1S2OYBymZ2wbAgAiiEDvPLJnk7xRjPgvXfs
	 0m0HgDshUh+/TGLQbrvAUDnBCCsmuy3SQMaZYYz67J7wIDVTV2pxgeR48mb4bWoZR9
	 pFTvaxDIa/tH5OTaY53WN+grz8XGtDVs5Feu4+NXSWQuTLMxm1NetD9JehUbp71heP
	 V/gk5oag4OIrA==
Message-ID: <sashiko-outbox-213819@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/19] riscv: sunxi: describe the wider Allwinner SoC
 family
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261114-v861-v1-1-eb71ec3ee523@iscas.ac.cn>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-1-eb71ec3ee523@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:36:23 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> ARCH_SUNXI is about to cover the V861 as well. Update its prompt and
> help text instead of adding another option.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-v861-v1-0-=
eb71ec3ee523@iscas.ac.cn?part=3D1

