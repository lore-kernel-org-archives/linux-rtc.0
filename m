Return-Path: <rtc-linux+bncBC433LF43MBBBI6A5W3AKGQEXI7H4OQ@googlegroups.com>
MIME-Version: 1.0
Received: from outils.crapouillou.net (rev33.vpn.fdn.fr. [80.67.179.33])
        by gmr-mx.google.com with ESMTPS id w10si145256wmw.3.2016.03.05.14.39.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Mar 2016 14:39:31 -0800 (PST)
From: Paul Cercueil <paul@crapouillou.net>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Paul Cercueil <paul@crapouillou.net>,
	Paul Burton <paul.burton@imgtec.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 2/5] Documentation: dt: Add binding info for
 jz4740-rtc driver
Date: Sat,  5 Mar 2016 23:38:48 +0100
Message-Id: <1457217531-26064-2-git-send-email-paul@crapouillou.net>
In-Reply-To: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
References: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
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

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../devicetree/bindings/rtc/ingenic,jz4740-rtc.txt | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
new file mode 100644
index 0000000..71e4ad0
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
@@ -0,0 +1,38 @@
+JZ4740 and similar SoCs real-time clock driver
+
+Required properties:
+
+- compatible: One of:
+  - "ingenic,jz4740-rtc" - for use with the JZ4740 SoC
+  - "ingenic,jz4780-rtc" - for use with the JZ4780 SoC
+- reg: Address range of rtc register set
+- interrupts: IRQ number for the alarm interrupt
+- interrupt-parent: phandle of the interrupt controller
+- clocks: phandle to the "rtc" clock
+- clock-names: must be "rtc"
+
+Optional properties:
+- system-power-controller: To use this component as the
+  system power controller
+- reset-pin-assert-time: Reset pin low-level assertion time
+  after wakeup (default 60ms; range 0-125ms if RTC clock at 
+  32 kHz)
+- min-wakeup-pin-assert-time: Minimum wakeup pin assertion time
+  (default 100ms; range 0-2s if RTC clock at 32 kHz)
+
+Example:
+
+rtc@10003000 {
+	compatible = "ingenic,jz4740-rtc";
+	reg = <0x10003000 0x3F>;
+
+	interrupt-parent = <&intc>;
+	interrupts = <32>;
+
+	clocks = <&rtc_clock>;
+	clock-names = "rtc";
+
+	system-power-controller;
+	reset-pin-assert-time = <60>;
+	min-wakeup-pin-assert-time = <100>;
+};
-- 
2.7.0

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
