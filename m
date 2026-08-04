Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160C74A3412
	for <linux-rtc@vger.kernel.org>; Tue,  4 Aug 2026 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863207; cv=none; b=ZiBiuP6dorqxgooB4kcdyVspbSyGuj4Q4t88NdbozmC8vpCx2R/qAqgboOqPWzLic2dsS8SIREFiktm4eXjmssZMtLB+ZcBk/2ZDqODFfxee6iF7SB2wbRcPT0bnBZJ06+5JuWDFRvUWoIhT+nBM+MUtzttWwWwPQ92qaXWXh6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863207; c=relaxed/simple;
	bh=VbB4Wil3UCJk1uCa8RVTSXImGevkwsTjzv2S+pJ7HVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SpMCIbiOsZqqZI1/IPrevUsdw7BHg+gS+CSnbGCJhmHuCTUp07v+YMTwk8zs1IZkPPE+G+2v/gHzWpPYGUklbu1Req4pa+pTXETWFJQv5/T4P5INnlG1wkMpTkSx/dI5c40Tf9xw7h8VYZTv7LF1JtUyL8wBLtPvZV+HJMPfrx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfzIATKN; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfzIATKN"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-37f9e2642deso8267a91.1
        for <linux-rtc@vger.kernel.org>; Tue, 04 Aug 2026 10:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785863193; x=1786467993; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uYY+O4tPwhRgJZdDFD4Z3lnoHAwg4o64PZBS1DmAN5c=;
        b=dfzIATKN1Lw1QchjIA+KADYhFvMIiX8MG9B/itTFLVq0gFBWGqKJ9pNtKLGF75J87X
         mykm6uxak/72vIp6fmz/Zwm9c0bUxZ5VuARiyPnH65lg0+r4mofdVTxsyfDcqz8qyfZm
         5pR3B72/4bPo8KuuU7gWwUWdWiV1AHsigLfIE1SxzfmqNVTTMniQSwmecMfsu45p7pt3
         urQ+LVJg28eWwc5HbWD3t1mATtpG1fWRiUy7xsYAb2ARSw/7j6JTL4C/evTZ8yM/0vF5
         gP/6ePEEJ7GhXatOHB6dXxRpX8ZZmFvhpr2FZ5Glj4DDbgdY9YIjkC2TQ4wusnMWeskE
         d9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785863193; x=1786467993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uYY+O4tPwhRgJZdDFD4Z3lnoHAwg4o64PZBS1DmAN5c=;
        b=VX832eBk4mVM0c7wXgGfMV6zaqJoSrRKfF6q+bk4V8Kqmd84EKNF46XfOyOpKPGQ0g
         7PflYUs6EHUiDoN3V+DcnePQWFb8t1xaA88HNVP9f6h1by2kgQsT0sh4cxnhBj06XgsS
         XXxkINw5NxKRvLTz4NPYgjHbdhRb9jDjvCeB/EcyCQcWLV/P3OJQbcOsdF6MMLnkHKcs
         fsYVJv+a4MnnUvpmS2El/ex6UlkW0xRFopNd6KxMb+sVb7M5KbPnbR/g/Q7v0ZEJv1JS
         rPNmOlYjsnJX3vEdTHUbWzvO+2og1nNy6lQK8aKT/Di3oO8S2l6jURJpx/12bTOVyaU0
         RG0Q==
X-Forwarded-Encrypted: i=1; AHgh+RpPqlZGQ67N76mKUz2h1eudcq9CUcUJBnXdHWjAROQcQlv6n0iFFpj1pm/Ix/HbVp2ulQjadOTQ+OU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz0kVdD6AJdKS7kd6eQcZY9vNSbNY4VJql3B1xVU6djslnxm8h
	VfXk0LJcuRXYGZUdGiAQWTxe3bjBxM2Pq44fB4yKTORY94r2KTxUwIns
