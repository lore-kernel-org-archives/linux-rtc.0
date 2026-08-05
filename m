Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C453D300F
	for <linux-rtc@vger.kernel.org>; Wed,  5 Aug 2026 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785961945; cv=none; b=Pz4Tk9YNv0j34GXUOXfAlOUJrLEHBkK+0h8UTBVVgMa1ls+Iodm5LoriePlZB/5ZDdm++MPsQX/zdm4pJfnOm4TFpGDttgZPn755v5kcMmqJGqDLyufbegDQj7XlADGquTyKz0HJcorsm27MlSVmvM++3e3/vLYYaSXxGxUurkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785961945; c=relaxed/simple;
	bh=GC5WfBi3pdSkQqvBpqhAWTY2/zB7h83BVsN553sPxIc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KoLvWhrmJOIBG0NAkccxC/aMyWVsihYyr0celft5A6zKIfW+MIMg5MGF5b+wZgCRn3EeqnK9NK/r0iue0zVs42IHEpjNA1n1RPXL4qjPIZmVzr1g9W4Ea/tq+Clj05s2wV+kRdWIC8RHy9C4T5WhmZF0brhGO5qT5M+90LMc7pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=j1FUuIVk; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="j1FUuIVk"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 02DAA24002D
	for <linux-rtc@vger.kernel.org>; Wed,  5 Aug 2026 22:32:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1785961941;
	bh=oqrGtEQIh0Mq/RQtbS30gLn+prr4+6xwg8RlNlqwgYY=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=j1FUuIVkfrKyagXbEcCsyJdN3NuL1uBNXBWBSIalYcktnOBflrZg0EjPBw1J/w+EB
	 6GwY6DhV+GReXBh0yuI8GDMxXj1LmYCesHm/cY5U3woUalrZrvdc3K/zFQCSb6tTvr
	 acXxo231h042+BAZacQKj//1nXfbuDHtMnl8UQrS6cMEYhlTgae3VGuSgQO84GzfRK
	 DsKWEhKvmNl0Sx19dCVOB4shaqvlmpd2Es1HfwX4Z7PJzLndykcVmFRLTAnQjcNCW0
	 RN0hNoBqIUJobXxzgKhdZDcvCnQMAPMgBTxbLLIqccIxCaESddeYES0nxxp2bqpqFO
	 5g1J80+91ycug==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hFhst3B87z9rxN;
	Wed,  5 Aug 2026 22:32:18 +0200 (CEST)
Message-ID: <d4912a33dee21a57d29ed4cc3692a8b72db522b0.camel@posteo.de>
Subject: Re: [PATCH v3 1/5] dt-bindings: rtc: Add pinctrl for S35390A
From: Markus Probst <markus.probst@posteo.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	 <uwe@kleine-koenig.org>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement
	 <gregory.clement@bootlin.com>, Sebastian Hesselbarth
	 <sebastian.hesselbarth@gmail.com>, Michael Langer
	 <michael.brainbug.langer@googlemail.com>, Andrew Morton
	 <akpm@linux-foundation.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 05 Aug 2026 20:32:20 +0000
