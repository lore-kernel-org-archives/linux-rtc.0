Return-Path: <rtc-linux+bncBAABBIHUXS3AKGQEJ2LSX2A@googlegroups.com>
Received: from email.microchip.com (exsmtp01.microchip.com. [198.175.253.37])
        by gmr-mx.google.com with ESMTPS id 79si1399143pft.0.2016.02.25.09.30.08
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 09:30:08 -0800 (PST)
From: Joshua Henderson <joshua.henderson@microchip.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Joshua Henderson <joshua.henderson@microchip.com>, Rob Herring
	<robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland
	<mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
 Gala <galak@codeaurora.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	<rtc-linux@googlegroups.com>
Subject: [rtc-linux] [PATCH v3 1/2] dt/bindings: Add bindings for the PIC32
 real time clock
Date: Thu, 25 Feb 2016 10:30:43 -0700
Message-ID: <1456421449-18225-1-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Document the devicetree bindings for the real time clock found
on Microchip PIC32 class devices.

Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
--
Changes since v2: None
Changes since v1: None
---
 .../bindings/rtc/microchip,pic32-rtc.txt           |   21 ++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/microchip,pic32-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/microchip,pic32-rtc.txt b/Documentation/devicetree/bindings/rtc/microchip,pic32-rtc.txt
new file mode 100644
index 0000000..180b714
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/microchip,pic32-rtc.txt
@@ -0,0 +1,21 @@
+* Microchip PIC32 Real Time Clock and Calendar
+
+The RTCC keeps time in hours, minutes, and seconds, and one half second. It
+provides a calendar in weekday, date, month, and year. It also provides a
+configurable alarm.
+
+Required properties:
+- compatible: should be: "microchip,pic32mzda-rtc"
+- reg: physical base address of the controller and length of memory mapped
+    region.
+- interrupts: RTC alarm/event interrupt
+- clocks: clock phandle
+
+Example:
+
+	rtc: rtc@1f8c0000 {
+		compatible = "microchip,pic32mzda-rtc";
+		reg = <0x1f8c0000 0x60>;
+		interrupts = <166 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&PBCLK6>;
+	};
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
