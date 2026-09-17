Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A004CDDFE
	for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671571; cv=none; b=kTUdctm8DV1WtAcAlryoTp95IrzLj5zLS9biPHl2yNcCOzk4rSw3dGqsZ3/4rClB7re2fWeT043sp59aML8IrWNq30xt3AW33hUjx6JMYL4MqUqtSGCMcC2HF9tR2zqTRq8ujwTAd6ntmd8+lbj9+FT0/+2bei4VIkgoLqQz5I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671571; c=relaxed/simple;
	bh=PBcRqcOstViSRWuHjONN11fKAWkDjLFpkArjBYfTbws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JR22it50wExWCy8BJpf4Tze/NXlXzgKrGoGc/af9jX8a0nFUpyl3fcN/GrCRBfEtpAg57csP+lz/pVmZe53E0PDzFCdIg0xNtQDtY/4PcCMJhhDdwxmikUO1jrHp40oKaBaUiszsr2KWRJRLWPPmz8qMOsPwUxrQUm53LP0vvnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Yv/ohBpI; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Yv/ohBpI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=R63UcNIpiW0TYQPUrgXyyCXb1Pg/Heu2w3/L+Y3ctgE=; b=Yv/ohB
	pIqT3k4g5DK1Nib4CbTlYRi7aEBkXZOtxH2lmB9mJ13w1nyupvKU4FCImBUII8L6
	kNIjhSdkwWvrjEZCpVlUewS2rzi5BHJAUGrnf+cl63cvmDkT9EA4QyCmhSpRRZOj
	kjYBrm85GOVCv+yRTPKlPQIRWdvRDbOFVIFMVoETi5NGF5xwevaeaC3UGr9uyMYA
	vVMg4p3Hw2uxktkupTJBgJdg3RWivlXxnHDqKkZzZ/uTfW1BaoTZLpw1WWQ/wXd5
	u2grr2LW+ncn1hjweDPGapUsS1nlWM3w74dvHOlBjqoyLKySExLjQkZuF1r4zWdj
	mCWlekR3LTtsZ9Zw==
Received: (qmail 2157926 invoked from network); 17 Sep 2026 20:59:18 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Sep 2026 20:59:18 +0200
X-UD-Smtp-Session: l3s3148p1@xlGFYbJbIMAujnsL
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: "Lad Prabhakar" <prabhakar.csengg@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 3/4] dt-bindings: rtc: rzn1: add R-Car X5H support
Date: Thu, 17 Sep 2026 20:59:06 +0200
Message-ID: <20260917185903.61253-9-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917185903.61253-6-wsa+renesas@sang-engineering.com>
References: <20260917185903.61253-6-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RTC on R-Car X5H is a bit special because interrupts are not wired.
Future R-Car Gen5 SoCs will have them wired again. So, create a
dedicated entry for X5H without interrupts.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changes since v3: tag added

 .../bindings/rtc/renesas,rzn1-rtc.yaml        | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
index 7ea77cd0bee1..b448725671ec 100644
--- a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
@@ -23,6 +23,8 @@ properties:
           - const: renesas,r9a09g087-rtc  # RZ/N2H
           - const: renesas,r9a09g077-rtc  # RZ/T2H
 
+      - const: renesas,r8a78000-rtc   # R-Car X5H
+
   reg:
     maxItems: 1
 
@@ -52,8 +54,6 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
-  - interrupt-names
   - clocks
   - clock-names
   - power-domains
@@ -66,6 +66,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - renesas,r8a78000-rtc
               - renesas,r9a09g077-rtc
               - renesas,r9a09g087-rtc
     then:
@@ -75,6 +76,20 @@ allOf:
         clock-names:
           minItems: 2
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r8a78000-rtc
+    then:
+      properties:
+        interrupts: false
+        interrupt-names: false
+    else:
+      required:
+        - interrupts
+        - interrupt-names
+
 unevaluatedProperties: false
 
 examples:
-- 
2.53.0

