Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:38055 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753126AbdI0ODu (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 27 Sep 2017 10:03:50 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 3/6] dt-bindings: rtc: Add sirf,prima2-sysrtc bindings
Date: Wed, 27 Sep 2017 16:03:42 +0200
Message-Id: <20170927140345.5537-4-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170927140345.5537-1-alexandre.belloni@free-electrons.com>
References: <20170927140345.5537-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Add device tree bindings for the SiRFSoC Real Time Clock.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 .../devicetree/bindings/rtc/sirf,prima2-sysrtc.txt          | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/sirf,prima2-sysrtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/sirf,prima2-sysrtc.txt b/Documentation/devicetree/bindings/rtc/sirf,prima2-sysrtc.txt
new file mode 100644
index 000000000000..58885b55da21
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/sirf,prima2-sysrtc.txt
@@ -0,0 +1,13 @@
+SiRFSoC Real Time Clock
+
+Required properties:
+- compatible: must be "sirf,prima2-sysrtc"
+- reg: address range of rtc register set.
+- interrupts: rtc alarm interrupts.
+
+Example:
+	rtc@2000 {
+		compatible = "sirf,prima2-sysrtc";
+		reg = <0x2000 0x1000>;
+		interrupts = <52 53 54>;
+	};
-- 
2.14.2
