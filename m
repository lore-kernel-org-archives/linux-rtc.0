Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:16845 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S932484AbdKGLkf (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 7 Nov 2017 06:40:35 -0500
From: Baolin Wang <baolin.wang@spreadtrum.com>
To: <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <broonie@kernel.org>,
        <baolin.wang@linaro.org>, <baolin.wang@spreadtrum.com>
Subject: [PATCH 1/2] dt-bindings: rtc: Add Spreadtrum SC27xx RTC documentation
Date: Tue, 7 Nov 2017 19:34:07 +0800
Message-ID: <7037c5053a533505f38fc036290a398989cfdafc.1510051749.git.baolin.wang@spreadtrum.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This patch adds the binding documentation for Spreadtrum SC27xx series
RTC device.

Signed-off-by: Baolin Wang <baolin.wang@spreadtrum.com>
---
 .../devicetree/bindings/rtc/sprd,sc27xx-rtc.txt    |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/sprd,sc27xx-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/sprd,sc27xx-rtc.txt b/Documentation/devicetree/bindings/rtc/sprd,sc27xx-rtc.txt
new file mode 100644
index 0000000..971d3a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/sprd,sc27xx-rtc.txt
@@ -0,0 +1,16 @@
+Spreadtrum SC27xx Real Time Clock
+
+Required properties:
+- compatible: should be "sprd,sc27xx-rtc".
+- reg: address offset of rtc register.
+- interrupt-parent: phandle for the interrupt controller.
+- interrupts: rtc alarm interrupt.
+
+Example:
+
+	rtc: rtc@280 {
+		compatible = "sprd,sc27xx-rtc";
+		reg = <0x280>;
+		interrupt-parent = <&pmic>;
+		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+	};
-- 
1.7.9.5
