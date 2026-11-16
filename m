Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853816;
	b=LiSDk9wuyc3JcxqNZZyYJb4x7sQqwl8kgFb9bouAPUCUFVunWzjsJbJHJjkE/3XUSWlz
	 gkEGBlfjRCiZNI7vIdT+vTJkhVsGnDXUgIEcOvhojlWtfPXdHo47+jOC9k6iv/6K4r7O3
	 KChpuCuiRxNAN0iNhGSrt2NOJLWqvRVmmY3kyH16D3jGdjUzfTcNTpg6lwoSOyf7zPGLw
	 lr4t3Xkv+k6Tyl58vOToQG9a8Xo5IBmgKOtGSOiq4rRqh/CHM41ZXGtWs68yxLCNQEBhR
	 TFxN2PUuZePzoC7DxpXEvOA/XdThsUpRk9sNhxvrzk21UA+1RmbAxQ/Fw/WuBYDesLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853816;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xapfgAJCLoQlkir661XJW8UeByt6AZ52Hqz2AFLNh5k=;
	b=CoFCtTTi47rw4cxyqI7p16ufgggle54lmezU9/lNITSkDFvdp7+O0g4LK4vUVWIdmFwT
	 Ur1rNxpksXAg576oZNg6XWqxbRUghLTE9tzZh93lpy2Wl4BxYH4/qHKuWFS8KKn1IcbBP
	 tsw/JKzmUe9FKa9IT/qVIsfg7o7sFYcDWK7UHtfokF1kkndscBHE3N44WncHhhUF+5F2i
	 /eR24/wG8znhNrYuvxhVD5mJmSHqXTiJrRmbjJ+HX6fAQBqJ2GBtV0VWUzsFelRU8UqoC
	 Tb2Vkazu31/doMM3mUSaAwKnTzHYnmj3M2aZxwjo6lXyezQfoQgkBXdjpUgRqrCB9cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhQwyLG4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B75606A337;
	Mon, 16 Nov 2026 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhQwyLG4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77891F000C9;
	Mon, 16 Nov 2026 18:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853816;
	bh=xapfgAJCLoQlkir661XJW8UeByt6AZ52Hqz2AFLNh5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PhQwyLG4wCSOQLVyfRixgXJK3VEZYeY5REj0ashzJROReKe6Uvn+SuPF4IyAXHrsj
	 oGiE2SdYAqVF2UbGrb9Awhy2lWoW5GUHf1N5Vp730kcQ/yyXp/GkFsj3YZfiQTNPG9
	 qMquaRasjXN0GJ0WA4u7O/6pmO78BNG7XJ+t2ZZXPkf0RxF17vM/IMtppAN0GVHegP
	 pDtMEz/gYs8hQLB+TgLCIaHYx9n3OZjAUTKroECMuCHnmaIG7qVNwfcEQ7VdMURx1e
	 FLi9N+pcEIetBSlYuMal2Rc0mjKnurfH6/fa0Yz6KHUgrp/40PJAqreDgv7D2l9dt/
	 zWThTZinjb9PA==
Date: Mon, 16 Nov 2026 18:30:07 +0000
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
Subject: Re: [PATCH 02/19] dt-bindings: riscv: cpus: add the XuanTie C907
Message-ID: <20261116-habitual-oxidant-dfbbe0c4829d@spud>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-2-eb71ec3ee523@iscas.ac.cn>
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
	protocol="application/pgp-signature"; boundary="WkjwqmRm5O2s7mCk"
Content-Disposition: inline
In-Reply-To: <20261114-v861-v1-2-eb71ec3ee523@iscas.ac.cn>

--WkjwqmRm5O2s7mCk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--WkjwqmRm5O2s7mCk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavtLrwAKCRB4tDGHoIJi
0lnpAP9C3fwKbN6HqfeFdwuatnKF0/9dHaDjmwYnhpF9IPCROQD/QgX5d1rfH6O5
yDgfnkvfBWYk3vACy1JoglUaB4u6uwM=
=wtAm
-----END PGP SIGNATURE-----

--WkjwqmRm5O2s7mCk--
