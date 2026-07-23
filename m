Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB164377AB4;
	Thu, 23 Jul 2026 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825048; cv=none; b=lzPiHM3soClAXZ3DnjXx7En/k9v9o1NqvI9vtVWO1ohlwavfDBzLxUbKxSp5618+yKUYtoT4M4av12XiStupCvCjiRKL5zA1vdzmzemgpCdBomiWDxfgmLyQE1f4+mpT406y+FNljmdJ1ophb++jNY5hiHwkrIx0ZxfVxlyBZto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825048; c=relaxed/simple;
	bh=daEFPkrJnPUX4ZZzTUErWA/RGKPEyVhycOAfpN4WBoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEqBl//rAM96Qd4oRnAtjvO6OJwyv2lxoNkwmeeoO4fVZdhWR69/WjFDpbOx9CKcVamUaI2sjTvIvIYCbJW5HvfLx7fl3A+a8E4FZ1xNspOVvMh38ePew5+AlUd63zDlhsDtnlSLke8cAWmGq3FKYUzx3bldunW2LddTKjlksHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXdrrg4I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXdrrg4I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93EC1F00A3A;
	Thu, 23 Jul 2026 16:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784825047;
	bh=8fPgBcFHZliTnkOApB7ME4wVie3VHagCNULw0zykUqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hXdrrg4I55YY4lUlhqys3Q76CJ3c9xsidpY3eL81ZSQIen1vXAUQS6i/GN9BvrK4Q
	 hW+epgt3OkycGHP5Kg+WNgcQBZUlv1yK1Hi0DTFn1zM7TjLrrHxpBnVNfJj4qgVBE2
	 7lmr8D28Y6ZRIyxbIBYwLX2zBJXZU0UcmWt+08a1jFdOsc7aFHVKo8znr9TwBgTCJZ
	 tWWb7itys2GWeXJr5yXiVfzmPSl/KcR/Zy0cBMxTHit3fj2+IyuErsGdon/79VJwmj
	 VLKEKbMc71mpfSw2ngNwi8JWq7rhIBCw8shY2wzuf080WYtErOXmfpuUHEIm6tPoqJ
	 4nUTlTl+C8fRA==
Date: Thu, 23 Jul 2026 17:44:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: alexandre.belloni@bootlin.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: rtc: abx80x: document ABX81X RTCs
Message-ID: <20260723-briar-hut-82e980e9996a@spud>
References: <20260722195814.298552-1-apokusinski01@gmail.com>
 <20260722195814.298552-2-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AXUglInnSkybAVCO"
Content-Disposition: inline
In-Reply-To: <20260722195814.298552-2-apokusinski01@gmail.com>

--AXUglInnSkybAVCO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 09:58:09PM +0200, Antoni Pokusinski wrote:
> Abracon AB0815 and AB1815 are RTC modules with SPI interface.
>=20
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
>  .../devicetree/bindings/rtc/abracon,abx80x.yaml   | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml b/=
Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
> index 355b0598411a..234a103724b5 100644
> --- a/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
> +++ b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/rtc/abracon,abx80x.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: Abracon ABX80X I2C ultra low power RTC/Alarm chip
> +title: Abracon ABX80X (I2C) and ABX81X (SPI) ultra low power RTC/Alarm c=
hips
> =20
>  maintainers:
>    - linux-rtc@vger.kernel.org
> @@ -21,10 +21,12 @@ properties:
>        - abracon,ab0803
>        - abracon,ab0804
>        - abracon,ab0805
> +      - abracon,ab0815
>        - abracon,ab1801
>        - abracon,ab1803
>        - abracon,ab1804
>        - abracon,ab1805
> +      - abracon,ab1815
>        - microcrystal,rv1805

No ref to spi-peripheral-properties.yaml? Do you not need any spi
properties, e.g. spi-max-frequency?

> =20
>    reg:
> @@ -96,3 +98,14 @@ examples:
>              interrupts =3D <44 IRQ_TYPE_EDGE_FALLING>;
>          };
>      };
> +
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        rtc@0 {
> +            compatible =3D "abracon,ab1815";
> +            reg =3D <0>;
> +        };
> +    };
> --=20
> 2.55.0
>=20

--AXUglInnSkybAVCO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamJE0wAKCRB4tDGHoIJi
0kD+AP4rRplYTl6FtHCdqfzTegZODKR9vG2wW5ep67EQtdMYdwD+MxtBQk4ZKDDv
cQaJM6fWp1quzsoHo88Cz6OIoGW4Cgw=
=gHFn
-----END PGP SIGNATURE-----

--AXUglInnSkybAVCO--
