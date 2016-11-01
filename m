Return-Path: <rtc-linux+bncBAABBFGH4HAAKGQE4CLZM2Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from relay1.mentorg.com (relay1.mentorg.com. [192.94.38.131])
        by gmr-mx.google.com with ESMTPS id ua1si336727pac.0.2016.11.01.02.42.44
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Nov 2016 02:42:44 -0700 (PDT)
From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
To: <devicetree@vger.kernel.org>
CC: <rtc-linux@googlegroups.com>, <linux-omap@vger.kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alessandro Zummo
	<a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, Nicolae Rosia
	<Nicolae_Rosia@mentor.com>
Subject: [rtc-linux] [PATCH] Documentation: bindings: fix twl-rtc documentation
Date: Tue, 1 Nov 2016 11:42:36 +0200
Message-ID: <1477993356-9195-1-git-send-email-Nicolae_Rosia@mentor.com>
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

Add interrupts documentation
Fix example and formatting

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
---
 Documentation/devicetree/bindings/rtc/twl-rtc.txt | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/twl-rtc.txt b/Documentation/devicetree/bindings/rtc/twl-rtc.txt
index 596e0c9..8f9a94f 100644
--- a/Documentation/devicetree/bindings/rtc/twl-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/twl-rtc.txt
@@ -1,12 +1,11 @@
-* TI twl RTC
-
-The TWL family (twl4030/6030) contains a RTC.
+* Texas Instruments TWL4030/6030 RTC
 
 Required properties:
-- compatible : Should be twl4030-rtc
-
-Examples:
-
-rtc@0 {
-    compatible = "ti,twl4030-rtc";
-};
+- compatible : Should be "ti,twl4030-rtc"
+- interrupts : Should be the interrupt number.
+
+Example:
+	rtc {
+		compatible = "ti,twl4030-rtc";
+		interrupts = <11>;
+	};
-- 
2.5.5

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
