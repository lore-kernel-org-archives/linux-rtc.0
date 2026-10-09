Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74AA361651;
	Fri,  9 Oct 2026 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560213; cv=none; b=Oyjt+cWyzR3A16+byfZyLdLKwdxRwPYIRVBEgOJt9N0b+rEx1CjD3ruhychHbnDhnHr4cw5SMddqfxtMgb9PMYybmhxkeixPiMDvQ4daj1KXTvI+wOVSSCjH8yR9DxZ+9+A+d9RXUvXqZb+s4yGhP2TqrazNpwkowRGQOa62ydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560213; c=relaxed/simple;
	bh=84hAe/1TSuKK66QqhSZq5idGiTsPqshLum2RSxTO+RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6/tB0hqw9ESlWzWXS6eHWog5rr3EDdMxKHMr9YmpxfPzOo6OFLjS+XeDtAtOLlbyt8bVUsCyByR3LMlob7xly3ylcrtUg8sXNWZ5wA7zzFqqrjqcq3o5ynePG5jAkhh3nEyi+tpbAbArnTJeXna5P5tTZbjVceMNpAacTPVbhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXHIK1/r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXHIK1/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D991F000FF;
	Fri,  9 Oct 2026 15:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791560212;
	bh=qEJJ+7mD4Baz1SpzT1AGFxKG4IHPQFBm1jwu2Ji5JI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lXHIK1/reBVeGnlsaBujeu/7RMEPkWbJe/SMH1OVqOCq2Ud4LFiMx9eeXAxmKI2/j
	 Y7o5bxgp+2EhsNGgg3VdYYfFC+JfLUufUmRSVUvyCMnlZRvjqvd+6VAWTiTDOyz/mB
	 zwzothjRfR6Ee+KzTSp28t7mKFw63nIXMG78+zzUNz+EIDd+UmB4Nv4RLj4goJxEKQ
	 kVl3I8TQx/Tars23dqUT4DTrMN7z3L6QPSJ13Y2qCFNFBrcanAh3kw3Zui51frsSPD
	 FHljlBVJf1p7a7tnfQP09iQPr2yHxypWocM7dakpt6YIvkw1JUnY0+/GUGEuz/q10D
	 ccVwz0il9hUng==
Date: Fri, 9 Oct 2026 16:36:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: rzn1: add resets property
Message-ID: <20261009-7b4b54034fafb7ad60ea917d@squawk>
References: <20261008201953.34307-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FWfzAmcVSQzNSq7T"
Content-Disposition: inline
In-Reply-To: <20261008201953.34307-2-wsa+renesas@sang-engineering.com>

--FWfzAmcVSQzNSq7T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2026 at 10:16:53PM +0200, Wolfram Sang wrote:
> The RTC on R-Car X5H does have a reset unlike the other versions.
>=20
> Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>=20
> Passes both DT checks. Kind of fixes 3b3fdc9fd40d ("dt-bindings: rtc:
> rzn1: add R-Car X5H support") in -next, but we don't use Fixes: for
> bindings, or?

If you want, make it more obvious IMO that this is a correction.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

>=20
>  .../devicetree/bindings/rtc/renesas,rzn1-rtc.yaml          | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml =
b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> index b448725671ec..5a869e6c0ae7 100644
> --- a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> @@ -51,6 +51,9 @@ properties:
>    power-domains:
>      maxItems: 1
> =20
> +  resets:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -85,7 +88,11 @@ allOf:
>        properties:
>          interrupts: false
>          interrupt-names: false
> +      required:
> +        - resets
>      else:
> +      properties:
> +        resets: false
>        required:
>          - interrupts
>          - interrupt-names
> --=20
> 2.53.0
>=20

--FWfzAmcVSQzNSq7T
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaskKCwAKCRB4tDGHoIJi
0q+hAP9dLmw044mVRadnXQzaTwUaybi6fjTRy4wkphrhQ+x5zAD8DrhowHwPYqOj
W+ilXoW9KA9RS6akP20Z8eR8OaqVMgM=
=Ajk1
-----END PGP SIGNATURE-----

--FWfzAmcVSQzNSq7T--
