Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761235;
	b=qF3hpS7gmqCHV0MILmhZnNYnzpzmKox7DwjeZBgTvS2V5NYCyw/6K4mfs1PAjp/GT/zv
	 dLZCWEXYdt5qDj/CfcxXxzWug6xYdz16Qh6sAL5j6eqCEmoNRAcFgYvOlwcInLeg0UoDd
	 AaP322g9GURr5QRyTIbvoLMJvoU4WaCX14OyGAeRhXE10kCAU9v30ZW0cnR0oeII1XDlD
	 zN39ryw5xxeVnG9FuHVQfgoFrKDJJYAKSwWGrXHIRVnXM1uahWorr1cVT3f1vrf24gEm0
	 eFmNdAkqm6c3kR5oEeY1uCNy6Qvj/6T8FTo77EfcAuNHElLt3RMU0VD+3muFhdblnAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761235;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K3jQu612H9ajMeymQpq8vjRgBwEgizibj3qAd22kGPo=;
	b=S4C3bls8/95lHqnFqUUlRNi7ZT51ZXPT/yy25WiL2kgiZVCloX4/6ghS61WRgqiuQkCZ
	 dhB1JTMi7XZn2MGN2ZWPgTxkZVKb22GD3HwrXiRsSO0TSqQfmPAjhB+W5sXjbCtLqGdpD
	 G7N9GxDlNqzUPdpGCK/OCNhwnHkcOm1QhvVjvo+zcC4ZFZ3bCyjEPyv2NpJMlp8gUVseL
	 andDz0HIvrvrIMhxQaMh7rhqZ5+kCct7F8H9kJcOiyvirWetRC7mIxoVh8JjxPAZJ/xRA
	 sZINQaRv6HSRZJuq9Vy0HMQgcOsq3/z+erAlgCs43efyR0tzdP/ToQtQ3rkZuFfkijQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hjWJ2gif;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC56606A329
	for <linux-rtc@vger.kernel.org>; Wed,  4 Nov 2026 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hjWJ2gif
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40ABB1F00919;
	Wed,  4 Nov 2026 03:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761235;
	bh=K3jQu612H9ajMeymQpq8vjRgBwEgizibj3qAd22kGPo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hjWJ2gifgwXdf69DOTcyjkDgL1tSM8MnBRj9WyfYXbBjbLWgVLx6vussHlBYgQph8
	 M+DsbK6+vc7d+7D2D91bYAR20cRJidrCWdOf5x6gXkSEsnb1oqgpS9b5uQUYL9iEik
	 ZhfCH5TBKvS+THazG7QM9Er2bc/Lgs2rrQOn7/bSkcLZ+t+IBsFDGcXL/R8fldm/a9
	 X9O3moxL0ow9GJ/aZ6B61lvQnhDFe01tPndZxzmu086iKvf67ySKG5K5+gl06/g0ge
	 4w3FuqfmxZiYRElyWdRhvuv0ULPZ+oTdxKrl16AIAxUxKc4XUXSxVL5EmSTMo9FWN4
	 ooA95D/J7LOpA==
Message-ID: <sashiko-outbox-196559@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: ma35d1: release the clock reference on probe
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261104025339.1527356-1-vulab@iscas.ac.cn>
References: <20261104025339.1527356-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:00:34 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> ma35d1_rtc_probe() gets the RTC clock with of_clk_get() and enables it
> with clk_prepare_enable(). The clock reference is never dropped and the
> clock is never disabled, not on the many later error returns and not on
> success either, since the driver has no remove callback. The reference
> and the enabled clock are leaked for every probe attempt.
>=20
> Use devm_clk_get_enabled(), which ties both the reference and the
> enabled state to the device lifetime.
>=20
> Fixes: dc0684adf3b6 ("rtc: Add driver for Nuvoton ma35d1 rtc controller")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104025339.1527=
356-1-vulab@iscas.ac.cn?part=3D1

