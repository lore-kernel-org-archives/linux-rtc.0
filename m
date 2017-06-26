Return-Path: <rtc-linux+bncBC2IT2GSZUDRBMNSYPFAKGQEGEHIKQA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com. [62.209.51.94])
        by gmr-mx.google.com with ESMTPS id y17si1940352wmh.3.2017.06.26.02.51.45
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 02:51:45 -0700 (PDT)
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni
	<alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: <rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [rtc-linux] [PATCH 1/2] dt-bindings: rtc: stm32: add support for STM32H7
Date: Mon, 26 Jun 2017 11:51:28 +0200
Message-ID: <1498470689-26829-2-git-send-email-amelie.delaunay@st.com>
In-Reply-To: <1498470689-26829-1-git-send-email-amelie.delaunay@st.com>
References: <1498470689-26829-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This patch documents support for STM32H7 Real Time Clock.
It introduces a new compatible and rework clock definitions.
On STM32H7 we have a 'pclk' clock for register access, in addition to
the 'rtc_ck' clock.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 32 ++++++++++++++++++----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
index e2837b9..0a4c371 100644
--- a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
@@ -1,17 +1,25 @@
 STM32 Real Time Clock
 
 Required properties:
-- compatible: "st,stm32-rtc".
+- compatible: can be either "st,stm32-rtc" or "st,stm32h7-rtc", depending on
+  the device is compatible with stm32(f4/f7) or stm32h7.
 - reg: address range of rtc register set.
-- clocks: reference to the clock entry ck_rtc.
+- clocks: can use up to two clocks, depending on part used:
+  - "rtc_ck": RTC clock source.
+    It is required on stm32(f4/f7) and stm32h7.
+  - "pclk": RTC APB interface clock.
+    It is not present on stm32(f4/f7).
+    It is required on stm32h7.
+- clock-names: must be "rtc_ck" and "pclk".
+    It is required only on stm32h7.
 - interrupt-parent: phandle for the interrupt controller.
 - interrupts: rtc alarm interrupt.
 - st,syscfg: phandle for pwrcfg, mandatory to disable/enable backup domain
   (RTC registers) write protection.
 
-Optional properties (to override default ck_rtc parent clock):
-- assigned-clocks: reference to the ck_rtc clock entry.
-- assigned-clock-parents: phandle of the new parent clock of ck_rtc.
+Optional properties (to override default rtc_ck parent clock):
+- assigned-clocks: reference to the rtc_ck clock entry.
+- assigned-clock-parents: phandle of the new parent clock of rtc_ck.
 
 Example:
 
@@ -25,3 +33,17 @@ Example:
 		interrupts = <17 1>;
 		st,syscfg = <&pwrcfg>;
 	};
+
+	rtc: rtc@58004000 {
+		compatible = "st,stm32h7-rtc";
+		reg = <0x58004000 0x400>;
+		clocks = <&rcc RTCAPB_CK>, <&rcc RTC_CK>;
+		clock-names = "pclk", "rtc_ck";
+		assigned-clocks = <&rcc RTC_CK>;
+		assigned-clock-parents = <&rcc LSE_CK>;
+		interrupt-parent = <&exti>;
+		interrupts = <17 1>;
+		interrupt-names = "alarm";
+		st,syscfg = <&pwrcfg>;
+		status = "disabled";
+	};
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
