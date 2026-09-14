Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E19C412BF3
	for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420741; cv=none; b=KQyhVrEtPBH7ntwkVL+wgg2Q0OrMNGTR0LoxZLpVTENw9HjyTgUoyjFks0WmemHlDUdEy/mRvtf7ZP69dHr6uDO8HCTQOhuZ4KjpBTQOnMVT6HOzi5d98iD4dO2WLCDU5+myHw4VvtJILLNJaDrnG1FxHiAjbU6OJ77YvJo3H1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420741; c=relaxed/simple;
	bh=yFJy1n+IFazmnQKnyW8JIkHtUDSZYkQNFCaqZgRlGnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3mJs22J3fFVSkCLhfMcF7qpoNY0FlF+jn+L0o7VlSlO2FexposXobF56Aj2yXoQLiZe5R6FtJSOyrJ5qMbVD7Cnmym93j+r0rXWOaqtPFwwwyH5qG+SFmcqL66+hC4fkoPBHSy4EegjVznxf5lTHWIsc0ssMGnAYkgOAtxH/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ABoru/tb; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ABoru/tb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=fiLQydX1FkHFA3GFJdRPmiR2qYZ15BuXxTsvw9rkHlI=; b=ABoru/
	tbJadhor2x1Sj68AKmzSrAc3fbTcYXdLIaN94Khc5IlE7Gbgcibq/uZERfNqy/h9
	HQ2UiSsn5QbhR3gN2KCV2aBHAmtFH8J4bPaltXEklMUdQ/EvAvv/q56h2bHQ2K43
	t7vcKv7d0rO7mI0Um6jeOHJZKL6fXHPJb+tbXqGbev8TnjwJU2ssnt+/TZ5MXehy
	hDBDVHZUYvFs0SkBkDh4luoPd290gxAMZ2tYDvsd9jcEwqwVphELLBTWhhi+MHGo
	6O4RnOkWQ+g9HGxnyLR/wNXoXuA2D51OVF5PliXCpf2oNtXQ+NyGCfxcOX9N5L09
	VBVCu/DiJqZLvLKg==
Received: (qmail 892950 invoked from network); 14 Sep 2026 23:18:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Sep 2026 23:18:47 +0200
X-UD-Smtp-Session: l3s3148p1@vW7R+ndbkrYujnvr
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 5/6] dt-bindings: rtc: rzn1: add R-Car X5H support
Date: Mon, 14 Sep 2026 23:18:30 +0200
Message-ID: <20260914211826.73727-13-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914211826.73727-8-wsa+renesas@sang-engineering.com>
References: <20260914211826.73727-8-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Identical to RZ/T2H except that interrupts are not wired.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
index b426a34958d6..55e1a33c566b 100644
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
 
@@ -66,6 +71,7 @@ allOf:
             enum:
               - renesas,r9a09g077-rtc
               - renesas,r9a09g087-rtc
+              - renesas,rcar-gen5-rtc
     then:
       properties:
         clocks:
-- 
2.53.0

