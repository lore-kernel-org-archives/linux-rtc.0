Return-Path: <rtc-linux+bncBCMILY6JWQBBBUXT725QKGQE64XZZBY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from wens.csie.org (mirror2.csie.ntu.edu.tw. [140.112.30.76])
        by gmr-mx.google.com with ESMTPS id ph9si558393pac.1.2016.07.08.07.33.53
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
Subject: [rtc-linux] [PATCH v5 1/7] mfd: ac100: Add device tree bindings for
 X-Powers AC100 codec/RTC combo IC
Date: Fri,  8 Jul 2016 22:33:36 +0800
Message-Id: <1467988422-17934-2-git-send-email-wens@csie.org>
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

The AC100 is a multifunction device with an audio codec subsystem and
an RTC subsystem. These two subsystems share a common register space
and host interface.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes since v4:

  - Style changes suggested by Lee.
  - Added commit message.
  - Added Rob's ack.

Changes since v3:

  - Fixed device node names and added labels.
  - Added clock output from codec and input to rtc.

Changes since v2:

  - Fix interrupt line for ac100_codec in provided example.

---
 Documentation/devicetree/bindings/mfd/ac100.txt | 54 +++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ac100.txt

diff --git a/Documentation/devicetree/bindings/mfd/ac100.txt b/Documentation/devicetree/bindings/mfd/ac100.txt
new file mode 100644
index 000000000000..b8ef00667599
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ac100.txt
@@ -0,0 +1,54 @@
+X-Powers AC100 Codec/RTC IC Device Tree bindings
+
+AC100 is a audio codec and RTC subsystem combo IC. The 2 parts are
+separated, including power supplies and interrupt lines, but share
+a common register address space and host interface.
+
+Required properties:
+- compatible: "x-powers,ac100"
+- reg: The I2C slave address or RSB hardware address for the chip
+- sub-nodes:
+  - codec
+    - compatible:		"x-powers,ac100-codec"
+    - interrupt-parent:		The parent interrupt controller
+    - interrupts:		SoC NMI / GPIO interrupt connected to the
+    				IRQ_AUDIO pin
+    - #clock-cells:		Shall be 0
+    - clock-output-names:	"4M_adda"
+
+    - see clock/clock-bindings.txt for common clock bindings
+
+  - rtc
+    - compatible:		"x-powers,ac100-rtc"
+    - interrupt-parent:		The parent interrupt controller
+    - interrupts:		SoC NMI / GPIO interrupt connected to the
+    				IRQ_RTC pin
+    - clocks:			A phandle to the codec's "4M_adda" clock
+    - #clock-cells:		Shall be 1
+    - clock-output-names:	"cko1_rtc", "cko2_rtc", "cko3_rtc"
+
+    - see clock/clock-bindings.txt for common clock bindings
+
+Example:
+
+ac100: codec@e89 {
+	compatible = "x-powers,ac100";
+	reg = <0xe89>;
+
+	ac100_codec: codec {
+		compatible = "x-powers,ac100-codec";
+		interrupt-parent = <&r_pio>;
+		interrupts = <0 9 IRQ_TYPE_LEVEL_LOW>; /* PL9 */
+		#clock-cells = <0>;
+		clock-output-names = "4M_adda";
+	};
+
+	ac100_rtc: rtc {
+		compatible = "x-powers,ac100-rtc";
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&ac100_codec>;
+		#clock-cells = <1>;
+		clock-output-names = "cko1_rtc", "cko2_rtc", "cko3_rtc";
+	};
+};
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
