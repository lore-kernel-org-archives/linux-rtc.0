Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F20E4F6462;
	Thu,  3 Sep 2026 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788458030; cv=none; b=ShHgcT4xHf837GXZ7hEZgyCI1RpiqUCz5VMUL9eXrBBAjBdCjBwA2FqbGKhIBqnmyFp+TOvH0SAwk2XzUsEgQ+joIJLBd2xjIDMzHbol/UUhWQejfZlzKlzr5dNNvBlZ754dcCmHpsyUgslzxFvbJstkL94jGqApwqlmKWRTPN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788458030; c=relaxed/simple;
	bh=zB0pFvTY+WCoNfOaxHiP41Qs3rsGeCHrAs4pk2z+be8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNcthkTQ9XAFdg+CGDYfEv3qrnE0odJuDdD9ZjZ/QHxb4D7bcDEcFwXNYNQfiSim6Q4n47G6Az50xsIkhYAET4PXb1sVPSY83XsGTRzDjuZEEIjbm65YTqEEG9vJLqH9vCSEEK7afJjgT9kRj4p7aRn4TAGEJl+To3xCRxTTnY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6nmnA/C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6nmnA/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2E51F000E9;
	Thu,  3 Sep 2026 17:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788458029;
	bh=hj1CNbhYcjUo/8FuuSCUUHXKGVj2eFrh4h2sogN8uSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a6nmnA/CZdOYKMZUjOl8sHpERWPf0xEfM3FG1M4tzLDhNbFtaX1njiBYzGydZwGzp
	 9oZp7L716eLVkMijWywXF+1+7mznM6fqyMKrdYJ31QZrehNTX0f9+x9eR94aiOoznI
	 35YsdLITdYHAVcxjEzli8Mf1y/qnC6Pr1rDRNmCsdy/mgxFL1ZN0tjcsAXEoCidA02
	 VOCzKAdxKRai8uuTE1gLzcN9HqxaWdlaunppfcGa+JJRELaYPdJT3bm4KHrhNvyuW8
	 6wk7Zwa0aIWk6hQxhoZ9LOfKPpHHql7cGoidsCeGQ687VTmgQU4mXYcC0PtyaSxXEO
	 jgEoUJSH4zDkg==
Date: Thu, 3 Sep 2026 18:53:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Sudheendra Sampath <giveback4fun@gmail.com>
Cc: alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
	skhan@linuxfoundation.org, me@brighamcampbell.com,
	jkoolstra@xs4all.nl, linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: maxim-ds1302: Convert to dt schema
Message-ID: <20260903-tattoo-unclog-292f54c0454f@spud>
References: <20260902233550.947218-1-giveback4fun@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rRBIxW7ri2Vseqbg"
Content-Disposition: inline
In-Reply-To: <20260902233550.947218-1-giveback4fun@gmail.com>

--rRBIxW7ri2Vseqbg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2026 at 04:35:49PM -0700, Sudheendra Sampath wrote:
> Convert Maxim DS1302 real-time clock binding to DT schema.
>=20
> Signed-off-by: Sudheendra Sampath <giveback4fun@gmail.com>
> ---
>  .../devicetree/bindings/rtc/maxim-ds1302.txt  | 46 -----------
>  .../devicetree/bindings/rtc/maxim-ds1302.yaml | 81 +++++++++++++++++++
>  2 files changed, 81 insertions(+), 46 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/maxim-ds1302.ya=
ml
>=20
> diff --git a/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt b/Doc=
umentation/devicetree/bindings/rtc/maxim-ds1302.txt
> deleted file mode 100644
> index ba470c56cdec..000000000000
> --- a/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -* Maxim/Dallas Semiconductor DS-1302 RTC
> -
> -Simple device which could be used to store date/time between reboots.
> -
> -The device uses the standard MicroWire half-duplex transfer timing.
> -Master output is set on low clock and sensed by the RTC on the rising
> -edge. Master input is set by the RTC on the trailing edge and is sensed
> -by the master on low clock.
> -
> -Required properties:
> -
> -- compatible : Should be "maxim,ds1302"
> -
> -Required SPI properties:
> -
> -- reg : Should be address of the device chip select within
> -  the controller.
> -
> -- spi-max-frequency : DS-1302 has 500 kHz if powered at 2.2V,
> -  and 2MHz if powered at 5V.
> -
> -- spi-3wire : The device has a shared signal IN/OUT line.
> -
> -- spi-lsb-first : DS-1302 requires least significant bit first
> -  transfers.
> -
> -- spi-cs-high: DS-1302 has active high chip select line. This is
> -  required unless inverted in hardware.
> -
> -Example:
> -
> -spi@901c {
> -	#address-cells =3D <1>;
> -	#size-cells =3D <0>;
> -	compatible =3D "icpdas,lp8841-spi-rtc";
> -	reg =3D <0x901c 0x1>;
> -
> -	rtc@0 {
> -		compatible =3D "maxim,ds1302";
> -		reg =3D <0>;
> -		spi-max-frequency =3D <500000>;
> -		spi-3wire;
> -		spi-lsb-first;
> -		spi-cs-high;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/rtc/maxim-ds1302.yaml b/Do=
cumentation/devicetree/bindings/rtc/maxim-ds1302.yaml
> new file mode 100644
> index 000000000000..3e6264464e10
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/maxim-ds1302.yaml

s/-/,/ as the filename should match the compatible.

> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/maxim-ds1302.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim/Dallas Semiconductor DS-1302 RTC
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>

This should be the original author of the text binding, provided they're
still responsive.

> +
> +description: |
> +  Simple device which could be used to store date/time between reboots.
> +
> +  The device uses the standard MicroWire half-duplex transfer timing.
> +  Master output is set on low clock and sensed by the RTC on the rising
> +  edge. Master input is set by the RTC on the trailing edge and is sensed
> +  by the master on low clock.
> +
> +properties:
> +  compatible:
> +    items:
> +      # Maxim DS1302 Real-time Clock

This comment is obvious, just drop it.

> +      - const: maxim,ds1302
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Maximum SPI clocking speed in Hz.

This should retain the comment about the voltages, rather than state the
obvious.

> +    enum:
> +      - 500000
> +      - 2000000
> +
> +  spi-3wire: true
> +
> +  spi-lsb-first: true
> +
> +  spi-cs-high: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - spi-3wire
> +  - spi-lsb-first
> +  - spi-cs-high
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi1 {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        rtc@0 {
> +            compatible =3D "maxim,ds1302";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <500000>;
> +            spi-3wire;
> +            spi-lsb-first;
> +            spi-cs-high;
> +        };
> +    };
> +

> +  - |
> +    spi2 {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        rtc@2000 {
> +            compatible =3D "maxim,ds1302";
> +            reg =3D <0x2000>;
> +            spi-max-frequency =3D <2000000>;
> +            spi-3wire;
> +            spi-lsb-first;
> +            spi-cs-high;
> +        };
> +    };

Where did this additional example come from? The chip select looks
rather unlikely and the example has nothing meaningfully different in
it.
I think this should be dropped.

pw-bot: changes-requested

Thanks,
Conor.

--rRBIxW7ri2Vseqbg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapm0KQAKCRB4tDGHoIJi
0p1yAQCcpdskp4Z8ZCMLdnduJPDs3OWp3olmiGxTSyalK4D3eQD+JUubQ4IZk7uJ
REzTmr6mfJJVWiXuRNAlwtzx7ot0nQY=
=VXJU
-----END PGP SIGNATURE-----

--rRBIxW7ri2Vseqbg--
