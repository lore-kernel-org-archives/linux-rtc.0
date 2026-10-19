Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444933;
	b=1TIXxJ5b5jK4xm6vXxxSIzqhiruZVTTX3Z59H7oKGekRAaqT1ATVBVcROOqXrFRnV7Tb
	 ZiBT+ZaWYUaGT0JVSWA29xfpZytPGJDgk4Oe8AW39eeEr2unW5viCqs87aLFubwCO3/XT
	 m+Cp2jPGJMJWQhGihgjOORJ/TKlmDCibKnPZQyRON5ZQm8luJHJulecr4J1N27yxSf9f5
	 cthdafP3OxolHSIdgBD3BBPiHnNMtAbU3Rk6IiC4Dt8IJvhVmZfWLLZvHY+DkUdN2hk8X
	 wwQYGybhkAxI5Sh9lpHNOQDDPXu+7YKiPAhpQ4pb5zGvgMz2oKEih2rrXFuky6c7YeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444933;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=s4Fl/Vam7brzdgXCfo4dO/yXm2JmRwXkL65n3tb1Itg=;
	b=iwEjbGjMrX8L8QgthclsslWEF/L88TwBqoIJu9xJ7YtqqHVGyWeVyza8g6aXlcRkvyfS
	 c0M3Ck5jzEbHC66DyRY9Q3qmkILRsa64YdGTSdXP6qtyb+8E0bWZ7ZujTpNrBYEEfnyaK
	 WqpcKwjCgoiS3swzFXPUJj3sFIiloZRB/oh2rkW5dILIiCSqNd5am3kg+yWsZqEeNaTmE
	 1x2f/d5so+nIuuRSc7ax2tMmWJ8jVklzPq8GAYLAyIjMNiW3FVRJz+18O8B3d9dTc/XQL
	 e8yLRHfyodv0UDa7p2ksjQdEDcnewmam3AxU8zvgNQ2tcV0X6U0eXGEkmUrN8/7rYQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwdKWoo2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70271606A321
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwdKWoo2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48A11F000C5;
	Mon, 19 Oct 2026 21:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444932;
	bh=s4Fl/Vam7brzdgXCfo4dO/yXm2JmRwXkL65n3tb1Itg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GwdKWoo2OD+QEkBgTH6eYK+czO2+ROF5OdqDcrrElpOvEZE/3gy833s4aqjzuWRhS
	 ksGQH0pPpZSitDzoziYruynM7TMtJWyUdyACV01yyMwbraVn1Xivr5h7T8J6cu1zft
	 GQwwf4qlWEdJ9IALWkn1hn+cHdWWMC/Tk3yMGYgSyKJMFzQvnQ8XJ7RuSzC8yJwizV
	 Ns0HtBbQY1QmBXt3W3V2iU5dSxg+n4DiZVISvbArt2q/5fN7w2rULUpvQxDkeDtCYN
	 9mu9ktpz70xxH5NHTeRNFspPYQalCtaD4BBgiu0km9LVPYbYBBg0oZxeDEQC/ex2Zc
	 ET0X0Digqp47g==
Message-ID: <sashiko-outbox-178236@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/19] rtc: atcrtc100: use guard
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261019211827.126262-4-alexandre.belloni@bootlin.com>
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
 <20261019211827.126262-4-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:22:12 +0000
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
62-1-alexandre.belloni@bootlin.com?part=3D4

