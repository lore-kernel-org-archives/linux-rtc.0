Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27265332621
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145235; cv=none; b=eaLoVpl6dXIZ6mPuxncjhZpK4/JW0XwueJfa70gefX5PtimLh1nOs0Quer0xJoDveA7d0Ff+1Jf9MNJ/GfEChLZ2+NonxdF7ZgmIoT5i88Rc6Nzm81bNRTBxiFVp9s8aCRbf+dSQJIWXO/ltUDSUGUC321u8UEsI35UtVDWKm7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145235; c=relaxed/simple;
	bh=5yfyDjc/0CUzSKaY3QXI6kBp0lZW+0ikSm9ZVGfutQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLY0Zq4X0/XV+1WgtO7dv/onglT7kfRXxENERkxt/xRLc/I8Hn5JINhqgKLhhQumEPqgHspJYsdbbjnsFi9HHoRLQb9Pu71fdZ9sf3hhPnUmj4pFBE0VnUPyNVzsRcNBaL86uzn1eQGvoD14KXAeIdP+/RSwPTea1L1KnZMjjGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Jt1oldtw; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Jt1oldtw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=5yfy
	Djc/0CUzSKaY3QXI6kBp0lZW+0ikSm9ZVGfutQQ=; b=Jt1oldtwiysXO4spxxpn
	WhSTV9oaP1MCwsHXC9btmeg+J1izuiTUFnn6bRzVBBALNNapvqJkOw2RKQZmXJGG
	PgkXhEhoSiAoVIndpQCxk106ru3OeOFaoFMYB0lsCXufyjHBKViAzASQKKEQfY+q
	gUHS2Xa49NmhNXkCFLOWqcGznyYmcAEWHRLxvli8w3pe20KyXVAmYM7ky1A7FvIG
	O3pujP/jULsQLUxUHynCdRvuJQC+w9Te2laX2SjbbVDdg5Y31AM3bPnTueTtJKfM
	MiLjx/guXBhyqyxq2ACB55TS4Pvc20Hre0WPMnCrFjFQBD6irNCkHUVKsv8hk7my
	xA==
Received: (qmail 4149904 invoked from network); 19 Aug 2026 15:13:49 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Aug 2026 15:13:49 +0200
X-UD-Smtp-Session: l3s3148p1@Zh6MLGZZyXltKXGR
Date: Wed, 19 Aug 2026 15:13:48 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
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
Subject: Re: [PATCH v4 14/15] rtc: rzn1: Drop trailing comma from OF match
 table sentinel
Message-ID: <aoWsDIfmFgkRpDje@shikoro>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DqjuLX6Z+eEJywHM"
Content-Disposition: inline
In-Reply-To: <20260819103926.2136712-15-prabhakar.mahadev-lad.rj@bp.renesas.com>


--DqjuLX6Z+eEJywHM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 11:39:25AM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Drop the trailing comma from the final empty entry in the RZN1 RTC OF
> match table and mark it explicitly as the sentinel.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Could be folded into patch 13 in my book, but not insisting on that:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--DqjuLX6Z+eEJywHM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqFrAwACgkQFA3kzBSg
KbZr6A/9FA/7gJpoHPYVsYzSdypGR0I7WjNmq4MSGa11AlsFevKaBCbBEI2lE1YP
lhpFBz8TYnxtvdpezdH/3kuLuOO5pW6VMgvWWdvU1k6PcY9TRHxi1KVe4GvHFxvv
PxWMlUhNfUbTHLB3Bxb8UP7qj86KxrHZuuXk3sBbdkK63HsZrL5MHxvDPsU9Avoi
fIQMhVX+CFDFYNcOz3u1pXvNvu2nN6uWlhmIKnhj1Qq1XecxMYXCh95F9LdISPTL
/pHPnP+PEVJnOR95xq1FAX1Abny/yd24fPyX/2XoePuDWDsFTa33KaKZxaFv89F7
hx5H5qB/bCSfQR+bj6kU/2OTybuxfXjEfdzIlTuHKBwAFPv/TyaXQA26gpUuoZEH
kczG+Tomsea5nRmdj5jcKCvn+eI7ZL40E2+AoPFsAEqcu/iQ+/0B8K6peuWu2Qjx
un0z+u6pJbYE6A+Hlv46E5ZZsd3UzShjIQrnKWte/3TJyfWNKj6ZwaLh9q2zXsD4
KDSFbR87LtGIErETWgA66HNLP7E8cfHpbBRoWBwGlnBNsLtE3rcnTqw25qEIJMyd
S2/cURL5B0Xrs/t/58SkqW2Ydz8F0EhdgoZR68Ldt+EwdAEj3uu82x+SbS7WYDTB
XccNnsaC0JBRSZGE6SXxKIrsEv6CO13M5ChGzcawaPkfqIvaRtY=
=AMpS
-----END PGP SIGNATURE-----

--DqjuLX6Z+eEJywHM--
