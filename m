Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEB44562AF
	for <linux-rtc@vger.kernel.org>; Tue, 11 Aug 2026 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467940; cv=none; b=D18VWbh6Xs0J3d53ZwptxIt0uuqvhMPbVFWvrnfgOKx3GFQ3SCrZzBpG4dSODF9hQ5Z1E+VBO9tgnVUZN0htDI5iYvtcPJoWySvwZwIHKdt3Z5rpsfouXnXCZAGN63Tg1Fve5yT/4G7/wNqvTUtc7ufR6ggB1ps9j2jokKNMe8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467940; c=relaxed/simple;
	bh=y60WQKbnfxxPpZGYQxuPuZXmWaUbdCih368iXeHm9WI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t811BOna5UKsIFnwoNgQVJZAwfPcFhzgjskB+DjP3krqKBJ0oarIYRZs1nvX5lQ/IcnEByDZFQ8XmlLM+9goRysTCLP0qG1fl02tCrNtt31E3/dei1sF4EXaeOD0MH3gB/8+cnpm2ZJKJAkAS7qcbZGnj5X7L8LdDOaRh1tHWq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=P4C9K/fu; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="P4C9K/fu"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id D18CC240028
	for <linux-rtc@vger.kernel.org>; Tue, 11 Aug 2026 19:05:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1786467935;
	bh=nOMPTZKoGJ+jhq7X3DLmn8turldSsuhoUMhsNGxWBMI=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=P4C9K/fu1jYqy+uH1PHKr4Md51RMD2apY7dRsKkJOU6NTgnL+nPRACt3JjDRLrCB1
	 Kse4yGndYQy4tBhUa2GAwCmI/exduQ5Z2Wxn1o6gLAK2UgXTIRYNv3blQAEoQczM+o
	 VN23bpB7bIEH7ZBDfKL95kO5Y6U2mKdVJvNBO9f23vq8nApQufV4tv5ibMaEO4lUjk
	 B8NJ1RBH9QQzH7ymEaUS3rflnsa4kd6/iFafKO783ngQCpeRVmBjDGZ02w8mUHvaZj
	 X7nkHUTdGfw7WW9vnkfTjMzksOWmdfjg4MiCokPVKD7BHPgRk8U+KBg2GGgvvYtYr9
	 +3S1hJ8Dz1L3g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hKJ0Z5j1Nz6twP;
	Tue, 11 Aug 2026 19:05:34 +0200 (CEST)
Message-ID: <de063c2d6fd671af5ab71ff9372a426730b98449.camel@posteo.de>
Subject: Re: [PATCH v3 1/5] dt-bindings: rtc: Add pinctrl for S35390A
From: Markus Probst <markus.probst@posteo.de>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rtc@vger.kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, 	robh@kernel.org, Alexandre Belloni
 <alexandre.belloni@bootlin.com>
Date: Tue, 11 Aug 2026 17:05:35 +0000
In-Reply-To: <20260805202151.3C0C11F000E9@smtp.kernel.org>
References: <20260805-rtc_s35390a_int1-v3-0-e836faba3e25@posteo.de>
	 <20260805-rtc_s35390a_int1-v3-1-e836faba3e25@posteo.de>
	 <20260805202151.3C0C11F000E9@smtp.kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-DNHLbVYBy4pleStj0hu1"
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-DNHLbVYBy4pleStj0hu1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-08-05 at 20:21 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [Medium] The schema describes a hardware constraint for the 'pmin2' fun=
ction but fails to enforce it programmatically in the YAML logic.
> - [Medium] The patch makes an undocumented, unrelated modification to the=
 MAINTAINERS file by adding a non-existent directory.
