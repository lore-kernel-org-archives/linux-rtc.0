Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444730;
	b=BFUCmrUEZf5TUS2RVZB7rnASO4sySPBCL40aBAQAQuNViof/8SL77GmrAEtSjrAww4Vc
	 5oD7O+sDcvpq4Na6NW/MVaUCh3MMYqtnzNaFpp0ZkQozjRV7d+Y+T4mnZsRp9XfeRiEsp
	 i1FWDDvqTCNRYesG25LBNjO9PlAjH7ev8mlOrzG1s7S9l9RiqTogXWS0gJga+GAI0M5V5
	 zdkFbc5bZbld1GbaNy4C8rnxzuNcaV/QQuhWGDFzO9TccSI8DsgIu5snQRKY8QYzciO0b
	 /5ugeVHAys0fulUkBnYV7G595c3dG3Qf20ROEOqwxg1ci3Bgj8UujsZucjK2GL2ABkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444730;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=J//4qIzQNPDXQaDEozFWZXv7kTTt8kmxa1XPyOuc5VA=;
	b=hISQ1XgjJ3+ZjGieJ2WSrlE9n3D6kKdsKsQl53olm4UnqK8bt+CVYwqxVBfhjYWRyeYW
	 v2pfEVmDlQzXmOerolmQC7+sPN6vS66Tk4oXx8eDsSJ4zWW2+oI0y7rXshdJM72EGZH2w
	 Z4xgsnXcMANbK6WbG67OoAQJ2YbEc+Be7b+Gmw0+aY3VWNkmEpAb6ta6R55Ib4NwfPi3k
	 n1hDJislrHQ/GEgnWHeyqgx5va4txpDDNG8rHCltRsXeuxd1XuzYk6wy+mKuhm+7TgTcv
	 tWKp8EuyhleLT2UopsOzlNnQHEraXNqFM9MBR8BCn/lYXrpOciXDjj7PsR3c0vZ0fjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ShKqsu8g;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF1E606A31E;
	Mon, 19 Oct 2026 21:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DF1E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ShKqsu8g
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 90C94C5CD5C;
	Mon, 19 Oct 2026 21:19:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5916E60582;
	Mon, 19 Oct 2026 21:18:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6BCB010328C22;
	Mon, 19 Oct 2026 23:18:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792444721; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=J//4qIzQNPDXQaDEozFWZXv7kTTt8kmxa1XPyOuc5VA=;
	b=ShKqsu8gVDQXUYopVVvo5HaUxUBgKyKMPfJDsOwTZYk7BegHfP5caIx0+qQNt7TASwyu/j
	imYMfcsnry7VRtBjHAbfInOIE/hNelR4sw02Rlwh+rcs/cC3KWhb+mjTJLedAEroSW5zNM
	u/0ObHy5mg5JbybuKcR2d8WjHNvHYbHXNWI0+OUvCq+2Dz5bKS/U8oIhSNEtc8nFWSiRfO
	qur5+u3ZrrS+/2VT7WzYyjz++2euItMK4E2k6kpk820VteTZgRZddQLS5QMCjMpPsNa/9v
	Y18pciU9XsqLYnmJBTHWX69xoNy1zTE5K5A4hJdSs2yNTlYBmRYfgGVVINwIiA==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/19] rtc: ac100: use guard
Date: Mon, 19 Oct 2026 23:18:03 +0200
Message-ID: <20261019211827.126262-2-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-ac100.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
index bba7115ff3ad..ee9fdb7fb63b 100644
--- a/drivers/rtc/rtc-ac100.c
+++ b/drivers/rtc/rtc-ac100.c
@@ -529,12 +529,12 @@ static irqreturn_t ac100_rtc_irq(int irq, void *data)
 	unsigned int val = 0;
 	int ret;
 
-	rtc_lock(chip->rtc);
+	guard(rtc_ops)(chip->rtc);
 
 	/* read status */
 	ret = regmap_read(regmap, AC100_ALM_INT_STA, &val);
 	if (ret)
-		goto out;
+		return IRQ_HANDLED;
 
 	if (val & AC100_ALM_INT_ENABLE) {
 		/* signal rtc framework */
@@ -543,16 +543,14 @@ static irqreturn_t ac100_rtc_irq(int irq, void *data)
 		/* clear status */
 		ret = regmap_write(regmap, AC100_ALM_INT_STA, val);
 		if (ret)
-			goto out;
+			return IRQ_HANDLED;
 
 		/* disable interrupt */
 		ret = ac100_rtc_alarm_irq_enable(chip->dev, 0);
 		if (ret)
-			goto out;
+			return IRQ_HANDLED;
 	}
 
-out:
-	rtc_unlock(chip->rtc);
 	return IRQ_HANDLED;
 }
 
-- 
2.56.0

