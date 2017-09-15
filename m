Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:51392 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbdIOAUv (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 14 Sep 2017 20:20:51 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Barry Song <baohua@kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] dt-bindings: RTC: Add sirf,prima2-sysrtc bindings
Date: Fri, 15 Sep 2017 02:20:35 +0200
Message-Id: <20170915002035.13284-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Add device tree bindings for the SiRFSoC Real Time Clock.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 .../devicetree/bindings/rtc/sirf,prima2-sysrtc.txt         | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/sirf,prima2-sysrtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/sirf,prima2-sysrtc.txt b/Documentation/devicetree/bindings/rtc/sirf,prima2-sysrtc.txt
new file mode 100644
index 000000000000..206a5b44af48
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/sirf,prima2-sysrtc.txt
@@ -0,0 +1,14 @@
+SiRFSoC Real Time Clock
+
+Required properties:
+- compatible: must be "sirf,prima2-sysrtc"
+- reg: address range of rtc register set.
+- interrupts: rtc alarm interrupts.
+
+Example:
+			sysrtc@2000 {
+				compatible = "sirf,prima2-sysrtc";
+				reg = <0x2000 0x1000>;
+				interrupts = <52 53 54>;
+			};
+
-- 
2.14.1
