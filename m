Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:38058 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753142AbdI0ODv (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 27 Sep 2017 10:03:51 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 4/6] dt-bindings: rtc: DS1307 and compatibles are not trivial
Date: Wed, 27 Sep 2017 16:03:43 +0200
Message-Id: <20170927140345.5537-5-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170927140345.5537-1-alexandre.belloni@free-electrons.com>
References: <20170927140345.5537-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Document optional properties for ds1307 and compatible RTCs

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 .../devicetree/bindings/rtc/rtc-ds1307.txt         | 36 ++++++++++++++++++++++
 .../devicetree/bindings/trivial-devices.txt        |  6 ----
 2 files changed, 36 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-ds1307.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt b/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
new file mode 100644
index 000000000000..c010f18a85a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
@@ -0,0 +1,36 @@
+Dallas DS1307 and compatible RTC
+
+Required properties:
+- compatible: should be one of:
+	"dallas,ds1307",
+	"dallas,ds1308",
+	"dallas,ds1337",
+	"dallas,ds1338",
+	"dallas,ds1339",
+	"dallas,ds1388",
+	"dallas,ds1340",
+	"dallas,ds1341",
+	"maxim,ds3231",
+	"st,m41t0",
+	"st,m41t00",
+	"microchip,mcp7940x",
+	"microchip,mcp7941x",
+	"pericom,pt7c4338",
+	"epson,rx8025",
+	"isil,isl12057"
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
+	rtc1: ds1339@68 {
+		compatible = "dallas,ds1339";
+		reg = <0x68>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <20 0>;
+	};
diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index d0666acdec66..db7dc1edd4a2 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -36,9 +36,6 @@ atmel,at97sc3204t	i2c trusted platform module (TPM)
 capella,cm32181		CM32181: Ambient Light Sensor
 capella,cm3232		CM3232: Ambient Light Sensor
 cirrus,cs42l51		Cirrus Logic CS42L51 audio codec
-dallas,ds1307		64 x 8, Serial, I2C Real-Time Clock
-dallas,ds1338		I2C RTC with 56-Byte NV RAM
-dallas,ds1340		I2C RTC with Trickle Charger
 dallas,ds1374		I2C, 32-Bit Binary Counter Watchdog RTC with Trickle Charger and Reset Input/Output
 dallas,ds1631		High-Precision Digital Thermometer
 dallas,ds1672		Dallas DS1672 Real-time Clock
@@ -55,7 +52,6 @@ dlg,da9063		DA9063: system PMIC for quad-core application processors
 domintech,dmard09	DMARD09: 3-axis Accelerometer
 domintech,dmard10	DMARD10: 3-axis Accelerometer
 epson,rx8010		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
-epson,rx8025		High-Stability. I2C-Bus INTERFACE REAL TIME CLOCK MODULE
 epson,rx8581		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
 emmicro,em3027		EM Microelectronic EM3027 Real-time Clock
 fsl,mag3110		MAG3110: Xtrinsic High Accuracy, 3D Magnetometer
@@ -179,8 +175,6 @@ sii,s35390a		2-wire CMOS real-time clock
 silabs,si7020		Relative Humidity and Temperature Sensors
 skyworks,sky81452	Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
 st,24c256		i2c serial eeprom  (24cxx)
-st,m41t0		Serial real-time clock (RTC)
-st,m41t00		Serial real-time clock (RTC)
 st,m41t62		Serial real-time clock (RTC) with alarm
 st,m41t80		M41T80 - SERIAL ACCESS RTC WITH ALARMS
 taos,tsl2550		Ambient Light Sensor with SMBUS/Two Wire Serial Interface
-- 
2.14.2
