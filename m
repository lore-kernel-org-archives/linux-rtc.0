Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.34.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792839895;
	b=M+kg64LuKx5ZOHkgIw3eNs+4j/Qo0UJBBBJItFVzGoZ4i1YbHmcsx2tXCd3lvimqUq6Y
	 yYEho2a7TBTXwRGE/6WjMANQIR7UNoTozrjlq0ZAKSITN+W7bipjHKd1RuYBi846sSgxY
	 EO0VPvGN6N1yjlrhww1UyPNLHbUuzbtoAR7z0LJ16YXorGaW8Qm5uBJMBRHbJyw6k+W1E
	 CUJGZUc1wjX1NXrYAGZtgPeviV+IRtHleVQKoNlzWFq5FHf9tdXPRnjk2/1y/9fQ0+tyE
	 XN/5r74xUolDpGagGNAH6ZWk33UIUow5Ly3pF7Fb2iGK4S+DGjOu6pmuCzsU+ReIQfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792839895;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=PX2qqghAmlmyFbFP9sa3fJAYCvxqqZstFsLQ6nRFC/g=;
	b=odcmpkPyM8b+DStNO1DZfD3Io5Vxpl9fJPG/YeuBRknz8RfVhShAUOXUNDCquYeefU3R
	 97aDrkwDYYGkKfhyqJk/xPeAxe2giqeDgDqJ0Ws2UVKxVq/gxKtUN4UKL7ZkY9ggLtg2O
	 CNb2sTDz/0R7dZ2j8+S4Ddy4+Sa2/h3Q5xbLjqoE/fSA6EX/39EUJNNcgzi1q3IAr68O8
	 Z/UVAui4z3r6+SvM34jFW0KKNgkQ6hiiZ4P6Hs3hetrBuzmSZciHr9aWbsWPtNgz/Wbus
	 jhx8QE94h7JRrscEjqLpOCYZwI0lxd3BnXQ0+9H86h1JAqHf5k0TeMC7LkeummV8ecA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	arc=none smtp.remote-ip=92.121.34.13
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0747B606A31A;
	Sat, 24 Oct 2026 11:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0747B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7B81B1A0169;
	Sat, 24 Oct 2026 13:04:47 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 457121A0088;
	Sat, 24 Oct 2026 13:04:47 +0200 (CEST)
Received: from lsv03900.swis.in-blr01.nxp.com (lsv03900.swis.in-blr01.nxp.com [10.12.177.15])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 59046180006C;
	Sat, 24 Oct 2026 19:04:44 +0800 (+08)
From: Lakshay Piplani <lakshay.piplani@nxp.com>
To: alexandre.belloni@bootlin.com,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	potin.lai.pt@gmail.com
Cc: pankit.garg@nxp.com,
	vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	Lakshay Piplani <lakshay.piplani@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v11 1/2] dt-bindings: rtc: Add pcf85053 support
Date: Sat, 24 Oct 2026 16:34:36 +0530
Message-Id: <20261024110437.2851275-1-lakshay.piplani@nxp.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Add device tree bindings for NXP PCF85053 RTC chip.

Signed-off-by: Pankit Garg <pankit.garg@nxp.com>
Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
V10 -> V11: - no changes
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
---
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

