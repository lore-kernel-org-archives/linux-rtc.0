Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A92047ECE7
	for <linux-rtc@vger.kernel.org>; Tue,  1 Sep 2026 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269321; cv=none; b=WSuPgqjDCxfYFFKbWA4cR/vwZm0pQcS8KzCk2tZa8iH20Vi+ppfJkPHyND3SxqXaYjX3tD83oLDIDnndZDDlkIqA71yNLPWztidsnh/DkdeoYtLn/KiA0EkqxVgjIJX96pT7QP19noYKUP1STQdMqa9JmOuICrwjdA8tcw7r8Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269321; c=relaxed/simple;
	bh=MUq/5ZoiCfWabfKDlFl7q+tz6E/EDZ9wlA4CyFJOWNk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=To5yFCY5EAAoNaH63yZ6A6XIsqirs+z91InF6SMnW5vIlEUPJzmxbgZo9yCL5lrI6JPWYN3EnDeAcuUvO/H2QW4gnKLKzoFUsx1MdZoI2lTo/Z9rDuuf++c36ccJcat2i5UY4ilN8iPdCDhLiBTj/45RIGPjwqrbp8NLc6jRBTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=EAgluykf; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="EAgluykf"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 37CF7240107
	for <linux-rtc@vger.kernel.org>; Tue,  1 Sep 2026 15:28:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788269317;
	bh=vUM+yN+wV2Rum2NOiWGNEq7ms74eqAhRWAUvws9oiXc=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=EAgluykfAjkRXM1DT8Typ2YUTHMMjJyBZEaJWN25o3SPept1PGpq6pWpAyGgRNYm+
	 ITCZaWPgb7aeAHVrS12l2xZy/FJbEZtPgvlE+ahrNMW7/kcHM8ayN1LaqRtga9xGlE
	 /oQ/UkGQwwKfNUtbZNFnCE2xjaCANnqeib+ot6DPAhZySVjAXZWKJUurPWJsaxrgNK
	 lnRlAYqZaNpe50gCz+kSArDkCavOODkJaCeJH6m7yFf1JPyXCPF8v2xwuye78LIn/c
	 1HZ4S//1N9A34INu/OiVg64XZmipGdhLO8M6fwe+ddIySzSCOGjUpq49qsVsacztrq
	 /FY7gkAc6Yefg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hZ6BV3xF4z6tyW;
	Tue,  1 Sep 2026 15:28:34 +0200 (CEST)
Message-ID: <c4b9b6c6033774a02be50cf07a6729a6b1e9e5ba.camel@posteo.de>
Subject: Re: [PATCH v8 1/6] dt-bindings: rtc: Add pinctrl for S35390A
From: Markus Probst <markus.probst@posteo.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	 <uwe@kleine-koenig.org>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement
	 <gregory.clement@bootlin.com>, Sebastian Hesselbarth
	 <sebastian.hesselbarth@gmail.com>, Michael Langer
	 <michael.brainbug.langer@googlemail.com>, Andrew Morton
	 <akpm@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 01 Sep 2026 13:28:36 +0000
In-Reply-To: <20260901-proud-furious-bison-0edeec@quoll>
References: <20260831-rtc_s35390a_int1-v8-0-dac1dc86ce1f@posteo.de>
	 <20260831-rtc_s35390a_int1-v8-1-dac1dc86ce1f@posteo.de>
	 <20260901-proud-furious-bison-0edeec@quoll>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-iRkZX+HtzAjTofklDxni"
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-iRkZX+HtzAjTofklDxni
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-09-01 at 12:05 +0200, Krzysztof Kozlowski wrote:
> On Mon, Aug 31, 2026 at 05:42:22PM +0000, Markus Probst wrote:
> > Synology NAS devices use the output pin for interrupt signal 1 to wake =
up
> > the system.
> >=20
> > Move devicetree bindings for sii,s35390a into its own file.
> > Add necessary properties to configure the individual pins via pinctrl,
> > which allows the interrupt signal 1 to be used for wakeup alarm.
> >=20
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
> >  .../devicetree/bindings/rtc/sii,s35390a.yaml       | 117 +++++++++++++=
++++++++
> >  .../devicetree/bindings/rtc/trivial-rtc.yaml       |   3 -
> >  2 files changed, 117 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml b/D=
ocumentation/devicetree/bindings/rtc/sii,s35390a.yaml
> > new file mode 100644
> > index 000000000000..dfe632c4b2c8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
> > @@ -0,0 +1,117 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/rtc/sii,s35390a.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: S-35390A 2-WIRE REAL-TIME CLOCK
> > +
> > +maintainers:
> > +  - Markus Probst <markus.probst@posteo.de>
> > +
> > +description:
> > +  The S-35390A is a CMOS 2-wire real-time clock IC which operates with=
 the
