Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444762;
	b=icAzSs6X5CxEb5nXDo/a05fdV7Wet0q1UHgTUMK3FzIWm/9J/HwEgEsQbGlpAdCPsq0P
	 ICWkod//rBgXXqRhp2opX1Xi9rIjqrCGFqbOFxgi8rZBXnrvcMhRF5wc6j3anwy1jBV6C
	 MxEBBcdfxQ1i93JsKb4DBFKFXueC+kPqPs2zovTJhOLNouJ7ugoqm5m7hrYnYvBb5nlnc
	 OHaq/HBFDZv45tWhx0iFvXjTVP0yrwaBIW26ijuQCKCD1/xFKZiokWofftnSzyNiXdKGn
	 gZr1XZ2IAqIAGurgWtNcUybC3Yx+TFmbR9sYLU8ilBx0CL/ulrhAytlAVLZ2DigL3ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444762;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=AcKQxhKC9aj1CzeOOI3+fPpZo7Qp9FIHgJahs9T+Q5M=;
	b=u2Bzkne/npMlV4UHCUft37XmxLgddAksFWF5sEX+MHvwztSGRJVYNslepoRO8xtnFkdt
	 17dpX11lkPnz8FuvYAJJQIwNiF5/67/Z/tJhy5FOZTfoQIDBkMRtPkx3/qIk9kFFek1FQ
	 l20sIWgNxlaqwIHUJy9YjFrZaUqIf0NDvhfpFqQmAHwUPFSsDuKqrv19WqjNZoQduTsCQ
	 oUL9fBlPkMW1cLehmErY5cgPaPWZE/pa1WYeWbTtRIRLv3QeK09WSnd7+ROtcdjREB/Kd
	 bOSWYfzsX0EtbACmd7MDSuujrPeaILzvFw7MnwtwhO+mHiHNlJDAspTEunO82VFds5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=UfL5a5cs;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EAE606A31D
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2EAE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=UfL5a5cs
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8C7FA4E4127B
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:19:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6153260582;
	Mon, 19 Oct 2026 21:19:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 88C0010328C22;
	Mon, 19 Oct 2026 23:19:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792444756; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=AcKQxhKC9aj1CzeOOI3+fPpZo7Qp9FIHgJahs9T+Q5M=;
	b=UfL5a5cs7XXvuL8b8Pi6e9M1qS7z4/V4AS6XVsfC845K0tRBlZwUwAfv0OItWJdiXf2IQ0
	v9MN4/oFH9EjYonTKiiAMKHojSqWZgy/+fGGGuHWhtaUi96QhYjA3xc5jmsX9KCCe72YyH
	kGRgY1bbMpK2KrysKuRGcj/kY9K/eZDbgty+SXBQCoXELDO02CYJoRat0No7lMDQlSVkKs
	lkgOBdidah+3IUJeFIjMBx4BXwV7Ba7F4kb8D7jAK6UV6nHflIwRv16JPTA1eUmd5e4V0i
	mV1C2FCqHYD+OGIfhMvDdV5NR/F6FgVaQ/OPybv17ZG+DnV+bK7wOmbGAyra9A==
From: alexandre.belloni@bootlin.com
To: Joshua Kinard <linux@kumba.dev>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/19] rtc: ds1685: use guard
Date: Mon, 19 Oct 2026 23:18:09 +0200
Message-ID: <20261019211827.126262-8-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-ds1685.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 5fc8e36b1abf..284815e5f478 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -666,7 +666,7 @@ ds1685_rtc_irq_handler(int irq, void *dev_id)
 	if (unlikely(!rtc))
 		return IRQ_HANDLED;
 
-	rtc_lock(rtc->dev);
+	guard(rtc_ops)(rtc->dev);
 
 	/* Ctrlb holds the interrupt-enable bits and ctrlc the flag bits. */
 	ctrlb = rtc->read(rtc, RTC_CTRL_B);
@@ -711,7 +711,6 @@ ds1685_rtc_irq_handler(int irq, void *dev_id)
 		}
 	}
 	rtc_update_irq(rtc->dev, num_irqs, events);
-	rtc_unlock(rtc->dev);
 
 	return events ? IRQ_HANDLED : IRQ_NONE;
 }
-- 
2.56.0

