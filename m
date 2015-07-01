Return-Path: <rtc-linux+bncBAABBTGSZ6WAKGQE5IK4F4Y@googlegroups.com>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com. [193.109.254.107])
        by gmr-mx.google.com with ESMTPS id ec7si110172wib.3.2015.07.01.06.21.15
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2015 06:21:15 -0700 (PDT)
Message-ID: <f7d3b86530f871549159fed1fd0519375997a2af.1435756293.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1435756293.git.stwiss.opensource@diasemi.com>
References: <cover.1435756293.git.stwiss.opensource@diasemi.com>
From: S Twiss <stwiss.opensource@diasemi.com>
Date: Wed, 1 Jul 2015 14:11:33 +0100
Subject: [rtc-linux] [PATCH V5 2/2] devicetree: da9062: Add bindings for
 DA9062 driver
To: DEVICETREE <devicetree@vger.kernel.org>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring
	<robh+dt@kernel.org>
CC: Alessandro Zummo <a.zummo@towertech.it>, David Dajun Chen
	<david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	LINUXINPUT <linux-input@vger.kernel.org>, LINUXWATCHDOG
	<linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, "Liam
 Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, RTCLINUX
	<rtc-linux@googlegroups.com>, S Twiss <stwiss.opensource@diasemi.com>,
	"Samuel Ortiz" <sameo@linux.intel.com>, Support Opensource
	<support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>
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

From: S Twiss <stwiss.opensource@diasemi.com>

Add device tree bindings for the DA9062 driver

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
Changes in V5:
 - No change

Changes in V4:
 - No change

Changes in V3:
 - No change
 
Changes in V2:
 - Dropped the RTC and Onkey binding information in this patch-set
   Those drivers have been dropped from this patch set and the
   binding information has been removed accordingly.

This patch applies against linux-next and next-20150701 



 Documentation/devicetree/bindings/mfd/da9062.txt | 79 ++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/da9062.txt

diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
new file mode 100644
index 0000000..5765ed9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/da9062.txt
@@ -0,0 +1,79 @@
+* Dialog DA9062 Power Management Integrated Circuit (PMIC)
+
+DA9062 consists of a large and varied group of sub-devices:
+
+Device                   Supply Names    Description
+------                   ------------    -----------
+da9062-regulator        :               : LDOs & BUCKs
+da9062-watchdog         :               : Watchdog Timer
+
+======
+
+Required properties:
+
+- compatible : Should be "dlg,da9062".
+- reg : Specifies the I2C slave address (this defaults to 0x58 but it can be
+  modified to match the chip's OTP settings).
+- interrupt-parent : Specifies the reference to the interrupt controller for
+  the DA9062.
+- interrupts : IRQ line information.
+- interrupt-controller
+
+See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt for
+further information on IRQ bindings.
+
+Sub-nodes:
+
+- regulators : This node defines the settings for the LDOs and BUCKs. The
+  DA9062 regulators are bound using their names listed below:
+
+    buck1    : BUCK_1
+    buck2    : BUCK_2
+    buck3    : BUCK_3
+    buck4    : BUCK_4
+    ldo1     : LDO_1
+    ldo2     : LDO_2
+    ldo3     : LDO_3
+    ldo4     : LDO_4
+
+  The component follows the standard regulator framework and the bindings
+  details of individual regulator device can be found in:
+  Documentation/devicetree/bindings/regulator/regulator.txt
+
+
+- watchdog: This node defines the settings for the watchdog driver associated
+  with the DA9062 PMIC. The compatible = "dlg,da9062-watchdog" should be added
+  if a node is created.
+
+
+Example:
+
+	pmic0: da9062@58 {
+		compatible = "dlg,da9062";
+		reg = <0x58>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+
+		watchdog {
+			compatible = "dlg,da9062-watchdog";
+		};
+
+		regulators {
+			DA9062_BUCK1: buck1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1570000>;
+				regulator-min-microamp = <500000>;
+				regulator-max-microamp = <2000000>;
+				regulator-boot-on;
+			};
+			DA9062_LDO1: ldo1 {
+				regulator-name = "LDO_1";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-boot-on;
+			};
+		};
+	};
+
-- 
end-of-patch for PATCH V5

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