X-Gm-Gg: AR+sD11K0GLRgVJo8yJNnhuSrIWjulodMcUFTZOBwqPwC9RK64s10XAsX2EQTLv4HIZ
	RQisP0BqR+5F/9DktxYmaSOEwNLAFoMZm86uQCVZ83YLT+Gtib+G+A+w5j47jNz0/FiBUAYw5O4
	Z+5+StJuhAAB46tgJULe/3Zo11f4QZlMTWFW9gH5x+gpF/jUNmN343+arMah8d8LheSUXfEnGqX
	PP0POT+VbqjjhYk8AgwffCGNyJVpcghzdenjM72iwBQVj3szE/UhyqYlosy3W/dCWYTlFjvDzQ/
	xbU+/29eymMFFLNWLhwzcJpXLBSmA/WQ9qE1hmzMCxUhTVAAudJo2ZooujANDeENrgUZ+SgBp/d
	8WPTKNl9z4aE1ZJJjrz38pNLses60BLOgrOezKu4Lf/9CMNzkvatVc6KMt6AWoXkP9BBOzaDcsZ
	/3kFodVIWxDj/HTljziqqRqCPTuOM+twFXH1FXY2vDrs5durkD8ForMQOKMtbV5Pu8PH/KIVfCX
	RVWSsRz3w==
X-Received: by 2002:a17:90b:264b:b0:381:bcfb:e710 with SMTP id 98e67ed59e1d1-3903c64c81cmr455190a91.3.1785863193378;
        Tue, 04 Aug 2026 10:06:33 -0700 (PDT)
