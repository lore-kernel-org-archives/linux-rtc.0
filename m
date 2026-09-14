Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05CE33E346
	for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420737; cv=none; b=rPCHXpGYkjZsahdc9xHImpkxiY6heOUebGcyacjdvNJPaVgL9hGwwmQRwfCJ06/2Tg5d961wGUpLGlG52IVuQnC7EORigS8n9JJchPdZdqV4PDDO5K0xfitx1ikAcK166FivVov2y+1Jjdgd1WxsBmFvmZ7OvGyvU0Ey0WBeuzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420737; c=relaxed/simple;
	bh=816jbw1UaOZZPT4qvlKB5sYYu83BuleHbDj1ZgcFbOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8rB+HUWC0jQJmdYwGOyLxzxkuVLv2UwYqsmASyYMyJ3qPA+izQgnFt4N8YDZJgVmF44DIa4u/TpvWMORdfUX8bSTLBZScz+M8ln3VrhndReFH+FhTIHhx7fz2XaDoNWVYi2whxIDHalV3aFcvX1ZpUfitgD84nLA9wYisY2p8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=KURBMiYm; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="KURBMiYm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=V1q1KL8H0Kb3zs8zgane8yh6ez+l5mHY9fyORNQ8DRs=; b=KURBMi
	Ym/7h6/5rwP1q4jW++RCi0hUtE1GCvONyRGJQXRkpj3hluvN4bU6ysDm4uQvaAaJ
	c3lsShmfX5jPQxDRfjMYl/VNA6HhdbRkkUTByNISW6OleToAPOCMKMnWVd7AjkOQ
	egFpWhf0Efx/ehwDWCwzDuyBmSlnEtpnQzBqeXwjfKUlJoVzCskjE32j3WXkWVvC
	N+eXDR0weDLdsCKPUMQnl2+9sl5fkjoCr602cvr9hli8RfhFAw0YuayZxbxpIZU3
	PnIgq6vNOS3cZlBO5braDNT+TzYL2mURjvCXCehGNM6OWmXiQeeMbiZ7cvKMVSPw
	HoYdEpG5pEjrYftg==
Received: (qmail 892825 invoked from network); 14 Sep 2026 23:18:45 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Sep 2026 23:18:45 +0200
X-UD-Smtp-Session: l3s3148p1@deio+ndbeLYujnvr
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
Subject: [PATCH 1/6] dt-bindings: rtc: rzn1: drop unneeded 'start-year' from example
Date: Mon, 14 Sep 2026 23:18:26 +0200
Message-ID: <20260914211826.73727-9-wsa+renesas@sang-engineering.com>
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

We don't use 'start-year' in upstream DTs because the driver does the
right thing by default, ranging from 2000 to 2099. So, drop it from the
example, too.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
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

