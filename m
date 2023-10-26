Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22437241FF;
	Thu, 26 Oct 2023 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8nC0qFQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BA9C433C8;
	Thu, 26 Oct 2023 16:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698337099;
	bh=8lycbEbgLCazid2wcr0C6ghdyhiiCB2WZw3WN6HpNDw=;
	h=From:List-Id:To:Cc:Subject:Date:From;
	b=V8nC0qFQ03RyDCJwbme3zNB671ZJWNm8hHPAkHsu9I5h2JqkpeoWbyTxe98mJ2Bmu
	 jWYkc5/09acNM4aADK35G5jkdxSXRlQYl2sUs+OYWjvUY3CDi5FErkXd7J/cMwQ6/r
	 b78QNO12RGTOrU16L4iazQjXE0fdyxRrLS4GI1o4TwfXt5Vzv/x1vrpT1xoopWm+LX
	 Y0ai3cKiGiPnLP5fVOiyrTmyoBXZ4+LoCpEt+KFr84hZU9VXGFZE0yDa7tJMN/Zi6S
	 0kr8sGlOg0QfSqCc82o/zSRo/WiaTi0d7r7rEZlKDP5udOH2i0ScTBKVx3HrohkC0O
	 mtIWXr3xsDGwg==
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
Subject: [PATCH v4 0/7] Turris Omnia MCU driver
Date: Thu, 26 Oct 2023 18:17:56 +0200
Message-ID: <20231026161803.16750-1-kabel@kernel.org>
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

I am sending v4 of the series adding Turris Omnia MCU driver.
See the cover letters for v1, v2 and v3:
  https://patchwork.kernel.org/project/linux-soc/cover/20230823161012.6986-1-kabel@kernel.org/
  https://patchwork.kernel.org/project/linux-soc/cover/20230919103815.16818-1-kabel@kernel.org/
  https://patchwork.kernel.org/project/linux-soc/cover/20231023143130.11602-1-kabel@kernel.org/

Changes since v3:
- addressed Andy's suggestions for patches 3/7 and 4/7

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
 .../platform/cznic/turris-omnia-mcu-gpio.c    | 1018 +++++++++++++++++
 .../cznic/turris-omnia-mcu-sys-off-wakeup.c   |  257 +++++
 .../cznic/turris-omnia-mcu-watchdog.c         |  122 ++
 drivers/platform/cznic/turris-omnia-mcu.h     |  170 +++
 include/linux/turris-omnia-mcu-interface.h    |  194 ++++
 14 files changed, 2271 insertions(+), 1 deletion(-)
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