Received: from [10.15.72.252] ([2409:40c2:5423:e712:2aaf:ae79:67c5:476d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca52d329sm5147124c88.4.2026.08.04.10.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 10:06:32 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Tue, 04 Aug 2026 22:35:08 +0530
Subject: [PATCH v3 4/4] dt-bindings: rtc: ti,omap-rtc: Convert to DT schema
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-ti-omap-rtc-v3-4-ba3bbd8af570@gmail.com>
References: <20260804-ti-omap-rtc-v3-0-ba3bbd8af570@gmail.com>
In-Reply-To: <20260804-ti-omap-rtc-v3-0-ba3bbd8af570@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Keerthy <j-keerthy@ti.com>, Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785863118; l=5941;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=VbB4Wil3UCJk1uCa8RVTSXImGevkwsTjzv2S+pJ7HVg=;
 b=hK83DJtdql0s9fVh0pB1mN+aT5VcopcY4vEC3oE/GWqdpf61rbyaapMGXgY8nsB8zlSmT0CHu
 blXDB+X02dWAAIUK5xAgstu5LtMM1MuV3jlRiN16zVo+9IRzMTsk5tf
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Convert the Texas Instruments OMAP Real Time Clock (RTC) binding from
the legacy text format to the DT schema. Mark 'ti,hwmods' as deprecated
as it is no longer used, it is kept to support legacy boards.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 Documentation/devicetree/bindings/rtc/rtc-omap.txt |  53 --------
 .../devicetree/bindings/rtc/ti,omap-rtc.yaml       | 140 +++++++++++++++++++++
 2 files changed, 140 insertions(+), 53 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
deleted file mode 100644
index 062ebb14cecf..000000000000
--- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-TI Real Time Clock
-
-Required properties:
-- compatible:
-	- "ti,da830-rtc"  - for RTC IP used similar to that on DA8xx SoC family.
-	- "ti,am3352-rtc" - for RTC IP used similar to that on AM335x SoC family.
-			    This RTC IP has special WAKE-EN Register to enable
-			    Wakeup generation for event Alarm. It can also be
-			    used to control an external PMIC via the
-			    pmic_power_en pin.
-	- "ti,am4372-rtc" - for RTC IP used similar to that on AM437X SoC family.
-- reg: Address range of rtc register set
-- interrupts: rtc timer, alarm interrupts in order
-
-Optional properties:
-- system-power-controller: whether the rtc is controlling the system power
-  through pmic_power_en
-- clocks: Any internal or external clocks feeding in to rtc
-- clock-names: Corresponding names of the clocks
-- pinctrl-0: a phandle pointing to the pin settings for the device
-- pinctrl-names: should be "default"
-
-Optional subnodes:
-- generic pinctrl node
-
-Required pinctrl subnodes properties:
-- pins - Names of ext_wakeup pins to configure
-
-Optional pinctrl subnodes properties:
-- input-enable - Enables ext_wakeup
-- ti,active-high - Set input active high (by default active low)
-
-Example:
-
-rtc@1c23000 {
-	compatible = "ti,da830-rtc";
-	reg = <0x23000 0x1000>;
-	interrupts = <19
-		      19>;
-	interrupt-parent = <&intc>;
-	system-power-controller;
-	clocks = <&clk_32k_rtc>, <&clk_32768_ck>;
-	clock-names = "ext-clk", "int-clk";
-
-	pinctrl-0 = <&ext_wakeup>;
-	pinctrl-names = "default";
-
-	ext_wakeup: ext-wakeup {
-		pins = "ext_wakeup0";
-		input-enable;
-		ti,active-high;
-	};
-};
diff --git a/Documentation/devicetree/bindings/rtc/ti,omap-rtc.yaml b/Documentation/devicetree/bindings/rtc/ti,omap-rtc.yaml
new file mode 100644
index 000000000000..02b3c23cf435
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/ti,omap-rtc.yaml
@@ -0,0 +1,140 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/ti,omap-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments OMAP Real Time Clock
+
+maintainers:
+  - Keerthy <j-keerthy@ti.com>
+  - Afzal Mohammed <afzal@ti.com>
+
+description:
+  The OMAP RTC is a year/month/day/hours/minutes/seconds BCD clock with
+  century-range alarm matching, driven by the 32kHz clock.
+
+properties:
+  compatible:
+    oneOf:
+      - const: ti,da830-rtc
+      - items:
+          - const: ti,am3352-rtc
+          - const: ti,da830-rtc
+      - items:
+          - const: ti,am4372-rtc
+          - const: ti,am3352-rtc
+          - const: ti,da830-rtc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 2
+    maxItems: 2
+
+  system-power-controller:
+    type: boolean
+    description:
+      Indicates that this RTC controls system power via the pmic_power_en pin.
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - enum: [ext-clk, int-clk]
+      - const: int-clk
+
+  pinctrl-0:
+    description:
+      Phandle to pin configuration for the external wakeup pins.
+
+  pinctrl-names:
+    minItems: 1
+
+  ti,hwmods:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Name of the hwmod associated with the RTC.
+    const: rtc
+    deprecated: true
+
+patternProperties:
+  "^ext-wakeup(-[0-9]+)?$":
+    type: object
+
+    description:
+      Child node describing external wakeup pin configuration.
+
+    properties:
+      pins:
+        pattern: '^ext_wakeup[0-3]$'
+
+      input-enable:
+        type: boolean
+        description:
+          Enables the external wakeup input on the selected pin.
+
+      ti,active-high:
+        type: boolean
+        description:
+          Sets the wakeup input polarity to active high. By default the
+          input is active low.
+
+    required:
+      - pins
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: rtc.yaml#
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: ti,am3352-rtc
+    then:
+      properties:
+        system-power-controller: false
+      patternProperties:
+        "^ext-wakeup(-[0-9]+)?$": false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    rtc@23000 {
+        compatible = "ti,da830-rtc";
+        reg = <0x23000 0x1000>;
+        interrupts = <19>, <19>;
+        clocks = <&clk_32768_ck>;
+        clock-names = "int-clk";
+    };
+
+  - |
+    rtc@0 {
+        compatible = "ti,am3352-rtc", "ti,da830-rtc";
+        reg = <0x0 0x1000>;
+        interrupts = <75>, <76>;
+        system-power-controller;
+        clocks = <&clk_32k_rtc>, <&clk_32768_ck>;
+        clock-names = "ext-clk", "int-clk";
+
+        pinctrl-0 = <&ext_wakeup>;
+        pinctrl-names = "default";
+
+        ext-wakeup {
+            pins = "ext_wakeup0";
+            input-enable;
+            ti,active-high;
+        };
+    };

-- 
2.55.0

