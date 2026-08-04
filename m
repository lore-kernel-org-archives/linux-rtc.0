Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DEA47ECFD;
	Tue,  4 Aug 2026 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862641; cv=none; b=fH8Szt4xsg7JkT0G6QU/JaLqMfSlD/7/2bboANN3bIRfbBp18iwtVo09n4rg77kfrqKsxTUuapZSHds+0I7SR2R7ARJUukJ9YSyd/4dKnIgk6k0aaK2knYbgu2pn28mncE7yQPvyhHMcrAJqmXIdScDWs0MzdRpllKmarftNxTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862641; c=relaxed/simple;
	bh=TmrgEsd767z9qRLdnCKVkxUQeGTSse/SVdU9mQg9Zyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7OcgeWY86L+KxSEsBT4DrYd0yUMoaYL9bifnGq+sbGDkV+gONjYJIQJUujVY7xLJfTnhUBmt8tySrp89hqQ2ZEaDjRLvzpa99tkemZSFz8lIiHP9LceokaPrn9vhEsQ/MjpnFWSbLi9tBnSmqId95VXHyPHQ9FBxd6as9PkcZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJiX3o69; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJiX3o69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710CC1F000E9;
	Tue,  4 Aug 2026 16:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785862626;
	bh=TmrgEsd767z9qRLdnCKVkxUQeGTSse/SVdU9mQg9Zyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NJiX3o690xjMm348kEsIL33rbnpq5+mt2PYwoOUCh8C/VevVwEWp+g539xYAjTyp6
	 l8fAPRQXy2TezE+KKyg4KtJn+1Z9txyixKMxeX9CmimuSBYt1zExwMmp8a+y6QsOMX
	 55j3MkIeVkqtO1e6SG2OrGRBoWMkLqYsqwzt13rKEznCQyQdcZ+jQcffwi118vGKNY
	 qkw+XuACvAB3Cze3qmXZcacWQZDX0zB4h8/GzrmCasoKKYFtk+NFWwKP5RHpojI8SH
	 dZx3cznl66YV0hJdjtDm4dNMzDuJ3FrKzK1xcCQep1A3P2dRi5MDl+QAYNA7MFw0tP
	 qHcYIyzzeVxlw==
Date: Tue, 4 Aug 2026 17:56:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 07/10] regulator: bd71828: Support ROHM BD73800
Message-ID: <8844ada9-a7f0-41e4-b7f8-72554800f625@sirena.org.uk>
References: <cover.1785838584.git.mazziesaccount@gmail.com>
 <f81e7214f9c02fb1a92d12944bc6b8790d5ea6a8.1785838585.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nmfFyTMrnsD2kE5O"
Content-Disposition: inline
In-Reply-To: <f81e7214f9c02fb1a92d12944bc6b8790d5ea6a8.1785838585.git.mazziesaccount@gmail.com>
X-Cookie: Biz is better.


--nmfFyTMrnsD2kE5O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2026 at 01:22:39PM +0300, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
>=20
> The ROHM BD73800 is a power management IC which integrates 8 BUCKs and 4
> LDOs. The PMIC has internal state-machine and it can support transitions
> to RUN, SUSPEND and IDLE states. The LDOs 1 and 3 have two different
> voltage range configurations that can be set at the manufacturing phase

Acked-by: Mark Brown <broonie@kernel.org>

--nmfFyTMrnsD2kE5O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpyGdsACgkQJNaLcl1U
h9CM8Qf+MWfx7oT+6ocgVqy6Donw8O1XTUV7GFL8y6DxGifWoicYpMQ5XP0qqIka
q2wDvBx/o7c3jn6AV/CZLljj9TKRxrnf0f5nz6oVC7Vj+bY1JtVxpXKDeIpCvrBj
94LJyDTrDMv/eNMn/nx14H0AfmdlT92N6PnYPFThpzB38Q0W7N6j1Y95nP1vyKX9
dIMCjZ7G1DOYSwq6RnOoZCycXIuK/UBeKWlaTLzTGgfNF0byl5dm0auuU4T6zfBv
0+TTbG7Idypm1sD40Vn4kG5HHKakajKGstJuq5lDuL49c3AXY0YPqaAwlyDWAhpO
o2lz3VOLFH3Vw3sO0lu9Gv2I/mXAAg==
=jP59
-----END PGP SIGNATURE-----

--nmfFyTMrnsD2kE5O--
