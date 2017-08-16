Return-Path: <rtc-linux+bncBAABBNWPZ3GAKGQE4Q6FILY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from regular1.263xmail.com (regular1.263xmail.com. [211.150.99.135])
        by gmr-mx.google.com with ESMTPS id c194si562itb.5.2017.08.15.19.02.10
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 19:02:29 -0700 (PDT)
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
Subject: [rtc-linux] [RESEND v9 07/12] mfd: dt-bindings: Add RK805 device tree
 bindings document
Date: Wed, 16 Aug 2017 10:00:47 +0800
Message-Id: <1502848847-26398-1-git-send-email-chenjh@rock-chips.com>
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

From: Elaine Zhang <zhangqing@rock-chips.com>

Add device tree bindings documentation for Rockchip's RK805 PMIC.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/mfd/rk808.txt | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentation/devicetree/bindings/mfd/rk808.txt
index 9636ae8..91b6522 100644
--- a/Documentation/devicetree/bindings/mfd/rk808.txt
+++ b/Documentation/devicetree/bindings/mfd/rk808.txt
@@ -1,11 +1,14 @@
 RK8XX Power Management Integrated Circuit
 
 The rk8xx family current members:
+rk805
 rk808
 rk818
 
 Required properties:
-- compatible: "rockchip,rk808", "rockchip,rk818"
+- compatible: "rockchip,rk805"
+- compatible: "rockchip,rk808"
+- compatible: "rockchip,rk818"
 - reg: I2C slave address
 - interrupt-parent: The parent interrupt controller.
 - interrupts: the interrupt outputs of the controller.
@@ -18,6 +21,14 @@ Optional properties:
 - rockchip,system-power-controller: Telling whether or not this pmic is controlling
   the system power.
 
+Optional RK805 properties:
+- vcc1-supply:  The input supply for DCDC_REG1
+- vcc2-supply:  The input supply for DCDC_REG2
+- vcc3-supply:  The input supply for DCDC_REG3
+- vcc4-supply:  The input supply for DCDC_REG4
+- vcc5-supply:  The input supply for LDO_REG1 and LDO_REG2
+- vcc6-supply:  The input supply for LDO_REG3
+
 Optional RK808 properties:
 - vcc1-supply:  The input supply for DCDC_REG1
 - vcc2-supply:  The input supply for DCDC_REG2
@@ -56,6 +67,15 @@ by a child node of the 'regulators' node.
 		/* standard regulator bindings here */
 	};
 
+Following regulators of the RK805 PMIC regulators are supported. Note that
+the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
+number as described in RK805 datasheet.
+
+	- DCDC_REGn
+		- valid values for n are 1 to 4.
+	- LDO_REGn
+		- valid values for n are 1 to 3
+
 Following regulators of the RK808 PMIC block are supported. Note that
 the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
 number as described in RK808 datasheet.
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
