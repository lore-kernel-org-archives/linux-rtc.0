Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A195F44E040
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136086; cv=none; b=Rf2JwP+FtlGWw88TkBGay5RGUF9UrTZQuLz04c6Yjq6XlcRGlePYFb/JenNMidicJIpmUITUCd/7EINAvjdsxSvFoEz2Z8HVrqV/NHTweGMaXzr8i9Emz9zbYLmXluxI7CF663gyt+I1haoXPF1QUCeO3rI69on8v6N46C16Mhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136086; c=relaxed/simple;
	bh=uQI3XAHDTn8+KY5L4ouP+6SB6FMgV+T6fRXQElDCkUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxpxVUjX+4E0ZaZNH23BvsF5Dj69Z7n8eU/iSwSrOsL2EQ+F+2aXgpFvfoPlTax4MxbhRPZMwnutYTPXd+cbuKC+Js0XbT7RyXhumbHwPRBESDvXFznFIESmxZ2ZVG3Pdg9YEgi6qXpffyNL1975S6iDZ0OirlMZs7OvyJZo0mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4h/52IU; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4h/52IU"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so1179017a91.3
        for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 03:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787136084; x=1787740884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G8E97ZQvAGrXyZ8ICqBm9FXVCnTnFkg/F1lMXTTvhqA=;
        b=E4h/52IUWYsnudlN910qJUAk9yRyhIbW+pVWWMofeo1NQLql2pnBd56JCdx7T77Rvh
         aIirMS/JcdCsIyh66X9VyCx44UeHug6s+74G/msz6MG4v9mDRqGXhdEXc/NSOmoyV4MR
         5oypUsBIkH4404pD/WPSjoGo99Ishc2QNm4gL1Rd/+YYdBlwJNl5aZ0PP1u2MnLSktG9
         AHGaRrakWwXUnUqgoMIgYoYIfGhz5OzOTBKf/2GIpuYlL4POA+hRxgrrxfPD33fo2wpJ
         33e8CnkW7QKTgISUQrn2y9TRmwVPx6ARqL5FYbfLkSP3GI/EwtJVT+90EBcpf75dmR+g
         2K+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787136084; x=1787740884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G8E97ZQvAGrXyZ8ICqBm9FXVCnTnFkg/F1lMXTTvhqA=;
        b=ZiCbIWqO1pznEmoX0YsRwkk85o9VY5gfOvA8wfKN84MwE9+tlLmOguGEWw2qv67m2a
         HDwCdCVOj4D4AWRCMOEGOmLq+KgK6+SDaWoC2JAFA0Qu7aPE4pf0xZnab4vgbaup6i0Z
         F4qYrS83rdSyqznDGcyiLOYHMmi/6F02xCylgV68BFWE9bfSAnEN/RWiuRLpPrKPkbI3
         hg9xpDo4ipCo8OgD8FEZYQAmpa9Z86jgz7imyI5AnkU37c6KfNVOlcJI9u8URDrt3RYA
         AvOxPjeBDnYUMY8TQRr6beh/COVj0TRjG1glgBZaq8Up/uX48VE08Myibg2mw8hwX2bm
         H+cA==
X-Gm-Message-State: AFuF++lrYyGzEqiKs0TVdrAD6a9HLL84BOfzRLQELIt0Y94xTYFw9mNQ
	8ECAO+RmYRq0j+WUtDn1CVoADy2mZM3cBaWgUwtL5cOk1w2ubfd775HS
X-Gm-Gg: AR+sD12pSVMa9iEbslbw/i71YFsF3EnHpwuXdRT9ODjHspk+x+bhppftTDGEGSwe5U6
	9xYFg6KwitbwAnlmIiy+OOZro+/31aZLLGjhhXthI5+Fu/lA8C0WW4qlh6XZ6QMOj2Tt9rHJxfk
	J+o+uZ56X9WYDOHGn/UTaezGaePXR/N3KEQpp6Cdlitg18zJOoPZhV2Tjr09kG8hxyqxDX/4emP
	lIueWG6Apsv1D5+8M3Eu+QNlgIii9+HjeP/qF07FjmhK5Xtc7n89jPIp9WnGH+HWKACNcxOFiEz
	R/6ORYOSmUqyyYWiRNBZRjgAl4zGodTgDkHK4NxhqszFlG0agVY0yUniuGPVPETqmYL4a9p4bO4
	MW9fkTjDjWpcVPvVJQTGNpK144oKDSkHRiOak6QPPWw7axzHabADiud9GWgPfTWyqyoT76VIn7L
	m/sKGw5r94/tegaF6q/E+PtOFtJTMfEMTzwWvCo7Qbpvl5JRebK6QYFYBK52n/jc75jix08BXFr
	ivm5mBjZIux8Wzx3M7WvfjyQ0K0N10rJCCeiCcidm9Cd6GzKJ895w4Jx4qV5cNxMWhXjbwCXTXh
	iWhC9mFSIto=
X-Received: by 2002:a17:90b:5250:b0:381:9028:5945 with SMTP id 98e67ed59e1d1-3958125375amr7486669a91.14.1787136083791;
        Wed, 19 Aug 2026 03:41:23 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c07:efb3:a897:a9b5:e171:c935])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef77fc0sm11169630eec.8.2026.08.19.03.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:41:23 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 15/15] rtc: rzn1: Add support for Renesas RZ/T2H and RZ/N2H SoCs
Date: Wed, 19 Aug 2026 11:39:26 +0100
Message-ID: <20260819103926.2136712-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
---
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
index 6097563c5f13..32f6464fe7d2 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -508,11 +508,16 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	return devm_rtc_register_device(rtc->rtcdev);
 }
 
+static const struct rzn1_rtc_data rzt2h_data = {
+	.has_subu = false,
+};
+
 static const struct rzn1_rtc_data rzn1_data = {
 	.has_subu = true,
 };
 
 static const struct of_device_id rzn1_rtc_of_match[] = {
+	{ .compatible	= "renesas,r9a09g077-rtc", .data = &rzt2h_data },
 	{ .compatible	= "renesas,rzn1-rtc", .data = &rzn1_data },
 	{ /* sentinel */ }
 };
-- 
2.43.0

