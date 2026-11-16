Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853986;
	b=Hw/lRNeOvJarHvvHbJxvyXsuh1Hw+QBpirerrSodzc2653YdiImBgfMwcEcsVLthYOn3
	 vbcvjmCdR++onM3O/SAexQ+p9s9/VIjSjluSGgqGQL/ybYaDp4JJHawy5utpjQIv5M84D
	 GkrCfZiNA9Jx1U1On/SuFha5jPjAJgOzIVWQjIHcjn6mjdcyQv8f2oHgcG5mCyqrkXt1V
	 XQCKcY9HPQC9uRBRC4Ehmkn+1GIHJm88ENnW04d+sH2NYt3FXKhTiMggsF0teVNSAPabC
	 6Gv2VY7w1G9ilJTr78+dDaxicRc81QYC7dtqnVpnnP9ysl5OZmngyrsGflGS9vU9GXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853986;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=W4DMrdgsLAUvBBrAedtVh2X2nrPi8BxrDXtCs7P+IMI=;
	b=gf1oUHkq5w8BS9BnAgmTqrovKKaUIXrE9dZed3+XCDq7UkzNefXGLi4L32btzTOknkF5
	 zGDFpVq/al+yiIXR/urAW9eoNNKd+SqnGg3jnFueN46dLVpkK5alQvRN/A5bX+pW/ebk7
	 l3d4nu1H3xgzNkkPSkvn8gzK+20xRi8ssP0N5GyiHLXvz7vUtjAPhSwBcgS/AdlY9FwKC
	 axhqHVY1ioP6WrzMjCNcx8hoKdA2NrWLsZ+VJzR83EJF3rp20fDaclySjPoaW94WDrUNX
	 wc4VaI2mw5pghA1lWedgXSxd1fP7yfVXEndvlOW7OOCekzZpEBuvwmp6O8lh1WECiqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WaluPPtm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E29606A330;
	Mon, 16 Nov 2026 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WaluPPtm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16001F000CC;
	Mon, 16 Nov 2026 18:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853986;
	bh=W4DMrdgsLAUvBBrAedtVh2X2nrPi8BxrDXtCs7P+IMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WaluPPtmVQajcvp3iSn8n4nUrBdnmzjvcL8SQtCk/wc4+cJVkEcnzLmkx0S1GIB8n
	 lTRfAEGpyhFjU4JMR6szToKlZxCFEdwOGLEDX2rxrQTq1rDBEt1SVAH5t+KuWrgO4P
	 SqWI39DsGszLHHoHQRQGo9qVoX9DM1YyYJEGs+rO4aPdze0yoHYmIhv+84jh4DimRg
	 oP48j2zl9gB3+kCyygIxdyd2P/ytRyTCUJOiLAeHn6cjZDwW/LsahzNz7CALmz+5Tl
	 Y2Bo3LxPi1sPEjllqdCBWIfviaqNkSjKpXc8pMXzZUemcpTEn1L93wEom2dMTp/7y5
	 m5zlvuwouxfRA==
Date: Mon, 16 Nov 2026 18:32:57 +0000
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
Subject: Re: [PATCH 17/19] dt-bindings: riscv: sunxi: add the YuzukiHD Avaota
 F2
Message-ID: <20261116-coerce-abroad-f6a0d972e7d6@spud>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-17-eb71ec3ee523@iscas.ac.cn>
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
	protocol="application/pgp-signature"; boundary="eAu7+tg1zQRG6YLP"
Content-Disposition: inline
In-Reply-To: <20261114-v861-v1-17-eb71ec3ee523@iscas.ac.cn>

--eAu7+tg1zQRG6YLP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--eAu7+tg1zQRG6YLP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavtMWQAKCRB4tDGHoIJi
0kqjAP46j2mw4L3q+jkKbSPU8KSsnHg0/9HtMnl3SxjhCkKDjQD/Zz+2au8n8mQC
VWw54ziAbcJSElKAfoNDn+1Tq0vebgc=
=7x1B
-----END PGP SIGNATURE-----

--eAu7+tg1zQRG6YLP--
