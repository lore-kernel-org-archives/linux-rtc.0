Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853928;
	b=gCX641m6jrqkKzlym+YDgG1msbZ+PxPb5/zabdpXz701seJaK51ehOU13pgdlEke2WOh
	 7zyNOjM0JkZ+B0C2PvqPPAZNzG7UjWYWIECgeBQyrbZs0gHP+34ditYT0KpRZiYH1ZTXW
	 2UUkSBikhW9KB05wc1NzXOFaFcGwbEYqH5iHyUCmH488xegjdlW8I+qPrfECI9oY0ACGm
	 TiPWtIxG54UtyU3QZZ10gp4INckPN0DoA5b8Cm4JTeVGoQEQDwTY73WsE3bvzUDjgdnxo
	 Yhi4C22xnJycet9zLvDJ0yfYSC+YMTQA6V4VCcXyj2v4Uuattp74jRXxkXQ16byWOtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853928;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=slt/8ehFK6dZ83SG4ILG0nE+6CRzbuCPyGX2iJ03a6M=;
	b=39zUpndccSkwlyG7CXQPCTXdTkNsUnq98vnaTcUYeR/5SXfXLQvornZkTAiPyKpRuf8r
	 GhlzQZcBHDRXtSEXrzllU74+zaLiilcc3rWyTrf/PjVH4O9wl8Fy6ZYjfVwKKTG+7xAdE
	 BGBTN/H0tiV0JCJJAqmb1BwJZavFMYXY4z15GSpLu1W6UkH1LY8uIjlI2ouChkkYk4tLK
	 2pUzy9xNPbXXkJsSshdH5ftVQXeZkFOBSdBKdYGHW8ZwzoTQJVIygX9KdaCSO7Alr0wX0
	 x1PExh5vb1InvTFE3I5zqneH24nfKJwqHf9xIQet1VG3cN2IVydABHU9dtdlyZ3GAJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1zUOPc1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA6E606A322;
	Mon, 16 Nov 2026 18:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1zUOPc1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9601F000CD;
	Mon, 16 Nov 2026 18:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853928;
	bh=slt/8ehFK6dZ83SG4ILG0nE+6CRzbuCPyGX2iJ03a6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X1zUOPc1SH6sn27i5wA8bSRgm8RrRGGhLZ6WL9cILoB1EyfLhWF/taTEFAeepoBJ6
	 WpxOoMp8xbqaGF4O+u8TA114hbrU+wNmFymBJ1VkJnnPVneFb2W/xdZlA7PwrryWD+
	 rVLS4kqLn/pKY8uIQxKV6J6Nh0qLRu3ix4hau+rSZa/axHQZgeDyAuUSnbbPLLce5e
	 Z1dr/HQLr6ogeoBE0rknyBgD9jNRa/qJ0b+FN4D934O4OCsasgcD9phJFnoYLi82NB
	 E44I5yEXb64JLkenblKV+9UN1rDUQR8GXq6WyIO1Us7rIX7LA2/QhYLLjXrqe0AF+Q
	 69CR1nFDOZ2Hg==
Date: Mon, 16 Nov 2026 18:31:59 +0000
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
Subject: Re: [PATCH 04/19] dt-bindings: timer: add the Allwinner V861 CLINT
Message-ID: <20261116-septum-unwitting-471f14128af1@spud>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-4-eb71ec3ee523@iscas.ac.cn>
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
	protocol="application/pgp-signature"; boundary="ErtSfEwv4s8akozZ"
Content-Disposition: inline
In-Reply-To: <20261114-v861-v1-4-eb71ec3ee523@iscas.ac.cn>

--ErtSfEwv4s8akozZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--ErtSfEwv4s8akozZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavtMHwAKCRB4tDGHoIJi
0qkwAP9Pd/ep9Gqk38vyq4AwUoKO4zmSxSq1Y4VcWPLvY0WyXAEAgRN5as9LYn94
9CLp0jfoNf3CqN/EAfLU4rUerUSzwwc=
=D0vo
-----END PGP SIGNATURE-----

--ErtSfEwv4s8akozZ--
