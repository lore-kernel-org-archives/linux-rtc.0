Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444778;
	b=aTeMZU8VV+bc8VTD6Yt133WHg2Dtr3Z0AibfXNZ6j0n7wp9lBsoDAkVJslzuCPeLD5sW
	 m//ylH7JBxz68BhgRlLUBfwG53EGJkF4GIDf3fiEY4hlkDI+lZknf+baIan7Y+Zf/zpQY
	 9gmjTbURyC7fjM6OLM3ehwtc648UAf4QSu17NKuXnafH/vpAUzhVr1thIpW9h8WJSkTEw
	 1hKwrYIzR7/q4UR3a/dMMDOVln38K2ttVlD9/8o1Hf24qf5g96CWz9NxevXwTH4kQn/o5
	 yhEcYD8iMgg4NwMFmDQorskHjNZb3Nsoku5ERsIdr4aCMJoHO2q+c1wicqa0XPwKRuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444778;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=mHFk2oWQyJ+WyNMEt7iJPhBL9azXT1ceCMRUTQ4ELA8=;
	b=TFZgE4AQoTl+eX57sPm9nTyt0PwECkjbMo/XRl7dYOzVVg8Egp/VYA46+be59F9nUHph
	 lbFYpPiZZNtea3lsyCdqolzbwoXskaAFlHkhheEEDy5OTiDOabLBRqa/bsYWzSSUJ/0Op
	 XzQ6TA2u9P1U0JlPk+RflQw6HFFqYYou7cVlou5cg19zT+OhjfdUUTRdlbZyypIo/dhRE
	 Unw93LwoMp+4B5SbOHqcrP+ySsl2O1qFot4DZww2PQRbR8G9n7iXLjoVNu5Hhi1gBBefB
	 dqZrUqaB0qRia4o/uoh9W29HJzhIV51ybSzUPrPq8+owqzJSnB5sDWBmVc3Vzv6yWjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=t4c51F8Q;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDED9606A321
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDED9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=t4c51F8Q
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E776EC5CD5C
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:20:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B0FEC60582;
	Mon, 19 Oct 2026 21:19:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE75810328C52;
	Mon, 19 Oct 2026 23:19:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792444776; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=mHFk2oWQyJ+WyNMEt7iJPhBL9azXT1ceCMRUTQ4ELA8=;
	b=t4c51F8Q8anTV49wdD+0ymUbglrtig2tmISRCKKc0kEzwD3wHLYx9ctssx+a9FFvDfcK4q
	CtrRzrjEbr+AVbgtsk2JWWvsR29PsJ2gKhQ9GqAM3PmmgCKjCW5c3vftXSorozLqfCoprw
	nFHXa8ExxxBOxPm9hJHWlvKAsp+4GDqtjjV9SP7oaY1uFsw5F4VsoTdxBS3cJQno+TCzd4
	kwFEFSH8uFUNnOFO6yRsrdFhch1VvlVpGCcA3QbPv9agX1DJfwEqHECc7N6zTSkOjvRB8V
	AWIklG1stZxzF4kB9X1qZSyKCZURWkZBNFM29w61uzKi+V4HF8T2y6pQGSyB0Q==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/19] rtc: mcp795: use guard
Date: Mon, 19 Oct 2026 23:18:13 +0200
Message-ID: <20261019211827.126262-12-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-mcp795.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index e12f0f806ec4..9b5b36b88122 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -352,7 +352,7 @@ static irqreturn_t mcp795_irq(int irq, void *data)
 	struct rtc_device *rtc = spi_get_drvdata(spi);
 	int ret;
 
-	rtc_lock(rtc);
+	guard(rtc_ops)(rtc);
 
 	/* Disable alarm.
 	 * There is no need to clear ALM0IF (Alarm 0 Interrupt Flag) bit,
@@ -364,7 +364,6 @@ static irqreturn_t mcp795_irq(int irq, void *data)
 			"Failed to disable alarm in IRQ (ret=%d)\n", ret);
 	rtc_update_irq(rtc, 1, RTC_AF | RTC_IRQF);
 
-	rtc_unlock(rtc);
 
 	return IRQ_HANDLED;
 }
-- 
2.56.0

