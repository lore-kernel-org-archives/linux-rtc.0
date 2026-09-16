Received: from mta0.migadu.com (out-206.mta0.migadu.com [91.218.175.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C995E3C09EE
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 06:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539182; cv=none; b=f3/tN7rGJF8xc9pNHjlw2wdNJQLccC1gyqXWZlj5Ie2W53Yv+We0pD+h7WbfqoRrKGxJvhvICKwEafAzCQma6WvrX4sT9zTLQQ91HsdjPZaVxU/QzXdkDfeaEOBs36AwpQd6unU8Y7QtxA9GefWZ87CuwnAEw0TeB8tBWaTe9d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539182; c=relaxed/simple;
	bh=oI6jcWCD8TyMR1NvHzCU9RzXsy5dY9606WpYMP/nRCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmQ7zqvesYC4cgO24E1iE/ewoFcMGZ/XV4eY+FWPaHwZwj2LCNeTG71ejOLSMXBmh45d2ssXdYe5eXioEj3rcKeXWd3KehVwMZyeHmIBXWiBI1tvrB8Uo9oUnNEx5Bg4KpOa++yPX2NpdTr1f6ta3olUcsHbW9c4118OOQ8rgHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rTBSXlxD; arc=none smtp.client-ip=91.218.175.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rTBSXlxD"
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oI6jcWCD8TyMR1NvHzCU9RzXsy5dY9606WpYMP/nRCo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789539179; v=1; x=1790143979;
 b=rTBSXlxDvsBqUYLnTNMfNVEHTXhKGHxfUAgi7m3Ek+qUHb9wMUk3KcZJbckYDFCk8MblFehx
 3jFXUAgfch8GA2BXDFLHYOcgFgGKeW36ul/mGOECRWVlV/WQtMz8advMAzeOwYh5p7BUzhbidWX
 jpCSjim67SuZVpICN1dpuVk4=
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 96fcc20599bce933;
	Wed, 16 Sep 2026 06:12:58 +0000
X-Mizu-Trace-ID: 96fcc20599bce933
X-Migadu-Flow: FLOW_OUT
Date: Wed, 16 Sep 2026 09:12:50 +0300
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
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Michael Walle <mwalle@kernel.org>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org, Sverdlin@mva-rohm,
	Alexander <alexander.sverdlin@siemens.com>
Subject: [PATCH v4 10/10] MAINTAINERS: Add ROHM BD73800 PMIC files
Message-ID: <078e51b1a71ca5d823c81cde8d3bde358742b2c9.1789538455.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1789538455.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SbEvGAB+GKChB7iR"
Content-Disposition: inline
In-Reply-To: <cover.1789538455.git.mazziesaccount@gmail.com>

--SbEvGAB+GKChB7iR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

Add the undersigned as a maintainer for the ROHM BD73800 PMIC related
files.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

---
Revision history:
 v1 =3D> :
  - No changes
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..b0925fa212cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23821,6 +23821,7 @@ F:	drivers/clk/clk-bd718x7.c
 F:	drivers/gpio/gpio-bd71815.c
 F:	drivers/gpio/gpio-bd71828.c
 F:	drivers/gpio/gpio-bd72720.c
+F:	drivers/gpio/gpio-bd73800.c
 F:	drivers/mfd/rohm-bd71828.c
 F:	drivers/mfd/rohm-bd718x7.c
 F:	drivers/mfd/rohm-bd9576.c
@@ -23840,6 +23841,7 @@ F:	include/linux/mfd/rohm-bd71815.h
 F:	include/linux/mfd/rohm-bd71828.h
 F:	include/linux/mfd/rohm-bd718x7.h
 F:	include/linux/mfd/rohm-bd72720.h
+F:	include/linux/mfd/rohm-bd73800.h
 F:	include/linux/mfd/rohm-bd957x.h
 F:	include/linux/mfd/rohm-bd96801.h
 F:	include/linux/mfd/rohm-bd96802.h
--=20
2.55.0


--SbEvGAB+GKChB7iR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqqM2IACgkQeFA3/03a
ocUlPgf/UQtEHmpliQhUmYPnZV6kHQcYRZWQcuWpDMSNJt8M7evnNQYXhFcFtpeW
FCGQUzkzPrOtKQUj6T3tvikw5duc5K1mBuczaAIt29RJ8H7uGBz8kjNAPsQobMa4
rD6xam7h3MHtOhXNDb2zQTcqi7ml0IrRQiaqGRyL0MQtVqA3bT8NegCDH8UEmwQn
xL3zLiQ+/gV36zrfgPBUSM5MQYuQCN0Rfo/ISVG2Q0fdxOGigMzBAzPeQjjNx1bO
RCBOkDPvlfLxTFQqEVkusNpWkXgVkeBIPFf2EgjAGZCYo7nllPKSY3RFMDvb+mXU
q0IL7vs2YtmhrrxCGBO8VpuwMg3uLg==
=UR3U
-----END PGP SIGNATURE-----

--SbEvGAB+GKChB7iR--
