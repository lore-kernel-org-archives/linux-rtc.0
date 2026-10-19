Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444781;
	b=gZRJRj12wpMe6nwaRxtLjW6Jm/Z7Qxpf8DYfEjFTkbrT3aC20maEi/sfYWY//6aTYEx5
	 H7WLcdssief8cIwQUOwFPk5jIT3AQddq+wchYnFmaTCL93MK3gkyxKUQPFDd6K1YwMkW8
	 Lgod4n6m1R8mQPdHtRcMS3PhGmVa0yfTpZaDK6J9nMr66DA3cIkdwPga582LsaSeUNmRU
	 3prZUoxb4KbcbGy33WGbk+KBS9EU8E2epKgupT4jJBu845s8nvxr2msHjCfMX2NselsaF
	 Iq2XXaYphqDpujCK/npyweBUEvocGXfOx0XJwzHWAbwFh+wHlQYBKFfpeFlGma6JVqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444781;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=CAFcFXPQgjIyCq4dIDXD81hgSPAzF5RMgOAUClVWhlM=;
	b=dD++sRiynC0XFNdd3nhcfMBpwrPahhClaJCf/v/NP6Wu1+hXpYoIbF1Mw5l3+50hLejc
	 jUmkF70/wXiX6i5Ru4G+y6a1C1iqnQqJwyMi7Cf2FhO9M2Qq30IAPknmkRpWHm9x8Y+Wf
	 pqs/p61CmVy1nlwGp7+PqsH8LJ2ksyEkZOi3kE0ujw1Dfg0I27YqB/NchJ6XNlga1WfxU
	 +oOfbgBtvCYKYwTgqz77APNZk8+qgsXPu4UCNCtlb7QUJrImKgsxWocMMeAjxEZ+q1Lsn
	 iYQXGXP1E1VqML97Dz2v6T39c8r5BLvT61GqsB6rpvDA7+FaUTRDlEx8NqtSd4rSubQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2GYzGmIX;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA1B60A2602
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BA1B60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2GYzGmIX
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F1A69C5CD5D
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:20:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AA2C260582;
	Mon, 19 Oct 2026 21:19:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A98310328C52;
	Mon, 19 Oct 2026 23:19:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792444779; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=CAFcFXPQgjIyCq4dIDXD81hgSPAzF5RMgOAUClVWhlM=;
	b=2GYzGmIX61GUjdLGgFMzI3wrvZDgiee82SicXjaYBWvmwxa3QyckyudMQefIJ88X1cT7+/
	Qbt7/wJ65sTkR2hsKjgwNs7Y76cx0x61l8S68hYuWeF3L7GAmnvnyet+mj2853m4uazjui
	5/qsjjPWg/oKd59NmytiarYBpp9+4PZ3lYD2YUB9yoNlvoMXMWN1FxliJFcvjEOzmH6+Dj
	H5hGz4jtYWKqkinELx7vR6L9n7gCbzx/RZYGWGsvkj/CH2OBddZHA7xoM3CRn26Q+aNuly
	/qHFlLine7mkAAigpCfRQuo20NLXBsPyGFYzgHXd4xpbpRyKtGf7Evdg/X1S2A==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/19] rtc: pcf2123: use guard
Date: Mon, 19 Oct 2026 23:18:15 +0200
Message-ID: <20261019211827.126262-14-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-pcf2123.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index e714661e61a9..22c626d57090 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -310,7 +310,8 @@ static irqreturn_t pcf2123_rtc_irq(int irq, void *dev)
 	unsigned int val = 0;
 	int ret = IRQ_NONE;
 
-	rtc_lock(pcf2123->rtc);
+	guard(rtc_ops)(pcf2123->rtc);
+
 	regmap_read(pcf2123->map, PCF2123_REG_CTRL2, &val);
 
 	/* Alarm? */
@@ -323,8 +324,6 @@ static irqreturn_t pcf2123_rtc_irq(int irq, void *dev)
 		rtc_update_irq(pcf2123->rtc, 1, RTC_IRQF | RTC_AF);
 	}
 
-	rtc_unlock(pcf2123->rtc);
-
 	return ret;
 }
 
-- 
2.56.0

