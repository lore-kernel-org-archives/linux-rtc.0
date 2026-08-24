Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A27D394E91;
	Mon, 24 Aug 2026 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569517; cv=none; b=Na2xqqizRtXzGKS/kGXVWmxtarpL0dEs2o/xxEeZYfj7PvX8bceqBH/tgk9M8KASHJizl8z1Rf7HULPVNxbF5eLQ/YlPZl4beFDTSVPezjoyvK4hgGBINKSQ3WwHif8mS/mriGw+uTfpKzeWIT6+KNP4zjj0V74QBppl0QAAwdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569517; c=relaxed/simple;
	bh=Oq3NsSA4NN6MjvOTatj4i1UIMVp23zTNnlUvUpUs8rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JyLVs9xTlE640RO1BHVbb+GNz0KqgS+e4V9ARgss87P0RPUDC2qMqKXm4EGydqaeM3miBuAuRUGvqv0Jedx8daVWWPwb8aV4HMVx0Ir0E9V7CI8dY8z98mPQntJE5OYKifGnvdSyF/9nIb352E7PAhsjCYdqg6zb9ZaHg2AYNRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=DRkDWX+x; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="DRkDWX+x"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B8DF611C96E;
	Mon, 24 Aug 2026 13:05:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1787569509; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=k/9cjy93SNiS59rdLj9Zd1G22nyWLEUw0GqoGpbSyTU=;
	b=DRkDWX+xRO8GGI0F00/I5br54ISXeo+iARYz3vEZ1BrZpvBEiNKSH9tFife9WFeR1nl8NB
	vQhUzazhES83vnsJE7YsZoyAfjq7iA1CRawqwv+9AVmvT70BpObcLeekUutIX8mnSOwW2r
	97V4+vW7bITUAMAEYggMXzBxwDIMsvAfDnt6DZkZkBhcW2TRoAgM9+N7SbXP94AyZ3iTZx
	DOD0o4V/rBTNIT5GGmVPlb316/ksZEU4m3AJUFHzI76Ah3ESfAMpJRCVtJy2vQ7AxKLD2E
	7c+fbBQimH+duTn3uZwIh1gA74fCE5CzBA7ALB9s6plnHIfXf5hGB5e30vNwlw==
From: Heiko Schocher <hs@nabladev.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	Heiko Schocher <hs@nabladev.com>
Subject: [PATCH v1 1/3] dt-bindings: rtc: add ricoh,r2223x binding
Date: Mon, 24 Aug 2026 13:04:24 +0200
Message-ID: <20260824110452.4038870-2-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824110452.4038870-1-hs@nabladev.com>
References: <20260824110452.4038870-1-hs@nabladev.com>
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
---

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

