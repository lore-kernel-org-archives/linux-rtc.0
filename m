Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00092CA6F
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144946; cv=none; b=aR5oSXkHBSzu7u9TfJyLgJnp9PocvjBvrA87RMYN+fr4mlgbnBOVFX8XjA/Q1Sz+h/de/fMyt9nrQ+FDEPkYTyWDbOXG6+08aMTXz3o+lSASIYOdtJMSnFou5gX2XKs4mQV/sNJvOfGHvwRjpwU3XdOGVBrzdvUn61p6B6x8pIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144946; c=relaxed/simple;
	bh=9Nbn5o/vBr01BfPoQbRvxsX77v5JAqrSqzMER37fxfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9YYj0bazs+/3sRNAIJ+y8gjb0OlwpZwzrneNgDH0+hmVBc0s78z1w8NMVrg1u+PvsX9UgURIKqEXzhhjsK1Y4PWNf6cTgn0wGjpNUuPOo6qcPV+g6dwXW1JGxCtYBQswmxndNDAYHRZl+gFJwn95JHjh2RHNpCD3V/DfVO98V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=eKMfDVFQ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="eKMfDVFQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=9Nbn
	5o/vBr01BfPoQbRvxsX77v5JAqrSqzMER37fxfs=; b=eKMfDVFQ4RtNu+Ljdmtr
	lN7rFMsXIRkOqDakzGWLDSJiMZRZ2LMf0fgQCs6JgblM4WXxf0ZJT7VYB5+GNMxj
	6CVdMFXIn+mZW/GGLKf2FS66JSh+Ze+WeKjwbtNl7NAVYDGXymoWxon0tMn7ERoX
	tikfb60RR4ozi1L/aj9Z1R37rlSI4WP3ATlZtPpoXrJp1a/W40uZGdicta5BhL2n
	rJYcI2kFFV2BeeP0CRo32qmi8yDfFmU5Fb3G8z3WI8Efp5p5y0TXUfM7O5R8FJBr
	fH6BGxdn4EYXho/sGOFPJTIvWuJOKJPAF4zquMPibSIHX4c3UlgybTAFzY9zej62
	kw==
Received: (qmail 4148485 invoked from network); 19 Aug 2026 15:09:02 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Aug 2026 15:09:02 +0200
X-UD-Smtp-Session: l3s3148p1@IGZvG2ZZuFNtKXGR
Date: Wed, 19 Aug 2026 15:09:01 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: sashiko-reviews@lists.linux.dev
Cc: Prabhakar <prabhakar.csengg@gmail.com>, conor+dt@kernel.org,
	robh@kernel.org, devicetree@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v4 12/15] rtc: rzn1: use FIELD_PREP/FIELD_GET and GENMASK
 for register access
Message-ID: <aoWq7VdKlAl_jGQQ@shikoro>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819104926.DBFC21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xDYN3QcHvYQLh2t5"
Content-Disposition: inline
In-Reply-To: <20260819104926.DBFC21F000E9@smtp.kernel.org>


--xDYN3QcHvYQLh2t5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Would it make sense to wrap this value with FIELD_PREP() to enforce the
> compile-time checks and stay consistent with the rest of the patch?

I don't care, you decide.


--xDYN3QcHvYQLh2t5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqFqu0ACgkQFA3kzBSg
KbYvNBAAij/txVALS6HMLJAZHs13t3Pmzs6Psr1E5mwiYpS8Qhx/iO2u+LQSo2kb
vYynQmnYrFZNwa7w8OEP3g3BMAoXKDP5/bmU7y0bMEgxDoQ9vPgieJaxprMTQ5hT
BafV0JZk+YxMbDb04CN6ioTYrQ7uDQenW+OLS3Lfmh4O+TF615sPOB4p7vadbXdv
uOfw1nX/VqRTI9uQ/uTeXdNPQ7IdtUSD15NyfaDezawjSj98VXVeKkT1SeaLvgBM
67Va8LO0W6dcIu65h/6FGz23b+7C5ncuxrH4xQCKaDwzlICxgLkjVSw836fPqnQ+
XC8qICRy1uAJEPCeIKaZtm+lx2n38RtEL1GzYlQ7zimGfyRa+RybB82LdsWMqf+K
AQhpnsYv847/FJshoHVCw/4HiZ6mZG8vpY1nLKt0vULccr1aJl4+17Mj2tttDUH1
/TTk4l4G0Qu6+bmDtTIvfgZp3YXTpjZR08FHtPuBm6sFYNDml+9zuhIxtns/zd6x
F4/F0iwf1WTkm50G1EaFXxdrW8Pye36E5qvaB6SSOsi83qa67HM/TjyHiBInjzel
1RqpJyt3ZfBx2Xicw1Oof7NPieC0lImT3hNLmnV7sOl0HbkkDXQ7EkfSyiLAtbLC
+3UQ3PGATuB4fbEjMD4bzwmWL6Q+IQB2W4EyN38sbxY2frFJp0M=
=NkSE
-----END PGP SIGNATURE-----

--xDYN3QcHvYQLh2t5--
