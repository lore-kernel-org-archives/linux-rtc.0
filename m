Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:25487 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1752259AbdKIDp2 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 8 Nov 2017 22:45:28 -0500
From: Baolin Wang <baolin.wang@spreadtrum.com>
To: <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <broonie@kernel.org>,
        <baolin.wang@linaro.org>, <baolin.wang@spreadtrum.com>
Subject: [PATCH v3 1/2] dt-bindings: rtc: Add Spreadtrum SC27xx RTC documentation
Date: Thu, 9 Nov 2017 11:34:16 +0800
Message-ID: <c65b61e5e37cb43214973cb3e479ce06c4a73395.1510198341.git.baolin.wang@spreadtrum.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This patch adds the binding documentation for Spreadtrum SC27xx series
RTC device.

Signed-off-by: Baolin Wang <baolin.wang@spreadtrum.com>
---
Changes since v2:
 - No updates.

Changes since v1:
 - Use a specific chip name as compatible string.
 - Remove useless alias.
 - Add the parent MFD node.
---
 .../devicetree/bindings/rtc/sprd,sc27xx-rtc.txt    |   27 ++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/sprd,sc27xx-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/sprd,sc27xx-rtc.txt b/Documentation/devicetree/bindings/rtc/sprd,sc27xx-rtc.txt
new file mode 100644
index 0000000..7c170da
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/sprd,sc27xx-rtc.txt
@@ -0,0 +1,27 @@
+Spreadtrum SC27xx Real Time Clock
+
+Required properties:
+- compatible: should be "sprd,sc2731-rtc".
+- reg: address offset of rtc register.
+- interrupt-parent: phandle for the interrupt controller.
+- interrupts: rtc alarm interrupt.
+
+Example:
+
+	sc2731_pmic: pmic@0 {
+		compatible = "sprd,sc2731";
+		reg = <0>;
+		spi-max-frequency = <26000000>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rtc@280 {
+			compatible = "sprd,sc2731-rtc";
+			reg = <0x280>;
+			interrupt-parent = <&sc2731_pmic>;
+			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
-- 
1.7.9.5
