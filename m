Return-Path: <rtc-linux+bncBAABBW6VXHBQKGQESRV5WEQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com. [91.207.212.93])
        by gmr-mx.google.com with ESMTPS id o77si6314978wme.0.2017.01.05.05.44.09
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jan 2017 05:44:09 -0800 (PST)
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
Subject: [rtc-linux] [PATCHv3 1/8] ARM: dts: stm32: set HSE_RTC clock
 frequency to 1 MHz on stm32f429
Date: Thu, 5 Jan 2017 14:43:22 +0100
Message-ID: <1483623809-29937-2-git-send-email-amelie.delaunay@st.com>
In-Reply-To: <1483623809-29937-1-git-send-email-amelie.delaunay@st.com>
References: <1483623809-29937-1-git-send-email-amelie.delaunay@st.com>
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

This patch set HSE_RTC clock frequency to 1 MHz, as the clock supplied to
the RTC must be 1 MHz.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index b077f99..d195ccf 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -371,6 +371,8 @@
 			reg = <0x40023800 0x400>;
 			clocks = <&clk_hse>, <&clk_i2s_ckin>;
 			st,syscfg = <&pwrcfg>;
+			assigned-clocks = <&rcc 1 CLK_HSE_RTC>;
+			assigned-clock-rates = <1000000>;
 		};
 
 		dma1: dma-controller@40026000 {
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
