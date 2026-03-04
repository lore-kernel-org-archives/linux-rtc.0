Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E064C394470
	for <linux-rtc@vger.kernel.org>; Wed,  4 Mar 2026 22:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772664838; cv=none; b=ApPKaYGI7jTHHQfFRzJt6YFQeqIzxzIed8qn+AgKoNXp57gdFIBvuW1arwgVNWlCUOL7cjHKTtaP+23UFndso0b8Cn/X53cqrPgCcB5GcOmRuOos/eeERbVHmsI14Akb5/KKUaq08CGBuPBzHyqHiJ+omMIs9p+PnMqi0nMRZNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772664838; c=relaxed/simple;
	bh=nIPc2gFEeOdWe9Jf0FKRk4ka8k1x2+L4/ixApaFAz1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i2iTNbvGBwICZzVUvWFY9Ew+rl8y8dWBM6UvMOk2VNf1uSm/UnHB4dS5931ACvSQwWqDJyz0hlBAOywz5cmyag6m6PsX8tpdl900fAosBT/eOfYXLUEXvRW2blAzvQtxNGjObWywg+87tRIdySwp8DVqUf/K/DN2jgBq0yrTG9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhK3uiKg; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhK3uiKg"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7986e538decso74354997b3.1
        for <linux-rtc@vger.kernel.org>; Wed, 04 Mar 2026 14:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772664836; x=1773269636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E45rulTPCYj9cqd8INLiszMLtxCYsLMuQe08qmhBNqQ=;
        b=mhK3uiKgffkNhVtXD131R3wV7m6RiFhr8j9QIMgKzvIneIGUexLegMpCplRXok7H4R
         PC1ru8/ECp2UaRGKbRLdzz773/F+nD7YZgIFsVpjKNNtzlbpEHxos5APSGlYHE5ZHhTA
         MRpz07XhssoVw0P5f5t3i6CgYJEPUTdNTih+fYO3Iz5Sc5PaaoZTP2VQv+K4IefkLg7h
         aBq7//3OvgWHsK+i/khCCWXZ//hVFeboSL/mLosXUDZQzwjbg6cvhC2gMz06tR5C0NUI
         gZrVDTjXt4vU81ttC8auiZPhgDiLyKuPObjkD5WGAdwNft+HC4gec2rlPSqbQKNZ2llQ
         iKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772664836; x=1773269636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E45rulTPCYj9cqd8INLiszMLtxCYsLMuQe08qmhBNqQ=;
        b=m067jY1IRWKv2iLcj+bmdrDrfmoYlxtVsueN3em4hqUra8NXt2XfMzRffun6HJOSCo
         KssKU/Z/JIAkOMSBUgbI34M0wUgbx280AhrJ+7xLqmk2ndF6zNJ1L7zsm+JYiEg35kUW
         y+H5wRqSQH0Bb0URztvH119flQCpapCj7FRrUKRhmYcvq6X8Fxr+hR69JChLGrJYLA8v
         G5avvjxtUsJLLclYdMdW++wIgs04pwQpEIUTur5MYy0GuP9KeslAXd2ikgl1z2HAyM3w
         DoobCUhtj22crXke7ggJlaudqnI2JJqnuuWWcZhUWv+IiWD4YUutaDrCIS+oEV/u0Fa+
         sbWg==
X-Gm-Message-State: AOJu0YykVzkZY3uMd7BwNnHklyb5LiWUVd9dxT7R6Vq4JVcpU8NoOo87
	e9WaSitPsb2d0IJpONQXbhTeOR5Co4rUPTQMkSGlMwzVF41JWtjW8jEcNWVYjzxIVRw=
X-Gm-Gg: ATEYQzzmk9HM+Z5WyRDDTbbwgheb19j0DNSX43zi/NCR13cSNtT8Fd+P0Fvq+M453Hg
	Z4pArJiHgGZkHNXZ5i5ge7lPdyTpkITyxCkNDtbXytb3VffJANpzwztUDJwv4NDILxf94C5w9mO
	cajLyg4mcLqaZK2byGEnDx7OYav5OOJJO8o8xmqOa2yCG6F7wgfPj04CiHNprLRsNzMMVgtxA47
	JAstHW9Q9SPULh3fsPsv24fH2HfPa1WIe3v7Qjgs63d3K4Sr+8ctyJfscUwgAA+SE7bTZSo7CTX
	RxWgMkZkB/Vsdp4Jwjt89bnvLvTqZSSROfizd6R9aiR6Api7gsZRL82R5hfWilE7jaPTGtSuJRh
	BVtmLtn1PPtaIolSKstxyL+L6J7DTFaEJRkpOQTjsn90BKEQTRQTXIw/+IX3jgDifJhMn0RGUfs
	d6u8p0ou093T2mCq6cxUWJfA1NIE/6nGqzIxekGk0L1SEb3ptvytzM2g==
X-Received: by 2002:a05:690c:46c2:b0:798:58be:3262 with SMTP id 00721157ae682-798c6cff985mr33425647b3.62.1772664835707;
        Wed, 04 Mar 2026 14:53:55 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798c97f759asm9454697b3.38.2026.03.04.14.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 14:53:55 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rtc@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Marvell Kirkwood and Armada 370, 375, 38x,...),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] rtc: armada38x: zalloc + calloc to single allocation
Date: Wed,  4 Mar 2026 14:53:29 -0800
Message-ID: <20260304225329.24510-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to simplify allocation.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/rtc/rtc-armada38x.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index 713fa0d077cd..245290ae1a8d 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -72,8 +72,8 @@ struct armada38x_rtc {
 	spinlock_t	    lock;
 	int		    irq;
 	bool		    initialized;
-	struct value_to_freq *val_to_freq;
 	const struct armada38x_rtc_data *data;
+	struct value_to_freq val_to_freq[];
 };
 
 #define ALARM1	0
@@ -490,18 +490,13 @@ static __init int armada38x_rtc_probe(struct platform_device *pdev)
 {
 	struct armada38x_rtc *rtc;
 
-	rtc = devm_kzalloc(&pdev->dev, sizeof(struct armada38x_rtc),
+	rtc = devm_kzalloc(&pdev->dev, struct_size(rtc, val_to_freq, SAMPLE_NR),
 			    GFP_KERNEL);
 	if (!rtc)
 		return -ENOMEM;
 
 	rtc->data = of_device_get_match_data(&pdev->dev);
 
-	rtc->val_to_freq = devm_kcalloc(&pdev->dev, SAMPLE_NR,
-				sizeof(struct value_to_freq), GFP_KERNEL);
-	if (!rtc->val_to_freq)
-		return -ENOMEM;
-
 	spin_lock_init(&rtc->lock);
 
 	rtc->regs = devm_platform_ioremap_resource_byname(pdev, "rtc");
-- 
2.53.0

