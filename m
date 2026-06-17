Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8453D1A82
	for <linux-rtc@vger.kernel.org>; Wed, 17 Jun 2026 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690677; cv=none; b=BtzW9oaY3U0aF1sQyHs9WfC6i5bZ2ANzp/PtN/HHKvr6SBGTcy2lhtlczMWD0DVTKbbegpKBsU2S6hAPW5NOrYfpfyh/kyuo+/E8ue2hfQK1Xct0dB7FCcGmPBGGrKh/4NdfXw1wA/XCX18WZ62BIuOX6g/IVjRcVPTshQeb1jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690677; c=relaxed/simple;
	bh=lPh//dIkKPE6lFC5XUMt84P/FROdrRxTL//Ir3Bd/jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6TkMIieZuv+C5Iw17QzXE1nFfkz5wLrVBQwuFA4NgANoOQb4Y8VcLFeoZ9MjCzb+KFCInjcRKirpWee6Ttr+2npHvdVc6SZjRstCtJ6i9Jpb2Y5WL9bBxNgwBQWaFYrNYHqQ27sgvz8jBfCiezjZmPB05mmiqTl7ZnfO9UITLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Sd4rtzZf; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Sd4rtzZf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=61sb
	l/w908/xJRNyWlqomqFd7S40v9pzQvZmcXhPkyA=; b=Sd4rtzZf3/l88azECl/p
	nI/zMolWXG4sccUe4/xrPA8xVZq9Ow3L5iEAcLTrrJwF1swDxQ12LI8/u3LhDM+U
	xh1hTxhLBTlS9eP5ZkfH3XvHO1nT3+3Rb+ueoC0bqD0NnoWHAeqft4rYM4Wlkei+
	qgcsm8RCOAQ2eGkA84KVp4VHwJ6BrLhh7zr+CuWUH52aoPYjTGxOVwAsYx2JhjUk
	6fh2/1rtaRMq6DtEnymy4xNYdW66qPxFRn/z5QZbcrSpMOZcv1M/cbfS7Buw0okE
	XSanzbuUwO2SRTgdQ+luTuXFIkxzoI25RTM3BRMqJOP0ofW8mDdvIkZTRDgMumwQ
	3g==
Received: (qmail 115458 invoked from network); 17 Jun 2026 12:04:31 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jun 2026 12:04:31 +0200
X-UD-Smtp-Session: l3s3148p1@2tqJL3BU7LIujnvI
Date: Wed, 17 Jun 2026 12:04:30 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Prabhakar <prabhakar.csengg@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 06/12] rtc: rzn1: Sort headers alphabetically
Message-ID: <ajJxLmDOCMfmf8Ct@shikoro>
References: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260615154805.1619693-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXg16frnn88_P_jHRH+HPy00wWfoqNKdOv8teSWNpMEGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hBtgEMc2jtrv0zQU"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXg16frnn88_P_jHRH+HPy00wWfoqNKdOv8teSWNpMEGg@mail.gmail.com>


--hBtgEMc2jtrv0zQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > --- a/drivers/rtc/rtc-rzn1.c
> > +++ b/drivers/rtc/rtc-rzn1.c
> > @@ -15,8 +15,8 @@
> >  #include <linux/clk.h>
> >  #include <linux/init.h>
> >  #include <linux/iopoll.h>
> > -#include <linux/module.h>
> >  #include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
>=20
> Sorting of special characters w.r.t. alphanumericals is always
> a bit fuzzy...

I rely on the 'sort' utility which gives the same output, so:

> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/rtc.h>
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--hBtgEMc2jtrv0zQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoycS4ACgkQFA3kzBSg
KbbG1A//dQW0VHQWEcQ5TptO3NyqdAqaLXWtXdhzo4vEUmiRcyAkUZmDoOX3MCph
eCjUZsMopEduFl1QmpB+YuRFhN4mYGwcz8NJzGr/efgEr08IBiX4F7Vt6xSpCdDj
pu4I4UruaUhrN0yReZ5JeXrJCNZ+wAdtmcS2T/kONe1RRhvRZTNbtiRaWQzMFFGg
yLerqk08+dsXq3iMHITRCQ504A58o4DmYm5QsIIQ+bG7KGpct02vpVAaFexGAZNV
oCOCPrnT2K6llmUzPhRLvuMymUC3cLlik48fPNVLjpo517RQup9S/O5+FJ9y9qo9
CsEkzsVRYRfUWNQD2PvAyN4bnUw36kamlHBwYwgo6KWT1JX3Z5Dgz3BMD+Y62dM+
A9hlhyp5/Hs+pzaxh2JLvDlrbVdZW/lKHFwsSAO0nQLBWbU1y8uUfy8SY3/77kua
OviyHRjDs5v0K1/ZQw5jmaOhgTwMyNPN6mqo6kZLkG+BsxF69knoYVRb6w3/J6Gg
0f2pwMV4ocus/hXvP8h3pZxJjjOGxL3z7E5piBCn/RNgzB+vAjZugjKbmgqFjWO3
tOkWk6ObcJ1arFTf3GO5XfdrajEgCx2sDwZxxAq3mhLavOR89SJcH879RVunLfxG
KEFrGLag688orRQ4yb2okU2Tg3BGX9zG1FAkUL9LhhefmQ6Er/o=
=JLdM
-----END PGP SIGNATURE-----

--hBtgEMc2jtrv0zQU--
