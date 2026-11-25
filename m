Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591271;
	b=TD5app7ouzNrqEGvLgj769L7EwBILY8qIXl0aHP6aCqH8kh1w8CajVgRoK3BtS4/CBSO
	 x0Xcm4aJF5mxAc4zMLXAgVoljhCjnDmjevQ8x3mGNFwOObiG/HAr5beISoa7tSjJKD4Wz
	 esT8KIPurRuAQSEXMxAG4cwQwhdvIcIO6+YXx7eOlmoE8lwek/pbKHdKFeFSaFfhHyxDe
	 74fUBq9bYOM2BhRnaW3l+tEJ0yOc82QTZJR6KXxqmIkOCNLxf6KjV6ntlxUt/822KxJgw
	 7lyDTBlK9QdCguY3mu1dlThQvK4BhcalJznJqGXNbmr8EKu4uzGhP4ma8TYnRTA+I5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=F8GSEEYgk4hpHEtSF34GSLfYJQCwCXCGgSvUQtVjSv8=;
	b=yvR5KQFgb8dw3SEVCEo2cKZngD/VTovTmjLg/yfH735NXNn6YVFFPbjL2ASVqZdv8aXI
	 TfaF1LgtpJpGl8NeBKWhRwCXnNrJMgad+yHCq3ww9HNcPFoFQwIGhSEim9PhZfpBu+GwC
	 kykQB8CeXvjFHGmenc/sp6kviu3RUggJbOH5fttnurgKurkCJ+VDprS3FSYkDbmGTX2Di
	 LAZyrUdzUrW6G398yYfGOgwN2/qTbacLXo8KTV5A5OGaIKuZ+vURK/gPd64XudxLJ8PB0
	 kr6Na81cXhRwgcUUaQrH18wcknyalKE81EwYWpjjXHSEnKLHITQSLKMfwNbm1JvX8fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FPnHiGbX;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7F0606A329
	for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 07:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC7F0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FPnHiGbX
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-385d8a00598so8000469eec.1
        for <linux-rtc@vger.kernel.org>; Tue, 24 Nov 2026 23:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795591270; x=1796196070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F8GSEEYgk4hpHEtSF34GSLfYJQCwCXCGgSvUQtVjSv8=;
        b=FPnHiGbXxeUnyli0qXq2Pb2ib64pxHSwBmx1w371Iji39oJ19lgGKXlbXdylMK2uoR
         8VX2tcDSf3kDIu9p8XNDOwV1DC73b8MJX7OSpUpTeB/H8C+F0CZ1pK4StHU9EZzuCVdp
         terW37IC+bCzZm3C37kUUWVNjZakquNrt8+SnZlbIPozpTy1U+bnG6+gbycH46Um+6zq
         M5FgejBLhTd69GTUr36tqr77p0QsTQ23zBfX7lX0EWuhTTROG/qKGFcsG26YT0aMtGOI
         TdYgOyQkIi1+2Bm4QWPdsCeQlduU+qvwJ2qmMLSku2GdffuAN4J1uf6IhgTS4/+nTE4s
         bifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591270; x=1796196070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F8GSEEYgk4hpHEtSF34GSLfYJQCwCXCGgSvUQtVjSv8=;
        b=da44a9B07oX3mfzvK9ndUzfv1Qbz6E5l6jTKkDq2Uqvye7iiDq/2roeYKgFpersS1a
         oUUar2d3ggrd39gwPYCu8yTo3oIODMixohKLw9PPE2hdfr5YhcprxtN8NO4KLhtiJTnf
         P7sRyVut3rvJPGcM2vqeU9YwL/lXZPV5YAD/7K4FxeL6a/5Nw4YDiusKW7QWWIrGBMTB
         0ff9iky2wY9bvxcOuVf8QDgP2ZeLHgJfg8zbEqYYUuU1h42C/7BATfGcyDjkn0ZR5rYb
         jh1KdT4DU+wkX1/qS+3ai8zKQmtkH8/Dl+2IjQ9pruyXBMsGKAuuW8d4hS9OzB5Graia
         tOrw==
