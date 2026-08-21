Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F82243CECB
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320651; cv=none; b=CiHtcZbOYmGJHzGRkbPI6arbEQHnk7BMhFz+PMlz+W2/xQMsPYbdEjijLZjkfZ8mEZtFhBUABa4dYNQywciQnNI93kjjJJUcDiFprfNdXZmINTKDTAM3k3OXI5C0oloqLjhGKnHInwxpho/No1tVKZQnjI+y6P2YhcCrEAPA8Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320651; c=relaxed/simple;
	bh=gBBs6/Ia6sSV95Cqo1e4c2MfPAgzo8DPkk69LA9oeJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQOo7MpYRRos6xo2zOdPUeu8TIu1X2W34YX07wmz8caJS3lwlTXrSXQisMY/205u/OOK9k9oCV+2rBBf1OFGl387k0ENEPjMsmBC00FnAiJhFQCd8x+QVHDwoU5YJ8GHkgT2GgXqmNuvYq2y43BiB+avwlTTXy+PRNzoJGeUbrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0DBEXGs; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0DBEXGs"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1272446a91.2
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 06:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787320648; x=1787925448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2YJ6zhi/Ow6W3tSjF84cEQa+6scy6/f5V+3PwsGj9A4=;
        b=k0DBEXGsNvnzXh4ighT4wkhQELGDx5KC/Z4omO7zYMxWP4ssSt4ZatUjqpS08Lol57
         O/kd5mUm9iAmpBQvhL863tqvahR2xEVsJMvKOtguGe70pFLob7vuhbpgIZrPEqR0dbwr
         5CsDBljk9VnAiorMrK98DA4anaDD5kRHskHiqj3W6NJ1hOYOtSs6e3lUZrGdLoI23KJw
         VLu3bQmBMulNLLmdIF471xa4t+MBeImCY9UlE2+kp3EK8uLamDZ0vOhsCpXbxWnNtycu
         2dMPcA0imK64YIReNHi0fhm98757ogczBq6QQqpdrqaMtqLp+UqZAsWbvsefQIUIZGYn
         A/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320648; x=1787925448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2YJ6zhi/Ow6W3tSjF84cEQa+6scy6/f5V+3PwsGj9A4=;
        b=msDgfUE9cbXShaTMrWbm8l3yNVv2Evg8BDMn/iA0WMM2FZ+B/xGp0n3cvAUoOT4Fcj
         D5u2Elkg5HurVDM/BHEHYcxQOfSAb+96zBa6q/brqTsH+B6HbpPDfMR1ZCsdUnCiog7a
         ZrUPW4FhdVgpv9nhjccQdu6B1lHCSCkU/Bd3RjU90GpUcBgo7Al1wwrR4oTMupt0lwgq
         2h8H2I45ppHWqKi6/kxP5/JfPoHUAcMeIVRNe//jCagqahArE5tJmKawlKWf0BHU2laB
         pqTPFhy/InptDB42mkM7uQ+t02mvH4hcAd46Jw9itFlVmRwV2yOq08Y+Y5bOLVx6NqB5
         6xFQ==
X-Gm-Message-State: AFuF++lVhlMFg6yKjCFd7GTbqBReDb+/EqHfGZKWADob/ZjoLQioKT9Z
	flEAr5IGX+/vBHGGJlJ7jh9K5BQ33NkZzzC2B5L8KGqL7tEC4GqFmr5r
X-Gm-Gg: AR+sD11yESnOwFzRnFr8o1SJdBe6KgveBEa6sTCqNe5xj+xeEwKyP9ViDqC3CUtFBDW
	JBFp038KkWZOmW78g/M7zovVHPXEhDbtjkulLe3wDRVhh7rwi+e2w0DibGNDUzq6LrURTZHW61l
	o7w1rsW2jcLcu08K1Nqaar6Q4HQTLPpJOIzH/M0a5NDwtGScbvqLrMXxPIrQllxD8tquwW18ohR
	XH/fwXTL6QGkhrrzmK6l12y7/B+lgUsb/Y2hiQC/rkmHt1qpnxIzkVgSEpkOyk0yZCtgMpH0SQA
	grEhzYscV7c4jFTy1ndxeFvGz46SzDT82k4xlYJ/DKbVVBnVL0LbWaxaMXLZ+IXY2VrF17/teWe
	eW6QRTxeSHYubbmeVjNkjRVaUwFtVIvLuSvO58UIdLq/3lFIiY+JH9hlcbTB5kA/ietTdwxRwVA
	DvvXq8YidBGLTQCjHM1+8p9oP0L5Ifp/LH6p7bhvDAFeePkNFVcAkexblJZdJtcZESwy37Jv7Xc
	Qzfbzs0CLtOam6iL3TAcZw7GInlFhUpbwP02viDa5j3LuxqTHaNi3E1TXJKXL4zmUNimZ9J1BYB
	DkZKxvuSPA==
X-Received: by 2002:a17:90b:2687:b0:38f:26c7:165e with SMTP id 98e67ed59e1d1-395c383cae0mr13124474a91.9.1787320647529;
        Fri, 21 Aug 2026 06:57:27 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c07:efb3:773c:1c8c:24ea:eff6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327d01ff056sm19972277eec.19.2026.08.21.06.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:57:27 -0700 (PDT)
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
Subject: [PATCH v5 09/17] rtc: rzn1: Use pm_runtime_put_sync()
Date: Fri, 21 Aug 2026 14:56:00 +0100
Message-ID: <20260821135608.275233-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

pm_runtime_put() may trigger the idle check after pm_runtime_disable()
is run as part of devm_pm_runtime_enable()'s cleanup action, leaving
runtime PM active.

Use pm_runtime_put_sync() to ensure the idle check runs synchronously.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v4->v5:
- Updated commit message
- Moved the patch prior to the patch that replaces the .remove() callback
  with devm_add_action_or_reset() 

v3->v4:
- New patch
---
 drivers/rtc/rtc-rzn1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index a7f22a491d61..6a434cb418cd 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -492,7 +492,7 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	return 0;
 
 dis_runtime_pm:
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 
 	return ret;
 }
@@ -504,7 +504,7 @@ static void rzn1_rtc_remove(struct platform_device *pdev)
 	/* Disable all interrupts */
 	writel(0, rtc->base + RZN1_RTC_CTL1);
 
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 }
 
 static const struct of_device_id rzn1_rtc_of_match[] = {
-- 
2.43.0

