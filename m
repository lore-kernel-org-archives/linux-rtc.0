Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991867;
	b=l6yjhSOvkMYgwwX0NbVTojR7ztL3oX7pM2hxdDNe08D44y1NVJ2xaaibwQc1fbaPezcB
	 76foS4XFYXdI2vJv7Cm4GCOxpAdjIL5Vxvgf/OfGPb6rsr9aiIbe0Jj7mB4l8gjoJYHJw
	 MVdnDrtxqzeaQoBnALxMgJIhxzvP6i2FT7DpaeXym2I4bXVHjDXDDYBUJ2vpA0Oysfvz4
	 bgDrMGueeNfWjQ3g2Wixxetc72JRKHYHegyDR3YXq02XXkySSl16w2uI9UNEsxwAnh0aw
	 S12nDOQbMb2xY2tVANK48399fG+DkBr44CO1h4z6gK/EMh4wRaN+2NVTA3mqs6d946g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991867;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Wk4b7YCq1VZeEWCgYwEX7nuNQxB/A+/em91DkDEhtyA=;
	b=rJHHubBO6zl2j3ZanfUOK9zilh0kUxMkAHVwNqHwWZ2Z7UenIwqpfCVrNiyznsaQG6UJ
	 ceHA8Q+13Aol19ojZayOlA23R11f/qUoWGCZtvmyA9pcJKkbI3GsBdyxi4j9nE1bo01GI
	 FoviW6eCsNQomhyPLH8cjCPQSSqlkoXmSkQmJ1o789VT92KTaM7gMMww8K3rNIzKcF9Q+
	 ERSeC/qNXgkyiXEiNUzGtjnYtw95T32n7Zh1jeavSv/Eug1GVlSp+TaIK9hsJTx//z0Fg
	 LaHyWsk0IjDGhruoW58BeBY34V9cDSgnVrFTCtiIwZqbJZT6Yfp8S++JR1yJ+pVogRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OpUyBcrC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE78606A880
	for <linux-rtc@vger.kernel.org>; Wed, 18 Nov 2026 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OpUyBcrC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8591F000C8;
	Wed, 18 Nov 2026 08:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991867;
	bh=Wk4b7YCq1VZeEWCgYwEX7nuNQxB/A+/em91DkDEhtyA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OpUyBcrCiWW57Wq/1gJrYXex39G9VSf7N8mvXhjKpKr1iMQFOAUg+8jlHl3WA99Zr
	 FPrL5SZEaEJCt/YQWinqGcw9NKpwRVQV1J78NfHD7XvvTkS6WIZF5J5+3FIaZCSO3v
	 BTnQsG2d7DrB7AO49Od7YVSSrVBScQPOtsDb32N+on7Rgt/HqE8oiIto3/XEzRrSSK
	 kFunBOmEowEs2CPm/gv23q1J+rGHyHoj3UP+1CyuhbGDaACqh9uWLM4OXNV9jG/1rf
	 AsPntfJX00X+HUAhA2Y5OdkdaAWawpCA7YrBKFQ/OhFThFpD8n2Z4BI36T1aCcdh3n
	 56ZxyizL1+vFw==
Message-ID: <sashiko-outbox-220514@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dt-bindings: rtc: haoyu,hym8563: document vdd-supply
Reply-To: sashiko-reviews@lists.linux.dev
To: pjh456 <147148383@qq.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <tencent_9B1CC4BF39DFA325C2B5384EA8B0319BAA07@qq.com>
References: <tencent_9B1CC4BF39DFA325C2B5384EA8B0319BAA07@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:51:06 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> The HYM8563 has an optional VDD supply.  Document it so boards can
> describe the regulator and defer probe until it is available.
>=20
> Assisted-by: DeepSeek:deepseek-v4.1-flash
> Assisted-by: Qwen:Qwen3.8-Flash-Next
> Signed-off-by: pjh456 <147148383@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_9B1CC4BF39D=
FA325C2B5384EA8B0319BAA07@qq.com?part=3D1

