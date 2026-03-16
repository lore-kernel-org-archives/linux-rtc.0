Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD4E332ED3;
	Mon, 16 Mar 2026 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683196; cv=none; b=bFrve/mQLW4BliJwUXydYlBlOBOyYFQcI0D49lTwufd/QMDRWd5cl+XBzEiewc+5RzKaFHLYirQr75LrVzFUtsA/X7cpLoREduPHUd0zf3p1uPIrn7W5c7HKXa5nmoMIxQRCCLoDEtOUXWEnaKGV2s52DK8FpsX/fnBPfBkWsC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683196; c=relaxed/simple;
	bh=wEHPyMu42lihqvWHgqVVNGPuEB9VrdUuNbdTcZKzmLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BM27k5xkKLVLPaGQxfbBdZaVnSny3J35OzVUSKPz0g4f3GC/2UPE9fJKCT2Bb0SssyOpLyZ5ulzwqKv+aqdUasoJDHeQQssdYNI5rsOFhTQd7Cb0d+gBcxsR5vsiSDxqG+QxtFkymN85ctreA6tGtp0EA/V6bI6rjtiAXO7zKqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSJlQ6Br; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSJlQ6Br"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B24EC19425;
	Mon, 16 Mar 2026 17:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773683196;
	bh=wEHPyMu42lihqvWHgqVVNGPuEB9VrdUuNbdTcZKzmLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hSJlQ6BrcpxYUk7JBEtBF9Qqe5d4jddMRs/BIYPXhpPeq2zSkrT1d7BDArBZojKWW
	 BKLlbp5f1keg+9VNpIOWgkIBIijWzUmue4HADCbTjzJnOVuwSErUxWlrchbV7aek/k
	 YL4Fz+hGFQ0alKzrJMsisaNWzjtXgr4Qjs4zOx0v4MuWkjCh4+uKgjvpAtIutxB2fm
	 V/l3yUflC1bUWuKJqOQf43X3PX/imfc5TIias6ybZRLFFbMRWwZztH+NfDeWxMC/EL
	 lfDdbpOMY/QxVqRDnnN9xRBiwYaM6qcWptv2b3NZoVJPWL8tv+1soDKh3FtqZiSf1Y
	 tDcGiBYLJGuaQ==
Date: Mon, 16 Mar 2026 17:46:26 +0000
From: Mark Brown <broonie@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Saenz Julienne <nsaenz@kernel.org>, Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Shree Ramamoorthy <s-ramamoorthy@ti.com>,
	Jerome Neanne <jerome.neanne@baylibre.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Dmitry Osipenko <digetx@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Joseph Chen <chenjh@rock-chips.com>,
	Chris Zhong <zyw@rock-chips.com>,
	Zhang Qing <zhangqing@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Lubomir Rintel <lkundrak@v3.sk>, Julien Panis <jpanis@baylibre.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Alexander Kurz <akurz@blala.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 03/15] dt-bindings: regulator: ti,tps65219: Use generic
 power-controller schema
Message-ID: <f0d6b252-370a-405c-b2b5-e02b8bc59bca@sirena.org.uk>
References: <20260316-power-controller-v1-0-92c80e5e1744@nxp.com>
 <20260316-power-controller-v1-3-92c80e5e1744@nxp.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8MjI/4wsRBNLAdgX"
Content-Disposition: inline
In-Reply-To: <20260316-power-controller-v1-3-92c80e5e1744@nxp.com>
X-Cookie: Excellent day to have a rotten day.


--8MjI/4wsRBNLAdgX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 10:47:38PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Convert the binding to use the generic power-controller schema instead by
> referencing power-controller.yaml and removing the local
> `system-power-controller` property definition.

Acked-by: Mark Brown <broonie@kernel.org>

--8MjI/4wsRBNLAdgX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm4QfEACgkQJNaLcl1U
h9BWOwf/RYua3madlI7scNf3qpDMzQZHgi+eqAl3g7Lq6pMKTkmLA/V4P37VJTPi
bB1VTwPRbNvxdczmeLgDust4Yi7d39Se6tX+OrgSXOhv+FMKnw621zdhZ9NLaI2Y
tsbOwANB98ZH+jnGwVRJirPiDuopbsmBHRd7JovirNpdNujPs0sss3Z/GfWVyjjZ
kZwF+6fEn7MKfHz8v0cVjdhDB/zKxJWyX6zlpSXToWVSvhiVnRmMW8tzvxax/kLa
NukR0cAOLKySPWir5+lkOD3Vr2as+vhfcBmfZOdOB1bNqGF8nWOUt6DJljvdw7Iu
wXg+QS+O0wGAQNLRmrZboAIyvnZQqA==
=igxU
-----END PGP SIGNATURE-----

--8MjI/4wsRBNLAdgX--
