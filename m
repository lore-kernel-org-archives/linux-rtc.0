Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444782;
	b=jEowFyOZgL0ZGW6tKz20elSGk6oDLqvC20GHi99XUVN39cOOTAmsCR4K0nDoxlQxNlxJ
	 4t6QQX+919qTiyog94Sm5aX1W0Sy+2Ni3QyJ3xw7cwMiNY8alle0fUiyFOzs9daLOsSPQ
	 LW3UBDV64XFWo1N4/YjgXmAKgUyW2snJ2Ybcm9PdPZMjlPqEpYK2GpmL5Yf5zFkOzwvW1
	 FQiDvezMilHotMK7lGTmWSIEM25SHYHr3bs/QNL1yxk1/Ycn2d/M58Zms6uaQD/wJ24WU
	 kcIG9hpcKFpzdTM7zOFA9qmduc5Z26TJKAmD+3mx0P+Lc77mQSg5wfv1e7R9PRmAILA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444782;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=Izt7CgX0/hyTwA/HJBttxhcQ6AOnSfVbeRowTljIexY=;
	b=soX9iWo/Uh5kG2OOYrFIqzId2+ZMFxFifPORZ5VGGIALHYKBhZYqBWcHaVcv6CMhxatZ
	 m6ozIDWUnNOykGZYrmIIu9erG5l60/WP16wkL4phaiQlq3YzrHz8lNZ/Zg7+ZKoBxD7pv
	 DzG0el2DOm9UxG10PX+uNMsE17+6Dmh03HQ/Qa7eH1r0pGoBZJd6IcKjpxeBAJHfnNExH
	 9aNphTGGIJTmC0jsoCyYohFlvy3kEPNNCMJirro3ydDzRkFeDXz6yS+cTmttOGOVhdRSs
	 TaXrF35qCrxmtUI4v7FerJJzfDvjotC8XcOKQAgJ9ByxuntU6QsRjB0Obkz6KoATajw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qoX9zPQR;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4035660A260E
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4035660A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qoX9zPQR
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0FE031A1253
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:19:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D8FDB60582;
	Mon, 19 Oct 2026 21:19:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 06DC010328C22;
	Mon, 19 Oct 2026 23:19:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792444780; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Izt7CgX0/hyTwA/HJBttxhcQ6AOnSfVbeRowTljIexY=;
	b=qoX9zPQRa2S6ib+huXM+FjPEFIvpDvG+e4w51my9qjW0jYUpIkPCd+yk2rCoHhgRkWIKq2
	WBhF6jDkRjK2natwF1+cykdubo9Ul/aaVr24nGvWHtIiU8QBAV7PfmgtfTkIsoTl7pa8pe
	GJgWtzLbdQXcAMPiILUw3NGqtlMoMfzTglf4PASGdYpyS8lZgDTRLCvr0O1Zd0O5u4r/ND
	m2XeIISGrBhNPZs3n2PT81rHtmpdxathBFqTt4TzYNWC/eQfL5gDRqFwshunT88pU5ddjm
	6Bkzi2nAhz645axMi+GyFzO5wlwFIkAl6wmFTklS4Rb6X8R8lr3txCfEVVK/hQ==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/19] rtc: rv3029c2: use guard
Date: Mon, 19 Oct 2026 23:18:16 +0200
Message-ID: <20261019211827.126262-15-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-rv3029c2.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index 98953af2a24a..c348b31928e9 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -270,19 +270,17 @@ static irqreturn_t rv3029_handle_irq(int irq, void *dev_id)
 	unsigned long events = 0;
 	int ret;
 
-	rtc_lock(rv3029->rtc);
+	guard(rtc_ops)(rv3029->rtc);
 
 	ret = regmap_read(rv3029->regmap, RV3029_IRQ_CTRL, &controls);
 	if (ret) {
 		dev_warn(dev, "Read IRQ Control Register error %d\n", ret);
-		rtc_unlock(rv3029->rtc);
 		return IRQ_NONE;
 	}
 
 	ret = regmap_read(rv3029->regmap, RV3029_IRQ_FLAGS, &flags);
 	if (ret) {
 		dev_warn(dev, "Read IRQ Flags Register error %d\n", ret);
-		rtc_unlock(rv3029->rtc);
 		return IRQ_NONE;
 	}
 
@@ -297,7 +295,6 @@ static irqreturn_t rv3029_handle_irq(int irq, void *dev_id)
 		regmap_write(rv3029->regmap, RV3029_IRQ_FLAGS, flags);
 		regmap_write(rv3029->regmap, RV3029_IRQ_CTRL, controls);
 	}
-	rtc_unlock(rv3029->rtc);
 
 	return IRQ_HANDLED;
 }
-- 
2.56.0

