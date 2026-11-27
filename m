Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795780110;
	b=iCcRmq25H8vZ8jG+83ZLoQ6NB7OaIA1q1R/1AwqfrTlykno/coExy3TyXc+AyJ4zLkEB
	 tdqVEMbfVPEjusOLE6N5Xicb2CuoaLYzVlcMRb/LOrpP1Y4ivyWK3khh0vv+VwqW21h5f
	 qPi3kjRXO0YhCLNKdAHaM6EkaDVOSgCpCAfNBMNh4davoHWVbTdWXFYjcNhVkPUkAJ+aB
	 8kpY/MiJpf9DyQu1U39Wf9NprcFyFQMLSLatQP6bvjfu2+MInbwA1CBJ95jPqRRra0bkU
	 ZGxuMlXbpPHCShlrX6r+wg2JJOsdC3SU5QcJX+MhVFYNs8VpJQ798u6uYt8YNKuoqrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780110;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Fhs9wDSoAfEXCvjWlKkCivDQPD7qYW8ufxXoDfuD6UI=;
	b=R9b68tDV0dOo71Rtc3AOl28SKxn1swZU3xEgKx/VbbA/xUDG6IQpK0ByxqV/zCUKulF4
	 XMqbwJ8uqhLzLIoWdfcOWt5C7TMGT0je+xMJTBBREbQm63nq16waPI/bXov078kOMenXg
	 hahWA4aS7frZWSyVJVzfoUYUOEZhgI0h87dVbzH1exHXq/n+dbK1sD2AQ7Tm4Y6BC52Gv
	 rhPtGcoIhEHcXnrMX6RWxsMMVvO4sZqKKbnC7OKaISZ9rNdcVAYszDEcwAYbyD50AXmDw
	 P6l3RiZRJukDrkgYjQmivec7UXHhaVsTgrxQS3smug3ibSmWpvO04HG1LhOeLsj6PyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJRJcSvt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E2A606A32D
	for <linux-rtc@vger.kernel.org>; Fri, 27 Nov 2026 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJRJcSvt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6704C1F00897;
	Fri, 27 Nov 2026 11:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795780110;
	bh=Fhs9wDSoAfEXCvjWlKkCivDQPD7qYW8ufxXoDfuD6UI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SJRJcSvtxf/bmD6gA4tr2KnWxNNoPcLFsNdpkXxGub9He/SvRzYoks8q9EJ/w1BYv
	 IVVLB3B19BmHn0ej9By4JlkmT/VlxyC0mlBDjeoLS1H7y3GaqwRD+XvNHMIcWMY0yX
	 pso2Yy793CpYOJImQFOOgw+0imY9EQOSd/LoGTj9HCTJE/RPwYVo6prmlTe+3ehwiN
	 e+dYSzDieS6GA5yx0KHdxvC6jJNtxE9htC6x8wG2zI6C4sIPNXQdop/FuXSaCLojOz
	 MDgupN8//SXMeEWIySbtDLmQwC0ASsYAZjFTYrj/fH4iwbWcuQ9XJpht4yMZmAh6Kv
	 73+Uxwskl0SAQ==
Message-ID: <sashiko-outbox-237288@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: jz4740: Register the power-off handler with devres
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tian Xuechen" <202300460064@mail.sdu.edu.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261127113337.390592-1-202300460064@mail.sdu.edu.cn>
References: <20261127113337.390592-1-202300460064@mail.sdu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 11:48:29 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Tian Xuechen <202300460064@mail.sdu.edu.cn>
>=20
> A clock registration failure or driver removal leaves the power-off
> callback pointing at the old RTC. Register a managed handler with
> the device as its callback argument.
>=20
> This issue was found by our static analysis tool under development.
>=20
> Fixes: f9eb69d1ae2f ("rtc: jz4740: Add support for acting as the system p=
ower controller")
> Signed-off-by: Tian Xuechen <202300460064@mail.sdu.edu.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127113337.3905=
92-1-202300460064@mail.sdu.edu.cn?part=3D1
