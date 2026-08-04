Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E44148CD78
	for <linux-rtc@vger.kernel.org>; Tue,  4 Aug 2026 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863167; cv=none; b=SYK+7Pf978en/8Bn1SXJnVBw5YPcTWb8FM4ZwijX+UHyOvWAeqgMpbCA6aXeKJJ8SYwDuwC2o5FkDruriT6MIY8KKsHsnbNczH+Qp2kxI4raU+rQQUwSpfNgT35L1wWDUNIZSfMdPSO1tAcw/sz4ZTXLA3qzO42prDX+UMErBUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863167; c=relaxed/simple;
	bh=BP5isHWJVSgsQc7eHb27miIKkXny1ILGVxUFS9gjsgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KPI5agOlVB/ue6HE1PxGYXz70fwM6lPg2IH12C4Up1Ucu7s9VofIOwgNRezijJZ3YbTx8yciTBwe0EFcbrgIJ7fhnoS0H9f7LIxXgvsb53mmNntf+MR+jZd3BNY1liQiNE3XVnw1J9ezd3z4T19HgaAIpEfkyRv+x32ckwMRmWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5E/1iZF; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5E/1iZF"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38fe113c792so5761a91.3
        for <linux-rtc@vger.kernel.org>; Tue, 04 Aug 2026 10:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785863149; x=1786467949; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VjB+Pa1McUr4XyZZTJgTh82TNmXCDaoM/UdBX+H7SC8=;
        b=h5E/1iZF9Tmx3U8tEzCB1W5zRqZHVkBs6YsyqX9jlRoPI4Vsq4OO6bAtA7D/4V3puS
         9n6WidwKBLsKG8K87/us1CZBIgqiLxApVjHzHXqWy8PRJxu1rcVf9VvgSbdQI7pCEDBo
         RlTA9YqAUya8mLjkV92IvVOSYy/goOTn8D+b6iuxiNhtj4xvxd1nQ/fsKWebrmr3/H4B
         TGEwPmO0uGFd20V34TyvHLz0YE7NIH7kgG7FfyrfZyAYuQPLFbN67Q2LDqTceP3z/DSd
         T8zdtk+8KvlWK1bcV/ppnGFyZMopIo/D1QxKg4bCWSt+Mxw/50hGAIIOMLzKvGLbdbNR
         jWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785863149; x=1786467949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VjB+Pa1McUr4XyZZTJgTh82TNmXCDaoM/UdBX+H7SC8=;
        b=iy2EfRRKOm9bxEMqNR8BcRjozPsKTbBC5fEz8D8k/LV9+Kxd9sqJmsKMcgU4blITN0
         pvNoDes0DUQtv1gvZAbV2GXIJIB+QCS5sCL7QdjGzz5cSvfByEDpaEGuEJ33ot7a4pEf
         s6wJwNBRiFoWXEbjWyGatQIID0lOm1yBKxBtkCyh2cj8OwN65HjNQF8tT3Yh+O560Mce
         Wbs1YaoVMzW30vNAeMrftmoJU1Xs5L2JkkHkOCz5n2QeHaAAOzsOc3xrdPsntK2JlSw0
         kR2f9S2p2u0UguVvWezT1vZFPyp1RLe5CSIAvKQ7CLE0NNRe8p17lzsNQb68Q1yyi3jN
         Qvow==
X-Forwarded-Encrypted: i=1; AHgh+RpfPvk+K46T5VcrgTgrM1slLP3wOgHNqzAnWcQ1niVH99hhHhanFtO4hZRiVUls47nlZ66jwcs5oa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEhttjZqErQZD3ZcuGy3mzSpIls4YdbsZQg6y5gTmMrDTPGEkQ
	8nvVP07A31wvvsmdnYf7G/5yNKIT6bXiTKPHJy5WjMJ9FYQLMn8Rn3Cv
X-Gm-Gg: AR+sD12DyDwLd/QYwEAjOy8EyWN2J5rdONdvRtPeREuotqcL1Jjp9sx8NEkDOJuvPG+
	9cxjhLsMGYgah8x9GDcCdtYQ37iQNJmwoMe4w7ZeVrQPnwqGT4hPkvXZ6077Lfi74p3hLZ+JoCw
	7XoU9NxktsWb1rhHItiAtupERS4KmAIA3z0X8zjsJyHbUXbnfnuRhbU5pr9M6tD9fOLUc71Jm4F
	HkxL0fx/liDXUUDa0qWL390vNF5cLMuOtZeBLPcZmy5wyyiOAgOyptjXPhzSA0M2VgF6UsuG4Or
	a047Qc/hvY1KRZcVG5YN8s0qYZPWbERTYHSo3Okg2kxW4hytTKYR2HUUnAQPHmA4J036lc/rhSA
	qyYtx22pTzDvZixshinm1flKhYz45E3tQW9c6vR8Rm49UGBhthgGfC5dzKzM1hVreHR5nkodwVO
	KuGzYIPmGnMnaDQu6ks8+oFDl0WDOdH19bSdB0WBRp4GTuoVK7HISVBItPGMKWPKNUrOnyV2s=
X-Received: by 2002:a17:90b:264b:b0:381:bcfb:e710 with SMTP id 98e67ed59e1d1-3903c64c81cmr451371a91.3.1785863149041;
        Tue, 04 Aug 2026 10:05:49 -0700 (PDT)
Received: from [10.15.72.252] ([2409:40c2:5423:e712:2aaf:ae79:67c5:476d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca52d329sm5147124c88.4.2026.08.04.10.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 10:05:48 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Tue, 04 Aug 2026 22:35:05 +0530
Subject: [PATCH v3 1/4] ARM: dts: ti: am57xx-idk-common: Remove unused
 ext-clk-src property
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-ti-omap-rtc-v3-1-ba3bbd8af570@gmail.com>
References: <20260804-ti-omap-rtc-v3-0-ba3bbd8af570@gmail.com>
In-Reply-To: <20260804-ti-omap-rtc-v3-0-ba3bbd8af570@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785863118; l=818;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=BP5isHWJVSgsQc7eHb27miIKkXny1ILGVxUFS9gjsgw=;
 b=AglLCpt0Ow4mCeWLX0NY9rtIDhK/08WmnqunooL/nv6BacQqxByO9/HQvU1mtVT1ZJN8n7QoA
 FKb0J8AydZ9DB4o0MwIVRocvKlO/ncX/sFRjei1eYxdCCcuUFKTEKfM
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

