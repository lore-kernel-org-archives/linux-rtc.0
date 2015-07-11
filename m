Return-Path: <rtc-linux+bncBCF2PQPV4MDRBAVFQWWQKGQEB47PRAA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-lb0-x229.google.com (mail-lb0-x229.google.com. [2a00:1450:4010:c04::229])
        by gmr-mx.google.com with ESMTPS id h8si374083lbd.3.2015.07.11.10.29.37
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Jul 2015 10:29:37 -0700 (PDT)
Received: by lbbyj8 with SMTP id yj8so21888742lbb.0
        for <rtc-linux@googlegroups.com>; Sat, 11 Jul 2015 10:29:37 -0700 (PDT)
From: Joachim Eastwood <manabian@gmail.com>
To: alexandre.belloni@free-electrons.com,
	a.zummo@towertech.it
Cc: Joachim Eastwood <manabian@gmail.com>,
	joshc@ni.com,
	rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH v3 2/2] doc: dt: add documentation for nxp,lpc1788-rtc
Date: Sat, 11 Jul 2015 19:28:50 +0200
Message-Id: <1436635730-15617-3-git-send-email-manabian@gmail.com>
In-Reply-To: <1436635730-15617-1-git-send-email-manabian@gmail.com>
References: <1436635730-15617-1-git-send-email-manabian@gmail.com>
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

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../devicetree/bindings/rtc/nxp,lpc1788-rtc.txt     | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.txt b/Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.txt
new file mode 100644
index 000000000000..ad41a040432c
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.txt
@@ -0,0 +1,21 @@
+NXP LPC1788 real-time clock
+
+The LPC1788 RTC provides calendar and clock functionality
+together with periodic tick and alarm interrupt support.
+
+Required properties:
+- compatible	: must contain "nxp,lpc1788-rtc"
+- reg		: Specifies base physical address and size of the registers.
+- interrupts	: A single interrupt specifier.
+- clocks	: Must contain entries for rtc and register clock
+- clock-names	: Must contain "rtc" and "reg"
+  See ../clocks/clock-bindings.txt for details.
+
+Example:
+rtc: rtc@40046000 {
+	compatible = "nxp,lpc1788-rtc";
+	reg = <0x40046000 0x1000>;
+	interrupts = <47>;
+	clocks = <&creg_clk 0>, <&ccu1 CLK_CPU_BUS>;
+	clock-names = "rtc", "reg";
+};
-- 
1.8.0

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