X-Forwarded-Encrypted: i=1; AL+hErH2t0cy7VScVmZbafMCeJ789mEkVnDh+zFslYtp2WT0tyQpvchyjuLnaXbguWAFE+dRCr+qxWSMIcg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/LpmfKGCeWDMBHP3XILLvifN3lXkLTfj38ucDp5ZAJ1jUKE1ro
	Rqm9IleT0JDguAK5q3qDf7KvLvXh+nYczG8Vydev+QPPnI1abf1Bdbht
X-Gm-Gg: AZFdTZdOz2Qi14BmV+7rJp7S6P7YC3xrWq3+mhG+00wzsqR5Fez34GQR4ujwJyvLB3n
	CTVmH+gYuCKaxve0H4ABxO2d/4fph+JOGEEiKLHXXESaqlB/NT0dIhi78PzUiT5MzV5Af60fjUw
	il4wyhmk+wgYTZLIXpeB2OTnNbqqHI6rR3qyKXO6uFmp8M08gdgQ0/7DcWQGFT2QMz7KW3hBWOI
	qB9DshgbQoD4VqD7p3kUN/7M15XwONhxJmJvAVVNDrIw5CJ6o0dR7tl66KWNC7RaTVNvj/Jxctx
	npZPd7dWTK13V7Fy2sxiu1ui6dLn63xhir/kS7clYWfiZjaZLuN6gBmY/6yUZkrEuvVpUwjXZ65
	E2kYXK31lwX6f/GU/2YMwhKq/2OEcf5An05xMgxtGUcDnaDvuRTOE1tACBx+mOWblvLu/lxHJQw
	Z7IavpioyiDPNRqZCjqo4IlYVYi36BPoaE1OAFY3LUZyJxtCczGBFlMDOsAAjbKJApgnI+vXq0L
	fMMFE0C8Flmpj053ao70tTEXvqR2ksKTgscV+QRxL/wNcETt8mxhsgxEAdqGrfmzzku+r3gF4Gt
	d4Hb3dc/kQt3BVDQcAcqYH50krVlORtdaeH+6e8U2lTkSuFjNpKU11KG6aiyzE6fqVdwEQUBIxD
	ajvsQO3Fk+/U=
X-Received: by 2002:a05:7301:4704:b0:383:729:cabe with SMTP id 5a478bee46e88-3856f8519ecmr18522481eec.19.1795591269843;
        Tue, 24 Nov 2026 23:21:09 -0800 (PST)
Received: from prasanth.alps.lineo.co.jp (vpn1.lineo.co.jp. [203.141.200.204])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm42767121eec.25.2026.11.24.23.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:21:09 -0800 (PST)
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
Subject: [PATCH 11/12] rtc: pcf85063: clear the wake IRQ on unbind
Date: Wed, 25 Nov 2026 16:20:25 +0900
Message-Id: <20261125072026.2997493-12-prasanth.r@lineo.co.jp>
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

Fixes: 05cb3a56ee8c ("rtc: pcf85063: add alarm support")
Signed-off-by: Prasanth R <prasanth.r@lineo.co.jp>
---
 drivers/rtc/rtc-pcf85063.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 819648619..909c96e5e 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -704,8 +704,8 @@ static int pcf85063_probe(struct device *dev, struct regmap *regmap, int irq,
 		} else {
 			set_bit(RTC_FEATURE_UPDATE_INTERRUPT, pcf85063->rtc->features);
 			set_bit(RTC_FEATURE_ALARM, pcf85063->rtc->features);
-			device_init_wakeup(dev, true);
-			err = dev_pm_set_wake_irq(dev, irq);
+			devm_device_init_wakeup(dev);
+			err = devm_pm_set_wake_irq(dev, irq);
 			if (err)
 				dev_err(&pcf85063->rtc->dev,
 					"failed to enable irq wake\n");
-- 
2.43.0

