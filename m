Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A486D3905EB
	for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643654; cv=none; b=cUdloYqnH+P5iasVA/QpCPJwS3KYOR12Z2JO69d/pEjJFr0848qK2or2oKuN/1wG+9YtfG8F6CL5lEcp4gPKphrJaF4vQdzo7zhl7RSqQKDlhpdt61zNoVGMtsAQF9H7TDbwsGUmjcvcRsl2rFi4A269h19EDdCg4YyGMWrpur8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643654; c=relaxed/simple;
	bh=HVVGJtiDUMqoLxQ9kcI/Q6KLz1KQCpg+Z9mhA3OTbME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hr7h+LKyEA0WERE9JFi9Y3DQ5lMpUPrgAQeq/DdZKtmUjG8WwwzoDfBqFzEtGCV4TRKt0boqX5aJxc8ICIeIcPMZe1GSv844CgxetGikqywaZ6XrjXIvc+lhhshVMI+6CWDkCjvUw2LOCC33l7VsyILy25IAQRh2BJ4Lsy+e98Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=NQl1JtpH; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="NQl1JtpH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=bVDUjNRx99nJYIuwHysBxWb2p0/5g5/xE5wbfYYgPzU=; b=NQl1Jt
	pHpUn0/uRV76xrzIku1U2Wjjf9wrgCBOE4SuqcMOMavWYJ2rulJtqSKkE6jwy/69
	cI1LU8AHaH7Mwx9NAPRrm7og/S5GqgWs2L5IbqG0ywnhqHPr+ohEZTm0qSplI8nS
	pdexcW9qgsB36vGeKko0hyzdULsLPXYKkb1xAqh9LsVr+p4oU0s8zyoQwVkOpYg3
	Bo8PJd/Mb0lTRm2h07QawrO332yztCoM2tWJy1F5tAtTN7rfiTQEeAXWcyFi9/Tb
	XkAAPPjdRJxa6IHZEscHY57lFz/5KW11GTbutWJwvelcBOfn5S9UHs+4p1VC59ko
	CIr+RK96caqPmDAg==
Received: (qmail 2005234 invoked from network); 17 Sep 2026 13:13:57 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Sep 2026 13:13:57 +0200
X-UD-Smtp-Session: l3s3148p1@5gxG4atbkNsujnsL
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
Subject: [PATCH v3 3/4] dt-bindings: rtc: rzn1: add R-Car X5H support
Date: Thu, 17 Sep 2026 13:13:47 +0200
Message-ID: <20260917111349.52250-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917111349.52250-1-wsa+renesas@sang-engineering.com>
References: <20260917111349.52250-1-wsa+renesas@sang-engineering.com>
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
---

Change since v2:
* handle only X5H for now and do not fall back to generic Gen5

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

