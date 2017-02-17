Return-Path: <rtc-linux+bncBC6YH6VTZQDRBI44TPCQKGQEIVVVGNQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id q4si56592wma.3.2017.02.17.02.19.14
        for <rtc-linux@googlegroups.com>;
        Fri, 17 Feb 2017 02:19:14 -0800 (PST)
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Haim Boot <hayim@marvell.com>
Subject: [rtc-linux] [PATCH v2 3/3] arm64: dts: marvell: add RTC description
 for Armada 7K/8K
Date: Fri, 17 Feb 2017 11:19:07 +0100
Message-Id: <20170217101907.8963-4-gregory.clement@free-electrons.com>
In-Reply-To: <20170217101907.8963-1-gregory.clement@free-electrons.com>
References: <20170217101907.8963-1-gregory.clement@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This RTC IP is found in the CP110 master and slave which are part of the
Armada 8K SoCs and of the subset family the Armada 7K.

There is one RTC in each CP but the RTC requires an external
oscillator. However on the Armada 80x0, the RTC clock in CP master is not
connected (by package) to the oscillator. So this one is disabled for the
Armada 8020 and the Armada 8040.

As the RTC clock in CP slave is connected to the oscillator this one is
let enabled. and will be used on these SoCs (80x0).

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-8020.dtsi         | 10 ++++++++++
 arch/arm64/boot/dts/marvell/armada-8040.dtsi         |  9 +++++++++
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi |  7 +++++++
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  |  7 +++++++
 4 files changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8020.dtsi b/arch/arm64/boot/dts/marvell/armada-8020.dtsi
index 048e5cf5160e..7c08f1f28d9e 100644
--- a/arch/arm64/boot/dts/marvell/armada-8020.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8020.dtsi
@@ -54,3 +54,13 @@
 	compatible = "marvell,armada8020", "marvell,armada-ap806-dual",
 		     "marvell,armada-ap806";
 };
+
+/* The RTC requires external oscillator. But on Aramda 80x0, the RTC clock
+ * in CP master is not connected (by package) to the oscillator. So
+ * disable it. However, the RTC clock in CP slave is connected to the
+ * oscillator so this one is let enabled.
+ */
+
+&cpm_rtc {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-8040.dtsi b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
index 9c1b28c47683..33813a75bc30 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
@@ -54,3 +54,12 @@
 	compatible = "marvell,armada8040", "marvell,armada-ap806-quad",
 		     "marvell,armada-ap806";
 };
+
+/* The RTC requires external oscillator. But on Aramda 80x0, the RTC clock
+ * in CP master is not connected (by package) to the oscillator. So
+ * disable it. However, the RTC clock in CP slave is connected to the
+ * oscillator so this one is let enabled.
+ */
+&cpm_rtc {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index 3a99c36433d6..d12741414009 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -79,6 +79,13 @@
 					"cpm-usb3dev", "cpm-eip150", "cpm-eip197";
 			};
 
+			cpm_rtc: rtc@284000 {
+				compatible = "marvell,armada-8k-rtc";
+				reg = <0x284000 0x20>, <0x284080 0x24>;
+				reg-names = "rtc", "rtc-soc";
+				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
 			cpm_sata0: sata@540000 {
 				compatible = "marvell,armada-8k-ahci",
 					     "generic-ahci";
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index 9e09c4d3b6bd..d01be5a639e9 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -59,6 +59,13 @@
 			interrupt-parent = <&gic>;
 			ranges = <0x0 0x0 0xf4000000 0x2000000>;
 
+			cps_rtc: rtc@284000 {
+				compatible = "marvell,armada-8k-rtc";
+				reg = <0x284000 0x20>, <0x284080 0x24>;
+				reg-names = "rtc", "rtc-soc";
+				interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
 			cps_syscon0: system-controller@440000 {
 				compatible = "marvell,cp110-system-controller0",
 					     "syscon";
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
