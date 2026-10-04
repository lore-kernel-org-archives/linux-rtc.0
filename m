Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365FB2F39B5
	for <linux-rtc@vger.kernel.org>; Sun,  4 Oct 2026 22:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791151382; cv=none; b=GG7MLO7/gR0e8i8JScXBMoBGXWpP8lmkztcOrG93qhXAi8uOZRNzgDKMBwXlPc1iYPvWKCwoxffpOPolgwShYYhfpIJLoXPfSOtgbc3BJtYg9SOYsAFOyYH4UeqVbxHd8E1UoBNgQMCQwTeEme2OyWyawk5JhnIPIfkGHgiriwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791151382; c=relaxed/simple;
	bh=qYoK+C9hoi1jUXZkwPKcbBZfQYJ0dAYzFXRqVN9Cz4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IVcwqmPXZ8N8ELCEv7XhM2dLnw4Z5YbfMcN/xB/brk9WBkJ2VQzUfUK5XzSdYj7O3gLBg9UTbFI/HIYih6zAALxF0I35n3WTlX6aQ4XZAxfdTlw82OxVXJAmXvz3AYQV0GmD9H00K0XUSF6xzKaaLmy8/IFkveGsjEaC+9LfnwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/Oqb7BJ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/Oqb7BJ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3a49623b865so559596a91.0
        for <linux-rtc@vger.kernel.org>; Sun, 04 Oct 2026 15:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791151380; x=1791756180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zA7/PnrzVV0kuFjVDODfJEpzsfgOMGEo0xCOYFUWh38=;
        b=A/Oqb7BJ9bt6Fbd3YPtJssMe09Hki62Ltw68MXqQX3fUe2yKnE7CwdfwyrnxuJMupj
         LxdMp+MWxVAEKWeJkOiOdvU2E5Pt6mKiBT1qlCpNtoInENni1LYjwKsz5Ocyxlduw6LY
         AkRq4W5m28qdFYbnhhQrfqH6lgxfkQaj29HrQS/ue0nd4/hBALr0Rw0vzXC2AbrbwimT
         j2CnIY1eawVFwlGjGJGMTPl2WkyhpkieM+QEYAuwDJHMIyLRdpTKi74oB0IO34vMh6D3
         TaKhUF6L49y2U8Ts7N/ng0w9oSSVLW4yzxFYmzAp2iXDrKSbliwfGCmojbIkjxwKtP2u
         wiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791151380; x=1791756180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zA7/PnrzVV0kuFjVDODfJEpzsfgOMGEo0xCOYFUWh38=;
        b=O9MjrfjEgqxSoTDX3CwS+Km/3Itvx3oV3KaqCRD7FHp0UYkwF3EMJayZCSdfdF8NTa
         6NSXDmQH+yns7WA+3X9A1dkWC2kGo0DodUPGN6lal2sHrOdRM/YSPQHec/had0/LwF/T
         8tGKqcvQSUlbNsLlu1QzuEztiGzNT40EeB+ZBygoq60/CgCsvD//NnALxm+QUb1gSjZh
         dkeaeJL8vCA+0hJCWDgWMlTw5++Jl4OpvjjysnyDBQ/oURI87nt8bv5YHONvCowZEol5
         Sd1XS70UCheirokuUGMSdcy1npw6o+r2eGcAwHBXUNR37wZeDYsdFWxMRmmT2OISnEKC
         xInA==
X-Gm-Message-State: AFq9FYIWXBIbO4g0cQNBkXA424oa/x+KkeNXJEiQZtG6nROFjPxbEP+z
	fniNll0Vj409qqJpBhLZgumlZdJqCjrGksTmRPdLoLGKOHwmoSHD6xyLBLAr+S9R
X-Gm-Gg: AYBFou2xnG0kdvrRzwEqSN9YEUuVw6MEJk2J5J+eziGzZ9rRxcM5kV5nifjMiEGbnM8
	nwPqMn5HtQzcRhaQSlE1DsRSyQdSgtJvtaoGmW9tcogk3V86NuBxXDIEzZDqNa/zpOgfDvkTh0O
	8Mv+VwlyeK5APTDA/ozXvVfzx8ZxAgHm6q4Tm0HKw1Drl4Nzo6CPNpD3kVYupVHdprHBBXC2okw
	PJWodz/zFBJQjCdUhQm4cA4XTjQTgD9q6TkzybGAujx+iPqrAj59sVMjH3KKWoNRsqYDNchWTJv
	SWGnKEPCOdFSklPqNukFnwWnzjAGxWvgjT4PRwDhqb8pqnbEkr8VaWm97R8bP17z5MFKTLTVAaz
	Ol7ZeXZCjMB4cPma1fmRJxVv3nIyRJDN9fRIKVT+4WBZBbZQhFOtxsb6F8qSm8CfRyWRGxIDNS3
	YCsz1QNfN34YP0LWpk2qKY0Q8fIuzTHudKOllZtihlFh3sVySVLX+IozTH2HK2vwr6VfNYp/NHu
	7SNroV3R2+SwjdPNBzJfUEZhiIu2sJ7UGwAJWVpRx9HWrwC099FkObB9rSMKhJg5HzddfnhICtB
	AtUlMCs7gmDVeP6zwkx8GuP8MeHJ8Ob4Go+eHIOlRPaix/2F
X-Received: by 2002:a17:90b:4ecd:b0:3a2:b4bb:91d0 with SMTP id 98e67ed59e1d1-3a7873da1b1mr4484990a91.36.1791151380450;
        Sun, 04 Oct 2026 15:03:00 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6dce36d07sm5771328a91.1.2026.10.04.15.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 15:02:59 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rtc@vger.kernel.org
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Linus Walleij <linusw@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] rtc: ftrtc010: use devm_platform_ioremap_resource()
Date: Sun,  4 Oct 2026 15:02:58 -0700
Message-ID: <20261004220258.401706-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open-coded platform_get_resource() plus devm_ioremap()
sequence with devm_platform_ioremap_resource(), and propagate its
ERR_PTR() directly.

This also reserves the MMIO region. The only user, gemini.dtsi,
describes a single 0x100 window at 0x45000000 that no other node
overlaps, so this introduces no conflict.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/rtc/rtc-ftrtc010.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
index b29c96be40f4..3e88cb224f67 100644
--- a/drivers/rtc/rtc-ftrtc010.c
+++ b/drivers/rtc/rtc-ftrtc010.c
@@ -111,7 +111,6 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
 	u32 days, hour, min, sec;
 	struct ftrtc010_rtc *rtc;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct rtc_device *rtc_dev;
 	int ret;
 
@@ -135,14 +134,9 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
 	if (rtc->rtc_irq < 0)
 		return rtc->rtc_irq;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	rtc->rtc_base = devm_ioremap(dev, res->start,
-				     resource_size(res));
-	if (!rtc->rtc_base)
-		return -ENOMEM;
+	rtc->rtc_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rtc->rtc_base))
+		return PTR_ERR(rtc->rtc_base);
 
 	rtc_dev = devm_rtc_allocate_device(dev);
 	if (IS_ERR(rtc_dev))
-- 
2.56.0

