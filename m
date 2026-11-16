Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853895;
	b=xN/GlgWPqlI1hbLtBDi4RYZLBfnRSkcyAaWMQ0FPt6xMb6Q/ghYOhNKqZ5J7NN1OdUvh
	 RpvxM8b+hFwh61BcKNji2Fg9T/VON3T2JkrlHgmb7bjbbLVMuok42u9VEAf5TwWpIR478
	 jIm7G3uidbH7a9L85Sa5E3YvS7FR9NrZq1w5LMrBpCvGV5Mq0bpEDkRrsbfBZeuz1I2J/
	 S1vfhD/JInQYln2DuTV0V1zxKUfE8750zEZBCziPNAY0QU6wiwWAN7o37jZKeMDQ21YhN
	 clWkiPamJx+D5D01G0TqDebxSWpK3zlmgmTC5fGvHp05mWVnm6FJdkwEjqCo0d9bbTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853895;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XJUTX/oG3xFE1N53/inUBACgrxQmH1VhG5mRIeJMkCA=;
	b=DOKC1Pf53uaCFL/7DVvqRnBRHtpRRTU6z+VwPE7f6UvyZVABreUpsXFqTtXorNIxGK67
	 WnXiXyDtn3QRanqw05Qynv5qXPoGrfuftHFEThJjbDXWL/jVMNgz1SUhoqH3O1Tfw2Ziw
	 rMrs6fTZoTh8+BOmQ6HLJElQF3pwv7ePPoC9muLkTuFAPDarpuwXqpz3rFpzY9ycrEG4F
	 xbm6JqAc29n7+6J5YmzyCwKuo3pzCqiRWAVyDiyybg57blRwL1GChBPrddNljHE1nKmoK
	 VqIIyxjzrqRtsIenQvr+V/upwyo6U3jiACtgz8vEaKKLU0Wp7/w/w/6k3IHL9dZrkLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvQ8bF80;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E44606A31C;
	Mon, 16 Nov 2026 18:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvQ8bF80
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5451F000C4;
	Mon, 16 Nov 2026 18:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853894;
	bh=XJUTX/oG3xFE1N53/inUBACgrxQmH1VhG5mRIeJMkCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YvQ8bF808RG4sXE5szH3DD7gpS+TlFCTXaX0vgrRZrdjqyhOnJo8pwDfaE3fyjFWK
	 LAtMA0HvOeCESP193MmryXsuJFOlr176GZLcshKu2Zeiy4AXD+IRSEGlVvD93d/XbL
	 noirZBbzEwlqSdCKe2HsbLZaX3gVjl8GsoMYefSL6ugEC2HTr+wrFwCAVsUrZz/+/s
	 ijqQlbkwFPF+IvGTExOWIpB9J2v6ZBOLME/yfL7eeNtxdUHg1JKQzUxJGieyT4KlS5
	 qBY9zfBP2tlR5U+F/UR2N2y6GCvTbiT2EUDIPLdW1XoTpWtSjsjuhYhH9tn3VENOlK
	 acIc4NSXc72tQ==
Date: Mon, 16 Nov 2026 18:31:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: gaohan@iscas.ac.cn, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
Message-ID: <20261116-myth-sponge-9a8cb0627b65@spud>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-1-eb71ec3ee523@iscas.ac.cn>
 <CAJF2gTTF0b-dkLdznGzwYZmC6rP6GozX1j0Rre5t-aw6i5uDvg@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="1w7qvO7R9koz6ld3"
Content-Disposition: inline
In-Reply-To: <CAJF2gTTF0b-dkLdznGzwYZmC6rP6GozX1j0Rre5t-aw6i5uDvg@mail.gmail.com>

--1w7qvO7R9koz6ld3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 09:13:49PM +0800, Guo Ren wrote:
> On Sat, Nov 14, 2026 at 6:33=E2=80=AFAM Han Gao via B4 Relay
> <devnull+gaohan.iscas.ac.cn@kernel.org> wrote:
> >
> > From: Han Gao <gaohan@iscas.ac.cn>
> >
> > ARCH_SUNXI is about to cover the V861 as well. Update its prompt and
> > help text instead of adding another option.
> >
> > Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> > ---
> >  arch/riscv/Kconfig.socs | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index cecbce0c4983..4cf3b24467e8 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -61,13 +61,13 @@ config SOC_STARFIVE
> >           This enables support for StarFive SoC platform hardware.
> >
> >  config ARCH_SUNXI
> > -       bool "Allwinner sun20i SoCs"
> > +       bool "Allwinner SoCs"
> >         depends on MMU
> >         select ERRATA_THEAD
> >         select SUN4I_TIMER
> >         help
> > -         This enables support for Allwinner sun20i platform hardware,
> > -         including boards based on the D1 and D1s SoCs.
> > +         This enables support for Allwinner SoC platform hardware,
> > +         including boards based on the D1, D1s and V861 SoCs.
> Perhaps we could keep the help text generic and omit the specific SoC
> models, so it won't need updating whenever support for another
> Allwinner SoC is added:
> This enables support for Allwinner SoC platform hardware.

Actually yea, you're right. There is apparently an allwinner device with
an andes cpu on the way too, so there will be growth.

>=20
> >
> >  config ARCH_TENSTORRENT
> >         bool "Tenstorrent SoCs"
> >
> > --
> > 2.55.0
> >
> >
>=20
>=20
> --=20
> Best Regards
>  Guo Ren

--1w7qvO7R9koz6ld3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavtL/gAKCRB4tDGHoIJi
0pIhAP4uFWaULc3q4nslu9XRgPV6TBBGg02sy+5Omy1R8F0pfQD/ScwUGiv/JuIQ
T4rHBR3hRAetz2ZNVtK27eqE8dA66wQ=
=0dEM
-----END PGP SIGNATURE-----

--1w7qvO7R9koz6ld3--
