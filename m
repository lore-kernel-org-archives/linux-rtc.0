Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CED93D0BF3;
	Tue, 25 Aug 2026 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787642382; cv=none; b=tXSCnfUc+rZUN4p9ODNTld9m7QEVrPjn1svTDeZHc5Jzv0GfHJiNdBxn2dXp8JfXnspeqfCxrFqBfz0oh7VYODlsoDYibScFYkcC3VnIa8OgwJIxQfquVrxdJDkEaff/8Q3tZXQ1le72NkmEekD6/0fwIR43icG4SrtyW3hFUs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787642382; c=relaxed/simple;
	bh=jTlkpKX/i4IK/qqSZ+v0AWvDMXAkhg+j6xaMzMiVKb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFH7N3D/8J7jrSB9+1sD7CAo1xKOx46Mleyec/RmhXlkH6H1X9J4k4KhIx1aQoQ7oXFhdrg0jk4UAP/aG7Y6Z8WeZ3g0+GpzZwE3opUwxafMtbCinVMPYxPeCwsUtyFLAUEDtta3CBpu7V4clI/Onxr/Xc8luXPrvgclnPciZP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Ov5GqHuW; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Ov5GqHuW"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BE6211CC0F;
	Tue, 25 Aug 2026 09:19:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1787642374; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=W429C6y4sT/FIA+4M/csrplvSTOypF/+XtDpNghU/6s=;
	b=Ov5GqHuW/ooR7ax4280lbRpdLF01HC1yt7XGwrJtVPPiBvmX/zY6kXohCWVDu/DvIllVz9
	UzRUznLGw7Zwt8TuBq5JrcdETWC+TEuHAmZpEUtFVL9JwAwve778awkw9eDkwzLmEf3Tzq
	0pFUjvGmSTSMdydd5yFnKzc8r2TxUYS4bzqrHOp3MQ0ugvPCTRngCXWsarmn7PitIL06Ac
	IzacjTzfxkPpK84o0Zkw3TGbutvWqV4sxwanoFAB7pcfgYd0B/Cb/d83T+mna04gYKz9R3
	OtZV7r7l8X25sDhVA/Y0hfQ1/lNaw5MoNg8ZE69MnJ2snr4CIpCy3vB8JR9sIg==
From: Heiko Schocher <hs@nabladev.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	linux-rtc@vger.kernel.org,
	Heiko Schocher <hs@nabladev.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/3] dt-bindings: rtc: add ricoh,r2223x binding
Date: Tue, 25 Aug 2026 09:19:16 +0200
Message-ID: <20260825071927.4090460-2-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825071927.4090460-1-hs@nabladev.com>
References: <20260825071927.4090460-1-hs@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The Ricoh R2223x is an I2C RTC of the same family as the r2025sd and
r2221tl which the rtc-rs5c372 already supports. It drives a clock output
and can be put into an eco mode that lowers its current consumption from
the backup supply, so it needs #clock-cells and a property for the eco
mode.

The trivial-rtc binding does not cover this, so give the device its
own binding.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---

Changes in v2:
- Added Reviewed-by from Conor, no code change in patch 1

 .../devicetree/bindings/rtc/ricoh,r2223x.yaml | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/ricoh,r2223x.yaml

diff --git a/Documentation/devicetree/bindings/rtc/ricoh,r2223x.yaml b/Documentation/devicetree/bindings/rtc/ricoh,r2223x.yaml
new file mode 100644
index 000000000000..e64a1ee378e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/ricoh,r2223x.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/ricoh,r2223x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ricoh R2223x Real-Time Clock
+
+maintainers:
+  - Heiko Schocher <hs@nabladev.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: ricoh,r2223x
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
+  ricoh,eco-mode:
+    type: boolean
+    description:
+      Put the RTC into eco mode, which lowers its current consumption while
+      running from the backup supply. Set this on boards where the RTC is
+      expected to keep time on a small backup cell.
+
+  start-year: true
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
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@32 {
+            compatible = "ricoh,r2223x";
+            reg = <0x32>;
+            interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
+            #clock-cells = <0>;
+            ricoh,eco-mode;
+        };
+    };
-- 
2.55.0

