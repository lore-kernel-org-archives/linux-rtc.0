Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A02C41DDFF
	for <linux-rtc@vger.kernel.org>; Wed, 23 Sep 2026 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194992; cv=none; b=Ol29Pw9hfjI+xS3/rXNNJfskDMiFY2i/OEEAjJMPXyEUDGGT+HC9mB3BoEdA4VkM8o7wqSZJPO8tXg8XV6n/kl85i06lKP01LixMxfYpFrGtmfbNhBnZsWeWzFA80YFJvY+NyolfeZUWg6prWQVbJmC/+Fkm41X2mIq9FkScZcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194992; c=relaxed/simple;
	bh=IKu+NW7V12nnMBgKKHdP7rj1fpU2GspG4UzSnncTVMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBh146m9kvOPyO05otrFMvVWyh7w0XgKKFDL1THo9WOTRs6263/YtoUqop29MLazRWoJ1sD7fM8f7Ch9cl2MESjLXeKL/0xy4dBOBR9ZnFW3Cd77AQKrqqaj1ES+sa6BMbnvM2pfE2myp/DmeWlGrBlybIe3sKIeDhfScSYyhdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VP3eZawc; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VP3eZawc"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29d50b7cf9so185802966b.2
        for <linux-rtc@vger.kernel.org>; Wed, 23 Sep 2026 13:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790194983; x=1790799783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qQkzg0CGegWquCnbwRamX/sZPF4fvz02MpKEACpVE4E=;
        b=VP3eZawcfCqhXEKT02y1EkPiImNqUQJFySdTatlLfPJxzoQjIhZS048w/xfRVLz5Gs
         upkVCy4FQwfQXVk8+p5kZQG7aHYCjikf7iJ7elwz8XC1d4UDuCb0fgnertOy5dmwF1EG
         BDfzjtFSgVCjUsQIpkQTfAKhvNVY30NIJNQjyygyeFksSv6OgFBdpcHEKyMuBOmdzRSa
         RXKCyVJSeOA+/uWUrmUH4+grPlg5dN9TqmGCWftv7q/qB5Uh3H0Aap5w1A0GBLzyCFZ0
         iucr7mIq+0LXzeHw+ZzInHZFAudO478yw4YqhT4NgtUmu5dXNmlRyRX8TdNLgCh9CuFe
         7hFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790194983; x=1790799783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qQkzg0CGegWquCnbwRamX/sZPF4fvz02MpKEACpVE4E=;
        b=gAV/WMn5PZZrXoQ3cLvKBaCSG/RVRCUnG8jndOGuKo6x0bAK4a4tl5opK+gtRDBpz5
         yUtHIordiTZiSS2d85jFbvzix+Fjjq2aJ+Hnx4LMObJ/jebX1foZ9Z/A6c8dLRziABbf
         HYsUZUqXrNouPKIWXFH25bfWcgVlsq+i1oDq1wh0bVPvV8zSaXZsUlbcsfOwZLz25Zf0
         xFbv1Gxhn4KX/lg2svfoYGHVeW/qG+ar0LRYxX5VomKDs8CKhc/7vjDeY7G0yUeX1jkm
         p5VIxF0QNF3il9JUsLzhvNLbE4KjFXaRPc6J5k58eSVjXZ+ffotr2FMKOXmFj7MTAlAO
         7o9A==
X-Forwarded-Encrypted: i=1; AKwUvByJcRZ+u4SiTZuYHGfKkml2qS/NH8vHK0XfAgPWEXRabsYKjfWveZFRM1WiEjtO5ByIr6xObnO9LDA=@vger.kernel.org
X-Gm-Message-State: AFuF++m0fuWSoJys3ZJpHASK7XMzRNVi+J8f8CFrhMiApSwpiQSQU+UU
	nk5WfLRdYgROTGl42ohf7yMaMy2K4sLnT5sZ9VzjUm/loBI5stbGlqDG
X-Gm-Gg: AYBFou1H0gfT3A+n69KlSBgphvQ2JxFd4QahZDuztOJEVNV0/7/hUk8tm5+OVrZe2pY
	qSO8iUaLHatKdORQuVwWm3gz2gDLg0Ic7EJOCtrPVzNFokiBM4eOucez0IbNPs+ODED7JUn2cyG
	IB6LXoUWu9ygeYnEfnMk3hFriQ/TPKn2nyfp0OSRpScVkwR7ztvVPMx5f7Clq+sI7Xh3B8S8ruB
	OQitvhOXvmumssapidQJ0DxBhklOkp/L7h0KfPIdVGG9/K1eI1OOZFYD7IMVLb9c6s1jr+0qzwt
	/Zu5UqGDm6nJO8uBoqJNSYPyyPlPJjiPvyNovXrghpqRH4czaVbLrpwNDzEpduoZsQY6+rtg0wD
	xZjvyDmh8ya2pPGG94wqzMwIWIlaGtEx7FjxE91A7LmHLG6Htt6SxuZ63p4IXAsYEMTf/GlnD1G
	KPUEfDNB3pRNPiX2OkvJcTSI5DGHM54E9oaQGnDI718xnEuC7SjaJak/POT/wPuQxldb5ysJkRM
	oTHL2U/16Efz36C8NT6rVyYigs5w67p
X-Received: by 2002:a17:907:a893:b0:c29:4915:83cb with SMTP id a640c23a62f3a-c2ac262664fmr19261066b.39.1790194982908;
        Wed, 23 Sep 2026 13:23:02 -0700 (PDT)
Received: from debian (ip-78-137-176-146.broadband.digiweb.ie. [78.137.176.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c8a44sm177243566b.20.2026.09.23.13.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 13:23:02 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: Pablo Mazzini <pmazzini@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v1 05/11] dt-bindings: rtc: sun6i-a31: add Allwinner B288
Date: Wed, 23 Sep 2026 21:16:55 +0100
Message-ID: <20260923201701.43391-5-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923201701.43391-1-pmazzini@gmail.com>
References: <20260923201701.43391-1-pmazzini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The B288 RTC wires one alarm interrupt, not two.

Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
---
 .../devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
index f2b91186ed37..1699e3576b91 100644
--- a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
@@ -19,6 +19,7 @@ properties:
       - enum:
           - allwinner,sun6i-a31-rtc
           - allwinner,sun8i-a23-rtc
+          - allwinner,sun8i-b288-rtc
           - allwinner,sun8i-h3-rtc
           - allwinner,sun8i-r40-rtc
           - allwinner,sun8i-v3-rtc
@@ -162,6 +163,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - allwinner,sun8i-b288-rtc
               - allwinner,sun8i-r40-rtc
               - allwinner,sun50i-h616-rtc
               - allwinner,sun50i-r329-rtc
-- 
2.53.0

