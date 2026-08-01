Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEEF3A254D
	for <linux-rtc@vger.kernel.org>; Sat,  1 Aug 2026 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785609790; cv=none; b=r1/iPIYzBzb5+QhBclXregWP2Y0x+7vOXj2IpX9w83dXbNy+fqB8VJTJVlhPySmWLCkwXcM9JnsA+7rA4sY0ulH+nQ9TdSiWzcl9u+Ufgm3WPZheah3yCqpmMvWtMuRAviz2kA6ddRvFf64JQGpxQxS2c8GH9LckQYGeeUvmIuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785609790; c=relaxed/simple;
	bh=E5JWAN0m1kGY1R7OT60OGbYi4BBz/4Fe+OiDxuBLstQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e2ChA0jMFSIwfaWnjA38Rl+Nl18vQ+C1cikZYLc0qVZYPNHFjt/w4a3O6nKixf5d1NZ4aa4khGj677JCJGqkfpwbcO9SAUlb2V87Ei6PZ9xTUlPRrvPvbmN+CVCSVQuOJPUEpR909jDdj7Afmum93p5u1MWsMVKR35ZJ3Pgam4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=moC0bcII; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="moC0bcII"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id F0BC7240104
	for <linux-rtc@vger.kernel.org>; Sat,  1 Aug 2026 20:43:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1785609780;
	bh=MLNXXaTC+Mcmzw26XB4POwyxYI5GqXN0i5lg+Jg9plI=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=moC0bcIIS1fuXl5je42CXRVqSYvlxgsah9d6pyXLhL+TU1YUzgYMbiF3aU8hD8zy8
	 CJWTOhzyhgFDSqG01KYeJ2+M8nTAlT1uUTeEGpbdishD9enaLyMkjhqdS8W/mXz0FT
	 MUAWpHbQcaDzRt3qrw3YT+L6T/RMmMoFDAZqw6KVCAiBFAUChQqmg+c67VczXmW4ht
	 3Pxlx5vWcPgQvj58jGBr/P1TzG2oOolaY+aWLXwGs2j53R6/hzoY9VM7AsmMnIZyK1
	 RYbSSHTrmaNzqCtY3Pl4tpuk6BGOOCk6JFP4gfM2iAI4QdF9DRoXiNRAUiEqge0pDw
	 tilh9Z/HWpEYg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hCBdb2RDcz9rxM;
	Sat,  1 Aug 2026 20:42:59 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 01 Aug 2026 18:43:00 +0000
Subject: [PATCH v2 1/5] dt-bindings: rtc: Add pinctrl for S35390A
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-rtc_s35390a_int1-v2-1-f10c99ad1d6c@posteo.de>
References: <20260801-rtc_s35390a_int1-v2-0-f10c99ad1d6c@posteo.de>
In-Reply-To: <20260801-rtc_s35390a_int1-v2-0-f10c99ad1d6c@posteo.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Michael Langer <michael.brainbug.langer@googlemail.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6263;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=E5JWAN0m1kGY1R7OT60OGbYi4BBz/4Fe+OiDxuBLstQ=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqbj4vCStqgMlwnH7BhUZZeIzKJgqwvZlg4RCdu
 UqtzvFQIr+JAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCam4+LxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9KhNA//WTK2pjSSolcj2B1XGKAGoDCTlEfyys5
 olp0VqTvC9gpsJyLWiYyNyXPuj1bwwUyebR91ZzPBTZjQZTKIZdSuIUfFGorU5AAnCU6AFWgiu2
 B5D9EPXmRyyBxHuF1GpXDtztbttvn61qgJLdC/nEul0J764OCPEOEblUMSvL6Xgn2ceaf4uirVn
 zvN02DAWrynvFCsQARk98MfmOSrYoJJ+RJA6VEvCPDnSbFch2ASYMHfOiqlRWtUBkStwkPrn9aS
 87cN3EgPwhMJ7myFbi+Hzh5UCHxVwHG64+C32ieNvBkFXNX1GvLOW4b278gMNab8z/1qyMCq2x9
 9TulJ4NoGQ4o6rCeKPoXyD+0Q9VP/WP+5J/djpN2Zns1CxsgOgoIQHDgV4XABO1p0o9oSd+fHs8
 myksSEXpkj8Ru+Q9sp1NavmpV874Km7b7y/RI7FghgQhYxOYEwSnsEmKpsob8kq5KpOTm3rCwPP
 n0R950BvMIfURHh/s+zx7z80IAb5TdFaKj7wRB6zORfCHNpErwJqrEw6hGnxO+LooXrfxg+HU3p
 C3Nre0O5UALmkgBtEtUlNY+sKNTMyNQ4SqU0RxGrPRyjOBIcQZJvxx4KvTRUTUAhh3N4vrNellk
 0XrASOtk3tKD+URKLWUmk83XAr2FUZ6/xaHJSc1v9DQoOBz4defA=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Synology NAS devices use the output pin for interrupt signal 1 to wake up
the system.

