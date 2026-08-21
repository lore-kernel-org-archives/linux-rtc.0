Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8F441A569
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324930; cv=none; b=Azr6zOqlGMBRUjMYZ4oJCq8gnDrcjPLosf/RTQmsvuFFcM9M8GUN8ll0K/q8+KgUbTzNvP0LFSKT+CmlO+fyWfd4QS/tvB2dNcHd5tiTgN4w19/PaKTCr6L09lXaBziT4azlbfS32oBU7FaFugfYvlyGv5IFU/URwZqqKWz4HBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324930; c=relaxed/simple;
	bh=b5Y9L5ynzvQ6L2rHM8+9SRWB3i51pTzonyCk1dx+5Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F23lAFo55MWmuu//t54Wl2oU6QUEwzyWMJ/05r0VUBoQwQoGzlaVbraq3+QbJtgEV+Ixs89sLcS9BQvfQkaJuDbksPZHsdqtrrV4PuxaeN3dJKxbCPG6htxyS1MJKBzk+DxpDnTZej/uoevNlH7IEryBo3Z4Fd/CHedif35mdAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=iobvnOUj; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="iobvnOUj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=b5Y9
	L5ynzvQ6L2rHM8+9SRWB3i51pTzonyCk1dx+5Y4=; b=iobvnOUjBprk5YjYOjE4
	MAR50YsEjSyd9ELLp6kafbrXi4KoEa0T1B4Bbn3vhUjbZj/5PFldUInrqWbPbp0T
	lVWL+oLUkM0/Bn942pBwd0s4AkQ+uNA/IfOzwnhMmkU+cY+YNmlSYswAnrhrCGRc
	Bi7Ta2VvTD0ZMZQcMa3bgtbUDF68XsGhXHTHwQeV7c39iHrGHtmi31ZEqFFum/Kc
	Y0qMp6w/gFlcBqZ6k9nnial3PNM6vcFpvokmiFvqKyyV6I67KU3R6RRcOdmO4EO8
	F6s/RZSUSqnPr1AXNxBw0zA2UbMwKt1Bq9By4NA99QFwjeNiE5hGKurRPGXOVQEA
	0w==
Received: (qmail 688578 invoked from network); 21 Aug 2026 17:08:45 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Aug 2026 17:08:45 +0200
X-UD-Smtp-Session: l3s3148p1@42k/A5BZ0o0ujnuu
Date: Fri, 21 Aug 2026 17:08:44 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: sashiko-reviews@lists.linux.dev
Cc: Prabhakar <prabhakar.csengg@gmail.com>, devicetree@vger.kernel.org,
	linux-rtc@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v5 04/17] rtc: rzn1: Handle unset alarm weekday in
 rzn1_rtc_read_alarm
Message-ID: <aohp_FhNdN-6T2ti@ninjato>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821141010.6EDB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2yfiX9kASGv1Xixk"
Content-Disposition: inline
In-Reply-To: <20260821141010.6EDB11F000E9@smtp.kernel.org>


--2yfiX9kASGv1Xixk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> [Severity: Medium]
> Does this early return prevent the hardware register from being updated to
> clear the calibration offset when steps evaluates to zero?

Dunno but we have to stop somewhere. This should be fixed seperate of
this patch series.


--2yfiX9kASGv1Xixk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqIafwACgkQFA3kzBSg
KbYNzA//TCemymfwY6MkiV1NeJtZz8RppRNfnh7PriR//yyH4HrBt6Yl1OfFK1e+
GdEGjiBnDoBGuzwNgBTI/fa479bijfs6o52c4+riGvWolk7+/Xj88eqA9A5Exl7z
IqEUkmRxNVwukg4jfWPvPcbbc5XX3AuIqipA4KGcwoo77uCtaN18nQtMvyR/ipDq
IRW9RG+yhWcgj/ivbxYMieGVgQgDy3hbitJvE4F2Q/WSeMgHQMIN/KGmEX51+GpI
Yv9CuPVYMkWHhGj4ob0W/Ozx8g9cifJyyW7JEVvLDFqaHc/iHLeMmHi/2DdoWpRb
mRrwLYlTM23dSixyuMedjRi4unzaTxW/L6r6TWAv8IwDTyyRpfb4to9EYLr8EVIx
/XQfQ1JN8xbnxBCG6VOilS6dh6BbklvyYdYGLdvA4bIK/3Y+i3K1CKUCbPviywoU
gEx4hf4Ewdb+W0xEZO28m/FDtTnvsToYLGSu8izSK0l/WNgewiAwWobB4hFdCYfn
wL6gWut9HXq5IHGzeuvfZdTj08hnCKbxAiaMsGxXpwVaraMc5Mb0XP8AUIG5jsZ1
cLsxptvdiAoVHckEk1hN8HY0RCFrsUHVyli33tMqF1hWmHxVS0ngjzflaHS1l7M2
MSC6fZq0ZS48Nh3o3k/lWJJt0DJ1STyjELK0r4eAhorNsJPh2XY=
=KiT/
-----END PGP SIGNATURE-----

--2yfiX9kASGv1Xixk--
