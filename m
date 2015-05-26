Return-Path: <rtc-linux+bncBDMYB2E7SQCRBWV5SKVQKGQEA4EKAOA@googlegroups.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com (mail-bl2on0110.outbound.protection.outlook.com. [65.55.169.110])
        by gmr-mx.google.com with ESMTPS id lg9si1737915qcb.1.2015.05.26.09.27.05
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 May 2015 09:27:05 -0700 (PDT)
From: <Frank.Li@freescale.com>
To: <lznuaa@gmail.com>, <shawn.guo@linaro.org>, <dmitry.torokhov@gmail.com>,
	<robh+dt@kernel.org>, <alexandre.belloni@free-electrons.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-input@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>, Frank Li
	<Frank.Li@freescale.com>
Subject: [rtc-linux] [PATCH v5 0/6] Change snvs rtc and poweroff to use syscon
 add pwrkey driver
Date: Wed, 27 May 2015 00:25:56 +0800
Message-ID: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
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

Tested old and new dts in imx6sx platform.

Change from v5 to v6
 - use dev_warn and dev_err
 - use phandle regmap
 - update document and dts for phandle regmap
 - use data variable in rtc-snvs.c

Change from v3 to v4
 - fix align
 - change to pr_warn

Change from v2 to v3
 - Keep snvs rtc compatiblity with old dts file
 - use general syscon-poweroff instead of modifying snvs-poweroff.c

Change from v1 to v2
 - Change simple-bus to simple-mfd
 - RTC remove lock.
 - RTC remove comments "These register offsets are relative to LP (Low Power) range"
 - power off, remove extra space

Frank Li (5):
  rtc: arm: imx: snvs: change use syscon to access register
  Document: dt: fsl: snvs: change support syscon
  ARM: dts: imx: update snvs to use syscon access register
  Document: devicetree: input: imx: i.mx snvs power device tree bindings
  ARM: dts: imx6sx: enable snvs power key

Robin Gong (1):
  input: keyboard: imx: add snvs power key driver

 .../devicetree/bindings/crypto/fsl-sec4.txt        |  91 +++++++--
 .../devicetree/bindings/input/snvs-pwrkey.txt      |   1 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |  21 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |  21 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |  28 ++-
 arch/arm/boot/dts/vfxxx.dtsi                       |  11 +-
 drivers/input/keyboard/Kconfig                     |  11 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/snvs_pwrkey.c               | 227 +++++++++++++++++++++
 drivers/rtc/rtc-snvs.c                             | 132 ++++++------
 10 files changed, 431 insertions(+), 113 deletions(-)
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
