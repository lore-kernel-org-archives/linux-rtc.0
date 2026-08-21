Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B314570EE
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787304871; cv=none; b=eWWYgZ6dSLnB2RyfaHhqy3xgv05FbVKE1zR7kOl0SXP3lvf/dk4xtjOO4DFt+tpfYYxQ2x8H0uCHkw8fv61L7EtQU+kwYC0k8YcUEtWrCtYz33ssSsWwKyCQSORLUyuCwUvb0N1pZVDtfNNddgK+KhTPD4vIcObreZj3juuQEow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787304871; c=relaxed/simple;
	bh=WdZLr1n+nWwhzHD5ms0FDl3HDufTPovn43dEUlSyeMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEMDorLJS/apTF7TDEaxWeicVsp/ODM2pmwF4BVIb4rN72KelXN0eJxElS2y4wgW0lSdoiW8GnsnAkv7PxMysu+U1vbw8t2ZWS8LEv5WKKsBiN3x7+toavZUec2hMWbY9mykBAOFOtb6u4d42jzDQGcX+UyPs/QQAxym4vJUhh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=HQbNKuAx; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="HQbNKuAx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=lWsL
	p4397NNo8UrAz6kD43LDVce8oF9NO46d/WYg4mA=; b=HQbNKuAxkA8YFlZuvH/n
	a0pzNRX4f20YbYH7d66QH/G+ukEKVl8cpYZBxYCgU1tz1zAncF3E/iFYbOv6L9Id
	ChSjHMS3rAIhq7IZDkamGbffz5MaA3O5ejxUrWFchu66hufkJ36Urw/dBaqWQdC5
	WZlr0fBM/rpSeVR6WxvJ9n1B5D969lfHPP0wxd9/uNHRxIgD7LaWpdmDiXYdEZT5
	IzFKJ+ZFydjTSKfMN8iCoNqisHFh74K2R5IVJz7SwZyAy9IuG1aCYu5zdQx/ifxW
	MblxCFi3Oj2r4mhrLTyET12zgy6M9Iu4f8fD/c9NXgNZPwuI5YTIchoXpQzcmAa/
	eA==
Received: (qmail 605895 invoked from network); 21 Aug 2026 11:34:13 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Aug 2026 11:34:13 +0200
X-UD-Smtp-Session: l3s3148p1@CbLbVotZJJwujnuu
Date: Fri, 21 Aug 2026 11:34:11 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
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
Subject: Re: [PATCH v4 13/15] rtc: rzn1: Add OF match data to gate SUBU
 register access
Message-ID: <aogbk-moFmTTFkJ0@shikoro>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aobjCr7ZtpLmL3VP@ninjato>
 <CA+V-a8tpo2Rc9xsvsj9LLqD2ZjoHzRAVsox=7xURAtwA-GYVEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ldgKrqKLs1cCm4Uc"
Content-Disposition: inline
In-Reply-To: <CA+V-a8tpo2Rc9xsvsj9LLqD2ZjoHzRAVsox=7xURAtwA-GYVEw@mail.gmail.com>


--ldgKrqKLs1cCm4Uc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> } else if (!data->has_subu) {
>         return dev_err_probe(dev, -EOPNOTSUPP,
>                              "No valid XTAL provided and SUBU mode not

Yeah, looks good to me. It is maybe a bit hidden that xtal == NULL in
the above case. I wonder if adding a comment above the return command

	/* xtal is NULL here */

will help understanding? But I'll leave it to you.


--ldgKrqKLs1cCm4Uc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqIG48ACgkQFA3kzBSg
KbY/zg/+Of59Tl+ksOh1ZjWKKHkcpR6EXcG0zxzOYsXFZ8cakdLFXeoLNV21EaGW
cbxZETOsPY+pbEpvG5/bwmv+nI/xI2FEH8RpXbkLjIQZxR8SvqHU3l/7zoPn+1vv
qXsl/vecQm2rL54bJnyiZ8h+pGnlJR7D0Ix0baajH9LGcV5TCH4R+hsSu4aDjhjE
nVKmu1txp+zuUhjlzVzWonD/H/CeMxRO9BJx6Jy+bLc4XNJvp6cMHCF4qOrPjshw
UbUJNH/6UVB6mOjg4CFPysiZzoXZb+iJ5Uhj5ns1UqIp66InIAEUM5CLdbhaZTqK
jhUoKSKnywtBSc+N7Act5mCCvUPjke41253G+VtV5ogwfpVT2Vx9nN1EgI7VNhRU
rCnshqJvppU0RRT1WlQBH0kRL/5yVY9d/YG9YjVoiQ+i3xIK+EkWCrxMJjMimj1G
8hXy3E9OEV4R/VZmqhYV1LNro8fozptm77xOGkKa+p4AMOUpLiL2eenTcb7hA++Z
p/wZi8NXPnsXHDbR3A1sxmxlrzOIMf5khDs0suACLo3WcUJMq/fFCdTEPRHTXwuH
KrWm9H/fBl2SCBLWzOGic4fC11O+Z2dU+wo9hiGaJupeXyQofwR2nDGq3rW6a5Nd
UY22bstARtMdWYCybjPB37gKSqoWosjhWvm2BULfNlbjJhhxxN8=
=Eu7r
-----END PGP SIGNATURE-----

--ldgKrqKLs1cCm4Uc--
