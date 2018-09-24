Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-db5eur01on0075.outbound.protection.outlook.com ([104.47.2.75]:24352
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726074AbeIXRZf (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 24 Sep 2018 13:25:35 -0400
From: =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bbv.ch>
To: a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        lukas.stockmann@siemens.com, pascal.bach@siemens.com,
        urs.fassler@bbv.ch
Subject: [PATCH 1/2] dt-bindings: rtc: add capacitor selection for pcf85063
Date: Mon, 24 Sep 2018 13:23:39 +0200
Message-Id: <20180924112340.2685-1-urs.fassler@bbv.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Add a device tree property to configure the used capacitor for the
oscillator.

Signed-off-by: Urs Fässler <urs.fassler@bbv.ch>
Signed-off-by: Lukas Stockmann <lukas.stockmann@siemens.com>
Signed-off-by: Pascal Bach <pascal.bach@siemens.com>
---
 .../devicetree/bindings/rtc/pcf85063.txt      | 20 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.txt   |  1 -
 2 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/pcf85063.txt

diff --git a/Documentation/devicetree/bindings/rtc/pcf85063.txt b/Documentation/devicetree/bindings/rtc/pcf85063.txt
new file mode 100644
index 000000000000..e987d1042545
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/pcf85063.txt
@@ -0,0 +1,20 @@
+NXP PCF85063 Tiny Real Time Clock
+=================================
+
+Required properties:
+- compatible: should contain "nxp,pcf85063".
+- reg: I2C address for chip.
+
+Optional properties:
+- cap-sel: internal oscillator capacitor selection. Possible values are:
+	- 0: 7 pF
+	- 1: 12.5 pF
+	The selection is not changed if the property is not specified.
+
+Example:
+
+pcf85063: pcf85063@51 {
+	compatible = "nxp,pcf85063";
+	reg = <0x51>;
+	cap-sel = <1>;
+};
diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index 763a2808a95c..abd3a818fb40 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -171,7 +171,6 @@ nxp,pcf2127		Real-time clock
 nxp,pcf2129		Real-time clock
 nxp,pcf8523		Real-time Clock
 nxp,pcf8563		Real-time clock/calendar
-nxp,pcf85063		Tiny Real-Time Clock
 oki,ml86v7667		OKI ML86V7667 video decoder
 ovti,ov5642		OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with OmniBSI and Embedded TrueFocus
 pericom,pt7c4338	Real-time Clock Module
-- 
2.18.0
