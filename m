Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F178407564
	for <linux-rtc@vger.kernel.org>; Mon, 15 Jun 2026 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538510; cv=none; b=B5ldSAdxW7J7d1jx4X7oEQBCmtAsRun+8ZvYMhlhkcCoCrUzdt/3JlE56FPiVjOPMvddBDmpiMWnuo/f8kn/eKy8b1FM1+bqa2GVFROi/rbJJZmMR1G/ozcxsEW1Oohlkr+xTlLdSqcDKCcfssPzXGWrtwK5/EyHjxEb5Kg5lkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538510; c=relaxed/simple;
	bh=UCb4fij7psL6yYMNSImmg7/vXhtlGjp23JJjW7oL6CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gM8ni+inGEW6wTl8fSPLdwVUTwN3AinbI//uFppZuuZEQtv3CfQdzrd8U+Dq/GS1FwIiFcBeDpy2ZayVg9auI1vbPoITn6JIbob6zaZmK4VNcyVMGLNLAM6ESd8n8mkQwVEkNDjTyOg9KUxs2nFXW4hmUizuvVcM8MJyT/3DE5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmglHg0D; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmglHg0D"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49222fb062bso25542605e9.1
        for <linux-rtc@vger.kernel.org>; Mon, 15 Jun 2026 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781538502; x=1782143302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRKg5ST4VFAZZHfw3kjoGIXnRyq9TwBzRi7iadBRYbo=;
        b=AmglHg0DtS/4zMls6dZcbtQljFWSMewG+rpDWiNiBMnMNug39eHdotM23wPPc4tRvD
         OfWiwYplB8MuOq+gBwwjZrpPADYMjRBLXvKC+MMgFdXGCeXagbVZSed4ih9XbEu8DPYx
         IrapwvDgcfhEgV+kn1aCjd3DXegknzd6f2+pYbE4+nCZsWBFWKFcaAKOsh8487F1zWo5
         ldX7c9nvP8L9gb2oy05ksSUYXj5Xx33YP/eig+2NaQd9n81dLnFhBVvPR+Ogwuwf/G/2
         0zZVe1lqa3Nnew1B4/9fAI609FOfR1F8aYz0Sv+1/9ixYeGLEW/RUu6G1VYbL8aRAhK9
         n4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781538502; x=1782143302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fRKg5ST4VFAZZHfw3kjoGIXnRyq9TwBzRi7iadBRYbo=;
        b=sBHsh4MnQZi6U6yD5LFvoT/CoSHXQyO8MwbI8jdtUlHSxswwZn8UyvEj5414gVy4yr
         xR3apxoEwqY34cX5cA8B5qtREVYqPfC722uoyFIF9rJg08Z8Py0cZwKuVzfsSAIKt4w1
         dYXnNbiNJfnQTvOySKKoPCjtseB8mv8Hqd0kyhZlxJgN1R8+fcuoVX2c3dotTcXkhZbE
         kvFc7hEUWQiL94LqbmgC6DCTQKrTxxrBTGb0u4MnTVDT9C+B4w9BPTzHaEnqBj2DdlUR
         rTxG1/vr9+/mXo3mvCxKWQDt90ZHfv0XIRe+/C+MnZw0yJj5Ofxo1DATEWBiJAMQQA2T
         u64A==
X-Gm-Message-State: AOJu0YzyEzZTh9XraiLWfOlY7ZdWLEBE9mevQ7691jNb5OheJsrGDhfR
	o8y7J2bWEZIzPz4hjcCp0kzlQTdK1stFfgRCYEj7swuX65+QS8YO1GmX
X-Gm-Gg: Acq92OEywwd3Bmrlbfr57GqHhZAvnSLqP1muNA6uDUuSqQN3DCsR+Gh8J/ZNwM3K5Eo
	97WT26Y0bc2uVQ720eFP/PVZFAjzRyeDCaiHPOocoQFGPUiLwKa+5HCnlOp5SnsKKWx8RHt+7Ls
	N8imjLDKgD5sVTE8qnGCH8ZrBrFd5vnBFI5WDKabv7ptt+wz2sNA6sbeOj6NM1TtfjekGMokCQm
	JbM0ARZRf2GM53mPi6bomG1Pm6Z6c9aTZUYVdKIyzUJ2jSt4qwLZPiO8jPU585CQZPhIsuaeQML
	rX88nXu1M4NW1+MT29TFQbmJEMqu3RdtaPYF0JF8iQgCJUdLObk6jhgP+nsx1X5SRRhRd+Bypm+
	aM9zGQxFklbufCQX6YHR7i8OYVnu2wz4dhhSDtAwNYcoXYE7JEY70pgmxCl9ArxEARa84hYZIPC
	kjV1B2OMCBHnE/L9ny06+g/8TKS5G640Wlx7LJykcr+vCsMi9slyfWxhtL0vEQRvnXrxLG6C0Yn
	JL/Q0KNvsPUK0+m8vcpPAgfj71LBwXRrSu+
X-Received: by 2002:a05:600c:8b18:b0:490:e1a6:25d with SMTP id 5b1f17b1804b1-490ec4fb514mr177988375e9.26.1781538501749;
        Mon, 15 Jun 2026 08:48:21 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:1e4:992f:3ad2:4f2b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26434dsm36010995f8f.1.2026.06.15.08.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:48:20 -0700 (PDT)
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
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 03/12] rtc: rzn1: Fix malformed MODULE_AUTHOR string
Date: Mon, 15 Jun 2026 16:47:56 +0100
Message-ID: <20260615154805.1619693-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Fix a malformed MODULE_AUTHOR macro in the rtc-rzn1 driver where a missing
closing angle bracket on the second author entry creates an invalid format.
Correct it to the standard "Name <email>" format.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-rzn1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index f81d691c8b9a..866ff595188d 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -517,6 +517,6 @@ static struct platform_driver rzn1_rtc_driver = {
 module_platform_driver(rzn1_rtc_driver);
 
 MODULE_AUTHOR("Michel Pollet <buserror@gmail.com>");
-MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com");
+MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com>");
 MODULE_DESCRIPTION("RZ/N1 RTC driver");
 MODULE_LICENSE("GPL");
-- 
2.54.0

