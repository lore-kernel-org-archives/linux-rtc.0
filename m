Return-Path: <rtc-linux+bncBC433LF43MBBBJXY3HAAKGQEEUOCH3A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from outils.crapouillou.net (outils.crapouillou.net. [89.234.176.41])
        by gmr-mx.google.com with ESMTPS id 18si880878wmr.0.2016.10.30.16.03.02
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Oct 2016 16:03:02 -0700 (PDT)
From: Paul Cercueil <paul@crapouillou.net>
To: rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Maarten ter Huurne <maarten@treewalker.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Cc: Paul Cercueil <paul@crapouillou.net>
Subject: [rtc-linux] [PATCH v2 2/7] Documentation: dt: Add binding info for
 jz4740-rtc driver
Date: Mon, 31 Oct 2016 00:02:42 +0100
Message-Id: <20161030230247.20538-3-paul@crapouillou.net>
In-Reply-To: <20161030230247.20538-1-paul@crapouillou.net>
References: <20161030230247.20538-1-paul@crapouillou.net>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This commit adds documentation for the device-tree bindings of the
jz4740-rtc driver, which supports the RTC unit present in the JZ4740 and
JZ4780 SoCs from Ingenic.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Maarten ter Huurne <maarten@treewalker.org>
---
 .../devicetree/bindings/rtc/ingenic,jz4740-rtc.txt | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt

v2:
- Remove 'interrupt-parent' of the list of required properties
- Add the -msec suffix for the DT entries that represent time

diff --git a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
new file mode 100644
index 0000000..df97594
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
@@ -0,0 +1,37 @@
+JZ4740 and similar SoCs real-time clock driver
+
+Required properties:
+
+- compatible: One of:
+  - "ingenic,jz4740-rtc" - for use with the JZ4740 SoC
+  - "ingenic,jz4780-rtc" - for use with the JZ4780 SoC
+- reg: Address range of rtc register set
+- interrupts: IRQ number for the alarm interrupt
+- clocks: phandle to the "rtc" clock
+- clock-names: must be "rtc"
+
+Optional properties:
+- system-power-controller: To use this component as the
+  system power controller
+- reset-pin-assert-time-msec: Reset pin low-level assertion
+  time after wakeup (default 60ms; range 0-125ms if RTC clock
+  at 32 kHz)
+- min-wakeup-pin-assert-time-msec: Minimum wakeup pin assertion
+  time (default 100ms; range 0-2s if RTC clock at 32 kHz)
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
+	reset-pin-assert-time-msec = <60>;
+	min-wakeup-pin-assert-time-msec = <100>;
+};
-- 
2.9.3

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
