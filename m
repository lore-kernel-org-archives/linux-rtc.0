Return-Path: <rtc-linux+bncBDXOFUXT2UGBBYO657DAKGQEAYYK2NI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from relmlie2.idc.renesas.com (relmlor3.renesas.com. [210.160.252.173])
        by gmr-mx.google.com with ESMTP id r66si1261433pfb.7.2017.03.29.10.31.12
        for <rtc-linux@googlegroups.com>;
        Wed, 29 Mar 2017 10:31:12 -0700 (PDT)
From: Chris Brandt <chris.brandt@renesas.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Chris Brandt <chris.brandt@renesas.com>
Subject: [rtc-linux] [PATCH v3 2/7] dt-bindings: rtc: document the rtc-sh bindings
Date: Wed, 29 Mar 2017 10:30:30 -0700
Message-Id: <20170329173035.67477-3-chris.brandt@renesas.com>
In-Reply-To: <20170329173035.67477-1-chris.brandt@renesas.com>
References: <20170329173035.67477-1-chris.brandt@renesas.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Add the binding documentation for rtc-sh which is an RTC for
SuperH and RZ/A SoCs.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
v3:
* remove 'power-domains' from example
* update commit message subject and body
v2:
* added interrupt-names and clock-names
* clocks now include counting sources
* changed 'is a RTC' to 'is an RTC' in commit message
---
 Documentation/devicetree/bindings/rtc/rtc-sh.txt | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-sh.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-sh.txt b/Documentation/devicetree/bindings/rtc/rtc-sh.txt
new file mode 100644
index 000000000000..7676c7d28874
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-sh.txt
@@ -0,0 +1,28 @@
+* Real Time Clock for Renesas SH and ARM SoCs
+
+Required properties:
+- compatible: Should be "renesas,r7s72100-rtc" and "renesas,sh-rtc" as a
+  fallback.
+- reg: physical base address and length of memory mapped region.
+- interrupts: 3 interrupts for alarm, period, and carry.
+- interrupt-names: The interrupts should be labeled as "alarm", "period", and
+  "carry".
+- clocks: The functional clock source for the RTC controller must be listed
+  first (if exists). Additionally, potential clock counting sources are to be
+  listed.
+- clock-names: The functional clock must be labeled as "fck". Other clocks
+  may be named in accordance to the SoC hardware manuals.
+
+
+Example:
+rtc: rtc@fcff1000 {
+	compatible = "renesas,r7s72100-rtc", "renesas,sh-rtc";
+	reg = <0xfcff1000 0x2e>;
+	interrupts = <GIC_SPI 276 IRQ_TYPE_EDGE_RISING
+		      GIC_SPI 277 IRQ_TYPE_EDGE_RISING
+		      GIC_SPI 278 IRQ_TYPE_EDGE_RISING>;
+	interrupt-names = "alarm", "period", "carry";
+	clocks = <&mstp6_clks R7S72100_CLK_RTC>, <&rtc_x1_clk>,
+		 <&rtc_x3_clk>, <&extal_clk>;
+	clock-names = "fck", "rtc_x1", "rtc_x3", "extal";
+};
-- 
2.11.0


-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
