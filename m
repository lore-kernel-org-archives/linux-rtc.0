Return-Path: <alexandre.belloni@free-electrons.com>
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Philippe De Muyter <phdm@macqel.be>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	devicetree-discuss@lists.ozlabs.org
Subject: [PATCH 1/2] Documentation: bindings: add abracon,abx80x
Date: Sat, 14 Mar 2015 11:05:45 +0100
Message-Id: <1426327546-8085-2-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1426327546-8085-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426327546-8085-1-git-send-email-alexandre.belloni@free-electrons.com>
List-ID: <rtc-linux.googlegroups.com>

Document the bindings for abracon,abx80x and related compatibles.

Cc: devicetree-discuss@lists.ozlabs.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 .../devicetree/bindings/rtc/abracon,abx80x.txt     | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/abracon,abx80x.txt

diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt b/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
new file mode 100644
index 000000000000..6f0d3b2cdd89
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
@@ -0,0 +1,32 @@
+Abracon ABX80X I2C ultra low power RTC/Alarm chip
+
+The Abracon ABX80X family consist of the ab0801, ab0803, ab0804, ab0805, ab1801,
+ab1803, ab1804 and ab1805. The ab0805 is the superset of ab080x and the ab1805
+is the superset of ab180x.
+
+Required properties:
+
+ - "compatible": should one of:
+        "abracon,abx80x"
+        "abracon,ab0801"
+        "abracon,ab0803"
+        "abracon,ab0804"
+        "abracon,ab0805"
+        "abracon,ab1801"
+        "abracon,ab1803"
+        "abracon,ab1804"
+        "abracon,ab1805"
+	Using "abracon,abx80x" will enable chip autodetection.
+ - "reg": I2C bus address of the device
+
+Optional properties:
+
+The abx804 and abx805 have a trickle charger that is able to charge the
+connected battery or supercap. Both the following properties have to be defined
+and valid to enable charging:
+
+ - "abracon,tc-diode": should be "standard" (0.6V) or "schottky" (0.3V)
+ - "abracon,tc-resistor": should be <0>, <3>, <6> or <11>. 0 disables the output
+                          resistor, the other values are in ohm.
+
+
-- 
2.1.0
