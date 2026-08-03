Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82890348C4A
	for <linux-rtc@vger.kernel.org>; Mon,  3 Aug 2026 23:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785799997; cv=none; b=JKeI4DmdJ0I4jbBvpxdIs2TcFrFkC84MgTROqNe1IW60/IsCCuavvAxSGW4h/KQIVmpBGj4z1rB5Da1j1yzfQDqRVWr0KI0GkLQjmL62kvCRF4WyDdMFz5xfdv+xvIM0gF9FkxiyWEE9z1XTaGWThz0a9cb4ZzUwvOgKz0EZi20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785799997; c=relaxed/simple;
	bh=4VaDfl6DohQthRdBboo6zsO+D8r9sqcTOUQcn49qNgU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PQ6CbqR5mZAOfFKVz1BSXHXnmA1oqcTAnQGtucSBYeC6FG4thkL0MUa6Q3uCUTNA4vXxbhxmuJILTGZSBkde4UPneVYd8MNsxvPMGJjvzgrCdRWEIckNSqOqm9TDgbJXHeGsY9JdwA69TS1H7OZNrSzOxBzIQOXj4NEZrFufKFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=Qxm2eIFR; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Qxm2eIFR"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 37AB524002A
	for <linux-rtc@vger.kernel.org>; Tue,  4 Aug 2026 01:33:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1785799986;
	bh=djDWVU6bQAvhKCDIzhiM30Qn0CZVzFT8gIIPI8qW+xo=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=Qxm2eIFRj1/wDqfhFzM9PR/Neemd2Bvgy4sbEnXRKOVyslE+0R/Np2Q3KioeIc1WZ
	 cg/r7rEE/xDd76TUWMLpywhsQPGgRyzZoTy4KKGVeMfygb76jlV/5ZclKhiIE12AZL
	 U2DBFsiKlzPJVhSPb+/N0b4CQ656JR0hnBZCz+QoV56AEb/FSBKY6G2zRKEXl57M0Q
	 8krpa/59gWpV+svZhNVbzLRXAz9KQtjaT96nPhtWV41tIlvcuqtve0cqkyPOthgpV2
	 5Oik/LM6/umdOtnu5ngjyaZDB12XEU1qTINYUcBu9VcU8/cTvgGeeJ/drbQin0nIN2
	 ELO8t/xKhNBHQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hDXzM1jLnz9rxB;
	Tue,  4 Aug 2026 01:33:03 +0200 (CEST)
Message-ID: <7af047ae0fae27e8bef3d8decdc97a21ee9bf520.camel@posteo.de>
Subject: Re: [PATCH v2 1/5] dt-bindings: rtc: Add pinctrl for S35390A
From: Markus Probst <markus.probst@posteo.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	 <uwe@kleine-koenig.org>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement
	 <gregory.clement@bootlin.com>, Sebastian Hesselbarth
	 <sebastian.hesselbarth@gmail.com>, Michael Langer
	 <michael.brainbug.langer@googlemail.com>, Andrew Morton
	 <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 03 Aug 2026 23:33:05 +0000
