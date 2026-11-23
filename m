Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795465639;
	b=g4JxQBju+WwhCm9x2iAfoSLY/wyM8QcVvUEEUJbZyIBJRem247sCXAjjugB1Q2I5ItuT
	 XIKnl79LGXFpvb7ys2n8EEzJA16+3m/1pbMMhthpRtVo5aQdJN2mMWT/5tNlhCI1lKHb7
	 R0gwk0tr8w6Jhh2cDPqdvEPW6B4GdTwIK1xlaMIv2Cnf5QAPV6nP2pNCR7Le8ALZ4msJM
	 0iFZgpKIpf5vxePU91490bToUpx8BsgnEwGu7ndJzVCPCZIay5HDDXvxEt5abqNrHPql5
	 EUMXV94WSK7Phz9CCsf0qbBOJR0awS3CpD2dQABunECCOBa34DfLpXVEaM5ytPruH4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465639;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aGR2ezp9P4Ja129w/l+m8Ayy/DbyQLAojBQ0FlM8kps=;
	b=2SFr/C4p7kgAlBc39qxhkZxQyv/5cLfJrvWfsqWAb0UyhFnlRDwBB/gwQh8Wze/2UbYy
	 Ts0o3/GcLMLEHB2cj8AheVR4UbvGe1e3+TQdXVqEsrTQ6opjtuNalxKMt4ncXGVoTplWp
	 CZ38lrfpf4+46GKGpv14eg7/ipXp04ImaTJNyhBvQJrSQxQYYQMzX73BcrsieEBE2gSPm
	 oG2zQ9cAY+BjhubrIt6MBrwe3IT7cA0TIb1LtITDjfpuV34uUeXq6hGrKpNfAw4I/EcoS
	 CXO4pkBFxzHQ02KPFftvQYKqHKGNuxJvIPFlJM/AeKFhoGXAy+LpLjAelv4MNTbVBfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hzgj151+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CF0606A327;
	Mon, 23 Nov 2026 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hzgj151+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795465638;
	b=tRNvCxYUhVZbmTRZOleBvVc3DJDPTzHsztEJ3QZ3EkyCQwBHgZzRYNMaD1CX0RTSyh38
	 RNczwHElX2M3Y65lpqLgfUWZ9H9hp5ZWU6Vfix0246ocyTGDdVKyipbbttFwt6Q5laEwt
	 s7e8FX4nnuPPcJ/1loElIAjqNohHNbmm9iH/rMr0n1ESsNVYz6GZklP/9JpPHzBeuuN8g
	 gLGLF8qR/Kuq+49ZcOrdx+P+raz+iriFC1QrS5wnoxLmB+N4xqp3aC8ZeAX2UNIJBj9Wt
	 7hwq4nvbMnNvv0Zdk2RVuER7Exce0e8/R+hOKX3NoaLf43d7+2og5GmN3eFBuGqnCqQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795465638;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aGR2ezp9P4Ja129w/l+m8Ayy/DbyQLAojBQ0FlM8kps=;
	b=L4LxUgBiqLeHf5zPFy+XXrjYmSRSWlmX8zNfLrtMkf0hMprdGShIr6mwB+F7pb8Z+d6b
	 xva2Kz0XJM1mGIjw69iZY3vn0p9DJCIEOs5krluGN0fkJcZo3CFSkeRKBO135hDxpqA/i
	 NDuWdYTHaQSv9CVrWBsdZnVNbCFZrB0qOiK18Ou+XmvtC8y9pxtE6edDjSVohvCSO69jY
	 PijNRM9s6DsVGSPiOAQJL8uzPa3bkwsOKpbn39rQGFCU8YZIGxfAXDXzdIlGHBogK4QZ2
	 b5f5k/Vmo2I6XD1MBBSg+ILRF++g897kID8zbE33OsRwI0UvItMh2RLDXj4olorvhNQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 017461F000E1;
	Mon, 23 Nov 2026 20:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795465638;
	bh=aGR2ezp9P4Ja129w/l+m8Ayy/DbyQLAojBQ0FlM8kps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Hzgj151+NwAmSMHt+m/izquWWqn9ZhK+/OfJqCP3s++jZkNdJr+esxwg/cuqHyzYq
	 0B4pJzVkkZkoFTK5wTvb5JHCH9dcNfHDmoxLxLC0SrfJ/GOvkgZL+Uwe17UgY2Fs6U
	 alnHzsP5kj3Kq3hcutWiRCZiSYN2j7d2LY8EDVmDSDjU4Zma89Oy9fXH80LImFL1qd
	 bYK4NOyRl0zBbZSOdRyPsfvx1ng46qw3YVNAg3BIXs+mrsXN+ZKzM7+jiYyM5xIRp4
	 Nd/rY6JnTLutDikSgt2rlHOGCbfiFQHs+JBl929YC0aB5aIQPFGJCY+bQ7Q7otIPky
	 nrvYppuVey1Hw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E7C0C4C6E5;
	Mon, 23 Nov 2026 20:27:02 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 23:27:01 +0300
Subject: [PATCH v2 1/3] dt-bindings: rtc: Add Cortina Systems CS7542 RTC
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
Message-Id: <20261123-b4-cs7542-rtc-v2-1-31ab43f2cc8e@gmail.com>
References: <20261123-b4-cs7542-rtc-v2-0-31ab43f2cc8e@gmail.com>
In-Reply-To: <20261123-b4-cs7542-rtc-v2-0-31ab43f2cc8e@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795465620; l=1725;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=zpMLao1XyuPRjMljD/Vh3jkbZiWoCb7Hr28HjaR1ywM=;
 b=rgWjdyBqwkccymgs+66LRcOFRHAymzficDjJPiPZ6wbISh87UlsKnhE3TdzWoT4jiKxCN9CNb
 8BRtVAQimPiDYoFVBUxQ3ISP15IXn2jlhkWnwwJRHN7+7g9kM7wMg78
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


