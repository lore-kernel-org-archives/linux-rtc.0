Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793625035;
	b=V1jhhu8LTYaYD5TmTg7Wh9uY+qiRkBSTnn4LmWPz9sxqRDp9Q78T5VuhLMIsXeoB/af6
	 6sM6zaJtMk63HjmqfVlp5ezL91ByPLoHAd8bmJZCox8eK7zaQrSJ/LRcCr2d/4RRDg7ga
	 9KRRG72BHpvBQas6gwN9RrUxm3vcTPcwop7IHe1uUwA8bRr2UKbWlpCUwwR95V1Qn0A0g
	 VQ4ky+Z5iIYTXZFXy0wwf/1YfE7SNruaQ07O0HYKMXXTGBhXifb7zsU3nkDh4l/rMe94b
	 rqUrA3p5ZQurjDGDypC9rz9/o3f5g7D20GkDNcwepGLR5Dj69YveO9S217Kggmftsrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625035;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lxvOgEDWBaEmyr7J4ifo7meCxuKiICNCy2oGfSS4700=;
	b=BSiBzMqt8uDkUEQ8u2w3QjStd3ZT1x7lEDi4eQ07cTwnYsf1TRTqyvYm6jqrzDdxRWXC
	 aAtU9PaVfu/63kzj6Gz4c+cu94m5ixi/0zJvq5mHNV1elUDim9VME0fyvCxVMc9Vta8/N
	 1Wuy6SvYmHT36zCtcCag4dmJZ9aqyzgGKkfE7nc784k1iHgbzOMsTyfwJJ0oWa8FjA1f7
	 9eL18+xT9DvJ7WeSFW1htGj2k2+T85sn6qpUuVO3x4MkVvfEchn1vCR7MR6ZcoPCk6hR5
	 FuNgX+EytZLTT6jG22TuLZIrPT9VyxJDslFrzBXKCGG66lxM4OVjjnNUQTknXfSgoig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mxAZenF8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16762606A324
	for <linux-rtc@vger.kernel.org>; Mon,  2 Nov 2026 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mxAZenF8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4821F00A16;
	Mon,  2 Nov 2026 13:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793625034;
	bh=lxvOgEDWBaEmyr7J4ifo7meCxuKiICNCy2oGfSS4700=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mxAZenF8wSS+p24r7fMilouEjV5bKJoAnnnbcDUyLoYxr44VC1brXVjLua9xfCwEf
	 cwsdCRtN5r/UuYT+BxNHslnJy2snPZ5bf9aP12k7aj4E8tjJvEddqcdEGCWhztKhH3
	 q5b2mMWr8+Fomp5dDwc43MVTghm+vM6H8gaKDhy5rGnqrIprun01NZreSoHAtofXgX
	 eDvDMNxF6rr96nimhC3YUM2qS1RYmze+PBJqVOMuNcHc7Y0Modi70vKUO4shdpfQUA
	 wT/Uk4ybSTonhRdvEojL3HKaPD/Ii95CSU82ZV15M2RB7NO36IfOnVHsC+p6FI4Ilv
	 lESeYr2qmmXEg==
Message-ID: <sashiko-outbox-193468@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] rtc: pcf2127: Disable the 100th counter for PCF2131
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261102130712.25104-4-herve.codina@bootlin.com>
References: <20261102130712.25104-1-herve.codina@bootlin.com>
 <20261102130712.25104-4-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 13:10:34 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> The PCF2131 has a 100th counter. This counter is enabled by default but
> 100th seconds values are not used in the RTC subsystem.
>=20
> In order to save energy when the PCF2131 is powered by its battery,
> disable this counter.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102130712.2510=
4-1-herve.codina@bootlin.com?part=3D3

