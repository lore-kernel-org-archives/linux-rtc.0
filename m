Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444922;
	b=kVDoEd71B3MUQdGtu+/FAV1Kbcs1FUh30MUHk9LqHDFzs+a9wHgL195FM3ccyPN/QInT
	 BzpbgNPzPXuubk3AHOzEaq/MlCA7HZQFiQ5+H7dqgYcuZcLHPGl6NPlNlJaGODhVsng2A
	 tP0G3T56qluzOALbGchff5phGBBjDQ6W5Ys6DQZk0lAv8z3/QcIGeHWbiHtEdW3J2qypG
	 ZLtamzxwGz8wB8vavpqwTkMrgJoY9aQuQapn9OO4RF7Wp2wzAiY2/zbHUIDNh9Ca7ZYyj
	 15a0hhKvkoVgD2Zi130hdSnwtQQFDjKpDS/ZNedKvW1d3rbpyJAGqmshxy/GXtdCMwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444922;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CLSSCCAzz6zT9OwWx+kUrLhBj+SUL89CW9IegMDQ1LM=;
	b=CRioMV5Qv1xAIZQ/hppb/cxSQul+6UaMV4OyisTdYJS6qZATJuIIBq238CKeWm2/pmZF
	 3ega5jWkRLZ8d3G9/zcAY0Spi1iAA9RClQp5yJ4w0C9s8+0wZP+nUVuCmQm23PRX6X4AT
	 qnAkllbqhJCfU/teve99yILEh684hJ5rtji4xThRt5IKPt6m8Ie3Wbsz4LjNr7nnC1Rrp
	 7iAk+DZbhLxcPEskEax1HyQcl4MucLLYxGHJDloUAT84vP6XYQc+TmAcIZHr37yt8BWyq
	 VMJ+091Rk9GtFhmrWmk4mHbjv/PgvurSTRQlKdOpJnHSnx++h/gJXmdk0Uv2PgDcVGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2Up9dKS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD75606A31E
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2Up9dKS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8AE1F000C4;
	Mon, 19 Oct 2026 21:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444922;
	bh=CLSSCCAzz6zT9OwWx+kUrLhBj+SUL89CW9IegMDQ1LM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D2Up9dKSG0citn+K/TvAEV1l6RIWpy2GdR+6vtspxuRvp7NXl7fbge+/iWfB8Gg0C
	 YcV+AIdKaObKdxWgzLlxJJHVyVDY2sItAsluMZOO4gKUXj6SgeGaESarRjSCZpJWHU
	 dYUsoFCYl3+xbla6LVC9Wdckp9/1FEWW64f6p4EFa0xAte3KHSOeeEgcwBym/cVnSU
	 Kaf0UmHd7Qi2PsPQ35JJhpDeGAsVHc8Um49C7A5Vbqg00EkDqnKrRhBKhS2UkHD9AX
	 fSU4dROYqmAhP34pYEtONR8hpt2DY9Dj3FTqUyR417e6N2G9bteP6IQCvqbdVv+rys
	 q2hrMB6NyegfA==
Message-ID: <sashiko-outbox-178235@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/19] rtc: ds1685: use guard
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261019211827.126262-8-alexandre.belloni@bootlin.com>
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
 <20261019211827.126262-8-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:22:01 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> Use guard() to simplify locking
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019211827.1262=
62-1-alexandre.belloni@bootlin.com?part=3D8

