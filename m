Return-Path: <rtc-linux+bncBD2OLRXW4ABBB36TWO2QKGQEZRBAASI@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id 190si2386969pfb.1.2016.01.30.08.50.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jan 2016 08:50:54 -0800 (PST)
From: Laxman Dewangan <ldewangan@nvidia.com>
To: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linus.walleij@linaro.org>, <gnurou@gmail.com>, <lee.jones@linaro.org>,
	<broonie@kernel.org>, <a.zummo@towertech.it>,
	<alexandre.belloni@free-electrons.com>
CC: <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, <swarren@nvidia.com>, <treding@nvidia.com>,
	<k.kozlowski@samsung.com>, <vreddytalla@nvidia.com>, Laxman Dewangan
	<ldewangan@nvidia.com>
Subject: [rtc-linux] [PATCH V7 7/8] regulator: add DT binding doc for
 regulator of PMIC max77620/max20024
Date: Sat, 30 Jan 2016 22:08:50 +0530
Message-ID: <1454171931-27752-8-git-send-email-ldewangan@nvidia.com>
In-Reply-To: <1454171931-27752-1-git-send-email-ldewangan@nvidia.com>
References: <1454171931-27752-1-git-send-email-ldewangan@nvidia.com>
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

Maxim Semiconductor's PMIC MAX77620/MAX20024 has multiple
DCDCs and LDOs.

Add DT binding document to support these regulators via
regulator framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes from V4:
- Separate out from regulator driver 

Changes from V6:
- Starting patch tile with regulator instead of DT:regulator
- Move all ldo supply to device node level from regulator sub node.

 .../bindings/regulator/regulator-max77620.txt      | 163 +++++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/regulator-max77620.txt

diff --git a/Documentation/devicetree/bindings/regulator/regulator-max77620.txt b/Documentation/devicetree/bindings/regulator/regulator-max77620.txt
new file mode 100644
index 0000000..caa8255
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/regulator-max77620.txt
@@ -0,0 +1,163 @@
+Regulator DT binding for MAX77620 Power management IC from Maxim Semiconductor.
+
+Device has multiple DCDC(sd[0-3] and LDOs(ldo[0-8]). The input supply
+of these regulators are defined under parent device node and details
+of regulator properties are defined under the sub node "regulators"
+of parent node.
+
+Please refer file <Documentation/devicetree/bindings/regulator/regulator.txt>
+for common regulator bindings used by client.
+
+Following are properties of parent node related to regulators.
+
+Optional properties:
+-------------------
+The input supply of regulators are the optional properties on the
+parent device node. The input supply of these regulators are provided
+through following properties:
+in-sd0-supply: Input supply for SD0, INA-SD0 or INB-SD0 pins.
+in-sd1-supply: Input supply for SD1.
+in-sd2-supply: Input supply for SD2.
+in-sd3-supply: Input supply for SD3.
+in-ldo0-1-supply: Input supply for LDO0 and LDO1.
+in-ldo2-supply: Input supply for LDO2.
+in-ldo3-5-supply: Input supply for LDO3 and LDO5
+in-ldo4-6-supply: Input supply for LDO4 and LDO6.
+in-ldo7-8-supply: Input supply for LDO7 and LDO8.
+
+
+Optional sub nodes for regulators under "regulators" subnode:
+------------------------------------------------------------
+The subnodes name is the name of regulator and it must be one of:
+	sd[0-3], ldo[0-8]
+
+Each sub-node should contain the constraints and initialization
+information for that regulator. The definition for each of these
+nodes is defined using the standard binding for regulators found at
+<Documentation/devicetree/bindings/regulator/regulator.txt>.
+
+Theres is also additional properties for SD/LDOs.
+The properties are required to configure SDs/LDOs FPS parameters
+when system is in "active" state or in "suspend" state.
+Here "active" state means system is UP and working normally.
+"suspend" state means system enters into the suspend state.
+
+- maxim,active-fps-source:	     FPS source for the gpios in active state
+				     of the GPIO. Valid values are FPS_SRC_0,
+				     FPS_SRC_1, FPS_SRC_2 and FPS_SRC_NONE.
+				     Absence of this property will leave the pin
+				     on default.
+- maxim,active-fps-power-up-slot:    Power up slot on given FPS for active state.
+				     Valid values are 0 to 7.
+- maxim,active-fps-power-down-slot:  Power down slot on given FPS for active
+				     state. Valid values are 0 to 7.
+- maxim,suspend-fps-source:	     Suspend state FPS source. Valid values are
+				     same as maxim,active-fps-source.
+- maxim,suspend-fps-power-down-slot: Suspend state power down slot. Valid
+				     values are 0 to 7.
+- maxim,suspend-fps-power-up-slot:   Suspend state power up slot. Valid values
+				     are 0 to 7.
+
+Example:
+--------
+#include <dt-bindings/mfd/max77620.h>
+...
+max77620@3c {
+	in-ldo0-1-supply = <&max77620_sd2>;
+	in-ldo7-8-supply = <&max77620_sd2>;
+	regulators {
+		sd0 {
+			regulator-name = "vdd-core";
+			regulator-min-microvolt = <600000>;
+			regulator-max-microvolt = <1400000>;
+			regulator-boot-on;
+			regulator-always-on;
+			maxim,active-fps-source = <FPS_SRC_1>;
+		};
+
+		sd1 {
+			regulator-name = "vddio-ddr";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-always-on;
+			regulator-boot-on;
+			maxim,active-fps-source = <FPS_SRC_0>;
+		};
+
+		sd2 {
+			regulator-name = "vdd-pre-reg";
+			regulator-min-microvolt = <1350000>;
+			regulator-max-microvolt = <1350000>;
+		};
+
+		sd3 {
+			regulator-name = "vdd-1v8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		ldo0 {
+			regulator-name = "avdd-sys";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		ldo1 {
+			regulator-name = "vdd-pex";
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1050000>;
+		};
+
+		ldo2 {
+			regulator-name = "vddio-sdmmc3";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		ldo3 {
+			regulator-name = "vdd-cam-hv";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+
+		ldo4 {
+			regulator-name = "vdd-rtc";
+			regulator-min-microvolt = <1250000>;
+			regulator-max-microvolt = <1250000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		ldo5 {
+			regulator-name = "avdd-ts-hv";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		ldo6 {
+			regulator-name = "vdd-ts";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		ldo7 {
+			regulator-name = "vdd-gen-pll-edp";
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1050000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		ldo8 {
+			regulator-name = "vdd-hdmi-dp";
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1050000>;
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
