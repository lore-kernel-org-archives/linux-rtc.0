Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E1C429CE6
	for <linux-rtc@vger.kernel.org>; Mon, 31 Aug 2026 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198739; cv=none; b=gPm+hiFDho5VDVAW487UzhENk6Xw5wxzbbl2Rxdqm01NvQ4S5kIhoGUyz1LEwaEiGPaTVvvYx2AbdMcsq3SaLJGuNjF5N0iOM9oAV8IaFvmT2MiJ8kX6KpmcDJCHRpjCckrdwFEWIHlgovRe4Cx9xMdVQj7eXmnFanYhfe2IrfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198739; c=relaxed/simple;
	bh=iOtkHFM4xA6Q6ENokRmm5ajvtmTFnJJq+Eo17/gQs/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OQn5liGWob660roscVWXKS3lUAe1YxWqDLwrAfLBqijJfS5zZtjx+YpbJqG6rLe441QJgpV4XAN57QB+cEBfQ3MiUJ0xhG04har9g9NncYw3MK4enjDrYiQ1J3MeHIU5BJAhPjDvGtLGrEzDYdok4MPWBuQOE+I+ckSrtkAkW1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=AN/6v+S1; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="AN/6v+S1"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 9521D240027
	for <linux-rtc@vger.kernel.org>; Mon, 31 Aug 2026 19:42:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788198143;
	bh=L5e2mIMLldSTVVXlkj+JfWc212Mt4e7gBItG7XdpBdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=AN/6v+S1pMI7JHGWhrEQ5jxqDmWfB+v1agACxvEd+u7VS15NPnFQcM8yZBxUZ1MYv
	 xDGNP8piTbfgnDJswIl5FEVCRFmReogb0yXbOmYV3dBZqhrrdZp6ZNRA+2I/Ma0oyr
	 In4UKoLmfaZ/RDbR3coLblVcHFnsf9DN8AVGPkFfkT/4kZhjM4pMYghEZIkv9nZh2B
	 +FGHoagMtBIq5J+wxB7/632EtPY4EcxohVt/yQM7iFYW/ZFwMpkucXJoe2QM63BpbY
	 OiJAaCYF1imylTNiAIoj9FfHhv7CK/UdW+0OuVzHBhly9/jYFBmp2SXFmHqzaIpOyO
	 /ys8QaH1jP4rQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hYbsn1Vphz9rxM;
	Mon, 31 Aug 2026 19:42:21 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Mon, 31 Aug 2026 17:42:22 +0000
Subject: [PATCH v8 1/6] dt-bindings: rtc: Add pinctrl for S35390A
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-rtc_s35390a_int1-v8-1-dac1dc86ce1f@posteo.de>
References: <20260831-rtc_s35390a_int1-v8-0-dac1dc86ce1f@posteo.de>
In-Reply-To: <20260831-rtc_s35390a_int1-v8-0-dac1dc86ce1f@posteo.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Michael Langer <michael.brainbug.langer@googlemail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Linus Walleij <linusw@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4282;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=iOtkHFM4xA6Q6ENokRmm5ajvtmTFnJJq+Eo17/gQs/4=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqlbz5DaV99XzebS7Fi0bVSnHiUSXF93zcPM8pz
 gcssd5/wjqJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCapW8+RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9KMAQ//YEFW5Ch4Js3fpHtsawYcnM0yxnPDPV9
 46/cVOCt80/cqHvAaT0OA0UNu+NwW/HBckbLc+P8Qnn4z/cNBm04NneQRzUUgXaonHKk8uowkkG
 Qk2l5S8+3tdPfe/ejl/pB3f21bDT3wZxyi3u8TaRkh1vOl1LYwmJ1drDvX//NDrXX9srLdeyZYj
 mLxMcz+xrN4vrHNJlIa8aBuGVzbn8UfTZ4LWNtzrE3zqEKFGnDaySHbwRSKnDjNla0gnx+D7f/3
 un0oK+LqettlxG2BPPboTbXah7CchxfTBMcUkiU51CtFyAZUY0V/8pOBNDUksUufs4Ge6GNZY6f
 KVRk7C2vHW3V29epR/xIn+K9euMqymJC2CipmIWbVV8sOxC3f//bSv6MM7nIKnvCQHHO5zagUSZ
 vffbYo0Vjy5nY/DnXxW7PZ/qgwbLWkHVCX83n3DMK0RPfkVcvIACWdW3OQN8t5cIkrpgNUWGR+Z
 DgpfTRredL9DjXttcf5ecsp9x0xS2MVWhmn3USlWx23BhmUorDlfu65WVyWFDH+F9jCYa+d3+tS
 aMHviNNpg3jVLrYzp3GJvUL9gHcM6JoEHC6rXjOB78hkIpHVf8EvOqVaU5vA7TrSK02uQUCqOuy
 BNL63VdbR/m+H1+OgM8JMB3/YAskzXcS5e5YifTu2GZ+H+7aGaik=
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
 .../devicetree/bindings/rtc/sii,s35390a.yaml       | 117 +++++++++++++++++++++
 .../devicetree/bindings/rtc/trivial-rtc.yaml       |   3 -
 2 files changed, 117 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
new file mode 100644
index 000000000000..dfe632c4b2c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/sii,s35390a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: S-35390A 2-WIRE REAL-TIME CLOCK
+
+maintainers:
+  - Markus Probst <markus.probst@posteo.de>
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
+  interrupt-names:
+    items:
+      - const: int1
+      - const: int2
+
+  wakeup-parent: true
+
+  wakeup-source: true
+
+  "#clock-cells":
+    const: 1
+
+patternProperties:
+  "^pins":
+    type: object
+    additionalProperties: false
+
+    patternProperties:
+      "-pins$":
+        type: object
+        additionalProperties: false
+
+        allOf:
+          - $ref: /schemas/pinctrl/pinmux-node.yaml#
+
+        properties:
+          pins:
+            minItems: 1
+            items:
+              enum:
+                - int1
+                - int2
+
+          function:
+            description: |
+              Pin function:
+              - ignore:  Preserve the previous state.
+              - disable: Disable pin output.
+              - wakeup:  Output wakes up the system.
+              - clock:   Output clock pulse.
+              - pmin1:   Minute periodical output with 50% duty.
+              - pmin2:   Minute periodical output L for 7.81 ms.
+                         Can only be used with pin int1.
+            enum:
+              - ignore
+              - disable
+              - wakeup
+              - clock
+              - pmin1
+              - pmin2
+
+        required:
+          - pins
+          - function
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@30 {
+            compatible = "sii,s35390a";
+            reg = <0x30>;
+            pinctrl-0 = <&rtc_pins_default>;
+            pinctrl-names = "default";
+
+            wakeup-parent = <&int>;
+
+            rtc_pins_default: pins {
+              int1-pins {
+                pins = "int1";
+                function = "wakeup";
+              };
+              int2-pins {
+                pins = "int2";
+                function = "disable";
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

-- 
2.54.0

