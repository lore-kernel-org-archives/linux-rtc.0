Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:51369 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbdIOAUM (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 14 Sep 2017 20:20:12 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] dt-bindings: RTC: add stericsson,coh901331 bindings
Date: Fri, 15 Sep 2017 02:19:52 +0200
Message-Id: <20170915001952.13170-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Add device tree bindings for the ST-Ericsson COH 901 331 Real Time Clock

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 .../devicetree/bindings/rtc/stericsson,coh901331.txt   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/stericsson,coh901331.txt

diff --git a/Documentation/devicetree/bindings/rtc/stericsson,coh901331.txt b/Documentation/devicetree/bindings/rtc/stericsson,coh901331.txt
new file mode 100644
index 000000000000..b592faca1612
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/stericsson,coh901331.txt
@@ -0,0 +1,18 @@
+ST-Ericsson COH 901 331 Real Time Clock
+
+Required properties:
+- compatible: must be "stericsson,coh901331"
+- reg: address range of rtc register set.
+- interrupt-parent: phandle for the interrupt controller.
+- interrupts: rtc alarm interrupt.
+- clocks: phandle to the rtc clock source
+
+Example:
+	rtc: rtc@c0017000 {
+		compatible = "stericsson,coh901331";
+		reg = <0xc0017000 0x1000>;
+		interrupt-parent = <&vicb>;
+		interrupts = <10>;
+		clocks = <&rtc_clk>;
+	};
+
-- 
2.14.1
