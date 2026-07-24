Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C763D47A6
	for <linux-rtc@vger.kernel.org>; Fri, 24 Jul 2026 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784884583; cv=none; b=nmEslprYiF6JYwLOkDj9t5VgQh8snXbgNJS384xkrQCLhWsRWL/Oa8+gSWbCNWLc+4ROiZsaBcpZ7nZS4GOLfvvyutq1dhqgLfCvIuW0VC5nnBeB7m7hiC0t4VfxaO8yRyEep1/JH/POz/KM1yO0BlmOhQjkD8c7XaOEzdSuXiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784884583; c=relaxed/simple;
	bh=teMAPguyylPaCMYb5vDXceBt5uTOrTz7cewNFhv91cI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tmV2NoQo6qe4cUhnfWPB1o4Ph9mliOTJC/1ZOEodrhkDfUyC738W1VnoI8oj28Tcgq2/kqrPO4+yKsdM5jOjrH+yZT75cOrLAYZC8udT/Bv0ZZLVcxT/SwVxLBgN20ZkfAriJRO9mhRcTtZOJbt5DHr36y8vv7HoNFSNHHYBtZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0RXY89s; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0RXY89s"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38eca09faa2so25810a91.3
        for <linux-rtc@vger.kernel.org>; Fri, 24 Jul 2026 02:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784884582; x=1785489382; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SlKvVsAZdZyNcMm228zHcviyjmOcHXNmz+JngmFmwiE=;
        b=X0RXY89sHfMshCrLv/pEb7lHmfhU83DxfdOY6kDu0EL+Nj7N5vgaRGWsZ6pmatxwsu
         KC9eBDy5Z8BE9tDTDeDTpR0GqVEs/FJeWUK611ood5aX02eKSRXwqu/iOHn7FakeIJqo
         vySSxo3173kKrJPzjrd/mY9M+cIMSH7Nf7u0OrP/VCEWXQ0upszCj5tyEMNhH7jdxcNV
         rdkYL+cqA149CUJrl4zLf+7UciEkb0twzdlvWwKj1AfvWZjiR2icGy/lFNMVc9sv42ye
         Gej8j8rRLkwLmKAGD/szAmD3JJGjY4xpCQlPY2SxdkYwrdq2s5HgtP65h9JhirIc5Imm
         hxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784884582; x=1785489382;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SlKvVsAZdZyNcMm228zHcviyjmOcHXNmz+JngmFmwiE=;
        b=olopRyHZpynl9C3nWEIMoJZQ0Vxzcxb1AB3ibzQmx4ljCd+s9O2vBBINDmbnZqG5yv
         PAX49+OnXFaj3qo4fQ5KvPD/KDJ6dfcElSk6XocKlTN2Ixw4S/3yO33J9p1dO/cEbyty
         4A9Fx9W+1jZB01CfFTzy7BFsX428XKH2YrGNH8bA7jwz3F308QuYDyStCgdba5A1tDBy
         qrAi58hjUCnbtGl1SU2vRb4JpsE9Ow38GhQTrNQ3e1mJs35FxpQoe6au4viCfsCr/rkh
         tacRdB6U9GPR4eStnDdjMpO2dtAhHs5O7JpHUPOUgFyjMvk8kJ7aLUZXLO/GcHvXSX3b
         pWIQ==
X-Forwarded-Encrypted: i=1; AHgh+RrAcEEMkgsCzyjm7EQwz681/sVXMYT5BTAuY85LTkc7RBVe2lb/tX0C7nMjhjU66GaYpqIoPZ7Xj7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy84pua8GkjsGYO1zOQx5NLhl39IuFJgQkyOQjNHFhOLVJ1nx9
	NeB9SKl7fEIajE+TxNTna17eXv5PlZOENBtbwqxaNQnvvQywTtIUALiv
