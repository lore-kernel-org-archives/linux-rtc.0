Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75FA538D6F;
	Tue,  8 Sep 2026 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871340; cv=none; b=Ge16bh+ASgS8ULOq3er8SM2E+w76L0vhMa6aKGdWhJWbMnN5WtVX9KoGbAKNg+Xn6ueuyofWUL88EUH402nv7r8qWIfsQFh4zUh9LDCoIv2yX7Zd/MLWAoFyGDSmgCpnC7CBnpRjQETZZ3cXQl94xLIRYhuT1KGHK1UBn6Rf1pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871340; c=relaxed/simple;
	bh=VGjT8yNKu9T3JwmloU5mS9DHacYk5CQ9txBTR2D1AMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXJsouZ/eryINnckaXWTx1VE8UaAOBcZ0mlUcbVRaJd04DzYk3kltn5aGriRU1IHvpwdWsw7HIWbB9W6HHA4saUdWhVFgKn/YGt8qfh4IbCcfZJTEIQX4ycNzuzRPi0N2JgoxKfhhv3AlqD6lD5STRa5x5eE5d9eTAO4XQe4UEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIHh1z2h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIHh1z2h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494551F00A3A;
	Tue,  8 Sep 2026 12:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871338;
	bh=Y6jk5OyEcqFWJOvwO61dpd5Psuv55kAUeibaILfDhBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QIHh1z2hHalV4r6vxxSmDOnm7gCcgpuCxZ3dHTtdGDsIuCCICO8a/8o4C1mR/Mffi
	 asNh7uYzRNGnVdtkYAp4h+sLNq3LWzFinaEnNpvxBEsr2mwBfi6WLAX6aoCju/uPme
	 HdqvboRN+pgrvpN1DPt+TPS2UdES5zqfzNTrr7MYswp8Bt8BQmwoGlCkW05PNpEwWk
	 PbFqtA1lNSG4CvCPVf4b0yol5nGUjobO8FvQp/xSgia/BEkZFlNEnb7Mfs559vW8YF
	 CQWhVJ4+BJAYcDMhh1bMb9onHhkYqJ7iyJQaepIagshhVG7Q6oIzq+Vk5iUNRLpJOm
	 NWHI7sdZ+rbWA==
Date: Tue, 8 Sep 2026 13:42:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Manush Prajwal <manushprajwal555@gmail.com>
Cc: conor.dooley@microchip.com, daire.mcnamara@microchip.com,
	alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: mpfs: fix unchecked devm_clk_get() error pointer in
 probe()
Message-ID: <20260908-karaoke-chrome-e1746c314d83@spud>
References: <6a9d4b02.7d74b517.206c4c.75f8@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DyNf6KzfTVv227Ts"
Content-Disposition: inline
In-Reply-To: <6a9d4b02.7d74b517.206c4c.75f8@mx.google.com>

--DyNf6KzfTVv227Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 06, 2026 at 04:44:09PM +0530, Manush Prajwal wrote:
> devm_clk_get(&pdev->dev, "rtcref")'s return value was passed straight
> into clk_get_rate() without checking it for an error first, unlike the
> "rtc" clock a few lines above which is correctly checked with
> IS_ERR(). clk_get_rate() only guards against a NULL clk, not an error
> pointer:
>=20
> 	if (!clk)
> 		return 0;
> 	...
> 	rate =3D clk_core_get_rate_recalc(clk->core);
>=20
> so if devm_clk_get() ever returns an error pointer here (for example
> ERR_PTR(-EPROBE_DEFER), which is the normal, expected outcome if the
> clkcfg clock-provider this RTC depends on has not registered its
> clocks yet by the time this driver probes), clk_get_rate() dereferences
> that error pointer instead of returning 0, crashing instead of letting
> probe defer.
>=20
> Capture the clock in the existing 'clk' local and check it with
> IS_ERR() before calling clk_get_rate(), matching the handling already
> used for the "rtc" clock in this same function.
>=20
> Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>

Fixes: 0b31d703598d ("rtc: Add driver for Microchip PolarFire SoC")
CC: stable@vger.kernel.org
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  drivers/rtc/rtc-mpfs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/rtc/rtc-mpfs.c b/drivers/rtc/rtc-mpfs.c
> index ece6de4a6..60596b0ea 100644
> --- a/drivers/rtc/rtc-mpfs.c
> +++ b/drivers/rtc/rtc-mpfs.c
> @@ -256,8 +256,12 @@ static int mpfs_rtc_probe(struct platform_device *pd=
ev)
>  		return ret;
>  	}
> =20
> +	clk =3D devm_clk_get(&pdev->dev, "rtcref");
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
>  	/* prescaler hardware adds 1 to reg value */
> -	prescaler =3D clk_get_rate(devm_clk_get(&pdev->dev, "rtcref")) - 1;
> +	prescaler =3D clk_get_rate(clk) - 1;
>  	if (prescaler > MAX_PRESCALER_COUNT) {
>  		dev_dbg(&pdev->dev, "invalid prescaler %lu\n", prescaler);
>  		return -EINVAL;
> --=20
> 2.46.2.windows.1
>=20
>=20

--DyNf6KzfTVv227Ts
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaqACowAKCRB4tDGHoIJi
0uBvAQD7XBtH+8ICDp5mTLM2S+LcsHxvXWu9InFUV/5E2ZWWFwEAyXAL081i2Az8
7c4LJDO4iy8sf9eNk/stTxBIE4O64QU=
=hrpV
-----END PGP SIGNATURE-----

--DyNf6KzfTVv227Ts--
