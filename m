Return-Path: <rtc-linux+bncBAABBV6PZ3GAKGQE2WNGRFQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from regular1.263xmail.com (regular1.263xmail.com. [211.150.99.131])
        by gmr-mx.google.com with ESMTPS id k73si1925948pfh.2.2017.08.15.19.03.02
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 19:03:03 -0700 (PDT)
From: Joseph Chen <chenjh@rock-chips.com>
To: gnurou@gmail.com,
	linus.walleij@linaro.org,
	dmitry.torokhov@gmail.com,
	lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org,
	huangtao@rock-chips.com,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	broonie@kernel.org,
	zhangqing@rock-chips.com,
	robh+dt@kernel.org,
	lgirdwood@gmail.com,
	linux-rockchip@lists.infradead.org,
	wdc@rock-chips.com,
	tony.xie@rock-chips.com,
	linux-input@vger.kernel.org,
	mark.rutland@arm.com,
	w.egorov@phytec.de,
	linux-clk@vger.kernel.org,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	Joseph Chen <chenjh@rock-chips.com>
Subject: [rtc-linux] [RESEND v9 12/12] pinctrl: dt-bindings: add bindings for
 Rockchip RK805 PMIC
Date: Wed, 16 Aug 2017 10:02:25 +0800
Message-Id: <1502848945-8574-1-git-send-email-chenjh@rock-chips.com>
In-Reply-To: <1502848628-27757-1-git-send-email-chenjh@rock-chips.com>
References: <1502848628-27757-1-git-send-email-chenjh@rock-chips.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/pinctrl/pinctrl-rk805.txt  | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt
new file mode 100644
index 0000000..eee3dc2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt
@@ -0,0 +1,63 @@
+Pincontrol driver for RK805 Power management IC.
+
+RK805 has 2 pins which can be configured as GPIO output only.
+
+Please refer file <devicetree/bindings/pinctrl/pinctrl-bindings.txt>
+for details of the common pinctrl bindings used by client devices,
+including the meaning of the phrase "pin configuration node".
+
+Optional Pinmux properties:
+--------------------------
+Following properties are required if default setting of pins are required
+at boot.
+- pinctrl-names: A pinctrl state named per <pinctrl-binding.txt>.
+- pinctrl[0...n]: Properties to contain the phandle for pinctrl states per
+		<pinctrl-binding.txt>.
+
+The pin configurations are defined as child of the pinctrl states node. Each
+sub-node have following properties:
+
+Required properties:
+------------------
+- #gpio-cells: Should be two. The first cell is the pin number and the
+  second is the GPIO flags.
+
+- gpio-controller: Marks the device node as a GPIO controller.
+
+- pins: List of pins. Valid values of pins properties are: gpio0, gpio1.
+
+First 2 properties must be added in the RK805 PMIC node, documented in
+Documentation/devicetree/bindings/mfd/rk808.txt
+
+Optional properties:
+-------------------
+Following are optional properties defined as pinmux DT binding document
+<pinctrl-bindings.txt>. Absence of properties will leave the configuration
+on default.
+	function,
+	output-low,
+	output-high.
+
+Valid values for function properties are: gpio.
+
+Theres is also not customised properties for any GPIO.
+
+Example:
+--------
+rk805: rk805@18 {
+	compatible = "rockchip,rk805";
+	...
+	gpio-controller;
+	#gpio-cells = <2>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pmic_int_l>, <&rk805_default>;
+
+	rk805_default: pinmux {
+		gpio01 {
+			pins = "gpio0", "gpio1";
+			function = "gpio";
+			output-high;
+		};
+	};
+};
-- 
1.9.1


-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
