Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444772;
	b=sQBoIHT9ZRuiTLM5Pstmwc5SHO3Pt/nzpmvNpX4a+WVxbYXIwhPiA4AvWIPdYZyH3sPq
	 AeUtga0Hkc8rU/57kDHgYiz7sWCzVn6GVcz7aM31zY4dZ5KhtArKzdHOgtfSXDn4KHpAZ
	 YagvTRFfx/4sSCOkj2yqDwJxYANXyS0JZ+qxDrkpq7Y3ApzGQGNsX7XdPG1e+gYwrfk2f
	 vbttexr1JxmyxmW9KkKU/NvtuSZaKxxZnr6+9ImcwcV8gdOhoziG8LFJ0aSBbUQ0pyOdU
	 AChfy7KLaVOxvXq4VCFGx9CtTIMaZ3f/7p45xAP4aXmIFOx7ZLF9E/MxIUyOmoquFBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444772;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=+kc2iACm9dCqzWnx1eQzs9n/o652xBmHZOuUjqDo0Ug=;
	b=T2uas5GAilMY7fqSbU35vUIgqiSo2R9UsxH0u8A64Mldg52Wy2YNe5SuxlTB79x86P7O
	 6NEhq2LkUXr/ODcsUFNyqwEB28G0wvhfrAEYUx64mKUoB4R/Ri1YaPB6RaIKSTig+yxAR
	 pVzAuZqSn34Cvwq1iq8CMryCitk1i3odepvJZbIF+D9ebwG9BLg8M/eZq1avk8fon78xM
	 86hMbnuls7VmuVA2Bnolr+OYK0WzUtuPi2IuNH4YYKZAEVxze/chBOJklpA1gO9la1pEA
	 DcrAh8nnZ8Do0qXgPBeK5VmqIzXGmoOyxCpgBYdtoYwEuDh+7VwvNH9VEVFb3H1vM+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=0UL8yj9h;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0150606A31B;
	Mon, 19 Oct 2026 21:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0150606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=0UL8yj9h
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D5B6EC5CD5C;
	Mon, 19 Oct 2026 21:20:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A081360582;
	Mon, 19 Oct 2026 21:19:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CA5AE10328D55;
	Mon, 19 Oct 2026 23:19:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792444766; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=+kc2iACm9dCqzWnx1eQzs9n/o652xBmHZOuUjqDo0Ug=;
	b=0UL8yj9hkTCD+Nf7TAER4C3CbQ2y9vWdBEpDedJcR+fXcd7NLHKLSH6P2b+ow2Q4h+SF8A
	e6pp70DTxUYeENlBMz8xwU9zByrF1+NJUx9C/h2Urxp6tEPdvAIlKdF5gaeMHhBW1mJfRm
	nLbUr+XdIR3BnAY9M0brIk4u/K8xL3RaTvVQBjybjSkj1zcN+KO92cPNV+fYEXL7aLx+DS
	TSd5wDRlQdoXjMoKDJ7peqQCTLGSevxiYkXQCwSeXCrzM1Gkna+H0olZzj86NQngBpB6Sn
	rW1qV3c7U9kqeoq0/3kygctcS0X55ELvS6k6R2WY2sXMN9DqgL0JeU0eWLooxw==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/19] rtc: hym8563: use guard
Date: Mon, 19 Oct 2026 23:18:11 +0200
Message-ID: <20261019211827.126262-10-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-hym8563.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index 1d52cc3def02..e3d7ca477e75 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -417,7 +417,7 @@ static irqreturn_t hym8563_irq(int irq, void *dev_id)
 	struct i2c_client *client = hym8563->client;
 	int data, ret;
 
-	rtc_lock(hym8563->rtc);
+	guard(rtc_ops)(hym8563->rtc);
 
 	/* Clear the alarm flag */
 
@@ -425,7 +425,7 @@ static irqreturn_t hym8563_irq(int irq, void *dev_id)
 	if (data < 0) {
 		dev_err(&client->dev, "%s: error reading i2c data %d\n",
 			__func__, data);
-		goto out;
+		return IRQ_HANDLED;
 	}
 
 	data &= ~HYM8563_CTL2_AF;
@@ -436,8 +436,6 @@ static irqreturn_t hym8563_irq(int irq, void *dev_id)
 			__func__, ret);
 	}
 
-out:
-	rtc_unlock(hym8563->rtc);
 	return IRQ_HANDLED;
 }
 
-- 
2.56.0

