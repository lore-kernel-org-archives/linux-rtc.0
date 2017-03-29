Return-Path: <rtc-linux+bncBDXOFUXT2UGBBYW657DAKGQEKWE7BGA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from relmlie4.idc.renesas.com (relmlor1.renesas.com. [210.160.252.171])
        by gmr-mx.google.com with ESMTP id i189si864231pfg.3.2017.03.29.10.31.13
        for <rtc-linux@googlegroups.com>;
        Wed, 29 Mar 2017 10:31:14 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH v3 4/7] ARM: dts: r7s72100: add RTC_X clock inputs
 to device tree
Date: Wed, 29 Mar 2017 10:30:32 -0700
Message-Id: <20170329173035.67477-5-chris.brandt@renesas.com>
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

Add the RTC clocks to device tree. The frequencies must be fixed values
according to the hardware manual.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 arch/arm/boot/dts/r7s72100.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 6a1448be4e10..632a6a481be8 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -51,6 +51,20 @@
 			clock-frequency = <0>;
 		};
 
+		rtc_x1_clk: rtc_x1 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			/* If clk present, value must be set by board to 32678 */
+			clock-frequency = <0>;
+		};
+
+		rtc_x3_clk: rtc_x3 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			/* If clk present, value must be set by board to 4000000 */
+			clock-frequency = <0>;
+		};
+
 		/* Fixed factor clocks */
 		b_clk: b {
 			#clock-cells = <0>;
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
