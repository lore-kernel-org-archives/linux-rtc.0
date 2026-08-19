Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573BD44A41A
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136033; cv=none; b=LzRNrmuyo2E1UXd/XsCEJYchiwg7iJHxMbiZOik75xIxe0jZ0p+NaiQcFC0M6RFECgy8cCB8pJOHNy1R0r2KDvvBVS5nXFvpApatijvDUCM+0z177iEM+vnLZrVCnBiqoytTNe9OUcCNQJ/hiM42GKQMgheFcWyj6CGqP7SA+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136033; c=relaxed/simple;
	bh=aTcOo0XibAPOtRvO+8kyvsr/qOC9+prnWMiglEoD9Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qafXQbn9uHznxV6ok9qjrxMTVoGDE+rWyLiB5dvrp1Z9xz/G/d9ka1ln6rM25F/4XYCurFhfMHCWChMfho1IlQXlev89tmCp4AD7Ftf6L8kPwu2oNmcOWnkIdsZVNM8h0Yt1Et709keNegtJvit7+g3o3Q59SkPF7Za0Beyu6Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeKfFoVE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeKfFoVE"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so9501395ad.1
        for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 03:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787136031; x=1787740831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XJmShcdu2pD9ZAClgzTisDQ5+0emOusWZQx2PntskkA=;
        b=OeKfFoVEawaweUbXWl9789KAjrlr2LKSFS4qCzHFOze0WWGrDO8EtLvADKtEbnmZZh
         k1NGNGAqFCjQkS8p0ZWC2nL2n4Nx5H6lUpw8A3vi8Dv9hqSy61Sk/F3AYkLDm4G/ROgh
         rDR+/zRnElveCejxZCGNm1Dy/7zkyC7eNRniMI0EvCdc4GQo72mFoeFzXL2wNEO1C3Ym
         KB7M4xe0CSaAtSxwp4/AwR9QQtrPQv2OWFLH3Dc3tlVPjynpToh3AuUTaex+47R6x3q4
         sXYYvmVnQQY2uRIIrSpn7ckm3GnFO4bqKJfZUGVX2UlxBhCD5/70rf8QcVLe77qMU/Iy
         hoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787136031; x=1787740831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XJmShcdu2pD9ZAClgzTisDQ5+0emOusWZQx2PntskkA=;
        b=mWSNQ+FyADTV1w3DaoLQpGMsAfo3qVikEFtq+GSIXXUMqfhi3Wc4lOgviY6rOBbTWM
         fmtUxB55wVVIB1c688jNJQ5A/TI1H2bjgp8bNUDT/LkVmpmIHU1JGgIOqt1Bbvww/oDf
         fHX8kBJOTXTuN2yfrGLC0Tl23jSNQzYHTmUvpANk8VZnKh/Q72m4NoZnHNetQQarvClT
         cbJJCRFgmHAFk2bD5X02oI92PZVK8ijVLMvY9FpdjJoNXOnK3GrzcZt9Rtx2YCApFMqK
         8oqnLv0P9w9KC4XoBQ7WcV+we2sfoctxPtSfKVh/jRAOuWqC+yBOXzNTzzvv+XvXiAvH
         Lsfw==
X-Gm-Message-State: AFuF++n39a+V2nw3lLAoHpQC+zWoiDVn/PTHlagCQaD+dZcOSQt4eWQz
	aZmLVjX1nLBXpRtJk15dyilUEI2QjVJSr8ejF3QzOy7E3mfoWfgv+k3l
X-Gm-Gg: AR+sD13g8DEB03LiJjj8wvFNEN/uVLD2gr5cSOUjZ1BqEeG6GjIfJcWs7MkvJIWyf6c
	Z6rAZi+D/5vZ+0/Kn6ktmhY9se7bJzECDEf8bndH3OGvOUInbTAlZR0PNbEwEbt2ImJe2NCRJbv
	KDD3ggvCFnCFYmBI2z554l2isieQ5saZAKozhnNlRoTpE1jQkhzsaWo+jwr6/3TNHfzdd0i4WK1
	mWHM/edhhlHKrdL9aF7uj1iNIX4bTpeKcO/N7ACtQW6nIF4iNSgF7xpOT5OaS4FSEaYcDOamMrD
	aG2V9D7WIcKxqU+BYEI3vzp9A1cX7MeHaS9MNzYU7no8sPX5oFoVL9O3pCoD1UgOy33X8dxUqfD
	Wyj/4C9tlgcSUpLEdmTGFaTl2CEIxspOaxcFN+yxdxaBU+TQ9pJk5BoDsuR3UDj+8jOb08LlfMF
	h507oeUScnYfVkribSM3iRS0znJ1zRsp5vmliiHl53ACLv8sl74pzAOR7SlAry1QDVKU8AjC7C5
	2qoK4HDkHCnS8hr2BdnK8bwWdQTDZgsN+Lc5QRqKcrZE6piKdmVtahLZK/iFzXz1LNy1zdeZJva
	/4lEOdtVAQ==
X-Received: by 2002:a17:903:3887:b0:2d1:1a18:4d0a with SMTP id d9443c01a7336-2d5fd740167mr64973755ad.9.1787136031538;
        Wed, 19 Aug 2026 03:40:31 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c07:efb3:a897:a9b5:e171:c935])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef77fc0sm11169630eec.8.2026.08.19.03.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:40:31 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 07/15] rtc: rzn1: Replace remove callback with devm_add_action_or_reset()
Date: Wed, 19 Aug 2026 11:39:18 +0100
Message-ID: <20260819103926.2136712-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
---
v3->v4:
- Added Reviewed-by tag from Wolfram.

v2->v3:
- New patch to replace the remove callback with devm_add_action_or_reset().
---
 drivers/rtc/rtc-rzn1.c | 56 +++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 94d592e88a04..da7d13337c0d 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -371,6 +371,17 @@ static const struct rtc_class_ops rzn1_rtc_ops_scmp = {
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
+	pm_runtime_put(dev);
+}
+
 static int rzn1_rtc_probe(struct platform_device *pdev)
 {
 	struct rzn1_rtc *rtc;
@@ -408,18 +419,19 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
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
@@ -432,7 +444,7 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	ret = readl_poll_timeout(rtc->base + RZN1_RTC_CTL0, val,
 				 !(val & RZN1_RTC_CTL0_CEST), 62, 123);
 	if (ret)
-		goto dis_runtime_pm;
+		return ret;
 
 	/* Set desired modes leaving the controller disabled */
 	writel(RZN1_RTC_CTL0_AMPM | scmp_val, rtc->base + RZN1_RTC_CTL0);
@@ -455,14 +467,12 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
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
 
@@ -472,26 +482,7 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "RTC pps interrupt not available. Alarm has only minute accuracy\n");
 	}
 
-	ret = devm_rtc_register_device(rtc->rtcdev);
-	if (ret)
-		goto dis_runtime_pm;
-
-	return 0;
-
-dis_runtime_pm:
-	pm_runtime_put(&pdev->dev);
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
-	pm_runtime_put(&pdev->dev);
+	return devm_rtc_register_device(rtc->rtcdev);
 }
 
 static const struct of_device_id rzn1_rtc_of_match[] = {
@@ -502,7 +493,6 @@ MODULE_DEVICE_TABLE(of, rzn1_rtc_of_match);
 
 static struct platform_driver rzn1_rtc_driver = {
 	.probe = rzn1_rtc_probe,
-	.remove = rzn1_rtc_remove,
 	.driver = {
 		.name	= "rzn1-rtc",
 		.of_match_table = rzn1_rtc_of_match,
-- 
2.43.0

