Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280876;
	b=qXHtUb4z+Sx3igCgS6goG9Zb9UxHJBVQ07LgIP/jZ6Rc7mis/jIobwVAHj38qlE63s84
	 eIlMQVN1r87EJf4vncbAuib1TixlA5Ao+FuKIfVArZNXe6jkj4WcfaePYXp2HK/v2G0L6
	 gGFq+i+ysPHFOSoaZLiQ4xOKsHsirLo0m4Xo464A0aozxDGTZ5VvGeBaCQzd24sM9e6oS
	 hhYwXUcxLjGBf/5uMoaWCk3xex5+w8n0Ei0mOgvld/dMp7HtSE8l4Q/EbTg2i7zgxCRea
	 sN9r7GvuyM1CpaV40hMwYLM8Sgf3qoied9KDiDnNv2CzTCPjsdBYSDHQbTfXJXWoplA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280876;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=c/IW5YFlvrYyvozjH5jg8RqF8aiR5amgVcH3N/Tmsj0=;
	b=ol/5b/7xcz4Adl07fVo50iegDYc6pyFqZWhNFfqeImGAUxCEPDjnPMdrG4yiB9k4DNQn
	 Xh+xS5RoRDdWKfvaIVrKZKaZfG+mr8FB3boz3CVbHD+dU5QtrKfKS7YgRJSWAG+V9cOy1
	 R7hcBvtAJ1bJs+0d2LaoASYwFRlwA1k2nR3W+KGKOkD3Ixp4unwdi9djEkk8kw7Jegu+J
	 ZJYcWQV5j7W3NM7dZO2nsPOafZushOCcf5p3PPLFSVgIDa9tbIcqzYwDS+EmAc8+AccuE
	 jqVkyapKcr+gh3b1msO0Z0eSOT2poqG78q+k/9VfBIgQgkf6BXmcGJbHXyXXqtsPNNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=trKuUWRq;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE73606A31E;
	Thu, 29 Oct 2026 13:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFE73606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=trKuUWRq
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9F0691A139C;
	Thu, 29 Oct 2026 13:34:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6CD5660360;
	Thu, 29 Oct 2026 13:34:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 931DC1032900F;
	Thu, 29 Oct 2026 14:34:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793280870; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=c/IW5YFlvrYyvozjH5jg8RqF8aiR5amgVcH3N/Tmsj0=;
	b=trKuUWRqU5L3LY3IttUQ/XyYe3IyPBzX1msURtVf6d/7wiNk+kr8i2oE40MpDkz/2nReoG
	zrCN1heslQhQT7OIcQljGA6EhO2ifSDNb3QzMgkDtMsZlnEASStHLK/A5t4k8azdg3fEcZ
	iuzaZFkP7HLT++YhSp07RJ+3VFXBm0g8nR0Ici9pWsKCa0JLVWtGSmrTSDsvtK03wmCMSY
	Xby1sFxieEt694CUtiC22Sd47vArylJ/h8NdgZaeHLqOX7/A4VxZus1mcKtUc0JsjyBMDM
	6XvnDMmGsB7q7RKttG2TYvGPnU/fe1v6J0TBM/bzFWid343SQGJedCBfnNmg/A==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] rtc: bq32k: use sysfs_emit() instead of sprintf()
Date: Thu, 29 Oct 2026 14:23:27 +0100
Message-ID: <20261029132339.925021-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029132339.925021-1-alexandre.belloni@bootlin.com>
References: <20261029132339.925021-1-alexandre.belloni@bootlin.com>
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

Use sysfs_emit() instead of sprintf() in the sysfs show callback
(bq32k_sysfs_show_tricklecharge_bypass) to conform to the recommended
sysfs attribute formatting guidelines in
Documentation/filesystems/sysfs.rst.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-bq32k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
index 573231613e52..0f50cfce88cb 100644
--- a/drivers/rtc/rtc-bq32k.c
+++ b/drivers/rtc/rtc-bq32k.c
@@ -210,7 +210,7 @@ static ssize_t bq32k_sysfs_show_tricklecharge_bypass(struct device *dev,
 	if (error)
 		return error;
 
-	return sprintf(buf, "%d\n", (reg & BQ32K_TCFE) ? 1 : 0);
+	return sysfs_emit(buf, "%d\n", (reg & BQ32K_TCFE) ? 1 : 0);
 }
 
 static ssize_t bq32k_sysfs_store_tricklecharge_bypass(struct device *dev,
-- 
2.56.0

