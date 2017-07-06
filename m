Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:48748 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbdGFJfs (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 6 Jul 2017 05:35:48 -0400
Received: from localhost (unknown [88.191.26.124])
        by mail.free-electrons.com (Postfix) with ESMTPSA id B04F32091B
        for <linux-rtc@vger.kernel.org>; Thu,  6 Jul 2017 11:35:43 +0200 (CEST)
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: <rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCHv2 1/2] dt-bindings: rtc: stm32: add support for STM32H7
Date: Thu, 6 Jul 2017 10:47:44 +0200
Message-ID: <1499330865-17232-2-git-send-email-amelie.delaunay@st.com>
In-Reply-To: <1499330865-17232-1-git-send-email-amelie.delaunay@st.com>
References: <1499330865-17232-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>
Message-ID: <20170706084744.sihxsaGhV-L1BS7UMmBJ0LP7rLLh0pY03bCBrBcyZVU@z>

This patch documents support for STM32H7 Real Time Clock.
It introduces a new compatible and rework clock definitions.
On STM32H7 we have a 'pclk' clock for register access, in addition to
the 'rtc_ck' clock.

Acked-by: Rob Herring <robh@kernel.org>
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
