Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4098F2F8E95;
	Sat,  9 May 2026 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778342339; cv=none; b=Pr9Hg6ciotpRUeZrDXnRRHVg3g/us+rk7d3242KJdspQfbLFuEhbuhP8qsZArb9ryHLWIq8TuV+rsaj+NWLuYX4515TKb8iLBQkGDS8FR2Js2PwbEYhNd9Jw3T4rC7Qv50eF3E0RTNghVJM7r1zekorhYaTbJPHASNVHrrWJ0jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778342339; c=relaxed/simple;
	bh=kFUUN9FC7XeEEU4/zcQMjMmtuvDVEy700Fl+b885Qsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZd/hObeXgk1XlN42p3aE+3jfymE8W4O8eWhwivGXFIPZpFRU7bYCyNeFAiX0vKtySE766Mi4GLA7uQlIsIthXv56tCbm1Q3pk4rShbeb1ggn1UA5uCqBnw0eVMxR6TfVXWjERRc0eDm3NZyThOwhGtdABGz+SZSgpsZVW/X04Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyoDUkqY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyoDUkqY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F35C2BCB2;
	Sat,  9 May 2026 15:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778342339;
	bh=kFUUN9FC7XeEEU4/zcQMjMmtuvDVEy700Fl+b885Qsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uyoDUkqYXtBWh+4mi9hb53Au4eWi0S1/7gIlhihpDv5l1CAre19a/iyBGzTIy0RhF
	 mGKy/H5ymdiFi/E1f2cjwDWWazBsSZJz53IDmHGHWu7cgfxMkCmgvf548IM9xkP6ii
	 dhQthNNmiIuADRK4zFJyWJePFSDWFwPFs9xAJe1G5sIZ0YhHOnDO/EjIkC5Bz5X13p
	 15v/UU8picTFSecmEg4zdSBYF6rGZoOVR8ynz0uVL3letsH6GGYduCNRuq9PImZFBj
	 rG3CRI+NuweI9Oicw3/YX7s5V1XtPCvYjQkaHqJEcelJwPbRSLVDnG/7YpXKTbtJ6F
	 zh6RfzK5/L/6Q==
Date: Sat, 9 May 2026 16:58:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Udaya Kiran Challa <challauday369@gmail.com>
Cc: alexandre.belloni@bootlin.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, skhan@linuxfoundation.org,
	me@brighamcampbell.com, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: rtc: epson,rx6110: Convert to DT Schema
Message-ID: <20260509-smudgy-hatching-235fde5ec761@spud>
References: <20260509090051.77603-1-challauday369@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bit2L5F3cAMNhMbP"
Content-Disposition: inline
In-Reply-To: <20260509090051.77603-1-challauday369@gmail.com>


--Bit2L5F3cAMNhMbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 09, 2026 at 02:30:51PM +0530, Udaya Kiran Challa wrote:
> Convert the Epson RX6110 Real Time Clock devicetree binding
> from the legacy text format to DT schema.
>=20
> Signed-off-by: Udaya Kiran Challa <challauday369@gmail.com>
> ---
> Changelog:
> Changes since v1:
> - Reuse common SPI peripheral properties
> - Drop redundant SPI-specific comment
> - Remove unused labels from examples
>=20
> Link to v1:https://lore.kernel.org/all/20260504183728.27412-1-challauday3=
69@gmail.com/

Seemingly there are 2 v2s of this.
pw-bot: not-applicable

--Bit2L5F3cAMNhMbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaf9ZvgAKCRB4tDGHoIJi
0m7UAP9lJBGF6xaMioNp/l8Fxpvsun0kR2xnHq5idUVek1IFFgEAnWFamqQeBlIP
pkbbFAoz4cJ88dZjTyDkk8UcLuCgZQU=
=whZz
-----END PGP SIGNATURE-----

--Bit2L5F3cAMNhMbP--
