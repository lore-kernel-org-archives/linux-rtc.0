Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697D42E173D
	for <linux-rtc@vger.kernel.org>; Wed,  1 Jul 2026 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916209; cv=none; b=Cq4iTWGimIBf4RZ+v/PLp5pnCMd+CLp5mdO4go8on5uSC7am+o3jym337TxIMp1fTHv3k1lSWATyMBKLfW3AxnUWBhMgSmwCbuurnvymOnAs/qS06xL6dPAbGtxsc34SAQCEbCetKfTmUWk9ydfgPFa/KNtkTyLy/QHGcILTEMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916209; c=relaxed/simple;
	bh=J+GbWvJiZAKOa8gwMW5w0/ZdCLjIm8F73+59a3lSp+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdCDo4bSLiebeCYeOOYpL+Vp+NhUtLcrIFTl5ohXgkgjLQK5BptsJH7FucXGRGry/A0nw3bCyCvjl+IYsXaCAienbli2FrenuLcXOXEoJtuOEnQKZBfV5bYQiO3MsTDNY76is1UifuwR3C0l2nHbecR+xeE7NVbWRHajbKlRFZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YE6GPTJz; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE6GPTJz"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4758b2a9e2aso481283f8f.2
        for <linux-rtc@vger.kernel.org>; Wed, 01 Jul 2026 07:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782916206; x=1783521006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0f93MJ18B13tIX/32rfVOVMBHkdlwoRgH8VUd/Tsek=;
        b=YE6GPTJzyQRLxou1E1Q3cTT5TQq+Ahv64ebm+ihlAfZo8lO4Jmq4EHvNy2JJeauQp0
         l0A6tW6u9jYWzFgPYaNH9wvPAtMtmpCpUzNXH1lhC1Tz2tp/1JCl3lZ/EJnlDlLIkaaP
         ZU6eA/Qb7WiSXgzEaTnsn1ou5z08rHCpFKcQvRTRRgwXhfz7e/GuLeZ3vM5nuskzJlJr
         xNXVXQEaKp9uMwvvBc6cVorvm+i60ACjchsNg02qph52ZeMwDp2RpE86sGHLPjz5q2ee
         grQ0EsCFEU36ncHIw1F1Mmi9XbXs2yzp+ot16l4zZ/hgIRPHLhSvHN3AqH2X4xpWg8fC
         ldPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782916206; x=1783521006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M0f93MJ18B13tIX/32rfVOVMBHkdlwoRgH8VUd/Tsek=;
        b=QAk5kZjx8ypr1s8MHTDuN/7dFL0I0Lidw4scc2sWQTYVsRlf3oX2/T4Hn6gojXN37L
         Nshte5UxxWhFjcTNbLvTO+kUQTqw+T74G7F4h9szYVC9WAEwaSz0q+f1TCFWSriNmr9Y
         N85E8cU4XWN/L/VGguR0z5VN3vTB/cJ+6ly0lIIzKctTngUpxChgHDR7I3igiHdm6M63
         ti7v+6QHnT2APXZaBJlZcDvMt7o/JlqP1u2DCR8tY5UuUL9v/VfEwCCyO+vOUNTGwKVw
         CTQxxsDVI9x6k+dFVuSFfV0ZvO8CcTxWMjKG0zd1eahlcMakAItx4GMfjQq2EcL9p6BB
         bZpA==
X-Gm-Message-State: AOJu0YyZozE2IDpe1z1A0uase5at1dXFRTeK04fLBjCwOnLRFixLLf5u
	eUEJi7uytYoYeQUl6Wm7fdXH8rlT9v8M/es9RJr0BjuY8Bm8c5rWHQu4
X-Gm-Gg: AfdE7cmXcCD694M2XuWgi4J8IVKNLu3DWwxXMY6Ma3dmNKhg+LCPMxJpzIvx/IaZJsU
	n+9xxQmA5k6w8jwhKWZV9juBcIeAU07/3jXhxsBHFsa0P78PN2bzLmwGWuySFdkEAWPly53czKs
	2W+V4rs/2PdWrr76+an4rpIEE7p7UzI9Y2KyZvcVLa2KB3dRRVhwdz/U5r4pnkfM5IoOTjXxFqN
	F6YpH1UAwkYmv45btxtxhrMqaIEE8Qe+jZqBsxlP+Xx4fSRNKynmCEAEeNUwY+qCpkdivgT3STf
	y1UncX5oiUq2EsZLNapOMOwnSvSFoZHk/7mw+C4L0MiXunyVMXezz4KsUUfVgHML6hbHU/RFQhM
	nadgm9AZD8Tf96a9uv8g8OOWutAj4zZSlIkZkLbwnShSLkmpcz/RaaOK7KVBl1Q8p3+B/buwFQG
	WZAOz5eht4V6LQ7B0vmgEkY7QkyOLH3ZA6sutFqtTdses3BnoyR71IuHNJ9lQVpNjtS3uve1QC3
	hmdlEhqo1Ep/rUUafR/UhVYAS8=
X-Received: by 2002:a05:6000:420f:b0:475:f0c2:5b03 with SMTP id ffacd0b85a97d-4775b5539a5mr3406191f8f.57.1782916205651;
        Wed, 01 Jul 2026 07:30:05 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:5353:5ce3:a6a2:3b98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dd94c829sm184902f8f.24.2026.07.01.07.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 07:30:05 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 01/10] dt-bindings: rtc: renesas,rzn1-rtc: Add RZ/T2H and RZ/N2H support
Date: Wed,  1 Jul 2026 15:29:44 +0100
Message-ID: <20260701142953.2014895-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701142953.2014895-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260701142953.2014895-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add compatible strings for the RTC block found on the Renesas RZ/T2H
(R9A09G077) and RZ/N2H (R9A09G087) SoCs.

These SoCs integrate a closely related variant of the RZ/N1 RTC IP.
Unlike RZ/N1, they do not implement the RTCA0SUBU register. This is
not a limitation for Linux support, as these registers are not used
when the RTC operates in "scmp" clock mode, which is required on
RZ/T2H and RZ/N2H due to their 195.3 kHz input clock.

The RZ/T2H RTC variant also supports a 1Hz output signal on the
RTCAT1HZ pin, controlled by the RTCA0CTL1[RTCA01HZE] bit. This bit is
marked as reserved in the RZ/N1 hardware manual.

Update the binding schema to require the additional clock inputs used by
these SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v1->v2:
- Updated commit message to drop reference about RTCA0TCR register.
- Added Acked-by and Reviewed-by tags.
---
 .../bindings/rtc/renesas,rzn1-rtc.yaml        | 35 +++++++++++++++----
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
index 1860f0e4c31a..ea7b039a91e7 100644
--- a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
@@ -9,15 +9,19 @@ title: Renesas RZ/N1 SoCs Real-Time Clock
 maintainers:
   - Miquel Raynal <miquel.raynal@bootlin.com>
 
-allOf:
-  - $ref: rtc.yaml#
-
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r9a06g032-rtc
-      - const: renesas,rzn1-rtc
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a06g032-rtc
+          - const: renesas,rzn1-rtc
+
+      - const: renesas,r9a09g077-rtc
+
+      - items:
+          - const: renesas,r9a09g087-rtc
+          - const: renesas,r9a09g077-rtc
 
   reg:
     maxItems: 1
@@ -54,6 +58,23 @@ required:
   - clock-names
   - power-domains
 
+allOf:
+  - $ref: rtc.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a09g077-rtc
+              - renesas,r9a09g087-rtc
+    then:
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          minItems: 2
+
 unevaluatedProperties: false
 
 examples:
-- 
2.54.0