Move devicetree bindings for sii,s35390a into its own file.
Add necessary properties to configure the individual pins via pinctrl,
which allows the interrupt signal 1 to be used for wakeup alarm.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 .../devicetree/bindings/rtc/sii,s35390a.yaml       | 119 +++++++++++++++++++++
 .../devicetree/bindings/rtc/trivial-rtc.yaml       |   3 -
 MAINTAINERS                                        |   1 +
 include/dt-bindings/rtc/s35390a.h                  |  23 ++++
 4 files changed, 143 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
new file mode 100644
index 000000000000..78a049576d5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/sii,s35390a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: S-35390A 2-WIRE REAL-TIME CLOCK
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+
+description:
+  The S-35390A is a CMOS 2-wire real-time clock IC which operates with the
+  very low current consumption in the wide range of operation voltage.
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: sii,s35390a
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+    description: Supports up to 2 interrupt lines via the INT1 and INT2 pins.
+
+  wakeup-parent: true
+
+  wakeup-source: true
+
+required:
+  - compatible
+  - reg
+
+patternProperties:
+  "^pins":
+    type: object
+    patternProperties:
+      "-pins$":
+        type: object
+        properties:
+          pins:
+            $ref: /schemas/pinctrl/pinmux-node.yaml#/properties/pins
+
+          sii,mode:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: |
+              Modes for the specific pin:
+              - S35390A_MODE_IGNORE: Preserve the previous state.
+              - S35390A_MODE_DISABLE: Disable all interrupts.
+              - S35390A_MODE_WAKEUP: Used for waking up the system.
+              - S35390A_MODE_ALARM: Userspace defined alarm.
+              - S35390A_MODE_FREQ: Periodical at configurable frequency.
+              - S35390A_MODE_PMIN1: Minute periodical output with 50% duty.
+              - S35390A_MODE_PMIN2: Minute periodical output L for 7.81 ms.
+                                    Can only be used with pin INT1.
+              - S35390A_MODE_32768KHZ: Raw 32.768 kHz output.
+                                       Can only be used with pin INT1.
+            minimum: 0
+            maximum: 7
+
+          sii,frequency:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: Frequency in Hz to be used with mode S35390A_MODE_FREQ.
+            minimum: 1
+            maximum: 31
+
+        required:
+          - sii,mode
+
+        if:
+          properties:
+            sii,mode:
+              const: 4
+        then:
+          required:
+            - sii,frequency
+        else:
+          properties:
+            sii,frequency: false
+
+        additionalProperties: false
+
+    additionalProperties: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/rtc/s35390a.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc: rtc@30 {
+            compatible = "sii,s35390a";
+            reg = <0x30>;
+            pinctrl-0 = <&rtc_pins_default>;
+            pinctrl-names = "default";
+
+            wakeup-parent = <&int>;
+
+            rtc_pins_default: pins {
+              int1-pins {
+                pins = S35390A_PIN_INT1;
+                sii,mode = <S35390A_MODE_WAKEUP>;
+              };
+              int2-pins {
+                pins = S35390A_PIN_INT2;
+                sii,mode = <S35390A_MODE_DISABLE>;
+              };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
index f4d0eed98a08..7b3f682ef4d5 100644
--- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
@@ -81,8 +81,6 @@ properties:
       - ricoh,rv5c386
       # I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
       - ricoh,rv5c387a
-      # 2-wire CMOS real-time clock
-      - sii,s35390a
       # ST SPEAr Real-time Clock
       - st,spear600-rtc
       # VIA/Wondermedia VT8500 Real-time Clock
@@ -105,5 +103,4 @@ required:
   - reg
 
 additionalProperties: false
-
 ...
diff --git a/MAINTAINERS b/MAINTAINERS
index 716acfc3d7c1..c85be1eefdb1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22696,6 +22696,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git
 F:	Documentation/admin-guide/rtc.rst
 F:	Documentation/devicetree/bindings/rtc/
 F:	drivers/rtc/
+F:	include/dt-bindings/rtc/
 F:	include/linux/rtc.h
 F:	include/linux/rtc/
 F:	include/uapi/linux/rtc.h
diff --git a/include/dt-bindings/rtc/s35390a.h b/include/dt-bindings/rtc/s35390a.h
new file mode 100644
index 000000000000..dcd0ca15f9e9
--- /dev/null
+++ b/include/dt-bindings/rtc/s35390a.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
+
+#ifndef __DT_BINDINGS_RTC_S35390A_H
+#define __DT_BINDINGS_RTC_S35390A_H
+
+#define S35390A_MODE_IGNORE		0x0
+#define S35390A_MODE_DISABLE		0x1
+#define S35390A_MODE_WAKEUP		0x2
+#define S35390A_MODE_ALARM		0x3
+#define S35390A_MODE_FREQ		0x4
+#define S35390A_MODE_PMIN1		0x5
+#define S35390A_MODE_PMIN2		0x6
+#define S35390A_MODE_32768KHZ		0x7
+
+#define S35390A_MODE_INT1_MAX		0x7
+#define S35390A_MODE_INT2_MAX		0x5
+
+#define S35390A_FREQ_MASK		0x1F
+
+#define S35390A_PIN_INT1		"int1"
+#define S35390A_PIN_INT2		"int2"
+
+#endif /* __DT_BINDINGS_RTC_S35390A_H */

-- 
2.54.0

