Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444787;
	b=3J758CpOACzLRROBxRlpjpfqw5TMXOMA+9GFgl7okJWqHbgA7mi+Y5arkYf86l1l8xK/
	 acDzOfRlqIbJOv18u+hhu61p2d2S5jXNdHOA92suQdfHjUVY+ltXFfbk1XSQV0oRqgJMI
	 4P6TVdFcbsiQLXom9VREm0zqFIAweZOmvfnMlYbuGgm/khZrMWXPkzy4qy6ImNLUupOu2
	 jV4H3xuGL8wanA3UJh7bXNirO/iyhQOIZ4tMyTMoIWGQrOP9jH3d/3vGfJaWwrmtJGUdm
	 uDRZawZKhSYyZCSHg+VcgQKgIEou110zhmNZODCDc9zibYILpqEHzNbCzIsJGXPYjPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444787;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=yZjG2IwYnhcLEtk23bjX0dkfBTdvYZcrIyrdACv8Msk=;
	b=0wuqb/Ki3wAjeOxOOsKyVk0N3xYeOqNJFj6tpLzGDnu9JtcfyO5XjJFQxCxAjpZKEbso
	 NRWAg7Rh3Nv5Z0/UW/aMm6NDGCYM0IqA+WZr/tnI7yiFaXBlr2XLv3D1KEvIeXE+rzX7e
	 fze2SnBmQhUoV/nukKZwTNhrlydpDa2s2QwQEZVRrdYsFDHoXw56Cpat1cXT3LamfJECX
	 tPCy1yID8wDDE5MnPIGkSMZZRQRV8AtuNLL1Gm6zrviOmgbC6w4Tp/FliYkvXgN1p8uqO
	 141r22tqh4am43Qgz5x6QnQmiDYBCqnKQz+AcT1Pit77+isl9sNiQ43lw1U0/QS/i7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=CuPFDcOQ;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F8F60A380F
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57F8F60A380F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=CuPFDcOQ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0DB0FC5CD5C;
	Mon, 19 Oct 2026 21:20:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C9B6D60582;
	Mon, 19 Oct 2026 21:19:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2CF0310328C22;
	Mon, 19 Oct 2026 23:19:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792444785; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=yZjG2IwYnhcLEtk23bjX0dkfBTdvYZcrIyrdACv8Msk=;
	b=CuPFDcOQ+v4qI8I69v9WKpehVrcXLlDsov6Zg7+hr/Wg0OdoUdbjpFWNy4cf+sIfC87wGl
	L7QzMSstyd7xIlyKRfpiZ7TLdwKb3AqCG7FZOEjpwEeALbRZiG/G9uPZrx7KCdoH/XWp8x
	QiDDhYZNqPZJBhPIT0U6aENC6bB3Vg8UveJiwM51/YveZ78F0Hkioz3mU5yu8lxxM7gzmH
	+dNZJZIhr25yh0ywUa+nWoe+M6N9MappPKkqCLv5ybCCrR3jCTBcDsu0WZ7S4YUJwewrvd
	itMnhEayIBY8SOWdhX93S7OmHYBcIkq+Whxx8rXEXXFPKzpbeL2REvWWSlPWbg==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-rtc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 18/19] rtc: stm32: use guard
Date: Mon, 19 Oct 2026 23:18:19 +0200
Message-ID: <20261019211827.126262-18-alexandre.belloni@bootlin.com>
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

Use guard() to simplify locking

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-stm32.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index d4ebf3eb54aa..1c4e4bd7afe4 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -465,7 +465,7 @@ static irqreturn_t stm32_rtc_alarm_irq(int irq, void *dev_id)
 	const struct stm32_rtc_events *evts = &rtc->data->events;
 	unsigned int status, cr;
 
-	rtc_lock(rtc->rtc_dev);
+	guard(rtc_ops)(rtc->rtc_dev);
 
 	status = readl_relaxed(rtc->base + regs->sr);
 	cr = readl_relaxed(rtc->base + regs->cr);
@@ -482,8 +482,6 @@ static irqreturn_t stm32_rtc_alarm_irq(int irq, void *dev_id)
 		stm32_rtc_clear_event_flags(rtc, evts->alra);
 	}
 
-	rtc_unlock(rtc->rtc_dev);
-
 	return IRQ_HANDLED;
 }
 
-- 
2.56.0

