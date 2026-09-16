Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FF04E66C8
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554340; cv=none; b=goP51ynQw1mlTgLkCt8OpiGLcDu+zFvSJ+ZGxgMsIMBArzj5jr918Fltgp4Nfn5tnbMBPj8XqUqjgyWuVV/zdT/MVA4HMtMrwFdk/N+9WMjbZHMH0XDMoAd03HnGltQg9I9IBLy7ToI4zaJGAuVGFT6hIe9p2bgZ65mZf/J0YEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554340; c=relaxed/simple;
	bh=xJLIvqr2ozwwZEzDVSIxSiDxISuUPknm5gQlBdpKW5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ssv0bIQ0pt8GfQMI0uGTpbFKLTVxKmSs9DC0EiEIlungIRO7ZpIXrxdOTjoSflEt+gGlWU30S9Cx+4/mJkkICvAmzEDFhGq0CncVVFngslckARNgSSuXphEytX9dQih3qBzFEkUxPRZet99UbWmwuaPjJUpEhZJt79ets+FvnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=FXd6Bnvx; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="FXd6Bnvx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=kQyC3tYlW47DuY2FSxHyQUL3kUwEOR3KmVDydlsmjJY=; b=FXd6Bn
	vxfxG/fJASqmBpdigjz2gCOMOS3A3kvx4lhLHXc2XuFpxvb2nUoQ57mIjFw1Qdmz
	GCHDB0s7oqe5OqU7arEzlkllqpYiuDDBsbTUByxm7tfdRieZEdD27p6cGAOKK05Z
	mNxKCudJQItHLRxb2o1Ir/l2Bb08XzrjQsn+a8XU/UxD4Ro2LyuWBf50ZYKAV2Mc
	pXwzWYaZMMrHGNGlMOurW0HesF8+OBnm9IbsdMxFKdIeJ8PJGKGEwDUFCBrxXXQL
	QOhF9A/ruPU/N87ZCQMXHJzQhuSra0ua6YzDONhHycdDY7IfSlHW9rvVPtVZq+Zh
	Z0CyQFevwbRVEczQ==
Received: (qmail 1502903 invoked from network); 16 Sep 2026 12:25:22 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Sep 2026 12:25:22 +0200
X-UD-Smtp-Session: l3s3148p1@xl62FZdbkoMujnt4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: "Lad Prabhakar" <prabhakar.csengg@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: rtc: rzn1: add SoC names next to their IDs
Date: Wed, 16 Sep 2026 12:25:17 +0200
Message-ID: <20260916102520.24288-3-wsa+renesas@sang-engineering.com>
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

This helps maintaining because the numbers are easy to confuse.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
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

