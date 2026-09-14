Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA130F958;
	Mon, 14 Sep 2026 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395346; cv=none; b=kNb+Hql8+rItqel696CoWlLo1MBnAF0wTLtUNE1bWZsjydzD47cM0/mQ1TZhIhPPbTs5aK0TvKiZTNf4thEvCgJGkkVPJbvHTJnqubazef9MAZvDO01xyZau7GzoDj10pw9IDbsgCqV/FciI0cH0d+/8ejwQGmIovonfC5arCnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395346; c=relaxed/simple;
	bh=kDySIegLRkdndFjX2B6UpfkU7N+6pCXIjxLUZrvMop0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iFg99oLRlJs+gDgMFCgKQyYEOPxAkbF2RmQHEwjiZqBim63ngnFGggPO+JCLRtD2UkDrLGeWAqksSpFrcwuDXW3RF0uo7vbLzlPVX59FZAzCHRQb8uqeoH1FUxoF+lJ5xORYlhqxyrD3T1EAOZyUIo3HAIZ90M78PgEld9KnDpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A0193200009;
	Mon, 14 Sep 2026 16:15:42 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 69BF0200007;
	Mon, 14 Sep 2026 16:15:42 +0200 (CEST)
Received: from lsv03900.swis.in-blr01.nxp.com (lsv03900.swis.in-blr01.nxp.com [10.12.177.15])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3A1E21800068;
	Mon, 14 Sep 2026 22:15:41 +0800 (+08)
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
Subject: [PATCH v10 1/2] dt-bindings: rtc: Add pcf85053 support
Date: Mon, 14 Sep 2026 19:45:36 +0530
Message-Id: <20260914141537.3881890-1-lakshay.piplani@nxp.com>
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
V9 -> V10: - Add description for the active-low level alarm interrupt.
	   - Move the PCF85053 MAINTAINERS entry to the driver patch.
V8 -> V9: - Document optional CLKOUT clock provider and add it to the example.
	  - Disallow interrupts and nxp,write-access on the secondary interface.
	  - Describe the alarm interrupt as active-low level triggered.
	  - Use 'const' for the single compatible string.
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

 .../devicetree/bindings/rtc/nxp,pcf85053.yaml | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf85053.yaml

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85053.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf85053.yaml
new file mode 100644
index 000000000000..960f871b6334
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85053.yaml
@@ -0,0 +1,132 @@
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
+    const: nxp,pcf85053
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: |
+      Alarm interrupt output. The ALRT pin is active-low and should be
+      configured as a level-low interrupt.
+
+  "#clock-cells":
+    const: 0
+    description: |
+      Present when the CLKOUT pin is exposed as a clock provider. In a
+      dual-host configuration, only one PCF85053 interface node should
+      expose CLKOUT as a clock provider.
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
+      register that gates which host may write the time registers.
+        - "primary": Designated host that *may* claim write ownership (set
+          CTRL.TWO=1) **if** write-access is explicitly requested.
+        - "secondary": Peer host that writes only when CTRL.TWO=0 (default).
+
+      This property determines the intended role of the host in relation to
+      the write ownership.
+
+      The actual role depends on whether 'nxp,write-access' is also specified.
+      Supported configurations are:
+        1. Primary with 'nxp,write-access' -> primary claims write ownership.
+        2. Primary without 'nxp,write-access' -> secondary owns time-register writes.
+        3. Secondary (must not specify 'nxp,write-access') -> secondary may write
+           the time registers when CTRL.TWO=0.
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
+      properties:
+        # The secondary interface has read-only access to the control and
+        # status registers, so it cannot service or clear the alarm IRQ and
+        # cannot claim write ownership.
+        interrupts: false
+        nxp,write-access: false
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
+        #clock-cells = <0>;
+        clock-output-names = "pcf85053-clkout";
+        interrupt-parent = <&gpio2>;
+        interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
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
+        interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
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
-- 
2.25.1

