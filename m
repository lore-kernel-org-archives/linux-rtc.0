Return-Path: <rtc-linux+bncBD2OLRXW4ABBB27T6G2QKGQEK6C4FVI@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id 12si818173pfb.1.2016.02.11.04.09.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Feb 2016 04:09:15 -0800 (PST)
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
Subject: [rtc-linux] [PATCH V8 7/8] regulator: add DT binding doc for
 regulator of PMIC max77620/max20024
Date: Thu, 11 Feb 2016 17:26:33 +0530
Message-ID: <1455191794-6065-8-git-send-email-ldewangan@nvidia.com>
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

Changes from V7:
- Details out the customised property.

 .../bindings/regulator/regulator-max77620.txt      | 200 +++++++++++++++++++++
 1 file changed, 200 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/regulator-max77620.txt

diff --git a/Documentation/devicetree/bindings/regulator/regulator-max77620.txt b/Documentation/devicetree/bindings/regulator/regulator-max77620.txt
new file mode 100644
index 0000000..b3c8ca6
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/regulator-max77620.txt
@@ -0,0 +1,200 @@
+Regulator DT binding for MAX77620 Power management IC from Maxim Semiconductor.
+
+Device has multiple DCDC(sd[0-3] and LDOs(ldo[0-8]). The input supply
+of these regulators are defined under parent device node.
+Details of regulator properties are defined as child node under
+sub-node "regulators" which is child node of device node.
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
+in-sd0-supply:		Input supply for SD0, INA-SD0 or INB-SD0 pins.
+in-sd1-supply:		Input supply for SD1.
+in-sd2-supply:		Input supply for SD2.
+in-sd3-supply:		Input supply for SD3.
+in-ldo0-1-supply:	Input supply for LDO0 and LDO1.
+in-ldo2-supply:		Input supply for LDO2.
+in-ldo3-5-supply:	Input supply for LDO3 and LDO5
+in-ldo4-6-supply:	Input supply for LDO4 and LDO6.
+in-ldo7-8-supply:	Input supply for LDO7 and LDO8.
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
+Theres are also additional properties for SD/LDOs. These additional properties
+are required to configure FPS configuration parameters for SDs and LDOs.
+Please refer <devicetree/bindings/mfd/max77620.txt> for more detail of Flexible
+Power Sequence (FPS).
+Following are additional properties:
+
+- maxim,active-fps-source:		FPS source for the regulators to get
+					enabled/disabled when system is in
+					active state.  Valid values are:
+					- MAX77620_FPS_SRC_0,
+						FPS source is FPS0.
+					- MAX77620_FPS_SRC_1,
+						FPS source is FPS1
+					- MAX77620_FPS_SRC_2 and
+						FPS source is FPS2
+					- MAX77620_FPS_SRC_NONE.
+						Regulator is not controlled
+						by FPS events and it gets
+						enabled/disabled by register
+						access.
+					Absence of this property will leave
+					the FPS configuration register for that
+					regulator to default configuration.
+
+- maxim,active-fps-power-up-slot:	Sequencing event slot number on which
+					the regulator get enabled when
+					master FPS input event set to HIGH.
+					Valid values are 0 to 7.
+					This is applicable if FPS source is
+					selected as FPS0, FPS1 or FPS2.
+			
+- maxim,active-fps-power-down-slot:	Sequencing event slot number on which
+					the regulator get disabled when master
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
+	in-ldo0-1-supply = <&max77620_sd2>;
+	in-ldo7-8-supply = <&max77620_sd2>;
+	regulators {
+		sd0 {
+			regulator-name = "vdd-core";
+			regulator-min-microvolt = <600000>;
+			regulator-max-microvolt = <1400000>;
+			regulator-boot-on;
+			regulator-always-on;
+			maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
+		};
+
+		sd1 {
+			regulator-name = "vddio-ddr";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-always-on;
+			regulator-boot-on;
+			maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
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
