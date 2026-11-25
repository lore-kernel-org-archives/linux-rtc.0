Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591260;
	b=x1eXZ0YG8n9bId/uoazwbCW3EWoBtM8eqWHUc4Q0vIs3uU8gOmPsDT+8wCSQFjJpbK//
	 e+a8RCaBr3gCgvaai6lLYrduAowTJIFCv9rb+8n3hrLxqr6bXL0kyOVtt7u09VzC633RD
	 PDTb79iTGEXklbtTna9CYDRPKCxR45wgTBFbzmYSKXGQQZbAVdKO5q45Sg0AUtS7P/26c
	 3WpRYK9GstM/oTWkhGNukUAlXPLRO5GD9YRQDg+pnsi5jzbBsImviKlPraYZQmZdwoW5u
	 55MIerqulrvi/4Pa/H2J3vZ+mwmhupH5h19/dwboSmF0gzHtBp0NpfPlrMS0jpA1PUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591260;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=28HBpc6z3pdJfLP1GsH9qqmR3YhVH3gJc4zTD6MNBjI=;
	b=fcDo4ztyy+7bgktAqTOm649EhXtNu0vRW6I9i4PiC87AjOf5Ee65rypa/VCzhu08VdFC
	 xLysZKf8Ap0U9qXDoJ7K4WxLX1Hw0d7v+Ei2jSKbKrtS4/JoM4ZOBFfNkUJcIBbPZA6oF
	 s2Gk6FHkFR/xmhVS5+Xwfjhse/wCqLt6SlKOuN/WF64z+zGuktvUZtfxVEyjYfCv7SS6S
	 rNXTndfiw9IFTgvBFohs9jYrdR4xNlaM0k/KB5PB9STNXXwlaRgpRwU/GeIUlJGOqxOUe
	 limww6O4vhTzqNPzS+SboJAkUJZiQGUh6C0uePDwlHZSFmNowbjD0y7Po+BED7ZXLpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wm4WkDeZ;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA340606A329
	for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 07:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA340606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wm4WkDeZ
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3282db206d3so5045100eec.0
        for <linux-rtc@vger.kernel.org>; Tue, 24 Nov 2026 23:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795591259; x=1796196059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=28HBpc6z3pdJfLP1GsH9qqmR3YhVH3gJc4zTD6MNBjI=;
        b=Wm4WkDeZDefN4tOjVLuBkEbw0t/Fz+QBzUU51Dyhnp/QXA7ja8WHBsXx+x0hO2rAFS
         LPCGXL6wz+1NE4bNp3mXoPuM1u1Q6S/45luyN7HNm6uZxN7L5fIvx44gc4TsmM8VJ3qG
         FMR2wHLn1VMuGsL/KPn2wm1uoki7FA+nutxJwfol04m412rdvLKE2fS2BSy4MfGqxGnl
         LN8rcZRwh5P4HuHaWl2BZ5nF7ot5eCRwKkYDwQGUUyj7Au/9yU6s7RfKynnvDnEEyzug
         2qJdkDjsf3KO2i7zqjjRYyGMpR92Rb1cwD7gdB9ToCv/jtNCO3dcai5/+UQ401LtzqOD
         xLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591259; x=1796196059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=28HBpc6z3pdJfLP1GsH9qqmR3YhVH3gJc4zTD6MNBjI=;
        b=mTXxKsv7yOIf28pBfbMbe+KNe8+0ARBMeNbUVwKQWqSMY1H8C68HC+3qfftn86x4bE
         UXS9GnRUEmrY8wlIBxfJjKLq9sjbvK17+l86qPpam32q5Pm0cAR3o3sZ9ldA4FKSTuSc
         3eKerSS7YikpilDkH3wNPFbEi0YvwN4DRn8L7HJn+qjK74XCWe65D/vv0stADA8RmZLI
         7T+c0vrnhsEOSO+9VdH6s6Z3snYF23B26hYTCeXkTLpFNRAj7D4tYwrtc5TBWbLoeGLC
         aMQI3vl2Z7ApWep8Oe0P0WdkAlApZKXbKqvPl6fXVUKvzg0EoTiwi0WOgeJsAZHEGRn+
         4A9w==
