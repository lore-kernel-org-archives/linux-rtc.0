Return-Path: <rtc-linux+bncBCMILY6JWQBBBVHT725QKGQEUO2AB2I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from wens.csie.org (mirror2.csie.ntu.edu.tw. [140.112.30.76])
        by gmr-mx.google.com with ESMTPS id ph9si558415pac.1.2016.07.08.07.33.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jul 2016 07:33:54 -0700 (PDT)
From: Chen-Yu Tsai <wens@csie.org>
To: Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH v5 6/7] ARM: dts: sun9i: cubieboard4: Add device
 node for AC100
Date: Fri,  8 Jul 2016 22:33:41 +0800
Message-Id: <1467988422-17934-7-git-send-email-wens@csie.org>
In-Reply-To: <1467988422-17934-1-git-send-email-wens@csie.org>
References: <1467988422-17934-1-git-send-email-wens@csie.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v4: none

Changes since v3:                           

  - Moved 4M ADDA clk to codec side

Changes since v2: none
Changes since v1: none
---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index 1526b41c70f1..cf2f4b72a841 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -250,6 +250,30 @@
 			};
 		};
 	};
+
+	ac100: codec@e89 {
+		compatible = "x-powers,ac100";
+		reg = <0xe89>;
+
+		ac100_codec: codec {
+			compatible = "x-powers,ac100-codec";
+			interrupt-parent = <&r_pio>;
+			interrupts = <0 9 IRQ_TYPE_LEVEL_LOW>; /* PL9 */
+			#clock-cells = <0>;
+			clock-output-names = "4M_adda";
+		};
+
+		ac100_rtc: rtc {
+			compatible = "x-powers,ac100-rtc";
+			interrupt-parent = <&nmi_intc>;
+			interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&ac100_codec>;
+			#clock-cells = <1>;
+			clock-output-names = "cko1_rtc",
+					     "cko2_rtc",
+					     "cko3_rtc";
+		};
+	};
 };
 
 #include "axp809.dtsi"
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