In-Reply-To: <20260805-rtc_s35390a_int1-v3-1-e836faba3e25@posteo.de>
References: <20260805-rtc_s35390a_int1-v3-0-e836faba3e25@posteo.de>
	 <20260805-rtc_s35390a_int1-v3-1-e836faba3e25@posteo.de>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-YHHTGLRZcmpMmgroGyKa"
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-YHHTGLRZcmpMmgroGyKa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-08-05 at 19:32 +0000, Markus Probst wrote:
> Synology NAS devices use the output pin for interrupt signal 1 to wake up
> the system.
>=20
> Move devicetree bindings for sii,s35390a into its own file.
> Add necessary properties to configure the individual pins via pinctrl,
> which allows the interrupt signal 1 to be used for wakeup alarm.
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  .../devicetree/bindings/rtc/sii,s35390a.yaml       | 109 +++++++++++++++=
++++++
>  .../devicetree/bindings/rtc/trivial-rtc.yaml       |   3 -
>  MAINTAINERS                                        |   1 +
>  3 files changed, 110 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml b/Doc=
umentation/devicetree/bindings/rtc/sii,s35390a.yaml
> new file mode 100644
> index 000000000000..0355f17f233a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/sii,s35390a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: S-35390A 2-WIRE REAL-TIME CLOCK
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +
> +description:
> +  The S-35390A is a CMOS 2-wire real-time clock IC which operates with t=
he
> +  very low current consumption in the wide range of operation voltage.
> +
> +allOf:
> +  - $ref: rtc.yaml#
> +
> +properties:
> +  compatible:
> +    const: sii,s35390a
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +    description: Supports up to 2 interrupt lines via the INT1 and INT2 =
pins.
> +
> +  wakeup-parent: true
> +
> +  wakeup-source: true
> +
> +  "#clock-cells":
> +    const: 1
> +
> +patternProperties:
> +  "^pins":
> +    type: object
> +    patternProperties:
> +      "-pins$":
> +        type: object
> +        properties:
> +          pins:
> +            $ref: /schemas/pinctrl/pinmux-node.yaml#/properties/pins
> +            items:
> +              enum:
> +                - int1
> +                - int2
> +
> +          function:
> +            $ref: /schemas/types.yaml#/definitions/string
> +            description: |
> +              Pin function:
> +              - ignore:  Preserve the previous state.
> +              - disable: Disable pin output.
> +              - wakeup:  Output wakes up the system.
> +              - clock:   Output clock pulse.
> +              - pmin1:   Minute periodical output with 50% duty.
> +              - pmin2:   Minute periodical output L for 7.81 ms.
> +                         Can only be used with pin int1.
> +            enum:
> +              - ignore
> +              - disable
> +              - wakeup
> +              - clock
> +              - pmin1
> +              - pmin2
> +
> +        required:
> +          - function
> +
> +        additionalProperties: false
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        rtc@30 {
> +            compatible =3D "sii,s35390a";
> +            reg =3D <0x30>;
> +            pinctrl-0 =3D <&rtc_pins_default>;
> +            pinctrl-names =3D "default";
> +
> +            wakeup-parent =3D <&int>;
> +
> +            rtc_pins_default: pins {
> +              int1-pins {
> +                pins =3D "int1";
> +                function =3D "wakeup";
> +              };
> +              int2-pins {
> +                pins =3D "int2";
> +                function =3D "disable";
> +              };
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Doc=
umentation/devicetree/bindings/rtc/trivial-rtc.yaml
> index f4d0eed98a08..7b3f682ef4d5 100644
> --- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
> @@ -81,8 +81,6 @@ properties:
>        - ricoh,rv5c386
>        # I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
>        - ricoh,rv5c387a
> -      # 2-wire CMOS real-time clock
> -      - sii,s35390a
>        # ST SPEAr Real-time Clock
>        - st,spear600-rtc
>        # VIA/Wondermedia VT8500 Real-time Clock
> @@ -105,5 +103,4 @@ required:
>    - reg
> =20
>  additionalProperties: false
> -
>  ...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5114e6db7307..4c8bc35cfe55 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22695,6 +22695,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/=
git/abelloni/linux.git
>  F:	Documentation/admin-guide/rtc.rst
>  F:	Documentation/devicetree/bindings/rtc/
>  F:	drivers/rtc/
> +F:	include/dt-bindings/rtc/
>  F:	include/linux/rtc.h
>  F:	include/linux/rtc/
>  F:	include/uapi/linux/rtc.h
This hunk should be removed.

Thanks
- Markus Probst


--=-YHHTGLRZcmpMmgroGyKa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmpzndEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSW7MP/R+DKRnlq2TKQNEX5aF6
xNbEmDv3HbKlTbQ1HWrBqpVbGMAkCmX42QNITv0YrECVN/74dlqfvS+gSWNYVKsc
VHGoLcJPNvjQraFvKNfI9e8bpozlSMNgmLTw35i+5/mA1T1UybOn26z5WzpnUat3
7DiOYsxPomsj+HvitUFbo3l/U/gvTrqJrPXNDQDm8jW+O4fIYZ+ERJi8kNaHV52v
313Lp5xCcN90mdEz/U1eGl1Pyaf/kIwmLoEdoORYF3zZhrQsfNPc2RXhC9hRCl+v
z41b9RCnfPhHCgt3JsvDcv1B11OTmA1HR6PeX9sxTax0k+xX0EV15tonkYjEB/WA
MbaDUSCxLOwBDU8hkLNqzIovrW8oNThzT6HErUUuaupJeMIaVQpNhH4yi4yTkAVz
vfLyFj/jOWg0UJW05cPC9U5Q14+NjnhZTcySIoKvcrZplUSqJp5CpqFLmKMjMJoJ
gVl/KvEdyyH4WfMkUH3Wdsspc/w4wR9g/DWVLMfqG/pAeXgBMX6Df1s0Y+O/2TvU
PayR4C7QnztgiWNQe2DsDldy+R1eXmBVQqFNHiAoqcxnmbxzhpNxzgnsR1FEr1l/
s/k5y8N5h/wYo/Cl/Tr2f9isE+zdU3fBeYCnkq2I9dM46zQyfnMhB8rhgm2cN4cT
KSPO6QJag9O0lE+gZvvfI9ll
=E2qu
-----END PGP SIGNATURE-----

--=-YHHTGLRZcmpMmgroGyKa--
