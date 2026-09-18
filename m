Received: from mail-pj2-f15.google.com (mail-pj2-f15.google.com [74.125.227.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4305F50B415
	for <linux-rtc@vger.kernel.org>; Fri, 18 Sep 2026 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789747012; cv=none; b=ua5EKrXc4IXmhb+qCFUYv6HMwWQixUw3C1oobsYoOx2Kfsi++EUQrHnTsMbb8JdNtpnlfPjyvYojIaujU3uWzJ2LWKidyo1RQ/88U67ofQR88E3X1iWyMDnvrkd6nkGnr8VXtRQCF+wnoNZGQVp7ywELg0VLL4Qvom0fEK07m1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789747012; c=relaxed/simple;
	bh=+fInZteJbxGusjrw1W0RE5Ukceo4TOjF0P5/Ej7DSUw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hfSAE/AmDh0GhfGGh6AZwPQ6ReEr9XPdF8XgddN98hCKidLrRVjfpi+n3YDJz2LjQP7ZWFJdM84b60ex1drgRD6JkLF1Ew0B2lhqTexd38MEg8o6sJpiolJl51w6DMdKtbO3tsa6MBfGqytylcbtt2wz4Wug6Kn+jopnL9OpW7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwIISE8e; arc=none smtp.client-ip=74.125.227.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwIISE8e"
Received: by mail-pj2-f15.google.com with SMTP id d9443c01a7336-2d747f01363so8076905ad.2
        for <linux-rtc@vger.kernel.org>; Fri, 18 Sep 2026 08:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789747010; x=1790351810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KcbJsmqKUVlgmMgW8drjDCDfJeq+Ke5tmTlLzlkgAFE=;
        b=lwIISE8eDQvBi+hlknfGdUHelBsoFp/gsqyD4qUVzlAc5ldpjztp4r5H8cB29qoYzf
         NaJm1LjCs/j1QysBuB+6qWNqkADdD1M9MuCotAkm6kS5+zbJesAjVLKiwO/UpoHBF/0S
         QHIvyFJDt53TB2YV18uRz7L1XN/By6GqEWDrA79eFC2A63p9KC17KhAvA9dWlvoI5Os+
         wE71Gy9r6+nt0fH1eUWPRpVxP5fwHYSc+6moNdvGuMraqx4MUx5SoX5984EWSOYW6rLK
         ilRXhFhFcTPrCxrgo7tVBzuCmWv+fGNaEIqUj5FJH4JzorDVPftTF+IzSLEfX2XwzQxO
         Q2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789747010; x=1790351810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KcbJsmqKUVlgmMgW8drjDCDfJeq+Ke5tmTlLzlkgAFE=;
        b=1hRyNv2RXWB7FjJbhOeBHNRWXg0lWG6ytKxVSxeV2NWTWVa1Y2E0yGdbiKNmNe3crD
         DVzW94M4S+25RPnDeSmv/tl3Q4fFeJueavr+HyoJ7vQpaBDZ52E0c9wSSqT1zSGqiXQ0
         gunwuntBn0BCb3K3K3g9GG6TZL6wSsKIjo7UZsRDREE3Ox1FyC1MmgmSWRfChOyKTGDe
         XhguWnTgEOVohpYCTJFBOVyH4qlEClyT5jQfRZUM8HEcpA1vKtRNal9uKXppMWFjezxA
         To9jysQLLmWTSILjevANsy3mNFzUgsRTcUC2HHYotfVdaL0UvXiz+3fnY+QiUoijDH7n
         PnmQ==
X-Forwarded-Encrypted: i=1; AKwUvBy7iDagR/mPa3gw98O0tdNGAfP4d85WlOq1xz7OzKysQGtpCHEhs28RM233EPhVePp+3aP6+cGrEs4=@vger.kernel.org
X-Gm-Message-State: AFuF++myrqm1ZypfjtZJLmUVoTHnVov7Ya/NW6Qg2e27N0X3Z22ine5e
	JPzkLZVgspWeBOXRteAVaohFoLWdqeG+ZDFickzw58WvRwNIIQNZWrfg
X-Gm-Gg: AYBFou1+x1SSD+X152O2KsxJS0K1jGZE+JvwVM0lVytGQ86u00ou2GJtUGV8sOqpdeB
	dO/DjGDckPDuOs2zb9eVTATGrmAqmhOzTX8SSdwLe+b96mOZyU+baU5CVBJU11LXQ2X2jjliStS
	GKo8IJaaB20pfRncZ3BAW9sVovLXvdUEyt+vMtFus5hpoukesS4y65GxNtkIzby7d3qKOpAwYId
	OUvQhwqsKnGYFbVcpOS9KVZp+alhDRkm1BnAxP+2SB4wQHDsgRAcO9uo8rtC7STiJ9E5M9nERDN
	owccIz9QMFSYtmCifIYa3WqgAKX6PgrREbxdq2yTzgGAWktegORL96LpBshGS2DWXaMdOlR9I/b
	MH4e44O2XIjjj6nDaY/LrXYqsD0G8C6PUT6CQteZMmIXWFkKaUS5enZI/EXq4aNc9gE5Ojnd9nT
	yF5FcJL+81AV08l6Bm5A/Yk5Y0x6EO6oNCYB5ix3w9EM4xHjc1BMI9rCzR9FSaTz6RZohFKuf3S
	jEt0KDJ3kDQKER0fQ==
X-Received: by 2002:a17:903:1844:b0:2dd:c100:942f with SMTP id d9443c01a7336-2ddc1009bf7mr1190205ad.45.1789747010314;
        Fri, 18 Sep 2026 08:56:50 -0700 (PDT)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddb7525be8sm10938445ad.24.2026.09.18.08.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:56:49 -0700 (PDT)
From: Cong Nguyen <congnt264@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-rtc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: mxc_v2: fix clock-unprepare race with the still-live alarm IRQ
Date: Fri, 18 Sep 2026 22:56:42 +0700
Message-Id: <20260918155642.2557978-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

remove() unprepares the clock, but the alarm IRQ is devm-managed and
only actually freed after remove() returns -- so it's still live while
the clock is unprepared. If it fires in that window,
mxc_rtc_interrupt() calls clk_enable() on an unprepared clock.

Free the IRQ explicitly in remove(), before touching the clock, so it
can't fire during or after the unprepare.

Fixes: 55d5a86618d3 ("rtc: mxc_v2: Add missing clk_disable_unprepare()")
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260914134826.EC26D1F000FF@smtp.kernel.org
Assisted-by: LLM
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 drivers/rtc/rtc-mxc_v2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-mxc_v2.c b/drivers/rtc/rtc-mxc_v2.c
index a07acbbcfaeb..3c174f6004c5 100644
--- a/drivers/rtc/rtc-mxc_v2.c
+++ b/drivers/rtc/rtc-mxc_v2.c
@@ -365,6 +365,7 @@ static void mxc_rtc_remove(struct platform_device *pdev)
 {
 	struct mxc_rtc_data *pdata = platform_get_drvdata(pdev);
 
+	devm_free_irq(&pdev->dev, pdata->irq, &pdev->dev);
 	clk_disable_unprepare(pdata->clk);
 }
 
-- 
2.25.1

