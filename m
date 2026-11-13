Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609385;
	b=Fq/C+1NbFbmHO0Gx/UDWF5VXV/IfCIzs4lyO+K8YIILF5P0iDBbHv6il4fNFwSFYIbFq
	 g8qcPGb19u+zgWD9RZjnQzNhbmnzh/LAgZEUc+W/x1sjaAEFC2JIDn/EBDoITwjnQ2oX1
	 zAykj4arWzsrYueodwrU1PbGxoyBo3Zyenw4hip0YVPSVolczGJeFYg+U7ybTZ4xkAChD
	 yVgY4BnmprQgAZoC9lThnkMMRQy3nQ6KtsVQQfwouGE2H/yzPD8JiSxUcvxW5SSKPG9h/
	 v3RWJJEXknTGh0RpqZihiu3bDZwfbNBuYi+CIUsWaMjgq3rZD+R0Ul5Ry0Vta6dY06Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609385;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YZN+BZW+JsVxgaX0ePTXr4+7BWioqzbo0OFVt9L2Jr8=;
	b=pkuEGScAXL/lgJaYHyZ4lP8u2fLWERpM3nvEvQC+VH9I667vL7xycKbBgDxpJgaZi+Lt
	 pO64b68XPL2SyvFX+QnZXe78dI7ihZ6K/9BY7r9qRyLO/tUh5mwIJNZfRc9pAkG8k0X7R
	 Fj8D07z85KUMylt+u+3aXQlnb4IT8AouOImMCOWz6TvbOhgMm9jhOSw/3p+3tLSCxLLMM
	 YHYsHipv2WZzRy6T6ceWn294CrdBSyIPoOPOV7MidyKhwyBKTHNCgNDPsld8wdGNmo7Mp
	 166+lGYmeAc1UtB06RDYJZAY6rgO0YGjRaOeqXE6FIBA/xDovDVbTMG8mUt4LE09uuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lAVTAJS7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604F2606A33A
	for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lAVTAJS7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0959D1F000C5;
	Fri, 13 Nov 2026 22:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609385;
	bh=YZN+BZW+JsVxgaX0ePTXr4+7BWioqzbo0OFVt9L2Jr8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lAVTAJS7FWhu7pktX12KTvqOU1bXerS3JJaWyr+4Tify+Cxp+FB0NXkKCWJcuXytX
	 4GexLqRbSmaMOyJSwfCXGZL+bCMf//Ukp+m4WW2X6XD0nvkRKtJsK5CAqwdiKT2rAr
	 d4FwVXPyYxt7wlPCPkrZUTFc0mosaxVGcGmeuzz3HM2cWjTPKNtxyJ7cfdg5/7NwP0
	 Sm54pYJivJB2Y59YkjDbqMB040P2FA1c7bY5pocXtFNU3upsdYmSyhuEcVHm9TyOLO
	 W4nr71uggZ2eBeACrPiaQF56ssDspA3XkxnTm8ghJO7/gd2QdEOMuPw4BvrcqXjOZg
	 gTsap/ZOL9s9g==
Message-ID: <sashiko-outbox-213820@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/19] clk: sunxi-ng: sun6i-rtc: allow variants without
 a 32k fanout mux
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261114-v861-v1-9-eb71ec3ee523@iscas.ac.cn>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-9-eb71ec3ee523@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:36:24 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> Some RTC clock blocks have no 32 kHz fanout mux. Do not register the
> fanout clock for variants whose match data lists no fanout parents.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-v861-v1-0-=
eb71ec3ee523@iscas.ac.cn?part=3D9