X-Gm-Gg: AR+sD10eAUBc1QH4cJO0ygAzhxGWSfjnMfZNXt5iUhH+LBMr1wWmGvR/ueTb/Qkv9SI
	wgiPq5njUJBRfOSYOG7Ka6nceY7DM9ro21Vl3Ay0CjjempMdTiJRF3/WCm6SSyU5Sru7CkYWiWu
	Xms2//ky5bsDFtZohg6yCSG3EJPjgg1jgYAfOoOo69CWg7jJpZqEUwJ2Asod+gmwHV3/5Bs/yNe
	Ytu7KV9xY3pgG9BhxtVr5Vk2uwaw3zDuJFLGM2JA4/Pjvn9P+7+yKxdktlbjL8ujj/IwTjbajxa
	N1WbxzDZBbRhhpZ8sdx0R7C1EWL+XSXc4wnmBxuCFAo0cpLnVf9qItwdbEPKM+tAmYYPg2f6dr2
	1muSH2JVJ/go4vTR24WQBZsCiMC35gBa4FNTJHVERXsZU29uLgAo2NQmfLmN/Ke3XgazhOyuoa1
	mZY2LMLzK4aLBPy+s=
X-Received: by 2002:a17:903:124c:b0:2cc:e648:7e0c with SMTP id d9443c01a7336-2cfa6f8c2ffmr56582265ad.7.1784884581649;
        Fri, 24 Jul 2026 02:16:21 -0700 (PDT)
Received: from [172.28.140.252] ([2409:40c2:5420:f772:24a9:f23f:ed43:a5ce])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df097e0sm29005610eec.17.2026.07.24.02.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 02:16:21 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Subject: [PATCH 0/3] dt-bindings: rtc: ti,omap-rtc: Convert to DT schema
 and cleanups
Date: Fri, 24 Jul 2026 14:45:51 +0530
Message-Id: <20260724-ti-omap-rtc-v1-0-ffef78853cd6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AMBBA0V+RWZuEejV+RSyqBiPxSFsiafy7Y
 nkW93qwZJgs1JEHQydb3taANI5AT2odCbkPBpGIMqlEjo5xW9SOxmksVaELKSVVlEEodkMDX9+
 taX/bo5tJu3cB9/0ATNBdZm8AAAA=
X-Change-ID: 20260724-ti-omap-rtc-6a5c5888e7e3
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784884567; l=1158;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=teMAPguyylPaCMYb5vDXceBt5uTOrTz7cewNFhv91cI=;
 b=MMq2SQq5KqAySM9j+WVtWXO35EXoE6FO1+qCVrYPLqIIoIh4B3/LC/xsN+5ZBGr/Ye2/oz9HS
 P5j/Y60+jAACNo5A8ruD3h8NYzbLjfk2tGzbZFltntTSL8rBncXjAgA
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

This series converts the Texas Instruments OMAP Real Time Clock (RTC) 
binding from the legacy format to dt-schema.

During the conversion process, two legacy, undocumented properties 
were discovered in the upstream device trees:
 - 'ext-clk-src' in am57xx-idk-common.dtsi
 - 'ti,no-init' in am335x-shc.dts

Both properties are completely unhandled by the rtc-omap driver. Patches
1 and 2 remove them from the device trees. Patch 3 then introduces the
new YAML schema.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
Bhargav Joshi (3):
      ARM: dts: ti: am57xx-idk-common: Remove unused ext-clk-src property
      ARM: dts: ti: am335x-shc: Remove unused ti,no-init property
      dt-bindings: rtc: ti,omap-rtc: Convert to DT schema

 .../devicetree/bindings/rtc/ti,omap-rtc.yaml       | 129 +++++++++++++++++++++
 arch/arm/boot/dts/ti/omap/am335x-shc.dts           |   4 -
 arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi   |   1 -
 3 files changed, 129 insertions(+), 5 deletions(-)
---
base-commit: 48a5a7ab8d6ab7090564339e039c421f315de912
change-id: 20260724-ti-omap-rtc-6a5c5888e7e3

Best regards,
-- 
Bhargav

