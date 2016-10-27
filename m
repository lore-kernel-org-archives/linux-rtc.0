Return-Path: <rtc-linux+bncBD66BCOYSQBBBTVOY3AAKGQEA2XOWRA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from comal.ext.ti.com (comal.ext.ti.com. [198.47.26.152])
        by gmr-mx.google.com with ESMTPS id l13si69515itl.1.2016.10.26.22.57.34
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 26 Oct 2016 22:57:34 -0700 (PDT)
From: Keerthy <j-keerthy@ti.com>
To: <alexandre.belloni@free-electrons.com>
CC: <a.zummo@towertech.it>, <rtc-linux@googlegroups.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lokeshvutla@ti.com>, <j-keerthy@ti.com>, <t-kristo@ti.com>
Subject: [rtc-linux] [PATCH 1/2] rtc: omap: Fix selecting external osc
Date: Thu, 27 Oct 2016 11:27:25 +0530
Message-ID: <1477547846-5335-1-git-send-email-j-keerthy@ti.com>
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

From: Lokesh Vutla <lokeshvutla@ti.com>

RTC can be clocked from an external 32KHz oscillator, or from the
Peripheral PLL. The RTC has an internal oscillator buffer to support
direct operation with a crystal.

            ----------------------------------------
            |       Device          ---------       |
            |                       |       |       |
            |                       | RTCSS |       |
            |       ---------       |       |       |
    OSC     |<------| RTC   |       |       |       |
            |------>| OSC   |---    |       |       |
            |       --------   |    |       |       |
            |                   ----|clk    |       |
            |       --------   |    |       |       |
            |       | PRCM  |---    |       |       |
            |       --------        --------        |
            ----------------------------------------

The RTC functional clock is sourced by default from the clock derived
from the Peripheral PLL. In order to select source as external osc clk
the following changes needs to be done:
- Enable the RTC OSC (RTC_OSC_REG[4]OSC32K_GZ = 0)
- Enable the clock mux(RTC_OSC_REG[6]K32CLK_EN = 1)
- Select the external clock source (RTC_OSC_REG[3]32KCLK_SEL = 1)

Fixes: 399cf0f63f6f2 ("rtc: omap: Add external clock enabling support")
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---

Boot tested and checked for rtc ticking on am335x-boneblack, am335x-bone
am437x-gp-evm, dra7-evm, dra72-evm.

 drivers/rtc/rtc-omap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index b04ea9b..dddaa60 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -113,6 +113,7 @@
 /* OMAP_RTC_OSC_REG bit fields: */
 #define OMAP_RTC_OSC_32KCLK_EN		BIT(6)
 #define OMAP_RTC_OSC_SEL_32KCLK_SRC	BIT(3)
+#define OMAP_RTC_OSC_OSC32K_GZ_DISABLE	BIT(4)
 
 /* OMAP_RTC_IRQWAKEEN bit fields: */
 #define OMAP_RTC_IRQWAKEEN_ALARM_WAKEEN	BIT(1)
@@ -786,8 +787,9 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	 */
 	if (rtc->has_ext_clk) {
 		reg = rtc_read(rtc, OMAP_RTC_OSC_REG);
-		rtc_write(rtc, OMAP_RTC_OSC_REG,
-			  reg | OMAP_RTC_OSC_SEL_32KCLK_SRC);
+		reg &= ~OMAP_RTC_OSC_OSC32K_GZ_DISABLE;
+		reg |= OMAP_RTC_OSC_32KCLK_EN | OMAP_RTC_OSC_SEL_32KCLK_SRC;
+		rtc_writel(rtc, OMAP_RTC_OSC_REG, reg);
 	}
 
 	rtc->type->lock(rtc);
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