> - [Medium] The pinctrl child node pattern `-pins$` requires the `function=
` property but omits the `pins` property from the `required` list.
> --
>=20
> --- Patch [1]: [PATCH v3 1/5] dt-bindings: rtc: Add pinctrl for S35390A -=
--
> commit 7fb91877359a278935b0893edcef6e5ae7d9c6a2
> Author: Markus Probst <markus.probst@posteo.de>
>=20
>     dt-bindings: rtc: Add pinctrl for S35390A
>    =20
>     Synology NAS devices use the output pin for interrupt signal 1 to wak=
e up
>     the system. Move devicetree bindings for sii,s35390a into its own fil=
e.
>     Add necessary properties to configure the individual pins via pinctrl=
,
>     which allows the interrupt signal 1 to be used for wakeup alarm.
>=20
> > diff --git a/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml b/D=
ocumentation/devicetree/bindings/rtc/sii,s35390a.yaml
> > new file mode 100644
> > index 0000000000000..0355f17f233a3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
> [ ... ]
> > +          function:
> > +            $ref: /schemas/types.yaml#/definitions/string
> > +            description: |
> > +              Pin function:
> > +              - ignore:  Preserve the previous state.
> > +              - disable: Disable pin output.
> > +              - wakeup:  Output wakes up the system.
> > +              - clock:   Output clock pulse.
> > +              - pmin1:   Minute periodical output with 50% duty.
> > +              - pmin2:   Minute periodical output L for 7.81 ms.
> > +                         Can only be used with pin int1.
>=20
> [Severity: Medium]
> Could this hardware constraint be enforced programmatically in the YAML s=
chema?
>=20
> As currently written, a device tree specifying function =3D "pmin2" for=
=20
> pins =3D "int2" would silently pass dt_binding_check validation despite v=
iolating=20
> the documented hardware constraints. Should this be enforced using condit=
ional=20
> schema logic?
>=20
> > +            enum:
> > +              - ignore
> > +              - disable
> > +              - wakeup
> > +              - clock
> > +              - pmin1
> > +              - pmin2
> > +
> > +        required:
> > +          - function
I cannot add further restrictions in an if statement to the property,
than disabling or requiring it afaik.

>=20
> [Severity: Medium]
> Should the pins property also be required here?
>=20
> If a developer creates a pinmux child node specifying a function but omit=
s the=20
> mandatory pins identifier, the incomplete node will silently pass=20
> dt_binding_check validation but fail to configure the hardware correctly =
in=20
> the driver.
Yes.


>=20
> > +
> > +        additionalProperties: false
> > +
> > +    additionalProperties: false
> [ ... ]
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 15011f5752a99..46a19a0873e06 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -22690,6 +22690,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kerne=
l/git/abelloni/linux.git
> >  F:	Documentation/admin-guide/rtc.rst
> >  F:	Documentation/devicetree/bindings/rtc/
> >  F:	drivers/rtc/
> > +F:	include/dt-bindings/rtc/
>=20
> [Severity: Medium]
> Is this addition to the MAINTAINERS file intentional?
It isn't.

>=20
> This introduces an undocumented and unrelated modification adding a direc=
tory=20
> that does not actually exist in the kernel tree, which may cause maintain=
er=20
> scripts to fail or behave unexpectedly.
>=20
> >  F:	include/linux/rtc.h
> >  F:	include/linux/rtc/
> >  F:	include/uapi/linux/rtc.h

--=-DNHLbVYBy4pleStj0hu1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmp7Vl4bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSSDIP/1qPbdVD96WWsrvK3XZi
m4orKp2ETQYeHnboOl3+uIuFQrZYOY6nl34oVjhhJ4yrB4qe1LbkDJ97T70WTc5a
J5PdfJ9ZY13wjVWD6p4vOFMIjENOxKmmy62AjOFy6QU4DfPZt2MNS3uShqyeZ+6z
/YTezWmr2LbbPl+Mc92N72H9prMY82ZxtUwHGG0eVqiCZhYws7gvHS9ockgKA+CQ
WS0WLOVYFtZqxnbPDqXW11LkBIPWYJXe+GIdYpgixuxA0Luo/UP0j6YVPbaavVWv
Xi8UQeuSQgVs6YdgcihIMfVmcz/Hde1jBX6+OaVnLff9RSABcjeAd6/L2w7KJiu/
TMW24qJ0Won5R5ndJRDj/P22sc2FuJiHnyzlF8uqrXbBi7nNdpJWtaSS7KOl8nMB
bPo4MxLddxC99dpnRgId1vRJRjOl9CSflgClKgbT6LaBeYFBuqQRjc3yQkaeCXLw
xuoGcITBU33O9Ix0mO1KwogZG1+Gp0f4Atd82AGv7mxkXfbkX5SuTYkb/JnfI0nW
iisBB4D0Zi3MWkjYajZzmCmUE/lQNYrSLs8v4L3Mv8c78Fu1CxVbFieL/pyQRZ5w
B11R6UyT8nsPT7m6PkRO1OZ7T6l/FK/+XciIu3f1N32jN65AuM53veR3jv65gDfs
jPZ3PglS+7yMQZipvoNwj0LY
=aw9u
-----END PGP SIGNATURE-----

--=-DNHLbVYBy4pleStj0hu1--
