Received: from mta0.migadu.com (out-247.mta0.migadu.com [91.218.175.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821EC43F096
	for <linux-rtc@vger.kernel.org>; Wed,  2 Sep 2026 11:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347015; cv=none; b=eOmC7U9j8k61dwVbhP9ynjonr693GUROZ4gRbUiCJ6Qbl+fPIW1lLEjmcCPmpa009tj3YAzLXZn7GBl3hjHKhKxJW8/+Fa6lQOC0/0cyYRLbfA+QFMhO/Z5fqx6vzkooh33OPBD0m4EeXcuRs7D+957vMteAFeerYaV82sbQMQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347015; c=relaxed/simple;
	bh=20snKJaG8UMW/EixhLl7Mhl2veH34E3KT+pk8OWVknU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XegYZtDe48Fuq9eDkbiZ4Kkd6z2L59VvoZjN0kgj47fWCWQQhV6f5AGgGJgP/+Ck7V6fdC/bMiPkNYouE0gTrKpimDRKHvagY8QnU6O9N66aa61hfMr6pnY2NnLsjGzasle2mPVm6KUqlklHSyONe+J1X2dIbrgEJZuqchhU754=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UqBysMNJ; arc=none smtp.client-ip=91.218.175.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UqBysMNJ"
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=20snKJaG8UMW/EixhLl7Mhl2veH34E3KT+pk8OWVknU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788347011; v=1; x=1788951811;
 b=UqBysMNJ7nJEOt3ZuhFhQkOwyIXBsK6i2miRq0YnguHuTE5KrLpWWqktfUkwcBK8QcTBwQEH
 9j79XAkSeslqGTe9MCut3qyed6/tUZut3ZgxbOy6RbNikOmfcPFruR9Lp0NAZ20RB+CgeyUOlmW
 boAZrjPCV21R7p8SFGhVHj3U=
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id f4c9c9e68c3ee15e;
	Wed, 02 Sep 2026 11:03:21 +0000
X-Mizu-Trace-ID: f4c9c9e68c3ee15e
X-Migadu-Flow: FLOW_OUT
Date: Wed, 2 Sep 2026 14:03:12 +0300
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
Subject: [PATCH v3 00/10] Support ROHM BD73800
Message-ID: <cover.1788346553.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="97DSgaQ3eGUvz8QX"
Content-Disposition: inline

--97DSgaQ3eGUvz8QX
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

Revision history:

v2 =3D> v3:
 - Rebased on v7.3-rc1.
 - gpio: Use gpio-regmap as was suggested by Linus W.
 More accurate change-log in individual patches.

v1 =3D> v2:
 - Rebased on regulator/for-7.3 as it carries dependency:
   f29a8bf6fde1 ("regulator: dt-bindings: ROHM PMIC state-machine voltages")
 - dt-bindings: Various fixes, split generic stuff to own files.
 - gpio: Styling, return -ENODEV if no GPIOs found
 - MFD: Styling
 - regulator: Simplify dt-reading
 More accurate change-log in individual patches.

---

Matti Vaittinen (10):
  dt-bindings: mfd: common ROHM PMIC properties
  dt-bindings: rohm,bd*: Ref common ROHM bindings
  dt-bindings: regulator: ROHM BD73800 regulators
  dt-bindings: mfd: ROHM BD73800 PMIC
  mfd: Support for ROHM BD73800 PMIC core
  rtc: bd70528: Support RTC on ROHM BD73800
  regulator: bd71828: Support ROHM BD73800
  clk: bd718x7: Support ROHM BD73800
  gpio: bd73800: Support ROHM BD73800 PMIC GPIOs
  MAINTAINERS: Add ROHM BD73800 PMIC files

 .../bindings/mfd/rohm,bd71815-pmic.yaml       |   9 +-
 .../bindings/mfd/rohm,bd71828-pmic.yaml       |   9 +-
 .../bindings/mfd/rohm,bd72720-pmic.yaml       |  29 +-
 .../bindings/mfd/rohm,bd73800-pmic.yaml       | 218 +++++++
 .../bindings/mfd/rohm,pmic-pins.yaml          |  72 +++
 .../regulator/rohm,bd73800-regulator.yaml     |  99 ++++
 MAINTAINERS                                   |   2 +
 drivers/clk/clk-bd718x7.c                     |   8 +
 drivers/gpio/Kconfig                          |  12 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-bd73800.c                   | 209 +++++++
 drivers/mfd/Kconfig                           |  15 +-
 drivers/mfd/rohm-bd71828.c                    | 147 ++++-
 drivers/regulator/Kconfig                     |   4 +-
 drivers/regulator/bd71828-regulator.c         | 558 +++++++++++++++++-
 drivers/rtc/rtc-bd70528.c                     |   8 +
 include/linux/mfd/rohm-bd73800.h              | 307 ++++++++++
 include/linux/mfd/rohm-generic.h              |   1 +
 18 files changed, 1662 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic=
=2Eyaml
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,pmic-pins.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd7380=
0-regulator.yaml
 create mode 100644 drivers/gpio/gpio-bd73800.c
 create mode 100644 include/linux/mfd/rohm-bd73800.h


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
--=20
2.55.0


--97DSgaQ3eGUvz8QX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqYAnAACgkQeFA3/03a
ocWq2wgAgL3fXf8KMA2V440duRc7DIi1NzHj2Skga7Hw3Q1+bMip9KQvtNuI0aoP
C1iFsO894P5zcCLgqXAeXbfFEP1XsXF3xdQE0K6H3ifM/BQAnwbxHMm2Pf/1FdHb
37SfRjZ1diBkrixn3UYqxljXnB3tJ2Wb7jQ9WeXAdkUr2Ejjf1UBM7MgvNWqjGG4
VxSASt9NLtxaAxj+DA7MGSSVvpCwepS93NeNW19JJ7aLmSLC69sq0Yndde8gR9r1
tZ2qC+QhSN0VSJnoCSR83n1UsVTNjM2hm2r9YuQnE9GA9Z2UXFeWbSHyEgoPuWWw
SbDmfT4YcFgxRspLULmE72TJ5qAXiA==
=txE5
-----END PGP SIGNATURE-----

--97DSgaQ3eGUvz8QX--
