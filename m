Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444734;
	b=Ca2osUx3qUp+bKfoN8vkvWwpzkOTfinzraNI6MFBequFwKz5tM9hC+nZC6+8bjsgXTkm
	 6kpr4+aLUT9ITzlgnvk1sd9NjQt9jQ3v0iH3Enywb2bcUDCMVzIOhPMPxsE/8GHSFDjug
	 ApdH7eNqODk7XnmmcOtmsJ2i4dLvSlbdt0KUAMQemNMVmTdS798n8BYUdV+mCqbh3fhsp
	 +xxMUiMwIHcL9HsosMLlNz1PuFXjRucXiw95HVTKEAHqFgk/YDpwMEEWY4oeGuEXfnLgJ
	 4ptyuCJ0Nd/ufzmj+7JLRsb9+m48yzXVDVjMpCKD4tbXHGMsBDAi9aOohEjd7dnmXbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444734;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=1aY/ovidFv5oOqnqGNioiPlwdlj0XKYaRdg6c0us2fg=;
	b=b7Dsay4gE8hoDFZENoAQA0rGR0hBBliYCJQWXTnSfnmh5NjG5q8svXSkh5LT8psDP9Ig
	 NNOI+9yL8aO+jnw/Xt7V/DV4c64Stmg5sPlGX56VKI7uPZXnoNq4FMuuplrGN14D+dVSX
	 eZZwvW9oGvdEJHJBOyPvDHzJL6xS+RbPhVIoAV1kYUOXU4nM/+PKLb5rNHTQ12wbyh9rm
	 Fve6nkM88XEQ5+ba74x1Hxh8weVX/KlsDrtRyV8eFjDpRoX+2tynNSwlx6RqzMuO2INhM
	 7KpLiEsaaj6OcPtumvyyJ0KT7mBkxoKxHaJNj/dqFtmKmT27MxMS7P28EPTunkQaojA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=DztTtqai;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604B5606A326
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 604B5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=DztTtqai
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E67694E4127B
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:18:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BA22960582;
	Mon, 19 Oct 2026 21:18:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C749C10328C52;
	Mon, 19 Oct 2026 23:18:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792444727; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=1aY/ovidFv5oOqnqGNioiPlwdlj0XKYaRdg6c0us2fg=;
	b=DztTtqaiMFNxQyeT/XjiWwK1V6UffMiaMoegSAVrYBY6q+Sq5lG9Men7q2iCjuO3qYEusE
	LZJfVRHOqRNva2Ht11r9c5SzJDXU7oaXb8Xgw8qfD+YkgSDQpAlnozdmiGIKVWwzPDQKMj
	PuYiw6Op4ELUS+ooThQFuvY3BxCjhgM8h+wnw3H49sbBoc7Qr2WFRFtLlKeKmSmigS7BeH
	VBDRHs3uTitLTuTm+IBSSLJYZ9roCxTB+AwmWtHMyLKgSKcnxbdSScA5MiuZ7NVAi6JoMq
	T28SUIn3TtaE+0j55Kt6jBMRlVHqzGJ5m7tkb0th9fHuAEGZx3qOQV8Hi808tw==
From: alexandre.belloni@bootlin.com
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/19] rtc: asm9260: use guard
Date: Mon, 19 Oct 2026 23:18:04 +0200
Message-ID: <20261019211827.126262-3-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-asm9260.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-asm9260.c b/drivers/rtc/rtc-asm9260.c
index 705470ae8428..422c2e5d83aa 100644
--- a/drivers/rtc/rtc-asm9260.c
+++ b/drivers/rtc/rtc-asm9260.c
@@ -116,15 +116,13 @@ static irqreturn_t asm9260_rtc_irq(int irq, void *dev_id)
 	u32 isr;
 	unsigned long events = 0;
 
-	rtc_lock(priv->rtc);
+	guard(rtc_ops)(priv->rtc);
 	isr = ioread32(priv->iobase + HW_CIIR);
 	if (!isr) {
-		rtc_unlock(priv->rtc);
 		return IRQ_NONE;
 	}
 
 	iowrite32(0, priv->iobase + HW_CIIR);
-	rtc_unlock(priv->rtc);
 
 	events |= RTC_AF | RTC_IRQF;
 
-- 
2.56.0

