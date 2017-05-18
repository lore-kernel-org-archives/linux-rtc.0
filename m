Return-Path: <rtc-linux+bncBDE6RCFOWIARB66Y7DEAKGQEFNZWSSA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id v194si1672517wmv.3.2017.05.18.16.21.31
        for <rtc-linux@googlegroups.com>;
        Thu, 18 May 2017 16:21:31 -0700 (PDT)
Received: from localhost (unknown [88.191.26.124])
	by mail.free-electrons.com (Postfix) with ESMTPSA id B987320DF1
	for <rtc-linux@googlegroups.com>; Fri, 19 May 2017 01:21:28 +0200 (CEST)
Resent-Message-ID: <20170518232129.z45lopsfg52m46n3@piout.net>
From: Linus Walleij <linus.walleij@linaro.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-rtc@vger.kernel.org
Cc: Janos Laube <janos.dev@gmail.com>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org,
	Po-Yu Chuang <ratbert@faraday-tech.com>
Subject: [rtc-linux] [PATCH 2/3] rtc: gemini: Augment DT bindings for Faraday
Date: Thu, 18 May 2017 23:56:34 +0200
Message-Id: <20170518215635.13505-2-linus.walleij@linaro.org>
In-Reply-To: <20170518215635.13505-1-linus.walleij@linaro.org>
References: <20170518215635.13505-1-linus.walleij@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The Gemini RTC is actually a standard IP block from Faraday
Technology called FTRTC010. Rename the bindings, add the
generic compatible string and add definitions for the two
available clocks.

Cc: devicetree@vger.kernel.org
Cc: Po-Yu Chuang <ratbert@faraday-tech.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/rtc/cortina,gemini.txt     | 14 -----------
 .../devicetree/bindings/rtc/faraday,ftrtc010.txt   | 28 ++++++++++++++++++++++
 2 files changed, 28 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/cortina,gemini.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt

diff --git a/Documentation/devicetree/bindings/rtc/cortina,gemini.txt b/Documentation/devicetree/bindings/rtc/cortina,gemini.txt
deleted file mode 100644
index 4ce4e794ddbb..000000000000
--- a/Documentation/devicetree/bindings/rtc/cortina,gemini.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-* Cortina Systems Gemini RTC
-
-Gemini SoC real-time clock.
-
-Required properties:
-- compatible : Should be "cortina,gemini-rtc"
-
-Examples:
-
-rtc@45000000 {
-	compatible = "cortina,gemini-rtc";
-	reg = <0x45000000 0x100>;
-	interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
-};
diff --git a/Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt b/Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt
new file mode 100644
index 000000000000..e3938f5e0b6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt
@@ -0,0 +1,28 @@
+* Faraday Technology FTRTC010 Real Time Clock
+
+This RTC appears in for example the Storlink Gemini family of
+SoCs.
+
+Required properties:
+- compatible : Should be one of:
+  "faraday,ftrtc010"
+  "cortina,gemini-rtc", "faraday,ftrtc010"
+
+Optional properties:
+- clocks: when present should contain clock references to the
+  PCLK and EXTCLK clocks. Faraday calls the later CLK1HZ and
+  says the clock should be 1 Hz, but implementers actually seem
+  to choose different clocks here, like Cortina who chose
+  32768 Hz (a typical low-power clock).
+- clock-names: should name the clocks "PCLK" and "EXTCLK"
+  respectively.
+
+Examples:
+
+rtc@45000000 {
+	compatible = "cortina,gemini-rtc";
+	reg = <0x45000000 0x100>;
+	interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&foo 0>, <&foo 1>;
+	clock-names = "PCLK", "EXTCLK";
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
