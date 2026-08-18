Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640FF3E51C6
	for <linux-rtc@vger.kernel.org>; Tue, 18 Aug 2026 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787050277; cv=none; b=kPpZdco3a9foBreahnI0sgZE3NS/jm9icm29mTpMoJ2xizmqVQLDC3AdVr5VHs/9r6tu8i6ozGwKJkL5FOhh/1euWhzwzs8hSklMSlwraV5Kno56mJXbCBwE0m5X3If8ng3unnwHsqWFXhcZMBXP0UnAdLtAl8fi9LU+Ty6mfW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787050277; c=relaxed/simple;
	bh=XI6eTIuvgUaJ8wwOh6l/BdaRuxz6+wAmPBXm3VeUo4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHOAvYdyShy0Ce7186k/s+W754HN6HIGnc8SS978ZDkDsUVBQh8IoUOekM/qJBuFePumUdPYa56k4tWwSDh/S17YGsePD6FdzuxL/Qaub4TYAUjrblNXmXI4U0HZI307PIa+XMfreFLGHiznKojAT0N80YjiMNjULCdk8Grnc9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=RLF0S+kN; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="RLF0S+kN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=XI6e
	TIuvgUaJ8wwOh6l/BdaRuxz6+wAmPBXm3VeUo4k=; b=RLF0S+kNS9v4/mlOZQ2V
	o6sq/ALl+wKL/ROn3xZ4EgizQpjH/peUXt4tjJO0UXkRGtTZHcGbO67TZN52gxEo
	cA5hfeWDbEcRbkJnBELzI5trqHpzVfhWpaZj1hNsSZ2sKmbd1528idhMsJEfB8Mc
	HbeOrZvUOtbrRAjgBrYOUeYWa991qSr9z25RYTk5gHrIj79RQibA3nczjiSDDW6X
	PPQJA33B16G9VzaHPRywjdoZpK0WoULVHstznK/9LVW8ibgkKzVGqPTwAYOAXLlt
	WH7IMhpB6UeuCuP4zRGlO0l5nrqnkksSjcFwnGTxKtbjf4jiyFkMX2iMlFDGF7Sc
	AQ==
Received: (qmail 3764408 invoked from network); 18 Aug 2026 12:51:13 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Aug 2026 12:51:13 +0200
X-UD-Smtp-Session: l3s3148p1@ZpG4EFBZGIgujnuP
Date: Tue, 18 Aug 2026 12:51:12 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: sashiko-reviews@lists.linux.dev
Cc: Prabhakar <prabhakar.csengg@gmail.com>, devicetree@vger.kernel.org,
	linux-rtc@vger.kernel.org, robh@kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	conor+dt@kernel.org
Subject: Re: [PATCH v3 09/12] rtc: rzn1: Use temporary variable for struct
 device
Message-ID: <aoQ5INLOtNELfXpH@ninjato>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175655.6A31D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i9uCrGg6SWItUDpN"
Content-Disposition: inline
In-Reply-To: <20260706175655.6A31D1F000E9@smtp.kernel.org>


--i9uCrGg6SWItUDpN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Should rzn1_rtc_disable_hardware() use pm_runtime_put_sync() instead to
> ensure the suspend completes before runtime PM is disabled?

Sounds reasonable to me, what do you think?


--i9uCrGg6SWItUDpN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqEOSAACgkQFA3kzBSg
KbafAg/+MCgXVaHhq3ddk51Im5xzgcqbuC9YjNFX0D8+7HqPozGqmWOfxCVmJOZF
PeaJyVcd+JF9e5+DH85exClAWl8s0p+ph2UWsuYVX9RH86ErOQJz4/lpaLVguc6K
NrAizPCc8TnkI87dc4iSidArzVIpp4+2g7y/qCtX0GTP7qTS1vVcMY/THkO8pT05
djQPlQ1SJ+OwF6qgAK5KWd/ayiKgkqzCIIkpuIQYQa9S0Q5IjoI5HXE2d8oNtm6p
75neuPZGVuJtzosKB3SB/j+/fU0hjamtnnXppk5MQ9hCbkcSkLNpN4xk4iE2OcSd
4IeG9kobM/zj8CSFuBNfCT1aFepRHPBS3oxLvena9Sd8FjVXk8pWLKcI8vZEEoq3
I9NriTjIcPHJTq3AM0aygvetDf00+eMPAxwWGNFLqrWGncCqXyBpyuw6/4vsImSa
1xjD+Khfm7CdqAeqmtq/B4vrR9PIqgS357TeJ20kVEb88BX4nSiQVWn1us9mSPxJ
a6gE2kaYdRKcEVTQbq5/smFzuOu8MR8SFsraRfeMk6f74tNOlWT7dPsf4EfRRfzU
vdoUSh0UeKkG7wu6F3TZJpn/PO6NunAD+0yefyAzclMP2SmaVpUjH/p+FwIoYdzj
INTb+V/qUf82I1atd2aPxp40/jim4MsRI2jZz0GEFliI5SVPaRY=
=gHS+
-----END PGP SIGNATURE-----

--i9uCrGg6SWItUDpN--
