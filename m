Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC51347BA7
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324650; cv=none; b=IqozEPBosjY9xyTzRBOtsI7Hpo5HeuX7a6Zf6zOLQaPJ/wJ7D7EVd7ietjkq3kJpZoQIyxWiIrOA6FPaGEb/up2b6DF7UhvwOqAho5Dv7hYhNfv+e1ehqIFy5P8njxNwqJMlvjUlNpYCaG1vPKAP7GLAifC16qtjdjhknDtvRZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324650; c=relaxed/simple;
	bh=RAEWCuMpWpAqrfwmkNURwdlB1mLi1nB5h/ADqQV5/xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cumKh0FZy5z/C+qsHZzIThLZA8LNeVBXJWRRe2ffkKHy+yFNn4GZuOx832PUG2L/2LNMzxBwZK5GAe3PfAClfYsYLStWL/ZjMclYQjSa1t4RtdTX4TNNWgKEtu1AQbmKfAHdQiRBxw6djI2BCv2v+xSsoizWok7/A7dNpOxGgjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=XabaeJqV; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="XabaeJqV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=RAEW
	CuMpWpAqrfwmkNURwdlB1mLi1nB5h/ADqQV5/xs=; b=XabaeJqVVhmKsLAyhW84
	PqEvWQ/NgvV0HalabjuwCuE/lc/+9+9nOhqL6QL8X+OpVjSAFmTk7GQNGP3k6qsU
	75wrXX57m2UUQJahnaTPQDdbDIuDoeyBH0o/TSv8UxK9m9n4VNmOJpjWa5j88257
	e0kMPyYY38fhOBRdvBUzwQsf/dsv2imxgjDrHiMQes/iXyr0JX5GIgtSv2uc3Kk4
	lA3WA+mRfRwUc4IYEbUM2QR0dUsz8bap4+Qt7ksdX5pkko/pEPYYZSIwVpPjZdHe
	/OitIxsSZbT4A0nBrLsFKrradMhtPthQm2sBk2GhGX0uk3f8ypV3xtia+cvSFjcB
	jQ==
Received: (qmail 686988 invoked from network); 21 Aug 2026 17:03:58 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Aug 2026 17:03:58 +0200
X-UD-Smtp-Session: l3s3148p1@hyMq8o9ZRIkujnuu
Date: Fri, 21 Aug 2026 17:03:58 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: sashiko-reviews@lists.linux.dev
Cc: Prabhakar <prabhakar.csengg@gmail.com>, robh@kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v5 01/17] dt-bindings: rtc: renesas,rzn1-rtc: Add RZ/T2H
 and RZ/N2H support
Message-ID: <aoho3qDXfUIo7a1d@ninjato>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821140541.1297B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KUQ78210WyRwBbZr"
Content-Disposition: inline
In-Reply-To: <20260821140541.1297B1F000E9@smtp.kernel.org>


--KUQ78210WyRwBbZr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Since unevaluatedProperties is set to false in this binding, if a device
> tree node attempts to expose and use this 1Hz output by providing
> #clock-cells, will it fail schema validation?

Binding will be updated once feature gets implemented.


--KUQ78210WyRwBbZr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqIaNoACgkQFA3kzBSg
KbYbSA/9F65H+jpsmNGjYHcCDkjw3qHSk01Ah+faTVXqC0Z2tcyyfY2429kFPOVl
mM5Ktue3897HIZxIR4+kCUNhTasdFCXY2qlfr8SAlatYWES6zDUqBNrFm4bPAX9+
WOrRBd13u1qh7w0FG9gg5HH2aaKMCkWgaCau9SMvHeeIRp4SlLeTP4Zw/W9DbUFb
ZU8IECTdXtCB5z4Wf2Qm8Wb8MhlqwYdvmcq5IEmPro8LbqRhFRg/b/k/AARhXImj
Ohgn9NzFhur4/L5QefKTm9Jab8PLq0mdEfpSt4/Wcvm3UYozmmx0uAUw7DncQ0vL
iJSIlDUAbT2DuAlDpGBAbJXNnzS18WLLFllzdqTxzYPS2qcouNK631nj95DuaTGd
0QPcg3JJt62QypdlmrKyntycV29l+8dR9/2CSSDIU63XjeBsr1ds9uejtD6Rw7hY
GTJVc0J/u7eW96E5xka7qUhIFr/OELKsCslNhTKh7tic5wmqevJzge99ptBW2ozN
5VcUbc5tb2bPGPtc5K50RiAU0X8LfenYN+9XJzDaqBg96ekifhXspiB+CzX7JpGH
MU3MuCHYFIjPGNE8IJqFmzhfJZI3h+AkGrG+TFOFXoBY6OEdGMuEwZoe6ZLrHHZm
+KWBcMs5xtTpZVDuHmAbYQ+QITHdCYfQBVKwyWavQqeVGP826Z0=
=i3oQ
-----END PGP SIGNATURE-----

--KUQ78210WyRwBbZr--
