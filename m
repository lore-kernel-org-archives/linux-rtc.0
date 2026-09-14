Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB48E414428
	for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420741; cv=none; b=ue6LGwO/kypVXM1PQfNY5KxRe0Wa9lxxvytVdu+7T93yqtDuM1jzJeriEWD4ITayhSwpE6OnWu10QakDO/1dp/+Zt2Nif/hMC6sNKIbhZvDfD8gKzeaN93BmFbhbgOsIMGIkhLySE4265fGAZTRAJn138lfhO+FeryOJ4WKHI7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420741; c=relaxed/simple;
	bh=b99W4ESpHTOUw8n3WoT7xa0gdy4VpiCBo1LFrNgg+bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MD1hC6fHf90dfcEifoAeDiIYSVTBrGhFC1/aXbAqxoakPPDr/4Kt7tjBnqybhnAAC4Z7YhFKAXZnVDYgXziG6P1SPfqbM7eCfcJZZVsdCExrBzu5sQNIN42TlgcuwH8IYEwa8AgZR4owxPXEpjiPlG0RG8VFmqnJJWQpGeqlr9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=OMLFlhUw; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="OMLFlhUw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=3QrDRwUSCCz1aEdjrMWv3T8Wu6hvE/oA5jb6/DisrNg=; b=OMLFlh
	UwRmS4p2YHz+BbYn4zzKoilFKIHpJiHkq9OKJGipG1jhEK2h0BuYDvxXtgEGwaIv
	pt3pYikq+Q7hHk5UEhfcEfGjw9WffApbDJ0zbhj0Xaay2tBrB/M5hlxPpuBRCyJ8
	Ugs4wtdngX/0X5a6dCQo+8GS3sHR+kBpOpvNtjPWMy6gq8yBcizdeS6jGAhrYTzZ
	d7tTccqqDDhNycNDZu+Q6gCfIYNBDktOPL+GhjVuN+eyoTIxb3fOjdee4ld+et32
	zFoDtMgRqVHw3qpn7QA/BgvsiS/9QfmFUFPxF2njr1oan7Djgu2U1gfcTOVmjJsD
	h4S8i7AbYyDgwYHQ==
Received: (qmail 892967 invoked from network); 14 Sep 2026 23:18:48 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Sep 2026 23:18:48 +0200
X-UD-Smtp-Session: l3s3148p1@BfPa+ndblrYujnvr
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-rtc@vger.kernel.org
Subject: [PATCH 6/6] rtc: rzn1: add R-Car X5H support
Date: Mon, 14 Sep 2026 23:18:31 +0200
Message-ID: <20260914211826.73727-14-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914211826.73727-8-wsa+renesas@sang-engineering.com>
References: <20260914211826.73727-8-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/rtc/rtc-rzn1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index ebb56c8d75ea..4360e125632e 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -526,6 +526,7 @@ static const struct rzn1_rtc_data rzn1_rtc_rzn1_data = {
 
 static const struct of_device_id rzn1_rtc_of_match[] = {
 	{ .compatible	= "renesas,r9a09g077-rtc", .data = &rzn1_rtc_rzt2h_data },
+	{ .compatible	= "renesas,rcar-gen5-rtc", .data = &rzn1_rtc_rzt2h_data },
 	{ .compatible	= "renesas,rzn1-rtc", .data = &rzn1_rtc_rzn1_data },
 	{ /* sentinel */ }
 };
-- 
2.53.0

