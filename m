Return-Path: <rtc-linux+bncBDQJZJXU2UMBB2ETYS2QKGQESVBDKYY@googlegroups.com>
MIME-Version: 1.0
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id e130si448255wme.2.2016.02.02.11.56.23
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Feb 2016 11:56:23 -0800 (PST)
From: Oleksij Rempel <linux@rempel-privat.de>
To: devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Oleksij Rempel <linux@rempel-privat.de>
Subject: [rtc-linux] [PATCH v2 2/2] doc: dt: add documentation for alphascale,asm9260-rtc
Date: Tue,  2 Feb 2016 20:56:11 +0100
Message-Id: <1454442971-25225-3-git-send-email-linux@rempel-privat.de>
In-Reply-To: <1454442971-25225-1-git-send-email-linux@rempel-privat.de>
References: <20160202102804.GT20165@piout.net>
 <1454442971-25225-1-git-send-email-linux@rempel-privat.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Document Alphascale asm9260 RTC bindings

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
---
 .../bindings/rtc/alphascale,asm9260-rtc.txt           | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.txt b/Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.txt
new file mode 100644
index 0000000..76ebca5
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.txt
@@ -0,0 +1,19 @@
+* Alphascale asm9260 SoC Real Time Clock
+
+Required properties:
+- compatible: Should be "alphascale,asm9260-rtc"
+- reg: Physical base address of the controller and length
+       of memory mapped region.
+- interrupts: IRQ line for the RTC.
+- clocks: Reference to the clock entry.
+- clock-names: should contain:
+  * "ahb" for the SoC RTC clock
+
+Example:
+rtc0: rtc@800a0000 {
+	compatible = "alphascale,asm9260-rtc";
+	reg = <0x800a0000 0x100>;
+	clocks = <&acc CLKID_AHB_RTC>;
+	clock-names = "ahb";
+	interrupts = <2>;
+};
-- 
2.5.0

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
