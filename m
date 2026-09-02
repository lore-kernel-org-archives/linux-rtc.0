Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780B34334CA
	for <linux-rtc@vger.kernel.org>; Wed,  2 Sep 2026 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788392127; cv=none; b=aj3vL7vUCVdGXfvZF3baTqmLBRatcXajaDU+5znfDTbOgN8kOz1hAN9lT0YnUCGZc7O+GOOOP+R0ashU5jabom8biJkt+NJCrLGwFmsulYZyj1Ve6YFJkrEbUiKi49NV/ImhBgJWxMWBGVF1LdboNjv0lhWzL/KsgLCorqXg90k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788392127; c=relaxed/simple;
	bh=U71T/iH4wTJhru5jPquFocWPqj8LcYNokk6NJovo93Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=huGcyU3s5PFVXM/IGi+Tpe/UnRPRA/oN/6osXv8DltsVoUuWhopa8CtvXHGuAf8SpBH5pkKShh4cWXZkjIkEWcv9/wiFCJe147YD3NWc+yWA7PqAOikfxkedMtNNJguAa97ieqsEPBH+TiSIicANLnP13wc2jCJoKdIZRUbQPnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1+CgPYJ; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1+CgPYJ"
Received: by mail-pj2-f5.google.com with SMTP id 98e67ed59e1d1-3965683e9e9so987585a91.1
        for <linux-rtc@vger.kernel.org>; Wed, 02 Sep 2026 16:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788392123; x=1788996923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AhxmtI32HeN59PYea0qLMDve3O4zMl3qKBe7Lg9m4z0=;
        b=i1+CgPYJ9MTaoANCKUiyMGxPX9KWLNytH1An1H3wj4hmZjVoe+habo5ZzuDjav7HTU
         iJgnyJJNG3+gG9QAwe+H/2Cio6fW7ouznxPsMV1ih3wpUc5G3MF2tncyp/vul/CEVuhZ
         wXAEUB9344eHQayYDQyh5o7TZRqqW4lX9SNKT3Ea+4dYbsHN0rXcDmBs2UWe9t2wI6DB
         l+nimdoEz8CkBHJWyJxkdFqepcA6qhLEdFJcAq4EKG8JPk0GqpzpFpiA8TSQ28Z0F3C9
         wIYYngwVfz7kcsQYaOt+SP+nuurqrO45LvDIqoq/wAS6q5tL2aDWhUd0oguGAxCUw7HM
         12Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788392123; x=1788996923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AhxmtI32HeN59PYea0qLMDve3O4zMl3qKBe7Lg9m4z0=;
        b=eSVONkBtHlBRGXSnYWF7ZUSOiJ+SkuQzo7Oiuj1ebfIkUTSoMgguiHIkqe9uH8gOLq
         zifDjKeY5dokSPue54yv+DEwiVYX3zE34RGXQRlSywa5xyxza17L1swBgvWOlJ9dJwwg
         nY5bIzVDVN2/qKKw4xyuXaE88/GxX8x5aB0dsovdZtk2A5PLUTR16hgUktzQWmWA4Lql
         N2s6dkbUODcsHpi8S7v3AahTvXcQMZwOEWInaUIRxSJifa65Hp/r+plGY/UQgR6rf7CG
         x5ULhP0+qVdPPJOGqeoJJUmHvkG0CGanCaYDWC2p05NVyuS9huTpvPftYrGtVnIXNprv
         47nA==
X-Forwarded-Encrypted: i=1; AKwUvBzjKfyvttmrWYV0iOwah+6f4UKeAxcAbQPpL95BxnLLwJs85szglK4KacOaG2CJ3lmyzaUa3S2nuzw=@vger.kernel.org
X-Gm-Message-State: AFuF++mF6Lj+JdA80opePNkqYjj+M/88qP3Q/IgcRa4Tm7g49UZnGoyo
	yDAV466DDA9NR0d5IhearKZLGBiyxSrazbXe/aKRSGqCBvGjOTYZlVS1
X-Gm-Gg: AYBFou0XQkxG12aKtLf6Y+SxZR6x95IhCEOVSLVU0QqbKqXWjw9ytpXXrns6bxfpzcg
	Pf6U3gm+Asy/GkYuaF0mvX/nkw+T7+BnT7AK5S4C4onSnuQUI7/uky8iaFbxnPJ/9A3AvjjXA4z
	nWfRziDdv3Okfg++m4NbYZVU1bUIRKaVmx+vRKz6pbEU3ywIkIooeSbxMM+Wwpjm3R4AvDQGQnO
	jbTulSrvGU3tZpbNMqW3kLjAlZMx78GINNvzgkaXU1TERyJB8BQ1J7qWZyFAhh5E6m1GeSIXllq
	/ygFCyH/FT2dl+3v/GH3G1DteFz+n63rUV1fGv8krd99xoxxL15rHN39NN2w6UH+rL/NmOUR8sl
	HCcI9JyAq9okaJMrNCr2pQ5C5kW0vHEj1Fa+61I7iw6PC13aW1pbmUll4AhR22oYmjKI/CU1lsl
	szmR3boaQ7ZdKQOyVgtoauN6DjsKlKJqTSnOQ0tCITjkMU5PUhPWsn1g2MddFzDPy3dWQz0G7KK
	L4hbaexcimTGv27G/+XFc9WC1n1m8icesME3Szg7fMjiz+w4xKtNsYm8vYSb0fdDG0+DwQF
