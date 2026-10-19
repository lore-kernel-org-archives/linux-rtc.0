Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444783;
	b=NBVEnmf+tkm0iCMOgBsOAhh5FrYomF+iZswh959QrQeT95gv2oEu2SyIuxzilNTAqzgA
	 MWRlQ5aS/F5ih84CduKHhayt5kjZeIrYQA7UDzG0rDj3NKhxUH2zLaGiZ2DirZK0LL3u/
	 Y1QKIFyRqKYswfp3zZrZ7HfeXgoZP0Lc4SNmGdaWvrvA/qsjxRctRcKvsL6fiDW0IW1er
	 VpBFmeaEtYakFAJ6l3aukxUulKcHOj6ahofBs0raG+kxAbTT7JsXRgyDfBPBetJ/Lpc5Y
	 uOyM0HNKs/CedUtobcvdi9yeWCBUeL5NN3YRaJcnvvHWdmAXxBGEi1HyNpyC5Olyh/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444783;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=h+ACSAFT3E0lFcRWOm+m/P7/9ovX/ScXqa/EaphD3O4=;
	b=ZM4CM/DGEyH2kucaU5XANxCvrAen5MbwZWHNbxaNG/zIx+cndLSKXkY3+2tAhxsSbVyT
	 Zfr1/iO0nq+fl3YuAWkKNe+k8FrJJq9JQbEV5EEPjTAWB9sNcGMDc5X5xyMvX0zeSXB3X
	 WUx9BDsu2gFeneFzykcFQnLVTotrEBcTHb86t9vGfPptKwdH44ssOhoVVZ+wvSa+ju0a/
	 aPrPyfSgGXxVQunAPHVBU4Ucw9vQ0EVljK6ja5gVAQyTpFAB7qZigQdmk9blJqScaEs1F
	 IEjmqGntY17mtuVHg0IfmZkQxfmaYZyIyKCi9EXMDEJ5KTW7cdJVFt1/s4MMxfMlgBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="MSTn/mtE";
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31484606A31B
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31484606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=MSTn/mtE
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 137764E4127B
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:19:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DC03960582;
	Mon, 19 Oct 2026 21:19:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2DCB410328C22;
	Mon, 19 Oct 2026 23:19:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792444781; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=h+ACSAFT3E0lFcRWOm+m/P7/9ovX/ScXqa/EaphD3O4=;
	b=MSTn/mtESafyT7UDo1cahMoC1+NCYt0SnEOFmWR8yDgfjAyVXcaUXvFdaPi5tYWfuYhHp0
	nm/eGTa1YfIDZBh16rIqv+STYvg6Kg9Yiamya1YGYezaDfujguU2+0NxZmqTTD+/V/pf2j
	9oYk9j4FJit+OgVx5hYLM+J0aZboabCrl3OhUKzI7/UraCpuUYtiWcIng5KLV4JU/4vWCS
	aobDpnnKEIlakZNExqxp8zyn/RD/bPmotBTmE0xiUTilJSXUhAJgvM4gql0Zu1/neWloU6
	ySjyMr4zMobaqGBZ3XKSMrBlAgLlOWeT8PhiBttCgUyl2TrPR92tF0jxBnwoHw==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/19] rtc: rx8010: use guard
Date: Mon, 19 Oct 2026 23:18:17 +0200
Message-ID: <20261019211827.126262-16-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-rx8010.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index ce3954132336..0a9be6ea62d0 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -73,11 +73,10 @@ static irqreturn_t rx8010_irq_1_handler(int irq, void *dev_id)
 	struct rx8010_data *rx8010 = i2c_get_clientdata(client);
 	int flagreg, err;
 
-	rtc_lock(rx8010->rtc);
+	guard(rtc_ops)(rx8010->rtc);
 
 	err = regmap_read(rx8010->regs, RX8010_FLAG, &flagreg);
 	if (err) {
-		rtc_unlock(rx8010->rtc);
 		return IRQ_NONE;
 	}
 
@@ -100,7 +99,6 @@ static irqreturn_t rx8010_irq_1_handler(int irq, void *dev_id)
 	}
 
 	err = regmap_write(rx8010->regs, RX8010_FLAG, flagreg);
-	rtc_unlock(rx8010->rtc);
 	return err ? IRQ_NONE : IRQ_HANDLED;
 }
 
-- 
2.56.0