X-Forwarded-Encrypted: i=1; AL+hErHNuNjSHlR1NvZD7WYwzk2ylYOawk1u/IKQVZ68hiTeSa+pOmaS5e82gDjNHvncvLs6fm8yK2e8WKY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pxY+6n8OSLe3f2vtqX6P95TEDJAzkMCVE+/saHJ6ccxw1qTLK
	SyS70QJbhzNXcOCqkKhtg1MtHHO3qepsrlCZYigAmUm2Oi0egQLyY1RH
X-Gm-Gg: AZFdTZfQnA3IH6cP/S27nnB644ZyGRMVDI0+kyKpWpjCp4uRYL4If2ePSMXxJymz8v8
	z+cSdCLLi2ODbfR2cbQXLn1ynOsaj97iEpramuWMD48rcFOrYM0SAZSdEOEzsE9HJ/mLcgZzVoY
	TIgRDv/+X5bohw7Xd9ZpGADD0EYn7fdGR7aKwQwfkwRXQAfy/u6Ji+Mtl1FpxbsNA1qSxEoX/wf
	U/c3pHdJCbDEgWm6EUSr689hrX3qhS1CEUOa79D4wVhVV3BJ+slsl/t5Z2/0GhRusqr+wrmDYmf
	/T9igPpH4DxaORyxIfnw7iptC/ILJnwwFappky2eFK/Yl+1eGmSEbr6rdxKPxOfgF0FYr8OmQnI
	7iOwqShbpsNf6NefEivJ3HRoxWdVK3uGfohvDiVUvRMLu0NHYPwKNfFpA7hTBXkY9403vbnkX9Q
	Y/3MrLyiDn9HvSd/m6scmC1kBIKG2CHiWZ9zNTN0OhJp5Sb4SNBzsCJ2DKJ4lqlZJ+0tNOjSvLI
	18OkvZ2YViCKDRo3qctUQHZ38mBH5M/7J1NwCknFA2bdNq3GvqFxr89vvCB951JtAiPwLfzVYS3
	Gd8UmhPjDVZdCJIN/2BEFQGs/3SkeLFNqLGJ5c+QdnKN3mY6iXIA49xOytFi5Jyx
X-Received: by 2002:a05:7300:f68e:b0:383:d3d1:f31e with SMTP id 5a478bee46e88-3856e94760dmr17054999eec.6.1795591258774;
        Tue, 24 Nov 2026 23:20:58 -0800 (PST)
Received: from prasanth.alps.lineo.co.jp (vpn1.lineo.co.jp. [203.141.200.204])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm42767121eec.25.2026.11.24.23.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:20:58 -0800 (PST)
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
Subject: [PATCH 07/12] rtc: fsl-ftm-alarm: clear the wake IRQ on unbind
Date: Wed, 25 Nov 2026 16:20:21 +0900
Message-Id: <20261125072026.2997493-8-prasanth.r@lineo.co.jp>
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
IRQ, warns "wake irq already initialized" and returns -EEXIST, so the
driver prints "failed to enable irq wake".

Use the device-managed variants so both are released on unbind.

Compile-tested only.

I used an AI assistant (Claude) to find this and write the change.

Fixes: 3a8ce46ce15a ("rtc: fsl-ftm-alarm: fix freeze(s2idle) failed to wake")
Signed-off-by: Prasanth R <prasanth.r@lineo.co.jp>
---
 drivers/rtc/rtc-fsl-ftm-alarm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-fsl-ftm-alarm.c b/drivers/rtc/rtc-fsl-ftm-alarm.c
index 5473f697d..565fd0df6 100644
--- a/drivers/rtc/rtc-fsl-ftm-alarm.c
+++ b/drivers/rtc/rtc-fsl-ftm-alarm.c
@@ -281,8 +281,8 @@ static int ftm_rtc_probe(struct platform_device *pdev)
 	rtc->alarm_freq = (u32)FIXED_FREQ_CLK / (u32)MAX_FREQ_DIV;
 	rtc->rtc_dev->ops = &ftm_rtc_ops;
 
-	device_init_wakeup(&pdev->dev, true);
-	ret = dev_pm_set_wake_irq(&pdev->dev, irq);
+	devm_device_init_wakeup(&pdev->dev);
+	ret = devm_pm_set_wake_irq(&pdev->dev, irq);
 	if (ret)
 		dev_err(&pdev->dev, "failed to enable irq wake\n");
 
-- 
2.43.0

