Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:38051 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753123AbdI0ODu (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 27 Sep 2017 10:03:50 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 2/6] dt-bindings: rtc: add stericsson,coh901331 bindings
Date: Wed, 27 Sep 2017 16:03:41 +0200
Message-Id: <20170927140345.5537-3-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170927140345.5537-1-alexandre.belloni@free-electrons.com>
References: <20170927140345.5537-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Add device tree bindings for the ST-Ericsson COH 901 331 Real Time Clock

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 .../devicetree/bindings/rtc/stericsson,coh901331.txt    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/stericsson,coh901331.txt

diff --git a/Documentation/devicetree/bindings/rtc/stericsson,coh901331.txt b/Documentation/devicetree/bindings/rtc/stericsson,coh901331.txt
new file mode 100644
index 000000000000..3ebeb311335f
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/stericsson,coh901331.txt
@@ -0,0 +1,17 @@
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
-- 
2.14.2
