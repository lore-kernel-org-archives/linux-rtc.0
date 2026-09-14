Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0062C414402
	for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420737; cv=none; b=RIl0zhSDvh4LFuV9hMBEEd46NNvCZ7ROmtVrqEKXfbZ97uhm8o7vn9UsDVNpJkbB+wxuXm2YZPKZgUfutGaTJCueTMcCfHpw6dBleJJ72m7JRlggLz3Pe6QTW5A4JhHEzqJyBatBlvCpf3cX8hfLAzxnjU/bDSr+WuBJk46u5Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420737; c=relaxed/simple;
	bh=9bqTNytpqzUdX5Zti4z2Qq46Zy2iFA/F45J5u5zYS9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=We1yTuBQvI9cnFnalvJiXevx1cz7bjTDztRBukgKnB/SAjEAL/okmHcr8kFMRUuEROSyaxq7Izn1nOKqEHPIGXxcHJv4gxkbMhVu7oZYDQBv8f9jyjtiNU7GRMhweNd/Tk8lInKhKEAdYdSJF6WuuRuyvnEN9XLVdz9Pup6k9wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=L6PtpKI1; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="L6PtpKI1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=JlLwoqIu+nPm0qnjpd1kggoDf53xt3SGWX9Z9HWkg3k=; b=L6PtpK
	I1DT3ujaJ+SRpi238+7xgsSMG3wJb+rB2g9yd/I/5Zv5oXHHWM19kUiNGO2imGQf
	JWvJb6qpleSuOTCfZvP2GutpZIzUTkJHqIUMs6L3VyMmE8eszW0kc8UtdhNV6BTU
	H2oFz5YVjysel0XjfxzwvXH4u3An6x7hKjABUJQLocncesYqk+ng74RXvIYfEVdJ
	vrcVG0mQ3BHaMvSNnRBpFWB2ups5H618z1QeA3blAaIDWSwVk662x6Xi2U3Ro54W
	DjKl8/CI3Z95NmvBoAuBGdGgIELtap1muze7spss8V3Ry+AhZcGYNsgeD41TNVRk
	7BsfZZA1ZMOU8Gsw==
Received: (qmail 892911 invoked from network); 14 Sep 2026 23:18:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Sep 2026 23:18:46 +0200
X-UD-Smtp-Session: l3s3148p1@/iG9+ndbhrYujnvr
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
Subject: [PATCH 3/6] dt-bindings: rtc: rzn1: interrupts are not required
Date: Mon, 14 Sep 2026 23:18:28 +0200
Message-ID: <20260914211826.73727-11-wsa+renesas@sang-engineering.com>
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

Interrupts are only needed for alarms to work. Reading/Setting the RTC
works fine without interrupts. Drop the requirement for interrupts
because an upcoming SoC does not have interrupts wired.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
index 7ea77cd0bee1..b426a34958d6 100644
--- a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
@@ -52,8 +52,6 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
-  - interrupt-names
   - clocks
   - clock-names
   - power-domains
-- 
2.53.0

