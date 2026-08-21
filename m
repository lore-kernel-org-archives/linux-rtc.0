Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E460494803
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320636; cv=none; b=ZieztYCt38shbdlTMXSUUvp+3yKqGTKUfQhcBFpbf+ILCDgkEdt+xFl1M3YQiHHdHvUF61V9ezRMLBWvfweaelO9keTbaGJGMPD/TFOGEYsSvHVRmjl7J4Gj1EMBU9wC0rwVbAVLiS/HWT/OV+DGxTWVSmo5qb8OZuTr15LeppI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320636; c=relaxed/simple;
	bh=AH6oUfHnmcXsnjm+DxjEoBqd1Vb5FnHglP4xh9aXyJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVrRSZsmscGug311FHrw5jhigoIb0EGJSj7PXgq2nLvNHBSeg7liCbFbyh+tqsN/q1uyQAxdb73XUN4GQDCNiesztj1VT1wdNP+87EoNwHqEzXmVR+a/i9adZt3oAuqBvXFU50C1ponO1WbLQ54HzVw8vEcUotnxQyM961I8teA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZeQPy5o; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZeQPy5o"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so648984a12.2
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 06:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787320635; x=1787925435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4G1vL/8vEDUkF7LKjkQY5Lqad8PP0uoAQCy9KkC2pcc=;
        b=dZeQPy5oWrPmBZoAC7p9feIB7O2ObUy6iBDR+P06GpkVb/USsyALQ/i4rLEhduOSpb
         1V9sEsFOlRVKiub+uNv7KVAW5gCKXDIW7a8L5MFoY8w+d39rOHWVUr8wQOmeH6xDkT1s
         j/1AnnbeBIqzR8nsNJ0pisGbDHmVhGU+9qJKcITbXuawUSO97YPommA//1kL/6JItfnO
         xO5SuRz4wRFgQfqiv6XAnPj4r93ugOe79ZBzkxr1VM3JT29cpmqOUBKde9XzK3buEjfL
         3Yvxks2kdiPLCuHFzxNWAfPBgkR+7FqE5brRUO9R0V83Ba95eYCexdkiVQ3BLraZfOvv
         k8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320635; x=1787925435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4G1vL/8vEDUkF7LKjkQY5Lqad8PP0uoAQCy9KkC2pcc=;
        b=YRAYnqFZvBid87GYgwl+2ISPtz71kd5zDRGu8ObwXyB8mY0b1/BTIsia3dCLdz63tB
         sGthJytU2NOZO6IwhDEFyxLClxQ+sCbnYvHxmMoUoIpb8BR5VYl5Firu9K6jHeUJ+sWZ
         eVamK+0KGuM5scJdqD0w4aQpPLt0iA2wFWoF58IH50LW+K4BURBuoAYfnyUXZkwaWUa4
         aqn9EXyWX8Qla3urrliTNNYhE4rXoASpm+R+GC2AF8R0k70HBHL6En2n9U3r5aX3ZC+q
         A/BbdxixMYEmfMTuWRk5sE+lcdsL0POlWdVy1dZAGr+o9uDaObN5yz/UEaBPWz9+cnro
         LpQw==
X-Gm-Message-State: AOJu0YyHGBktmEmx6FOmAabGKZyJ0UsgjQup1f+s7FxKz0fD0PBtUXbh
	Qrpkom2f6SuDVZGqYtnkyFQ10yGMceDnViIFEdu3EO9QwdPdXeL4D4Lb
X-Gm-Gg: AR+sD12MoD4Bb6aqV/FRptZjV3okB9tBY9dKCfqe5oQ0Eu6nNTlBodMAJ3dJKBikiC7
	Yv2faNmI+o/u3jp6y380W+o5nbyW8gKJWpBxo0jb9+uaTGZJ8zxr1zX0ZWgwFj1mC1JiSRUODbU
	A4cgz65iyNHehUqgDcndKx3GVKdSsLwx/lXwT/GSckW7dU2PcQr3IfGnb19nVZAQMwFaoqN5mCx
	hlyW1ycuYqH6svfRCnQ/MF9kvSjR5bWF8vGkcy+jhPm01M4Kob8bnbU6R83gYGdIwX0W6c0dhXs
	cwiEDubPakWGWIX7yERJo4hutKvhlHLGGzs60JWnXKBfTfYOs/ZEPdNQ1AMRQUQ19SlTq8m2X5y
	uhWtBlToPBiImwbLsOcyh795KbQXUednKAJHhUVqNa/g6OIUYnZVVIcsem/hVqbt2KFuTYZzuL9
	903E3XWfrqgw3jSZtOkRgJ+KfK5ZMp03g+YM+ehSDDoeCkdfTN3slSPeupLtXipwQFq+WDi34B2
	iYkfvZnLOvC4Xmly6FcxaeuZurVxu8M/Hjq9N3rgNfNkOLWCL95t1BiGakbfaQu9Z9G+VZFN42M
	/miwsE2qxg==
X-Received: by 2002:a05:6a21:9d48:b0:3cc:fe21:bf6c with SMTP id adf61e73a8af0-3cd3009d046mr14054819637.11.1787320634827;
        Fri, 21 Aug 2026 06:57:14 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c07:efb3:773c:1c8c:24ea:eff6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327d01ff056sm19972277eec.19.2026.08.21.06.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:57:13 -0700 (PDT)
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
Subject: [PATCH v5 07/17] rtc: rzn1: Fix malformed MODULE_AUTHOR string
Date: Fri, 21 Aug 2026 14:55:58 +0100
Message-ID: <20260821135608.275233-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Fix a malformed MODULE_AUTHOR macro in the rtc-rzn1 driver where a missing
closing angle bracket on the second author entry creates an invalid format.
Correct it to the standard "Name <email>" format.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v4->v5:
- Added Tested-by tag from Wolfram.

v3->v4:
- No changes.

v2->v3:
- No changes.

v1->v2:
- Added Reviewed-by tags.
---
 drivers/rtc/rtc-rzn1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 09631a3a5134..a7f22a491d61 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -524,6 +524,6 @@ static struct platform_driver rzn1_rtc_driver = {
 module_platform_driver(rzn1_rtc_driver);
 
 MODULE_AUTHOR("Michel Pollet <buserror@gmail.com>");
-MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com");
+MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com>");
 MODULE_DESCRIPTION("RZ/N1 RTC driver");
 MODULE_LICENSE("GPL");
-- 
2.43.0

