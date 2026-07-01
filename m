Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8340B34C83C
	for <linux-rtc@vger.kernel.org>; Wed,  1 Jul 2026 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916216; cv=none; b=fQhsmC7ot6ylFex2fuNY9sLax/m8DXrdMCVmgY1V1pM4KF5SW0Gg9EtJNOaxpsNaggQZqIROhvOBCUr255TrAcyi3A9BdDjLoSOHlNKeLgapkx/ntISNbNgsW2N5joC38xBFo9w5jz5LC6k90Q55EDcmRCABpLd5mJd79a2iGx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916216; c=relaxed/simple;
	bh=OZkCdMx+rjplXJXoJyNaMuNBYl1kd2GTMziWSPNPsHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AORfpxYIJb23ufTC0x9fDrxHVerkinZOUZW8PqhvE9egSspKRm3KBG7RbxE9qMxH/znjEoZXolZR21xT0elIDsCzdssxKEs2zPPL2tab822GqKVKyFAwBzB/+GVGIIl8hXBXUOw9IRCwm5olfFumQn2+XrmrGhSSCNyfp5zK4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ho6L+XgT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho6L+XgT"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47248615e4dso721573f8f.2
        for <linux-rtc@vger.kernel.org>; Wed, 01 Jul 2026 07:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782916213; x=1783521013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0l3tUihLneFPrnWysYsFL0qPvzOr5P9+eaScNelAyF4=;
        b=ho6L+XgTZSpIVFZhRy6DeeDBiABpJVylcyEFeemLet60dqYTJ8w6szCEgu4mXPvYDI
         TbmZMPiNdItz7qLuCUFhe05IxAseSk3JDFPtgtsJNfrKi6Vf0szSjRojxOPknDQWm5gn
         VX2w1g44eMAPElRIx9YJXzQByEDwHPZRvbxXYdaH1/66OOcR/3omPPb3jQ8RLcrIYbCV
         2/QRaGij7uq4qeqJJURFshdL/WN8ISgjB/Lo+JWk7sMvYv/YpCi3NiTsatJ37vpEth5M
         3SBJ7rdX/evGQ5jfwwTCOz51LjUFaHgzkcI7XT+97L/GA6TD6svLkNxJSlXtEt9OuBSW
         IVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782916213; x=1783521013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0l3tUihLneFPrnWysYsFL0qPvzOr5P9+eaScNelAyF4=;
        b=Mn6SkQ7yVUrnU7G8S0pr0eNJYc1r4fCJzicSctKLeeWxFTmtmYv2YZMzot+44M7dVf
         T5uHnlMf367l7ssmbWQoupz4sjpelk9aD+BUfGSKURxSnyK5Brrel633bOUXs9Vy+moO
         e6dbOc5EIiyIR1ZCXqkL3MbAxX5oa6RImXh/4FQVSwx9l6bZF7ciIX3PvvGZYGOpXhMj
         XRVMjJIL9sKCny6j6jkI7E4p7XbNaJBeRdk4mYcULerQPpSDzUVapcLhX2Lj7gpNy64E
         Ze6Rwxz4rKbkJ4rmv7Za7klqeKVMwQxx+y4cDE769SsWnwrTB0I0mwKu7qWThnvBcXMJ
         jPbg==
X-Gm-Message-State: AOJu0Yw4/pDTL8vNaUUzGI7UMdTQpn7aL4m9C6F5pyrgGIfM4krYMlvE
	1V0Lpucx5O/PmYQqc5CyhtJr8lWFH3444ySVDyAE0CDD3n/i0TWOHnWB
X-Gm-Gg: AfdE7cm0HHmsw9SuBRj9dPkVyEpRxpmtzNX6Nf3oQJd6dwXYLjFRCosuwHHIomj+Klc
	DhZYRRqz8RpuEVjODzVUBJY3S2E/PgaBS8yunbkIFzu0IMFKGPGvXuLSoGP3sa691iaoePOfGXY
	QftuMrNoMadPPM2OjDpYUoh0l16ArNigpOy77NbFM/WAzK6haRyiPXIzTFrOKJp7v5yM5tbGYcV
	J5PuQ0Bz63LGahsFIdi6vIMQb2le5B1Bn8FCmUaWVB4DuxN4Ate3sHEfisBvwZ4lX/zxMvfH9HM
	s4GWUiZjZTTq6IeYZiIeR3w245Crqbgk0A73CuVeTnGW0pAfYTS/dRn5o9+oIyd36CO0k8xKKEH
	bar8sRbbtMITM3t+OgUhiu1gJharmfP0E103FSllxbfyx5HcDdS8BcOzoAqJ9xxQKb2SdmxD4ex
	mDgGTwiYPAF/585FZkHtIJ3Ea+80gLpTNINmUc2elCPZfPXrlG5NpixZd33L1a8aQnIRuwsSS6p
	lj7xKcJPKdX7Mr/ZsiLe1f9IFoRHGqKEiDp2g==
X-Received: by 2002:adf:e195:0:b0:460:64e8:2553 with SMTP id ffacd0b85a97d-47757e57472mr3171049f8f.4.1782916212964;
        Wed, 01 Jul 2026 07:30:12 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:5353:5ce3:a6a2:3b98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dd94c829sm184902f8f.24.2026.07.01.07.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 07:30:12 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 08/10] rtc: rzn1: Consistently use dev_err_probe()
Date: Wed,  1 Jul 2026 15:29:51 +0100
Message-ID: <20260701142953.2014895-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701142953.2014895-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260701142953.2014895-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Use dev_err_probe() in the IRQ request error path to make error handling
consistent with the rest of rzn1_rtc_probe().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v1->v2:
- Added Reviewed-by tags.
---
 drivers/rtc/rtc-rzn1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 4540d764edfb..f236b08e3ca9 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -470,7 +470,7 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(dev, irq, rzn1_rtc_alarm_irq, 0, "RZN1 RTC Alarm", rtc);
 	if (ret) {
-		dev_err(dev, "RTC alarm interrupt not available\n");
+		dev_err_probe(dev, ret, "RTC alarm interrupt not available\n");
 		goto dis_runtime_pm;
 	}
 
-- 
2.54.0

