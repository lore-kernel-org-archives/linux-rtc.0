Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325BC339383;
	Mon, 31 Aug 2026 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194832; cv=none; b=NFlNkP3Xjkt2lGDUvj5UIdxiRRYyEM0vbOJ6/Ksqd/X++i6wj89vd3ZCmx++hyS9OPuTk70UtLIpSqO5UbN0tPeuKhhv9+WA9RD2Cxa/qouKeJt4wvms+lYOrmTCCA48rpeUHW6EIoJLf6BWmpk1y0gV6SOo94dIwMU+uuXs3Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194832; c=relaxed/simple;
	bh=0IGJ/VMBc0hNIKINVYD78fctDJOxqDY1t0Xdvc9VFQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdiz7G6PYG1sCCfx5YM4rzZSj3X+LnZcFDmDHVhsy3ESeijFnE92HOg6/gEfINiRzcevpgGG433ywFeB5jf1V3lIbS8wZWE++HN00dNF897f66LcK+80IwCElKw0KqHP+rViAffuqzt1Y0E+9nJ5P/rIQBnTI0hu/zdTgmFNhIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOA81gsL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOA81gsL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7644F1F000E9;
	Mon, 31 Aug 2026 16:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788194830;
	bh=ZirCIc9EB7gtC4ijBO/mp3VXtz/a+lJqEgBTzaSoBGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eOA81gsLbzo0G6Gp7gAbct5ooY0TMVh6T3outXooj1QVXbDFGdeVdLoFdKxSFOYbA
	 +edDxXzPXn6rdIkWDxOgsATtReLQWAQvXgdioNuUkIqAF/v6nwUMJd0/gg76Xvk8cl
	 6y9yiLsDGNi1cLzu0c8TsrXp4ZrRLlKkXHCL+ehmGe3ZKPobQBiu2UQleLzJb4o+Cs
	 UhxNS07lRalE3Tw1c2x6xJzf1sEdL7xNQAGmivKPUIWh1PpWEgsuDl5v4HWMQSvwaL
	 OhX5orc+5pKrEzzZMZz2uHHAZMs05ExxtGGcvUhH0/d0JdQsGR0f4mEZElbULw5pIV
	 8gleQREfAxHOw==
Date: Mon, 31 Aug 2026 17:47:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Michael Langer <michael.brainbug.langer@googlemail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/6] dt-bindings: rtc: Add pinctrl for S35390A
Message-ID: <20260831-theorize-unnoticed-1e6ac97d5369@spud>
References: <20260829-rtc_s35390a_int1-v7-0-debcd31143ae@posteo.de>
 <20260829-rtc_s35390a_int1-v7-1-debcd31143ae@posteo.de>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/S+o0lYrnjJZ6O8r"
Content-Disposition: inline
In-Reply-To: <20260829-rtc_s35390a_int1-v7-1-debcd31143ae@posteo.de>

--/S+o0lYrnjJZ6O8r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 02:22:56PM +0000, Markus Probst wrote:
> Synology NAS devices use the output pin for interrupt signal 1 to wake up
> the system.
>=20
> Move devicetree bindings for sii,s35390a into its own file.
> Add necessary properties to configure the individual pins via pinctrl,
> which allows the interrupt signal 1 to be used for wakeup alarm.
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  .../devicetree/bindings/rtc/sii,s35390a.yaml       | 111 +++++++++++++++=
++++++
>  .../devicetree/bindings/rtc/trivial-rtc.yaml       |   3 -
>  2 files changed, 111 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml b/Doc=
umentation/devicetree/bindings/rtc/sii,s35390a.yaml
> new file mode 100644
> index 000000000000..d9da3abbbd51
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
> @@ -0,0 +1,111 @@
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

Probably this should be you!

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

I think you need interrupt-names here, so that you know which is which?

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
> +            minItems: 1

This construct here seems overly complicated.
You should be able to do
    patternProperties:
      '-pins$':
        type: object
        additionalProperties: false

        allOf:
          - $ref: pincfg-node.yaml#

	properties:
	  pins:
	    minItems: 1

cos the additionalProperties: false you have below will exclude the
parts of pinmux-node you don't want.

pw-bot: changes-requested

Thanks,
Conor.


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
> +          - pins
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
>=20
> --=20
> 2.54.0
>=20

--/S+o0lYrnjJZ6O8r
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapWwCQAKCRB4tDGHoIJi
0jnVAQDHKr3Ggu9GiXbgWCOZibO91GsY120UnN4mo0ZWOJDTeAD9FYsMrH3OyB7A
PVZA6zfOGAPBH+3caffWVRLR213OwQQ=
=4Fr7
-----END PGP SIGNATURE-----

--/S+o0lYrnjJZ6O8r--
