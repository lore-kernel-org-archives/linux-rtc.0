Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444751;
	b=gHI+eC2GmMn1a34hbCSLPVN1feyVSfPbVu58SAgZg9AX2Co/zAe6HKCS+BEDxY8wJY2B
	 +5m1MQe8qJNOAp1UCmJoGvDbQ4VdQ2YS14jnOw2xrNavIXt+BJil25fLQadcGdYzqmq1C
	 4eqgKtSVfXCa/XQUz5b5X1TDu4UsxsdctZe7iE+G+Y7NOIFFwgdLOcVAms0jjGstCPCAC
	 HwKBY4sAu4TJ+lVVM9v+yuhkMGdv8q9Bf9tFzA/nROfioXPL8aESFiV//Fm/EXI2M9lHa
	 K9QqcOhF3BPQdk2mVcEA42xupC3gA1FVsIrVRIBTnMFAEw6/77EP5v1OyIfTA+bMg/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444751;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=A3KySBfkO0wNf//W+vJY7lgKk6K7hXGdO/qW19nptvg=;
	b=joKErc+y4/+IWxmMvSAgTAeMA76CZ+O+U3GkvpKXrIjM2IGwJvEIZRLqGzoxJ60hubkc
	 0SgNx11XdlRcVbkOKUbI329cX5w9FF+DBZwIPssF/PWm2LX0bZmCbSKG95V5vuGh8ecOO
	 XpCYgdz4BXVlkluaNEqa051mtEWPcCb7nVSqrGu9ZduCco30pBoJvaqbzNjCMQYBB50RB
	 luWDQsizWWhl7pBczOLo2K+z7bHFyBtBkpu0im8WWDMC5qSEHEGU1/uepEBGXkU1TZysH
	 8KM3UHLN33Ku6ngG/NP4IgaFSglhNwGc5I2M6EOSJha0Uio0wLevWxIFG0thR4UXG7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=GZuFzpHx;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E509E606A322
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E509E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=GZuFzpHx
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 79FC04E4127D
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:19:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4E68F60582;
	Mon, 19 Oct 2026 21:19:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9931410328C22;
	Mon, 19 Oct 2026 23:19:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792444744; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=A3KySBfkO0wNf//W+vJY7lgKk6K7hXGdO/qW19nptvg=;
	b=GZuFzpHxX2rs6jdzW1UIdzLpwsAHnxWjeI8v2dCVNvlewU/dcTq6nJM2ucRunrbbNpUR2d
	NCwdqVO/V51Qi1v0SnB/oMAMlPAxOCH+a0nhFBGCRGDogDEt8/XFucAazNZYPEuceRnL7E
	HFoVOMPo8T7O6Y3Dmh97cJgWiN5mZq+k/jwsxq5lafUBfrFovWC3lpNGBNgKd2X6xJ2xmN
	xE8DIbaIeG0sL+DFeeFos9DcG8jgGk2eFFZSXtXwEseuLQR9d2rTMSKoBeAK6Z/X3YL+C/
	AxhsybY6igXL3whReaXa6+yVAIPSMO+o05Ih9fxnNkobDfnWDlidF2zD2QXdlA==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/19] rtc: ds1307: use guard
Date: Mon, 19 Oct 2026 23:18:07 +0200
Message-ID: <20261019211827.126262-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Use guard() to simplify error handling

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1307.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 522f7eef3b4a..0cf4836b81b1 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -579,28 +579,27 @@ static irqreturn_t rx8130_irq(int irq, void *dev_id)
 	u8 ctl[3];
 	int ret;
 
-	rtc_lock(ds1307->rtc);
+	guard(rtc_ops)(ds1307->rtc);
 
 	/* Read control registers. */
 	ret = regmap_bulk_read(ds1307->regmap, RX8130_REG_EXTENSION, ctl,
 			       sizeof(ctl));
 	if (ret < 0)
-		goto out;
+		return IRQ_HANDLED;
+
 	if (!(ctl[1] & RX8130_REG_FLAG_AF))
-		goto out;
+		return IRQ_HANDLED;
+
 	ctl[1] &= ~RX8130_REG_FLAG_AF;
 	ctl[2] &= ~RX8130_REG_CONTROL0_AIE;
 
 	ret = regmap_bulk_write(ds1307->regmap, RX8130_REG_EXTENSION, ctl,
 				sizeof(ctl));
 	if (ret < 0)
-		goto out;
+		return IRQ_HANDLED;
 
 	rtc_update_irq(ds1307->rtc, 1, RTC_AF | RTC_IRQF);
 
-out:
-	rtc_unlock(ds1307->rtc);
-
 	return IRQ_HANDLED;
 }
 
-- 
2.56.0

