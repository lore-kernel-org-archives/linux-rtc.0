Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591265;
	b=uVlFQviVAi1hh7HRf3WJgivislTCTMErck84oYw1Gtcjx8dI7vZ6cTfdCCp7A0Y6VwRK
	 +/9OnLNfYtRb/UvUF4eVvb+JHns9BvNzDktiAFv6qw9+L+SxTfu7hbjo0AmEfxEevGENd
	 /UVGnyLFJjQyFbgMxX58r6s1+n2i49uUbP1X7wXxfuiiJnTRCeB3Zn1HCt0uVWUkpj6pY
	 xA8JQGAtkAOaT347MqF964ZBKrD1jEhETEm422q91yDAMaAIWX1K0zymrJpN+/gMbFzHo
	 56dU1ctAf+JeW6hSXF2MkBo0ezzVGW2sjmi6vrw1GNrP9ZTdBQZzaf0081AjUB3VSxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nvNpguFZ8dgL57oZbzRJkOYpYD8+B/VysS9gBllwJ8Y=;
	b=dnVMfKeIpCh8tKBmx8zY8SGlbwfYdIAtD7J4qsAPcm/P7CeMAAi9eNCQpZFb+IDiMQ5J
	 4AE8j9fW6GqPn/PbEqoryhzL5Xx7MtTyJraA2kb/In8h619zD2chGWCt58Z+PjqdFTPIS
	 ptl0t0FNi3jtu8eIGKADU7+gfSRthY8ynL28E8SctCFDpeGf/m1SRrnUB3qFUNM7TTxew
	 4Xv4zjUVpD9V92l4KgikBRMyEfB2jHlR7vQH+BR4gwLgmpZDykDXtcuLNaFPvy8HwbOTN
	 p+IT88lUD5umqIZeGTPFN/mi4I0rT7w91ITqHdjeZXioqlyFq9nxsz9SmPJo1bmPI0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l+7wZ+uR;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10899606A31E
	for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 07:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10899606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l+7wZ+uR
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-386bd881d39so3833339eec.1
        for <linux-rtc@vger.kernel.org>; Tue, 24 Nov 2026 23:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795591264; x=1796196064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nvNpguFZ8dgL57oZbzRJkOYpYD8+B/VysS9gBllwJ8Y=;
        b=l+7wZ+uRMU5L9Y3iw9iR0vQ56PzFuAqOTVajti9f8T0P497l3uY0X71+HyaoHNJYlj
         ysqt3L/0+JFPMTmsBmKlRs+RvJZm2a9d/Tymcfm9lP0TMCSobeI7oVrlrSnMbHAelVen
         ENqoJLFmcOqPNac5Bd1+auEf/pAGwDXNq/DOJhAitri/XoFUEZoaulRMMZYqWCd8x/uu
         hhoa7kUOPRrwrurg9g5TkSeYVCfF9pyKV8VQldFLqwrNTT9cnwagOa/ySt9Amlz3ickV
         w2QcGokSWaEbB7cmsX1oNu2Js5qW3hfv8BK2+bKCDIhfcBDhVIujIvFzKwcT2fRAJE4w
         bwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591264; x=1796196064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nvNpguFZ8dgL57oZbzRJkOYpYD8+B/VysS9gBllwJ8Y=;
        b=LG2GTda1XTfaE8WqJzlRrbc1taoF6V2Nv1frMQKXOztWLgAejjWUbq5iSHTlDIBpM7
         +Ckk2CmRHN0uX3i2dxJTF8h9y3wrk9c5TYrUCTDgL08Dg+v5x5axpj8GreB9YvxtGTUO
         r61qdmxuguH6ReRI20zwo91PuDn+zf651EzK/pjZtsK7sJ1DeF0YdXWxcJb3w5TRH+q9
         z751cridZzH2tXw8XRH3RB7ake1NnYebEowGHeZMtReTk/WEmLwe1/zbpIV/cf+D5elm
         tXkhp+AbRUs03clWRDiGV6sObOuH2+ES6yGq4pp/+yyBPd1t9kiK8ha6gxiqSmt5LRfa
         +Fbg==
X-Forwarded-Encrypted: i=1; AL+hErEANpSQRQlEtzFipRfS0aS3htK4M7q6IelvNWGAL0rQA4e1tJLGwrcCK1I5fL1T5u43I233qi4197M=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qp5PQw199RHnaABd7aq6xuLJgR0HE/8dBq6qk1PZfnZttdsuB
	nPlQXwQbTQvQ2GvjQHxc7Pw/1qS33C7057Jx5kLXrgqJmsbiGrASyjlE
