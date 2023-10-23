Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE31BDD0;
	Mon, 23 Oct 2023 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrDIxiY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2109C433C8;
	Mon, 23 Oct 2023 14:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698071497;
	bh=op1TQ1CkzwHxq8Z5ucFb/6/AuiA6zhcq2OVkycKqPXI=;
	h=From:List-Id:To:Cc:Subject:Date:From;
	b=HrDIxiY341J98QsROmXCAI+0dBFa4WOo5Yd0NYEYrhGGZ8lZ68djaVOrDTjpNgXK4
	 VJeFgNuedXOpLk+VFETT2MnYZ4qWA29MsxJ2dlR9ge7mhYQxD5unm9tioP3l30JReR
	 1Msd8FtOK//yvTtfWkqbv1EwJVlsvHC2ybxppZJrRqrfECuYF7WrTJZtpOyPKJ7Y9y
	 7RCFOBge0Aau1E/G59aD7u76ctd4wgEAukfsB0vn6dNHXkbryYVhlOblvBvB+i9/Iy
	 obNbZZv16FsnU0dZo3Q5rG06iloukt96vhnh6HUke7PJuj2lZrn1SUKFnGrZd8v5wR
	 YkGuVGZg4Q7HA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
List-Id: <soc.lore.kernel.org>
To: Gregory CLEMENT <gregory.clement@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	soc@kernel.org,
	arm@kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	devicetree@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v3 0/7] Turris Omnia MCU driver
Date: Mon, 23 Oct 2023 16:31:23 +0200
Message-ID: <20231023143130.11602-1-kabel@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Andy, Linus, Arnd, Gregory, and others,

this is v3 of series adding support for Turris Omnia MCU. See the cover
letter from v1 and v2:
  https://patchwork.kernel.org/project/linux-soc/cover/20230823161012.6986-1-kabel@kernel.org/
  https://patchwork.kernel.org/project/linux-soc/cover/20230919103815.16818-1-kabel@kernel.org/

Changes since v2:
- I've dropped the usage of devm_device_add_group(), since it is
  deprecated as noted by Andy. In patch 4 I use the .is_visible()
  attribute group method instead
- dropped the setting of min_hw_heartbeat_ms watchdog member in 5/7,
  since it is not needed, as suggested by Guenter
- addressed Linus' and Andy's suggestions in patches 2/7 and 3/7.
  There is one of Andy's suggestions which I did not address completely,
  see changelog directly in patch 3/7

Marek Behún (7):
  dt-bindings: arm: add cznic,turris-omnia-mcu binding
  platform: cznic: Add preliminary support for Turris Omnia MCU
  platform: cznic: turris-omnia-mcu: Add support for MCU connected GPIOs
  platform: cznic: turris-omnia-mcu: Add support for poweroff and wakeup
  platform: cznic: turris-omnia-mcu: Add support for MCU watchdog
  ARM: dts: turris-omnia: Add MCU system-controller node
  ARM: dts: turris-omnia: Add GPIO key node for front button

 .../sysfs-bus-i2c-devices-turris-omnia-mcu    |   77 ++
 .../bindings/arm/cznic,turris-omnia-mcu.yaml  |   67 ++
 MAINTAINERS                                   |    4 +
 .../dts/marvell/armada-385-turris-omnia.dts   |   35 +-
 drivers/platform/Kconfig                      |    2 +
 drivers/platform/Makefile                     |    1 +
 drivers/platform/cznic/Kconfig                |   47 +
 drivers/platform/cznic/Makefile               |    7 +
 .../platform/cznic/turris-omnia-mcu-base.c    |  271 +++++
 .../platform/cznic/turris-omnia-mcu-gpio.c    | 1021 +++++++++++++++++
 .../cznic/turris-omnia-mcu-sys-off-wakeup.c   |  250 ++++
 .../cznic/turris-omnia-mcu-watchdog.c         |  122 ++
 drivers/platform/cznic/turris-omnia-mcu.h     |  168 +++
 include/linux/turris-omnia-mcu-interface.h    |  194 ++++
 14 files changed, 2265 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-turris-omnia-mcu
 create mode 100644 Documentation/devicetree/bindings/arm/cznic,turris-omnia-mcu.yaml
 create mode 100644 drivers/platform/cznic/Kconfig
 create mode 100644 drivers/platform/cznic/Makefile
 create mode 100644 drivers/platform/cznic/turris-omnia-mcu-base.c
 create mode 100644 drivers/platform/cznic/turris-omnia-mcu-gpio.c
 create mode 100644 drivers/platform/cznic/turris-omnia-mcu-sys-off-wakeup.c
 create mode 100644 drivers/platform/cznic/turris-omnia-mcu-watchdog.c
 create mode 100644 drivers/platform/cznic/turris-omnia-mcu.h
 create mode 100644 include/linux/turris-omnia-mcu-interface.h

-- 
2.41.0

