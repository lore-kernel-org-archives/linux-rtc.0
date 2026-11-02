Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624851;
	b=aI0IG5E2II+trITZmEEOyAuKT1uw9eCfBTOswRsmcot5OPu9o3iEkF38LuJqSx6NU1aJ
	 9wtyhDGjf49czVCJiLRPwQirJY+zW3n9muCQL747T8Sd3wQBrp529BsERXEs1KgaToqqw
	 JA1ofbEF314JlEmrG5la1pOgJM3ZxlI+hSNn+1BWYlM2lJwipPQqdZ/gmEucataxN7FA4
	 tq9/47zsX9Qd92gGYhqAmYa6kXuROafkTi6uVsTZ8dclkleFzfZE5LRxYDXi72CN15Jq0
	 sGlZlPFQJTkraUju9HxhINmj9epaUsgrvo4xejzmb7dHlaMZvUnofpXbhQePWkH90RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624851;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=vd4UujPDzA0eLjqYOmoFDMFIfeJnmHMPRcAx0AsIvgQ=;
	b=YwWSa/vG+7oZ8Aa91alE3MPEtiS0rDR5WBlwxoRWDeitXc+86S5/c56Dv5w1O30a4WMa
	 4vRHaIXt7m/Nt2h/4hOcou+0r7tf+Vr1YSK/z4bQ8VtQCiH/iF8FZPgglYe47nU8l3GzY
	 LuCVSDxV0VbsqG7+sDo7CeLxE5ALHvz/WYPcXeLb74BK0Y5RIWT9kbdZ6OpaBGsml4+86
	 xY9FLyHQRWtBujEMtXPOCXqAz7u4LhivUCQbiAN3DvaM6wpnsU9MmXg7UdPMcaDJQ1MB2
	 cPpQOAXI29rhZ1wECAA8lLjWabFFn/m1a1IO3zfKX3c7flgL5IpUXNYXGjRYIwNGQ+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="0VPq/ysI";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6FD606A335;
	Mon,  2 Nov 2026 13:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF6FD606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=0VPq/ysI
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 61FD71A1410;
	Mon,  2 Nov 2026 13:07:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2E52860750;
	Mon,  2 Nov 2026 13:07:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EBCFA1032909D;
	Mon,  2 Nov 2026 14:07:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793624844; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=vd4UujPDzA0eLjqYOmoFDMFIfeJnmHMPRcAx0AsIvgQ=;
	b=0VPq/ysICkeaWSFbmA2Cpjjku3uMcIXbrCA+Yieb6NrUIyEwhfNMaSCEApKtwxx6JIR5tv
	v73EdDBT5m8P0CD+ppA9lLE6EnQ54U0a8OSJLrUZvQ+3z4d/XLbH/3L8HIy58XNVRMqR+l
	6ENXlj2a6bzkbmLAJgm4Oz4y6VtZx/pgXtXNBVWDmjbND/24bLG70/YG3Ruy+B9yJC7WWt
	sDWPYxTHMoCS9JFGyAE5lPM2GBdRohTcKSzEHvUNj6Iyr5KA1fUtMovj787wHm0OPIAJb2
	crcW/O2izhLhv+jgjnTwiLQ3r3xbBtz/KShvvvMHnkLQUKk3sscBrX39kHLjEQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 1/3] dt-bindings: rtc: pcf2127: Add support for clkout clock
Date: Mon,  2 Nov 2026 14:07:09 +0100
Message-ID: <20261102130712.25104-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102130712.25104-1-herve.codina@bootlin.com>
References: <20261102130712.25104-1-herve.codina@bootlin.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

PCF2127, PCF2129, PCF2131 and PCA2129 provide a configurable output
clock on their CLKOUT pins.

Add support for this clock considering those devices as clock
providers.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
index 11fcf0ca1ae0..11c0bc04f304 100644
--- a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
@@ -27,6 +27,12 @@ properties:
   interrupts:
     maxItems: 1
 
+  "#clock-cells":
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
+
   start-year: true
 
   reset-source: true
-- 
2.56.0