X-Gm-Gg: AZFdTZdR9RnMJuStGOchBXHCHiR9kf6FrkxSfERNIOIt+n2NgazBMCtyV4s1mFOJ3t5
	Y+GyScCqPFup5/AUmh9k3d6WUH0WxLI6bpGxDpaWsMSp2Klrhj4ujFDK0qCIT3ueHD6xEqlIJje
	Au1t34r5BXOMAWhC87w5R4RezNA/vWw5J/7+r/vOUsinx86t99k+ddG+agRUTKqmYlKHl1oeoMa
	mH7JnYm2r/Krvxin8YqbL30B/rQD4Ww2sH2j+3b1H9Hr6vXv5jO8ReqGgMrfSpyJ4+9lVvHKLEP
	1/xblKilpQmbaXkZNbSANYA2lw/5IjPfPzHi9LYU4+YP9P6buHRJ5ffswuudSES7YYKsNrXosQQ
	C6vv5M7S+WFS0ffv0m5PP/+EHzTrpPJkmp+URbx72REf7fq/YriAWZ+V0oq178yDzyj7IpU92Lo
	qDS25pR9+V1hF8rsgP+UevcC0xQdO3vN7BikhSpcsu9llq+AYBZP7cW8gwj8vkbeqioP+pNilkw
	MT/nkUEvlwVoE9a4TZWYWVn5txoSHKD/0+lIEZ4VsDRWiccJo1g/US1nzBRRT9SJ6Ov/799VUDR
	/xI4+YKYaVOAaLOm5OfUCmMHYk89H9Ji0zd3VR/BP/SZXYe8BRikiUvXwPknLRQO
X-Received: by 2002:a05:7300:5994:b0:386:a915:8b97 with SMTP id 5a478bee46e88-386a9158dcamr12709277eec.27.1795591264064;
        Tue, 24 Nov 2026 23:21:04 -0800 (PST)
Received: from prasanth.alps.lineo.co.jp (vpn1.lineo.co.jp. [203.141.200.204])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm42767121eec.25.2026.11.24.23.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:21:03 -0800 (PST)
From: Prasanth R <ragaprasanth@gmail.com>
X-Google-Original-From: Prasanth R <prasanth.r@lineo.co.jp>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Paul Cercueil <paul@crapouillou.net>,
	CL Wang <cl634@andestech.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	Prasanth R <ragaprasanth@gmail.com>,
	Prasanth R <prasanth.r@lineo.co.jp>
Subject: [PATCH 09/12] rtc: atcrtc100: clear the wake IRQ on unbind
Date: Wed, 25 Nov 2026 16:20:23 +0900
Message-Id: <20261125072026.2997493-10-prasanth.r@lineo.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125072026.2997493-1-prasanth.r@lineo.co.jp>
References: <20261125072026.2997493-1-prasanth.r@lineo.co.jp>
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

From: Prasanth R <ragaprasanth@gmail.com>

The driver has no remove callback, so the wake IRQ set with
dev_pm_set_wake_irq() and the wakeup source enabled with
device_init_wakeup() are never released on unbind.

When the driver is bound again, dev_pm_set_wake_irq() finds the old wake
IRQ, warns "wake irq already initialized" and returns -EEXIST, so probe
fails with "Failed to set wake IRQ" and the RTC cannot be bound again.

Use the device-managed variants so both are released on unbind.

Compile-tested only.

I used an AI assistant (Claude) to find this and write the change.

Fixes: 7adca706fe16 ("rtc: atcrtc100: Add ATCRTC100 RTC driver")
Signed-off-by: Prasanth R <prasanth.r@lineo.co.jp>
---
 drivers/rtc/rtc-atcrtc100.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-atcrtc100.c b/drivers/rtc/rtc-atcrtc100.c
index 25183331a..2c78192db 100644
--- a/drivers/rtc/rtc-atcrtc100.c
+++ b/drivers/rtc/rtc-atcrtc100.c
@@ -318,17 +318,15 @@ static int atcrtc_probe(struct platform_device *pdev)
 				     "Failed to allocate RTC device\n");
 
 	set_bit(RTC_FEATURE_ALARM, atcrtc_dev->rtc_dev->features);
-	ret = device_init_wakeup(&pdev->dev, true);
+	ret = devm_device_init_wakeup(&pdev->dev);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
 				     "Failed to initialize wake capability\n");
 
-	ret = dev_pm_set_wake_irq(&pdev->dev, atcrtc_dev->alarm_irq);
-	if (ret) {
-		device_init_wakeup(&pdev->dev, false);
+	ret = devm_pm_set_wake_irq(&pdev->dev, atcrtc_dev->alarm_irq);
+	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
 				     "Failed to set wake IRQ\n");
-	}
 
 	atcrtc_dev->rtc_dev->ops = &rtc_ops;
 
-- 
2.43.0

