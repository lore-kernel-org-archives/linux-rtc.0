Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BA0481A88
	for <linux-rtc@vger.kernel.org>; Wed,  1 Jul 2026 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909653; cv=none; b=CR5yHAfqtz+e42OTJ076ZFkwjIQH1ZNIp7ybh1O3KnhRclgXH7T91TCRe/u06x+3kJy1WfUsnM1l1pDhpSahKUgfpPGi9F2/sy/pHbgPdWwKBLwTpZSaVmcDT/ASw8liobpf4HXyfHMXlpyJpFP5L5wJgGqfGEX2x4/3y3XxuHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909653; c=relaxed/simple;
	bh=u7rlk6WjnZJ8yyBEjOlow02CVcCwL5fGiUnXZ5iRM1o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W5BMGBZBZ5+2MfB4njekH5jFvs26EdmiXmhh8lkvy1QdaUD5CFfOHwv3cOrl7RXmGkc3gnvxSKSocPMHGXkzXDjkvwA1EsXzgLaZ9NCtaZHj3HzCEuXvSwVsqcjyYq0j+5XGOu+QISJyvO8yXw9iJT7j0VQVj/06/9GlGSqps6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gQvYCKzM; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gQvYCKzM"
Date: Wed, 1 Jul 2026 15:40:29 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782909639; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=aK3bC/Yk0HPeufinAbygJPny8WFgvPaMtUqpGTyHhJE=;
	b=gQvYCKzMuitnqCrr9yMf4pAiAN3VWLV15XONb6CIKdJdwmtC+o0aSHBQwI6IPX3U1t4DNP
	2Pg96KIEo1TWYH0rAdmfLWX3TEdb/sudtr11QYhDxP5QVCE7DBCyAuT3HgVH5RYhl0M9vd
	3x5uc7UAClug1VBWlUtWaNSlITOrV1k=
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
Subject: [PATCH 0/8] Support ROHM BD73800
Message-ID: <cover.1782909323.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3MnEKyKDxsefSFik"
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT


--3MnEKyKDxsefSFik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add support for the ROHM BD73800 PMIC and compatibles.

The ROHM BD73800 is a power management IC which integrates 8 BUCKs and 4
LDOs. There is also an ADC and operation amplifier intended for current
/ temperature measurement and accumulation. RTC and 32.768 kHz clock
gate are also included. The PMIC can be customized via OTP and it has
options for operating as a main PMIC in multi-PMIC installation. Some
of the pins can also be used for GPO or GPI (including interrupt support).

There are also ROHM BD71851 and BD71885 PMICs out there. These are, from
the SW-perspective, similar to the BD73800. There is only some different
default values and OTP settings. The driver should be able to handle them
just fine.

Oh, finally - there is absolutely no rush reviewing this. I am likely to
be (mostly) offline for (at least) 3 weeks. So please, take your time, I
probably will spin the next version only somewhere at August.

---

Matti Vaittinen (8):
  dt-bindings: regulator: ROHM BD73800 regulators
  dt-bindings: mfd: ROHM BD73800 PMIC
  mfd: Support for ROHM BD73800 PMIC core
  rtc: bd70528: Support RTC on ROHM BD73800
  regulator: bd71828: Support ROHM BD73800
  clk: bd718x7: Support ROHM BD73800
  gpio: bd73800: Support ROHM BD73800 PMIC GPIOs
  MAINTAINERS: Add ROHM BD73800 PMIC files

 .../bindings/mfd/rohm,bd73800-pmic.yaml       | 229 ++++++++
 .../regulator/rohm,bd73800-regulator.yaml     | 119 ++++
 MAINTAINERS                                   |   2 +
 drivers/clk/clk-bd718x7.c                     |   8 +
 drivers/gpio/Kconfig                          |  11 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-bd73800.c                   | 234 ++++++++
 drivers/mfd/Kconfig                           |  15 +-
 drivers/mfd/rohm-bd71828.c                    | 145 ++++-
 drivers/regulator/Kconfig                     |   4 +-
 drivers/regulator/bd71828-regulator.c         | 555 +++++++++++++++++-
 drivers/rtc/rtc-bd70528.c                     |   8 +
 include/linux/mfd/rohm-bd73800.h              | 307 ++++++++++
 include/linux/mfd/rohm-generic.h              |   1 +
 14 files changed, 1629 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic=
=2Eyaml
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd7380=
0-regulator.yaml
 create mode 100644 drivers/gpio/gpio-bd73800.c
 create mode 100644 include/linux/mfd/rohm-bd73800.h


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
--=20
2.54.0


--3MnEKyKDxsefSFik
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmpFCr0ACgkQeFA3/03a
ocW39Qf+JhmHKD3YmwcPiXyAzs4+zjXCf/hmvseRMrfUZMcPgd6wzSdfwW5tjREO
ZvjBKwewGLKu9DhRuOOx4SvTFW2nTIgALznjjX5CKWVfZf+Rh1SOAHL/A6knt/CP
4+aQrY6CG0wX/zrrFLcoGpU7pPeyhgyn+QZ+h3azfcW4+RQmYpAv/oYteFXs5bPX
YZD3k/t+2y9xFTbSEcurR7zSNqcCWn8/blvs6h9o25PI7XvctsvYJ8I/jxAw1Vd/
mrNMSPWEHuGf8Y0O0Hy/YhhRluR1zszWcFOxHKynorjn73os+O5EMBe3zmRUK/ti
sFS8Dn4YqrvMUyMhhPtbpdci+o/m6A==
=zQEM
-----END PGP SIGNATURE-----

--3MnEKyKDxsefSFik--
