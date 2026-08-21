Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A5B418A28
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 21:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787346765; cv=none; b=CvvO5KYZFxwJIvGEZ3mKpoFoGAguE5SLfEFcaKEzF6BJrfnUCOALMvCqBnzO56HLdA0jBnYjomT9KXevxNp4QkA8YbxfK5N5c8sNQ8mQ9Eh4dRzNCrvhocD29qRCO9/PfzqFkcNhBoUaigi0WvsQ/ON4Yi98B1/TLYlthSBuPjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787346765; c=relaxed/simple;
	bh=A+v7mWu+wCAlwX2apMuc3TGMtMv4ggi9HrGbcDSLrQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzzRmXo+QCfo5oZqCdvr2Qz4r/gWfgC/i1QNk2PT1Tj0iGXqHFcpPoSZTaugtoqtDF4X6GuggzCTNHbB7HrXGXxM4VhPoMpK5DikQfNDoa1PhInJUXkJtYfWLUSIStAFdCZliIvooQ/Yro6wwp6VtpzEMEhH5QMdHVUJteDYe8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+bsGhnt; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+bsGhnt"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so1552430a91.0
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 14:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787346763; x=1787951563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4l8YNQk41/fppyfIDksrLwHHQ57AKnk38Us5hixv6DA=;
        b=G+bsGhnt7HVIcww9MuoR89rkzMxJbcgAtccPBw601hymCbaRQRh/KN5v+f9fGDvSjZ
         FTgLuxIC8kWJdS5wyRHtCO+NY9oCNgoN8IOzEGKmokLT0dR6yjx6CcsfrqB0i6ze60DS
         fcPxos/90zpHWD9VGW67r9tOZdYNHv59GOt6dDpm+2Y2QZeX7jc3DKrHcim3C0TJIMxO
         Mlm4YUFgD6BLGeWXRCR9LCcZMomHRjOQfU4Tw2Dy47XUp+owI0P3ckmUlZVWjSGKxjZo
         OYDrKasf9df7Rp8Hcgqm8G91YjoERtzyRupa+L8T3oahFcpoigsXYdD/LvkIeJLpeGmx
         kiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787346763; x=1787951563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4l8YNQk41/fppyfIDksrLwHHQ57AKnk38Us5hixv6DA=;
        b=b6qtYSZ0JDccvi44Bmd9LuEc3tMd3VMoKAIyNM+KwaF89OdLbtd25fE9PGboUHW+ub
         n7PKAlZPdpXVj1fRbiKDveDyMwBEmb7eZ0OIgonGqWot6duuyPPWraIcwMK5og7+SF0u
         L8KisGLt4Drv83dfajpcNx9Z2XJ/lv0tsf+BqYO5Yly+OoTIUoOkfquQrC1jRf3w7mEq
         vyrfJFAMNWyNcmK6xzq+ckj+ZXG3IU9tyhLyIxFDSrnDkm3hvXGFRR/GVROflYqsIusn
         mQ4S9BE3WoFULpBAdr8yIYn2GOCwx7mevbRZmyPMhLgBdBg9Gxk3tV2d4GAIpZom347u
         er/g==
X-Gm-Message-State: AFuF++lQi3eB7A1KvMEbX21QYlTdGJU3T1fI4eTeUhFwKt/zpdA4Fxay
	EqHj7+iM4IXW/hMhaafKEs0ASFkg2DV0Yeo5aGWmWNwXwGIsFsglm6oi
X-Gm-Gg: AR+sD10xCIcrJ2OpJLAZaUAExsueLyutegnuXhba8+VO/B/BjLXQFhTQRho33OZRZs0
	TBlvdo5IncngS1oOKDy0dEDpsUGTFbsSeQAkhIGMatSHQMXEiOBcIbyOTiWl3wzjgvcNqo4mNu6
	/tYLDMMjN1VQwbQt9hmz47aYU5fOVoGdEqi6I6NkKLgxIUjO7E2zxIbtxXDbBmYJX5iUan8ILPh
	+pS0rMySdB3gwMONw+MI61XTc6mWNwYT9fLacerB9LxUg7wukwLyqdZkDQPSvbp1xaIaraQvBTr
	8ru9ax4JKNesZMyQVETwRDqR/mFrUaXceH5SoCB1OoOQ1vNthRkIQ6FKumcRlqXBR/e++B7VFsR
	1nflpZuzzOr3cz17r2dX4Ob12zWDysROSX0E8Sktu1odjmcI5bbT4TRzJ2bUaERvKpf1uxenZJx
	vQOVc1AWcNvw1qMFC8sRI+S+4qZqa6L4MIozOQd3tF6TGdk+JGB3URYwIYVUw6NDtRFOQ4zNfSZ
	GwI359h/9CKQ0VM7kdb2mEpVBUdt3hdGPwES49vWW4FF2rg47rhVSz9IlQ5ZqNiAOawzpXl
X-Received: by 2002:a17:90b:3dc5:b0:37f:be6c:f3f2 with SMTP id 98e67ed59e1d1-395dee7e2dfmr2594815a91.2.1787346763290;
        Fri, 21 Aug 2026 14:12:43 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:194c:dba4:ea1e:d7d1:affe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf175399sm49755257eec.26.2026.08.21.14.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 14:12:42 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v6 17/17] rtc: rzn1: Add support for Renesas RZ/T2H and RZ/N2H SoCs
Date: Fri, 21 Aug 2026 22:10:32 +0100
Message-ID: <20260821211032.13554-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add support for the RTC block found on the Renesas RZ/T2H (R9A09G077)
and RZ/N2H (R9A09G087) SoCs.

These SoCs integrate a closely related variant of the RZ/N1 RTC IP, but
do not implement the RTCA0SUBU register. Use variant-specific match data
to disable SUBU support for these SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v5->v6:
- No change

v4->v5:
- Renamed rzt2h_data to rzn1_rtc_rzt2h_data
- Added Reviewed-by and Tested-by tag from Wolfram.

v3->v4:
- Dropped RB tag from Wolfram.
- Added OF rzt2h_data
- Updated commit message.

v2->v3:
- No changes.

v1->v2:
- Updated commit message to drop reference about RTCA0TCR register.
- Added Reviewed-by tag.
---
 drivers/rtc/rtc-rzn1.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 906d03c65df3..1e1676a7f3cc 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -523,11 +523,16 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	return devm_rtc_register_device(rtc->rtcdev);
 }
 
+static const struct rzn1_rtc_data rzn1_rtc_rzt2h_data = {
+	.has_subu = false,
+};
+
 static const struct rzn1_rtc_data rzn1_rtc_rzn1_data = {
 	.has_subu = true,
 };
 
 static const struct of_device_id rzn1_rtc_of_match[] = {
+	{ .compatible	= "renesas,r9a09g077-rtc", .data = &rzn1_rtc_rzt2h_data },
 	{ .compatible	= "renesas,rzn1-rtc", .data = &rzn1_rtc_rzn1_data },
 	{ /* sentinel */ }
 };
-- 
2.43.0

