Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444756;
	b=ELhrfS9QF3rDqG/HRllFZBZ/s+JRVULX0lGxigfIBAiBSnnIVi9prwLoDNH3kdJ1elsT
	 fBTpeiLA6vG4pOJd4OSeAqsz1gaPu35XbuCgxYCzoqaemEGhFBwKrD9UenJJR0olD7zbk
	 IGkXsLE6WZzrZbYZWeSTwLvq8V63Tgz5yveCR0Kds9Zn5qTx4EwwXTLmVu8DyZrLuh+ae
	 wvV44CizO0UBsuNJb68c1COO7DW2lFpjz3o5Zbx8ve/F6wxwotgKfU8dbb38g8ofSHpr5
	 8euMcFnKVof4TdiHGsMJR795a0vdQicBtUfLGwBs/ioCCA7v72MgnI5NTqrTbSKffpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444756;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=XEzKTFQ9bTRV2RN61J13fI5VmT4JunXOx6tYvH1TSr0=;
	b=tQJdzgJ2kP/IBv6Q3mCr2mebVgyMaHttX38QTH1e6B0/6WKkYW2RPmzueB5Mf2dG/ekH
	 kNdOQF6mfM6kr1Pk+mwQtpVm1Ulz5BurRFLO/+dH0bias85+RCTY7DmcPHLHLSUPsqDA5
	 5IfKvcHJ3KbCMkMOQEpKV0F0IP2ia9Dk59Q4XTe8HaouPmFMGy3GsjB++tZZiq5eAinDD
	 q5WkMzqf0h+exHTBbc7ApVqwAo0bVszl0BvibTlF9PMbNijYRRTUrYlKIG0/ylfzKMx9p
	 OH/NQAowQVQKlj4BV+Pjj63jZJy6BHfHKN6BX+RB9Xl5EfPssygmCspziIK+B7C1xQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=hvGNaa4j;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2914F606A322
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2914F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=hvGNaa4j
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A1F044E4127B
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:19:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6FB4060582;
	Mon, 19 Oct 2026 21:19:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A5A5810328C22;
	Mon, 19 Oct 2026 23:19:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792444750; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=XEzKTFQ9bTRV2RN61J13fI5VmT4JunXOx6tYvH1TSr0=;
	b=hvGNaa4juhtdKkRo0Ug86nVSFiOoo1PvBDyeNL+uFmJf0e2S0AFSKRkycwiATrbkPQ3Hbs
	6WLw7k1d6zHe3QGMwBqYElr0VyUsbxbulrBG+ZOVx2la2BtczUK4EstTXrZRuToWr4mQoI
	FN4CBl5lFWmr5PXYUDNfUD+ywdZNQgMprqmu/95Hrac30Ru8gtfsvmlysIlKLWFuH+gGCF
	RqWQogzaq/o3VRGA5HjBMHcVCl2Ri3GDv7IidQCrMnlN5BlE3wBJ3dDI9N8xjKgxTllOaH
	ihKJTXB74s4ypfhjAcVk+SngkgDPogrh3eKfwY9g6LBqZZxrBsDke88iNX9RJA==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/19] rtc: ds1343: use guard
Date: Mon, 19 Oct 2026 23:18:08 +0200
Message-ID: <20261019211827.126262-7-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-ds1343.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-ds1343.c b/drivers/rtc/rtc-ds1343.c
index 54f6af7886a8..22abec4ba656 100644
--- a/drivers/rtc/rtc-ds1343.c
+++ b/drivers/rtc/rtc-ds1343.c
@@ -312,11 +312,11 @@ static irqreturn_t ds1343_thread(int irq, void *dev_id)
 	unsigned int stat;
 	int res = 0;
 
-	rtc_lock(priv->rtc);
+	guard(rtc_ops)(priv->rtc);
 
 	res = regmap_read(priv->map, DS1343_STATUS_REG, &stat);
 	if (res)
-		goto out;
+		return IRQ_HANDLED;
 
 	if (stat & DS1343_IRQF0) {
 		stat &= ~DS1343_IRQF0;
@@ -328,8 +328,6 @@ static irqreturn_t ds1343_thread(int irq, void *dev_id)
 				   DS1343_A0IE, 0);
 	}
 
-out:
-	rtc_unlock(priv->rtc);
 	return IRQ_HANDLED;
 }
 
-- 
2.56.0

