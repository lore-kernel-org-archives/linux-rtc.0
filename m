Return-Path: <SRS0=NPLb=DU=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A42C433E7
	for <linux-rtc@archiver.kernel.org>; Tue, 13 Oct 2020 14:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88AA924872
	for <linux-rtc@archiver.kernel.org>; Tue, 13 Oct 2020 14:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388864AbgJMOl1 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 13 Oct 2020 10:41:27 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54819 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388829AbgJMOl0 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 13 Oct 2020 10:41:26 -0400
X-Originating-IP: 90.65.88.165
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 5D9F3C000B;
        Tue, 13 Oct 2020 14:41:23 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: rtc: rv3032: add RV-3032 bindings
Date:   Tue, 13 Oct 2020 16:41:09 +0200
Message-Id: <20201013144110.1942218-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013144110.1942218-1-alexandre.belloni@bootlin.com>
References: <20201013144110.1942218-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Document the Microcrystal RV-3032 device tree bindings

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
changes in v3:
 - remove rtc.yaml change


 .../bindings/rtc/microcrystal,rv3032.yaml     | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/microcrystal,rv3032.yaml

diff --git a/Documentation/devicetree/bindings/rtc/microcrystal,rv3032.yaml b/Documentation/devicetree/bindings/rtc/microcrystal,rv3032.yaml
new file mode 100644
index 000000000000..a2c55303810d
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/microcrystal,rv3032.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/microcrystal,rv3032.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip RV-3032 RTC Device Tree Bindings
+
+allOf:
+  - $ref: "rtc.yaml#"
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+
+properties:
+  compatible:
+    const: microcrystal,rv3032
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  start-year: true
+
+  trickle-resistor-ohms:
+    enum:
+      - 1000
+      - 2000
+      - 7000
+      - 11000
+
+  trickle-voltage-millivolt:
+    enum:
+      - 1750
+      - 3000
+      - 4400
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@51 {
+            compatible = "microcrystal,rv3032";
+            reg = <0x51>;
+            status = "okay";
+            pinctrl-0 = <&rtc_nint_pins>;
+            interrupts-extended = <&gpio1 16 IRQ_TYPE_LEVEL_HIGH>;
+            trickle-resistor-ohms = <7000>;
+            trickle-voltage-millivolt = <1750>;
+        };
+    };
+
+...
-- 
2.26.2

