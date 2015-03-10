Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: [v2,3/4] dt-bindings Help for pcf85063
From: =?utf-8?q?S=C3=B8ren_Andersen?= <san@rosetechnology.dk>
Message-Id: <1426019675.5476.21.camel@sanws1.rosetechnology.dk>
To: a.zummo@towertech.it
Cc: devicetree@vger.kernel.org, rtc-linux@googlegroups.com
Date: Tue, 10 Mar 2015 21:34:35 +0100
List-ID: <rtc-linux.googlegroups.com>

Signed-off-by: Soeren Andersen <san at rosetechnology.dk>
---
 Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
index 0000000..dcda544
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
@@ -0,0 +1,16 @@
+* NXP PCF85063		Tiny Real-Time Clock
+
+Required properties:
+- compatible: Should contain "nxp,pcf85063".
+- reg: I2C address for chip
+
+Optional properties:
+- quartz_load : Internal oscillator capacity for quartz crystals
+	Values usable for pcf85063 load capacitance are 7pF, 12.5pF
+
+Example:
+	pcf85063: rtc@51 {
+		compatible = "nxp,pcf85063";
+		quartz_load = "12.5pF";
+		reg = <0x51>;
+	};
