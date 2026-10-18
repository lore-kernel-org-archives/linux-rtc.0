Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9059A4AA416
	for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792334274; cv=none; b=Sec0mob6iCrMeBdjvXyEOe81drKuH7+V43NuqaDFJBlGL/nMtxx0pq00GpYsR0GHL663iO5uQMfO/rLM11l188T/IHymPr2KJNqxI9mA50QZ+HAZ5MtINtilAdFKkQoR9cAmKxMNM6B4SeR5dmh2+MFDOfQUhTY2PXtYyeZ4Dkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792334274; c=relaxed/simple;
	bh=5k7F0mIR20ZConUuzbdU6QkCxs915s50rLRdWwa5YMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHvyoLosfqbGSUSauZg3OUMpoAUe70ekr3XU8uN40mRxAQBArYXyaJQPmN8wmTbrQQsJJMyKTyO4u6UeCE+aKoLxQm0JrLn46nnJnrRyOYr2sDrHB1V8OekzeZ2pUwevJDFr1pI/wh8cEHdnL0EJCpkmSqUp8YZE44e8qpNL3BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQDdmrU4; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQDdmrU4"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48b042c0759so733523f8f.2
        for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 07:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792334272; x=1792939072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wFcZmTOFsZoMO9gy8wdBwLf5bhkHxxJ9J7LR6D0FEOU=;
        b=jQDdmrU47J61SJEZkgKAEWOfeIpYYGfSuydkSsxbGUfAiWklV5nK0lcNHa2H7bVU6K
         Rf9QWcAYvcTBsFKDTyQ6zTzlFw5bkjcImc8QG0ENibtxrDyn+XpXEUzh/CuHC5vfXQeR
         D0IGSWd3jx0Ypuc0+h/YcN39/sEHAmsI1T3iYfjG4xZ/IbYgd+vwe2UjOgyqQY5SVGJp
         +i2OPKHzU8Q2lhejW673wt3bqK+0w6eT2aFVyWz0AhQw1IKW+o+ha+XzUNfAh5TUnp4A
         Ff9l7NAF2S8Y8AO+dDL8uQhBTq3mzCXwDFglM3xXH9G8WpwxQOGLIOw2acGqY2ifjV3K
         xw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792334272; x=1792939072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wFcZmTOFsZoMO9gy8wdBwLf5bhkHxxJ9J7LR6D0FEOU=;
        b=rrZskHpyRrBpQYjcxmebaSJkKcuQb4gBLTo7cm4Wp+RyiGi2ZclVqmKS4HrFQ5mpWM
         Gub/zyFS2d8eROB+gIRONA12Ud3cUqPS5MBZw63SHK/k4gGXnhbNuJBX3yaYk9fylN8U
         DR4bIjzxEFzgUNF2T0Xl1WNDi+Nz+KTCg/+6+CgXzhAsZ5fu0/xpssNjjLhKugBpK2pq
         fWcuknhzdsmcvLlYP4S2SKFDbGFKYFtS8zuiy9Mlebmq/4lhe5907Vvujia9h3GerYiZ
         y91+nOq6CvD2VdwEfesL8qP2HUK36bLhK3J6XHrUVU9TCIIiVQ1Fm1eTY9dABmRNa1IR
         o83g==
X-Forwarded-Encrypted: i=1; AKwUvBxeN0P60DxgdWHDya0p4hn6XhLle6ur9HIPPjFx4JnAanORyZXv06p8ysEINFG0tax2o/2KjKsgs3Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYLoxJcG8AxSaQK2KZ6/l0lzMhqI4DAvCd8SqK+R9HRLWY/ggdqX
	tPazgjRrqPPS1QSSzbwkuRzCJMEoONFBp9p5846FxJX+Enmxw3KvBBjU
X-Gm-Gg: AYBFou3UPm5/3ymmnfgaAFHdlzZ9oo1+GdDoXLHtVyNR5bOzeeBl7x0wBo27BHzIk2F
	v8rXr//tWKYZKToI06nJuI8qXzY1gdRLmos+imBUXd4d8zrSDkx1cePTcEeWOIFwruFkVpW07SK
	2QVqj0EACavRtLgvP0hLE9p6iL3AkhO/9qQaRUzfk6kGqm0NrrI67tIXLflPVmXSIfk7o0d0eLg
	SyLRiQVU2jv1E3XkSb1xOCHyF5/Gv2szV7b9EXgluJM2z1UkLsHodSS2l6wWXS2mcmXIwghcN/G
	1WEAKX9Tnk5RkIU/Tpo3TKt6gCK2rxisbyFup4YNPjafGyIClnb+IsFwVYuF5eNqByRtHXx5wiI
	XEU7QI6jHasZvhGNHejC+wvTdThmlh/q8ieY3JRxZPFzcTC+vo+TFUI5AZ5dMczhsl1Th/60MTI
	7ZkvxfB4nxLFPHGbt8MAK7NyU1W8RDKDKT3UK2RqhcKcolqTdlNnUFFDDvMwF6BrgTxb123UtjQ
	DBp37de/TBziV4BSSm7p5CSCAcFe9AKLZdBcTv9h5qydA==
X-Received: by 2002:a05:6000:3c9:b0:48d:f470:6b3e with SMTP id ffacd0b85a97d-48e08017195mr8926508f8f.13.1792334271780;
        Sun, 18 Oct 2026 07:37:51 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd510d60sm16559652f8f.58.2026.10.18.07.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 07:37:51 -0700 (PDT)
From: Sander Speetjens <sander.speetjens@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	sander.speetjens@gmail.com,
	pbrobinson@gmail.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v12 1/3] dt-bindings: rtc: Add missing type to trickle-voltage-millivolt
Date: Sun, 18 Oct 2026 16:37:10 +0200
Message-ID: <20261018143712.1040152-2-sander.speetjens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018143712.1040152-1-sander.speetjens@gmail.com>
References: <20261018143712.1040152-1-sander.speetjens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trickle-voltage-millivolt property had no associated type.
-millivolt is not a default property unit suffix, so the schema does
not automatically infer uint32. Explicitly reference the uint32
definition so the type is correctly declared.

Suggested-by: Rob Herring <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
---
V11 -> V12: No changes

V11: https://lore.kernel.org/linux-rtc/20261014083016.332338-1-sander.speetjens@gmail.com

 Documentation/devicetree/bindings/rtc/rtc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rtc/rtc.yaml b/Documentation/devicetree/bindings/rtc/rtc.yaml
index efb66df82782..e46d50b1063e 100644
--- a/Documentation/devicetree/bindings/rtc/rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/rtc.yaml
@@ -51,6 +51,7 @@ properties:
       if trickle charger should be enabled.
 
   trickle-voltage-millivolt:
+    $ref: /schemas/types.yaml#/definitions/uint32
     description:
       Selected voltage for trickle charger. Should be given
       if trickle charger should be enabled and the trickle voltage is different
-- 
2.56.0

