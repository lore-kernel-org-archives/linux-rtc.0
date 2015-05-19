Return-Path: <rtc-linux+bncBDMYB2E7SQCRB6W35WVAKGQEYG5B4BA@googlegroups.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com (mail-bn1on0110.outbound.protection.outlook.com. [157.56.110.110])
        by gmr-mx.google.com with ESMTPS id ti15si1626314pac.0.2015.05.19.10.08.09
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 May 2015 10:08:09 -0700 (PDT)
From: <Frank.Li@freescale.com>
To: <lznuaa@gmail.com>, <shawn.guo@linaro.org>, <dmitry.torokhov@gmail.com>,
	<robh+dt@kernel.org>, <a.zummo@towertech.it>, <p.zabel@pengutronix.de>,
	<alexandre.belloni@free-electrons.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-input@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Frank Li <Frank.Li@freescale.com>
Subject: [rtc-linux] [PATCH v2 4/7] arm: dts: imx: update snvs to use syscon
 access register
Date: Wed, 20 May 2015 01:04:39 +0800
Message-ID: <1432055082-28983-5-git-send-email-Frank.Li@freescale.com>
In-Reply-To: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
References: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
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

From: Frank Li <Frank.Li@freescale.com>

snvs is MFP device. Change dts to use syscon to allocate register resource.

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 12 ++++--------
 arch/arm/boot/dts/imx6sl.dtsi  | 12 ++++--------
 arch/arm/boot/dts/imx6sx.dtsi  | 12 ++++--------
 arch/arm/boot/dts/vfxxx.dtsi   |  9 +++------
 4 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 0482a66..9df9faf 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -687,21 +687,17 @@
 			};
 
 			snvs@020cc000 {
-				compatible = "fsl,sec-v4.0-mon", "simple-bus";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x020cc000 0x4000>;
+				compatible = "fsl,sec-v4.0-mon", "syscon",  "simple-mfd";
+				reg = <0x020cc000 0x4000>;
 
-				snvs_rtc: snvs-rtc-lp@34 {
+				snvs_rtc: snvs-rtc-lp {
 					compatible = "fsl,sec-v4.0-mon-rtc-lp";
-					reg = <0x34 0x58>;
 					interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>,
 						     <0 20 IRQ_TYPE_LEVEL_HIGH>;
 				};
 
-				snvs_poweroff: snvs-poweroff@38 {
+				snvs_poweroff: snvs-poweroff {
 					compatible = "fsl,sec-v4.0-poweroff";
-					reg = <0x38 0x4>;
 					status = "disabled";
 				};
 			};
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index a78e715..99f37f9 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -564,21 +564,17 @@
 			};
 
 			snvs@020cc000 {
-				compatible = "fsl,sec-v4.0-mon", "simple-bus";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x020cc000 0x4000>;
+				compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
+				reg = <0x020cc000 0x4000>;
 
-				snvs_rtc: snvs-rtc-lp@34 {
+				snvs_rtc: snvs-rtc-lp {
 					compatible = "fsl,sec-v4.0-mon-rtc-lp";
-					reg = <0x34 0x58>;
 					interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>,
 						     <0 20 IRQ_TYPE_LEVEL_HIGH>;
 				};
 
-				snvs_poweroff: snvs-poweroff@38 {
+				snvs_poweroff: snvs-poweroff {
 					compatible = "fsl,sec-v4.0-poweroff";
-					reg = <0x38 0x4>;
 					status = "disabled";
 				};
 			};
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 708175d..97de407 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -662,20 +662,16 @@
 			};
 
 			snvs: snvs@020cc000 {
-				compatible = "fsl,sec-v4.0-mon", "simple-bus";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x020cc000 0x4000>;
+				compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
+				reg = <0x020cc000 0x4000>;
 
-				snvs_rtc: snvs-rtc-lp@34 {
+				snvs_rtc: snvs-rtc-lp {
 					compatible = "fsl,sec-v4.0-mon-rtc-lp";
-					reg = <0x34 0x58>;
 					interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 				};
 
-				snvs_poweroff: snvs-poweroff@38 {
+				snvs_poweroff: snvs-poweroff {
 					compatible = "fsl,sec-v4.0-poweroff";
-					reg = <0x38 0x4>;
 					status = "disabled";
 				};
 			};
diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 4aa3351..fccfc01 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -404,14 +404,11 @@
 			};
 
 			snvs0: snvs@400a7000 {
-			    compatible = "fsl,sec-v4.0-mon", "simple-bus";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x400a7000 0x2000>;
+			    compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
+				reg = <0x400a7000 0x2000>;
 
-				snvsrtc: snvs-rtc-lp@34 {
+				snvsrtc: snvs-rtc-lp {
 					compatible = "fsl,sec-v4.0-mon-rtc-lp";
-					reg = <0x34 0x58>;
 					interrupts = <100 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks VF610_CLK_SNVS>;
 					clock-names = "snvs-rtc";
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
