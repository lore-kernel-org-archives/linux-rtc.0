Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7769353A6C
	for <linux-rtc@vger.kernel.org>; Fri, 24 Jul 2026 21:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784926946; cv=none; b=K6ZzWAk5tlhvB0wJA3ym/MY4/r95GT04t2+VZlJnbY3qP0yL6aoq+x5vUMOQyy7tvmVS5nk8REAja7B96R49rAO3L170xB67QbIZCHLsvCZJT+WcVq2vShjdW2zzEsqqc+yuZxTolzRoezlSFTh7crHQQ05rs7Tdi3uEJfxFMrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784926946; c=relaxed/simple;
	bh=BP5isHWJVSgsQc7eHb27miIKkXny1ILGVxUFS9gjsgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XjbrBM7j931qbTYB+kHcMQ5Hwxg7tGcQkvRNHP4IszEfWpfR8DmmLoUL3DtMy3fD25Qm0pE53A8QoGwdksdNRujnqXqiMz0DXP08+v3L9VA7JYDL/7Sw9tM0+NQXF94J+94OaY3yks62zG+PTtx6QCBKtiU8FSUohVegdBdaiWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAaQkehJ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAaQkehJ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-384c94c9423so115535a91.2
        for <linux-rtc@vger.kernel.org>; Fri, 24 Jul 2026 14:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784926944; x=1785531744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VjB+Pa1McUr4XyZZTJgTh82TNmXCDaoM/UdBX+H7SC8=;
        b=KAaQkehJ3bkez/cewHZmwzD3268RHAuXVh9QTKDgq6ggmeJnSg/AjhRGVdpKFlMtdt
         i6oGaWtWN8zHxggfAVomNLYYh+A30lEq8rd452cNNdYEk9elCnW2AhsIbLug8tyLQWYx
         p164558eFWoDvz/JEr7cguAiBVcsILazPVX1gIHfm0G0VyugqMs89cF3m6XAJ321foBI
         qouPnX8VclQBJXhUvZYG2pcCZQmuy2JW3N48zvWIbF1B4X3f2j+X896LLBflTY5mnnRS
         h3KrjYrAMP88LyvVJJE5XMv6YuMPDIYWzRVSyld9o6Yrzq60mpY6zwpDUv6mYKsga5Rp
         5ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784926944; x=1785531744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VjB+Pa1McUr4XyZZTJgTh82TNmXCDaoM/UdBX+H7SC8=;
        b=r1mW19QI693i9CNJWaveEKkXrn80Zb4uvVnDgVnkZ2c7asMVP0p6kZ2wYQEQtEtIqY
         juEkZMTQY0IEt3XQDMGqWpyJGlFs8sQQo3sWvwWjOnfbVaI3IUVrT8n13JQe/SozAGVL
         fBIhaxenphhsM43k1FypLlSTyxlaXqxaFqRbmetaHoA+fV7fZfGCyKw0d7UZNgCBSGvh
         2R65ou19TbYaD1sGItUszBbyk6fVIFDvBZkpehBy0WQlYM6ZXCNubtBWUPKb1nYbGnaa
         X/RUPEZg9m3buGF4FDIu7Xiemd300xbgOOoKNmzvy/NsesHCTeuywZdRmVjIlYyn3Qxo
         P6tQ==
X-Forwarded-Encrypted: i=1; AHgh+RofeqhAMzXZyPeBiZgNBWUSU5S3Em3Y8Nu9BKo9peuePgfR1Kn5P91tiNU58b7YeaFxESMfwpDrxd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPgiU/0Bnwec0XEe7So4UoO6/WvmflOnHZaO+3npEmJhonf1Dl
	NMLwtR2sLUre2J3THGTyAM/7x+PgXpEUQXODK2lmmXotrll+46gkTmaJ
X-Gm-Gg: AR+sD11wc5+yIQbrqzsmOFRJSJshxfsbhPY2G8l0hfi+8KWZOnJpyL1e+9mrByyzNJM
	LOXFulL7Cg+hdeLYc2/Uk4Bq2X1cH3bpvald45BgwBXw7v1MsctSC4G9Wxwi4ffU20VLJiCpA1/
	APynbK8Ahzy+LtQLceoE7CP4ecyQ5vG+EOwrwGeved0pZ7YDmAF7F/7YmcYhLqHtY18sctXq8o7
	drIQmwyEBaiUD/wuRXgVpw6vJabUkTEz6O8RhNsZ95cDeR49MY0wuo6ZvhhQbnBPGOhXFgxaWC2
	34hCajIva6t39n4USWv0bdX4dEmSzla0HHHgVuhNHCyGvEa9nIFpnRsE6uKVSwNY8JjziDxOnsd
	0TwShcC4VVdnAJ0/9L3Rej5SdAmStEJ+HnrlhZXaoJ6/Ow5JNxUivBUVIhvwDuiq7gDlnHzm0w1
	A6mNJi6owa831ndV8=
X-Received: by 2002:a17:90b:5707:b0:38d:90c1:2485 with SMTP id 98e67ed59e1d1-38f2963f507mr38503a91.5.1784926944335;
        Fri, 24 Jul 2026 14:02:24 -0700 (PDT)
Received: from [172.28.140.252] ([2409:40c2:505f:3320:3d54:c6f0:368a:d94b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548e63sm2485324eec.19.2026.07.24.14.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:02:23 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Sat, 25 Jul 2026 02:31:56 +0530
Subject: [PATCH v2 1/3] ARM: dts: ti: am57xx-idk-common: Remove unused
 ext-clk-src property
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-ti-omap-rtc-v2-1-13f765ca96b3@gmail.com>
References: <20260725-ti-omap-rtc-v2-0-13f765ca96b3@gmail.com>
In-Reply-To: <20260725-ti-omap-rtc-v2-0-13f765ca96b3@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784926923; l=818;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=BP5isHWJVSgsQc7eHb27miIKkXny1ILGVxUFS9gjsgw=;
 b=GZPjhTALNqNqEfqW7quMWgJj2Rh1x7yZRa6ZgyLobMt9wQ45rj6S/AMJuNBFY0uPEXflzMmHC
 MO5HSWxDxNbAVzCaPd/+kBztjYa5zlH0RyLkbkVIyWoItqadOrd4R2S
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

