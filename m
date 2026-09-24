Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAE0459AC7;
	Thu, 24 Sep 2026 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254846; cv=none; b=acMJwNgEK6h8vtE78D2N0UsDx7fkbSI51WQNyIhybFGYI9tn8etsCAQ3OSoPduZUriFcFF8v2JmZ717Ux8Ie6NlIfEWzQ+eqUFGBTsVOqNp+fYSnSrcFAKtVJgAumnEu5OrIZZff0b9zCgebeuu4gsFGxbhgQhojqWOjukr4gAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254846; c=relaxed/simple;
	bh=lQ9iv3yD0ptTA54gnXaolzRlm7/dGGbiYR5tFbAgAcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnw6+ERmTJ7L4551Tvw2pkizxFnSjB8JJNplAFoSraBb4vtcMymsjkkb7AwwIOLVAHJFuKXl/KY2jr4wcxDhMV2iowr+UPdwSUA5pcfsuDzX0C162P37/L1+tUq3H0nCXXm4NxiLFG5AC1cgBz61txKTxsPaMVa9OvMqzIgi8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZENFdU2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZENFdU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35BA1F000FF;
	Thu, 24 Sep 2026 13:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790254845;
	bh=wgAsGxjOI4SZCAEuxYRxPYQum9DEyKkKsyTbJWwoLNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eZENFdU2E/XV9I//8XRof0Mq2OyiVVh/IlQYRFrXsBhkHGKKPhe5wUEUVv6HNtiIm
	 mWvLeogoTBMmpwV8w2W9zVk9Ty52RU1vRPH0eegRfZBbAD7HKKfLf4jL8+ps8Un8BG
	 C4YS3wdM+pettGiXmC1s6w8gu7RlIvZJBIoLtmzRiD0lJvWZ5hMtmrkWLfx4iVcgPL
	 tN0QOtsa/0JK1E7lPPn/hdF/6o7hodvclldHr8c6jLr4hicJ5SAIVUHkAsTPkf4hLX
	 2wQTlHmzlzQlUTxSidJ1F2/4AvRwUa0iutemQnEWGljyDfSbgZfQqoHwn66fS1rBsk
	 ziOjnLv15akpQ==
Date: Thu, 24 Sep 2026 14:00:38 +0100
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
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
Subject: [GIT PULL] Immutable branch between MFD, Clk, GPIO, Regulator and
 RTC due for the v7.4 merge window
Message-ID: <20260924130038.GB453446@google.com>
References: <cover.1789538455.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789538455.git.mazziesaccount@gmail.com>

Enjoy!

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-clk-gpio-regulator-rtc-v7.4

for you to fetch changes up to e8e8d60fe8cc35340f6110ff70ef7959de1c3c0b:

  MAINTAINERS: Add ROHM BD73800 PMIC files (2026-09-23 11:32:19 +0100)

----------------------------------------------------------------
Immutable branch between MFD, Clk, GPIO, Regulator and RTC due for the v7.4 merge window

----------------------------------------------------------------
Matti Vaittinen (10):
      dt-bindings: mfd: Common ROHM PMIC properties
      dt-bindings: rohm,bd*: Ref common ROHM bindings
      dt-bindings: regulator: ROHM BD73800 regulators
      dt-bindings: mfd: ROHM BD73800 PMIC
      mfd: Support for ROHM BD73800 PMIC core
      rtc: bd70528: Support RTC on ROHM BD73800
      regulator: bd71828: Support ROHM BD73800
      clk: bd718x7: Support ROHM BD73800
      gpio: bd73800: Support ROHM BD73800 PMIC GPIOs
      MAINTAINERS: Add ROHM BD73800 PMIC files

 .../devicetree/bindings/mfd/rohm,bd71815-pmic.yaml |   9 +-
 .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml |   9 +-
 .../devicetree/bindings/mfd/rohm,bd72720-pmic.yaml |  29 +-
 .../devicetree/bindings/mfd/rohm,bd73800-pmic.yaml | 218 ++++++++
 .../devicetree/bindings/mfd/rohm,pmic-pins.yaml    |  72 +++
 .../bindings/regulator/rohm,bd73800-regulator.yaml |  99 ++++
 MAINTAINERS                                        |   2 +
 drivers/clk/clk-bd718x7.c                          |   8 +
 drivers/gpio/Kconfig                               |  12 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-bd73800.c                        | 209 ++++++++
 drivers/mfd/Kconfig                                |  15 +-
 drivers/mfd/rohm-bd71828.c                         | 147 +++++-
 drivers/regulator/Kconfig                          |   4 +-
 drivers/regulator/bd71828-regulator.c              | 558 ++++++++++++++++++++-
 drivers/rtc/rtc-bd70528.c                          |   8 +
 include/linux/mfd/rohm-bd73800.h                   | 306 +++++++++++
 include/linux/mfd/rohm-generic.h                   |   1 +
 18 files changed, 1661 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,pmic-pins.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd73800-regulator.yaml
 create mode 100644 drivers/gpio/gpio-bd73800.c
 create mode 100644 include/linux/mfd/rohm-bd73800.h

-- 
Lee Jones
