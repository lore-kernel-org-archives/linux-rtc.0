Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCC04E3EFC
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554344; cv=none; b=I1cU9HPykEPnIrNggPqqp8MIX7cGK0xB9whUgdJneY2bcibJY19Hmax2Ikh5rgmKt+84AZ/DzoF+ICTFSW1HvU6/hmz7D7giJHdO322IAoQR5qmgqgF+Fy2fFV5BCgVpRtUhMeisvQgKMUx9WhunhMLVwe1AqjQQOPs2T2ysZ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554344; c=relaxed/simple;
	bh=1tkIrWwrGFxIur197aiul+BHy4AUIgRUAhXst0EfR3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsecUZUSWDdcW5m0HYB95MMckbXpx+I7pKjV5TMrYOfOEwO4d9WbODeh14bbmHxSgO+p2EEr9WKpW94mm+MjzTxmSQCaC5UMmYC7sZsLfwZteCZ+fHn2moP4C6rDBOZyvSH5d7Rff7wzp4w//gw8KdQe42IPzz6Nb/FWcuT4ooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ES4eNa75; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ES4eNa75"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=xIoZDT04ItzPzCjsOYpDgyIWJ+9SvmCWgY6JUqjGg0M=; b=ES4eNa
	756RCxsMB9aUAVMC7DSYPR1uF0k28CCuEDjorAfirpKkGPpaywYD3Z6ScBCifxe6
	IqqF89Sr0OXO8CU0goFEtojGyWW+cP0tYKNWqiRQC85fqOGsm+gBwXWXuKkI0Orl
	oEmAGWxT9Qesc9hRR+I7YXOFNV+8Met5YKbry1Tza5RA2GP6OUsgHtPbaQF+X2bS
	Ec2b0riIchz//SobBBA9g39KPnmzbnsiCH8sXvtyVQGPkzdPo5XeqR+VM3I5YR+2
	NrralugftDqfCNQVAGw/+Qtss2K4/gCca8h4DaOgeDCEtX2kyc7h74QWu3SibIKe
	K9YrI1NTdVbDiVvQ==
Received: (qmail 1502933 invoked from network); 16 Sep 2026 12:25:23 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Sep 2026 12:25:23 +0200
X-UD-Smtp-Session: l3s3148p1@UBXBFZdbnoMujnt4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: "Lad Prabhakar" <prabhakar.csengg@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 3/4] dt-bindings: rtc: rzn1: add R-Car Gen5 support
Date: Wed, 16 Sep 2026 12:25:18 +0200
Message-ID: <20260916102520.24288-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916102520.24288-1-wsa+renesas@sang-engineering.com>
References: <20260916102520.24288-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In general, the RTC on R-Car Gen5 is identical to RZ/T2H. X5H is an
exception, though, because interrupts are not wired. X5H2 will have them
wired again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../bindings/rtc/renesas,rzn1-rtc.yaml        | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
index 7ea77cd0bee1..186d0076590c 100644
--- a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
@@ -23,6 +23,11 @@ properties:
           - const: renesas,r9a09g087-rtc  # RZ/N2H
           - const: renesas,r9a09g077-rtc  # RZ/T2H
 
+      - items:
+          - enum:
+              - renesas,r8a78000-rtc      # R-Car X5H
+          - const: renesas,rcar-gen5-rtc  # R-Car Gen5
+
   reg:
     maxItems: 1
 
@@ -52,8 +57,6 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
-  - interrupt-names
   - clocks
   - clock-names
   - power-domains
@@ -68,6 +71,7 @@ allOf:
             enum:
               - renesas,r9a09g077-rtc
               - renesas,r9a09g087-rtc
+              - renesas,rcar-gen5-rtc
     then:
       properties:
         clocks:
@@ -75,6 +79,20 @@ allOf:
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

