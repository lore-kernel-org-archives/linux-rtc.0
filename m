Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:48969 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932115AbdKONHS (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 15 Nov 2017 08:07:18 -0500
Received: from localhost (unknown [37.71.171.242])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 2C6C320381
        for <linux-rtc@vger.kernel.org>; Wed, 15 Nov 2017 14:07:14 +0100 (CET)
From: Fabio Estevam <festevam@gmail.com>
To: alexandre.belloni@free-electrons.com
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org, jbe@pengutronix.de,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] dt-bindings: rtc: imxdi: Improve the bindings text
Date: Wed, 15 Nov 2017 10:59:53 -0200
Message-Id: <1510750793-25564-1-git-send-email-festevam@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

Improve the bindings text by doing the following changes:

- Remove the i.MX53 reference, as the RTC on i.MX53 is a different hardware
- Add 'clocks' to the list of required properties
- Explain that the optional security violation irq is the second entry
- Use the real unit address and irq numbers for i.MX25

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 Documentation/devicetree/bindings/rtc/imxdi-rtc.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt b/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt
index 323cf26..b8f3050 100644
--- a/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt
@@ -1,20 +1,20 @@
 * i.MX25 Real Time Clock controller
 
-This binding supports the following chips: i.MX25, i.MX53
-
 Required properties:
 - compatible: should be: "fsl,imx25-rtc"
 - reg: physical base address of the controller and length of memory mapped
   region.
+- clocks: should contain the phandle for the rtc clock
 - interrupts: rtc alarm interrupt
 
 Optional properties:
-- interrupts: dryice security violation interrupt
+- interrupts: dryice security violation interrupt (second entry)
 
 Example:
 
-rtc@80056000 {
-	compatible = "fsl,imx53-rtc", "fsl,imx25-rtc";
-	reg = <0x80056000 2000>;
-	interrupts = <29 56>;
+rtc@53ffc000 {
+	compatible = "fsl,imx25-rtc";
+	reg = <0x53ffc000 0x4000>;
+	clocks = <&clks 81>;
+	interrupts = <25 56>;
 };
-- 
2.7.4
