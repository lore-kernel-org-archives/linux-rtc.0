Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:38047 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753111AbdI0ODu (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 27 Sep 2017 10:03:50 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 1/6] dt-bindings: trivial: Add RTCs
Date: Wed, 27 Sep 2017 16:03:40 +0200
Message-Id: <20170927140345.5537-2-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170927140345.5537-1-alexandre.belloni@free-electrons.com>
References: <20170927140345.5537-1-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Add remaining trivial RTC bindings.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 Documentation/devicetree/bindings/trivial-devices.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index aae37352c574..d0666acdec66 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -41,6 +41,7 @@ dallas,ds1338		I2C RTC with 56-Byte NV RAM
 dallas,ds1340		I2C RTC with Trickle Charger
 dallas,ds1374		I2C, 32-Bit Binary Counter Watchdog RTC with Trickle Charger and Reset Input/Output
 dallas,ds1631		High-Precision Digital Thermometer
+dallas,ds1672		Dallas DS1672 Real-time Clock
 dallas,ds1682		Total-Elapsed-Time Recorder with Alarm
 dallas,ds1775		Tiny Digital Thermometer and Thermostat
 dallas,ds3232		Extremely Accurate I²C RTC with Integrated Crystal and SRAM
@@ -56,6 +57,7 @@ domintech,dmard10	DMARD10: 3-axis Accelerometer
 epson,rx8010		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
 epson,rx8025		High-Stability. I2C-Bus INTERFACE REAL TIME CLOCK MODULE
 epson,rx8581		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
+emmicro,em3027		EM Microelectronic EM3027 Real-time Clock
 fsl,mag3110		MAG3110: Xtrinsic High Accuracy, 3D Magnetometer
 fsl,mc13892		MC13892: Power Management Integrated Circuit (PMIC) for i.MX35/51
 fsl,mma7660		MMA7660FC: 3-Axis Orientation/Motion Detection Sensor
@@ -67,6 +69,8 @@ gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire In
 infineon,slb9635tt	Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
 infineon,slb9645tt	Infineon SLB9645 I2C TPM (new protocol, max 400khz)
 isil,isl1208		Intersil ISL1208 Low Power RTC with Battery Backed SRAM
+isil,isl1218		Intersil ISL1218 Low Power RTC with Battery Backed SRAM
+isil,isl12022		Intersil ISL12022 Real-time Clock
 isil,isl29028		Intersil ISL29028 Ambient Light and Proximity Sensor
 isil,isl29030		Intersil ISL29030 Ambient Light and Proximity Sensor
 maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
@@ -155,6 +159,7 @@ nxp,pca9556		Octal SMBus and I2C registered interface
 nxp,pca9557		8-bit I2C-bus and SMBus I/O port with reset
 nxp,pcf2127		Real-time clock
 nxp,pcf2129		Real-time clock
+nxp,pcf8523		Real-time Clock
 nxp,pcf8563		Real-time clock/calendar
 nxp,pcf85063		Tiny Real-Time Clock
 oki,ml86v7667		OKI ML86V7667 video decoder
-- 
2.14.2