> > +  very low current consumption in the wide range of operation voltage.
> > +
> > +allOf:
> > +  - $ref: rtc.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: sii,s35390a
> > +
> > +  reg:
> > +    maxItems: 1
> > +
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
> > +
> > +  wakeup-parent: true
> > +
> > +  wakeup-source: true
> > +
> > +  "#clock-cells":
> > +    const: 1
> > +
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
> > +
> > +        properties:
> > +          pins:
> > +            minItems: 1
> > +            items:
> > +              enum:
> > +                - int1
> > +                - int2
> > +
> > +          function:
> > +            description: |
> > +              Pin function:
> > +              - ignore:  Preserve the previous state.
> > +              - disable: Disable pin output.
> > +              - wakeup:  Output wakes up the system.
> > +              - clock:   Output clock pulse.
> > +              - pmin1:   Minute periodical output with 50% duty.
> > +              - pmin2:   Minute periodical output L for 7.81 ms.
> > +                         Can only be used with pin int1.
> > +            enum:
> > +              - ignore
> > +              - disable
> > +              - wakeup
> > +              - clock
> > +              - pmin1
> > +              - pmin2
> > +
> > +        required:
> > +          - pins
> > +          - function
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        rtc@30 {
> > +            compatible =3D "sii,s35390a";
> > +            reg =3D <0x30>;
> > +            pinctrl-0 =3D <&rtc_pins_default>;
> > +            pinctrl-names =3D "default";
> > +
> > +            wakeup-parent =3D <&int>;
>=20
> I don't understand this need. Device does not generate interrupts - no
> interrupts property - thus how can it wakeup?
It is just an example.

>=20
> As explained in commit msg, the signal at int1 goes to the SoC, right?
I assume.

> So where does it go? To which pin of which device? &int?
For my Synology DS923+ NAS, I do not have schematics. I only know for
sure from source code that INT1 is used for wakeup and I can confirm
that this does indeed wake the device up.=20

>=20
> Can you show complete upstream DTS using this?
There is arch/arm/boot/dts/ti/omap/am3517-som.dtsi, which has the pin
output of INT1 routed to a gpio pin. INT2 isn't connected at all.
According to the public schematic [1], this looks accurate.


Thanks
- Markus Probst

[1] https://www.scribd.com/doc/60133698/SOM-M2-Schematic

>=20
>=20
> Best regards,
> Krzysztof

--=-iRkZX+HtzAjTofklDxni
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmqW0vQbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSb7EP/0A6hImyam3AZT6bEy9e
tqPzzX/4eg90lRdFBoC07xjNdZy9zEF7/SN1jeWxIssdBIm70G5PqQ4ovL8BN5uy
4h/06BGhT0JxIYlTUiaJNye1ro3B8TquZJUCWr2s3DYLuim3sGAr366rL2Py6U8D
VooNcKXa68474yEi/cJKQfqF5E5m6pwDaISAKfJcrd0rQA9MitLaLu8iFK+vfKPF
vfM1fdZnMJEiRU1juNsqz1asfpqKOxX+Jn8u9ZEpZfBErnsCpM+sX2MEw7DbD6xw
WpETOiFat1weVALHkGE/seTEasfVJdJcNeAJ51RBpPmva5Yz63wKPugl4siz/WRI
0ECRDwpWQI2567MQOOpk2RtXByYq5sc8TDB/rofz+0sUB4ck5jHyv9eHK72rObbv
EHsK/HcJ0+i/YlFqUqBS8LsjAdZAlvLw0jdBdsUS09p50gLUtAsr4vrFSz/sd21C
bba9qkI+Pz4YvrLvno72CES7EQ7PAt1eFNT/Waudu8Rp/tKWdTbn/1sMOYdZmxLR
ysKzIu6tTTtbL8VPbixjhVo3lAZyB7EteAVPctpnP+w2/UrLW47qP30nP2OJsr+J
AFJoL9Y6j+iW8j7H7utpdRHacuKHEnazT5YeR3wla2h6LWJnrpynsRKCtIgJDs9E
AcViFv6GY9IYjEqxwEnLwuwe
=fvHI
-----END PGP SIGNATURE-----

--=-iRkZX+HtzAjTofklDxni--
