Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DE030E83A
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325264; cv=none; b=iM6UK/a8au/1naVG8xMtxhPtNxEwddH0xW6ocBQD43gs8gtOwCg8qMX0oKSPGYcBpd0e3csrGDx41DgTqkoAAOdmY/Vpe7NPOTf+AiUKcenqs/lvkF4fNMbq5QteUU7QbwWNnBRIVHqTHVUkLPUL9nZFR9n9GkT6AaX6VM7EzVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325264; c=relaxed/simple;
	bh=wY7XRtmj1KbGEiUESwzJJb5qldev5ixKZHao9+FX0Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmKm9Ns/hg7iAF7uE9CjTUdMy09TQDMI+F8cGrBB5FdYbmupyx4tO5NzgXXUolDVZKDAEnqibetmU89oAfRuArm653FhA1W/RDg3el5SmUe35r3s6zD8lFtnmc4M1ZUMhzmDHDnxQgGl/R8C24Is8sqzf2VshEVjtOe3E1sSF98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=TTcgc0zG; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="TTcgc0zG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=wY7X
	Rtmj1KbGEiUESwzJJb5qldev5ixKZHao9+FX0Xw=; b=TTcgc0zGGFn7QvbWsXQ1
	qQ+/HRBZQq4+W6DIToUmqP2jqpAhwgz7dMu3gmK/wZGajGKQZ0QRXAvpeS2casof
	KbijSv8ScseQWwmTGnCBY/wNs4+GaSNL/u6M3m/fFYWyjgaMT7WlJ9NpSSus9hDR
	0x33yWMS0zO8z3XZAcLGWcr23S7SjcgAxXGvVcO4RmvSzBVOV6h3pmfaib68RYjk
	X3H2jmgueHgRI0csgwGpldmfOnNLa2sZI/5NEaENIViQ2XM91F7h9IDJMFqgiEQz
	n+H4IXSo9gdRzBDujppzV4bbzs15f59bj61+h7v9DnC4cpkTr83A1ByrgTVY4U7o
	2w==
Received: (qmail 690203 invoked from network); 21 Aug 2026 17:14:20 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Aug 2026 17:14:20 +0200
X-UD-Smtp-Session: l3s3148p1@jHA7F5BZ9qIujnuu
Date: Fri, 21 Aug 2026 17:14:20 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v5 09/17] rtc: rzn1: Use pm_runtime_put_sync()
Message-ID: <aohrTPS6e0hYrSkk@ninjato>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="woJgFuwEXgULRzEe"
Content-Disposition: inline
In-Reply-To: <20260821135608.275233-10-prabhakar.mahadev-lad.rj@bp.renesas.com>


--woJgFuwEXgULRzEe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 02:56:00PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> pm_runtime_put() may trigger the idle check after pm_runtime_disable()
> is run as part of devm_pm_runtime_enable()'s cleanup action, leaving
> runtime PM active.
>=20
> Use pm_runtime_put_sync() to ensure the idle check runs synchronously.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--woJgFuwEXgULRzEe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqIa0sACgkQFA3kzBSg
KbbxOA/8Cxq/pc72Oaez6z5TdwGDlV+B0Oma8yjI4wbnXfcSDoMQ8XvOt0i8Z/CR
ECEb5wXWjTDfa4ibvh4fFdxydxyiFIVYq5ah0VB2khAueL0QWdUGILG/bLUXz3LG
qi4KjfhouZYWf4bhtCkDZIKLJCOR1XGT8hi6HQjpsvwUhG/j+MKhY2QvazJcCvZh
BusEov1tWVFqYsk8aksR7K8eReLZlxrRdE9GfZPWH02rtnkdS40pCEHvx9fJ97Ds
O3sfTvBVSXaJMViJwFQDF8DCblnjnQkUhPgZ5WHH5PNhY+Q73F3pvXk1PP+86Z9f
ZhgyDlFzXyI7JzvfyJ0vbC7TZZQ4U8D+fiL8zgIte1Sa78adIICGAON+pUbT7XgX
wA+K8Fe93ZGRuddcpKE45tOvOcKKnRNj8KOWLM1h8KRENdd3719WlQPmTC7Vh2v6
fVK54rkGMiTIyIBROWRcIY1uAvOY4hl98GUxLQHn+rrmL4so5mV4vVXLDDE9Pm3C
zx7hM3QjUf0PzYtM+QO8sBQd1Lh3CYDDMEx1SpnY6J09wTmFe1y3br4a8sTQP/F7
4Ognd1ftT8/28euDyUEAF3qN18W/OD++j+ZlNd9bW4IS1Iuu55y7QK03PN1/4W8c
N50Km72K9u0Ye/VlnOUIDEO478S6vvX7ivqKUURJ0rE/eiYEKzw=
=4q6Q
-----END PGP SIGNATURE-----

--woJgFuwEXgULRzEe--
