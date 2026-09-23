Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A88852CCEA;
	Wed, 23 Sep 2026 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181437; cv=none; b=SLyzRnnSa3a9MdikzxT9rlCZXKyjEx7sPv7EiXypm5I50xKkHxipxgR2HsL213X2rAKhZAI8641P+XX/mWIYjGx3pdYK/btETe9w20/Sj7t3gXJcQipDRBOCaW9c1KYuqIsw3dKJJF0+YZSJCI4Y1x++TuyhUWgJwSMk7jl6UFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181437; c=relaxed/simple;
	bh=TMvxa8MpRdNxr9ZNm7UhI/azZpijL0Gc6JsDl9w8eFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIBlztrZ0t9FwykxPJo+uqAiVHuUi+7CQjtmNDmFi4SXT2hP/CXYWV6Ch5LZeWeOR/M/kYpufhO9m9v7Oy6Jam7yMNzPCpNjuztvy1vFaHhonghF6hhBClcgDAkK2MLlk0yzfjvHXEoi8AE0kcLHq0zBgPWqQIh4xDXhgD1/V9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQf4pIbl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQf4pIbl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318FC1F00898;
	Wed, 23 Sep 2026 16:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790181428;
	bh=m8DBmCwTPj1HLJxixk1IybieKhVRtaJzcM/QTZMWWjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OQf4pIblBoaTwNI1vgYOnKhNp/sI31yk//Xw9BqFUy7G/htBaC1NWTmeOya/KJSKj
	 K/NGiYIvAia/lMUsHtjNHNqpTfO9nq7hthRnvWANp0ndLdh59OVduYheLv3N+uZ/XC
	 nOWOeHDaKX7dly2b5WUSdcmPgt4b8tXszQwP+xye9ctzkZGhP60mIBypeIeqjq2H7A
	 /3Lnb0i65OdNrEN8SFXtvowiX4I66P+1EVPVHx4+F2HLUpCoya2FenCeBqg+xrgdgx
	 M1TfReFrPG/QDzCLMNMCX0ZAaWQ+8TjhgNMiRAKgqhFW47l7p+9gw22AIaUiyhqRkK
	 pku6EJq0GyryQ==
Date: Wed, 23 Sep 2026 17:37:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Sander Speetjens <sander.speetjens@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] dt-bindings: rtc: Add property for Raspberry Pi 5
 RTC
Message-ID: <20260923-browbeat-judgingly-b047721f5cb3@spud>
References: <20260923131323.1099979-1-sander.speetjens@gmail.com>
 <20260923131323.1099979-2-sander.speetjens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JCSrJm94KekIipH6"
Content-Disposition: inline
In-Reply-To: <20260923131323.1099979-2-sander.speetjens@gmail.com>

--JCSrJm94KekIipH6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 03:13:22PM +0200, Sander Speetjens wrote:
> The Raspberry Pi 5 has a built-in RTC that can be battery-backed
> via the VBAT pin. When a rechargeable coin cell is used, the
> hardware requires a trickle-charge voltage to keep the battery
> topped up.
>=20
> Expose the trickle-voltage-millivolt DT property so the driver can
> program the correct charge voltage for board specific configurations with
> the attached battery.
>=20
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
> ---
> V3 -> V4: Add a reff to uint32
>=20
> V2 -> V3: Fixed the firmware property naming
>=20
> V1 -> V2: As discussed with Krzysztof Kozlowski, this property is folded =
into
> the existing raspberrypi,bcm2835-firmware properties.
>=20
>  .../bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml    | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm283=
5-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm=
2835-firmware.yaml
> index 983ea80eaec9..9349fc8908a5 100644
> --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmw=
are.yaml
> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmw=
are.yaml
> @@ -133,6 +133,13 @@ properties:
>      required:
>        - compatible
> =20
> +  trickle-voltage-millivolt:
> +    allOf:
> +      - $ref: /schemas/rtc/rtc.yaml#/properties/trickle-voltage-millivolt
> +      - $ref: /schemas/types.yaml#/definitions/uint32

Is this actually needed? Shouldn't the type of uint32 come from the same
source that the type in rtc.yaml does? Or is this missing in dt-schema?

> +      - minimum: 1300
> +        maximum: 5000
> +
>  required:
>    - compatible
>    - mboxes
> @@ -144,6 +151,7 @@ examples:
>      firmware {
>          compatible =3D "raspberrypi,bcm2835-firmware", "simple-mfd";
>          mboxes =3D <&mailbox>;
> +        trickle-voltage-millivolt =3D <3300>;
> =20
>          firmware_clocks: clocks {
>              compatible =3D "raspberrypi,firmware-clocks";
> --=20
> 2.55.0
>=20

--JCSrJm94KekIipH6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarQAMAAKCRB4tDGHoIJi
0uyDAQCECFdvo/mCsj8XGZ3LnWxt/mRzZS/C+eKt/t7T7Cvr2wD/WTdqT56+5e32
CI1NMazHWbLAWGdFQqbYmY5B9BJXrAo=
=FVJW
-----END PGP SIGNATURE-----

--JCSrJm94KekIipH6--
