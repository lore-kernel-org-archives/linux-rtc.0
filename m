Return-Path: <rtc-linux+bncBD2OLRXW4ABBBW5EUO2QKGQE6CFSO7Q@googlegroups.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com. [216.228.121.64])
        by gmr-mx.google.com with ESMTPS id jg4si741068pac.2.2016.01.27.06.21.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2016 06:21:15 -0800 (PST)
From: Laxman Dewangan <ldewangan@nvidia.com>
To: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linus.walleij@linaro.org>, <gnurou@gmail.com>, <lee.jones@linaro.org>,
	<broonie@kernel.org>, <a.zummo@towertech.it>,
	<alexandre.belloni@free-electrons.com>
CC: <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, <swarren@nvidia.com>, <treding@nvidia.com>,
	<k.kozlowski@samsung.com>, Laxman Dewangan <ldewangan@nvidia.com>
Subject: [rtc-linux] [PATCH V5 0/5] Add support for MAXIM MAX77620/MAX20024 PMIC
Date: Wed, 27 Jan 2016 19:40:03 +0530
Message-ID: <1453903808-29788-1-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Add SW support for MAXIM Semiconductor's Power Management
IC (PMIC) MAX77620/MAX20024. This PMIC supports DC-DC/LDOS, GPIOs,
RTC, watchdog, clocks etc.

This series add respective driver for each of sub-modules.

Changes from V1: 
DT DOC:
- Added units in some of properties.
- Change the boolean property to tristate type and detail some of
  properties.

RTC:
- Rename the file to rtc-max77xxx.c and make the generic implementation.
- Direct regmap apis are used for the register access.
- Decouped from max77620 driver.
- Taken care of cleanup comments form V1 version.

MFD:
- Code cleanups per review from V1. 
- Move register access APIs from header to c file.
- Remove some of non required variable, remove duplication in error message
 and simplify some of function implementation.

GPIO:
- Use the gpiochip_add_data and get the chip data from core APIs.
- Cleanups based on comment received on mfd/rtc.
- Avoid duplication on error message.

Pinctrl:
- Cleanup code based on comment received on mfd/rtc.
- Avoid duplication on error message.

Regulators:
- Cleanup code based on comment received on mfd/rtc.
- Avoid duplication on error message.
- Taken care of review comment from Mark.

Changes from V2: 
- Run coccicheck and checkpatch in strict mode for the alignment.
- Drop RTC driver and its i2c client registartion.
- Refactor Regulator  driver to use core API for DT parsing.

Changes from V3:
- Change all sys initcall to module driver.
- change the max77620_read argument to unisgned int from u8.


Changes from V4:
- Provide more details in the dt binding doc.
- Take care of fps nodes.
- Split the submodule's DT binding doc on respective folder.
- Drop the battery charger and low battery binding and related code as
  it need to go on power driver.

Laxman Dewangan (5):
  DT: mfd: add device-tree binding doc fro PMIC max77620/max20024
  mfd: max77620: add core driver for MAX77620/MAX20024
  pinctrl: max77620: add pincontrol driver for MAX77620/MAX20024
  gpio: max77620: add gpio driver for MAX77620/MAX20024
  regulator: max77620: add regulator driver for max77620/max20024

 .../devicetree/bindings/gpio/gpio-max77620.txt     |  25 +
 Documentation/devicetree/bindings/mfd/max77620.txt | 118 +++
 .../bindings/pinctrl/pinctrl-max77620.txt          |  87 +++
 .../bindings/regulator/regulator-max77620.txt      | 163 ++++
 drivers/gpio/Kconfig                               |   9 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-max77620.c                       | 292 +++++++
 drivers/mfd/Kconfig                                |  15 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/max77620.c                             | 727 ++++++++++++++++++
 drivers/pinctrl/Kconfig                            |  10 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-max77620.c                 | 693 +++++++++++++++++
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/max77620-regulator.c             | 844 +++++++++++++++++++++
 include/dt-bindings/mfd/max77620.h                 |  35 +
 include/linux/mfd/max77620.h                       | 406 ++++++++++
 18 files changed, 3437 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-max77620.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/max77620.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-max77620.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/regulator-max77620.txt
 create mode 100644 drivers/gpio/gpio-max77620.c
 create mode 100644 drivers/mfd/max77620.c
 create mode 100644 drivers/pinctrl/pinctrl-max77620.c
 create mode 100644 drivers/regulator/max77620-regulator.c
 create mode 100644 include/dt-bindings/mfd/max77620.h
 create mode 100644 include/linux/mfd/max77620.h

-- 
2.1.4

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
