Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:38067 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753264AbdI0ODv (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 27 Sep 2017 10:03:51 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 6/6] dt-bindings: rtc: merge ds1339 in ds1307 documentation
Date: Wed, 27 Sep 2017 16:03:45 +0200
Message-Id: <20170927140345.5537-7-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170927140345.5537-1-alexandre.belloni@free-electrons.com>
References: <20170927140345.5537-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Now that there is documentation for the ds1307 and compatible RTCs, merge
the ds1339 documentation in it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 .../devicetree/bindings/rtc/dallas,ds1339.txt          | 18 ------------------
 Documentation/devicetree/bindings/rtc/rtc-ds1307.txt   |  8 ++++++++
 2 files changed, 8 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/dallas,ds1339.txt

diff --git a/Documentation/devicetree/bindings/rtc/dallas,ds1339.txt b/Documentation/devicetree/bindings/rtc/dallas,ds1339.txt
deleted file mode 100644
index 916f57601a8f..000000000000
--- a/Documentation/devicetree/bindings/rtc/dallas,ds1339.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-* Dallas DS1339		I2C Serial Real-Time Clock
-
-Required properties:
-- compatible: Should contain "dallas,ds1339".
-- reg: I2C address for chip
-
-Optional properties:
-- trickle-resistor-ohms : Selected resistor for trickle charger
-	Values usable for ds1339 are 250, 2000, 4000
-	Should be given if trickle charger should be enabled
-- trickle-diode-disable : Do not use internal trickle charger diode
-	Should be given if internal trickle charger diode should be disabled
-Example:
-	ds1339: rtc@68 {
-		compatible = "dallas,ds1339";
-		trickle-resistor-ohms = <250>;
-		reg = <0x68>;
-	};
diff --git a/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt b/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
index c010f18a85a0..d28d6e7f6ae8 100644
--- a/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
@@ -26,6 +26,13 @@ Optional properties:
 - clock-output-names: From common clock binding to override the default output
                       clock name
 - wakeup-source: Enables wake up of host system on alarm
+- trickle-resistor-ohms : ds1339, ds1340 and ds 1388 only
+	Selected resistor for trickle charger
+	Possible values are 250, 2000, 4000
+	Should be given if trickle charger should be enabled
+- trickle-diode-disable : ds1339, ds1340 and ds 1388 only
+	Do not use internal trickle charger diode
+	Should be given if internal trickle charger diode should be disabled
 
 Example:
 	rtc1: ds1339@68 {
@@ -33,4 +40,5 @@ Example:
 		reg = <0x68>;
 		interrupt-parent = <&gpio4>;
 		interrupts = <20 0>;
+		trickle-resistor-ohms = <250>;
 	};
-- 
2.14.2
