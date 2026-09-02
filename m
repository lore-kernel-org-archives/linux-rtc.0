Received: from mta1.migadu.com (out-199.mta1.migadu.com [95.215.58.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9C54766AC
	for <linux-rtc@vger.kernel.org>; Wed,  2 Sep 2026 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347281; cv=none; b=SEwQgrmdrMPXkr2492vWHY3QupbOJI4qawGAa8W5KSbD4zBTgt1ClCAxNVIPnaHEJN6H01rAjs/eBo3oXfA10TfXmscDgy0reQIUbSOtSpuuao2a+WYfEqPggclpecgBC3HD9D7XTHleD/jifEuhwRivGCCGFUy1egeK1dT/32w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347281; c=relaxed/simple;
	bh=1HVX0QznIeEH3Yn+cjpqvVAEiGoY+5zL4TL1ple+vFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWgtGtCOXFtgWJfwIN6VpCL6S/wu4diVopSe/cMI3c1hUzuYn7kf8hntifQwQuEx1QILDNHe3UDWIeUrAdzJHrIGAU3rV2at6MiM8lNqLTsJsTFrSwMP/W/tMq45jlHvOLB1ctvdHTo/0U70vnADKau/kWrTGltVLilp5Z+U/D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lIDuz1Gp; arc=none smtp.client-ip=95.215.58.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lIDuz1Gp"
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1HVX0QznIeEH3Yn+cjpqvVAEiGoY+5zL4TL1ple+vFo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788347277; v=1; x=1788952077;
 b=lIDuz1GpVB3Kunsc4lviuvbGbpug/5XYyhoWAuqLYXy4V7rS/HDJUQAzfi0mitj1mpRH499n
 jtB2PxcBTgfImlIPpnQMtZqZxW1erAGQQxrUpwgJm44BeQdzTG6foqP/c+UqmbKqz1PVDOyUZrF
 7q4lgWw6hDJI4V7fzgnGsaPI=
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id b9341dd2beae2cd4;
	Wed, 02 Sep 2026 11:07:56 +0000
X-Mizu-Trace-ID: b9341dd2beae2cd4
X-Migadu-Flow: FLOW_OUT
Date: Wed, 2 Sep 2026 14:07:51 +0300
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
	linux-rtc@vger.kernel.org
Subject: [PATCH v3 10/10] MAINTAINERS: Add ROHM BD73800 PMIC files
Message-ID: <cfea698c783274d26858e85d4ca7068eba3d3ef9.1788346553.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1788346553.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0FeZEPMpasJlEgax"
Content-Disposition: inline
In-Reply-To: <cover.1788346553.git.mazziesaccount@gmail.com>

--0FeZEPMpasJlEgax
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

Add the undersigned as a maintainer for the ROHM BD73800 PMIC related
files.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

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


--0FeZEPMpasJlEgax
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqYA4cACgkQeFA3/03a
ocXk7wf/fv7aGQBmrQLxOgHBApSHfBrtnLYfNs/PJK1KrLJgU82PQ1eosOVB42Id
DdKz+lGmOMWd7FZbbT5NUnH7dQu8WScXrn0016aNsYpN13dhaUwZMacOAYfrcuQr
ySclGtVBxKaF9fq8TF5H5XNdI6xZJ4odC0Zyz4pt1aoRayOGqgJvexsg2K3ckI2T
rId4F/LihCnHT0n3eaSHFWl24J+flFCz//gUr8uA14ufig0gi9y73zceg+V28Qj9
QDkCe2kr5JRrMeGu0MpjZefGGP6dU9r2P5yzK9gs2vWZkbwGCO9u/09hLTGC6xgG
wh88iMN5JnRl6ogCm1W1bzvHqtV8gg==
=rFWO
-----END PGP SIGNATURE-----

--0FeZEPMpasJlEgax--
