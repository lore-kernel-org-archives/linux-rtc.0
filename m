Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617B93CC7CE
	for <linux-rtc@vger.kernel.org>; Wed,  5 Aug 2026 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785958351; cv=none; b=KwsfuMLS51v4OM8kNu2hxvDfREtwSg7DAL4nrzbrzfAbcOLlhN3/QUBE51fXJQfup/7ngVc0ou8cEJDSyDvdtW5oOO4zlf65rRXrjAvM8ON1ciOgu2vWtKQIQV/1c7UOvzB27YY7QteljnvhQwy9mCyBuwInyrSPCcJCZH6dAdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785958351; c=relaxed/simple;
	bh=ipSRT20Aft1lwNt8pGJiWIzMDKcRjF8APfy0A6t7JtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RvvY6ayoYX9J/DksfnK5oyAiLm5x935/LNu/lLmZ6b/6+F4vuSkM3f2PklYiOLDWdIPXHkQw0Z+Nczme+Cv950DR8UwhN3h5XmWD0mIqybc2vsdT0t9iGse+tLLNTyGQsRhHzcbYdDsjxbgCvh83C+lf67Wgq0qm1TXencgMLKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=ZpI2V5KA; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="ZpI2V5KA"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id D033B240108
	for <linux-rtc@vger.kernel.org>; Wed,  5 Aug 2026 21:32:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1785958347;
	bh=uv9tpj0u3TV1pFJXvO27WgfoME45rFUWLiaBnkzAOVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=ZpI2V5KANcZ98l00rTt/YRVt0pPbruhiTu4goB7664UwFp9VaXu63feYbVRHTtqsk
	 m5aRKA000WeL9pesKSqaXshuHi/KpVBauMhEvMsb824m0+UufbBnOYStBO8h5Ud0i+
	 h/bg1fXl08/r15AmtLF8WjvSmi/Mm0pjrckQ6DwGB7kWeE26lZZPjkf7BfubifX6MI
	 OOexGP3zZVtfQqPyDuhxhOrV1eSRb4NtnXQRfgmAA2Y2omBe3C8U9e4li0pw/g+cJs
	 R+GDBpP2V7GNw+WVVE/XkM+a/N6D4GvvKyF+uJ6yElGr19txsS/8X8PekVTb3WJqu2
	 uZtlPKQmHiWoA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hFgXn6D8cz6tsf;
	Wed,  5 Aug 2026 21:32:25 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Wed, 05 Aug 2026 19:32:27 +0000
Subject: [PATCH v3 1/5] dt-bindings: rtc: Add pinctrl for S35390A
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-rtc_s35390a_int1-v3-1-e836faba3e25@posteo.de>
References: <20260805-rtc_s35390a_int1-v3-0-e836faba3e25@posteo.de>
In-Reply-To: <20260805-rtc_s35390a_int1-v3-0-e836faba3e25@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4709;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=ipSRT20Aft1lwNt8pGJiWIzMDKcRjF8APfy0A6t7JtE=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqc4/GvRHM9pIroPXsxpkEUdnzHAaOYRPl4VqRN
 wrJ3dUFkfSJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCanOPxhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9L3Mw/+OeXDQ+lfWx7YJjH8kh3pj4JnXJDeX6f
 IC5mPjJ2TuhMdSZBeimNV/IOf0IdR47D76gkxJHG83uo0HBuXxijHMQW459jUE52nv0vkJefL6b
 QMSMChjK4cj0EMppNUEKf3aOY+UENAVeZDUEv9n4k3OjRCQ+e3vMPQV+Lj5Dy10Cwz9cAXePEfx
 ihaIVgNDF1ZnAFjfS9FI43a5EJYL5pdoxUDXERYbUkoRsTsFj2DHfq2jDpDJerKxQI45cg9+zUX
 QvaK1pd5PH+TSkwPq+AIKhKqu0tX0S4poS43VSZWcZp1wntXzkOW3sCcKWIoctX/OAa1z33x0Bn
 NLkGaK0VSVfBJcaqXZxMaBXkxu9drtELVZf26PH/5eJqUrOpuOj3MSCzsKcG4LkkcToHaXX9oPc
 ASW6Gz494Jd9ddr5o7NnHfc5dBGK2lFQAsX5oMars99aemPkDu2eXSR9AP9/LKjcCLJHLFc+E0L
 9/Qp6X3wPWb1o8sPkYyqPOYGDs1RCXk5kx+wjYIYo2VVsELqq2lO0NtkrZELqclWJ71m9wJytyv
 BMHCdLlGceMrRcWTsnNET21jKcqGKz6PTMGPdTn8Y8zpVx2Ej9m3s+7dsHan1vzSlRW8wEPxWSK
 IYAqVpEMx3tveN054wFUEdXJNfrGnkFQmmy02fLtxgKkx0d574HU=
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
 .../devicetree/bindings/rtc/sii,s35390a.yaml       | 109 +++++++++++++++++++++
 .../devicetree/bindings/rtc/trivial-rtc.yaml       |   3 -
 MAINTAINERS                                        |   1 +
 3 files changed, 110 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
new file mode 100644
index 000000000000..0355f17f233a
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
@@ -0,0 +1,109 @@
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 5114e6db7307..4c8bc35cfe55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22695,6 +22695,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git
 F:	Documentation/admin-guide/rtc.rst
 F:	Documentation/devicetree/bindings/rtc/
 F:	drivers/rtc/
+F:	include/dt-bindings/rtc/
 F:	include/linux/rtc.h
 F:	include/linux/rtc/
 F:	include/uapi/linux/rtc.h

-- 
2.54.0

