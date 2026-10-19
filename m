Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444725;
	b=rk2cpUTPn0Rwl25SlkLcNvFHTAgxbxEwXXvMjYq2BRr414Ade4Z/7M7WoW1vnLD/psKY
	 RoAlfOS7A3nx5x6Sk7wPdIdiPSNaAkX5qtvFQjc2Gf5mrf3Xg7Kr52dAt5icC3uf8cfjs
	 PqD1enohKSqpYl57Rr6H31FkOsxz2HDbjW4ys7HLUdQ1JTKKK/+Nu0yR6X0BR3DjzJO4K
	 hvlty4bXS6otUYeF2geaf/1TtqeG67E0JP1M9QUtUh2IWc5nDJ45hlFgks0EonRUmA5rn
	 XRFZIGPI3QFDmo/VgYe1/B4oOKME/jn+bAbfLV2kfgd1fW5YmmEcbWy90ryensGeWfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444725;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=erR1br+KTUL8BSxH8eJPmM4IbOdvr3KiMa2SS5dLq1c=;
	b=pNnlyZ9k83MGs3k4Q31OlIymjwbZYykVL8rtmJ5WKLHK0jIogrJREPZBqQk3nIvCfA4d
	 V7x7tRLjvEo5Bxajgtg1BJidYZaUFNA7pJ8fAX9p0AAAsQzCdQsQqp0bnhZ/VKmTxETCO
	 tJXTXcMRSm3MR7hyytJlhJIA2J04aBJcAw6Dgw9nMGGXuRuLBpLhI8J9076whL+89WRHu
	 xcFoSnEZQnKCjWT1mhj9/Z48fE1aXb/BBwPPgDUAFGNXyjG56dBeepDYfS0vnPbZyrLG3
	 WVseAy0Gbl38vEe8K66aOI5Lk4Zp2vDG6MTX6vtlDHvzsa8et6G1xIvp6nsZ248MxVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="XLwhA5p/";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D838C606A31C;
	Mon, 19 Oct 2026 21:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D838C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=XLwhA5p/
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4648F1A1246;
	Mon, 19 Oct 2026 21:18:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1425260582;
	Mon, 19 Oct 2026 21:18:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 19A0610328C52;
	Mon, 19 Oct 2026 23:18:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792444716; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=erR1br+KTUL8BSxH8eJPmM4IbOdvr3KiMa2SS5dLq1c=;
	b=XLwhA5p/Jkt3HCDKhY2ThPPZeo9uNUOTiacUXXXrY1W0hD2XA/xNm7oVDhzM2r8NHHCu6u
	XHANuuq5rgtt2zYHKMHhPvUG1qRGtmqYOiXcBYZP1enekmnZmHQdw5Mf1txaOXjJuoGeGk
	hIixnXUMOQThn6ouddCC+VXhk/g6IC1HCrZJOuOAwVuwDY70xozYQOaZGStEBHuw2dFUPQ
	1Wq5Ce6PomZWVzdNcbFWiq3biV2Ywmo99zs1+IRhaYX6jty2FmDr0PrtBhM3ETCriWePZO
	jo9s34N9UiOMQafKyPxeweCWPu95VMfEP0IFttzNUKECZj/KcRoiDdKW9rK0wQ==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/19] rtc: introduce rtc_device.ops_lock guard()
Date: Mon, 19 Oct 2026 23:18:02 +0200
Message-ID: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.56.0
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

Add guard class for rtc_device.ops_lock locks. This allows to simplify
error handling in interrupt handlers.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 include/linux/rtc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 0f43b5027235..169d93520dbd 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -168,6 +168,9 @@ struct rtc_device {
 #define rtc_lock(d) mutex_lock(&d->ops_lock)
 #define rtc_unlock(d) mutex_unlock(&d->ops_lock)
 
+DEFINE_GUARD(rtc_ops, struct rtc_device *, mutex_lock(&_T->ops_lock),
+	     mutex_unlock(&_T->ops_lock))
+
 /* useful timestamps */
 #define RTC_TIMESTAMP_BEGIN_0000	-62167219200ULL /* 0000-01-01 00:00:00 */
 #define RTC_TIMESTAMP_BEGIN_1900	-2208988800LL /* 1900-01-01 00:00:00 */
-- 
2.56.0

