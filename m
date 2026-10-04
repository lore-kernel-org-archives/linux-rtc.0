Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884CB2E975E
	for <linux-rtc@vger.kernel.org>; Sun,  4 Oct 2026 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791152011; cv=none; b=d3aKAhgt5cP4Vxmi4FbBwvJlIzN+x6D2uT9O6Xwybva+0B0ExUQX3pRTOZQUA3AII7y688XFAmpgdwkjc5NWq+pTGqLx/JejoSAmH8IrkwHATuJ7yilkeOEUOq15jT1Af0qQukGoclgMRoXNehMvDEBQZyyaKqkbD2fJ6wNc/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791152011; c=relaxed/simple;
	bh=Se8Ax4+TIBiCq3yGIY0Rj1lMt8PKeNTEx1PQrZt26lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ERAiJRUVJVk19762/qx4kDmD399z33c07DAHlUUezUAd+U8YMRT/PXmZeHpoO+K56iq9l7rF18oM4C+YwJtTE6VdyVi1UP4X8zP5GROaNU1wBuNBTxBRvk25lxV87WKaT+qhXNKfLLx6A5Q71lBvyI/90gcge/Qd6IeKizN522A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJyGsCJm; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJyGsCJm"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33bfb26865fso725244eec.2
        for <linux-rtc@vger.kernel.org>; Sun, 04 Oct 2026 15:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791152009; x=1791756809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qol00xKd0T0+apHbVQX4zHawmYMyVklpl08y4ubxCGE=;
        b=VJyGsCJmAY/BCKN4B0x3Dq7iQEg416pRnlTbpTNiPacNbpgBANQLItH9DvA6G3DAMe
         BD/nG061rQ0IwDvo1rynA9YedxI2QrciTeN9g9vL04JNPlVwXx/whUn08JEUgxKJs4Yd
         L8g5y6/sAi2QUhJ/odf3HxxupJtC+KH+M8pdZKP7t75O/399dj2dxlT9qE+tCbaffGoO
         ObYTFkmZZd/FRFUPNem9yJY3IQUYzNnQXvXQT7WY0c1hQfHEdOWkcIcqKhs8toQ7o0Ez
         Uu2dbVNRby1qkQ95cZc8jqRt6TBRhu9ma6rUeoULKbLAq/FXtaVRYXfJkcgR17k1wI1Q
         /96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791152009; x=1791756809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qol00xKd0T0+apHbVQX4zHawmYMyVklpl08y4ubxCGE=;
        b=ImzF0/TzgXoy+TMqI9VjT7iPqzcjetbifTszkrxa2Dofwz2ufge9dkVh3vqRGJie5Z
         fyh0XukM1bpyJPSAUITnKIgk6acvqJvFuDtUegbCYzlk3FGtIMPgPnMJVlmc1ZGzNaSQ
         wnRPCneoqmh022fbYlSLeCw69FUClDG3bxXUomqIFOb2Et1/nB2ytmw2L/PvOZl9aW4t
         DR3RiFoO0Rbksfhe4JE/b2TAzc7cczjYW5ahsRyDXgN5XO9iCYHPgGEOU3Cvvr9uk1iX
         zS4Ou4GVXZh+N3i/QiQ8G67rLWSUwsmcL4KuzVYwCTWV7BTtLRcT8zxQ8o//nIVey6x5
         iU2w==
X-Gm-Message-State: AFq9FYLfw4bY8+nnXXpyj107EI+K2VPx8VkSm10ETwzgbG6YIg47oiEv
	jfVyLEocL4TQpwUEQkeoAqRfvUj8fR2unPovWMMtN9pE/CzL9YK0nLppegrMMNTf
X-Gm-Gg: AYBFou3CySLNG3jrc3ChLjQW8MaFpZ0lljCsJwqDzV9o3nqHx4UiH57ax3O5ptQoDHb
	J1/oANJqz1ChAieFytpxO5NLlDD4Lur3p+euqIuR6tI9imM+e2P1dvseezrL3atSggO276HDyYo
	wzhC62O/JpI6l5ALqY2VcJsG9pQWDz8CgvZxHPui7ESNcobsdESo/ihl7xohyNYxmpiPOd9kDW1
	dWFZfqGdlEeyW/sNU087kYbRcSdsySIseUX4ex7utCiUVlP/guuqDWrOGl/jCZbHtwNY0SSjVw+
	KBAXTBxXzA68vOWCn9OErrsrK2Ah9ECP3Z0HEBvx1E4CUYOji+WTV9TEBBTK4jMRnAayRLPfmhv
	kSjvPM90qFpTCWLIB5CIxFDbpBeqkIe1o3PBsAlVWdMTLgDz+oUnLjz1GLpKZajJKzVQvAid25c
	EPvVXZpNWy4UWu9Kd+2dyC1MlGGb7d/I3NOBoIHA245QBkwnI4yJFO5XJmtn1UJnS62yzhHIGQI
	T/aGmlkvyaOPfCYz+2VmkHy0v5rgDABsi8IFTsk0qIM3qXWTeo3s5B0xgZm7IVKNCHUB4Jd0QJc
	NCosURpMvckxkll/M4bFgZdC+p49CH7OrIsoGQ4u0ZBduDT+
