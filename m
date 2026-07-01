Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F801481641
	for <linux-rtc@vger.kernel.org>; Wed,  1 Jul 2026 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909839; cv=none; b=QzkaboWCHiwDnahh5bAs3lseX3Rv+1nNQCpreq27XhvtGMc+wMe/nMWSwdi23jnhSVxEWvLX/HzSgQiSfpiD7/4AGTGOMUGlJFKo00tuxPfRIhtutQJ84naTgdeSc4N0i0z17VVUfieJQeVtShBC6RdCgKF4gHCnIeT69fpPFxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909839; c=relaxed/simple;
	bh=6t6TRoE3H/XPSUTPmMbz5ishetNjDBcVUQXQegWXEiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6VYUoqx86U6CLuJxVebXCvWF7nDv6ols2Cr4E9lRQZ+/GuP2q69etvVf76BByK/o0IBtSWVMKUebbYm0C4l5sObEYsxnei99CEba48SBHZWecVgc4zJWYBtOu2DDPG63WJAIXm8He1lo7CHY9lU2PtGuWnD4UjDibD8UOAhbWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e4vV2phO; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e4vV2phO"
Date: Wed, 1 Jul 2026 15:43:46 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782909836; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=MiQ1/C1jpe96dAYn+Baq5dQ8BcaDntA255UEyCOTILQ=;
	b=e4vV2phOsDtihHVJ+K8nZUPzvB6o6KPg6J1kPpGLgeKHETTupGMW7UMNnnpN7Zarar21B8
	AcsvNCogj2cVvF7To0PvBt9PXDMXetI/mLf9GSK4OGP14bxCPiEtO8FqmnCQ6FTyYfWT5J
	8j5h1kaNM33d5rMBRx8TNemRqjIjOz8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 8/8] MAINTAINERS: Add ROHM BD73800 PMIC files
Message-ID: <1eebab6c729762d30b843edda6b4d94c7d2f7a5f.1782909323.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1782909323.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kDmr9dI/n9pZMDFs"
Content-Disposition: inline
In-Reply-To: <cover.1782909323.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--kDmr9dI/n9pZMDFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

Add the undersigned as a maintainer for the ROHM BD73800 PMIC related
files.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..92795b08bc52 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23539,6 +23539,7 @@ F:	drivers/clk/clk-bd718x7.c
 F:	drivers/gpio/gpio-bd71815.c
 F:	drivers/gpio/gpio-bd71828.c
 F:	drivers/gpio/gpio-bd72720.c
+F:	drivers/gpio/gpio-bd73800.c
 F:	drivers/mfd/rohm-bd71828.c
 F:	drivers/mfd/rohm-bd718x7.c
 F:	drivers/mfd/rohm-bd9576.c
@@ -23556,6 +23557,7 @@ F:	include/linux/mfd/rohm-bd71815.h
 F:	include/linux/mfd/rohm-bd71828.h
 F:	include/linux/mfd/rohm-bd718x7.h
 F:	include/linux/mfd/rohm-bd72720.h
+F:	include/linux/mfd/rohm-bd73800.h
 F:	include/linux/mfd/rohm-bd957x.h
 F:	include/linux/mfd/rohm-bd96801.h
 F:	include/linux/mfd/rohm-bd96802.h
--=20
2.54.0


--kDmr9dI/n9pZMDFs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmpFC4EACgkQeFA3/03a
ocVcuwf/V8mvdJre7xxJ4FAz8hw8Mqz8mjvmSZnGNnbVkH7ZoKolHDW53cyJlNmZ
C+Gz586iz/lXmQSssIMJcm1xUKvkULFKS6lLMn3108fdmoc2xbtIiJT78fZevNfp
2Mgg+GPmgxEXHheyB06ih6qf32UlaDlrZwb2nUAKchyNFWoz6zTUBI23nv+CiHpq
0knu0LeM4MAzOBxKO3ZqB4BYgixbcw6t5XnWLwmaeABbgVsxy8VOHj7IqmoYYKMI
LNQg60m/eo0wPIs9QI0unQUQetbECr3WkcBDGy2P8U3SaHLq9v1p9nTwa2DhhDNX
Wny0/puUnjqFBZvPUAmWTrg1tvBZhA==
=uRdm
-----END PGP SIGNATURE-----

--kDmr9dI/n9pZMDFs--
