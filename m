Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528031;
	b=i4n/i6xbvXz9eOJDpXjGxzqNTSWmh7OXVUtxjyDLx1MO4QBtxoUHnAkA8OEark2GYJbT
	 FX8JkLZmwjIcdaH1+rzKE7BncTjUveVSmFrMl4irV59ZYR6ZGvCtHQhVtSxDO44Xbsdp9
	 kC+a/RgQhFoIAPcNoBtSfpM8XiRK28P/w4RaXByuvOpSPayfBEx9P3zz4EbgRXnJb7rrM
	 aby6Fio64WJpA43Dyh86sjXbnJVCcIc206BYCal7bR9ngrktKya9kDlDUrhW8A0La6UCT
	 cJ+/gmHvilT7aYsKa2JvAO4LPDEbSXvHrn4Zrv25C6l6LWq7srrf2XiOcbhJRQmKJ1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528031;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UfGYSinG+gdaWBF8N5o718wNXROm7MPNi8myAJloip8=;
	b=HDusvWrkGOizYoILRxEYi5n70Al1XsAnHBjAvXEWvgNqoUV9nOahCv0OSo95Lcp02BF2
	 gQFtrPUzPEF+hi2ALs0JBc+QSmI0BZKVbkXfYMqtE4wROazi4MGL7Wm9U9Jhjwi+Wrgoh
	 B9662VDiRvBOV3aDDFe657eQ9U+sV2W2Q/h3yW7NY77i1luMx1LmChBiPGoU3NNewx3C9
	 UYp6uFWFk2kWuU2XK48GU+UqAQeA1JHsM+ljrrxoxGvAe1FjO4xsF674uUa+zgKd3qPAI
	 TTQWsDbYA6RDf+g1Z+ZLY3+J/rYll2eee2cJDrqGXECac7vHXBPppgioLFOF5ui7W+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fUNBZo6w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF29D606A326
	for <linux-rtc@vger.kernel.org>; Tue, 24 Nov 2026 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fUNBZo6w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529441F000C6;
	Tue, 24 Nov 2026 13:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795528031;
	bh=UfGYSinG+gdaWBF8N5o718wNXROm7MPNi8myAJloip8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fUNBZo6wuvvLTtfl6/GM91+OsKDgeozagp1zmCtMLbJ6tdAzmoUetcETHSK3Hn+na
	 sL9ipUqolUPfRm5xk7a0PZgoihLNruDR9ZJDpzm6ByTh257463zo1LluwdmzvKwron
	 U4qdecPsmKSjPlNTsAqYR8hVqKhiEBMYp1qkPVtTrIwU4OOXQZo2Y9epBJoBWn5WAO
	 byXnt1E9KDlUoIwPxTjJhjSod00oX78Ae9P1Jgkt8W5Ph5jhDHOpQ2ZsEduvGaJucD
	 9vok12v+n9ba4FjwdCzxBYu2Cjr7YKRhxqX92+2qnqDSR1sJu2pbIvOTcMhe+dUtTy
	 QwJHyvenlxngA==
Message-ID: <sashiko-outbox-231249@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: sd3078: Fix BCD encoding of the month
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261124134309.237707-2-blum@kernel.org>
References: <20261124134309.237707-2-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 13:47:10 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> The SD3078 expects a one-based month encoded as BCD, while tm_mon is
> zero-based. Adding 1 after converting tm_mon to BCD incorrectly encodes
> October as 0x0a instead of 0x10.
>=20
> Add 1 to tm_mon before converting it to BCD.
>=20
> Fixes: 1d67a232105b ("rtc: sd3078: new driver.")
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124134309.2377=
07-2-blum@kernel.org?part=3D1
