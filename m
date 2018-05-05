Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34747 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751792AbeEEDKv (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 4 May 2018 23:10:51 -0400
From: Fabio Estevam <festevam@gmail.com>
To: alexandre.belloni@bootlin.com
Cc: robh+dt@kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] dt-bindings: rtc-2123: Make the node name generic
Date: Sat,  5 May 2018 00:10:31 -0300
Message-Id: <1525489831-23871-1-git-send-email-festevam@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

According to Devicetree Specification v0.2 document:

"The name of a node should be somewhat generic, reflecting the function
of the device and not its precise programming model."

Do as suggested in the binding example.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt b/Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt
index 5cbc0b1..811124a 100644
--- a/Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt
+++ b/Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt
@@ -9,7 +9,7 @@ Optional properties:
 
 Example:
 
-rtc: nxp,rtc-pcf2123@3 {
+pcf2123: rtc@3 {
 	compatible = "nxp,rtc-pcf2123"
 	reg = <3>
 	spi-cs-high;
-- 
2.7.4
