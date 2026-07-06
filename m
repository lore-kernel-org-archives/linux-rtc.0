Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DDB3BADA2
	for <linux-rtc@vger.kernel.org>; Mon,  6 Jul 2026 17:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360311; cv=none; b=V1+VqNCl66bRNIGtdYx8rYeHpq94+hebi5N17Fj2ELHLdpObQiQoC1aQvnKIV4VGIbJZdqpWeBOqc9yYgV6H5bRnKwxnG+6o659HXtxT8Z+SwwrMfpUbaGgcfesn3UxiKCWKhaubjuAElm01P0To7k0qyoewd8ja+3TvxY5EHsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360311; c=relaxed/simple;
	bh=HpoKLu3V9es7opMjR7pFLLCqJR5zFl25bej0vBDOdBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQdhlBrFR+k+QC8w+oqNFjTyRjJjlr+ddi9bXkvWjZHRBH8wXbNrz3K0+xguA1expZf65wuzrA79x8oSP0mJlvhXIXNi6/fTz3G3NVIbL5C5jdYanAuhjXMPYTCbYOm8MkkwoqQGgvFTZ4Qa0ukiANUQmMiRgQdCFYKC5hojlvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUGNDx/7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUGNDx/7"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b786d6c0so17911245e9.2
        for <linux-rtc@vger.kernel.org>; Mon, 06 Jul 2026 10:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783360308; x=1783965108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oPWiZQln08GcBf8WEujKuispVEeODLsYsfgQWbMre4M=;
        b=FUGNDx/7ylTJ2QP6gqcQgch9db8FBkH+5VNR06bW3VDxGj5k93UWpsuEm6AQO03lFE
         6PpUz4JfHVNBUm+oQhLmh9/7qGuWgbczs5nFKYZZ+VgemA2mozh+6tt0SWjptaESAaB0
         BPEKpNxg0oPz4uJTEddpXDMjXFUzHEtMcGBJLT3t6N463k9Jr/3JxS9K+DlTqcc2HchI
         5v/VXHALSgHNaL4m/aJaSCGm+4BSGSK29VwQbTtbG14u9k1b3SKZf21kiydkU3+oxXVt
         ZBBAsLLcN/SoTz4wGTc5XBfBPunwkqi78ZQ4vH2Z5QH/jeNKL8RdR7qkTzegytHG7Gas
         FPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783360308; x=1783965108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oPWiZQln08GcBf8WEujKuispVEeODLsYsfgQWbMre4M=;
        b=BSuQc/gEfREp/+2OeeN6Xw5gMJTAVl7I493m5oT/q+RT1GsKICKeEDi6D8z6igq5AQ
         O+EsAiKh0n+UoYUB03XeqY/CFWEG314RXDYa2bSJ5j7fLRvwV4aryByIFYma6f5SQJlK
         PD9kLa34FF7MEvLG2p58P9xFcK1Zx8kukMD6YBkvH0ixffn6eojrUQQWa+MZk2o6ZcTa
         aBc1gy3PH4tLsVbnnZY46o3WxcsQPDzvHx8uixinsdNTamn5NuXzhJP8plDVd2tjun1t
         AOrnfqbwjj4rvhdmIF3rdSE2whfN4DyO+49cBxr44w8vhYQgzBnBjB+GkkKS23didkvM
         r5GQ==
X-Gm-Message-State: AOJu0Yy5VhqyLjc4tEkZdhOkifemwds2yHxYSKkheOzKU9+OzgvbSmmt
	tFrXWm3UJcnTLhSJpl9mCyu1qJvEglFxztEMqbi7NZ7l7Uu+W+e5gVWs
X-Gm-Gg: AfdE7cngeCi2zyP7ybmqdyGGMAagKA7CgpSfoZUhiuRq08EkakJPBD6KVYiVuiIXJJj
	Cz4mgDNKW98HD8r9fq2h/3Yq2omczAW6GnYgddmVnSQVvIVsmuupaSdzGIbn5i0tBi5HVuiB7gE
	cZy1SBN7JgK/A6k663jgR/4so9azSVQ0NPNXDCbvxkgXFC7zamAVC/XKnQ6OUJonbYOb5iCeNg6
	cNo7gLAeWj7sqgrFSGMZH+Md1cd8HsYgSF8TUergEj5YwQmuAZQ5OCE5r2YTjvZPFwi+zb+djH9
	E0K5Vp5tswfG0Ulpc8ePilbqjBpO6azz80RM8NyzNwVk18Cmy5g2dxDIMcOSdpiWkGWk6Jyx3LG
	uqycwFGYX0/YKOkqGBHLwkEJD6IkRsof6A2M4vMaTUp1mX334bV5C2HDtbKtdIhDeJe9dpSSYJX
	8PwX5lNLB1oQh49OJP+lU4aIoePwVoltixeD1Kvnu/Og8Py5BgEhrgRKJa3WNpaSG6sHwiaR47g
	GLGDWu4hbWeJUyM//G+VYWYeA/D+kEfSWjfGA==
X-Received: by 2002:a05:600c:c167:b0:493:c98f:12e3 with SMTP id 5b1f17b1804b1-493df08f73cmr17773565e9.20.1783360307931;
        Mon, 06 Jul 2026 10:51:47 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:8e02:886d:c345:c5e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0078d49sm1263145e9.0.2026.07.06.10.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:51:47 -0700 (PDT)
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
Subject: [PATCH v3 01/12] dt-bindings: rtc: renesas,rzn1-rtc: Add RZ/T2H and RZ/N2H support
Date: Mon,  6 Jul 2026 18:51:27 +0100
Message-ID: <20260706175138.12587-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v2->v3:
- No changes

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