X-Received: by 2002:a17:90b:4a8e:b0:38e:4114:d8c7 with SMTP id 98e67ed59e1d1-39aedcfc81bmr12171133a91.0.1788392123330;
        Wed, 02 Sep 2026 16:35:23 -0700 (PDT)
Received: from samlap.tailb86931.ts.net (c-24-5-101-44.hsd1.ca.comcast.net. [24.5.101.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1431994fdd7sm1209199c88.10.2026.09.02.16.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 16:35:22 -0700 (PDT)
From: Sudheendra Sampath <giveback4fun@gmail.com>
To: alexandre.belloni@bootlin.com
Cc: devicetree@vger.kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Sudheendra Sampath <giveback4fun@gmail.com>
Subject: [PATCH] dt-bindings: maxim-ds1302: Convert to dt schema
Date: Wed,  2 Sep 2026 16:35:49 -0700
Message-ID: <20260902233550.947218-1-giveback4fun@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Maxim DS1302 real-time clock binding to DT schema.

Signed-off-by: Sudheendra Sampath <giveback4fun@gmail.com>
---
 .../devicetree/bindings/rtc/maxim-ds1302.txt  | 46 -----------
 .../devicetree/bindings/rtc/maxim-ds1302.yaml | 81 +++++++++++++++++++
 2 files changed, 81 insertions(+), 46 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/maxim-ds1302.yaml

diff --git a/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt b/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
deleted file mode 100644
index ba470c56cdec..000000000000
--- a/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-* Maxim/Dallas Semiconductor DS-1302 RTC
-
-Simple device which could be used to store date/time between reboots.
-
-The device uses the standard MicroWire half-duplex transfer timing.
-Master output is set on low clock and sensed by the RTC on the rising
-edge. Master input is set by the RTC on the trailing edge and is sensed
-by the master on low clock.
-
-Required properties:
-
-- compatible : Should be "maxim,ds1302"
-
-Required SPI properties:
-
-- reg : Should be address of the device chip select within
-  the controller.
-
-- spi-max-frequency : DS-1302 has 500 kHz if powered at 2.2V,
-  and 2MHz if powered at 5V.
-
-- spi-3wire : The device has a shared signal IN/OUT line.
-
-- spi-lsb-first : DS-1302 requires least significant bit first
-  transfers.
-
-- spi-cs-high: DS-1302 has active high chip select line. This is
-  required unless inverted in hardware.
-
-Example:
-
-spi@901c {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	compatible = "icpdas,lp8841-spi-rtc";
-	reg = <0x901c 0x1>;
-
-	rtc@0 {
-		compatible = "maxim,ds1302";
-		reg = <0>;
-		spi-max-frequency = <500000>;
-		spi-3wire;
-		spi-lsb-first;
-		spi-cs-high;
-	};
-};
diff --git a/Documentation/devicetree/bindings/rtc/maxim-ds1302.yaml b/Documentation/devicetree/bindings/rtc/maxim-ds1302.yaml
new file mode 100644
index 000000000000..3e6264464e10
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/maxim-ds1302.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/maxim-ds1302.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim/Dallas Semiconductor DS-1302 RTC
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+
+description: |
+  Simple device which could be used to store date/time between reboots.
+
+  The device uses the standard MicroWire half-duplex transfer timing.
+  Master output is set on low clock and sensed by the RTC on the rising
+  edge. Master input is set by the RTC on the trailing edge and is sensed
+  by the master on low clock.
+
+properties:
+  compatible:
+    items:
+      # Maxim DS1302 Real-time Clock
+      - const: maxim,ds1302
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Maximum SPI clocking speed in Hz.
+    enum:
+      - 500000
+      - 2000000
+
+  spi-3wire: true
+
+  spi-lsb-first: true
+
+  spi-cs-high: true
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+  - spi-3wire
+  - spi-lsb-first
+  - spi-cs-high
+
+additionalProperties: false
+
+examples:
+  - |
+    spi1 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@0 {
+            compatible = "maxim,ds1302";
+            reg = <0>;
+            spi-max-frequency = <500000>;
+            spi-3wire;
+            spi-lsb-first;
+            spi-cs-high;
+        };
+    };
+
+  - |
+    spi2 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@2000 {
+            compatible = "maxim,ds1302";
+            reg = <0x2000>;
+            spi-max-frequency = <2000000>;
+            spi-3wire;
+            spi-lsb-first;
+            spi-cs-high;
+        };
+    };
-- 
2.47.3

