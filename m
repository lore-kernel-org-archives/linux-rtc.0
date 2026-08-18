Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091ED38A729
	for <linux-rtc@vger.kernel.org>; Tue, 18 Aug 2026 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787038930; cv=none; b=sDhp/+V8JKfDynxFoZh6QapzauaJqaRpx3acbpiEKyygzV/Woi/TORaVjeQPloUQoXq77MuAJEJc9DhBSRhDzovVmw1/oY5FP+TliLyGsj+XXP8XYzXA9zLRsYJ67MbzLb3rgfV3NSDg3UIaJzavl4Kzi77ACZ0kHLVC4L/9vwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787038930; c=relaxed/simple;
	bh=oGyeMwWwyNxnYHgRG+cYVLJIv4NFuydfmoOIj8UVprw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAqR2bvfB6+dQQcSyYI10BpkGGsf0amI4A9F68szWcejih9gGqw/xO+5X4YwHqHXywfpHDUfQ/LGUAojd8HFs1IEeLTEGGSoGifhDo9+TQ3J4+5hjXIGTLty5jNZiqSn6u60DuA5aczVE4U+esjucHaOHxp40v/dnjts1EH20v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=BCJ1z001; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="BCJ1z001"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=oGye
	MwWwyNxnYHgRG+cYVLJIv4NFuydfmoOIj8UVprw=; b=BCJ1z001x9bRQ28Ttdld
	BdkGWf7swVQrd4R86fovHcFONrTuO53ZGCYApHA7IUx5KP0bdB3ahJg0LWJaLszk
	vE2wuaB2vqdXyWUnwB/DqVfjjClTAAyTFS287NbZzCOkiNbMWgFmxyCP32LuZePr
	2hvWyJoIE2SJp78UGsCow8ekbHN3CF799rOGbmOo0FzPlltQ0nfon8FZlX/JH/nl
	nBSA5uhuHewgjgiFscaRp2QdU4LHDEQ1YqCpDipvJ6eBCyj2bYIIjqLki8jdWxLG
	5n+xieEtgWmcVrS2RpZ8uYiV+AcR0kNkShghqRqh4AhJ86firM90oPxJX3BkVTuW
	MQ==
Received: (qmail 3713082 invoked from network); 18 Aug 2026 09:42:04 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Aug 2026 09:42:04 +0200
X-UD-Smtp-Session: l3s3148p1@n0o/bE1Z2qwujnuP
Date: Tue, 18 Aug 2026 09:42:02 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: sashiko-reviews@lists.linux.dev
Cc: Prabhakar <prabhakar.csengg@gmail.com>, conor+dt@kernel.org,
	linux-rtc@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, robh@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 01/12] dt-bindings: rtc: renesas,rzn1-rtc: Add RZ/T2H
 and RZ/N2H support
Message-ID: <aoQMyllxMOpY5sHx@ninjato>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175846.7964C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G1roVsMbbFrlNkHL"
Content-Disposition: inline
In-Reply-To: <20260706175846.7964C1F000E9@smtp.kernel.org>


--G1roVsMbbFrlNkHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> [Severity: Medium]
> The commit message mentions that the RZ/T2H RTC variant supports a 1Hz clock
> output signal on the RTCAT1HZ pin. Since this introduces a clock provider
> capability, shouldn't the #clock-cells property be documented and required
> here with an appropriate const constraint?

X5H has this as well but the feature has neither been implemented nor
tested yet. So, I suggest to add related properties incrementally.


--G1roVsMbbFrlNkHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqEDMUACgkQFA3kzBSg
KbYqdBAAkGVzBM7LC437y0id2WgytX+hYLCravvY636xG7hvder4rj6oyP3fnQCB
sWFfmh9JW4OrIbhAX5/zK402tK3zDaEBln6mQB/OF3Dbxll/Ok4ZIzvZPFlquXBx
ShDq7OHGB/b05fYuEflJ2suO6BSAChb1xpzBW2Og7ILqLuq0LYzuLTn27mtVWIoo
gmoGFs7+1l2EHsjENoNEyXlE5JUalL4QhH7zT1pTzPaaMk00lEkmc4dlJMW/cJIP
1L15XKkf55HHSMTu7YsSfJbeYi24RnKmghJGIuSBzzRO2xNXpZQgdcxiG+QWpyHg
g47YQD3EZnYS3Mct+35UNeVPLumRqUTGLUfHzdcYxAomRWdUvvKNVbKre2Vi6MWb
mH8zQVLYBdz81rS9MTUM5hIyhc+Sx/WiyYI7yAjh9Z1nJK5wMdksnuKelSF0yIDv
ysi28m65ittECWypPBm150fGGdKv+nGUrFH255J+DzbmHHv2DHiwM/8VAoJqOWkH
BTQXZrHUyhBJGObJOxYm5/jIG1XySC62FBWjp1yNw4WZ8rbeTuac5XB5w7YG84jc
0BGdfe4fEegnPvnzYXBEEK3SlvXpp44MT0pRzLHuGn9kEm8BKBIXYUFvpZD6NtwE
siZAJAbpxm1rNMkl4fw/a5RclQRAm24PVVXFxjlqZNtAHQ+Fv8M=
=ybHS
-----END PGP SIGNATURE-----

--G1roVsMbbFrlNkHL--
