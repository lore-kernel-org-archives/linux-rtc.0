Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3B8411A10
	for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420738; cv=none; b=m+WYnT2ZHPwblrAlOKEzUzQZR+ts6ikUO7yf5gpU3AlpEzZY5DrWvH0OUIZ+T1EHIhnVP/VZUInF5HFKk4JTjekY7MNZ744eUvv9DxOS5zNFXmfeb50hE9tldT2rpm8DUnm3lr8yfRkeRtCG7XaE65NVHBw3Gq9FnwHx64rlVjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420738; c=relaxed/simple;
	bh=rzOQkXdtVDKhD1a+znviw++22mOL9V86viVU0oWyM1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UoxMnpqNdXeGvmjo0vpXhVu/G0+FLOu2KKKe0924jnohCnsveSY9p64JKuO6TL1H2zL7aeVp8JkZGfCoZF+AKXNjmRrWxM6fpdgMOMhkonnz16Qt2UnxIfV8CBfPrVt6A5hR43WIeSwnCvjP2tvvZugRKnOYVRfT0ajXqJJatjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=W+hgUgdg; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="W+hgUgdg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=EhRRke5CZubX9sZzElGqON9hdQ5Mjo1KISI6jkivWwE=; b=W+hgUg
	dgsHsQ1wUAN5H2c/+34pYJZJp196V3mXriiJ621PQ+IEk6UEE8Ozts9HfsGMxqm0
	8o3ecFuwnXdkSeA2vxHFXLZBKwPOYzJJmckz72zQtFAIzLTBEffQ0TBLrKl90uBv
	NV2du28GOgGDjFiwJHtdteZ25WKA7SGJiex6wlf7JiV0UfU0pUHVSABMRJDmvM+1
	WlVA3BJTHQ9aQg+bFC06HdCSYCsbhgXA9DyC/nEyyrRVtjPAuJ+c0xmpM/fS2N55
	KiTBnwqe58skxMc+FPVnS8CoFFeOkSChPVFId7pfd+KsYO78xYNRmMgDEtAuSTV0
	MxrvIzx15dgvEd0g==
Received: (qmail 892932 invoked from network); 14 Sep 2026 23:18:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Sep 2026 23:18:47 +0200
X-UD-Smtp-Session: l3s3148p1@qW7H+ndbjLYujnvr
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org
Subject: [PATCH 4/6] rtc: rzn1: make interrupts optional
Date: Mon, 14 Sep 2026 23:18:29 +0200
Message-ID: <20260914211826.73727-12-wsa+renesas@sang-engineering.com>
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

If no interrupts are specified, alarm handling will just be disabled. No
need to bail out. Instead of juggling with 4 different static rtc_ops
for all {subu|scmp}_{no_}alarm cases, a single non-static rtc_ops is
chosen which is adapted during probe().

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/rtc/rtc-rzn1.c | 58 +++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index b9d69ebdd224..ebb56c8d75ea 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -378,22 +378,9 @@ static int rzn1_rtc_set_offset(struct device *dev, long offset)
 	return 0;
 }
 
-static const struct rtc_class_ops rzn1_rtc_ops_subu = {
+static struct rtc_class_ops rzn1_rtc_ops = {
 	.read_time = rzn1_rtc_read_time,
 	.set_time = rzn1_rtc_set_time,
-	.read_alarm = rzn1_rtc_read_alarm,
-	.set_alarm = rzn1_rtc_set_alarm,
-	.alarm_irq_enable = rzn1_rtc_alarm_irq_enable,
-	.read_offset = rzn1_rtc_read_offset,
-	.set_offset = rzn1_rtc_set_offset,
-};
-
-static const struct rtc_class_ops rzn1_rtc_ops_scmp = {
-	.read_time = rzn1_rtc_read_time,
-	.set_time = rzn1_rtc_set_time,
-	.read_alarm = rzn1_rtc_read_alarm,
-	.set_alarm = rzn1_rtc_set_alarm,
-	.alarm_irq_enable = rzn1_rtc_alarm_irq_enable,
 };
 
 static void rzn1_rtc_disable_hardware(void *data)
@@ -431,14 +418,11 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(rtc->base))
 		return dev_err_probe(dev, PTR_ERR(rtc->base), "Missing reg\n");
 
-	irq = platform_get_irq_byname(pdev, "alarm");
-	if (irq < 0)
-		return irq;
-
 	rtc->rtcdev = devm_rtc_allocate_device(dev);
 	if (IS_ERR(rtc->rtcdev))
 		return PTR_ERR(rtc->rtcdev);
 
+	rtc->rtcdev->ops = &rzn1_rtc_ops;
 	rtc->rtcdev->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	rtc->rtcdev->range_max = RTC_TIMESTAMP_END_2099;
 	rtc->rtcdev->alarm_offset_max = 7 * 86400;
@@ -490,9 +474,9 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 
 	if (scmp_val) {
 		writel(rate - 1, rtc->base + RZN1_RTC_SCMP);
-		rtc->rtcdev->ops = &rzn1_rtc_ops_scmp;
 	} else {
-		rtc->rtcdev->ops = &rzn1_rtc_ops_subu;
+		rzn1_rtc_ops.read_offset = rzn1_rtc_read_offset;
+		rzn1_rtc_ops.set_offset = rzn1_rtc_set_offset;
 	}
 
 	/* Enable controller finally */
@@ -503,20 +487,30 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 
 	spin_lock_init(&rtc->ctl1_access_lock);
 
-	ret = devm_request_irq(dev, irq, rzn1_rtc_alarm_irq, 0, "RZN1 RTC Alarm", rtc);
-	if (ret)
-		return dev_err_probe(dev, ret, "RTC alarm interrupt not available\n");
 
-	irq = platform_get_irq_byname_optional(pdev, "pps");
-	if (irq == -EPROBE_DEFER)
+	irq = platform_get_irq_byname_optional(pdev, "alarm");
+	if (irq == -EPROBE_DEFER) {
 		return irq;
-	if (irq >= 0)
-		ret = devm_request_irq(dev, irq, rzn1_rtc_1s_irq, 0, "RZN1 RTC 1s", rtc);
-
-	if (irq < 0 || ret) {
-		set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtcdev->features);
-		clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtcdev->features);
-		dev_warn(dev, "RTC pps interrupt not available. Alarm has only minute accuracy\n");
+	} else if (irq >= 0) {
+		ret = devm_request_irq(dev, irq, rzn1_rtc_alarm_irq, 0, "RZN1 RTC Alarm", rtc);
+		if (ret)
+			return dev_err_probe(dev, ret, "RTC alarm interrupt not available\n");
+
+		irq = platform_get_irq_byname_optional(pdev, "pps");
+		if (irq == -EPROBE_DEFER)
+			return irq;
+		if (irq >= 0)
+			ret = devm_request_irq(dev, irq, rzn1_rtc_1s_irq, 0, "RZN1 RTC 1s", rtc);
+
+		if (irq < 0 || ret) {
+			set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtcdev->features);
+			clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtcdev->features);
+			dev_warn(dev, "RTC pps interrupt not available. Alarm has only minute accuracy\n");
+		}
+
+		rzn1_rtc_ops.read_alarm = rzn1_rtc_read_alarm;
+		rzn1_rtc_ops.set_alarm = rzn1_rtc_set_alarm;
+		rzn1_rtc_ops.alarm_irq_enable = rzn1_rtc_alarm_irq_enable;
 	}
 
 	return devm_rtc_register_device(rtc->rtcdev);
-- 
2.53.0

