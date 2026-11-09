Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794264092;
	b=HyB0PuzIISTL08iuQwvrDIprlnHMt8JoL+exk3IbfTHS511WwVtw7pW3jymI0TONGhab
	 LfPTqR6lYxMG4Q365iXRvK1GG99oik3twFIqLekfEh5PlgxGOsm1t9GXBXF8ZcnYPil7k
	 PSz73CtjPEHIn0j8LEBG2fBSepRTsmMN+yjIbLAg/oOLcnLNidKvQSj8Q1jHBF6FYLQIc
	 cjtunEAcpnUsXi1kWjbTGGN36OmegDceLb6a4y4yuPAPTno7N1aGI/N8A8iaVFWKwYrWJ
	 5NFmETn7RR0M4WVpSxMMk7VZuL9kw+e2tixmTwQWP4lrT1eCsb509sBCTah/Svww19w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264092;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bQOz20Gh7Qg3eylPFIJuDZOfPTneMVNOzHEqFKDPaYU=;
	b=aWM0IDuSQiWM5w1oMFbRPLbypT4DSXuv2aCC3IOAOSfaILvbhY1OaL/QCt88ra/DtTx8
	 IjN2AiPoGzN+LAMFU2ip6//JiYDOBpX91AE7tCDt3BgcRGrKaV2SzsO67SBwdT070l7/a
	 hSukHy0Vp9IrQw+o643Y5PPx1rng9I7Kw0Nx366s0C+/Ofh+4p8wQPZEhQqedfwLUA2u9
	 LbhS3703V0N60i8SOxhHNElJBC3SoaKUN+mfRrtha4dReK6sMtN9LqnfnTntA3RzL3pPk
	 9OelEVm2b7uU+dybmmWINXnpEhFxKcUldlOUXvqzHsazPHfps75UjuWTledRDbqDzYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8oCeTM6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651D0606A32A
	for <linux-rtc@vger.kernel.org>; Mon,  9 Nov 2026 22:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8oCeTM6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A276E1F0089F;
	Mon,  9 Nov 2026 22:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794264092;
	bh=bQOz20Gh7Qg3eylPFIJuDZOfPTneMVNOzHEqFKDPaYU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z8oCeTM6+YRKaO7rrqKqa1viDkOUcENb0d5R+AS6OFRjZ+fTAD2bP2f+3xW6iwIgg
	 8Eux4R9iQATfBD2W74MEHRxbOwMMkYJjVpv+l6mmxPP2GVP+cIUddMsy8JqG8ThMzl
	 N+62drZrooB44ZXxXCIzQnZWQVSHtreX68LbDOG+vps2eXbP90Ee6l9zh5ptSk3fXp
	 R8x6udQ/bgiqjcSpX8TvBDQUKNYe6r1xho8m412SthGKXdYmuKuAghrVeRnMX3PY81
	 Jupn1iVAVPWHnOGQ0dafbDOQbkPexQ4+6iSVeihfCKsYdnkqIquFbKXh5BmMqiRjQ5
	 QMM06lQJWO2ng==
Message-ID: <sashiko-outbox-205760@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] rtc: gamecube: Add missing newline to SRAM bias
 debug message
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261109223902.84918-7-blum@kernel.org>
References: <20261109223902.84918-6-blum@kernel.org>
 <20261109223902.84918-7-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:41:31 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> Add a newline to the SRAM bias debug message to terminate it properly.
>=20
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109223902.8491=
8-6-blum@kernel.org?part=3D2

