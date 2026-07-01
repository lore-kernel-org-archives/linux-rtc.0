Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63426375F81
	for <linux-rtc@vger.kernel.org>; Wed,  1 Jul 2026 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924197; cv=none; b=m8JY8Ij9XXBD1SJ7oXjzneJmd7yDD2SJYubpO+c7oUWvzdNLXJeDE5TR3LQOEuwqxhhWkRQ0NY+pDyaKuAf/f8tCx8JWI7oqld/HsnRws+yPoK9y7BWPY7nvJsaamFx4kjNaabE8NuQE+lpcIKVMJfYFojDMszAkio6Uo6qMEoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924197; c=relaxed/simple;
	bh=K5UvUCKLk87TSsBR25eiYQhn4EFgvgqmhzh9xmlby5s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fqVgz97FjE19MPWDvs32RMe1XWA8C7XxC72iB/m4kqH5fpcyRSt3odsIlDuUJOz1GXOLeITOpcRCFRqFAGUxc+vYPZ+MUqf3rd7zIY6vUWFrNfK26BLl1YgcwE+OiLNjS/gjsjrxEhxCq+SImluT+poB+JQSI0cXlRsgqTIGDcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=rsuRhl3D; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="rsuRhl3D"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id C6FE724002D
	for <linux-rtc@vger.kernel.org>; Wed,  1 Jul 2026 18:43:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1782924187; bh=h6G6oRgORHVYJo/knBtQJKa5dpje2k0WnY1iIjqH1yE=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=rsuRhl3D5asDldg1wXWaNCrYv2yQ/vpElg+E7UsU8Pzf6vVNNb1y8eO9GfIJWBcxK
	 l3XayJyMKN7lW58TgP1xaH1S2pjJ3VpA51h7hxDFYjBGDr2/rbBjJB/g0jQJmPLZIB
	 KxYucZpBn6PTc/Vu5/yF2yH1x1dsvIBDc4UONMp2F4B/PBulGjoCKt8UV1xp3Mfqu5
	 53f50UhZ4sTUkxmUE/Qb4TCKdsNufgZCzPzSPu5IWieGi7UbXItjuqzuMeNMr/s7jd
	 NPnkQzlnMH+L2WmQ3/rITS/xj7qePTulR10Y6ygeYAk2r3Uk8OCbHWT480yHdlubx+
	 pP9+gGa+rHzpw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gr5RY3WfGz6tvq;
	Wed,  1 Jul 2026 18:43:05 +0200 (CEST)
Message-ID: <d06dd0726aa3795ae99df5fa8a9c05d6e2001efd.camel@posteo.de>
Subject: Re: [PATCH 1/3] dt-bindings: rtc: Add sii,wakealarm-output-pin
 property for S35390A
From: Markus Probst <markus.probst@posteo.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	 <uwe@kleine-koenig.org>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement
	 <gregory.clement@bootlin.com>, Sebastian Hesselbarth
	 <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 01 Jul 2026 16:43:07 +0000
In-Reply-To: <7de66163-369e-4118-af51-6913b565fa4b@kernel.org>
References: <20260630-rtc_s35390a_int1-v1-0-1b2239e16be2@posteo.de>
	 <20260630-rtc_s35390a_int1-v1-1-1b2239e16be2@posteo.de>
	 <20260701-bronze-jaguar-of-perfection-028bac@quoll>
	 <45e8157be53c3d8827fcccece7f706968bc056d3.camel@posteo.de>
	 <7de66163-369e-4118-af51-6913b565fa4b@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-nC+OGHgEd8Indof71zb6"
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-nC+OGHgEd8Indof71zb6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-01 at 17:14 +0200, Krzysztof Kozlowski wrote:
> On 01/07/2026 15:25, Markus Probst wrote:
> > > > +
> > > > +maintainers:
> > > > +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> > >=20
> > > This should be someone caring about this hardware.
> > He does have the majority of commits on this driver (excluding merge
> > commits and commits not exclusive to this driver), although most of
> > them are pretty tiny.
> >=20
> > Who would you suggest instead?
>=20
> Someone adding features for this driver, maybe driver maintainers. But
> if Alexandre is fine, you can leave him.
>=20
> > >=20
> > > > +
> > > > +description:
> > > > +  The S-35390A is a CMOS 2-wire real-time clock IC which operates =
with the
> > > > +  very low current consumption in the wide range of operation volt=
age.
> > > > +
> > > > +allOf:
> > > > +  - $ref: rtc.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: sii,s35390a
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  sii,wakealarm-output-pin:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    enum: [1, 2]
> > > > +    description: |
> > > > +      The output pin to wake up the system.
> > > > +      Default will use the output pin for interrupt signal 2.
> > > > +        <S35390A_OUTPUT_PIN_INT1> : Output pin for interrupt signa=
l 1
> > > > +        <S35390A_OUTPUT_PIN_INT2> : Output pin for interrupt signa=
l 2
> > >=20
> > > Does that mean device generates the interrupts?
> > Yes.
> >=20
>=20
>=20
> Then I think you miss interrupts property.
=46rom what I can tell the line is used to generate a system wakeup
event.

There would be no obvious benefit of connecting it to an interrupt
controller, so this property would be obsolete?

Thanks
- Markus Probst

>=20
> Best regards,
> Krzysztof

--=-nC+OGHgEd8Indof71zb6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmpFQ4cbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSFI8P/3g9wc/GMAAirV36quML
+9GQDRlBJXSizRsPFYQAjN9Qi3KS3SOK3g+EMCdzOl7WoIc8f/lP2x1qtL5w1vus
6MH+CjY9OmWeQPSenS8wjEjwxyEhUGMPZdsfOz/Tr17wxf9+G3NKogTOYDZ03Bli
iH+mjDH+ZXFtsm3ZBaTzqkEWjmeCi+OIVHf0hMCWCqEtWFBFVwIaFLtO8YsaOQui
6+nf5Yz1AHWi5qhVNpnXXA48Zr0n+tz/gz80b7BrNS/p62fJFPxtE43yN6sAT+Ad
QZOEblmA1hlM+l6Ptjvg8H+zOsxyExvp1GXORnwX3YQaoKNxp8j5/evGjDCSUsem
IxghOTDcT8UukAnc043EtlhN20t5i7DRj8CvRZ3Z4vLcTatc16bfuffqnzGtSGlO
y9+3Pk0+42rw/1TgviNtmlVeSLh17h5GUWekO/vtOa0kt6J/Vg0HEx53xkpPSr/5
8m26hdaOv7qCgcNg4iDIVoVuhRhIfzLlqTWlvgrKiuIXbXbs6LD53VqD8q9ifJM+
rnjcl+Tpavi6iI7BOg+3gOO/tSpXF92S4O6hyR4h678q3kqq+VRX+PrK6L7PRf56
GZ/ngn+UM41wGxpNz39i81LKwcjthvHJDxj9okl28drlux9Tc/Q10URNJWgMtEmn
ROYB9Z0HEt6kJWAo1zMBL/Ym
=9wxf
-----END PGP SIGNATURE-----

--=-nC+OGHgEd8Indof71zb6--
