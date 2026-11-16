Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853961;
	b=fexE31CfGVufvl9O5mprzmXuqI11tLu0aPxaNAPeUWZKCzL+c62iRqMxx9bLdWu5Vv6V
	 IMZs4S9fP4TXn5shE4BcyGe/r/kqtRjDQ4iEnguD0kA6iYUBDa+Sl0nyBFv3fe63jCtFB
	 0gff4/ZfSkGee3Z+olidDlgFk1i+YtszVPS+P0b5vJ7puFKdS0qhT3JlaEjl06nnu7tzI
	 qp+btVWNZBTu+uUmF5R/dMtCFXCJy4aqftadu0StXJU4r7+3ngKxEuIa+lrBp4xnpldHk
	 ispN92+iwH5ereN2BtuxN4s1hTSgC1R87nhjA3CETrDxR66QbX/2WcUGA+aBqGX5orQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853961;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=u0amJXnNhvCqUYVosfqp8kda2/cuojxj7YCK3kHoL1c=;
	b=gCWYu60vkRtsAZ3fJIK8eVEyHBF+lTaqXvW5/LCJ3bBbkFAt13rYofa2Si0iq7+fJ+yE
	 DLgo6WA0FpCDr8DiBzgej1Jt8iFGmvkADMSyS7cRbfpxSrFBGjX575Dars0I6bI+4VA7N
	 9qO8SW78a/sLgT6Klc/Wq5BetKz9GAM4RkhrQj/2dEsBGal5PxtEzN34dR9j+cXDdOXBo
	 utc07IGHVhjqa18TsOaYkIfQwpOMFuoG7ndgyqHTIdJcUEpatzNcvd8pOG418OrUwdAv1
	 2cDDUktO6I+ayGqNZQSfzNr5OuoYaBn4vDVWDGnA2jDUi1us5dRAuB4fEcRvJbC5j4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BufQ4yB8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA943606A32A;
	Mon, 16 Nov 2026 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BufQ4yB8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB111F000C4;
	Mon, 16 Nov 2026 18:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853960;
	bh=u0amJXnNhvCqUYVosfqp8kda2/cuojxj7YCK3kHoL1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BufQ4yB8tNbR8TJ/Hnm/k0+qE6qxhRqGHHX46jkRGjToD5o4wDrOYPG7nvezFv0ij
	 e00clQXsG373kdYmAXh8oCe3IdIVdiT7Iui5KI+tcxMLHi5sV3JE0MCYGqkDxIcaXG
	 7gFlY44DXGIocwrYaoiYok5Qz2wfSVMvRrYiuUBEIyuQJO2rmvTxnoeAq5ciRmKYtF
	 8jWVjuzRfesJCaPTKOdJGnjX00leLrKY96LkSJxp8fIyI8sTMQtc30D3p5LMJfS9hY
	 WHff+hOG9ikpu+ry1kjea+En2yvY2vIpCCDVgojLaxx8EmurFzgfstWWNc3x0/FSjO
	 xjWuXeQY+sZGQ==
Date: Mon, 16 Nov 2026 18:32:32 +0000
From: Conor Dooley <conor@kernel.org>
To: gaohan@iscas.ac.cn
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Guo Ren <guoren@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Samuel Holland <samuel.holland@sifive.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Anup Patel <anup@brainfault.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Maxime Ripard <mripard@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Han Gao <rabenda.cn@gmail.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>, devicetree@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 03/19] dt-bindings: interrupt-controller: add the
 Allwinner V861 PLIC
Message-ID: <20261116-catsup-lethargic-45b29242cb79@spud>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-3-eb71ec3ee523@iscas.ac.cn>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eBIsJ0dmZzflzkKm"
Content-Disposition: inline
In-Reply-To: <20261114-v861-v1-3-eb71ec3ee523@iscas.ac.cn>

--eBIsJ0dmZzflzkKm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--eBIsJ0dmZzflzkKm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavtMQAAKCRB4tDGHoIJi
0gQ9AP9yFcU7elfIZfpsStDtWeKtAnPFAqBGCugfc09t6ejP6wD/arKyMr+JWozf
FFL142vScOtV8F9Q7w85A31HzFStQgc=
=1gXO
-----END PGP SIGNATURE-----

--eBIsJ0dmZzflzkKm--
