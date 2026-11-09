Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794264099;
	b=R6HuY4Cw8HFR5LJEnBvVwakmsLtEYarKFOBkt5DVlVnnVtgeO6ChtR39OmegPjqcKsL0
	 TDp6J+EFePFwJzAY+zbpgz4zSmk4Z6eyMaxVM4cYhJhHI12juYAIaJU61685C1F2xMU5m
	 LyJLdfKJlZyG6c0jo5Jhra/Q3+CGKehNnOWs/9wF9ov4FwaGc/wkb0Djs98g457q/5Q9X
	 rkhHbGEH/48JtL2Ljn7MFrhmbIo/0nym++7PY0s7RajGuGp5F0UtcpJGOU3Hlfs8rRVbK
	 eR2rtyAPFFEYZbn/WQekBoN75JBFgdo88jG7y7EJP96hXpQnmedTFSahsE5Ylk9V8ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264099;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nJN3CxyovdYi29W2WH9VPdEi1Rm5D+lg54kF/t7vNJY=;
	b=oVrDz2l1++3Mevx1cx7yV6VMfkXJUcRYpaueb3Bbt2VmUVTIqT2Ap9MxKUSQa11lrhMi
	 qpwb1ENuDDVqj1XX1Waj6LoZyWwjyT9OlzXhOnM43j+Nsl0oiyi4Uv21K5qP6dKY3Akq1
	 abjgdLx7ciPdkxMSb4NkhY0doq/BIKKVRDhU7Kqe75QLIWRRolgnp93gzjkMU6w/BHJ65
	 wv0akqP5662wm8443E5ufwKnms09YlISFY/slzshH8q8PaHPbnwymjYsP/Wg4f8dPaooB
	 bjmpexCM3nI3pAKW5zFZRSXexshqX0JFfAakTGFIP0+bAdtkAOm2GOk23OgW0qbKYZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bd8rXzNz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E44E606A336
	for <linux-rtc@vger.kernel.org>; Mon,  9 Nov 2026 22:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bd8rXzNz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C641F0089F;
	Mon,  9 Nov 2026 22:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794264098;
	bh=nJN3CxyovdYi29W2WH9VPdEi1Rm5D+lg54kF/t7vNJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bd8rXzNzE0XvcHck8MVhe+4p01b4HGRMwizjnicSkPgJdMJotiJooiv3o0m9MkEUZ
	 mOQZuM518IB+qRVJW8urOcxcQthNn8P2y3TxoeAHBq7haQMlJsUrCU7/X4EDCnzWv9
	 vFZsLa3tTSPjjbg2pj41X6ArfHzqlK1lhrOH+L4frFcAAMOc7bdSmCMD6C+fNf00OG
	 0cvU7mcRG9v4zpmwnsStS2FsVv93ZTki/FeC6mYAioujCgYFhGZ5FvRLzB40efQQYc
	 LakwFLuN9lz9F2Q59lAdBLneaQG0URsjxiBpjMlpzjf+pg4zE/K7zoi3zuu97njRwD
	 oxktR6DkPwcmQ==
Message-ID: <sashiko-outbox-205763@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] rtc: gamecube: Explain why fast_io is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261109223902.84918-8-blum@kernel.org>
References: <20261109223902.84918-6-blum@kernel.org>
 <20261109223902.84918-8-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:41:38 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> Replace the TODO with an explanation of why fast_io is enabled.
>=20
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109223902.8491=
8-6-blum@kernel.org?part=3D3

