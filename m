Return-Path: <rtc-linux+bncBDMYB2E7SQCRBNO35WVAKGQEZRN5R3Q@googlegroups.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com (mail-bn1bbn0102.outbound.protection.outlook.com. [157.56.111.102])
        by gmr-mx.google.com with ESMTPS id ye6si1595942pbc.2.2015.05.19.10.07.00
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 May 2015 10:07:01 -0700 (PDT)
From: <Frank.Li@freescale.com>
To: <lznuaa@gmail.com>, <shawn.guo@linaro.org>, <dmitry.torokhov@gmail.com>,
	<robh+dt@kernel.org>, <a.zummo@towertech.it>, <p.zabel@pengutronix.de>,
	<alexandre.belloni@free-electrons.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-input@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Frank Li <Frank.Li@freescale.com>
Subject: [rtc-linux] [PATCH v2 0/7] Change snvs rtc and poweroff to use syscon
 add pwrkey driver
Date: Wed, 20 May 2015 01:04:35 +0800
Message-ID: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

From: Frank Li <Frank.Li@freescale.com>

Change from v1 to v2
 - Change simple-bus to simple-mfd
 - RTC remove lock.
 - RTC remove comments "These register offsets are relative to LP (Low Power) range"
 - power off, remove extra space

SNVS is MPF module.
include rtc, power off, ON/OFF power key

  arm: imx: power-off: change to syscon to access register
  rtc: arm: imx: snvs: change use syscon to access register
Above two patch change existed power-off and rtc use syscon

  Document: dt: fsl: snvs: change support syscon
  arm: dts: imx: update snvs to use syscon access register
Update dt file and document

  input: keyboard: imx: add snvs power key driver
  document: devicetree: input: imx: i.mx snvs power device tree bindings
  arm: dts: imx6sx: enable snvs power key
Added on/off key driver

Frank Li (6):
  arm: imx: power-off: change to syscon to access register
  rtc: arm: imx: snvs: change use syscon to access register
  Document: dt: fsl: snvs: change support syscon
  arm: dts: imx: update snvs to use syscon access register
  document: devicetree: input: imx: i.mx snvs power device tree bindings
  arm: dts: imx6sx: enable snvs power key

Robin Gong (1):
  input: keyboard: imx: add snvs power key driver

 .../devicetree/bindings/crypto/fsl-sec4.txt        |  93 +++++++--
 .../devicetree/bindings/input/snvs-pwrkey.txt      |   1 +
 .../bindings/power_supply/imx-snvs-poweroff.txt    |  24 +--
 arch/arm/boot/dts/imx6qdl.dtsi                     |  12 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |  12 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |  19 +-
 arch/arm/boot/dts/vfxxx.dtsi                       |   9 +-
 drivers/input/keyboard/Kconfig                     |  11 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/snvs_pwrkey.c               | 232 +++++++++++++++++++++
 drivers/power/reset/imx-snvs-poweroff.c            |  21 +-
 drivers/rtc/rtc-snvs.c                             | 128 +++++-------
 12 files changed, 417 insertions(+), 146 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/snvs-pwrkey.txt
 create mode 100644 drivers/input/keyboard/snvs_pwrkey.c

-- 
1.9.1

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
