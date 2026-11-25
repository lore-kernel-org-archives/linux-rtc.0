Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591255;
	b=kMJxN7ase8gybW7zY1Hoo7QeF7i3o8/hjBZQLMO9mGRSkfFcJQZNpwHw6Yo+xd+3RyAG
	 5PuDPtO/GxlE9VyXMqqddAbzARLDK3InkOwnnX9DUzILywU/VObQNOZyQc0AEMt0/NUmv
	 biFhj4PC69T26bebIk2xJcfSFutb1OH+Mi8SO5VnO5khOKZlxrFbbS6SbotWw4dg1BaQh
	 AVnExG5IeHs86ClzbWmr2VO9oj/qGY4octsDxGYBDxMs0X6JbP5y8lbYipa/+dADj1Imh
	 lcEZAphlm+j4iTFa5gin/X/PFzjkfQTbvHhbyMhBB6jb1CeWBRd+tjgHGbDptLZPSyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5F8HNE1pXchPLDdh5vD/VO4OIkLD+d4JqHGWbIQKRts=;
	b=NqmgDpVjp4ZGoGfmDYkr8U20tOygV20SOT/HRGjBylJjqogFaQmLB6VfQpkua7BpUpdz
	 k/h5+95xV8fW1Rwny/5XRlXgAJFpd6YHKuCHbjYhx/bJRpUo+gnRQWkYssUAiggf5gmyI
	 QP/Gn9zZ06os3ivZxTyikjDTj7b3fmJsK8T+sMNvYPj82YCsGqGXHrvzJkYUZITb5z1fN
	 bBP1KzLpY+85i9l+ywFyuFIlUdIA4SiergyJrKGnPejjt1w0DMkPKhS1R7ODk6ITwJIlR
	 WfNScjtLfw97aUQyubaaQC16uoHG4wa6rsDLMs8c3+oh5GbmR3LIDxNdVhBCxe2aK3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z+dT7Gce;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF5A606A32D
	for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 07:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BF5A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z+dT7Gce
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3866a784546so7243110eec.0
        for <linux-rtc@vger.kernel.org>; Tue, 24 Nov 2026 23:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795591253; x=1796196053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5F8HNE1pXchPLDdh5vD/VO4OIkLD+d4JqHGWbIQKRts=;
        b=Z+dT7Gcek3BaDrpZ2J1xdZYOhN6MUaO8yn+uBeXBhrpvjLQ1IcGWQq9y3MKVJaAAeP
         UninuSAJxjM2rbNeiDlNB7CRZPURpzChxqUn86ELHYo18n//4OsrrvcpWGwk//Y71Avx
         EojR4fYDx+YPRM4CZ7zjdTSRo20gROkIn7UgU1nImLthV6DjpAlrYg/b3kp0khaUkf6R
         kNpdun+tTCrrJC2TKBnCl+kujAgCEZiQ+dIUYKgbHS8Ud+dnOTHUfCojjHPFS+5guwb7
         iR4vdENBixDziY1EUk/kT1jMhWZzK49WMTHqB7PXl3X+tzYJwrOLE7ZWaH3HwIbM2PCk
         jJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591253; x=1796196053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5F8HNE1pXchPLDdh5vD/VO4OIkLD+d4JqHGWbIQKRts=;
        b=tn3RPZ/W+WH5sAa/2c6degJRBOJ4CXHCZtcNB9So9k8NgkdN1bC+BSkR1Yid8Hr3nS
         Zmy8gBWftpgVrqhq2+8PewjLkSOWbpL/hD5iGwsdsr+Fwpgyu4koyvSWw69bXqEukgic
         3bDzu2v/i4DSZKqTJCFXd/0ag5O0j9xfbwFJzAl1yoAzRalGMMHeKPvTlDz5AJIOBz9F
         16TABSadGzd0VQk2F4I/GwqwdfD5gcWgYTwWmDUCfM+piKw+i5CpCv0to+GZrbwBQOMT
         2wZsEBv/foOtjzbJcbhjDP3rrx7qmqxDyOAT3LxLG2SBtDzLks0G1C/79DFeZKTHyewp
         WSpQ==
