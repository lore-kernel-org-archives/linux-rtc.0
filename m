Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB54348C4C
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144743; cv=none; b=lAjCItnctCrb3r/GCt2E6OId2UUv09N72xCrlK1ZTu80oKgsqzu4HcUYIHLSNz59X22/+luqLdO8YH8USeY99EIkTl4vPwTo+UGU6yx/hE/zEfWuf8qRLPVve6jdHNib0i1HlzVWQP8MgUFHyY2A2QMI3BqSsduc8EejwRAqYqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144743; c=relaxed/simple;
	bh=/D1VsP3SQhtNO3OKkceoJC90C2gXHy4rFbqa5Y3NOfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMjpFD7HtocYqM32eQ04lTPFWcmaEoRC/aB8AeMapqCoQbIFAxYQQ7Kp+9gsUper8I1uV0WsxqiOs7rgPaCpkc2UpHlk32FElWpDOiCMip1mjzh0BH6j6j55JM/FBwdDXMynVRdcAyR9T9MjSRTIuAJa9NarIH+pOBs8miJjHfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=EQ8nKAJ+; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="EQ8nKAJ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=/D1V
	sP3SQhtNO3OKkceoJC90C2gXHy4rFbqa5Y3NOfU=; b=EQ8nKAJ+pMBCew5iUYKS
	2qh90EPzcGPTxWmCrVY9gpvOr0HpZpQMVZLSImFqpESesxx3RsWLF9U1caB7BK4e
	ZjCifJ3hHU3bW/hNSVFnZYtbjA7CiQPRmKnbvhMSNwL1ectP5AtRbRj8IIyO3O2X
	bDJ8DaRtFxzOwgP70CSpLP5PyFfUNZ0WI/JZxx5yVsqQXlTvGWR/vXomv2i2dSKI
	bLS+LXualDOxZugtfWEcROeOZENQK6GQFLUodxbP0TXJ21F38FoPeoD5Ko41TNNl
	ABbgHI2ry+V9z0Bw+AiypV16x4libqyfS+LiuOxUnEIORDgv3hhPguCZ4xjMR0tY
	+A==
Received: (qmail 4147323 invoked from network); 19 Aug 2026 15:05:39 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Aug 2026 15:05:39 +0200
X-UD-Smtp-Session: l3s3148p1@q/9ZD2ZZTWltKXGR
Date: Wed, 19 Aug 2026 15:05:39 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: sashiko-reviews@lists.linux.dev
Cc: Prabhakar <prabhakar.csengg@gmail.com>, devicetree@vger.kernel.org,
	linux-rtc@vger.kernel.org, robh@kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	conor+dt@kernel.org
Subject: Re: [PATCH v4 06/15] rtc: rzn1: Fix alarm range check truncation on
 32-bit systems
Message-ID: <aoWqIxFRItjNu6uN@shikoro>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819105028.70F3A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VofL5F6kBP0bJeVp"
Content-Disposition: inline
In-Reply-To: <20260819105028.70F3A1F00A3A@smtp.kernel.org>


--VofL5F6kBP0bJeVp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> [Severity: High]
> This is a pre-existing issue, but can this sequence of register writes
> trigger a spurious interrupt?

I think this is true.


--VofL5F6kBP0bJeVp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqFqiIACgkQFA3kzBSg
KbarCBAArcmhyt0MLfoZ5yb6fj+jCSupu4CHWhCIWhpI6FljbxcMGGDpuUuzMvbn
yq72MpkbAx4j0u5UYdCsIc4vfoZtsgT2gJwPwLBrLpKk87galelLAzJoQtOAQFIn
qWcWTkXjACzqfJZkhklsuKu81KEtNm3LaBKI5C/T1D8zSq0zj6rTLx4aoN8B2e5U
P2rsALa6OTh4eObEIxixuUdOlgOfMlMD9RLZoOsmdsB8PImsw4WmsFHNPXhnxffZ
3Jyj0bnCM7LroDm6KnREaQVWlCuj2FFppHh+Ku/w9SZKMQn72H9ijvfghYm6ttTv
6nsQmFtlM6BzKdruddoc123VB7Hzr2M+ngaM2MdBihiaprNsI3rRcQodj5yu0tOF
KFuS/3p6WxnZ+kmf9XMegGc33TbMwLgKoAweafaz3NE23g4Qpt63tsopltzmr2oE
5ztQqA5ugj6Zc642DdQhDVAS4FJaKHuS04VHtbO3uaOlXVEcNnUVkZlE5dvGIZyo
cKl/CQYOOG5RqPgORuyq/8LEfdidCcRK2gzq+7wRCJY6aqpMLq56Dy6ZCYj03EPk
I4qs3hSrmThwwafxyt3eMxa+qStOJ5QH0WM04QpQrlBaTYBhnaarQj8WtyjkUjHN
eMgDX27m+JVjtuE7QXdSN3ko6oWN1ysPigMS7AyWEhCjFAFw+9w=
=IVCf
-----END PGP SIGNATURE-----

--VofL5F6kBP0bJeVp--
