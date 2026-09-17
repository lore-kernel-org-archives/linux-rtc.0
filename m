Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BDC4C9E1C
	for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643652; cv=none; b=T7qoUR4QIHmcmkpUBks8V7tVwwyYdK8TRpT4kXTL6Lq+bQ0v1CLWlYWPCRfOCWAJbPCJuDhTgyMkRD6r8keXz7Yiq45gforOuzzRCPP7+BfA9RGrGZT6i0GWxCRH2mUR3wUxF+wWxl3czzoO8MM3ybkL3y2MsIE+fsOz1/oD5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643652; c=relaxed/simple;
	bh=zYVnKLe3K5YLyS+siMWe+pysYnv2RbFTdum7QLUo5GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRFGM5Ur6GqdCfBRu6rq49wxKaZCGindKGwlCCseBZwG/inhZfO8UMYbEI6biY0w8hOBdGKF/EXbMgAYlmYtQopajLWMS0/DHmSRBKOrC4guxeWbuqLynol9kRRTEedBqf3iu5l0iNQn+fgHOFIpLFdVcnPeLYsC5XEacO8FNHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=VPa/hNYn; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="VPa/hNYn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=TBEEd74BLEO3Ky1xSmQbh3pPKWeV3w/bEdgEd+vqvoA=; b=VPa/hN
	YnDaCYu2CaB0MzzkNPLvEjskD0phOC6dUaoacDqok3cqfaA0hwFb19sqD7Tt3k7m
	enZ6Nq/KgkpOhCuNkkJ8XuLJptQIWhS8RSCD1apLa5Jb9AcrKAjW6pzWYAV5eZMP
	iDXFmy4u4nEKQx/oc5kcz2LZ9VEQTjGCmvsMMoGIkcxyzucrXkHMfCYpKIt7hSR9
	f9plhZ0MIUR25HZygu3sDaBe2HBAkCc5nZzxM18YEYRqAJIBCnPYPy0kg7GDgzlY
	FPW6tFOOwd3vyfyHEqmTMK7UrHU5wWGIgvwI7ZGCrkJStsVUVKVO7REh6GMxHppE
	4iWiyG1Vf+N0xzqw==
Received: (qmail 2005208 invoked from network); 17 Sep 2026 13:13:56 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Sep 2026 13:13:56 +0200
X-UD-Smtp-Session: l3s3148p1@3+I74atbgNsujnsL
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: "Lad Prabhakar" <prabhakar.csengg@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 2/4] dt-bindings: rtc: rzn1: add SoC names next to their IDs
Date: Thu, 17 Sep 2026 13:13:46 +0200
Message-ID: <20260917111349.52250-3-wsa+renesas@sang-engineering.com>
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

This helps maintaining because the numbers are easy to confuse.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Change since v2:
* added tag

 .../devicetree/bindings/rtc/renesas,rzn1-rtc.yaml      | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
index e96007981c34..7ea77cd0bee1 100644
--- a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
@@ -14,14 +14,14 @@ properties:
     oneOf:
       - items:
           - enum:
-              - renesas,r9a06g032-rtc
-          - const: renesas,rzn1-rtc
+              - renesas,r9a06g032-rtc # RZ/N1D
+          - const: renesas,rzn1-rtc   # RZ/N1
 
-      - const: renesas,r9a09g077-rtc
+      - const: renesas,r9a09g077-rtc  # RZ/T2H
 
       - items:
-          - const: renesas,r9a09g087-rtc
-          - const: renesas,r9a09g077-rtc
+          - const: renesas,r9a09g087-rtc  # RZ/N2H
+          - const: renesas,r9a09g077-rtc  # RZ/T2H
 
   reg:
     maxItems: 1
-- 
2.53.0

