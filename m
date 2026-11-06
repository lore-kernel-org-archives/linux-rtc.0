Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989018;
	b=bF2zbo/4/s6krRvfcwF0ARP85gIpNYimsCBssiBNX0F2/topAzsPqd6Flbu6soPTEGbv
	 WsgK5LNboMikaZYcp14QmlarZaVjiyyfNUFwMzlghSana5al6A8dUN5rvQ/CDbQV/h2oP
	 Y71mD4oqkl0IWchuqRAFmSDk7z01YM1ogUHNZK085OxQsci1/+3E1IweMASo7jdvysB5l
	 kCIEDxmKIkFtrdiZCnh7NcNcZ0EWfsKNLFyo1tu++TACfc4mbQ6kc07vtz9u7hOzQJTac
	 MEpkVEJ5BoMZP6P4Rn5TiNMqQm4y9T+hYJVAwurNfQjmZen2YffIei7THt4s08DWhvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989018;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=w0VSteOSDHzDJMMZlPVFDnksNQwbIiA9tfmca7n6AqU=;
	b=41qTnOb6Hbm1ycddOe+V7dAG3YinnqFchxnxf9vaGNzzkB47zQnyMW+Qgww7VhGBfRzQ
	 9JSple0Xop7uAJjcyXph0+lfCG1hpTGicTOCjVVYPJVgYJub3qKFxqSufqd9IN/vER5qP
	 VXZlH1j8+JSPQVQ9Xuis5KRSXrQdHun+FtDflwX9YxTykSvX9cvDFVW53tjCoHXZxuMqc
	 ec7fM4q5/cjT3UAdVpB/dZ5Jw8CSAgvhAhHdh7/xYJK6GUzE2bZZI0RgnHYsDdU+2Zt+q
	 5pgQgCjwXq4sZAbQAVHwW+2S0/X9y3UYpe05tN5YXWNrUheyAsin2gNncIEI9t76kpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KavtPbl8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B2C606A326;
	Fri,  6 Nov 2026 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KavtPbl8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598931F0089F;
	Fri,  6 Nov 2026 18:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793989017;
	bh=w0VSteOSDHzDJMMZlPVFDnksNQwbIiA9tfmca7n6AqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KavtPbl8UnPg1FIv7HRBd0pFzHPrSUQlTt90GE6CtORA4iOosOZ5mR/hdZk1+l/qi
	 jageRticCNg+PWLnKMivdGaCUSOJIOipCBa6IBGCjd+nb+xP8+WAzNHfGLuyuqf/qg
	 irUJtFT/yD4Epb5flnuVNtRdQodXHsR9RayaC40lLQJb3QBWlhalqflcPgNrZOiws1
	 gHMrMvr7a8cNj+i1gZxHfPrDMMlH5TnQLIcavAoF3g5NLuA1R+LQyAz+Aj/K0vkYzK
	 WdjA0pjHLtAA+VCHmYn8XnZ0W+RW6IGux+BKponKdsIErmvZyNzoEmoykp0z0ntVtA
	 iHc/LHte9UBYA==
Date: Fri, 6 Nov 2026 18:16:52 +0000
From: Conor Dooley <conor@kernel.org>
To: Owen O'Hehir <oo.hehir@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Hal Feng <hal.feng@starfivetech.com>,
	"ziv.xu" <ziv.xu@starfivetech.com>
Subject: Re: [PATCH 1/3] dt-bindings: rtc: Add StarFive JH7110 RTC
Message-ID: <20261106-skyline-elaborate-1d30d5e99de5@spud>
References: <20261106175600.3877614-1-oo.hehir@gmail.com>
 <20261106175600.3877614-2-oo.hehir@gmail.com>
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
	protocol="application/pgp-signature"; boundary="Y+/7ryyc8QG4aH7I"
Content-Disposition: inline
In-Reply-To: <20261106175600.3877614-2-oo.hehir@gmail.com>

--Y+/7ryyc8QG4aH7I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 05:55:58PM +0000, Owen O'Hehir wrote:
> Describe the RTC in the always-on domain of the StarFive JH7110 SoC.
>=20
> Signed-off-by: Owen O'Hehir <oo.hehir@gmail.com>
> ---
>  .../bindings/rtc/starfive,jh7110-rtc.yaml     | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/starfive,jh7110=
-rtc.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/rtc/starfive,jh7110-rtc.ya=
ml b/Documentation/devicetree/bindings/rtc/starfive,jh7110-rtc.yaml
> new file mode 100644
> index 000000000..95edddea1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/starfive,jh7110-rtc.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/starfive,jh7110-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 Real Time Clock
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>

Really, this should be you or someone that actually cares about the rtc
on this device, not the subsystem maintainer.
pw-bot: changes-requested

Otherwise, this looks fine.

Cheers,
Conor.


> +
> +description:
> +  The RTC in the always-on domain of the StarFive JH7110 SoC. It counts =
BCD
> +  time and date from a 32.768 kHz clock and has an alarm, a frequency of=
fset
> +  adjustment and millisecond and one-second pulse outputs.
> +
> +allOf:
> +  - $ref: rtc.yaml#
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-rtc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: Millisecond pulse
> +      - description: One-second pulse
> +      - description: Alarm and calibration events
> +
> +  interrupt-names:
> +    items:
> +      - const: ms-pulse
> +      - const: sec-pulse
> +      - const: rtc
> +
> +  clocks:
> +    items:
> +      - description: APB bus clock
> +      - description: Calibration reference clock
> +      - description: 32.768 kHz counter clock
> +
> +  clock-names:
> +    items:
> +      - const: apb
> +      - const: cal
> +      - const: 32k
> +
> +  resets:
> +    items:
> +      - description: 32.768 kHz counter domain reset
> +      - description: APB bus reset
> +      - description: Calibration reset
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - resets
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/starfive,jh7110-crg.h>
> +    #include <dt-bindings/reset/starfive,jh7110-crg.h>
> +
> +    rtc@17040000 {
> +        compatible =3D "starfive,jh7110-rtc";
> +        reg =3D <0x17040000 0x10000>;
> +        interrupts =3D <10>, <11>, <12>;
> +        interrupt-names =3D "ms-pulse", "sec-pulse", "rtc";
> +        clocks =3D <&aoncrg JH7110_AONCLK_RTC_APB>,
> +                 <&aoncrg JH7110_AONCLK_RTC_CAL>,
> +                 <&aoncrg JH7110_AONCLK_RTC_32K>;
> +        clock-names =3D "apb", "cal", "32k";
> +        resets =3D <&aoncrg JH7110_AONRST_RTC_32K>,
> +                 <&aoncrg JH7110_AONRST_RTC_APB>,
> +                 <&aoncrg JH7110_AONRST_RTC_CAL>;
> +    };
> --=20
> 2.43.0
>=20

--Y+/7ryyc8QG4aH7I
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCau4ZlAAKCRB4tDGHoIJi
0u3QAP9iXmVACPlMqrsukwxvGGlu7UXlmHrZIe49uW1XNeip+wD/cF9fDbYx11SI
XVeLyV4S0JyXiW6UQiLkHm7vFH/qVQc=
=uLvR
-----END PGP SIGNATURE-----

--Y+/7ryyc8QG4aH7I--
