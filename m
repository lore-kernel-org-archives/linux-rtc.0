Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D22413786
	for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420737; cv=none; b=rJasjt02Os2nVuT8LRolphnIEahGN8m4p688i0dXOT8DaS6ru8cBqcBoTMzN9LVbWIfcJjjse9DGG1Z+ypBoZxlDuflkOgeBdnsRTleBFXHMpKpLfIQ5LRY0eG76nKTEN6pbW8T2z8C718U2juQAiqJSt4hX7B+X0cA3fom4uyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420737; c=relaxed/simple;
	bh=1cqu24sc0bEbkUn97SekG2f6OyLCCXWSUIMpOwmBONk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TImLN2EskRn/qu3dygwuCIXzq1IML4JFJ4xqql1PiD+lcYGmaPAIrNLK+NotWGwqrv6ocgCz1pxg99iEJll/noKxJJngeXxBATt1EH8z/eEBnEtvikV+1x3TaacQ80LIRoOzD+ZTX/FMYfHrT4c74FJZjgTcUi48EQxacrt9qBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=lmR4kJd0; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="lmR4kJd0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=LKy7y/LQXWteCIfZG9HkT+fRiu0RNjjkJIkSFm776b8=; b=lmR4kJ
	d07d5ovVzLQxEzo45t/EPuJJIc9M754bD7BAC0fKaXsB0mXwDzUoFGJ/OBuP5wnt
	XNe2GEPPQ2Y/NJm7fuRRwmz6n2yEshXrZFV7hMGUE0GoBgY+d3YuUHvbumD6UnIn
	FpcGXtFDPnjHuJ4Nc19LAoXs+qHam1zkIc5gd0AosI9NY7aZkzwjdkA8Dva5+U3g
	fNmel8nMoofJERyVHrzAerQAKhfFToMV1uu9qq/eIeHZSHQklgnaW5owyv4RCPWV
	RFs/y8oOeC0Z2RHs0SZngvIN1ej7NF9ZNYIX5EitOe16us3L0ryn4HlOgP1f+15c
	1C4cP55XhwcizhOw==
Received: (qmail 892869 invoked from network); 14 Sep 2026 23:18:45 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Sep 2026 23:18:45 +0200
X-UD-Smtp-Session: l3s3148p1@NiWz+ndbhLYujnvr
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
Subject: [PATCH 2/6] dt-bindings: rtc: rzn1: add SoC names next to their IDs
Date: Mon, 14 Sep 2026 23:18:27 +0200
Message-ID: <20260914211826.73727-10-wsa+renesas@sang-engineering.com>
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

This helps maintaining because the numbers are easy to confuse.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
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