In-Reply-To: <20260803-mottled-pretty-sloth-bf7dbd@quoll>
References: <20260801-rtc_s35390a_int1-v2-0-f10c99ad1d6c@posteo.de>
	 <20260801-rtc_s35390a_int1-v2-1-f10c99ad1d6c@posteo.de>
	 <20260803-mottled-pretty-sloth-bf7dbd@quoll>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-WE5p0wNFoNN4V4RC6yVN"
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-WE5p0wNFoNN4V4RC6yVN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-08-03 at 11:56 +0200, Krzysztof Kozlowski wrote:
> On Sat, Aug 01, 2026 at 06:43:00PM +0000, Markus Probst wrote:
> > +  wakeup-parent: true
> > +
> > +  wakeup-source: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +patternProperties:
>=20
> This goes after "properties:" block.
>=20
>=20
> > +  "^pins":
> > +    type: object
> > +    patternProperties:
> > +      "-pins$":
> > +        type: object
> > +        properties:
> > +          pins:
> > +            $ref: /schemas/pinctrl/pinmux-node.yaml#/properties/pins
> > +
> > +          sii,mode:
> > +            $ref: /schemas/types.yaml#/definitions/uint32
>=20
> Use simple string. See pinmux bindings.
>=20
> > +            description: |
> > +              Modes for the specific pin:
> > +              - S35390A_MODE_IGNORE: Preserve the previous state.
> > +              - S35390A_MODE_DISABLE: Disable all interrupts.
> > +              - S35390A_MODE_WAKEUP: Used for waking up the system.
> > +              - S35390A_MODE_ALARM: Userspace defined alarm.
> > +              - S35390A_MODE_FREQ: Periodical at configurable frequenc=
y.
> > +              - S35390A_MODE_PMIN1: Minute periodical output with 50% =
duty.
> > +              - S35390A_MODE_PMIN2: Minute periodical output L for 7.8=
1 ms.
> > +                                    Can only be used with pin INT1.
> > +              - S35390A_MODE_32768KHZ: Raw 32.768 kHz output.
> > +                                       Can only be used with pin INT1.
> > +            minimum: 0
> > +            maximum: 7
> > +
> > +          sii,frequency:
>=20
> Frequency needs -hz, but anyway if this is becoming a clock, then you
> must have clocks property and this is simply not needed... unless this
> is some periodical wakeup call, not a clock? Then simply -hz and
> property must be more descriptive (frequency of what? pulse?).
Yes, it would become a clock if configured. But in this case, the
"clocks" property seems to be a clock consumer property. It would be
providing the clock signal.

Anyway, it was added since it was only ~10 lines of code. Looking
through documentation, using the clock subsystem might be a bit more
driver work.
Since I don't have a specific use for it, I will drop it in the next
revision.

Thanks
- Markus Probst
>=20
>=20
> > +            $ref: /schemas/types.yaml#/definitions/uint32
> > +            description: Frequency in Hz to be used with mode S35390A_=
MODE_FREQ.
> > +            minimum: 1
> > +            maximum: 31
> > +
> > +        required:
> > +          - sii,mode
> > +
> > +        if:
> > +          properties:
> > +            sii,mode:
> > +              const: 4
> > +        then:
> > +          required:
> > +            - sii,frequency
> > +        else:
> > +          properties:
> > +            sii,frequency: false
> > +
> > +        additionalProperties: false
> > +
> > +    additionalProperties: false
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/rtc/s35390a.h>
> > +
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        rtc: rtc@30 {
>=20
> Drop unused label
>=20
> > +            compatible =3D "sii,s35390a";
> > +            reg =3D <0x30>;
> > +            pinctrl-0 =3D <&rtc_pins_default>;
> > +            pinctrl-names =3D "default";
> > +
> > +            wakeup-parent =3D <&int>;
> > +
> > +            rtc_pins_default: pins {
> > +              int1-pins {
> > +                pins =3D S35390A_PIN_INT1;
> > +                sii,mode =3D <S35390A_MODE_WAKEUP>;
> > +              };
> > +              int2-pins {
> > +                pins =3D S35390A_PIN_INT2;
> > +                sii,mode =3D <S35390A_MODE_DISABLE>;
> > +              };
> > +            };
> > +        };
> > +    };
> > diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/D=
ocumentation/devicetree/bindings/rtc/trivial-rtc.yaml
> > index f4d0eed98a08..7b3f682ef4d5 100644
> > --- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
> > +++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
> > @@ -81,8 +81,6 @@ properties:
> >        - ricoh,rv5c386
> >        # I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
> >        - ricoh,rv5c387a
> > -      # 2-wire CMOS real-time clock
> > -      - sii,s35390a
> >        # ST SPEAr Real-time Clock
> >        - st,spear600-rtc
> >        # VIA/Wondermedia VT8500 Real-time Clock
> > @@ -105,5 +103,4 @@ required:
> >    - reg
> > =20
> >  additionalProperties: false
> > -
> >  ...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 716acfc3d7c1..c85be1eefdb1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -22696,6 +22696,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kerne=
l/git/abelloni/linux.git
> >  F:	Documentation/admin-guide/rtc.rst
> >  F:	Documentation/devicetree/bindings/rtc/
> >  F:	drivers/rtc/
> > +F:	include/dt-bindings/rtc/
> >  F:	include/linux/rtc.h
> >  F:	include/linux/rtc/
> >  F:	include/uapi/linux/rtc.h
> > diff --git a/include/dt-bindings/rtc/s35390a.h b/include/dt-bindings/rt=
c/s35390a.h
> > new file mode 100644
> > index 000000000000..dcd0ca15f9e9
> > --- /dev/null
> > +++ b/include/dt-bindings/rtc/s35390a.h
> > @@ -0,0 +1,23 @@
> > +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
> > +
> > +#ifndef __DT_BINDINGS_RTC_S35390A_H
> > +#define __DT_BINDINGS_RTC_S35390A_H
> > +
> > +#define S35390A_MODE_IGNORE		0x0
> > +#define S35390A_MODE_DISABLE		0x1
> > +#define S35390A_MODE_WAKEUP		0x2
> > +#define S35390A_MODE_ALARM		0x3
> > +#define S35390A_MODE_FREQ		0x4
> > +#define S35390A_MODE_PMIN1		0x5
> > +#define S35390A_MODE_PMIN2		0x6
> > +#define S35390A_MODE_32768KHZ		0x7
> > +
> > +#define S35390A_MODE_INT1_MAX		0x7
> > +#define S35390A_MODE_INT2_MAX		0x5
> > +
> > +#define S35390A_FREQ_MASK		0x1F
>=20
>  don't get why this grew. None of these look like bindings.
>=20
>=20
> > +
> > +#define S35390A_PIN_INT1		"int1"
> > +#define S35390A_PIN_INT2		"int2"
>=20
> Drop entire header.
>=20
> > +
> > +#endif /* __DT_BINDINGS_RTC_S35390A_H */
> >=20
> > --=20
> > 2.54.0
> >=20


