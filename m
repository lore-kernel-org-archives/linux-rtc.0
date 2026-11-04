Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776188;
	b=z9eIpRvgWRNPXMNzbaa/ZrI4jb1uYEW4FE5hUhpB6YkKk/bpne2xmECJgozfpMppbk3G
	 SHfzAcmpKWXdBNLcaQ1aTSx5UQ0fzHI48XUauCdIUHJ5WLt0P5ft7Aanhi9LtaEU1o8E0
	 RX/LUzqAHc3EZbVynEeK6VXfv5nZh48h1eY8on0VXeyr+yT5QoFfT/gZw1K0FDBZ9pRwl
	 n5hSevyqRj+QJUmyYlt0R/ate9aIcHFngqPiJgFAXtx20VBnJ4w/K5Si60+xTQBIxmL3K
	 eJAPYkozP17+R42tc+WUAhFATjcAkyf1NF4P/uxSOHTMp+T7t8nlWUz6f3PhljI/ASQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776188;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=53pbC/U0rhiWGlhOmfBUEZjuy+0ABq7Anh+NSDlPh8I=;
	b=0osCRceUZQT2H2mImL0xpmw/zXT5iKsxE5YmGVqh46Rf2Vq+/sj6GoCdVJj2H+lawNQw
	 B+46N+oXseCchY0WGUs9mYZac07oQ0Q36d2+8kbgdhF5QlFd9yBveAkBWegRocXUS5huF
	 2409byv6wKBL+KsH6nfjFjxDFho7HKqUh6qWQqkARBNur83b4JU/f7Ba7cr7m0Okl35sq
	 JvXK2OuZa0ZJy5c6jFo2xPu6dNMcFE/GYXMO8207iTntbrN8qVTxucHldRZdDM6UlnlC6
	 sXTjrwi6i0AkRctVRk0zv2yY0OKs3emW+UvizgvJNO/RQ/6mNaMoLJkNcDbx6MK16zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CBnFhgWq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000A0606A326
	for <linux-rtc@vger.kernel.org>; Wed,  4 Nov 2026 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CBnFhgWq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7361F000C1;
	Wed,  4 Nov 2026 07:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776187;
	bh=53pbC/U0rhiWGlhOmfBUEZjuy+0ABq7Anh+NSDlPh8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CBnFhgWq1HWvT09kDZSbhOL63XUJTtTLg7JV3AAOICZMqkJnErZYgVVOYcrvfQa6i
	 iepjiakTZUAHyVfwv10WTiare4khBTEI23EuRC6KBVTV7x77inaSoZJoE0FuHyDFn3
	 zUKtX704QzhcXizARBthfFcoJ6yXr4jg0VSguSBSqs9YU45saQCeGQ4IbIzj5nKkiF
	 CPrGYB1F53TOQXIqPJaz6lFs5B5sSe4b9H0KijmRxolb6clLnngBh4+cq4H99el0wU
	 gX36prvdY0RwNBnc4/EpZtlsFUzNdrDE3Yvr6mpaMIdHV00Ak/lr4bEG6jbH5r6Fxh
	 3/ZOJtAW38EqA==
Message-ID: <sashiko-outbox-196778@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] platform/surface: aggregator_registry: Add support
 for Surface Pro X
Reply-To: sashiko-reviews@lists.linux.dev
To: "Val Packett" <val@packett.cool>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261104070441.74127-6-val@packett.cool>
References: <20261104070441.74127-1-val@packett.cool>
 <20261104070441.74127-6-val@packett.cool>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 07:09:47 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Maximilian Luz <luzmaximilian@gmail.com>
>=20
> Add SAM client device nodes for the Surface Pro X.
>=20
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> Signed-off-by: Val Packett <val@packett.cool>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104070441.7412=
7-1-val@packett.cool?part=3D5

