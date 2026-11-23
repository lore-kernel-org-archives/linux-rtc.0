Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795471216;
	b=DK9dfzYqCOBYZBdaGNJVXlUq/cjjtNmUdPL7mcUC3nhnb2GeMSvVKqgHDqt8lzMI+1sm
	 GKxlOShKOTu7d1o25LtJ0zM8C3dR+yEeKfzAaP/o7TP1x/TKcsFJyd4ls3TDzF6EMKvY8
	 +iuIUYnuz045cDVG5dpOKAzn6QTm2rSgEV1VGZc7V7FR6TBNnCkC3KoLFwSughwimy6O7
	 JYzgCdIdM7yDTbH75b/945z7oFWKqMZiIwjwJtOG2psDvbGvIPksovK078Ya+iCb1wpwN
	 tYc9UuX9ZY8hW41Ui4yuMRk+kZkgZIb8FBioetffmaE08Rjlh+rrDK0VG+w7sa88qDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471216;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aGR2ezp9P4Ja129w/l+m8Ayy/DbyQLAojBQ0FlM8kps=;
	b=kS0EJbSayWwuNvFNIC9bQvE6dqC6y0prQ2gSXOGlLgQkPq/BSHsSNSBJIVzP84+i9+Mi
	 XMaM4IqD2aGUmjEweTAzegl+z+N48TwaI13mA/gGQRMkDPs6FrHRkb4P1XEgWYMzHS3zy
	 Iizf2pS9d9UpfjyKpikzQPW/O/aZFso6vrtuMC6mH+gE6nseKocFGnXZ/VoOERuH1u5e1
	 yiMLlxZRRAKdVHCFrI1r6b9gf+x/FQcJwkbZCj/wNpOFMk0OdHYzYoQ5TaB4WgXJquqlV
	 pYOoXZZpgFzqcKBli67gOnM9pjMrIXLZTESOBIN40mtg6WmyiHENVqcBGNnNxPC5QpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ej4sFNGa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A14E606A330;
	Mon, 23 Nov 2026 22:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ej4sFNGa
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795471215;
	b=EVZURYWsCpEkturXxd+fwafkwYF/mCnJUcaPQCwT6JFrWmulLRISZkCTjTc9s36ebm0K
	 K3JSt29LxdO8sACAbMuDZ1noeEaBk8XKTmq8CWz/3C+gGk6NVDJYG0gSG6kpFbxUbCZnN
	 jbOkFlntrwXuTzOOPgBmvfYemv2xDVaSXBM3V+K3zcjeMHwp4RbxzUsdet6rmlg4lyM7H
	 4x+/D2B2PdeulzcuDGW97Yma6a+wZjfHind6r3zGhOd24rkfO/eJXOKcawvKQys/d0UfN
	 MzMAhjWYbymE1ZBPUFAm+GcsMr2gRJPVhpFX16ArIXOuUc/Ht6zyNUCNZJuUqCLHnMA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795471215;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aGR2ezp9P4Ja129w/l+m8Ayy/DbyQLAojBQ0FlM8kps=;
	b=VRXGlXdYLW7uC7Ci5s3bNAUNNRvRScMHgaQ7GsZgPLWgJN41akoa6mj3GVcaC+EMOifX
	 I3TIq+EkYLTatVuH3zAwhS66zydprbPTzAa5bqUZGFxTKSsFR7MKxoMWtQH8eqzejaLbe
	 e4DtxzE+c0AyPzV3bDmyhLW9ozZeDMGGj6hB2PpepX1uRDuLwui2FSKDW+yFl4v4P2lRr
	 nvxqtlOcD7AxPbp0KlTuoY5z8T9riHpHq0vfOdufYEsy/C41dTBiCcKiR8YjcVNQDxxLp
	 5rppuexSSWNFkEOXR2sYxD7oMIDiXI4798BIXeOXTqO8K+uoXycMwrobLvHe8ngHsbQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6F8841F000C4;
	Mon, 23 Nov 2026 22:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795471215;
	bh=aGR2ezp9P4Ja129w/l+m8Ayy/DbyQLAojBQ0FlM8kps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Ej4sFNGaWDMdg9ehgILrSVI/ou9TBycY1mEyeBxRbdS6RV+4zhVEHjTJrn8JfZokS
	 kZXJhSd6anCMH94GJ33AF+MyIC4WW5+VYf1geVDI81cUUA8bOzvdhzMlGh6V7Oamdt
	 d4aAyLyPGqZDt62ZX/Y2o3nDt/U0DNVlSIOvPzF+OdY7FYNGVn/QFPMIocPggHnTz3
	 oO8mqrBI8q57rT5krWgBqxQcuZcl0d/kG2y45rLIvo+7gG1UNLY4He6vaxUXwKic/J
	 husNvitRxpuBezzEix1VkzYCaaBkFWWcXN0OLYNwyuwg28CgOzI7Zzr0+8/A365dIg
	 P1ztNs6F6G2nA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E9E534C791;
	Mon, 23 Nov 2026 22:00:13 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 24 Nov 2026 01:00:13 +0300
Subject: [PATCH v3 1/3] dt-bindings: rtc: Add Cortina Systems CS7542 RTC
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
Message-Id: <20261124-b4-cs7542-rtc-v3-1-53902bfbe0ae@gmail.com>
References: <20261124-b4-cs7542-rtc-v3-0-53902bfbe0ae@gmail.com>
In-Reply-To: <20261124-b4-cs7542-rtc-v3-0-53902bfbe0ae@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795471212; l=1725;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=zpMLao1XyuPRjMljD/Vh3jkbZiWoCb7Hr28HjaR1ywM=;
 b=JVEzuYZczknbvfw9Uv/sBFiXsf3MZXa53kfeDPvqBAv6qB22xnGPK4LsqjFWc6cuR/ncv87U7
 kk+PtIn17BbDejCuFJLJ2y9yGkcqAeFif1dSZGW5wFBMUrc4V1WkOeA
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


