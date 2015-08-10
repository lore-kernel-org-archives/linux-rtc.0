Return-Path: <rtc-linux+bncBD66BCOYSQBBBTO5UGXAKGQERWZABTI@googlegroups.com>
Received: from comal.ext.ti.com (comal.ext.ti.com. [198.47.26.152])
        by gmr-mx.google.com with ESMTPS id j6si695321igx.0.2015.08.10.02.28.45
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 02:28:45 -0700 (PDT)
From: Keerthy <j-keerthy@ti.com>
To: <tony@atomide.com>, <linux-omap@vger.kernel.org>, <pawel.moll@arm.com>
CC: <galak@codeaurora.org>, <paul@pwsan.com>,
        <alexandre.belloni@free-electrons.com>, <akpm@linux-foundation.org>,
        <johan@kernel.org>, <grygorii.strashko@ti.com>,
        <rtc-linux@googlegroups.com>, <bcousson@baylibre.com>, <nm@ti.com>,
        <devicetree@vger.kernel.org>, <t-kristo@ti.com>, <j-keerthy@ti.com>
Subject: [rtc-linux] [PATCH v2 1/6] ARM: dts: AM43XX: Add clk_32k_rtc node
Date: Mon, 10 Aug 2015 14:58:21 +0530
Message-ID: <1439198906-31189-2-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1439198906-31189-1-git-send-email-j-keerthy@ti.com>
References: <1439198906-31189-1-git-send-email-j-keerthy@ti.com>
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

Add the clk_32k_rtc this is the external clock source
for the rtc.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am43xx-clocks.dtsi | 6 ++++++
 drivers/clk/ti/clk-43xx.c            | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index d0c0dfa..31f1d96 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -159,6 +159,12 @@
 		clock-frequency = <32768>;
 	};
 
+	clk_32k_rtc: clk_32k_rtc {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+	};
+
 	clk_rc32k_ck: clk_rc32k_ck {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
diff --git a/drivers/clk/ti/clk-43xx.c b/drivers/clk/ti/clk-43xx.c
index 3795fce..af393c2 100644
--- a/drivers/clk/ti/clk-43xx.c
+++ b/drivers/clk/ti/clk-43xx.c
@@ -22,6 +22,7 @@
 static struct ti_dt_clk am43xx_clks[] = {
 	DT_CLK(NULL, "clk_32768_ck", "clk_32768_ck"),
 	DT_CLK(NULL, "clk_rc32k_ck", "clk_rc32k_ck"),
+	DT_CLK(NULL, "clk_32k_rtc", "clk_32k_rtc"),
 	DT_CLK(NULL, "virt_19200000_ck", "virt_19200000_ck"),
 	DT_CLK(NULL, "virt_24000000_ck", "virt_24000000_ck"),
 	DT_CLK(NULL, "virt_25000000_ck", "virt_25000000_ck"),
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
