Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8774C4F5A
	for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643655; cv=none; b=i8+XY8DyG0jCrEeV7R4smS8biP1YVbWJnoCdHg9gthqEX01yg6VtXmobo1KI7p0Na8csmhb7Y0EyH/CbU9LfgnE6ELQ83Pf9/OE6IRdofUx56LDrWfwrixXNK5R4qwU4YnedtS4eOvC62rItehGzmFh1H45fQ5ERiiH52RhWSZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643655; c=relaxed/simple;
	bh=XZwo6yJnTh3K+fYtO+r0Pwt+uOrIMJj/zmPDwZU42vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAevZGRc0j6R8+ZZCuEyAmAIDIj//1Hj9tYsXnfE7Lh8w4m8AHncCtKynAWTgLDwIg0O1Z3B/hHw4dffY7fjMoSPGTP75CHobqnm7kSxZ4BTo7cMFya5IKvdKU4AvhtWgq1AfNXSfYomwEWXB3n6f1Oxy0I2hRyelPiTttXlrY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Vv7Z759A; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Vv7Z759A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=DAhxZkY3W8rK9KiVYdRKcltTWTYtRHfrGuZlgKupDAI=; b=Vv7Z75
	9AjYjL4LE1QWYi68XwtQ6L/tmFkjZXs3+BcYk6U1tB37zfVVFvKqlSiS0gfMblCU
	OpRbu41BEyL7SYRN32vMOkr7rNjckNG+bcq9EWwo+SfG74TcfSVZLLnMNWOo+61D
	pnHOgz1nuYKDxp67hy9vOZLrtzYtpvU+hhXOLY6hho7WQY9j5SWV8PLLqW7wf3kO
	KegUhmuxbmhfYkqdbzEZk1vAwHugFe4zaE7q1gb1BwGESFgF9gelr2p31odbfdWZ
	P1uLor0yKrseZV6fKAaQLx/6rNS61pACBY9XPXXqcL8YGZY9/BBUJE3B0IK5Pmpo
	5HXicdHVgr40l78g==
Received: (qmail 2005251 invoked from network); 17 Sep 2026 13:13:58 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Sep 2026 13:13:58 +0200
X-UD-Smtp-Session: l3s3148p1@fCZQ4atboNsujnsL
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: "Lad Prabhakar" <prabhakar.csengg@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-rtc@vger.kernel.org
Subject: [PATCH v3 4/4] rtc: rzn1: add R-Car X5H support
Date: Thu, 17 Sep 2026 13:13:48 +0200
Message-ID: <20260917111349.52250-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917111349.52250-1-wsa+renesas@sang-engineering.com>
References: <20260917111349.52250-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RTC on R-Car X5H is a bit special because interrupts are not wired.
Future R-Car Gen5 SoCs will have them wired again. So, create a
dedicated entry for X5H without interrupts.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---

Change since v2:
* drop Gen5-family compatible since X5H is not compatible with it
* added tag

 drivers/rtc/rtc-rzn1.c | 53 ++++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index b9d69ebdd224..855158da5f6c 100644
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
@@ -531,6 +547,7 @@ static const struct rzn1_rtc_data rzn1_rtc_rzn1_data = {
 };
 
 static const struct of_device_id rzn1_rtc_of_match[] = {
+	{ .compatible	= "renesas,r8a78000-rtc", .data = &rzn1_rtc_r8a78000_data },
 	{ .compatible	= "renesas,r9a09g077-rtc", .data = &rzn1_rtc_rzt2h_data },
 	{ .compatible	= "renesas,rzn1-rtc", .data = &rzn1_rtc_rzn1_data },
 	{ /* sentinel */ }
-- 
2.53.0

