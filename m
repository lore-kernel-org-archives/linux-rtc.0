Return-Path: <rtc-linux+bncBD2OLRXW4ABBBYVEUO2QKGQEYZDK5ZQ@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id tn7si801212pac.1.2016.01.27.06.21.22
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2016 06:21:22 -0800 (PST)
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
Subject: [rtc-linux] [PATCH V5 1/5] DT: mfd: add device-tree binding doc fro
 PMIC max77620/max20024
Date: Wed, 27 Jan 2016 19:40:04 +0530
Message-ID: <1453903808-29788-2-git-send-email-ldewangan@nvidia.com>
In-Reply-To: <1453903808-29788-1-git-send-email-ldewangan@nvidia.com>
References: <1453903808-29788-1-git-send-email-ldewangan@nvidia.com>
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

The MAXIM PMIC MAX77620 and MAX20024 are power management IC
which supports RTC, GPIO, DCDC/LDO regulators, interrupt,
watchdog etc.

Add DT binding document for the different functionality of
this device.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes from V1: 
- Added units in some of properties.
- Change the boolean property to tristate type and detail some of
  properties.

Change from V2:
- added unit in period related dt property.

Change from V3: None
- Added Rob's ack.

Changes from V4:
- A- Provide more details in the dt binding doc.
- Take care of fps nodes.
- Split the submodule's DT binding doc on respective folder.
- Drop the battery charger and low battery binding and related code as
  it need to go on power driver.


 Documentation/devicetree/bindings/mfd/max77620.txt | 118 +++++++++++++++++++++
 include/dt-bindings/mfd/max77620.h                 |  35 ++++++
 2 files changed, 153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max77620.txt
 create mode 100644 include/dt-bindings/mfd/max77620.h

diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documentation/devicetree/bindings/mfd/max77620.txt
new file mode 100644
index 0000000..f258ce4
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/max77620.txt
@@ -0,0 +1,118 @@
+MAX77620 Power management IC from Maxim Semiconductor.
+
+Required properties:
+-------------------
+- compatible: Must be one of
+		"maxim,max77620"
+		"maxim,max20024".
+- reg: I2C device address.
+
+Optional properties:
+-------------------
+- interrupts:		the interrupt on the parent the controller is
+			connected to
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells:	is <2> and their usage is compliant to the 2 cells
+			variant of <../interrupt-controller/interrupts.txt>
+			IRQ numbers for different interrupt source of MAX77620
+			are defined at dt-bindings/mfd/max77620.h.
+
+Optional subnodes and their properties:
+=======================================
+
+Flexible power sequence configurations:
+--------------------------------------
+The PMIC has multiple control mode:
+	Normal mode also called as active mode on which all step-down
+		regulators, all linear regulators, GPIOs, and the 32kHz
+		oscillator are in normal active mode.
+	sleep mode: Regulators/GPIOs/clock can go on OFF state based on
+		their configurations.
+	Global Low power mode (GLPM): In this mode, step-down regulators, linear
+		regulators, and the 32kHz oscillator are in low-power modes.
+
+	Different modes of regulators/clock/GPIOs are controlled by the their
+FPS configurations. There is different configuration registers for each of
+these resources. Typical configurations per resource are:
+	FPS source: 	Attach the resource to required FPS source. When
+			resources are attached to one of FPS source then
+			resournce can be enable/disable when related FPS
+			source gets the control signal for ON and OFF.
+	Power on slot: 	Slot number on which resource is ON once FPS source
+			get ON signal.
+	Power down slot Slot number on which resource is OFF once FPS source
+			get OFF signal.
+
+There is three FPS source for resources called FPS0, FPS1 and FPS2. All
+resources need to attached to one of these FPS. It can alsoi be set
+FPS source to NONE, and on this case, it is completely controlled by
+the register control rather than external input control to PMIC.
+
+The configuration parameters of FPS is provided through subnode "fps"
+and their child for FPS specific.
+The node name for FPS child are defined as "fps0", "fps1", and "fps2" for
+the FPS0, FPS1 and FPS2 respectively.
+
+There is need for different FPS configuration parameters based on system
+state like when system state changed from active to suspend or active to
+power off (shutdown).
+
+Optinal properties:
+-------------------
+-maxim,fps-control:	u32, FPS control source like external control input
+			to PMIC i.e. EN0, EN1 or software (SW). The macros
+			are defined on dt-bindings/mfd/max77620.h for
+			different control source.
+				FPS_CONTROL_SRC_EN0 for PMIC external input EN0.
+				FPS_CONTROL_SRC_EN1 for PMIC external input EN1.
+				FPS_CONTROL_SRC_SW for software control.
+
+-maxim,shutdown-fps-time-period-us: u32, FPS time period in microseconds
+				    when system enters to shutdown state.
+-maxim,suspend-fps-time-period-us:  u32, FPS time period in microseconds
+				    when system enters to suspend state.
+
+-maxim,enable-sleep: 		    Boolean, enable sleep state of PMIC
+				    when the FPS control input become active.
+-maxim,enable-global-lpm: 	    Boolean, enable Global Low Power Mode (GLPM)
+				    of PMIC when the FPS control input become
+				    active.
+
+Here supported time periods by device in microseconds are as follows:
+MAX77620 supports 40, 80, 160, 320, 640, 1280, 2560 and 5120 microseconds.
+MAX20024 supports 20, 40, 80, 160, 320, 640, 1280 and 2540 microseconds.
+
+For different sub modules like GPIO, pincontrol, regulator, power, please refer
+respected device-tree binding document on respective directories.
+
+Example:
+--------
+#include <dt-bindings/mfd/max77620.h>
+
+max77620@3c {
+	compatible = "maxim,max77620";
+	reg = <0x3c>;
+
+	interrupt-parent = <&intc>;
+	interrupts = <0 86 IRQ_TYPE_NONE>;
+
+	interrupt-controller;
+	#interrupt-cells = <2>;
+
+	fps {
+		fps0 {
+			maxim,shutdown-fps-time-period-us = <1280>;
+			maxim,fps-control = <FPS_CONTROL_SRC_EN1>;
+		};
+
+		fps1 {
+			maxim,shutdown-fps-time-period-us = <1280>;
+			maxim,fps-control = <FPS_CONTROL_SRC_EN0>;
+		};
+
+		fps2 {
+			maxim,shutdown-fps-time-period-us = <1280>;
+			maxim,fps-control = <FPS_CONTROL_SRC_SW>;
+		};
+	};
+};
diff --git a/include/dt-bindings/mfd/max77620.h b/include/dt-bindings/mfd/max77620.h
new file mode 100644
index 0000000..1b571d7
--- /dev/null
+++ b/include/dt-bindings/mfd/max77620.h
@@ -0,0 +1,35 @@
+/*
+ * This header provides macros for MAXIM MAX77620 device bindings.
+ *
+ * Copyright (c) 2016, NVIDIA Corporation.
+ * Author: Laxman Dewangan <ldewangan@nvidia.com>
+ */
+
+#ifndef _DT_BINDINGS_MFD_MAX77620_H
+#define _DT_BINDINGS_MFD_MAX77620_H
+
+/* MAX77620 interrupts */
+#define MAX77620_IRQ_TOP_GLBL		0 /* Low-Battery */
+#define MAX77620_IRQ_TOP_SD		1 /* SD power fail */
+#define MAX77620_IRQ_TOP_LDO		2 /* LDO power fail */
+#define MAX77620_IRQ_TOP_GPIO		3 /* GPIO internal int to MAX77620 */
+#define MAX77620_IRQ_TOP_RTC		4 /* RTC */
+#define MAX77620_IRQ_TOP_32K		5 /* 32kHz oscillator */
+#define MAX77620_IRQ_TOP_ONOFF		6 /* ON/OFF oscillator */
+#define MAX77620_IRQ_LBT_MBATLOW	7 /* Thermal alarm status, > 120C */
+#define MAX77620_IRQ_LBT_TJALRM1	8 /* Thermal alarm status, > 120C */
+#define MAX77620_IRQ_LBT_TJALRM2	9 /* Thermal alarm status, > 140C */
+
+/* FPS control inputs */
+#define FPS_CONTROL_SRC_EN0		0
+#define FPS_CONTROL_SRC_EN1		1
+#define FPS_CONTROL_SRC_SW		2
+
+/* FPS source */
+#define FPS_SRC_0			0
+#define FPS_SRC_1			1
+#define FPS_SRC_2			2
+#define FPS_SRC_NONE			3
+#define FPS_SRC_DEF			4
+
+#endif
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
