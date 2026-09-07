Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3532456DE2;
	Mon,  7 Sep 2026 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776509; cv=none; b=BP+2ccOzDRAsY3nuJA7BygF/V+xUZERJNFYqCIy2Do5ETggum/0DTOb3F7r5r0EOYYlNnB7UFfAh5xjqQL+f13jVw3H2YUc1SP9AdP48p7jqvaKYC8BMSgyhoJmaxiPwjFvDVIZwhBKikeVUblFDV0Caa5uGRVsuG04UZJBM7yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776509; c=relaxed/simple;
	bh=LOz2SPq3agdqp5UwiFmeyVY1T37pAD7q9aJqbAw+PoI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mrQcXChdDmUG+sP7XhUDIoCfMLJ+KZlOwyXlCD7TRHu3IL3rfoFtV8N/qBvZaDv+2cQ497hR2Rlyoxz91UEnCgVfPWa6WzsgJ6LK87JvzlxsWZepc5SrQEpWH8dXE5oQunYYbty3WcpHiZb7+hm0KRCeNeXWwY011CbmK0ubrXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 53370200305;
	Mon,  7 Sep 2026 12:21:40 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1D6FE20020A;
	Mon,  7 Sep 2026 12:21:40 +0200 (CEST)
Received: from lsv03900.swis.in-blr01.nxp.com (lsv03900.swis.in-blr01.nxp.com [10.12.177.15])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D7FA9180006C;
	Mon,  7 Sep 2026 18:21:38 +0800 (+08)
From: Lakshay Piplani <lakshay.piplani@nxp.com>
To: alexandre.belloni@bootlin.com,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: pankit.garg@nxp.com,
	vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	Lakshay Piplani <lakshay.piplani@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v8 1/2] dt-bindings: rtc: Add pcf85053 support
Date: Mon,  7 Sep 2026 15:51:33 +0530
Message-Id: <20260907102134.394717-1-lakshay.piplani@nxp.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Add device tree bindings for NXP PCF85053 RTC chip.

Signed-off-by: Pankit Garg <pankit.garg@nxp.com>
Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
V7 -> V8: - Use 'unevaluatedProperties: false' instead of 'additionalProperties:
	    false'.
	  - Fix typo in 'nxp,interface' description ("ready only" -> "read only").
V6 -> V7: - no changes
	  - Added Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
V5 -> V6: - Dropped driver-specific commentary from property descriptions.
	  - Simplified and clarified descriptions for better readability.
V4 -> V5: - Updated schema validation logic to enforce correct combinations of
            'nxp,interface' and 'nxp,write-access' using oneOf clauses.
          - Refined property descriptions for clarity and hardware alignment.
V3 -> V4: Add dedicated nxp,pcf85053.yaml.
          Remove entry from trivial-rtc.yaml.
V2 -> V3: Moved MAINTAINERS file changes to the driver patch
V1 -> V2: Handled dt-bindings by trivial-rtc.yaml

 .../devicetree/bindings/rtc/nxp,pcf85053.yaml | 120 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf85053.yaml

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85053.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf85053.yaml
new file mode 100644
index 000000000000..f6e4acfcbc0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85053.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2025-2026 NXP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/nxp,pcf85053.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PCF85053 Real Time Clock
+
+maintainers:
+  - Pankit Garg <pankit.garg@nxp.com>
+  - Lakshay Piplani <lakshay.piplani@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - nxp,pcf85053
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
+
+  nxp,interface:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ primary, secondary ]
+    description: |
+      Identifies this host's logical role in a multi-host topology for the
+      PCF85053 RTC. The device exposes a "TWO" ownership bit in the CTRL
+      register that gates which host may write time/alarm registers.
+        - "primary": Designated host that *may* claim write ownership (set
+          CTRL.TWO=1) **if** write-access is explicitly requested.
+        - "secondary": Peer host that writes only when CTRL.TWO=0 (default).
+
+      This property determines the intended role of the host in relation to
+      the write ownership.
+
+      The actual role depends on whether 'nxp,write-access' is also specified.
+      Supported configurations are:-
+        1. Primary with 'nxp,write-access' -> primary claims write ownership.
+        2. Primary without 'nxp,write-access' -> primary is read-only; secondary may write.
+        3. Secondary (must not specify 'nxp,write-access') -> Secondary writes only
+           when no primary claims ownership.
+
+  nxp,write-access:
+    type: boolean
+    description: |
+      Indicates that write ownership of the PCF85053 RTC should be claimed by setting
+      CTRL.TWO=1. This property is only valid when acting as the primary interface
+      (nxp,interface="primary").
+
+required:
+  - compatible
+  - reg
+  - nxp,interface
+
+unevaluatedProperties: false
+
+allOf:
+  - $ref: rtc.yaml#
+  - if:
+      properties:
+        nxp,interface:
+          const: secondary
+    then:
+      not:
+        required: [ "nxp,write-access" ]
+
+examples:
+  # Single host example.
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rtc@6f {
+        compatible = "nxp,pcf85053";
+        reg = <0x6f>;
+        nxp,interface = "primary";
+        nxp,write-access;
+        interrupt-parent = <&gpio2>;
+        interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+      };
+    };
+
+  # Dual-host example: one primary that claims writes; one secondary that never claims writes.
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rtc@6f {
+        compatible = "nxp,pcf85053";
+        reg = <0x6f>;
+        nxp,interface = "primary";
+        nxp,write-access;
+        interrupt-parent = <&gpio2>;
+        interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+      };
+    };
+
+    i2c1 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rtc@6f {
+        compatible = "nxp,pcf85053";
+        reg = <0x6f>;
+        nxp,interface = "secondary";
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..01b4f7157f36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19793,6 +19793,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
 F:	drivers/extcon/extcon-ptn5150.c
 
+NXP RTC PCF85053 DRIVER
+M:	Pankit Garg <pankit.garg@nxp.com>
+M:	Lakshay Piplani <lakshay.piplani@nxp.com>
+L:	linux-rtc@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/rtc/nxp,pcf85053.yaml
+
 NXP SGTL5000 DRIVER
 M:	Fabio Estevam <festevam@gmail.com>
 L:	linux-sound@vger.kernel.org
-- 
2.25.1

