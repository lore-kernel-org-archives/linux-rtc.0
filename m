Return-Path: <rtc-linux+bncBD2OLRXW4ABBBU7T6G2QKGQEAHJIBDA@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id ui7si1080810pab.0.2016.02.11.04.08.50
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Feb 2016 04:08:50 -0800 (PST)
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
Subject: [rtc-linux] [PATCH V8 3/8] pinctrl: add DT binding doc for pincontrol
 of PMIC max77620/max20024
Date: Thu, 11 Feb 2016 17:26:29 +0530
Message-ID: <1455191794-6065-4-git-send-email-ldewangan@nvidia.com>
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

Maxim Semiconductor's PMIC MAX77620/MAX20024 has 8 GPIO pins
which act as GPIO as well as special function mode.

Add DT binding document to configure pins in function mode as
well as pin configuration parameters.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Acked-by: Rob Herring <robh@kernel.org>

---
Changes from V4:
- Separate out from pincontrol driver

Changes from V5:
- Starting patch title with pinctrl instead of DT:pinctrl

Changes from V6/V7:
- None

 .../bindings/pinctrl/pinctrl-max77620.txt          | 127 +++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-max77620.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-max77620.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-max77620.txt
new file mode 100644
index 0000000..ad4fce3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-max77620.txt
@@ -0,0 +1,127 @@
+Pincontrol driver for MAX77620 Power management IC from Maxim Semiconductor.
+
+Device has 8 GPIO pins which can be configured as GPIO as well as the
+special IO functions.
+
+Please refer file <devicetree/bindings/pinctrl/pinctrl-bindings.txt>
+for details of the common pinctrl bindings used by client devices,
+including the meaning of the phrase "pin configuration node".
+
+Optional Pinmux properties:
+--------------------------
+Following properties are required if default setting of pins are required
+at boot.
+- pinctrl-names: A pinctrl state named per <pinctrl-binding.txt>.
+- pinctrl[0...n]: Properties to contain the phandle for pinctrl states per
+		<pinctrl-binding.txt>.
+
+The pin configurations are defined as child of the pinctrl states node. Each
+sub-node have following properties:
+
+Required properties:
+------------------
+- pins: List of pins. Valid values of pins properties are:
+		      gpio0, gpio1, gpio2, gpio3, gpio4, gpio5, gpio6, gpio7.
+
+Optional properties:
+-------------------
+Following are optional properties defined as pinmux DT binding document
+<pinctrl-bindings.txt>. Absence of properties will leave the configuration
+on default.
+	function,
+	drive-push-pull,
+	drive-open-drain,
+	bias-pull-up,
+	bias-pull-down.
+
+Valid values for function properties are:
+	gpio, lpm-control-in, fps-out, 32k-out, sd0-dvs-in, sd1-dvs-in,
+	reference-out
+
+Theres is also customised properties for the GPIO1, GPIO2 and GPIO3. These
+customised properties are required to configure FPS configuration parameters
+of these GPIOs. Please refer <devicetree/bindings/mfd/max77620.txt> for more
+detail of Flexible Power Sequence (FPS).
+
+- maxim,active-fps-source:		FPS source for the GPIOs to get
+					enabled/disabled when system is in
+					active state.  Valid values are:
+					- MAX77620_FPS_SRC_0,
+						FPS source is FPS0.
+					- MAX77620_FPS_SRC_1,
+						FPS source is FPS1
+					- MAX77620_FPS_SRC_2 and
+						FPS source is FPS2
+					- MAX77620_FPS_SRC_NONE.
+						GPIO is not controlled
+						by FPS events and it gets
+						enabled/disabled by register
+						access.
+					Absence of this property will leave
+					the FPS configuration register for that
+					GPIO to default configuration.
+
+- maxim,active-fps-power-up-slot:	Sequencing event slot number on which
+					the GPIO get enabled when
+					master FPS input event set to HIGH.
+					Valid values are 0 to 7.
+					This is applicable if FPS source is
+					selected as FPS0, FPS1 or FPS2.
+
+- maxim,active-fps-power-down-slot:	Sequencing event slot number on which
+					the GPIO get disabled when master
+					FPS input event set to LOW.
+					Valid values are 0 to 7.
+					This is applicable if FPS source is
+					selected as FPS0, FPS1 or FPS2.
+
+- maxim,suspend-fps-source:		This is same as property
+					"maxim,active-fps-source" but value
+					get configured when system enters in
+					to suspend state.
+
+- maxim,suspend-fps-power-up-slot:	This is same as property
+					"maxim,active-fps-power-up-slot" but
+					this value get configured into FPS
+					configuration register when system
+					enters into suspend.
+					This is applicable if suspend state
+					FPS source is selected as FPS0, FPS1 or
+
+- maxim,suspend-fps-power-down-slot:	This is same as property
+					"maxim,active-fps-power-down-slot" but
+					this value get configured into FPS
+					configuration register when system
+					enters into suspend.
+					This is applicable if suspend state
+					FPS source is selected as FPS0, FPS1 or
+					FPS2.
+
+Example:
+--------
+#include <dt-bindings/mfd/max77620.h>
+...
+max77620@3c {
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&spmic_default>;
+
+	spmic_default: pinmux@0 {
+		pin_gpio0 {
+			pins = "gpio0";
+			function = "gpio";
+		};
+
+		pin_gpio1 {
+			pins = "gpio1";
+			function = "fps-out";
+			maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
+		};
+
+		pin_gpio2 {
+			pins = "gpio2";
+			function = "fps-out";
+			maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
+		};
+	};
+};
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
