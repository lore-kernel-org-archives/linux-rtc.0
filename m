Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4995434EEE6;
	Wed, 28 Jan 2026 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594165; cv=none; b=noEogXPSF5jivcTEryjNmQdjIocI4NaffkiRjY/eLaDixfE6tTwTHRUNnIkom2sht0oYHzzlKfymsR3kaHgzWvNRJre15wZugy+fu3uM4wT9vemKBrhtEaER4epUOyC/It186jikmiaD0NrjJJZMoeKNrZz+JQBfgJAFYQjSQ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594165; c=relaxed/simple;
	bh=MV4zJVUPG0TIFSORt9w0lvMQpDktiQKvvR2tzf2EVf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHYfq2fUlNnKWZl8v1WMYRKFUGbksFjlnzS/VFgkumoKgOH3QqalL3hKaGZa8e9TU4rOGmrw4NkfCPvpSv7f9Hq5mj05DkQePJj4mE2ET6DXr8kSlmEgXMsUyipjg6igC25tZ2dgn97Fv8V4VOUeiysOWxxySLrT8C/mqvHaOKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j4+T0TQ8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=viqeemaI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j4+T0TQ8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="viqeemaI"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769594161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SoKuQzz4G4oLOsx25HsiRvaTcp8ursPrum/xBovvjB0=;
	b=j4+T0TQ8lW523WIn7s+fI9XJqr/CcU5uvc8oB7c9QV9aqJQXp6va3K3zVDFks9mO8q1nrD
	IPneTxbqU3gGdZBGh4eA91PQTRILNFoPuUIE4hnfVn3IUcmyuuWejlMBKHLVsvn9KgKJTY
	YatitFONlGl82CrOOLK7sM2N9WlzwPJ6wBSRBLj7kt5ISwspaX7YH3/zvI/fqEmgZoExpo
	xsIYBxM+aV17p1OYBLOVryKrdaDvay4F+XOYBemcZoliLVUXnoFkfCkCnGVVEB9dk//pRc
	meC90TO67we4DAuIq4OCz/XBDJT/34tKuwFUCgUJVaUt+TtrU/kxQG6Ia3hCKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769594161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SoKuQzz4G4oLOsx25HsiRvaTcp8ursPrum/xBovvjB0=;
	b=viqeemaInEUhQsuSncms6muvPmMDkjbulMK6W+g97Kd+7UqvoRvS/cvq+wzZ7ZUITxFPeO
	taBAp1KyQMorzTDQ==
To: linux-kernel@vger.kernel.org
Cc: "Thomas Gleixner" <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Yiting Deng <yiting.deng@amlogic.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-amlogic@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v2 12/20] rtc: amlogic-a4: Remove IRQF_ONESHOT
Date: Wed, 28 Jan 2026 10:55:32 +0100
Message-ID: <20260128095540.863589-13-bigeasy@linutronix.de>
In-Reply-To: <20260128095540.863589-1-bigeasy@linutronix.de>
References: <20260128095540.863589-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.
The flag also disallows force-threading of the primary handler and the
irq-core will warn about this.

Remove IRQF_ONESHOT from irqflags.

Fixes: c89ac9182ee29 ("rtc: support for the Amlogic on-chip RTC")
Reviewed-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Cc: Yiting Deng <yiting.deng@amlogic.com>
Cc: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-amlogic@lists.infradead.org
Cc: linux-rtc@vger.kernel.org
---
 drivers/rtc/rtc-amlogic-a4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-amlogic-a4.c b/drivers/rtc/rtc-amlogic-a4.c
index 123fb372fc9fe..50938c35af36a 100644
--- a/drivers/rtc/rtc-amlogic-a4.c
+++ b/drivers/rtc/rtc-amlogic-a4.c
@@ -369,7 +369,7 @@ static int aml_rtc_probe(struct platform_device *pdev)
 		return PTR_ERR(rtc->rtc_dev);
=20
 	ret =3D devm_request_irq(dev, rtc->irq, aml_rtc_handler,
-			       IRQF_ONESHOT, "aml-rtc alarm", rtc);
+			       0, "aml-rtc alarm", rtc);
 	if (ret) {
 		dev_err_probe(dev, ret, "IRQ%d request failed, ret =3D %d\n",
 			      rtc->irq, ret);
--=20
2.51.0

