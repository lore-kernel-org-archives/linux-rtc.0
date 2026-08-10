Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951C139A05C
	for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 05:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338919; cv=none; b=MQTHU37/AlwercXpzq3WvTlTJFVJQE7nEjj3Wx+6o6B7lpaFc+Q5Df8PkISk7yPapUkPJGlx8caTPdPFW4akkAfzkSMgU0QvpWgSQgkYCrikVEYIh00rXRpH+a3P2N3dgVkp6V1fn2YFvIWrp4HvdGtKMucxcWodSJl/1xlHLe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338919; c=relaxed/simple;
	bh=zav2p/QVOlzjJl8PWalEICH7C0E9wyu1bnc1VlxxYa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPscqQbsOgzmsMdbWzsaD/F6x3gO4I3AKbUFvM6OQviHb49OdF4uCGHlFKneY2AJ47jLii9+eQ1wwIIjqLrpSEnY6/ScftXXXsNFTXodP9IP8UtXdWWl03syBY+gLsr0BJhtzTLKro4bdNReSqsRPd2Kw3kf2OZzMyVeKzZkffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1JA1els; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1JA1els"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso2770444a12.1
        for <linux-rtc@vger.kernel.org>; Sun, 09 Aug 2026 22:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786338918; x=1786943718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0YZwlgtilaKnaw3bFD0t+VHhRkaxeSpx4Q+6Q/sn9GI=;
        b=e1JA1elsg9sJppJU53GOlXqpxk78WuXbMh8TVRVbSU7nHPrONTCPZUJ5JUvY84hsCO
         I1Ut0e+sxfUTePe+zMX9Z0w610EJZ+x9M+TMzothhkkfyNXWuEMpwjC39S4eRTRLpiMh
         1wwAxTmoghH7DpQ8LML4vz7CAwT66DQItj5C5MLTGWVWWWkXtq01nQyMLCXqfZftKsvN
         +yfAbzI8EcDwLLuBdL4w1NaFUnCeB1wdFNUmBe5UqHqGYctAhtu6SNBo2bMn9nsN+Qoa
         KTBnu5Z+24i544yRHLqI5FNvagjaA05EVptz1PN5dM9y/KaxZwYoZ0NaxaxCxO18U5Eu
         VsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786338918; x=1786943718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0YZwlgtilaKnaw3bFD0t+VHhRkaxeSpx4Q+6Q/sn9GI=;
        b=i+x8mAITTa+S6m1afKZKCh0gV4h7uccxYtFq/sTBmeiNnRVs13KZXT2+jpuijn6rQM
         hUDx78MDGesp2k1NVszKZ/XY4Q2aoKLYs6eE9DmAFfWZkXG61yg01X40bQHJXf0bf9UQ
         WzWF80ZWMIDRDiIaAW1xKNttJMqxitLWtfqC7jPDRAcR7c9+xQsnk77udJFsvn20MR6A
         JswFMAkIoSwcOYgLE/ndyPIq6Kgr9t7m7qbKz/iArsxX2FLy/XFb1/ho0kk1bGGj8Ocw
         ucHDD1JnmglAQumncBybGEevGpLVzZey2DAysxtPcoYh/0tQTmgh/zNKffI84DFQens7
         2BIA==
X-Gm-Message-State: AOJu0Yyuv20+SaNc1/5/NcFOxFg3/yxjyFXphsfWrVHyxpCHwdkbV0uW
	/g/AHSoyqiMlKTnlpVwGUyffnEl1fPjFoGfn10PzKEEox7qfrHxkFqUMNpAi5w==
X-Gm-Gg: AR+sD12u/63rLsMrlvw/QymPtG84HV0o83OcbCthtzPkiN1yInle6LYyeZs3qPozNxP
	2C4r8b/TplpdRRw3lP3990eDjlUk57nt9FRi0OHwXENxaxXuzB2NLCx3XO06w8a/SNd/McKrN7b
	t9RBhneEb8S8xpi22BFgGd8YmCK/uzo0EupkIMUkOKG4RbvGw6PRAd/Tn+yoHgc8xIdhtOpkvVL
	9/eCPkRjZ7yXHFyL9Yjj2CN/COrGPVs94+U264or3Yl+Adpp6/LdaGfonlgYaRPxM+XKONcAoIy
	wdMasVDjcwq1Q/wp2yrXeI7iZMNZvrROUpRNizkEDzxPKBbf9AjVgjlhaIMFK3hroC+XOdehRKn
	wOmFvzX0JXPiQPzOQLp+Mjn3SE9mwBhzJL0PyHbinpn+bBdmoDGoReYjNjBEsRU2dKUftnCKAiw
	BUHCfnPXDSoMP5vJtJVg/3Jf7OoPTdVUYMTAsBSWIk1GKqOBeJEaGT0F0JqU7BlptfoXInVKO7z
	L67F60lAbbPUjaG4yY+190rbhqes/EE4Z89614zc87nUUn1Fl3H5lWG4HbhZkrSU3PB1OWKiwWQ
	Qnlf
X-Received: by 2002:a17:90b:3805:b0:387:d5bd:622f with SMTP id 98e67ed59e1d1-3928472ab9bmr6277812a91.18.1786338917920;
        Sun, 09 Aug 2026 22:15:17 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b13b0c74sm4719672a91.0.2026.08.09.22.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 22:15:17 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 1/2] rtc: m48t59: Propagate errors from optional IRQ lookup
Date: Mon, 10 Aug 2026 12:15:03 +0700
Message-ID: <20260810051504.26912-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

platform_get_irq_optional() returns a positive IRQ number on success or
a negative error code on failure. For an optional IRQ, -ENXIO indicates
that no optional IRQ is available, while other errors should be propagated.

Propagate all error codes returned by platform_get_irq_optional() other
than -ENXIO, so that failures are properly reported to the caller.
Preserve NO_IRQ for the case where no optional IRQ is available.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/rtc/rtc-m48t59.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-m48t59.c b/drivers/rtc/rtc-m48t59.c
index 4e608bc8bbd3..1150f3f6b008 100644
--- a/drivers/rtc/rtc-m48t59.c
+++ b/drivers/rtc/rtc-m48t59.c
@@ -404,15 +404,17 @@ static int m48t59_rtc_probe(struct platform_device *pdev)
 	 * the mode without IRQ.
 	 */
 	m48t59->irq = platform_get_irq_optional(pdev, 0);
-	if (m48t59->irq <= 0)
-		m48t59->irq = NO_IRQ;
+	if (m48t59->irq < 0 && m48t59->irq != -ENXIO)
+		return m48t59->irq;
 
-	if (m48t59->irq != NO_IRQ) {
+	if (m48t59->irq > 0) {
 		ret = devm_request_irq(&pdev->dev, m48t59->irq,
 				m48t59_rtc_interrupt, IRQF_SHARED,
 				"rtc-m48t59", &pdev->dev);
 		if (ret)
 			return ret;
+	} else {
+		m48t59->irq = NO_IRQ;
 	}
 
 	m48t59->rtc = devm_rtc_allocate_device(&pdev->dev);
-- 
2.43.0

