Return-Path: <rtc-linux+bncBD2OLRXW4ABBBRXT6G2QKGQE22RBAUQ@googlegroups.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com. [216.228.121.64])
        by gmr-mx.google.com with ESMTPS id ff2si857368pad.2.2016.02.11.04.08.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Feb 2016 04:08:37 -0800 (PST)
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
Subject: [rtc-linux] [PATCH V8 1/8] mfd: add device-tree binding doc for PMIC max77620/max20024
Date: Thu, 11 Feb 2016 17:26:27 +0530
Message-ID: <1455191794-6065-2-git-send-email-ldewangan@nvidia.com>
In-Reply-To: <1455191794-6065-1-git-send-email-ldewangan@nvidia.com>
References: <1455191794-6065-1-git-send-email-ldewangan@nvidia.com>
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

Change from V5:
- None

Change from V6:
-start the patch title with mfd instead of DT: mfd:

Change from V7:
- Better describe the FPS to make more clear.

 Documentation/devicetree/bindings/mfd/max77620.txt | 143 +++++++++++++++++++++
 include/dt-bindings/mfd/max77620.h                 |  39 ++++++
 2 files changed, 182 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max77620.txt
 create mode 100644 include/dt-bindings/mfd/max77620.h

diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documentation/devicetree/bindings/mfd/max77620.txt
new file mode 100644
index 0000000..2ad44f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/max77620.txt
@@ -0,0 +1,143 @@
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
+- interrupts:		The interrupt on the parent the controller is
+			connected to.
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
+The Flexible Power Sequencer (FPS) allows each regulator to power up under
+hardware or software control. Additionally, each regulator can power on
+independently or among a group of other regulators with an adjustable power-up
+and power-down delays (sequencing). GPIO1, GPIO2, and GPIO3 can be programmed
+to be part of a sequence allowing external regulators to be sequenced along
+with internal regulators. 32KHz clock can be programmed to be part of a
+sequence.
+
+The flexible sequencing structure consists of two hardware enable inputs
+(EN0, EN1), and 3 master sequencing timers called FPS0, FPS1 and FPS2.
+Each master sequencing timer is programmable through its configuration
+register to have a hardware enable source (EN1 or EN2) or a software enable
+source (SW). When enabled/disabled, the master sequencing timer generates
+eight sequencing events on different time periods called slots. The time
+period between each event is programmable within the configuration register.
+Each regulator, GPIO1, GPIO2, GPIO3, and 32KHz clock has a flexible power
+sequence slave register which allows its enable source to be specified as
+a flexible power sequencer timer or a software bit. When a FPS source of
+regulators, GPIOs and clocks specifies the enable source to be a flexible
+power sequencer, the power up and power down delays can be specified in
+the regulators, GPIOs and clocks flexible power sequencer configuration
+registers.
+
+When FPS event cleared (set to LOW), regulators, GPIOs and 32KHz
+clock are set into following state at the sequencing event that
+corresponds to its flexible sequencer configuration register.
+	Sleep state: 			In this state, regulators, GPIOs
+					and 32KHz clock get disabled at
+					the sequencing event.
+	Global Low Power Mode (GLPM):	In this state, regulators are set in
+					low power mode at the sequencing event.
+
+The configuration parameters of FPS is provided through sub-node "fps"
+and their child for FPS specific. The child node name for FPS are "fps0",
+"fps1", and "fps2" for FPS0, FPS1 and FPS2 respectively.
+
+The FPS configurations like FPS source, power up and power down slots for
+regulators, GPIOs and 32kHz clocks are provided in their respective
+configuration nodes which is explained in respective sub-system DT
+binding document.
+
+There is need for different FPS configuration parameters based on system
+state like when system state changed from active to suspend or active to
+power off (shutdown).
+
+Optional properties:
+-------------------
+-maxim,fps-event-source:		u32, FPS event source like external
+					hardware input to PMIC i.e. EN0, EN1 or
+					software (SW).
+					The macros are defined on
+						dt-bindings/mfd/max77620.h
+					for different control source.
+					- MAX77620_FPS_EVENT_SRC_EN0
+						for hardware input pin EN0.
+					- MAX77620_FPS_EVENT_SRC_EN1
+						for hardware input pin EN1.
+					- MAX77620_FPS_EVENT_SRC_SW
+						for software control.
+
+-maxim,shutdown-fps-time-period-us:	u32, FPS time period in microseconds
+					when system enters in to shutdown
+					state.
+
+-maxim,suspend-fps-time-period-us:	u32, FPS time period in microseconds
+					when system enters in to suspend state.
+
+-maxim,device-state-on-disabled-event:	u32, describe the PMIC state when FPS
+					event cleared (set to LOW) whether it
+					should go to sleep state or low-power
+					state. Following are valid values:
+					- MAX77620_FPS_INACTIVE_STATE_SLEEP
+						to set the PMIC state to sleep.
+					- MAX77620_FPS_INACTIVE_STATE_LOW_POWER
+						to set the PMIC state to low
+						power.
+					Absence of this property or other value
+					will not change device state when FPS
+					event get cleared.
+
+Here supported time periods by device in microseconds are as follows:
+MAX77620 supports 40, 80, 160, 320, 640, 1280, 2560 and 5120 microseconds.
+MAX20024 supports 20, 40, 80, 160, 320, 640, 1280 and 2540 microseconds.
+
+For DT binding details of different sub modules like GPIO, pincontrol,
+regulator, power, please refer respective device-tree binding document
+under their respective sub-system directories.
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
+			maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN1>;
+		};
+
+		fps1 {
+			maxim,shutdown-fps-time-period-us = <1280>;
+			maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN0>;
+		};
+
+		fps2 {
+			maxim,shutdown-fps-time-period-us = <1280>;
+			maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_SW>;
+		};
+	};
+};
diff --git a/include/dt-bindings/mfd/max77620.h b/include/dt-bindings/mfd/max77620.h
new file mode 100644
index 0000000..b911a07
--- /dev/null
+++ b/include/dt-bindings/mfd/max77620.h
@@ -0,0 +1,39 @@
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
+/* FPS event source */
+#define MAX77620_FPS_EVENT_SRC_EN0		0
+#define MAX77620_FPS_EVENT_SRC_EN1		1
+#define MAX77620_FPS_EVENT_SRC_SW		2
+
+/* Device state when FPS event LOW  */
+#define MAX77620_FPS_INACTIVE_STATE_SLEEP	0
+#define MAX77620_FPS_INACTIVE_STATE_LOW_POWER	1
+
+/* FPS source */
+#define MAX77620_FPS_SRC_0			0
+#define MAX77620_FPS_SRC_1			1
+#define MAX77620_FPS_SRC_2			2
+#define MAX77620_FPS_SRC_NONE			3
+#define MAX77620_FPS_SRC_DEF			4
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
