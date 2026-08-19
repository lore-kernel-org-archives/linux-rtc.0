Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEBA345CBE
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144792; cv=none; b=fC6ytEhgT3cq+pA0siZsextp84vu8JVuNs0uZ4F5HCHvgcat0oleKkE+ONlpwXhmvb5ZmPOr7RbA4r2meuOrLqxwTXvpaQQlMQoQQSCqoOjVN5IfSItrzSDTAoHiKJACSDLFsOwMcsEY3LsabMsDOnAWst/W51VBnYXxNuHRGaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144792; c=relaxed/simple;
	bh=WYl+7C0E6IgBAfMHMHUNAWBdcEkwoLLZ078z7H7EGAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8pflMjBpPxMTt786XZhFzyTR3yqWCAHXiMIh/NoYEVhKuZbxhfCMEblNzI9pX8Pe7buJPjPSjadhluZF9J2jrj2pjRUcPXSWf7H4mdb8jiRKIfE6U3llLXOPbd7XT6BY3DEVKigeww6IT3cV2xVD96YkmT25CtnIz+FqwpN34g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=LJjh/1fm; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="LJjh/1fm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=WYl+
	7C0E6IgBAfMHMHUNAWBdcEkwoLLZ078z7H7EGAo=; b=LJjh/1fmLKAXC6n58j8m
	DTCQuNifB0it7oL988p554NvNZLBBvAAUc8+mqVIcs6NkKgP/5tV8cy7KS99mttM
	ZZsiiJ2t8D0o/V32l6jbEfqe2w0GVOld4LMzUUXJ545o0cKNoWpZzcWsZZcvlRrt
	btb5UUj4a8fHb69aXdnv679pEWTkl/tMBKhQ4r3v+T510E8ef+zJ36vSjVglJvG+
	LLDclU+iWW8NujGKCN20Xl3WfkLf+6iRTmdX+tjre788ovx0naHgVsVEfadVMgsx
	U45chxaOxRdzFpU+tR94yAo2u9rFjmG7kbbTSZT+LT5EuXf3H5ft5aGIthiOeHXb
	Uw==
Received: (qmail 4147680 invoked from network); 19 Aug 2026 15:06:28 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Aug 2026 15:06:28 +0200
X-UD-Smtp-Session: l3s3148p1@98tGEmZZZT5tKXGR
Date: Wed, 19 Aug 2026 15:06:28 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: sashiko-reviews@lists.linux.dev
Cc: Prabhakar <prabhakar.csengg@gmail.com>, devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v4 07/15] rtc: rzn1: Replace remove callback with
 devm_add_action_or_reset()
Message-ID: <aoWqVMc-EQEDqA8h@shikoro>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819105027.B7A121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GfVtLtE/qZVvJuNe"
Content-Disposition: inline
In-Reply-To: <20260819105027.B7A121F000E9@smtp.kernel.org>


--GfVtLtE/qZVvJuNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Would it be safer to use pm_runtime_put_sync() here to ensure the device=
=20
> reaches a suspended state before the teardown continues?

Yes, seems like patches 7 and 8 have to be swapped simply.


--GfVtLtE/qZVvJuNe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqFqlQACgkQFA3kzBSg
KbZjcw/+JeMSUjwuxvivLfyHn5AnM8n1v3foG5pYDx3Juy93sGFv6oCfY1+04b39
+tnciTTpAXZme2zs+JzGUg2pjy/C4ZFAqmwBfcOyYlY5+TXx2LIlovtVqVg8cy2W
xHGD7wDIuVNPc/HNEzWMYwu7R5w+cNErDsYv3jeBeHuvbwImxuT2aRaPEuO3Gsy/
gaaUosXwU4Ie4p2+ugO+1zI+U942jfcHSHCO9Ht9F9dfhVJdgadFbHQT930ro75M
jE53wUr/X3M+z98zyXp7mxu41QIb482PxUiRA2qogYCeV5WMDkJTnoQlE2fZ0lFi
3wXhPpNIfqB1SA0RYZnNbXmFzuyfeUOeVz8AfwxmnDJw4fLGU1TqhC1JeQ052zRv
dWMcObCGwmm2kLc+A3irvXE+YX8byMOHlX8DlaSTAkWXO+4VABjz+5ILDcljSSZh
VXi6CrvA7siVAtkjwlP1cDt4GF7kdHwSUZe27WfoIaa8GWiVOuADHNbHLxV0C+T4
uHJVM2zsZoOL0Sk3eaTz+JgdKszq+e8kke6wkWzGiD0O+Wd4qULpYypLdw5yB3Jy
+kxc4TPQ5rl+5xO0vnNjdEzfLrkFx/oExxQhfInUi81I2vpIokDp9uHCAyIFUXYV
uB5Kju0f2ruGuR8Z1FfS2kPuQLPNbBmGDRMkJaW3yIww/kS3Zmw=
=0DNs
-----END PGP SIGNATURE-----

--GfVtLtE/qZVvJuNe--
