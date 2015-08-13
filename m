Return-Path: <rtc-linux+bncBD66BCOYSQBBBUMEWGXAKGQEAIWSUMY@googlegroups.com>
Received: from devils.ext.ti.com (devils.ext.ti.com. [198.47.26.153])
        by gmr-mx.google.com with ESMTPS id a11si123632igv.3.2015.08.13.00.08.01
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 13 Aug 2015 00:08:01 -0700 (PDT)
From: Keerthy <j-keerthy@ti.com>
To: <linux-omap@vger.kernel.org>, <rtc-linux@googlegroups.com>
CC: <tony@atomide.com>, <alexandre.belloni@free-electrons.com>,
        <akpm@linux-foundation.org>, <johan@kernel.org>,
        <grygorii.strashko@ti.com>, <bcousson@baylibre.com>,
        <devicetree@vger.kernel.org>, <t-kristo@ti.com>, <j-keerthy@ti.com>
Subject: [rtc-linux] [PATCH 1/2] ARM: dts: AM437x: Add the internal and
 external clock nodes for rtc
Date: Thu, 13 Aug 2015 12:37:47 +0530
Message-ID: <1439449668-32301-2-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1439449668-32301-1-git-send-email-j-keerthy@ti.com>
References: <1439449668-32301-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

rtc can either be supplied from internal 32k clock or external crystal
generated 32k clock. Internal clock is SOC specific and the external
clock is board dependent. Adding the corresponding nodes.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi        |  2 ++
 arch/arm/boot/dts/am437x-gp-evm.dts  | 13 +++++++++++++
 arch/arm/boot/dts/am437x-idk-evm.dts |  9 +++++++++
 arch/arm/boot/dts/am437x-sk-evm.dts  |  9 +++++++++
 4 files changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index d99b2ee..484f092 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -336,6 +336,8 @@
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH
 				      GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "rtc";
+			clocks = <&clk_32768_ck>;
+			clock-names = "int-clk";
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 215775d..22038f2 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -112,6 +112,13 @@
 		clock-frequency = <12000000>;
 	};
 
+	/* fixed 32k external oscillator clock */
+	clk_32k_rtc: clk_32k_rtc {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+	};
+
 	sound0: sound@0 {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "AM437x-GP-EVM";
@@ -941,3 +948,9 @@
 	tx-num-evt = <32>;
 	rx-num-evt = <32>;
 };
+
+&rtc {
+	clocks = <&clk_32k_rtc>, <&clk_32768_ck>;
+	clock-names = "ext-clk", "int-clk";
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
index 37834427..af25801 100644
--- a/arch/arm/boot/dts/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/am437x-idk-evm.dts
@@ -110,6 +110,13 @@
 			gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	/* fixed 32k external oscillator clock */
+	clk_32k_rtc: clk_32k_rtc {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+	};
 };
 
 &am43xx_pinmux {
@@ -394,6 +401,8 @@
 };
 
 &rtc {
+	clocks = <&clk_32k_rtc>, <&clk_32768_ck>;
+	clock-names = "ext-clk", "int-clk";
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 22af448..7da7c2d 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -24,6 +24,13 @@
 		display0 = &lcd0;
 	};
 
+	/* fixed 32k external oscillator clock */
+	clk_32k_rtc: clk_32k_rtc {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+	};
+
 	backlight {
 		compatible = "pwm-backlight";
 		pwms = <&ecap0 0 50000 PWM_POLARITY_INVERTED>;
@@ -697,6 +704,8 @@
 };
 
 &rtc {
+	clocks = <&clk_32k_rtc>, <&clk_32768_ck>;
+	clock-names = "ext-clk", "int-clk";
 	status = "okay";
 };
 
-- 
1.9.1

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
