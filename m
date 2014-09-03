Return-Path: <boris.brezillon@free-electrons.com>
From: Boris BREZILLON <boris.brezillon@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Andrew Victor <linux@maxim.org.za>,
	Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com
Cc: Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: [PATCH 5/5] rtc: at91sam9: add DT bindings documentation
Date: Wed,  3 Sep 2014 10:45:34 +0200
Message-Id: <1409733934-14465-6-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1409733934-14465-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1409733934-14465-1-git-send-email-boris.brezillon@free-electrons.com>
List-ID: <rtc-linux.googlegroups.com>

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 .../devicetree/bindings/rtc/atmel,at91sam9-rtc.txt   | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
new file mode 100644
index 0000000..9ca455f
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
@@ -0,0 +1,20 @@
+Atmel AT91SAM9260 Real Time Timer
+
+Required properties:
+- compatible: should be: "atmel,at91sam9260-rtt"
+- reg: should contain 2 memory regions
+  * the first one encodes the memory region of the RTT controller
+  * the second one encodes the GPBR (General Purpose Backup Resgisters)
+    memory region used to store the current time
+- interrupts: rtc alarm/event interrupt
+- clocks: should contain one clock pointing the the slow clk
+
+Example:
+
+rtc@fffffe00 {
+	compatible = "atmel,at91sam9260-rtt";
+	reg = <0xfffffd20 0x10
+	       0xfffffd50 0x4>;
+	interrupts = <1 4 7>;
+	clocks = <&clk32k>;
+};
-- 
1.9.1
