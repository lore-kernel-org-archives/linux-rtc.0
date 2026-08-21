Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0BC499F05
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320694; cv=none; b=Q4hPZoto63LPh8Fyfb/OHJsdsP070BleBFNHcoMI9t/BhL7Q3hWQRAiVi261VmcWTYrCQvUl5I7M9WRbLJKkwf6mbz7GXbYfVGjETOpLFoAPeyf9+9nZFsVqXTjZYUFk694/qx6i6cWr/6exsKcK3tKZz7cIAUvpJ0IDQK3wX8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320694; c=relaxed/simple;
	bh=04GCmteGIux4olAHeskFAacFufwWGnwkFW1GWc2dsNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxJ3WRd8r+2jkxMkGaMg6jSVaTsT8MNCqsynZ0f64V89cYpH2KhgAQetLS9PwD/7/d/x/d1y+gTygWn06G3qBc89dNdN6xoanC6LheZPqFESPShD1HGoLlSqvlFG1yQIgTXvtzS92zrMlUd4w9eWK/7KiU0hpvfEl201d8OmHCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gk3YzsBB; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gk3YzsBB"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-395cf2535acso556227a91.1
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 06:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787320692; x=1787925492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NwGs2ndQ+fjxjLIqK9oi+yaLvoYinheEb0GyyG+r0eg=;
        b=gk3YzsBBhccMwhwaXya8roFyFS0OtV07f62bDiN6vdNaXwW1vJ7afYyYqHlR5ode1x
         5xdGMT8w7dO1Wl/B8lZYB6x7ro0LLkesFhMLP5rGKB+3VO2EQy96PFk3G7DrCeJ5rkMK
         f/8T4AZ3wOCFoGXIBjl+zrsfRHEmyX9aoEU11yB4b+SLVUsL8XtBx8LbNZYsadJ787ij
         ffwHCodjlbhz/eMsr5ds4ZUoBlTR3ZEQA86IS4a4b8tXDboGfEF8EpX8YULfPDKEuhPa
         2ZpPJxnog6voiJOnozWyMYCKV91EOjvQsH0fk+QljJMXdMpxdwPucEG5uqggs4CVYwaE
         UUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320692; x=1787925492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NwGs2ndQ+fjxjLIqK9oi+yaLvoYinheEb0GyyG+r0eg=;
        b=eZNteslH73P04QJkBxMII8NIgeopkkcnMVNQO9ZR6XTu7Q12eqzUhSYudNKJ/+Jxax
         tKTRMud9SBec6vys3Vhy21rVUYZIA6FyPusPohVXoRfzqZ612NGLMsCllfguAkPdfp+h
         AIHYCDA0GqAPE27OUqXLQChSiOYhPQ1h1fBNKR1+b0HNUCXwVHYU/DOg3hEe6kMgr9uz
         ldg+l6NSJBp5iIO+07HGSAaSqzbPh2rzwX3JyJF8DMuM1QD1hdgb+sB4uUZdF97Cd1h6
         iya8fffj7NHYxJW6WwmvxylPBhYd+zX2UGqQb7HzO72EXk9bM/cts+KBDpgSlZU0wQjY
         Oq1A==
X-Gm-Message-State: AFuF++nfVvpgCwUn7wnDif2sOouXKsLkx4cJ/XN6bu5kizZB/NdCAkmc
	BC9kvVwZYkptdXAgfo2D3F3YZTpCu5pHdnTAhUD7ouZ8ZaoeXJiR6d5qHGlkwg==
X-Gm-Gg: AR+sD11YfZ9s/bBNp9X9nryNketDinKZ/q5lldvPsh8uT3bFswwUBsGoKVuEO3FUjdB
	5qJD3ZuxGgNsejluKRjDkVPTDYwrEiY1rLWZshRVdcySs+ffpG2DtvZP0Uj7dsQuXC6CuZqhj66
	0cwjGQPpED5yIHPp4dkvHUfG+2mbp9eSxceKMPi35BPzZq4wx7eP4KUPp1PyPEEL5AMkAROmyyd
	Zhzt0gBih7xBPJmU1YiHs8hKYyiD/q9utOZQ1/9i7WYOUiHlEjce6MQv73r+3aywSEJuBNfAX14
	clPE8H7w7olP/dUCBUbAU7DKXqrdA7MG/nVc0djv4jG3G+ufvNPoa0W6zjnysNetGQ0PAfIdzTV
	ZEiayrq4zcWzhkFIMbKsaDmwv95+79Ajbs+FnxAphvYY62CACI1IT3RPiBAAf8qyz9ZF8A/Lalg
	sK3IZ3Ntup2c5QOGQ3n2TlPm25hUS6lxAr7JkNugDDCYHfimx+oE4rDrjjjSPUOZxo2pP+YWuDl
	YhGoY6mz05BoaOxw5i1q7QZwp5aa2Ae5HSXIoo64QHH3vBrfWZOn1N3CsRDNXs50ta78sqngYo8
	SPCYxw+uMA==
X-Received: by 2002:a17:90b:2d0b:b0:38e:9784:dd47 with SMTP id 98e67ed59e1d1-395a044f2c1mr18208312a91.1.1787320692568;
        Fri, 21 Aug 2026 06:58:12 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c07:efb3:773c:1c8c:24ea:eff6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327d01ff056sm19972277eec.19.2026.08.21.06.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:58:12 -0700 (PDT)
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
Subject: [PATCH v5 16/17] rtc: rzn1: Drop trailing comma from OF match table sentinel
Date: Fri, 21 Aug 2026 14:56:07 +0100
Message-ID: <20260821135608.275233-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Drop the trailing comma from the final empty entry in the RZN1 RTC OF
match table and mark it explicitly as the sentinel.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v4->v5:
- Added Reviewed-by and Tested-by tag from Wolfram.

v3->v4:
- New patch
---
 drivers/rtc/rtc-rzn1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 35770bff129f..75713e7b045b 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -528,7 +528,7 @@ static const struct rzn1_rtc_data rzn1_rtc_rzn1_data = {
 
 static const struct of_device_id rzn1_rtc_of_match[] = {
 	{ .compatible	= "renesas,rzn1-rtc", .data = &rzn1_rtc_rzn1_data },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(of, rzn1_rtc_of_match);
 
-- 
2.43.0

