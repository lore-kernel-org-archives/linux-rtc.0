Return-Path: <rtc-linux+bncBDXOFUXT2UGBBN5BVPDAKGQETM55XNI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from relmlie3.idc.renesas.com (relmlor4.renesas.com. [210.160.252.174])
        by gmr-mx.google.com with ESMTP id c123si1013513pfa.4.2017.03.16.10.51.50
        for <rtc-linux@googlegroups.com>;
        Thu, 16 Mar 2017 10:51:51 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH 4/5] ARM: dts: r7s72100: add rtc to device tree
Date: Thu, 16 Mar 2017 13:51:11 -0400
Message-Id: <20170316175112.27913-5-chris.brandt@renesas.com>
In-Reply-To: <20170316175112.27913-1-chris.brandt@renesas.com>
References: <20170316175112.27913-1-chris.brandt@renesas.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 arch/arm/boot/dts/r7s72100.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 2a42a79..e047fc8 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -551,4 +551,15 @@
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
+
+	rtc: rtc@fcff1000 {
+		compatible = "renesas,r7s72100-rtc", "renesas,sh-rtc";
+		reg = <0xfcff1000 0x2e>;
+		interrupts = <GIC_SPI 276 IRQ_TYPE_EDGE_RISING
+			      GIC_SPI 277 IRQ_TYPE_EDGE_RISING
+			      GIC_SPI 278 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&mstp6_clks R7S72100_CLK_RTC>;
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
 };
-- 
2.10.1


-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