X-Forwarded-Encrypted: i=1; AL+hErFUhLhgbiSnQTP55zYjUfhL/ww0qliiYK19+9P0tLLS4y3INj78zSzcPTAgzq7b66ZJ+BB9DxN2ZbU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/np1hdZ+jhPdOA/rgfL/JZ0R45+0nCK5Q/ymMOdXV9QZ13tDyq
	vUaAZeKlfK1F6bfNzyPeBMa4VDdOGcQklFxZB4jHqe6rQww6RN4/hIQU
X-Gm-Gg: AZFdTZfFGet3EyTXqaxWZGcZ3hA7CxB+eseCFLjrG2W2iEaKPD0X/oyAiieTA07xzHD
	n3nfsRDLeV0Ih8umQlz8hv+wBtiGuDFwhsVimRvblXn5gj6X6VWu1SBbAcuflFAEduWUzCBEIoj
	uRp5TxAH7h436Osq4TXyrwmpoYlRB2LiNS/zGXUM6EQI8ZJ0eaqIFU/LlRF16D4c8DxyPF2cThO
	wbDWULIzJzBwK+duEM9F+Y/FrRxHBMa2SXBYklYANfvYF379MZkrA4parwD8TtJnxeyQM5Xrr3q
	7eNC7Z44TI0OpJ8r1n2QiJz27UMAbh1ZX2oGuNZY+ThXd1wuGh9R4k/IXsQQlNVbAUPeNiglaQe
	oeZbwUqa80JV5i/4m7wWR/S5fgSHo+QgM/f+Ba3S6N9xJwE5h/Vq3JAoRZwgJTmLh5sffCAnIme
	HnngQWZdUbu5gNVSL4KNPO9ETuJnNej1zlvMcSWdxLRElNyxzpna1dWsiaicCznEUa+BTomI5h0
	JlBRKMl9ep4jXLRq6JhQo46+y9BAGddGzRgcjp+STrZkGDCG81HMW0daOwOIoxYn3Tr7iSMm4PB
	jLiieQ82+1D/gmAK9x1xDxb+G6/yt15czeN9UKmsxegpiZdrTbva18/U9TfCdTv6
X-Received: by 2002:a05:7300:88:b0:386:959c:11ac with SMTP id 5a478bee46e88-386959c141bmr16142558eec.6.1795591253408;
        Tue, 24 Nov 2026 23:20:53 -0800 (PST)
Received: from prasanth.alps.lineo.co.jp (vpn1.lineo.co.jp. [203.141.200.204])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm42767121eec.25.2026.11.24.23.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:20:52 -0800 (PST)
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
Subject: [PATCH 05/12] rtc: imxdi: clear the wake IRQ on removal
Date: Wed, 25 Nov 2026 16:20:19 +0900
Message-Id: <20261125072026.2997493-6-prasanth.r@lineo.co.jp>
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

dryice_rtc_remove() and the probe error path do not release the wake IRQ
set with dev_pm_set_wake_irq() or the wakeup source enabled with
device_init_wakeup().

When the module is loaded again, dev_pm_set_wake_irq() finds the old
wake IRQ and warns "wake irq already initialized".

Use the device-managed variants so both are released when the driver is
removed.

Compile-tested only.

I used an AI assistant (Claude) to find this and write the change.

Fixes: bcae59d0d45b ("rtc: imxdi: add wakeup support")
Signed-off-by: Prasanth R <prasanth.r@lineo.co.jp>
---
 drivers/rtc/rtc-imxdi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index 4066e32b5..a1afe84d6 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -812,8 +812,8 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, imxdi);
 
-	device_init_wakeup(&pdev->dev, true);
-	dev_pm_set_wake_irq(&pdev->dev, norm_irq);
+	devm_device_init_wakeup(&pdev->dev);
+	devm_pm_set_wake_irq(&pdev->dev, norm_irq);
 
 	imxdi->rtc->ops = &dryice_rtc_ops;
 	imxdi->rtc->range_max = U32_MAX;
-- 
2.43.0

