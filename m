Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D723E3D85
	for <linux-rtc@vger.kernel.org>; Fri, 24 Jul 2026 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784884643; cv=none; b=VTWXBxQBic7oSs+PC0ORa5yvGIdjLGwDx3tUix0iXgTxUGMKtpDu671IyaJA7jhaU2NIgiB5vAlKccheAZgqYKtiKa7bMCkk0r2MXbmA7qK6ORUepvS6mGZkxOV1DvuFpseMRn8O69HQcw1xHT2QlCjSYQuQ1WLoy9h9rX8DPrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784884643; c=relaxed/simple;
	bh=w4D0gIALD+oQwRkcRYqkjrxWL3scQENxlMKyZtbKsVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZfJ3B0Nw8Gu1eQ8u3O2TVZjtG9lCFVjxFGtkLFoyqUa9KQYBVaGFniyfIjOTrjetObdFVTmuunljcrwpPA8L2RhkrFrYe5vSeBPUWjWXqEvZ1idbcKceJP3ayQNWuNnZXWNeGgz2gOkciThrHg9TvaxYcthWybWuOgI+fA8D3X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4Zu4n9X; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4Zu4n9X"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cb2513ec378so40799a12.3
        for <linux-rtc@vger.kernel.org>; Fri, 24 Jul 2026 02:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784884627; x=1785489427; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+UQbPPZ/37Je+N1GakDOwbWdjlhTCE3rkUERQqlv0nk=;
        b=l4Zu4n9XZ0ctfub79kag1CMZyulq5Uwu2VJQ0fLxHF4gQXwDHZXwMGCbg8Hav2scVX
         RsqC/RByIXKWBm+8tLQzRHhNQzD4vp0uP/4IzUuw8d/TKdo+bDZxqcX0tdyVOjXVOZQW
         345q71u4htUOAqVC4lc3MAQVpEITuVjk/SXZjx1OHmN2amIN4g3cKXltrRsiddm0A3h1
         B5hCd7FOtBdWFlh+VT/RW4ui8Y22vIOz/ku4TrKEoTXRG1F6A2RSwcLhteRc4WfHqKg9
         iBVgTyhLnkL5cXEPAYa3HfzAuHy/Ob/kBqF/E54A5HywxMsFw1V3MhTaTNSGEJh+IxE2
         XX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784884627; x=1785489427;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+UQbPPZ/37Je+N1GakDOwbWdjlhTCE3rkUERQqlv0nk=;
        b=BMQQkTqb0j5FX8yKIK8d8YpEoK0mqdizlePSwp5WR25Axl0x0JHykTfYKkrNevfZx6
         iv0/aWpGAN1x5bbjWhSUfSupqd2B97q1AxIUmdEWtQavpkpryxgBtHWPM25aO0CSwbbi
         DYyG3hFK9FZfeq8Ph6+CNZJ318ASs+obwHorYqTLpCcYFQNOZ8Stx/T8oFg/uBd0HeQl
         eBnuZFnyq7UF48xpIKJ1O7+57MnSFICG8ANJ6buNU484e6krx0+/48VD1EDkR+Z5C1t1
         l31ueYQ7+t1yt8BTVyBNpGiGXIA+sNjUAnqoTXfaTndyAyuIUw3Oz+2M+rnmUii6ZyQ7
         zXQQ==
X-Forwarded-Encrypted: i=1; AHgh+RodfI8Q9yxcVMC3D0wMAWELO3WvXWSHq2zYIoYiFl5AO/Prx7s52ohbAD9e/+VtDBWMwW/dquLH5jw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx1VyMqW+rulj+WUcMmUgkTBsdcsAu1Bcxxot/NbQ2H3e3T2sc
	pGTe7r9ffVIXGJwHod5/JDHOzl60JLm/K2FbwKOAIOPf/FIrxIJTzchl
X-Gm-Gg: AR+sD10nbD5nJOehJ9ZlhhE3S1Vw7T6CBvRTCpQb1IbT8xuweV0/VbLs/q0/RnJdP3j
	Laosnwxqnb3aPkZ1KG+aeyUIOFJOw+6wbCuUk8FUbBJOh8lSpM9rrOwotx7nZDp4ECgGHbSSFTK
	6ni/JeK1k1OmcVfTsanrrjMYQyLkKYu2f8fCWagMdv/gS0DBZ458d3Nw8gkfOAgDDbO7OKBnujG
	VMyTDF6ILCr2F50d0XOr0GM4RZ/oIS2pCzNwxkc04KX9u55Sa50TI1ayH4+PbGr/O2XZd/SXRGp
	GqP1SZABH6jBc3LLE8MAiTeWYiUdCmSg+EhxMIlezS0LDYekGSoUjqxSwjT44ghR5eiBGFn00kW
	swKVc3MKAnHABxMi2vUKxOQmxM7/fpMz1my1YMiyFVtxYGyisoZt5LCwRypswCtTszcKcfdwHGU
	JSNF5UtzF6ZTDUBXM=
X-Received: by 2002:a17:903:98c:b0:2ca:6885:8a06 with SMTP id d9443c01a7336-2cfbd2b74c3mr26871855ad.5.1784884626794;
        Fri, 24 Jul 2026 02:17:06 -0700 (PDT)
Received: from [172.28.140.252] ([2409:40c2:5420:f772:24a9:f23f:ed43:a5ce])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df097e0sm29005610eec.17.2026.07.24.02.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 02:17:06 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Fri, 24 Jul 2026 14:45:54 +0530
Subject: [PATCH 3/3] dt-bindings: rtc: ti,omap-rtc: Convert to DT schema
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-ti-omap-rtc-v1-3-ffef78853cd6@gmail.com>
References: <20260724-ti-omap-rtc-v1-0-ffef78853cd6@gmail.com>
In-Reply-To: <20260724-ti-omap-rtc-v1-0-ffef78853cd6@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784884567; l=3625;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=w4D0gIALD+oQwRkcRYqkjrxWL3scQENxlMKyZtbKsVQ=;
 b=BfmznW35u7g2x8z0F5tLkqAKnZchpdk7hk8EOMs8x/nTSaF7A2roM2S1KuW/nwH3NxrnUBAC1
 puVALS+J/QqD63B2R6G2p739pkc276q4xrY+lJYlAw4LmSsUrqo8B5x
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Convert the Texas Instruments OMAP Real Time Clock (RTC) binding from
the legacy text format to the DT schema. Mark 'ti,hwmods' as deprecated
as it is no longer used, it is kept to support legacy boards.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 .../devicetree/bindings/rtc/ti,omap-rtc.yaml       | 129 +++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/ti,omap-rtc.yaml b/Documentation/devicetree/bindings/rtc/ti,omap-rtc.yaml
new file mode 100644
index 000000000000..eeea1bab6530
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/ti,omap-rtc.yaml
@@ -0,0 +1,129 @@
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
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: ti,da830-rtc
+      - const: ti,am3352-rtc
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
+    oneOf:
+      - items:
+          - const: ext-clk
+          - const: int-clk
+      - items:
+          - const: ext-clk
+      - items:
+          - const: int-clk
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
+        enum:
+          - ext_wakeup0
+          - ext_wakeup1
+          - ext_wakeup2
+          - ext_wakeup3
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
+unevaluatedProperties: false
+
+examples:
+  - |
+    rtc@23000 {
+        compatible = "ti,da830-rtc";
+        reg = <0x23000 0x1000>;
+        interrupts = <19>, <19>;
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

