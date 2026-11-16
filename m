Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853838;
	b=q1rx7548RZUoFsoti703js8RTCDX1WIng0IjThQsmpmP6RqN0hD3H5j+WOL+SOwY7EdC
	 fUz6y1ndc+Ur6PTziHsttTsBcRPr4jzsZGq7ZG77X/ETQBdbA9Lf8xQFInky4F5HIjrox
	 jF9MTlHlhXtoZb1kpkr//TYrxn26YQDt3iofX9ADJUZGqoKstczZCEJtMSOfODbErY218
	 RuwESB4vTyvZmGppu5o5usteACEok09myf3HhoqSXEwh0h60WuXUbRwMbvuETap456+Yv
	 jT3+NR1l6Atj7oveJs+EQU0dGgLEjulzrYOB/QT1s8HBVD3UtiDT4rU40Ddho1m0k0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853838;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fq8UNJdybhSyeB6z80ooizYYo9twY2GQIUpJeSeo6z0=;
	b=UxtXWn4fj2v4MMSDJVSW4deP00DTLcQiffuMnNJl7aNFhQpSYHtIUi2/Gn07vkLFJqLz
	 hp9ccFMxABAfXGk62y/i6PuRkjIyCPs0WD8FFZevF72cCD9VM73vp+NTglc0jCevh/Xhq
	 Vco3n5/JseEgKa2FZbXc4HNAAjpQOWFy5dorYP55jtdKS2CouqXKUFNNyK+LjLt+jytXL
	 FtrYalV6SmDoKP8h0Gpl7DTCJE5yGsNuCaaJANz5gCS0VnVneneCpdTRZNtVX/B1KVV2X
	 CsxqALEy00EBVCUNQ/QbOvU637axzZxLttjP6Wl1+FIOuj7UXGKV4dt5XOruhJCQYdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AvHSX4j3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEB2606A322;
	Mon, 16 Nov 2026 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AvHSX4j3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C6E1F000CF;
	Mon, 16 Nov 2026 18:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853838;
	bh=fq8UNJdybhSyeB6z80ooizYYo9twY2GQIUpJeSeo6z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AvHSX4j3wHDmokZU9UmVXmHC/fH1020VEVVpL9WtM3yt1ZLgWvlTQLWLh25a5F+wF
	 p3oUOOczaaWxcUzN7gYP1fNxtgc0+ZXdREZYeVZQAopYSK2pbI9yKNwIy6otK7H24J
	 edE2Xz/uQA0j+T6dxpSSGiE9qsXFnmRP/q3P1fzcbc0L8m9Dz+e7vwYIoT+3vWEI75
	 brLsfzg+hCziVtYBEbAyuBUijC55x32ZmaI6mDyvQrTnuiKvIkWR/+6x+24GYN0Nit
	 oAqvU02x6x22NLIUjcEEpldo08azcX3NHrALt5Mum6cq3oTlGfnrrZmafSe3n2a2cl
	 YerqN1Mu0CFZg==
Date: Mon, 16 Nov 2026 18:30:30 +0000
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
Subject: Re: [PATCH 01/19] riscv: sunxi: describe the wider Allwinner SoC
 family
Message-ID: <20261116-trekker-dropper-f5a3f7cd7387@spud>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-1-eb71ec3ee523@iscas.ac.cn>
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
	protocol="application/pgp-signature"; boundary="zLmNtJsl6PDzM1aQ"
Content-Disposition: inline
In-Reply-To: <20261114-v861-v1-1-eb71ec3ee523@iscas.ac.cn>

--zLmNtJsl6PDzM1aQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--zLmNtJsl6PDzM1aQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavtLxQAKCRB4tDGHoIJi
0l6qAP9H2PZxrdM3PXC0VQDqNZHcObimsehrN1DJV6Ri5MeH5wEA4MvfzsTXAJvt
qyg5wYSgjZRDoS3t6HW/HGfIGKx1BgA=
=jF6F
-----END PGP SIGNATURE-----

--zLmNtJsl6PDzM1aQ--
