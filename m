Return-Path: <rtc-linux+bncBCO3XAUMTIFRBIMMU2WAKGQEH3G6GVI@googlegroups.com>
Received: from comal.ext.ti.com (comal.ext.ti.com. [198.47.26.152])
        by gmr-mx.google.com with ESMTP id b7si4927igv.3.2015.06.23.09.15.29
        for <rtc-linux@googlegroups.com>;
        Tue, 23 Jun 2015 09:15:29 -0700 (PDT)
From: Nishanth Menon <nm@ti.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alessandro Zummo
	<a.zummo@towertech.it>
CC: <linux-kernel@vger.kernel.org>, <rtc-linux@googlegroups.com>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <balbi@ti.com>, <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [rtc-linux] [TMP PATCH V2 5/5] ARM: dts: am57xx-beagle-x15: Add
 wakeup irq for mcp79410
Date: Tue, 23 Jun 2015 11:15:14 -0500
Message-ID: <1435076114-12416-6-git-send-email-nm@ti.com>
In-Reply-To: <1435076114-12416-1-git-send-email-nm@ti.com>
References: <1435076114-12416-1-git-send-email-nm@ti.com>
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

With the support in the generic PM framework for wakeirq and capability
added to the rtc-ds1307 driver to support this, we can now define the
optional wakeup irq to allow the RTC to wakeup the system from low power
modes as part of suspend.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Please do not merge this patch -> since this needs to come via linux-omap
tree and also needs to be done with a few other changes on other peripherals.
This is meant for illustration only.

 arch/arm/boot/dts/am57xx-beagle-x15.dts |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index a42cc377a862..5c9ce2df260a 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -517,7 +517,8 @@
 	mcp_rtc: rtc@6f {
 		compatible = "microchip,mcp7941x";
 		reg = <0x6f>;
-		interrupts = <GIC_SPI 2 IRQ_TYPE_EDGE_RISING>;  /* IRQ_SYS_1N */
+		interrupts-extended = <&crossbar_mpu GIC_SPI 2 IRQ_TYPE_EDGE_RISING>,
+				      <&dra7_pmx_core 0x424>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&mcp79410_pins_default>;
-- 
1.7.9.5

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
