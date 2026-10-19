Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444941;
	b=mOHHUTrupUfWw5JoGXYjzmdDgvgVyjt9LhwhU6Zblcn/r2gJtZJtRwRiBtcDYWalUR4J
	 5jtN6x3CBqilvV92t/jfo7bCyRL2elEjgcMXD0C6uMqG8T1j5+L5D09/tTVQnLT7v0daD
	 Cal8B7XEQwDae4bbPwMvXTMIuBQs3itdrvSf05T35ggMbD1Q+442BOfHo8thkAM1Sc7wg
	 Mlar1F2TzbJaVR6Le8F1sQPaQNtjEGQwoXBUFDkNbANyJxdAAYquhifzw3CGJQadA7jX+
	 Py4FFQlwYQjb26CYo3504Ryg5PIzx+uX9GY9gvpsQLRnkaD9lvoH8nUS7f1XfS07XFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444941;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lz/mz5okCna7W+6T+o5XnUsrkjuXpmEIV3JTOiQLkfI=;
	b=aUpjZjXuNCHkpldOHHqDbaT6MKnVn7QlJ9POtE4kWCASGw3CKJACWbBCnSMCFVhSxEAT
	 bD4QU7WvQMLUQiP7F8bqGQCnb0mjL+fiMX8PQN2QECx1HvTPN0qNaRhZQZmxixZ5d9Qyd
	 xx+YiDfvn2vxg39/w5iqS4v/en/syK/EUtqUbv+BmDLsRXsIMQOklln4H41m5PKy2Hi6p
	 aJofn8bVeg3jTymntl8sSvIWyw6YQuNiQVwVwhW2L6rs7fQAQ1l0im4Qug1eUfv6JWMEH
	 WP4Bq7b9itjYwAvC1ogAX/xpPBubMiv8JEXqFMh7op8OwqD/SP0EoLkLQx7oSRSEZbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GYT++21d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34AE606A320
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GYT++21d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D1B1F000C5;
	Mon, 19 Oct 2026 21:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444940;
	bh=lz/mz5okCna7W+6T+o5XnUsrkjuXpmEIV3JTOiQLkfI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GYT++21dnnQE+aG3Tk3neDunN8osa0nQm5UFfS/mInB2SIgLiuFR8wqfpdV8/bnw+
	 S/p3m0uaqJM7ri1F4bhUDQfR/J8iiOUH67zVTL/DiGt1aKtmqXWKAtjOW/zwm48IP6
	 2qMz0rYKqBq2RscZPokIAlooyMqlneC0GIkdE2TCol1cv0JZRJirnQahWNDp6Xz9Mb
	 /8kWGwrAayGoADO0xt5g0DCk3Ekx0KkdU3V/2PZ9Y7YQ9jWDXS4QeVbs+C6ORCBiFC
	 XAdJtROTiVQvbC41x0/J/YXLjApDoOxlgyXp1B8uqwqEGO0MmyuU06sce/IcdEX/2s
	 FBtmS1hATx73A==
Message-ID: <sashiko-outbox-178240@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/19] rtc: m41t80: use guard
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261019211827.126262-11-alexandre.belloni@bootlin.com>
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
 <20261019211827.126262-11-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:22:20 +0000
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
62-1-alexandre.belloni@bootlin.com?part=3D11

