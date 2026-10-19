Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444935;
	b=b8n1RDYHvaaVl8O2JAOCTv84tL41VOmFNeUmI0qtWQ0iLclgKyvA+eb6avHQtIFIyBr0
	 ubGdHg9kTXReZpMHn1rXBFtCrre5mXbaeCa9AgUNE6+268C3iewmkqnFB+k+tDMdyaoLf
	 D64ecAZG+zAeS6OlWK2TsHVP5l6CzdgYrfrvMw1CcAbt+CJnaKpHeTX9peqO0+nnlQLHo
	 0mmmbXG3Yk9r0DzCS0pPhf6EYp1+hJXxitVlY+igAIthVz0VePbEop+5VSvSdw/jFRKHy
	 iw64mHeNGfH2Q5i3kRSmoHldAbgdBsyxtkTOrmcYnexKcifIJ7S9y77mS7dKue0KTFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444935;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Kh+kzb4kqFX6zQ7Sl9+aMOIDfpDlqYP/xqlY5DlkAmE=;
	b=Gao3/9UZiohnDocmA+/lLgdWMqBFaONFO16FkIB2s2EYyM3bDsh9evx+6kCbqNV8L1xa
	 EtyJKt33AusLttuPEEAB+/CDPAqSSzH3j0V9dCbVpC+2VZooAR2eURgQHExXKJQaCxhVq
	 vyxrc3CDrm4Mi8ZdQ27LtFw7+Vrg0HG2edH+E230PZQUDtJKRSLD9EZwXa8SX+pu1uiaX
	 oCvJXyD7so7gaK3xQkxkgYf0vmN7J4HoVZJuxH8tzpjqoyPhqeCv7Vnn7lyz1CmIyP53E
	 ZiSz8xh6LyYkDoDeg2ULbbFlrKHCGPbFdJBMXZ9nu9WZQxnXbPpSoCWYaUCr4y5gkCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFpIstsy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84A3606A320
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFpIstsy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BF41F000C5;
	Mon, 19 Oct 2026 21:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444934;
	bh=Kh+kzb4kqFX6zQ7Sl9+aMOIDfpDlqYP/xqlY5DlkAmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mFpIstsy8za6mwZRCeM567Td4UUYHvbjhut+/hjwUVlWOo+jBG4qIVKRGLiR3EovZ
	 zcwZU0++h71IgcadUzPmEPeuikTWomS7MFM0FgVxkKmcFtTVo1Pz/Y/LE+WOkKTa1S
	 EaLEm+Zn0mdoQkxEYcLBsYZJAtCW71J23RGq2MJ2yn+LD5MrC3EJNh1F+lCLSbPxEh
	 7aM/xtXwGm95qR3CbSqoXY6o8VOS0tpq7McWrd+KgdySyZs4qH4nGGKtQJC+N0minc
	 cdizsrg7aJbfCL40RsHO3Ba8qco+gR8pahuA9ino3zS/u+HhXTn02TpTsTRFQlerkB
	 VzhJxcyNGlgmg==
Message-ID: <sashiko-outbox-178238@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/19] rtc: hym8563: use guard
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261019211827.126262-10-alexandre.belloni@bootlin.com>
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
 <20261019211827.126262-10-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:22:13 +0000
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
> Use guard() to simplify error handling
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019211827.1262=
62-1-alexandre.belloni@bootlin.com?part=3D10

