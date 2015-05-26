Return-Path: <rtc-linux+bncBDMYB2E7SQCRB3V5SKVQKGQEHBLINZA@googlegroups.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com (mail-bl2on0132.outbound.protection.outlook.com. [65.55.169.132])
        by gmr-mx.google.com with ESMTPS id jk4si1727120qcb.3.2015.05.26.09.27.25
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 May 2015 09:27:25 -0700 (PDT)
From: <Frank.Li@freescale.com>
To: <lznuaa@gmail.com>, <shawn.guo@linaro.org>, <dmitry.torokhov@gmail.com>,
	<robh+dt@kernel.org>, <alexandre.belloni@free-electrons.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-input@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>, Frank Li
	<Frank.Li@freescale.com>
Subject: [rtc-linux] [PATCH v5 6/6] ARM: dts: imx6sx: enable snvs power key
Date: Wed, 27 May 2015 00:26:02 +0800
Message-ID: <1432657562-5592-7-git-send-email-Frank.Li@freescale.com>
In-Reply-To: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
References: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
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

enable snvs ONOFF power key support

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index f8f0819..e391d63 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/clock/imx6sx-clock.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "imx6sx-pinfunc.h"
 #include "skeleton.dtsi"
@@ -679,6 +680,14 @@
 					mask = <0x60>;
 					status = "disabled";
 				};
+
+				snvs_pwrkey: snvs-powerkey {
+					compatible = "fsl,sec-v4.0-pwrkey";
+					regmap = <&snvs>;
+					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+					linux,keycode = <KEY_POWER>;
+					wakeup;
+				};
 			};
 
 			epit1: epit@020d0000 {
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