--=-WE5p0wNFoNN4V4RC6yVN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmpxJSEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSeeQQAJiJHHqdtepYKqV8bn1f
7GnPjLKXPm4ovd1ERvFtZssRegwaHA3BUiBGqcelTWyIqofLv9v8TjBli4xrxwd2
cKW6jOC/Xzbx37Cl90E+iSKQyxT1Bu6HS5Mk9+FC+ep8pL4a8EH9NyIdFDG17gc+
eS45B0WM20oEH/udzt6qk6UJNVjkEJmkMs09mzq1QOCTj7vJyCTYB3adlwOui47n
h1r1I5e9ZisU1WGfKgBBk9Gm+lX/uDOfDlYG6BaH7Mb7gOcrYqCuLGysGQJVridO
uf17IzliwtLic1kHBAU4NFlNSMMhncyjqrZkHHvXPxgul6CEYhj3V0uF/x9uFcra
Zw/wvhA+WSg/tW35LEhEocq+jArhuL0h/vePrp5JvPIgvm5wSGeccKlEHyKjx7Eq
scdZxvQLbIGj5peZfcwAiDN+u/2oyLFiD6sk2j7SMqIR7E94kYL0D3o0UZ0dZVLA
UTxw9J7M1kgcwzPZn8E7OAN1nWNmfECANidMH6aZ+rFdlxY4PNBFuDjzCipChCNd
arfl9ZLEUYQ5R1nBHaXQrdBYBHt8Hbdup+E0oAOLQUSqKwlFeZ1/8Z32aB3qVNBf
zudZq2CVMiT5rrATyZXjqh+qoITD5+ULhmAz+h6VpHYfirsa27asRaOeigBo3CsO
XEozlYZAQZK39Mxrfg471VLA
=q6sH
-----END PGP SIGNATURE-----

--=-WE5p0wNFoNN4V4RC6yVN--
