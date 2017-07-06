Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36603 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbdGFUk3 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 6 Jul 2017 16:40:29 -0400
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] rtc: ds1307: remove legacy check for
 "isil,irq2-can-wakeup-machine" property
Message-ID: <ff4ea92b-4af3-1a59-2ea3-056a43125c20@gmail.com>
Date: Thu, 6 Jul 2017 22:40:03 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Commit 8b44f5be20fd ("ARM: dts: armada: replace isil,irq2-can-wakeup-machine with wakeup-source property")
removed the last usage of "isil,irq2-can-wakeup-machine" almost
two years ago. So I think we can get rid of supporting this
legacy binding.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 Documentation/devicetree/bindings/power/wakeup-source.txt | 9 ++++-----
 Documentation/devicetree/bindings/rtc/isil,isl12057.txt   | 1 -
 drivers/rtc/rtc-ds1307.c                                  | 8 +-------
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/wakeup-source.txt b/Documentation/devicetree/bindings/power/wakeup-source.txt
index 963c6dfd..3c81f78b 100644
--- a/Documentation/devicetree/bindings/power/wakeup-source.txt
+++ b/Documentation/devicetree/bindings/power/wakeup-source.txt
@@ -20,13 +20,12 @@ List of legacy properties and respective binding document
 1. "enable-sdio-wakeup"		Documentation/devicetree/bindings/mmc/mmc.txt
 2. "gpio-key,wakeup"		Documentation/devicetree/bindings/input/gpio-keys{,-polled}.txt
 3. "has-tpo"			Documentation/devicetree/bindings/rtc/rtc-opal.txt
-4. "isil,irq2-can-wakeup-machine" Documentation/devicetree/bindings/rtc/isil,isl12057.txt
-5. "linux,wakeup"		Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
+4. "linux,wakeup"		Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
 				Documentation/devicetree/bindings/mfd/tc3589x.txt
 				Documentation/devicetree/bindings/input/ads7846.txt
-6. "linux,keypad-wakeup"	Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
-7. "linux,input-wakeup"		Documentation/devicetree/bindings/input/samsung-keypad.txt
-8. "nvidia,wakeup-source"	Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
+5. "linux,keypad-wakeup"	Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
+6. "linux,input-wakeup"		Documentation/devicetree/bindings/input/samsung-keypad.txt
+7. "nvidia,wakeup-source"	Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
 
 Examples
 --------
diff --git a/Documentation/devicetree/bindings/rtc/isil,isl12057.txt b/Documentation/devicetree/bindings/rtc/isil,isl12057.txt
index cf83e094..fbbdd92e 100644
--- a/Documentation/devicetree/bindings/rtc/isil,isl12057.txt
+++ b/Documentation/devicetree/bindings/rtc/isil,isl12057.txt
@@ -24,7 +24,6 @@ Optional properties:
 
  - "wakeup-source": mark the chip as a wakeup source, independently of
     the availability of an IRQ line connected to the SoC.
-    (Legacy property supported: "isil,irq2-can-wakeup-machine")
 
  - "interrupt-parent", "interrupts": for passing the interrupt line
    of the SoC connected to IRQ#2 of the RTC chip.
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 18b6a6af..37720242 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1396,14 +1396,8 @@ static int ds1307_probe(struct i2c_client *client,
  * This will guarantee the 'wakealarm' sysfs entry is available on the device,
  * if supported by the RTC.
  */
-	if (of_property_read_bool(client->dev.of_node, "wakeup-source")) {
+	if (of_property_read_bool(client->dev.of_node, "wakeup-source"))
 		ds1307_can_wakeup_device = true;
-	}
-	/* Intersil ISL12057 DT backward compatibility */
-	if (of_property_read_bool(client->dev.of_node,
-				  "isil,irq2-can-wakeup-machine")) {
-		ds1307_can_wakeup_device = true;
-	}
 #endif
 
 	switch (ds1307->type) {
-- 
2.13.2
