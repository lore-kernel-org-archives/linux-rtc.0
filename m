Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59443803DD
	for <linux-rtc@vger.kernel.org>; Mon, 31 Aug 2026 19:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206060; cv=none; b=qkxSxSscOvRoPyRYQjPjDFwptpa9pYUJkOxUXFzVBSoMb28YIPcIfYDdc6rM6OiyQ6pIrC2e4ONcARb9jtmJ2jF3U745t76Z14vBvdvL/RifFuGB99UuuleBFDhP4weTiY76Hq1BUsLJrO++bpzvmpZsn5C5IaeZk4LSYqVDZkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206060; c=relaxed/simple;
	bh=FnWcAyJS6GrJWXH3EWTDqsYVEpBz5xBx3U0s+hHdp+o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tWZHKQI87w2s37odaaD7NGimctHWKyQ+TarLJM95eEGBhLigApry+rlLYk4dQyuQgIgRkHm3nwII4YHKbhjNJhUUCdq2i7fN7eDecfY7vFVX3+WGyf2vei+LH0gaSsvKCEdvzUUx/4FFCT3nCsqe2M0WqNLOvXZGKBjOfJzpHtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=HhgC4/0u; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="HhgC4/0u"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 75D8F240106
	for <linux-rtc@vger.kernel.org>; Mon, 31 Aug 2026 21:54:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788206056;
	bh=R4p3i2nZc7tOxktctYJYvJS5rRGEnIY0oYLyTSEWSiE=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=HhgC4/0uzV9DHKh+799CZ4vfd63oUyjC/7AAtn48fHelgC4YOImwu79H5p1uatkVS
	 ZiCoG+PyKo7TepFzw9KOC2vqinA9Rk7FlfLvzyBz0y5rAzWHNRLDqkUW8a5DABtW5f
	 TN8f8n5aK/8/fMvsZl5hTxKPqgQx/4PcZN/elrmP+heTGCh7kjTIbGLli2tnCcIP0y
	 pB/iUBe8EsrC+c8Zt0k4aSq9hWKd/MwNglvMCry0c4d1EvRN0tLg5PvovR2JpjTO2J
	 lDbc0gf49f/keHyJ0PO1mkaBPc6IbVOlEWhYE/bOdvkUSerwQw/3U4d1Br8RdQtTQc
	 o9JzUJmzIwX5A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hYfnz3Xjcz9rxF;
	Mon, 31 Aug 2026 21:54:15 +0200 (CEST)
Message-ID: <8cbf37aa8ae970093a9572f70e02e0ba7a368512.camel@posteo.de>
Subject: Re: [PATCH v8 1/6] dt-bindings: rtc: Add pinctrl for S35390A
From: Markus Probst <markus.probst@posteo.de>
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-rtc@vger.kernel.org,  Alexandre Belloni
 <alexandre.belloni@bootlin.com>, robh@kernel.org
Date: Mon, 31 Aug 2026 19:54:16 +0000
In-Reply-To: <20260831195235.6C4931F000E9@smtp.kernel.org>
References: <20260831-rtc_s35390a_int1-v8-0-dac1dc86ce1f@posteo.de>
	 <20260831-rtc_s35390a_int1-v8-1-dac1dc86ce1f@posteo.de>
	 <20260831195235.6C4931F000E9@smtp.kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-PYFvtLagHyqvafs0sVTM"
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-PYFvtLagHyqvafs0sVTM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-08-31 at 19:52 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] DT binding schema strictly requires 2 items for `interrupt-nam=
es` even when only 1 interrupt is defined.
> - [Medium] Incorrect use of `additionalProperties: false` alongside `$ref=
` breaks dt-schema validation and inheritance.
> --
>=20
> commit b7c0d2bd5acb5ccb26e8865062b4b49889e6cf5d
> Author: Markus Probst <markus.probst@posteo.de>
>=20
> dt-bindings: rtc: Add pinctrl for S35390A
>=20
> This commit moves the devicetree bindings for the sii,s35390a RTC into
> its own dedicated schema file. It also adds the necessary properties to
> configure individual pins via pinctrl, allowing the interrupt signal to
> be used for wakeup alarms.
>=20
> > diff --git a/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml b/D=
ocumentation/devicetree/bindings/rtc/sii,s35390a.yaml
> > new file mode 100644
> > index 0000000000000..dfe632c4b2c85
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
> [ ... ]
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 2
> > +    description: Supports up to 2 interrupt lines via the INT1 and INT=
2 pins.
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: int1
> > +      - const: int2
>=20
> [Severity: Medium]
> Since the interrupts property allows minItems: 1, does interrupt-names
> also need minItems: 1?  Without it, the implicit minimum is exactly 2 ite=
ms,
> which will cause schema validation to fail for valid device trees that on=
ly
> configure a single interrupt (e.g., INT1) and specify
> interrupt-names =3D "int1";.

Should be

items:
  enum:
  - int1
  - int2

>=20
> [ ... ]
> > +patternProperties:
> > +  "^pins":
> > +    type: object
> > +    additionalProperties: false
> > +
> > +    patternProperties:
> > +      "-pins$":
> > +        type: object
> > +        additionalProperties: false
> > +
> > +        allOf:
> > +          - $ref: /schemas/pinctrl/pinmux-node.yaml#
>=20
> [Severity: Medium]
> Should unevaluatedProperties: false be used here instead of
> additionalProperties: false?  Using additionalProperties: false alongside=
 a
> $ref to another schema strictly rejects any properties not explicitly
> listed in this block, which breaks the evaluation of inherited properties
> from pinmux-node.yaml as well as generic dt-schema internal properties
> like phandle or $nodename.
Thats intended.


--=-PYFvtLagHyqvafs0sVTM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmqV2+EbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSn9cQALCsu7o5AGk8sZhEM+1t
bEdkda5DmoPpD7qmiUK1tZ1DZlpneH2wWBqoUEJ3RlHCWVgff/N2acoyABGqn/Ha
KDJLJxIH62uzo9+7rDHfPxlGjKW4iY57Ugm7yGGgp64XHntuNQUb+zZGeveIsBmw
RKt3LMKAJHmEAhAoVHnNpchsImCdJURnK0XwrTau7oxM5KC4bm5XhTXZUG1QxdFf
PI17WtFMV8j9tNaEgH0BcToDmkKekc4HqxeihVg9timDDp2sNWzm2eg+bmlbKGmV
rj9o7m8E4CyyNpEoPNU5QhBs088Y+pFlX+pJExiq2AGUoNeeofE/oTvzNZHvoOL6
uYpUOmviXjxFxHtf0XLO5BOABYiNMXMvJEMHGnfmDqFXKAtCo9QBFj92ajPBmC+7
6EhNnH/P+EfPET9syO+DN3wLJzD3xDbCWuqA9uMY4NtYTAsCD05r90NXdhmAFoN/
KJ18xdmmqkvDitANl29YTox4ikkuhFGI4lLEkcLcWCUFnkQgQ/pyeKwlzGpD+MNC
U8pBg2iEgVMr9fsPQQOAHbNHroUrJaQK/k3BAnC/AsRIKZQaJkJ/tD0dfKX45O9l
o8zNiMtTLg42s+YM4f+Vg/mhDmVIITAa3OBuJ4bTDWKbW92yexMXhl2RWwUPVvgU
kqhVMHubprlYa/VIsOk/jw1W
=q4Dv
-----END PGP SIGNATURE-----

--=-PYFvtLagHyqvafs0sVTM--
