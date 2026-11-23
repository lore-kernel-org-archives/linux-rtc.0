Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795474204;
	b=Pbfuu5A/jz9QEe8OwxT5vCdxdCPuzjVgKytH1T3N/Eqis2/5BvAyDmC1VkYICArszkcp
	 8VEaBCSX3hpFnCelw3MfiUg/6Zp0v5zSujNmqUbb3SojTFgXa3Y0IisihpedjS/dHH1ty
	 B92WsPkAmsD+kTj9v3TxXrZoL8gqvz3bIz5jdDwD3o3WAk+TEbOaYrhejp/wYPf1C+Yqg
	 os+uZFk6NTgHX2fyO+fyF/n096a7VX5bYfn3wHZJ6cXqByW3cJKHksxrJ5oghJCBWIEKF
	 WEwuo0kxV9DE3rz0RLd/bg3/2vs/GvQGUA/4Kct/39u8fZyaLvkCijq1doxJ4XIZQzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795474204;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aGR2ezp9P4Ja129w/l+m8Ayy/DbyQLAojBQ0FlM8kps=;
	b=U7Rf4l+tkYQLSLuix7EvjKw9r1GQv5qIgFKdPUNy9mVmamPH+XamyRY81NFqHnwzkU+H
	 Y4N9OeDjSP18eHrbpd5r+AbsHvPsT2gFy53ENBwr8mk+VQp6Pkb9Qb6/ZcUwICHAoOMrG
	 51LgsGytsXzFulJx7mloSIPzpJOZD54UCzkFNM4lfgvABw8huaf/UHasQ2DEcN/6wlSF9
	 3fS0b8EvOxbKPUaZjIQXyN+Cz8lkdGl1UqXEgGFv5G1bZL7q7IZPtSZ263Q3bWZxEVUPT
	 XnJaLPGE6QLMobMLYpG4TAZopxTRTpACnjok7vDzA+Ld61WlZ1I4QRptZiyAsUpT44w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQaMpVHT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E5D606A31E;
	Mon, 23 Nov 2026 22:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQaMpVHT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795474204;
	b=Zm50c1xB+pzZQe1th8fpFmOMMwK5CkTMwG3LjtPMybrQQgABcZ5gRzGCpWVQZt3fhps8
	 xuIe+FrAfnb7N6bhxx2DiPhXoNOnh71+3JFL36SKxmFjy3GK39CAVGrrRNta2lziRrleB
	 V3tuJxNgLJYl/gE7GYt3l9tEBmx5ZIMOsDZX0UxjmsLI3WOucFRBuWcSrEShN7T4jx7iA
	 Qk+xX1whqZrWZPp855LVjqmNZP/1eZUV8iPuVNmPAElHC7kEMAm+Zhph5q9Z5YxHVsJzG
	 pWvYEY3gYDlW9RoVZMZYhmN1Jc495s7fAcjhf9Kf9LXmpN2Jb2a24hooYFVOx8jz7Yg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795474204;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aGR2ezp9P4Ja129w/l+m8Ayy/DbyQLAojBQ0FlM8kps=;
	b=f/cARXIWrXCndgJ4q5sr64BDejCDGRrJAWMnMwgkXTa5GUC26W+qg8Y5qXI47XmUVMqb
	 RwZEHISeia2Dz9UcHhK3anQgINnLBJLcCFZeuGEmhi1cd2O5EN1iQTqpC6czgB10bPvWh
	 632W6k3k0Vl0957Au3ERgt4Lt7YpdMb9oUycDeiVRRIhdg4ES9QKcu+JqSGQLFIRxjtAR
	 E7jN8/Ur8RhA9m2yZJXBm08ws7LuQhaEC7hyFUy7dSB3lfIJAUdqWLJclV/q6GwKympbi
	 Hlt0Z0c82nn44a2U0r9tCLHgGaqSfy7VDxuiKYo2nmGp1j1CnG5eGELGhp+3vwYxnow==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E16CA1F000CA;
	Mon, 23 Nov 2026 22:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795474204;
	bh=aGR2ezp9P4Ja129w/l+m8Ayy/DbyQLAojBQ0FlM8kps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XQaMpVHTb7BArGyhjeF62QsOk5zJ3Dlg83buTDKE5lGaJ8C19chG96Ninjv+HufVW
	 Uhb4wRmYnOZeegy1WSZHQBukjfLSf3N6lnySTXDA8DFb6iCFc9TocPjRfTKIBxcgiL
	 Nzn8j2XAV/WFB1I1Z2tIMFMl5qNABD7jgq44x2qLZnVnZxNZspoE6u40MGabe3Mz8C
	 k/YLiD7y1KBs+fy+7nGSkvfX7vH3lzs0BtwcP0k54qNFjh96GNWqJ3N4O0AWq6/oUQ
	 AQNZ0ZDsE7sMGVyWkgaNjx4hoLzH8fCJNCXWYN5C7cVOgTjomr1ZiF4OqQutmICmU5
	 pNYELCgvOpEnw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 65D264C7A3;
	Mon, 23 Nov 2026 22:50:01 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 24 Nov 2026 01:50:01 +0300
Subject: [PATCH v4 1/3] dt-bindings: rtc: Add Cortina Systems CS7542 RTC
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261124-b4-cs7542-rtc-v4-1-bceefd844074@gmail.com>
References: <20261124-b4-cs7542-rtc-v4-0-bceefd844074@gmail.com>
In-Reply-To: <20261124-b4-cs7542-rtc-v4-0-bceefd844074@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795474200; l=1725;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=zpMLao1XyuPRjMljD/Vh3jkbZiWoCb7Hr28HjaR1ywM=;
 b=oR9esJeUokeEbZbQ02JskhlGOH4puiHttYHl17UuOIWe6aXpRWccZ2ZqaICQjdZb/s5vaU3mA
 14QGt6UnM/TDu5W93R1uxBzV6ZVsC19Y3sygKEm/Vya7Miqgi4SJZgB
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Describe the RTC register block and its optional alarm and periodic
interrupt lines. The initial driver supports the calendar without
requiring those interrupts.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 .../bindings/rtc/cortina,cs7542-rtc.yaml           | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/cortina,cs7542-rtc.yaml b/Documentation/devicetree/bindings/rtc/cortina,cs7542-rtc.yaml
new file mode 100644
index 000000000..8c2cc7ec9
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/cortina,cs7542-rtc.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/cortina,cs7542-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cortina Systems CS7542 real-time clock
+
+maintainers:
+  - Fil Dunsky <filipp.dunsky@gmail.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: cortina,cs7542-rtc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Alarm interrupt
+      - description: Periodic interrupt
+
+  interrupt-names:
+    items:
+      - const: alarm
+      - const: periodic
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    rtc@f4920000 {
+        compatible = "cortina,cs7542-rtc";
+        reg = <0xf4920000 0x50>;
+        interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "alarm", "periodic";
+    };

-- 
2.53.0


