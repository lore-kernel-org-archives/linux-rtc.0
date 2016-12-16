Return-Path: <rtc-linux+bncBAABBCWWZ3BAKGQEKGIUPQA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com. [91.207.212.93])
        by gmr-mx.google.com with ESMTPS id h23si195469wmi.1.2016.12.16.00.51.21
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Dec 2016 00:51:21 -0800 (PST)
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni
	<alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>
CC: <rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        Amelie Delaunay
	<amelie.delaunay@st.com>
Subject: [rtc-linux] [PATCHv2 2/8] dt-bindings: document the STM32 RTC bindings
Date: Fri, 16 Dec 2016 09:50:51 +0100
Message-ID: <1481878257-29163-3-git-send-email-amelie.delaunay@st.com>
In-Reply-To: <1481878257-29163-1-git-send-email-amelie.delaunay@st.com>
References: <1481878257-29163-1-git-send-email-amelie.delaunay@st.com>
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

This patch adds documentation of device tree bindings for the STM32 RTC.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
new file mode 100644
index 0000000..e2837b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
@@ -0,0 +1,27 @@
+STM32 Real Time Clock
+
+Required properties:
+- compatible: "st,stm32-rtc".
+- reg: address range of rtc register set.
+- clocks: reference to the clock entry ck_rtc.
+- interrupt-parent: phandle for the interrupt controller.
+- interrupts: rtc alarm interrupt.
+- st,syscfg: phandle for pwrcfg, mandatory to disable/enable backup domain
+  (RTC registers) write protection.
+
+Optional properties (to override default ck_rtc parent clock):
+- assigned-clocks: reference to the ck_rtc clock entry.
+- assigned-clock-parents: phandle of the new parent clock of ck_rtc.
+
+Example:
+
+	rtc: rtc@40002800 {
+		compatible = "st,stm32-rtc";
+		reg = <0x40002800 0x400>;
+		clocks = <&rcc 1 CLK_RTC>;
+		assigned-clocks = <&rcc 1 CLK_RTC>;
+		assigned-clock-parents = <&rcc 1 CLK_LSE>;
+		interrupt-parent = <&exti>;
+		interrupts = <17 1>;
+		st,syscfg = <&pwrcfg>;
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