X-Received: by 2002:a05:7301:782:b0:351:1e72:735d with SMTP id 5a478bee46e88-3511e7277b6mr5112361eec.19.1791152009426;
        Sun, 04 Oct 2026 15:13:29 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3512718a18esm8976988eec.17.2026.10.04.15.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 15:13:28 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rtc@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] rtc: stmp3xxx: use devm_platform_ioremap_resource()
Date: Sun,  4 Oct 2026 15:13:27 -0700
Message-ID: <20261004221327.416323-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open-coded platform_get_resource() plus devm_ioremap()
sequence with a single devm_platform_ioremap_resource() call, which folds
the resource lookup and mapping into one step and returns an ERR_PTR on
failure, checked with IS_ERR() and propagated via PTR_ERR().

Move the mapping ahead of the devm_kzalloc() so that an error or deferred
probe is handled before the rtc_data allocation, avoiding needless work.

The fsl,stmp3xxx-rtc nodes in imx23.dtsi (reg = <0x8005c000 0x2000>) and
imx28.dtsi (reg = <0x80056000 0x2000>) each provide a single
non-overlapping IORESOURCE_MEM window, so the region reservation now
performed by devm_platform_ioremap_resource() introduces no conflict.

Keep the alarm IRQ in a local, as it is only used in probe, and fail
probe on a platform_get_irq() error instead of passing it to
devm_request_irq(). Drop the open-coded error messages, as
devm_platform_ioremap_resource() and devm_request_irq() already
report failures.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v3: fix compilation.
 v2: add platform_get_irq error check
 drivers/rtc/rtc-stmp3xxx.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index 7afcd14aeee5..9ddb4c0e39c5 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -56,7 +56,6 @@
 struct stmp3xxx_rtc_data {
 	struct rtc_device *rtc;
 	void __iomem *io;
-	int irq_alarm;
 };
 
 #if IS_ENABLED(CONFIG_STMP3XXX_RTC_WATCHDOG)
@@ -245,29 +244,26 @@ static void stmp3xxx_rtc_remove(struct platform_device *pdev)
 static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 {
 	struct stmp3xxx_rtc_data *rtc_data;
-	struct resource *r;
+	void __iomem *io;
 	u32 rtc_stat;
 	u32 pers0_set, pers0_clr;
 	u32 crystalfreq = 0;
+	int irq_alarm;
 	int err;
 
+	irq_alarm = platform_get_irq(pdev, 0);
+	if (irq_alarm < 0)
+		return irq_alarm;
+
+	io = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(io))
+		return PTR_ERR(io);
+
 	rtc_data = devm_kzalloc(&pdev->dev, sizeof(*rtc_data), GFP_KERNEL);
 	if (!rtc_data)
 		return -ENOMEM;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
-		dev_err(&pdev->dev, "failed to get resource\n");
-		return -ENXIO;
-	}
-
-	rtc_data->io = devm_ioremap(&pdev->dev, r->start, resource_size(r));
-	if (!rtc_data->io) {
-		dev_err(&pdev->dev, "ioremap failed\n");
-		return -EIO;
-	}
-
-	rtc_data->irq_alarm = platform_get_irq(pdev, 0);
+	rtc_data->io = io;
 
 	rtc_stat = readl(rtc_data->io + STMP3XXX_RTC_STAT);
 	if (!(rtc_stat & STMP3XXX_RTC_STAT_RTC_PRESENT)) {
@@ -354,13 +350,10 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(rtc_data->rtc))
 		return PTR_ERR(rtc_data->rtc);
 
-	err = devm_request_irq(&pdev->dev, rtc_data->irq_alarm,
-			stmp3xxx_rtc_interrupt, 0, "RTC alarm", &pdev->dev);
-	if (err) {
-		dev_err(&pdev->dev, "Cannot claim IRQ%d\n",
-			rtc_data->irq_alarm);
+	err = devm_request_irq(&pdev->dev, irq_alarm, stmp3xxx_rtc_interrupt,
+			       0, "RTC alarm", &pdev->dev);
+	if (err)
 		return err;
-	}
 
 	rtc_data->rtc->ops = &stmp3xxx_rtc_ops;
 	rtc_data->rtc->range_max = U32_MAX;
-- 
2.56.0

