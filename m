Return-Path: <rtc-linux+bncBDS7HNEFSALRB5UE5WWQKGQENWUBZYY@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c3si120139wiz.2.2015.07.31.02.40.06
        for <rtc-linux@googlegroups.com>;
        Fri, 31 Jul 2015 02:40:06 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 04/23] Documentation: dt: rtc: at91rm9200: add
 clocks property
Date: Fri, 31 Jul 2015 11:39:40 +0200
Message-Id: <1438335599-3301-5-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

The RTC needs an input clock, it is the slow clock. It is required as it
will not function without it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com
 Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
index 34c1505774bf..5d3791e789c6 100644
--- a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
@@ -5,6 +5,7 @@ Required properties:
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: rtc alarm/event interrupt
+- clocks: phandle to input clock.
 
 Example:
 
@@ -12,4 +13,5 @@ rtc@fffffe00 {
 	compatible = "atmel,at91rm9200-rtc";
 	reg = <0xfffffe00 0x100>;
 	interrupts = <1 4 7>;
+	clocks = <&clk32k>;
 };
-- 
2.1.4

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
