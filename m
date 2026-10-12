Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42236477E52
	for <linux-rtc@vger.kernel.org>; Mon, 12 Oct 2026 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799789; cv=none; b=fouxW224Sg2/071q88vpc/YMI+U3ABAvwVWyS7EAObE8JW2UkECZnB3zat5tphJeEUTJBvRox6UKuJWiGjdYTKWKRGSRg3EnSYvpcyGZras4Fu8SHrxboIoC6cSY3sV3y/USXCSF959UkOL1FusZmjmzBTxroXqIIHCpzcKNEHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799789; c=relaxed/simple;
	bh=lqFyZF/H6AwrrMe7UJI3gtjvDDPQczserSqPhG0tCVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVGLAWz2CH32jxQtZFDm0oSEpbBSeI5VrancJI5nWKgIl8Yhqv5OZXmL6fK8Nw1Nc2iTNBHru+IIZdmvkVX286QrCqKbxe1CkARTDjz2u1ZUe7uP1KlyuNI+sy+tH5+ySUy8fzJdx+DD55minkK46y39tO2PgEMyEBUVJckVpXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tmq/V/aM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tmq/V/aM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a02667ccebso11246395e9.0
        for <linux-rtc@vger.kernel.org>; Mon, 12 Oct 2026 03:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791799777; x=1792404577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bSIEEiVdbd5GTxTHiyeMgIrG8fJXeKWJLeUgPGtIm2c=;
        b=Tmq/V/aM/h0Pl3GQ3Ck7W/bxyq36UrnhH0snINqjcZOO78hpJcvxRNEBBebxMsHDXj
         oM0knIxF1Vda1z9SgUpmhVpKP7qSz5fcywFWj9p9gmAHP58DhXoTaQ/H9B6tcLVJ5sI4
         AfT+hCNuJJ1Mpq0Aj4+twBmX0rU3NZKMJsdbYbGY2X8cppevI6GuAOeuU2mb7BG7fpb8
         atDf1Op1uCBsMXDI950RNmIcdAbrQn8F5/4zbGRE2EY03wqFqy99VNnraj2efyYxDHLV
         HKkW0rsbUuznCpBQVvfLco83NT++ij2WLXxhDy+/L4IAf+PwTZluqY+iefzqvIUb8rOS
         GH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791799777; x=1792404577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bSIEEiVdbd5GTxTHiyeMgIrG8fJXeKWJLeUgPGtIm2c=;
        b=Vat1l8SrHRXWmUQHybWV+YsxS/QdKC8A74QI3nc5cCMCYmbD7FBnCqHCNvMQ1bpY+g
         dj7KlG3vSLkKEGHb9zXeGnlYnl2J371YzYQGvezF6BlmG5ITQuiPwxE+jylDd3IKfigl
         vl0nrgDcyAwbWhFBBP06AkHWobbhiKnP2qaVTA4IbkII80Zk2yJE3qTj1OgaNMWTBTos
         pORp3YOdThZjBGuKGywRh98QrQRSkkkaM4BKaC9iJvhIhCI/Tgmmv4rOEhGDak+1h+He
         Y7Am9TT3mrAmhXvZ8Cwh3sAr88NiZ8sfT5cMIMCZ1I1wucfGRZbF1tvJXQ3vweEj0FGJ
         sCjQ==
X-Forwarded-Encrypted: i=1; AKwUvByQFYdC2TPXdyKvD0N5QPzlPlXfjpdF0QnftqJnL4zDdoU7fnz90Zhd0/or+lDLbZt2c8vnU18B5MU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJp3DgMU4UcreFLOrNuHHoHaCS5kCI8RJmZEjDzVYORzDse3Job
	PGmweQn8UGd1NnpNg1MJbp6TN+27lxOnz0reeOR8QgYIJrNHyEvW/lgA
X-Gm-Gg: AYBFou2PJRltouY0wBaSn5jlZVxkSf1pytIkHVnzRjDfbldOq8lWHuK+frttaJ6gIdB
	mbtAbioXxXwe3rHDGrFwrP8aCfueLavyd+Y7AQHL99Z40i7wAH3DOAp0w2W5NENqwrNuY4Qp1/0
	zmcOu5MXCIXYaWDbGGmxevCcwlpZWXeK8PhSCr0o3aJtPEsjb7IOvDkk5+OEGAdzzWvrUxZkd15
	mUYqhy9xF6mMoF5Ctso1RrKdqkP+WuvCi6c4EQnHGa5w9mYAv4sOzYkOT9NaGtbAsFftcn92pQx
	KUeyCQXwVHGTxe29K405IAvJKV/LhCIb1+U27/HvGRMGTkPHEFQHNyrMNcIX2xQwgnWCIpbXEIf
	ImUIirCBM0WuoouiKEaMrhH534EOETBQW2QWK41ezPYlyan6Lwz57/9mjpjIZThl53mSVBIDwkm
	X36TPcjInMFM1Vl2lRJIMXYaIE//Du1i5IBjXhfYMIgpp4k+R0/h68sE75fei8/AB8LpVNu7tMr
	tlprr48qzhuDCvlyyKIBqnFbGJKlDMK
X-Received: by 2002:a05:600c:6290:b0:4a1:813f:2a61 with SMTP id 5b1f17b1804b1-4a18e4ad518mr163049805e9.15.1791799777253;
        Mon, 12 Oct 2026 03:09:37 -0700 (PDT)
Received: from debian (ip-78-137-176-146.broadband.digiweb.ie. [78.137.176.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a192d3efb6sm166229885e9.1.2026.10.12.03.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 03:09:36 -0700 (PDT)
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
	Andre Przywara <andre.przywara@arm.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v4 05/11] dt-bindings: rtc: sun6i-a31: add Allwinner B288
Date: Mon, 12 Oct 2026 11:08:10 +0100
Message-ID: <20261012100816.331033-6-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012100816.331033-1-pmazzini@gmail.com>
References: <20261012100816.331033-1-pmazzini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The B288 RTC wires one alarm interrupt, not two.

Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
index f2b91186ed37..ebe35f893f8c 100644
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
@@ -82,6 +83,7 @@ allOf:
           contains:
             enum:
               - allwinner,sun8i-a23-rtc
+              - allwinner,sun8i-b288-rtc
               - allwinner,sun8i-r40-rtc
               - allwinner,sun8i-v3-rtc
 
@@ -162,6 +164,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - allwinner,sun8i-b288-rtc
               - allwinner,sun8i-r40-rtc
               - allwinner,sun50i-h616-rtc
               - allwinner,sun50i-r329-rtc
-- 
2.52.0

