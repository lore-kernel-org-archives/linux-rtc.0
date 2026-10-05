Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B7847DD43;
	Mon,  5 Oct 2026 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791198911; cv=none; b=bxfEEPhr9moZjBHu4IwftTvsTHsqGNNZMu+OUQJ/zA4VKEjR9TE4sFNvu6XIYOBOwYI/JdvgE04TiEf6qV1BCj9rEAQ6NcaYZcyavtPAn0zSEDonl0VIM/KASvpW9MHKmhLnNuPYuEwW5sP9uihNceIdUquvPI/rdxDth3b6U6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791198911; c=relaxed/simple;
	bh=h1sRPh81K0gmnAp4CqyqRchev54/wKCO69GbJvo5TQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fy8pa4XQBM+G5KUcPQ5J0UMm9snAS0cKg+rfaIwtmH+YUvrBr09/i4LchNGTk36Z9UocLRTA0meGt3cdHErH33llb4z4txVfU7rV2yKVzWXFKzNIkKW3eBHdmnc742hl47cmBWz0Tk95p6IQXPu6xRSTp4aIBtdeDGa2VCvGRLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nL0hJUpJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nL0hJUpJ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D27041A1165;
	Mon,  5 Oct 2026 11:15:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9EB61604FE;
	Mon,  5 Oct 2026 11:15:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A9E6210330776;
	Mon,  5 Oct 2026 13:15:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791198905; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=uMS1REwvUex7S66RvMiQUXgUMbhM5GP3fPx1du/oD7g=;
	b=nL0hJUpJpTdyv7epaoanzb+DkpQ1j3z8KLIA1xUbpCsiT8k8iMmPYtcL2c00awa+TAXdPI
	hD1MZyh8OGCmK9wg9Fghqr7IwcM5feDBmBRqEdKKbrRKBO2nsL1U9AxWDXhPupqDaeBqjo
	mGozKDwWtLJUAlx9cTUqCsfTLdhRDoOpaQEqy/F3E7ohFbhV/77hmGc8nv2c0Z06eT9Yvy
	vLwNgoX9WNIVbxc/b1JUAt/H1Vspl9NrpcebcftJ/34JRXNiNhFQtBFuQ6aOrLkLJwW263
	vO0TA0c1DfwQXzPYsoLiDvqlLbkMVd68H/um0xd+ccq2GZtnTbtOABLdTIvQuw==
From: alexandre.belloni@bootlin.com
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Linus Walleij <linusw@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Dan Carpenter <error27@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rtc: ftrtc010: fix cast
Date: Mon,  5 Oct 2026 13:15:01 +0200
Message-ID: <20261005111502.159855-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

The hour and minute registers will rollover before the multiplication to
convert to a number of seconds can exceed an 32bit integer, there is no
need to cast them.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://patch.msgid.link/20261002105946.8rdteIpO7uWGEcTlS65F8iSi4gsRoXi2kgq8FTSaDPA@z/
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
Changes in v2:
 - put grouping parentheses back

 drivers/rtc/rtc-ftrtc010.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
index b29c96be40f4..c66d4a85f23c 100644
--- a/drivers/rtc/rtc-ftrtc010.c
+++ b/drivers/rtc/rtc-ftrtc010.c
@@ -72,7 +72,7 @@ static int ftrtc010_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	days = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
 	offset = readl(rtc->rtc_base + FTRTC010_RTC_RECORD);
 
-	time = (timeu64_t)(offset + days * 86400 + hour * 3600 + min * 60 + sec);
+	time = offset + (timeu64_t)days * 86400 + hour * 3600 + min * 60 + sec;
 
 	rtc_time64_to_tm(time, tm);
 
@@ -92,8 +92,7 @@ static int ftrtc010_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	hour = readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
 	day = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
 
-	offset = time - ((timeu64_t)day * 86400 + (timeu64_t)hour * 3600 +
-			 (timeu64_t)min * 60 + (timeu64_t)sec);
+	offset = time - ((timeu64_t)day * 86400 + hour * 3600 + min * 60 + sec);
 
 	writel(offset, rtc->rtc_base + FTRTC010_RTC_RECORD);
 	writel(0x01, rtc->rtc_base + FTRTC010_RTC_CR);
-- 
2.55.0

