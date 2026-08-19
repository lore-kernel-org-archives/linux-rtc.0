Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27BB3A5449
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787177157; cv=none; b=uuuq9shyEFsE7tW2dTcAlE+ywot9J9KFzYUxdGlOwPL1hwbwhe3g4cE46RifUia2/tg5luyMcg2wQQ9HCwQK5VevjnX4YNI0/ffdvCiOcgERX73kcMWEYebU75I1rEsjZ99S5eF+7gz3tTSlZRqzvpeKF+ZG6MIg4MVbhGbPYag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787177157; c=relaxed/simple;
	bh=/RN4bcc6JZOueMRQ2yaP4BUuLLpjTzlr7/VSEGCklNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QjmlLNcFyHNlGlhFvwNVgm9Ldk9eI0bZsV2gHPzgq81mARrP3rqPqiFOx6uKxtqWlmyNTBHMM/xpOJeaa1VCc+H3Z2EXIfRkxy+DOiHf7BAcm7FGetUsA/FLyPVy2JwicMCej2M41apzaLq8RAT12iOY4p63XaGNePIGLDTeiLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=B7hCpQg8; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="B7hCpQg8"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 1597224002F
	for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 00:05:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1787177154;
	bh=ELtl4sHgY9Ch4KYBqdzaGVJ+wwPAgLu5Sies0dF8+Lg=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=B7hCpQg8Ugg/JQfhJw98lW8JRtxQlNeZOBTnF1YSNlvMnP+xz+/Bl5sPf2xGMijQl
	 hN8UCLpCL0XuH9wBwPjW7tMheEUINygJutsUvGgSxKDmq3v38AnVQaIP7lAtgburoX
	 lcTm1in0PhlU0sfq+fU7e0GBeKN5E+CwnjYq0qNS58/0NsbX92qvsQxw0Hip8+Av+q
	 4FETHbVlVorYepD4VrWjjQsLy54Ym8eid185rXG5UuKT4Z+Dqj3TXX7cvtf/q5N8md
	 W9jruZKz3OQGj8PWDoSwR/6WlWloKc6YCmAh4CVzvCKySyHLF2xVMu6dHg2CJtK/vS
	 auQ6RcNIhgoCw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hQLHN3gmPz9rxL;
	Thu, 20 Aug 2026 00:05:52 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Wed, 19 Aug 2026 22:05:53 +0000
Subject: [PATCH v5 1/6] dt-bindings: rtc: Add pinctrl for S35390A
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-rtc_s35390a_int1-v5-1-5eb4ef85c6a9@posteo.de>
References: <20260820-rtc_s35390a_int1-v5-0-5eb4ef85c6a9@posteo.de>
In-Reply-To: <20260820-rtc_s35390a_int1-v5-0-5eb4ef85c6a9@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4267;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=/RN4bcc6JZOueMRQ2yaP4BUuLLpjTzlr7/VSEGCklNo=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqhii8D7IaVVkAhB9EUWXeIteCdgpVafSwGHZ+n
 n53JN5ecyWJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaoYovBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9JQog/+PFx0uR5U2uVc7m1HEiY1bEsjeXupbhP
 NYU9bZCYBFGJ2B7lsOtfv5CSOyGWJ9lFByLB2r4OEArh+CpuCtZ8vAc3R+C2xW+8U2su1wetW6T
 fVBD7E1D4oN8kET+CDAGXg/qgtVqHMdM/igHS7OvTx3ocwjttsM4zEKA/PvaNVf/+FS7a+jlwpF
 RCMj4BsRGQbLFKE/nyTf/2gUOROO8ZQIK+sApFn3Wa6Zb/Tq9EivlbXQERG/2GxGVkzehvw23RX
 nrsTPm/JqJpQr+crLhmkgu6AEli4MOCna2374RrCSpl9zgqxr3XHNx3mRPpsi9YryT8S4/nztmA
 DExpjs6HuqYEDKEgPc92+AVEwPQYFnVSYxsnFKyFrK6JHj/lLFHXm5iZN1egFXn+IrSJXIXgShy
 QtG1YOSdVp03Bizrl4Bv/TA4P3O79BCk+spVqu0tFuJ/U0wJl71hfiMlEZ4SMO6Q5QMwzsR+PCm
 UUPxjLlrogPalAcatrVu5Zvf6pUxMEjR3mgjntnIyopJ6s1kwrd6L+Z3+FS1DOXSLE99qlEdhdd
 yaOIdtZaIJF122RQqsERYFIBJk675nYCmC8O3KE+k0DlufG672A7I1MO5jvmM9tHXKn3peqKNZ3
 IZgUWkJWU74iwsL4qUmEdKUnmTVq24qjvL2yxndpiEZsaM0UdXr4=
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
 .../devicetree/bindings/rtc/sii,s35390a.yaml       | 111 +++++++++++++++++++++
 .../devicetree/bindings/rtc/trivial-rtc.yaml       |   3 -
 2 files changed, 111 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
new file mode 100644
index 000000000000..d9da3abbbd51
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
@@ -0,0 +1,111 @@
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
+  "#clock-cells":
+    const: 1
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
+            minItems: 1
+            items:
+              enum:
+                - int1
+                - int2
+
+          function:
+            $ref: /schemas/types.yaml#/definitions/string
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
+        additionalProperties: false
+
+    additionalProperties: false
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

