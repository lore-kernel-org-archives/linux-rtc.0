Return-Path: <rtc-linux+bncBCMILY6JWQBBBXUD2W5QKGQEILMEFPA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from wens.csie.org (mirror2.csie.ntu.edu.tw. [140.112.30.76])
        by gmr-mx.google.com with ESMTPS id 62si639173pfx.1.2016.06.30.08.59.26
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jun 2016 08:59:26 -0700 (PDT)
From: Chen-Yu Tsai <wens@csie.org>
To: Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>
Cc: Chen-Yu Tsai <wens@csie.org>,
	linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH v4 7/7] ARM: dts: sun9i: Switch to the AC100 RTC
 clock outputs for osc32k
Date: Thu, 30 Jun 2016 23:58:51 +0800
Message-Id: <1467302331-9663-8-git-send-email-wens@csie.org>
In-Reply-To: <1467302331-9663-1-git-send-email-wens@csie.org>
References: <1467302331-9663-1-git-send-email-wens@csie.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The 32.768 kHz clock inside the A80 SoC is fed from an external source,
typically the AC100 RTC module.

Make the osc32k placeholder a fixed-factor clock so board dts files can
specify its source.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v3: none
Changes since v2: none
Changes since v1: none
---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 5 +++++
 arch/arm/boot/dts/sun9i-a80-optimus.dts     | 5 +++++
 arch/arm/boot/dts/sun9i-a80.dtsi            | 9 +++------
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index cf2f4b72a841..04b014603659 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -103,6 +103,11 @@
 	allwinner,drive = <SUN4I_PINCTRL_40_MA>;
 };
 
+&osc32k {
+	/* osc32k input is from AC100 */
+	clocks = <&ac100_rtc 0>;
+};
+
 &pio {
 	led_pins_cubieboard4: led-pins@0 {
 		allwinner,pins = "PH6", "PH17";
diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index e35c06c162a7..fd874ded890e 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -152,6 +152,11 @@
 	status = "okay";
 };
 
+&osc32k {
+	/* osc32k input is from AC100 */
+	clocks = <&ac100_rtc 0>;
+};
+
 &pio {
 	led_pins_optimus: led-pins@0 {
 		allwinner,pins = "PH0", "PH1";
diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index f68b3242b33a..dd11115ec087 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -148,15 +148,12 @@
 
 		/*
 		 * The 32k clock is from an external source, normally the
-		 * AC100 codec/RTC chip. This clock is by default enabled
-		 * and clocked at 32768 Hz, from the oscillator connected
-		 * to the AC100. It is configurable, but no such driver or
-		 * bindings exist yet.
+		 * AC100 codec/RTC chip. This serves as a placeholder for
+		 * board dts files to specify the source.
 		 */
 		osc32k: osc32k_clk {
 			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <32768>;
+			compatible = "fixed-factor-clock";
 			clock-output-names = "osc32k";
 		};
 
-- 
2.8.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
