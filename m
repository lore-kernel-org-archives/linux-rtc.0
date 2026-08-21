Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B303F4156C2
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 21:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787346717; cv=none; b=NYLrGNMOPCjfaCZiK/JAiLRZzHjCtw45aKKuzwy5WvdiQHLxtdCUjoqOfLejpjhoP27OQO2rzcFRkc4A+NwxeGAGExx9hwojtXzdheZv6Xt6qiaM+pEdGYOWD3r9cbAGqduKj308oXwf87q7HKgq4J/iB1vAdlaHqrY2K98jvHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787346717; c=relaxed/simple;
	bh=d2UnVodaVm/N8lN47MQEhAtOqQObzsirhygSI9irOJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNeAxw/+j2zAoWBmqzQY27xhueijC9Oy6552HRqZCZF5nt9AJW5HQDZOSmWHHPNZybLlvGAnNoAKHsa8OKbH3E09ywKLSik1RaubxdG3H0e0xmlj/wJqE8jN//FGij2ShIO7K3bTdIrIhTWO2ph6x6xLYt03BIPee797FJ7l3Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7tgj6cS; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7tgj6cS"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso1185869a12.0
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 14:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787346715; x=1787951515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Os1dA2r+cmzBxD6OAoS0KdmNVaKSS6rJQ9hDdA7As9E=;
        b=b7tgj6cSuYFsr1UjVkQ7jii/OaDU5B6VZOPl1CUinsNF2FSrETN0vWxrYvEZfvvIv1
         h2VqNL5qDze46v/JTZuhDGH6qAQnf3GwNyvoY/oZaVyvk4kT/dprZaD5McSWXXjKHXgg
         zT0jn+c9EquF4YnIxzfZKa2eieTEXimmCAP8BLDe/FauUJ1hrKf0EJZ9paoUznIp+Xz0
         7gwwLf7/LTDKofGR1gD8LbE65KS1Nsrjxskp6BYDMSAhSMlJTPghc6eQXZuo/H+ecOVT
         60g3jtggO5cY+2eZ/HPOEdb3Iyqiwxw5e9DS/59MMnc+FX94pmi319z4kMGjK3Pk3Alg
         7hbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787346715; x=1787951515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Os1dA2r+cmzBxD6OAoS0KdmNVaKSS6rJQ9hDdA7As9E=;
        b=WpFwW7DWO+Xc3uJDA5QtDRSeNXAYS7XJevmGUwy9hmXOkfcTSoIYXbcTZwqc3XZl/7
         dj3Gs5Tp3ruOx+oeLN7zU008qNpO8JuiJfbIp39MUfDVL8zu1o5D4Iwt3zqRgPsQQIZW
         Vvvll8geTDI86zAF5TEa9YirGPk/Tu3eJ4mWJ8eYeVF2DZBNW90v1fSj4FjL71cT5sfB
         yHUz414EYhu2H8MENmPd+KU7FUK8QrKL+Qp2ZrAJWJqqI5U544sCQpz1M/bKUWw9lULR
         /QeHPX4GGm7HVoWAlu+zv/6wsRh9/w8B1dwDz799jb7OdKcEXvfGm5RsjeQ/q8Hzeqqs
         GF0Q==
X-Gm-Message-State: AFuF++kVew5773/G11TORD6FE9GKA4iLCemaASc34VTa8CLVityCiNr+
	jUTB/hQBpvw9epmprkVU/oBLqsT9MK/Hmkp6smnHUWWBmDju3TFF3G97
X-Gm-Gg: AR+sD13abKqbbe8jEdf3uoK7SqbuRngyCveTE0TNLCIVUU0nObXPVvV1oLTpOhbZD5w
	F/zNXr55hiS7PpVLqXwU+rmaXfNWVEI9UaErZCAiilCk4BCyka8qafJfYXYlxlyYMOnkokSbB4X
	5tfvj6CitkiBYkXsFRdLG9bmQdNlT936olvlkd3r3CuPq78qaSgDxhswM0zzBUabdSXgRGUjL3O
	hhIWaCaQrCVFqHFrEng97EQ7My+D9npVIOO0hH6DBS4yt4S88CUbKMEECpAmsSWdOHTt0VOCCoJ
	P//Xepygocrs7kt3mdOedd+OQAMu2HR+R20S+Xe5MPnkNovntfDN1cz07HX7uZ1EeYmk+6K32K7
	ZbeaBp/wT2gETJ/nvBKk7d7aVTE8G7eb7qwjRB4HFkIbdILv7U8+gOdHbR7WuqiHkR+3+Agjpm+
	RtQmHYIV/bJkgrAGfkV7HBaBYLOQXHWvrm+qnjaC5Vdlu9It+oi1a3KBJ0LZn+xTmNMHH94Hql2
	l35TuURoqIpc1GNcvaPYazTwGkn+wJWsSGDwuZNeSH3EF48Jnmcm5xmmUb4r1TtHP7Jq4rE
