Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854128;
	b=bRwvRYChFsvo8Sqm/2YfvPiNyJivTD1HSn5BgzFNG8GdSu3vhvKmHabzORpAAcr8JTwr
	 kkRiOJ7nw9khHh9LAyFQyYmi9rEV1KScIkfa2PwOB3hyIpEpe/I3iFUdWyXK5KQ8DqECB
	 n/cacKwDZ6fHZsRxroviSj2rxN8KnPYLckQTv3yQ01ZsKGKVWQAkW0KId8KyWtQBnswj1
	 Q8XAHM6cKp/CmmBpeBZ3sWt5nic41ytmnGzdB1mB1PmCGggf8wXLjkZ8p1/uW6xK3YTQA
	 OUCdcMzkJ4MO3ItE2GCNBLBZPBmE+ROm+hmNyJCNdUfLe88iceLisTGVWUBqAbkfXeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854128;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Q8fWQBgofRqmDIckF8inUm41V68y3ygeKVYMQd0qF0E=;
	b=DfnPCpBkuzOtYtjx9ADTPyvfoomDrmBNJzdg3hhg+2oDZNaV/W1zlrYxbsJbdW7GMF1u
	 8EqiMqpHO0z7n5eb+rY913Izm6ianHyGjG3xOfj8TIny3aPHe2LNeA8izM+iwsUBZkPH/
	 2qAiyQU3TkEEoWCa+EiVrkbApzdfRgdDOsxXJf+nhL2HhbwyeFATdFerueGj5264o+j0z
	 kth34MCb1HYe2/y+CByzmhncJ6xfhNkhO1LTxi21InbGP3tsQ2lLuhlPB7upu9sIE9GTG
	 dPu9Hvh3On5OOD36Yf0XE/S4zztDhXCbFUp7JBNHIWklfkScybkk3jR1/BhwoFLoQyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9SXc34f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B3B606A339;
	Mon, 16 Nov 2026 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9SXc34f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8970F1F000C4;
	Mon, 16 Nov 2026 18:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794854128;
	bh=Q8fWQBgofRqmDIckF8inUm41V68y3ygeKVYMQd0qF0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m9SXc34fYM5jcJuE1wTy6zk64bskstE3LtiDgfZxmmOaqHstxKBWeNqSoTlPNJ83z
	 QT5lbfPhNY1vvAmdlzX65ielD8qN5RtpztH54/QmlfCrWFL2x0grSV7yt/TpR4g5/2
	 Q7j4mNfhDrwj/w31plz/G21x+t9/KwKPaG6dOqCcT6pJvBXr8r6zYOVmkzOLUjBRdq
	 B52g+XcrwyWqhU0KG0NpxTVKtNArw4E/DOy8C3vVOT6fJE8KiOeQ6oG7Ad+XAnFijL
	 s5NP99cIJVFtIQG1Jona40lByHZtMTjMEooORNkB532sTG8PzJO8O+FfalgSU1FPDU
	 Gn380UsXQlfzw==
Date: Mon, 16 Nov 2026 18:35:19 +0000
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
Subject: Re: [PATCH 12/19] dt-bindings: pinctrl: add the Allwinner V861 pin
 controllers
Message-ID: <20261116-friday-follow-4d042ae6a3b7@spud>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-12-eb71ec3ee523@iscas.ac.cn>
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
	protocol="application/pgp-signature"; boundary="iob+U2BkGYeh1b1b"
Content-Disposition: inline
In-Reply-To: <20261114-v861-v1-12-eb71ec3ee523@iscas.ac.cn>

--iob+U2BkGYeh1b1b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 06:33:38AM +0800, Han Gao via B4 Relay wrote:
> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> The V861 main and always-on pin controllers follow the A523 binding.
> The always-on one has a single interrupt bank, so also allow a single
> debounce value.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>  .../pinctrl/allwinner,sun55i-a523-pinctrl.yaml     | 31 ++++++++++++++++=
+++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sun55i-a=
523-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/allwinner,sun5=
5i-a523-pinctrl.yaml
> index d7d0ba32ced4..3c2924df17b9 100644
> --- a/Documentation/devicetree/bindings/pinctrl/allwinner,sun55i-a523-pin=
ctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sun55i-a523-pin=
ctrl.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/pinctrl/allwinner,sun55i-a523-pinctrl=
=2Eyaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: Allwinner A523 & A733 Pin Controller
> +title: Allwinner A523, A733 & V861 Pin Controller
> =20
>  maintainers:
>    - Andre Przywara <andre.przywara@arm.com>
> @@ -26,6 +26,8 @@ properties:
> =20
>    compatible:
>      enum:
> +      - allwinner,sun252i-v861-pinctrl
> +      - allwinner,sun252i-v861-r-pinctrl
>        - allwinner,sun55i-a523-pinctrl
>        - allwinner,sun55i-a523-r-pinctrl
>        - allwinner,sun60i-a733-pinctrl
> @@ -35,7 +37,7 @@ properties:
>      maxItems: 1
> =20
>    interrupts:
> -    minItems: 2
> +    minItems: 1
>      maxItems: 11
>      description:
>        One interrupt per external interrupt bank supported on the
> @@ -62,7 +64,7 @@ properties:
>        Debouncing periods in microseconds, one period per interrupt
>        bank found in the controller
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> -    minItems: 2
> +    minItems: 1

You've lowered the constraints here, and while this is harmless that is
not apparent from the diff so please note it in your commit message.
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: changes-requested

>      maxItems: 11
> =20
>  patternProperties:
> @@ -149,6 +151,29 @@ allOf:
>            minItems: 2
>            maxItems: 2
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          const: allwinner,sun252i-v861-pinctrl
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 7
> +          maxItems: 7
> +        input-debounce:
> +          maxItems: 7
> +
> +  - if:
> +      properties:
> +        compatible:
> +          const: allwinner,sun252i-v861-r-pinctrl
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +        input-debounce:
> +          maxItems: 1
> +
>  additionalProperties: false
> =20
>  examples:
>=20
> --=20
> 2.55.0
>=20
>=20

--iob+U2BkGYeh1b1b
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavtM5wAKCRB4tDGHoIJi
0oJfAP4ufaoW9ODoPhwL/60TwgcwPU7zYRBS09Lui2xZHPvT9wEA+DbyCtPMNtgu
WpkHu4Qik6IU6UhTe8QqVvGh8jwnUgc=
=GpLT
-----END PGP SIGNATURE-----

--iob+U2BkGYeh1b1b--
