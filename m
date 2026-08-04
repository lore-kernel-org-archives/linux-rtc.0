Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A98446823;
	Tue,  4 Aug 2026 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838803; cv=none; b=n9ra1sBX1ggloKiCohrcybELYiuemGba7in4MNk749J+IptbJZQrOELXrk74jIAOZS7W/mWR9YKPRYs+z+zH2UUpFD/rT6H8bFNJBc4M75Zpo/Idodu8yhyeqVrlnFXOE/JLwn/1eI5iPXOjaXIvTXjZNhXTAyIyY5H7KYNjQOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838803; c=relaxed/simple;
	bh=W0VsvBw4erS62StCAwFbLIw6VY59rs3FwUtxsXp2c1k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tIPUqY2V3UUlYrrrH7VRBb+8Pk5B/q9ZVfcRK/bcxB1cVTVasXTLvc+6vqQlUpj10mB4S3oUvLlbAlYZwmd3z2NrgAdpmAfKTXWVbjD6R0JUortdNHCmqqFiFreSYBmjIcQLfbL2sXdKmRQWFI1/c1yjQvxUOgag30T1kg8q/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MQajXf89; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MQajXf89"
Date: Tue, 4 Aug 2026 13:19:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785838799; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=59bV0VTFOGjwq0yxRhupbuwjdHtO+zfKFhfxls/eC1w=;
	b=MQajXf89w0T5db6AJd9zx//7rK725ZHKv5Ok+6Bjr62pPw7N17z3N5RCH0aPmCPXoJVyu+
	NlBiKSyGDQ3ZaGHIvY4YbkDVMDiqwZSq6qEyCkomAIabtYiXScS3prTWPVYTg3NpdPmNtD
	DMfwz52CyuLOzwJb9MUA2Ko0LJLzDy0=
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
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH v2 00/10] Support ROHM BD73800
Message-ID: <cover.1785838584.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VHhze1AYksE9JiYU"
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

--VHhze1AYksE9JiYU
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
 drivers/gpio/Kconfig                          |  11 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-bd73800.c                   | 227 +++++++
 drivers/mfd/Kconfig                           |  15 +-
 drivers/mfd/rohm-bd71828.c                    | 147 ++++-
 drivers/regulator/Kconfig                     |   4 +-
 drivers/regulator/bd71828-regulator.c         | 558 +++++++++++++++++-
 drivers/rtc/rtc-bd70528.c                     |   8 +
 include/linux/mfd/rohm-bd73800.h              | 307 ++++++++++
 include/linux/mfd/rohm-generic.h              |   1 +
 18 files changed, 1679 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic=
=2Eyaml
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,pmic-pins.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd7380=
0-regulator.yaml
 create mode 100644 drivers/gpio/gpio-bd73800.c
 create mode 100644 include/linux/mfd/rohm-bd73800.h


base-commit: 36c3ea84289913d16dd2ed783534193c957055b9
--=20
2.55.0


--VHhze1AYksE9JiYU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmpxvLYACgkQeFA3/03a
ocW5HQgAlH75SLN8BaghMw7rYf5U9E5OPedQFEdQAj2bvP6pi2a0oh763U9YtSRZ
QfAyxQwz7oEW7rvDT9sMY5A1DcNAo5rTCxeyFKJ1KeBiimdmB277fU2cpMzJ0Noh
zYrxA2ttWRKa4vGfhxraIK0Z4IAHiL0wSOkH6bvDagXjaUVflGVSShS9xGur5hhY
udrdU6DX1VAiphwBais1772pxrPuDYtx048OL1TZb9KmKyMX6XY5zEOi1LpvWfhL
cXGA50TcS3+PLDDGGZF2n0+AYxdc2sL8IEYDJZwo5eWsJ19MdysbX4xWDzCz+NHY
2G4KMK/9ZJxdjPekEoDWrzyH1P7AnQ==
=+2F/
-----END PGP SIGNATURE-----

--VHhze1AYksE9JiYU--
