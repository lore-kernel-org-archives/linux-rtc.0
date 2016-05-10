Return-Path: <rtc-linux+bncBAABB257Y64QKGQEOZ3NYJA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from root.phytec.de (mail.x-arc.de. [217.6.246.34])
        by gmr-mx.google.com with ESMTP id a65si1734151wma.0.2016.05.10.06.19.39
        for <rtc-linux@googlegroups.com>;
        Tue, 10 May 2016 06:19:39 -0700 (PDT)
From: Wadim Egorov <w.egorov@phytec.de>
To: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, mturquette@baylibre.com, sboyd@codeaurora.org, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, dianders@chromium.org, zyw@rock-chips.com
Subject: [rtc-linux] [PATCH v5 4/6] mfd: dt-bindings: Add RK818 device tree
 bindings document
Date: Tue, 10 May 2016 15:18:58 +0200
Message-Id: <1462886340-7893-5-git-send-email-w.egorov@phytec.de>
In-Reply-To: <1462886340-7893-1-git-send-email-w.egorov@phytec.de>
References: <1462886340-7893-1-git-send-email-w.egorov@phytec.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Add device tree bindings documentation for Rockchip's RK818 PMIC.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/rk808.txt | 37 +++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentation/devicetree/bindings/mfd/rk808.txt
index 4ca6aab..9636ae8 100644
--- a/Documentation/devicetree/bindings/mfd/rk808.txt
+++ b/Documentation/devicetree/bindings/mfd/rk808.txt
@@ -1,7 +1,11 @@
-RK808 Power Management Integrated Circuit
+RK8XX Power Management Integrated Circuit
+
+The rk8xx family current members:
+rk808
+rk818
 
 Required properties:
-- compatible: "rockchip,rk808"
+- compatible: "rockchip,rk808", "rockchip,rk818"
 - reg: I2C slave address
 - interrupt-parent: The parent interrupt controller.
 - interrupts: the interrupt outputs of the controller.
@@ -13,6 +17,8 @@ Optional properties:
   default output clock name
 - rockchip,system-power-controller: Telling whether or not this pmic is controlling
   the system power.
+
+Optional RK808 properties:
 - vcc1-supply:  The input supply for DCDC_REG1
 - vcc2-supply:  The input supply for DCDC_REG2
 - vcc3-supply:  The input supply for DCDC_REG3
@@ -29,7 +35,20 @@ Optional properties:
   the gpio controller. If DVS GPIOs aren't present, voltage changes will happen
   very quickly with no slow ramp time.
 
-Regulators: All the regulators of RK808 to be instantiated shall be
+Optional RK818 properties:
+- vcc1-supply:  The input supply for DCDC_REG1
+- vcc2-supply:  The input supply for DCDC_REG2
+- vcc3-supply:  The input supply for DCDC_REG3
+- vcc4-supply:  The input supply for DCDC_REG4
+- boost-supply: The input supply for DCDC_BOOST
+- vcc6-supply:  The input supply for LDO_REG1 and LDO_REG2
+- vcc7-supply:  The input supply for LDO_REG3, LDO_REG5 and LDO_REG7
+- vcc8-supply:  The input supply for LDO_REG4, LDO_REG6 and LDO_REG8
+- vcc9-supply:  The input supply for LDO_REG9 and SWITCH_REG
+- h_5v-supply:  The input supply for HDMI_SWITCH
+- usb-supply:   The input supply for OTG_SWITCH
+
+Regulators: All the regulators of RK8XX to be instantiated shall be
 listed in a child node named 'regulators'. Each regulator is represented
 by a child node of the 'regulators' node.
 
@@ -48,6 +67,18 @@ number as described in RK808 datasheet.
 	- SWITCH_REGn
 		- valid values for n are 1 to 2
 
+Following regulators of the RK818 PMIC block are supported. Note that
+the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
+number as described in RK818 datasheet.
+
+	- DCDC_REGn
+		- valid values for n are 1 to 4.
+	- LDO_REGn
+		- valid values for n are 1 to 9.
+	- SWITCH_REG
+	- HDMI_SWITCH
+	- OTG_SWITCH
+
 Standard regulator bindings are used inside regulator subnodes. Check
   Documentation/devicetree/bindings/regulator/regulator.txt
 for more details
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
