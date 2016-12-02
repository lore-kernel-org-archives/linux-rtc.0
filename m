Return-Path: <rtc-linux+bncBAABBU4CQ3BAKGQEXSNLOYA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com. [62.209.51.94])
        by gmr-mx.google.com with ESMTPS id l19si404513wmg.0.2016.12.02.06.12.34
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Dec 2016 06:12:34 -0800 (PST)
From: Amelie Delaunay <amelie.delaunay@st.com>
To: <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux@armlinux.org.uk>
CC: <rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <gabriel.fernandez@st.com>, <amelie.delaunay@st.com>
Subject: [rtc-linux] [PATCH 4/8] ARM: dts: stm32: Add STM32 RTC support for
 STM32F429 MCU
Date: Fri, 2 Dec 2016 15:09:57 +0100
Message-ID: <1480687801-19525-6-git-send-email-amelie.delaunay@st.com>
In-Reply-To: <1480687801-19525-2-git-send-email-amelie.delaunay@st.com>
References: <1480687801-19525-2-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This patch adds STM32 RTC bindings for STM32F429.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index d195ccf..d181025 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -125,6 +125,20 @@
 			status = "disabled";
 		};
 
+		rtc: rtc@40002800 {
+			compatible = "st,stm32-rtc";
+			reg = <0x40002800 0x400>;
+			clocks = <&rcc 1 CLK_RTC>;
+			clock-names = "ck_rtc";
+			assigned-clocks = <&rcc 1 CLK_RTC>;
+			assigned-clock-parents = <&rcc 1 CLK_LSE>;
+			interrupt-parent = <&exti>;
+			interrupts = <17 1>;
+			interrupt-names = "alarm";
+			st,syscfg = <&pwrcfg>;
+			status = "disabled";
+		};
+
 		usart2: serial@40004400 {
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40004400 0x400>;
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
