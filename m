Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444784;
	b=H9nXTJQk7bE4WHlm1SCxCpYk/2RM+q+u4aDDP+fuZWmZ829CYmG0sNn7J0i8H+h1h/9L
	 DtWDyomlvG4yioTAgoWySfopsL7GAEFFf5nIqvcaU/7EY06MrVNxrIHp+vkEvv53kVvpC
	 0djnZ91a04j6VJLkIXpygXxwKvh1v3W1fkINxFi4yhrPA01F9VxhT0wmpCEuMkHGfD0hM
	 XqZF6iWR08iOavX6NhjuFsednuw9esmly7VKDkiMGbrNasWKjMuySzYNNVoky7isP5JjD
	 B4QWfDXyBke52sRxpGt+5fI7+j12hTk/ABKoim/xW2PIbVqi4HxerHN2iXjv4A47seQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444784;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=qBxQYxKuGBQ21fvUZrk2h4HlHhEGKYtEVodKZiq6n6I=;
	b=sR+B0RL1ZLbpzZ4eL/i0DnhblPABcpnsAg64aiZU4Wkbx8BY8gUNdTt33EGgauOZGXEK
	 FeW9MZU31PfoA9VOt7m28ntCVVzB3MnS+B8lDqZZqlFMhMKa6YX9YGSucGaShGFur+EIE
	 2x4NfT5W0oR0UAhE9K3BXdjZUU8ndLhPZTfGtmRFz9qrIg0k9nzswNa7ISiSO1wHj0QL4
	 1vZepfalZU/n3rOQsb3C1+2/aLClWdUI8Ov11TnidE+JAR4IuB5LC4D9bbKMy6roMZ7xq
	 hIFxjyj3sHhH+9uRl1vulnPWZgsh4Fm7bBHBuUCdcHtdRE0GoVscSBfwxuTimWnF92A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=nKkXzUCx;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E943606A329
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E943606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=nKkXzUCx
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 155411A1253
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:19:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DEEE160582;
	Mon, 19 Oct 2026 21:19:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2C88910328C22;
	Mon, 19 Oct 2026 23:19:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792444782; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=qBxQYxKuGBQ21fvUZrk2h4HlHhEGKYtEVodKZiq6n6I=;
	b=nKkXzUCxw9bGp749jDRlWncmYfUZV9m/Ol1wB6Ub35/NocG5dHH3vlYgxjcxUEwBxgtr9d
	hz3g1Ztozl9H5lutUlKcpJToVX/KSN+ZGIBSsjR2Dp5TbeYerDWbR+BHIsJqHcIDGnzjwG
	9cxSq1lP6D8f8vULmbfvISA903BApSTarwXcDZa0D6k89ZZRhPHsoSr7ygV0h9HTwnoNI9
	3SRt5LBgx27TrwLQdqkQ9iZHXNcDzUCMv/JG+e9fjisEHpAhKCOpaO9rIPuuYoevdoyMA2
	Z4hNHEE1qQCgDqhduOgIs11f42MEK3gHK1Z2vUK50YXnBBPhgvb4uW/nkiWLSA==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/19] rtc: rx8025: use guard
Date: Mon, 19 Oct 2026 23:18:18 +0200
Message-ID: <20261019211827.126262-17-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-rx8025.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index 5eeaa929f3ef..2f2deb59cbee 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -180,10 +180,11 @@ static irqreturn_t rx8025_handle_irq(int irq, void *dev_id)
 	struct rx8025_data *rx8025 = i2c_get_clientdata(client);
 	int status, xstp;
 
-	rtc_lock(rx8025->rtc);
+	guard(rtc_ops)(rx8025->rtc);
+
 	status = rx8025_read_reg(client, RX8025_REG_CTRL2);
 	if (status < 0)
-		goto out;
+		return IRQ_HANDLED;
 
 	xstp = rx8025_is_osc_stopped(rx8025->model, status);
 	if (xstp)
@@ -201,13 +202,10 @@ static irqreturn_t rx8025_handle_irq(int irq, void *dev_id)
 		status &= RX8025_BIT_CTRL2_DAFG;
 		if (rx8025_write_reg(client, RX8025_REG_CTRL1,
 				     rx8025->ctrl1 & ~RX8025_BIT_CTRL1_DALE))
-			goto out;
+			return IRQ_HANDLED;
 		rtc_update_irq(rx8025->rtc, 1, RTC_AF | RTC_IRQF);
 	}
 
-out:
-	rtc_unlock(rx8025->rtc);
-
 	return IRQ_HANDLED;
 }
 
-- 
2.56.0

