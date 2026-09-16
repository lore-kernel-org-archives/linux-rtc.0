Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191F84D90BA
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554342; cv=none; b=jWaJ49bSYtsWbHYk9NmJQ5VCJ6urvPhjB8TI3/qc460WNlW9Rukh91KuwxN13JQlyFPa9ZO3EThELR6zANMRcpSPAwygXoQXf7KpGKH3YeKSGWOLOlYUAaQRK06TrxIzocdSgADjeTBBlo61/ZaL1k9hmEf6X+i8wTCq6UFDuGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554342; c=relaxed/simple;
	bh=j9v7DkGfpB4zGAwndCJ1McVF5cfElSugk5pjDEYvNr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAhoLxjwNDavWaJL5d8RefKzfKtSJMhXAgnAUQU5onhcrxk4YrXVKcy+GS77bJk+f5sS6Ta1pSqguJaqLfhKaKyj5n1PkVaC13bAdTR8aEvcm6LL1zgFWATaJeESvSC9hjPiQ0SK6lADY4apDvlVzCI9lrCE5isyaUHTjWhXT6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=a7XvOaV5; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="a7XvOaV5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=mVCe4GYcnfFzfwKQINJLnliob4JI5t7C6E9IUFzIfpM=; b=a7XvOa
	V5HnqsxN8aCBWaMmeLbs0QW6cVd0aDNBh065vDMZ33zsIdf2rorrhY8rGgcMKVcS
	VJD8pcUOUrz3qmA/YQBsFVM1qvOh/yBgWg1s8C+Jr/u3m3TUe71xpJc1tzZZLrsx
	oFcI/GYCpyadJVijktZrcuxCUytks6dOMR2HRYkdyGlA13uPFcqumD4TTi3TZsV+
	7aR6B+nMwo/sru/NxF4nFzOsnVKDcxv5Y7PO69TW7MGu8nnZxtIwvFI05/44zoqH
	0GWsBBN8Phd0DAalqWrhKakVgpnRJrx5V9lxCoh6EA1q5+RlkA00Hqj9VP2SWyY4
	vcEroNVZLrMEJBnA==
Received: (qmail 1502948 invoked from network); 16 Sep 2026 12:25:24 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Sep 2026 12:25:24 +0200
X-UD-Smtp-Session: l3s3148p1@9gvLFZdbooMujnt4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: "Lad Prabhakar" <prabhakar.csengg@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-rtc@vger.kernel.org
Subject: [PATCH v2 4/4] rtc: rzn1: add R-Car Gen5 support
Date: Wed, 16 Sep 2026 12:25:19 +0200
Message-ID: <20260916102520.24288-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916102520.24288-1-wsa+renesas@sang-engineering.com>
References: <20260916102520.24288-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In general, the RTC on R-Car Gen5 is identical to RZ/T2H. X5H is an
exception, though, because interrupts are not wired. X5H2 will have them
wired again. So, skip alarm setup for the X5H case.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/rtc/rtc-rzn1.c | 54 ++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index b9d69ebdd224..349288a07632 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -68,6 +68,7 @@
 
 struct rzn1_rtc_data {
 	bool has_subu;
+	bool broken_irqs;
 };
 
 struct rzn1_rtc {
@@ -396,6 +397,11 @@ static const struct rtc_class_ops rzn1_rtc_ops_scmp = {
 	.alarm_irq_enable = rzn1_rtc_alarm_irq_enable,
 };
 
+static const struct rtc_class_ops rzn1_rtc_ops_scmp_no_alarm = {
+	.read_time = rzn1_rtc_read_time,
+	.set_time = rzn1_rtc_set_time,
+};
+
 static void rzn1_rtc_disable_hardware(void *data)
 {
 	struct device *dev = data;
@@ -431,10 +437,6 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(rtc->base))
 		return dev_err_probe(dev, PTR_ERR(rtc->base), "Missing reg\n");
 
-	irq = platform_get_irq_byname(pdev, "alarm");
-	if (irq < 0)
-		return irq;
-
 	rtc->rtcdev = devm_rtc_allocate_device(dev);
 	if (IS_ERR(rtc->rtcdev))
 		return PTR_ERR(rtc->rtcdev);
@@ -503,25 +505,39 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 
 	spin_lock_init(&rtc->ctl1_access_lock);
 
-	ret = devm_request_irq(dev, irq, rzn1_rtc_alarm_irq, 0, "RZN1 RTC Alarm", rtc);
-	if (ret)
-		return dev_err_probe(dev, ret, "RTC alarm interrupt not available\n");
-
-	irq = platform_get_irq_byname_optional(pdev, "pps");
-	if (irq == -EPROBE_DEFER)
-		return irq;
-	if (irq >= 0)
-		ret = devm_request_irq(dev, irq, rzn1_rtc_1s_irq, 0, "RZN1 RTC 1s", rtc);
-
-	if (irq < 0 || ret) {
-		set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtcdev->features);
-		clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtcdev->features);
-		dev_warn(dev, "RTC pps interrupt not available. Alarm has only minute accuracy\n");
+	if (data->broken_irqs) {
+		/* All known broken irqs are on SCMP only variants */
+		rtc->rtcdev->ops = &rzn1_rtc_ops_scmp_no_alarm;
+	} else {
+		irq = platform_get_irq_byname(pdev, "alarm");
+		if (irq < 0)
+			return irq;
+
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
 	}
 
 	return devm_rtc_register_device(rtc->rtcdev);
 }
 
+static const struct rzn1_rtc_data rzn1_rtc_r8a78000_data = {
+	.has_subu = false,
+	.broken_irqs = true,
+};
+
 static const struct rzn1_rtc_data rzn1_rtc_rzt2h_data = {
 	.has_subu = false,
 };
@@ -531,7 +547,9 @@ static const struct rzn1_rtc_data rzn1_rtc_rzn1_data = {
 };
 
 static const struct of_device_id rzn1_rtc_of_match[] = {
+	{ .compatible	= "renesas,r8a78000-rtc", .data = &rzn1_rtc_r8a78000_data },
 	{ .compatible	= "renesas,r9a09g077-rtc", .data = &rzn1_rtc_rzt2h_data },
+	{ .compatible	= "renesas,rcar-gen5-rtc", .data = &rzn1_rtc_rzt2h_data },
 	{ .compatible	= "renesas,rzn1-rtc", .data = &rzn1_rtc_rzn1_data },
 	{ /* sentinel */ }
 };
-- 
2.53.0

