Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551163D5C1D
	for <linux-rtc@vger.kernel.org>; Fri, 24 Jul 2026 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784884604; cv=none; b=QkPVF09lgv/E20k1/9Gt6IL3VzlU/n2IzE1SpXpQAU10AYOXPOnsRs7a0wRjOZ/LgHaROZ3ckZ7ooEWy7WV4WFIX01QavhnuyitEkphY2QujnLGY95LFJ6MBqNKp9Kk1ib9aJZGXWmHiSo8gUe1wGLwhnYisQ9IoHuEKxznLg9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784884604; c=relaxed/simple;
	bh=BP5isHWJVSgsQc7eHb27miIKkXny1ILGVxUFS9gjsgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z/0sMUg+dtyHQ/xaV4R9pWmTxxfjeVVamuqylXiHpeT7Ho2kt9i6spzcK8wZZito/aMrIdHt3HJyNOlIy+lR/zZLKguRKWidMfzLfxWhJzy/8XkXDFhPbTSPbXQK9HAv88BqQWb12Ow44FI+9yoqPfsLX54+URMf89JKgOE/iWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckfVSnnc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckfVSnnc"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cf420670bbso400875ad.1
        for <linux-rtc@vger.kernel.org>; Fri, 24 Jul 2026 02:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784884598; x=1785489398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VjB+Pa1McUr4XyZZTJgTh82TNmXCDaoM/UdBX+H7SC8=;
        b=ckfVSnncK78p/IeyTdUn9UhFQMvZDSmQMRSAWFoucAUxBe2jYn5+40QL3DixOc1gb2
         UupU4EMf+wpQ+4wOBCn2/YCdyvHAIQJJGDOgF1pu16pCbYhbIQHIbHdvkoMhES6F2H3N
         +fRTsYYu4MdcgenaOKIp06yEv0OUvxmcftsiVvR0oN4u2vtSu0sOF6OhCRfIM6NVPBiT
         uJ7Cmt5oZr8fwzMBJfeXHO1kZgfUTlVq74jFPK/tc6Z5r5qoh4M67rjIefYmBamTyUEo
         ZqdLobe/p6b3yCCSJqWQOmGxphRzX0wGfRI5vPfW8x7kVHt8Vb0+b8ULp0fPw0en6Z1j
         rG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784884598; x=1785489398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VjB+Pa1McUr4XyZZTJgTh82TNmXCDaoM/UdBX+H7SC8=;
        b=gFyVR8DHFRYJ/yp2y1IcEMjy8+5KYuGKXb5ELzXYVEWaxa03B4iLnqL4Kz1Eu03n4G
         rWoKXGUNyYQbpOrFSHZCJb1GJxD4lDxgUU1SQeCbFZg13AaS3F0lOINgSw/GDvIPdz5x
         0z4wn7eX2bWynVki8U30Wp7GwddN6kcQ2+NW089BDM/Tm4+zZ0DVVwY3+sf+g9un0/+J
         BTtAUoQ7rNsGnGokghDNOZ/Ewi2duKncB8A5smFhpnv6s3c0BlWEwgkFwtTzVZww0Qbu
         kua4l8oSIdoPBjp5cE6PCakat6iArbKRDq31NjpO0ZfNTiNXPKo0t4PssF0oiyncoDqi
         5RAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpx7Jq6MsIAiAvL1HlFqgbuOC1iTskUjpxN9J3jHZvNrF8XG+YAdjeaXYQOYtPHzTdAICeDtt/ZWyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywjwu0XaHeVGLrXzbW+h7uJJNKAcGN3DUJjyVeaO4L2hWKl1tL
	u+IGgxaMF+AGasQ9A59kMKnRXKe0eygTNm17TZruK6HYbh8Q/8YDk/bG
X-Gm-Gg: AR+sD10JDmjkV/libjLM84q6fi19JnVoXknTomhSA+qYetr7PQ5nCGln8ik54hbC+Am
	/09ICC8NzFw9sbViQEHGzikRjnmY5Zq+VPgUfnk6XujT5zbkQ0zaaGSvtcPUGOZRCMYrsWU1X9E
	S7ekVXsD5WBxG0ejQxXY1H2bgftRxrT5MuGnbxcQ9I7+sEOan+RVoTtoeQCnOfYcce6H+tT8Mzg
	Yxd8EYnj7mMHw6nkaGN0Ng6rEVWdcUyjNk2AoQ2biBhcOU/Jb8JaUdYwmzZMcd0dIaOQsL1OuMk
	ZdL9V1kaqtQWCbZ/jShwUqyRotA9JQvLNjcoUvz1yT8o/18c2SV4O9jp4A4pRoX0lQB6N4XCoyY
	y9xKkwwbiLuWZxlSTR7mbhtMywZyXb5uf/MVqNoWpIdlgZcprNNZ4As9d1NOinvp2m3FJCEmNi2
	2vmn7MGu3YlN4gpes=
X-Received: by 2002:a17:903:1b4c:b0:2c9:ed4a:c3a4 with SMTP id d9443c01a7336-2cfbc786e8emr26645295ad.0.1784884597950;
        Fri, 24 Jul 2026 02:16:37 -0700 (PDT)
Received: from [172.28.140.252] ([2409:40c2:5420:f772:24a9:f23f:ed43:a5ce])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df097e0sm29005610eec.17.2026.07.24.02.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 02:16:37 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Fri, 24 Jul 2026 14:45:52 +0530
Subject: [PATCH 1/3] ARM: dts: ti: am57xx-idk-common: Remove unused
 ext-clk-src property
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-ti-omap-rtc-v1-1-ffef78853cd6@gmail.com>
References: <20260724-ti-omap-rtc-v1-0-ffef78853cd6@gmail.com>
In-Reply-To: <20260724-ti-omap-rtc-v1-0-ffef78853cd6@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Keerthy <j-keerthy@ti.com>, Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784884567; l=818;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=BP5isHWJVSgsQc7eHb27miIKkXny1ILGVxUFS9gjsgw=;
 b=Arb/QliFJxM9kFp5UEcBYDyYbtPAeByB6h0+Q0mOkm4zPN0HBl3kOfB75858CY6vRmSGtm4HH
 MnGoAvMiTBTC6D0+JKrsHhb9T3VCOWeCrgg/sO/xnuo+FbPJsRdeJFu
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

The 'ext-clk-src' property is a legacy, undocumented boolean property
that is entirely unhandled by the rtc-omap driver. The driver instead
determines the clock source natively by checking the presence of the
"ext-clk" clock via devm_clk_get().

Remove this unnecessary property.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi b/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi
index 43e3623f079c..ef4bd554e92b 100644
--- a/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi
@@ -445,7 +445,6 @@ &uart3 {
 
 &rtc {
 	status = "okay";
-	ext-clk-src;
 };
 
 &mac_sw {

-- 
2.55.0

