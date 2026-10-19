Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444780;
	b=sjlcNagh4i8lHBmcqOsi5sACJNyoNGunbdZ+xY5Y85rl9vVWRrpKdEub4iqayQyTZcZT
	 ZuI08WVvNB+aVlATwbepqss0E0SCHvdgBdgIMXeqsq2nBDYGVvIm4NUQEm40aNi4luhoJ
	 TSAGdnkeVEedrIpdUmdWYlR2AoFWW3wrkK6Wulx2VH4Cya7QtPIeLApowfLw87HQ53JZu
	 Mu+dEl3iRvP2DagA5nAHlmm5ikCxm6MO+RV0bMyBuK//J93qrIIXUGSz84xl6UbFhr38d
	 tgxqXA/mtcvBuA0HJINC7d+2LExCwlpI8jZK/ub6pMhKP+y0hLv1b0xkNvRshXmk7gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444780;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=RBqo1UTEScQb7GoSfKb2w03koBStSMDw0Vj4TrMbixM=;
	b=yuamH1TBKCcEdwQWoAicxftC6PfjhvAsRK9b1gCvbVgjYJ5lCEJUK/vV4ARhkguGJo2f
	 nzZ2OLk4vcc2hiWtx1ehMYxdb+ptawFfLOGQpspu9ytL3Lum+87SWFJuo+03ZHtVvzr05
	 jpsHI7j7+m3nkoAzMkUdRBqX6zNf8a0ydbjLL4bPmVI/i9JyAzSpc8fPixiBANw/3YpOe
	 Zo67lG0MQiQRstQ8fFdHWayudPTyHolITYHiikau0LUyf4Yfl0a+rE5H6YfIEmsr1kxXi
	 ghS2FqlTZYSvxrVPMNphiOqSRCljIg6hpn5Ot6fNSfut7Vc+U9RQb7Jbj49qm3OWosg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=DQDqnWFl;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6C7606A32C
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F6C7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=DQDqnWFl
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1912DC5CD5C
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:20:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D658160582;
	Mon, 19 Oct 2026 21:19:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EDDDD10328C52;
	Mon, 19 Oct 2026 23:19:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792444778; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=RBqo1UTEScQb7GoSfKb2w03koBStSMDw0Vj4TrMbixM=;
	b=DQDqnWFl3UzkmSIyy6EsSwCIHPz8spKRxDrOQjUKPmslIkWgPJn9VN6wxJ+C98uA8+Xk5D
	97S5hj1FCyOpGiHsDli6CmAuumUh1n1r1oJVifUlllBnU/PkoGh2eFwsuRvDPVqof/LZjw
	4MYz09TSLFi0x9yL/IEpmpRsZiG1ExO+RlKk1w4qdPtohRShWdBSy1LzO5ksXc2ycOsovV
	rJrt6PVzNNQ36hWAhxQlH7mVtf+3soaCbtutH8qcij2CdH7UQIQilsKI4JtjVerZ0LKKUT
	cwZUpUVKSSm43sx8ntZZP9yMJqO+xtV7DSzg9e+SFYqVlH7m+1/FCi8r7pyzUQ==
From: alexandre.belloni@bootlin.com
To: Ming Yu <tmyu0@nuvoton.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/19] rtc: nct6694: use guard
Date: Mon, 19 Oct 2026 23:18:14 +0200
Message-ID: <20261019211827.126262-13-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-nct6694.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-nct6694.c b/drivers/rtc/rtc-nct6694.c
index 35401a0d9cf5..1cf9b672256a 100644
--- a/drivers/rtc/rtc-nct6694.c
+++ b/drivers/rtc/rtc-nct6694.c
@@ -210,20 +210,16 @@ static irqreturn_t nct6694_irq(int irq, void *dev_id)
 	};
 	int ret;
 
-	rtc_lock(data->rtc);
+	guard(rtc_ops)(data->rtc);
 
 	sts->irq_en = NCT6694_RTC_IRQ_EN;
 	sts->irq_pend = NCT6694_RTC_IRQ_STS;
 	ret = nct6694_write_msg(data->nct6694, &cmd_hd, sts);
-	if (ret) {
-		rtc_unlock(data->rtc);
+	if (ret)
 		return IRQ_NONE;
-	}
 
 	rtc_update_irq(data->rtc, 1, RTC_IRQF | RTC_AF);
 
-	rtc_unlock(data->rtc);
-
 	return IRQ_HANDLED;
 }
 
-- 
2.56.0

