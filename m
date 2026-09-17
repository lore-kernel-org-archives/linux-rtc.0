Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1A33B14A2
	for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671566; cv=none; b=cKJsekobnSYGN/l3SBkOMf2UgOhXDz6v5vefijDBFTNb/+9JX7ZhzqpiKsw3hxYkZmA39oEI0+b9/SWtSXZC0ToItXIMFUzXeSqez4gubQ7R1c14VBwQjxHlvg7GZgjX1Cvk5XE3hpPpKfcj/K75JTOQrFb+E3NTXcTV5+r+tK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671566; c=relaxed/simple;
	bh=KfcKlga3iduqVUj46FoNFc2uilLHGU4EeE3eYe4ELNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNH8vpwmuUxFtTpKpvGTZRITYxwsowRDdR+X+xMGbJrvYzyBJCy2Ik7En9+UxU5dOwhVCDO3Mn8Ev0TRtNxPcgJajMqisau1/KTzMqHZhCX+jBQnRApGqGjbmmD+fNWPvuCRpEd62lHneoKOwRNEdJKkAgJG9t9YUXpdSTCoqKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=LOaIoenO; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="LOaIoenO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=OWSWJHpcU4VqZDtiauqprL6s7wDQzwSOM87tKFR7OdE=; b=LOaIoe
	nOorrep1Gs+Vb2NzfJ+tS7069kGvDRKaXTLHQ97M33Rp5DmvfJb5AeUa1Hr4I+W4
	J2mz/Efqp9n1z3BAZc9sFE2AuDCJ9Glktd2jonUj15gXmMKARrzMkiWbNDuaVedm
	nfYV6ohZ3dL8s6E7YCowZds5qbRt5jn0If51SdykHhzIe5q+sTckE1ALa11LtbSE
	NS4BU/j5utuh7NmZZPsuZXlAIV5HXgWvBwAtsDfstjHv94cXSzM3ED7hJzOwYiAu
	70y59VXDd2opjvUsppxqB8sSEHY3pXLPMOpxUF4OqQoWXrePjiGIwtYZpsg2zeN2
	Dm9mpt16ENqOiEBQ==
Received: (qmail 2157834 invoked from network); 17 Sep 2026 20:59:17 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Sep 2026 20:59:17 +0200
X-UD-Smtp-Session: l3s3148p1@MRVwYbJbEsAujnsL
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
Subject: [PATCH v4 1/4] dt-bindings: rtc: rzn1: drop unneeded 'start-year' from example
Date: Thu, 17 Sep 2026 20:59:04 +0200
Message-ID: <20260917185903.61253-7-wsa+renesas@sang-engineering.com>
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

We don't use 'start-year' in upstream DTs because the driver does the
right thing by default, ranging from 2000 to 2099. So, drop it from the
example, too.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changes since v3: none

 Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
index ea7b039a91e7..e96007981c34 100644
--- a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
@@ -91,5 +91,4 @@ examples:
         clocks = <&sysctrl R9A06G032_HCLK_RTC>;
         clock-names = "hclk";
         power-domains = <&sysctrl>;
-        start-year = <2000>;
     };
-- 
2.53.0

