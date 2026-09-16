Received: from mta0.migadu.com (out-4.mta0.migadu.com [91.218.175.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3AE3E1CFB
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 06:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538653; cv=none; b=jELhhVWXs7rapnfM/9UOVeMSLxdkSIkHPUle9hPfoIUjI9QPXnRjocSbs9NrybzuRi1hoiHXqF3viPvGnlYtU4xMpWwpEotQkrWknfhaed+N/ZuGI6NiZ7F40jqZtjvjK8aENkYePUyWhziYG0WJo/m5RYeDZaY1f6EjycDYa8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538653; c=relaxed/simple;
	bh=Wjxk7Nkbncmp1+ATMZ2lzO7C1dQkbRu3+K8tHlPDmXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GU3l8N2ZqNa0c5Gfd8j2KY37zG5+zdG8L7blU8xq2ZoEqG0l7Pnmjf5CZtS+QhYGRA8XKFsI5t1qradXi8kiTJHVde512L4iiTiD5xnaqlTSpJVLjsEhN+5EHQbanrQ9n0qSSIoc75EK3RsDn/S97pwrYz97Vyeqnc2G+hRv2Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hRLl4N7X; arc=none smtp.client-ip=91.218.175.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hRLl4N7X"
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Wjxk7Nkbncmp1+ATMZ2lzO7C1dQkbRu3+K8tHlPDmXk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789538649; v=1; x=1790143449;
 b=hRLl4N7XdRohK/q0vgsb62X/bioqxaKPMgI1uejN0dj+a51QKxh0v89ZjFyqWr2ykVm0NAAn
 DKr+5piBu6j3OxnN1Eeegvrl1y48Yg2SH/8SrSQB0MGbl7QFVl1sSULduofyUSiGgmrCswBLzIt
 xaLoIxPCJ2NC17BBn4oVzGyE=
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id b599e5e885e3c597;
	Wed, 16 Sep 2026 06:04:08 +0000
X-Mizu-Trace-ID: b599e5e885e3c597
X-Migadu-Flow: FLOW_OUT
Date: Wed, 16 Sep 2026 09:04:04 +0300
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
Subject: [PATCH v4 00/10] Support ROHM BD73800
Message-ID: <cover.1789538455.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XojVb7aV+M6rXB30"
Content-Disposition: inline

--XojVb7aV+M6rXB30
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

v3 =3D> v4:
 - Minor styling
 More accurate change-log in individual patches.

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
 include/linux/mfd/rohm-bd73800.h              | 306 ++++++++++
 include/linux/mfd/rohm-generic.h              |   1 +
 18 files changed, 1661 insertions(+), 46 deletions(-)
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


--XojVb7aV+M6rXB30
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqqMVQACgkQeFA3/03a
ocU6agf/erXoYpeXBfdNklLVkEaEgEF0ZxTUMKmzxvgR8WMZK1v8pTOKFx6Kyv0e
caZgMbTSHqxiYvVIEkLR4tc4Shm1ER9i/Pz6xGPjjrru7UrIZxpXJ+LfHFFvbR0t
N+Bw+MqwvNIXEMx8BuPYNnHj0UgFbXNA2hJmgXbS4RGGh3qCkr2Lumuj/4syAUUf
tm6mPxFbzMcFu5lPky9W3bTLWPKgM2ZeppMq5xI9jlEOwETeitUHS2Cc2rhCoXcF
y3K1Qdswxn+aWBP7bg+bWFCk3mMqakx3oKN8S5C49ssRA24OsXhAaMGsZ7OPniJe
S93wHr4rphPHzhT7Mw16tyirnAhZxg==
=qCdj
-----END PGP SIGNATURE-----

--XojVb7aV+M6rXB30--
