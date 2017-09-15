Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53173 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbdIOBqK (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 14 Sep 2017 21:46:10 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] dt-bindings: RTC: Add bindings for m41t80 and compatibles
Date: Fri, 15 Sep 2017 03:45:50 +0200
Message-Id: <20170915014551.22664-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The ST M41T80 family of RTC are not trivial devices, document them.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 .../devicetree/bindings/rtc/rtc-m41t80.txt         | 32 ++++++++++++++++++++++
 .../devicetree/bindings/trivial-devices.txt        |  2 --
 2 files changed, 32 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-m41t80.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-m41t80.txt b/Documentation/devicetree/bindings/rtc/rtc-m41t80.txt
new file mode 100644
index 000000000000..12add61e5687
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-m41t80.txt
@@ -0,0 +1,32 @@
+ST M41T80 family of RTC and compatible
+
+Required properties:
+- compatible: should be one of:
+	"st,m41t62",
+	"st,m41t65",
+	"st,m41t80",
+	"st,m41t81",
+	"st,m41t81s",
+	"st,m41t82",
+	"st,m41t83",
+	"st,m41t84",
+	"st,m41t85",
+	"st,m41t87",
+	"microcrystal,rv4162",
+- reg: I2C bus address of the device
+
+Optional properties:
+- interrupt-parent: phandle for the interrupt controller.
+- interrupts: rtc alarm interrupt.
+- clock-output-names: From common clock binding to override the default output
+                      clock name
+- wakeup-source: Enables wake up of host system on alarm
+
+Example:
+	rtc@68 {
+		compatible = "st,m41t80";
+		reg = <0x68>;
+		interrupt-parent = <&UIC0>;
+		interrupts = <0x9 0x8>;
+	};
+
diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index 4353151367a1..4b169caab0eb 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -175,8 +175,6 @@ sii,s35390a		2-wire CMOS real-time clock
 silabs,si7020		Relative Humidity and Temperature Sensors
 skyworks,sky81452	Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
 st,24c256		i2c serial eeprom  (24cxx)
-st,m41t62		Serial real-time clock (RTC) with alarm
-st,m41t80		M41T80 - SERIAL ACCESS RTC WITH ALARMS
 taos,tsl2550		Ambient Light Sensor with SMBUS/Two Wire Serial Interface
 ti,ads7828		8-Channels, 12-bit ADC
 ti,ads7830		8-Channels, 8-bit ADC
-- 
2.14.1