X-Received: by 2002:a05:6a20:7f92:b0:3c4:1c9f:d81 with SMTP id adf61e73a8af0-3cd4ba456b5mr2824576637.7.1787346714895;
        Fri, 21 Aug 2026 14:11:54 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:194c:dba4:ea1e:d7d1:affe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf175399sm49755257eec.26.2026.08.21.14.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 14:11:54 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
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
Subject: [PATCH v6 10/17] rtc: rzn1: Replace remove callback with devm_add_action_or_reset()
Date: Fri, 21 Aug 2026 22:10:25 +0100
Message-ID: <20260821211032.13554-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Simplify the driver teardown by registering a managed cleanup action with
devm_add_action_or_reset(). This eliminates the explicit probe error path
and allows the .remove() callback to be dropped.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v5->v6:
- No changes.

v4->v5:
- Fixed conflict due to moving the pm_runtime_put_sync() patch prior to this one.
- Added Tested-by tag from Wolfram.

v3->v4:
- Added Reviewed-by tag from Wolfram.

v2->v3:
- New patch to replace the remove callback with devm_add_action_or_reset().
---
 drivers/rtc/rtc-rzn1.c | 56 +++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 84ec8dc397e5..f90785827945 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -385,6 +385,17 @@ static const struct rtc_class_ops rzn1_rtc_ops_scmp = {
 	.alarm_irq_enable = rzn1_rtc_alarm_irq_enable,
 };
 
+static void rzn1_rtc_disable_hardware(void *data)
+{
+	struct device *dev = data;
+	struct rzn1_rtc *rtc = dev_get_drvdata(dev);
+
+	/* Disable all interrupts */
+	writel(0, rtc->base + RZN1_RTC_CTL1);
+
+	pm_runtime_put_sync(dev);
+}
+
 static int rzn1_rtc_probe(struct platform_device *pdev)
 {
 	struct rzn1_rtc *rtc;
@@ -422,18 +433,19 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	ret = devm_add_action_or_reset(&pdev->dev, rzn1_rtc_disable_hardware, &pdev->dev);
+	if (ret)
+		return ret;
+
 	/* Only switch to scmp if we have an xtal clock with a valid rate and != 32768 */
 	xtal = devm_clk_get_optional(&pdev->dev, "xtal");
 	if (IS_ERR(xtal)) {
-		ret = PTR_ERR(xtal);
-		goto dis_runtime_pm;
+		return PTR_ERR(xtal);
 	} else if (xtal) {
 		rate = clk_get_rate(xtal);
 
-		if (rate < 32000 || rate > BIT(22)) {
-			ret = -EOPNOTSUPP;
-			goto dis_runtime_pm;
-		}
+		if (rate < 32000 || rate > BIT(22))
+			return -EOPNOTSUPP;
 
 		if (rate != 32768)
 			scmp_val = RZN1_RTC_CTL0_SLSB_SCMP;
@@ -446,7 +458,7 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	ret = readl_poll_timeout(rtc->base + RZN1_RTC_CTL0, val,
 				 !(val & RZN1_RTC_CTL0_CEST), 62, 123);
 	if (ret)
-		goto dis_runtime_pm;
+		return ret;
 
 	/* Set desired modes leaving the controller disabled */
 	writel(RZN1_RTC_CTL0_AMPM | scmp_val, rtc->base + RZN1_RTC_CTL0);
@@ -469,14 +481,12 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, irq, rzn1_rtc_alarm_irq, 0, "RZN1 RTC Alarm", rtc);
 	if (ret) {
 		dev_err(&pdev->dev, "RTC alarm interrupt not available\n");
-		goto dis_runtime_pm;
+		return ret;
 	}
 
 	irq = platform_get_irq_byname_optional(pdev, "pps");
-	if (irq == -EPROBE_DEFER) {
-		ret = irq;
-		goto dis_runtime_pm;
-	}
+	if (irq == -EPROBE_DEFER)
+		return irq;
 	if (irq >= 0)
 		ret = devm_request_irq(&pdev->dev, irq, rzn1_rtc_1s_irq, 0, "RZN1 RTC 1s", rtc);
 
@@ -486,26 +496,7 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "RTC pps interrupt not available. Alarm has only minute accuracy\n");
 	}
 
-	ret = devm_rtc_register_device(rtc->rtcdev);
-	if (ret)
-		goto dis_runtime_pm;
-
-	return 0;
-
-dis_runtime_pm:
-	pm_runtime_put_sync(&pdev->dev);
-
-	return ret;
-}
-
-static void rzn1_rtc_remove(struct platform_device *pdev)
-{
-	struct rzn1_rtc *rtc = platform_get_drvdata(pdev);
-
-	/* Disable all interrupts */
-	writel(0, rtc->base + RZN1_RTC_CTL1);
-
-	pm_runtime_put_sync(&pdev->dev);
+	return devm_rtc_register_device(rtc->rtcdev);
 }
 
 static const struct of_device_id rzn1_rtc_of_match[] = {
@@ -516,7 +507,6 @@ MODULE_DEVICE_TABLE(of, rzn1_rtc_of_match);
 
 static struct platform_driver rzn1_rtc_driver = {
 	.probe = rzn1_rtc_probe,
-	.remove = rzn1_rtc_remove,
 	.driver = {
 		.name	= "rzn1-rtc",
 		.of_match_table = rzn1_rtc_of_match,
-- 
2.43.0

