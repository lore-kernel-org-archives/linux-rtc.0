Return-Path: <rtc-linux+bncBDKOBWPM5ABRBVOWUO5QKGQEEOBADSQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com. [2607:f8b0:400e:c00::241])
        by gmr-mx.google.com with ESMTPS id po17si907962pab.2.2016.06.21.00.23.01
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 00:23:01 -0700 (PDT)
Received: by mail-pf0-x241.google.com with SMTP id t190so762020pfb.2
        for <rtc-linux@googlegroups.com>; Tue, 21 Jun 2016 00:23:01 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	devicetree@vger.kernel.org,
	cphealy@gmail.com
Subject: [rtc-linux] [PATCH v2 03/17] RTC: ds1307: Add devicetree bindings for DS1341
Date: Tue, 21 Jun 2016 00:22:36 -0700
Message-Id: <1466493770-11895-2-git-send-email-andrew.smirnov@gmail.com>
In-Reply-To: <1466493770-11895-1-git-send-email-andrew.smirnov@gmail.com>
References: <1466493770-11895-1-git-send-email-andrew.smirnov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Add devicetree bindings for DS1341 that allow to control settings
affecting power consumption of the chip.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 .../devicetree/bindings/rtc/dallas,ds1341.txt      | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/dallas,ds1341.txt

diff --git a/Documentation/devicetree/bindings/rtc/dallas,ds1341.txt b/Documentation/devicetree/bindings/rtc/dallas,ds1341.txt
new file mode 100644
index 0000000..7942dd0
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/dallas,ds1341.txt
@@ -0,0 +1,23 @@
+* Dallas DS1341		I2C Serial Real-Time Clock
+
+Required properties:
+
+- compatible: Should contain "dallas,ds1341".
+
+- reg: I2C address for chip
+
+Optional properties:
+
+- dallas,disable-oscillator-stop-flag : Boolean. Configure chip to disable oscillator
+  fault detection circuitry. Setting this flag is beneficial for power saving.
+
+- dallas,enable-glitch-filter : Boolean. Configure chip to enable crystal oscillator
+  output glitch filtering. Setting this flag will increase power consumption.
+
+Example:
+	ds1341: rtc@68 {
+		compatible = "dallas,ds1341";
+		dallas,disable-oscillator-stop-flag;
+		dallas,enable-glitch-filter;
+		reg = <0x68>;
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
