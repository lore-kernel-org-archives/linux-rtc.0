Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9152D350D74
	for <linux-rtc@vger.kernel.org>; Mon, 15 Jun 2026 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538502; cv=none; b=moKBm5CclSx3mKvwYj3DTNgX5Ji8VlAbbTdTc78wlBAMZXcWiXkOs6F39jDEnndd2urcnheT3oeZKWXWgtHk75mxjVd7NbZ0kp5BKXoMeJPuveweGcOxFmzvxO1XtQ7+8i9BP2DhmkJ7hMuZUuW6G0deNuNCK4iUPGnzNMQSg3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538502; c=relaxed/simple;
	bh=i0epigYQSf6nodYrIVmZxJadmqWcGELiZNYUZq0FVfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/MCWhXDtN9E776Xbz2RflYcQTY1EOQDliUozFb6QFgIedhKT9T96F8Xs0HlWb1/XOqIWoXpZzGd3UJqJg8BjdyAmGXusQjORk9AIHVvxN6u8kpF/ZsjYtlbunuebJ4V52p1J7Hp9DMPtc3d+xtum0cC+ZafaHRaSJ0azLQGJDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oya6tk5W; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oya6tk5W"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b3637b90so26901245e9.3
        for <linux-rtc@vger.kernel.org>; Mon, 15 Jun 2026 08:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781538499; x=1782143299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6TqdYR7EjMTpHsjbl3Oaxm9i/7wwH40MmAvo6XkU6A=;
        b=oya6tk5WPsFdMxBAzLZxTqF5CNPi25TxzEVJIPdXn1eGkjcz3LIdYSILyfV6mB8DCn
         HqX6cX1R35+olDhoFLA+niKfwVQ8goyWH6C0s1fcbWaIlog1Si4WgaagFtLR/4PpYGu/
         yC9O5aMx0OoXoOORnhnvM7qrDRh7DBr41jPnPGhMkI40VpKJ5sLz/c0bAHKjEjDMkpRY
         V22YXEFYYd/z+D08CqQNpxUM1eA39H7lInADFBwwVTkGgImel6LMg/oYaesrWUIucWfL
         iqIoUVkl6zyTgHmj4ppXpkMGTnFscrAU4FzPxMGpeRBe1jM3VnxBg5e76IyhBHjCjlkC
         58fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781538499; x=1782143299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+6TqdYR7EjMTpHsjbl3Oaxm9i/7wwH40MmAvo6XkU6A=;
        b=DEG9Rhfo1C+ZcJUzSTxvbYa87xcGu1+UJVtVLXlkj4NadWVNQv2Ha0spudr+BTgkeH
         qNpcmkJLKycq25igabJjUuzH401EWKs8NxFzy19VY+rGKfiZFshrHVqItxfwuxwGvsVl
         8IY72nrUo8a1oejrM5mkpqG9ftwLpMIysKdLAPG/UtEAHwXOXUIWFIpV8BMQd0tZ/7GB
         eiUL0ClZi1YK40XE0On+aAAl5+vdEAGQEWRw7ajRUr1iPPK/JH9xRsPsSLQYi2Qkv9lW
         gGocWRgUWi5AEedubwPVKXNSVVnhXYz+BBrTvCsM4WIyALmC6burj1tTI8KxXNX3ijiB
         bGrQ==
X-Gm-Message-State: AOJu0YxjBFr7/JgmNEEadp/BPmxceImK6WpNKAKBXKGyAUzOurFk+K74
	9878L7/w+EFf3L7KtzENWfypnGBhRIhijth4ZzfUqEYizqRAy7WbqUwE
X-Gm-Gg: Acq92OFL+T4owmvN7oLlk8CVY4pTMSzVmnX5nq0bFz0wUcIaxb2O2Tp3UqQJz9f9/HC
	FfJWhuSnT4L/6PSxWkz+nJkPheYA4GjJi+N8DXYiA2Fq4EPUcSqmfWhSG4/uWU8/8/IUhyHOqUf
	T8g61VZsmWG+c2uhbthu3uhPbNiGyEjfVg4vSz8asQWzONJUd6QJmsf34kka2qY/MppxfZSgut/
	Vttik+qTUeseLOzNQY+gD/Um59G+qr2sXar9U0gCZu8hzef3Vu5C2iolJcpiQGvuZgpbdP9CzUA
	Caciz3zQxBzMtJ45u+Sqxa1XmuT/aONCVtB9/4PGTygQOUPjHLNq+dVl0fLrYS+MN8GDVFPx5gy
	EIyfUB3svyam5kiMVmR9WnNAf8k5RrCSboHkpgspxArJxmKG9mMPnRNPEse1LR+VBGtMfbrsWkv
	RNCplkofLmPbbhNE6L4ej+aZgw3eexL+Yj+ubn7tiJyLX8vYaf3W7V0NgVH9vC/I45wwIWnvxD6
	iyZrlPdUPJ9/PC7RTJjsATv37DcXvG1VlE5
X-Received: by 2002:a05:600c:81c5:b0:490:ea88:9d4c with SMTP id 5b1f17b1804b1-4922016094fmr111312015e9.32.1781538498881;
        Mon, 15 Jun 2026 08:48:18 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:1e4:992f:3ad2:4f2b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26434dsm36010995f8f.1.2026.06.15.08.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:48:18 -0700 (PDT)
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
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 01/12] dt-bindings: rtc: renesas,rzn1-rtc: Add RZ/T2H and RZ/N2H support
Date: Mon, 15 Jun 2026 16:47:54 +0100
Message-ID: <20260615154805.1619693-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Unlike RZ/N1, they do not implement the RTCA0SUBU and RTCA0TCR
registers. This is not a limitation for Linux support, as these
registers are not used when the RTC operates in "scmp" clock mode, which
is required on RZ/T2H and RZ/N2H due to their 195.3 kHz input clock.

The RZ/T2H RTC variant also supports a 1Hz output signal on the
RTCAT1HZ pin, controlled by the RTCA0CTL1[RTCA01HZE] bit. This bit is
marked as reserved in the RZ/N1 hardware manual.

Update the binding schema to require the additional clock inputs used by
these SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

