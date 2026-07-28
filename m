Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4FB1DF74F
	for <linux-rtc@vger.kernel.org>; Tue, 28 Jul 2026 00:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199988; cv=none; b=Gfa59kzTWqvgJ6uH45RwNLekLpou/bkYRjYQaSXXOyuS6ccL7tAu8dWiFRjjavmEe9G3j9dGrDvNd2PdeA7yqB+npdpBgQ2J5vp6D3GpYQc7H+UyFZSeyZKueKUEiUmRfvDasV0k5wIjnkrX0+e+A8yrzY1eUhKyFga+h15fFmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199988; c=relaxed/simple;
	bh=G7lymH4VzRk5UrLXjayesVG8bgNIj/qtuB+ba31PCpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eOuDGC7xDtoobvIELk5kinlbWDf4NIzjNHliQgP2hX/e9PUs3yNAVoj122491Z7k/UIg/x2RN7M1ja1FDCIvp3HT6Newk4I6eYKnZZCKrr59rz2jDU9Ajtyppq7uZ3xDavnVqennKG51kOo200bjnasH6rZJjx7HOpogJvYb8kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDel/hWb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDel/hWb"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cedda2ce6fso27858835ad.1
        for <linux-rtc@vger.kernel.org>; Mon, 27 Jul 2026 17:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785199986; x=1785804786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FCOP69TPCNrGBnhvWYc5AWzDXdjWfSA97RAp2UWvhJs=;
        b=WDel/hWb0QdKQWmdFeut+xIOAHmlUFvcTtLPhHp0tZLTV1g70i/WOnByCj/HjFw252
         bMwshoSMeWM+lsDvMvfGydguWXZI7Pbqd7sBNRAWGvyi0hW3+Dev6V2zl5UB24Q6+Vui
         shGkArcW6LcvmY7N/io3D3lyTBFdGoLCZcmsH9YjbUfiak6WlkQuC7klX83+NEUmUSch
         5ad9/Sriz0mbnzU7at2Yajs9FJm7uWjrwivCuF43fBF8yanaJG/CpzWVblBYK99SZM3S
         cMLTClAjvRu6CGgbtDvv/mtqLcPKNZSvw9l5EYEA0LE6Dhhvvr+v3I9SiQRLXfNHNOhW
         9x2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785199986; x=1785804786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FCOP69TPCNrGBnhvWYc5AWzDXdjWfSA97RAp2UWvhJs=;
        b=XP02ldq2RJJ57Ga4HcQ5LTNMKxeD4X6f60542M3tTTwJQJAiuCv2RL/qPW+jEIF9oh
         OO4CZDtvlYFbU4+xjvL9Ez49JhkqVi00jkqTQwiqsScaPPlPOS3tD20mfj9hh4Uq6aNn
         ArzN0euuH+BSaPqUGdfDnkqbdy8wRkojjZVVcINwjDeYyb0XX3itwfXgdXe0WMufmo6I
         taMq5fMvYxu5IQaG6qWW2vKmpgs7AVtErg4hytL4Te+TDEgi6v6tHD9s16O0dfSjs2wH
         kD1WUN4YUiVfLiwGiXdV7SsDSfDCEIkQI91IMViIHNKShw3IOEgnXGuUrsGpqrIVA5oj
         znOA==
X-Gm-Message-State: AOJu0YwYDZa4LLufSimcd9lZOtMBpdbKumvIJlY8fy0yBBH7S/4+CsI+
	R9mm/BotSFBgK0FUi5EtjszHP5Zt/3xdoPOO/jZtNMp6OJab9+bB8CsJXSRyoq1K
X-Gm-Gg: AR+sD115b/D37cOwW42eOZCV1/+O8faBWWNfi1QBOZ8HnClHTtb7iq23RhYXBqJMKT1
	YypOZb/D5uAKiOjVwd31goYQCz3gsphiY2wftvTPN6dtk6gjHYGw45DwR3TrmXMRwMzNHiDksB9
	VjqtytsZy0uFfhDGHmHYCp9hPu4Ee7Zh9UAAofXBNnMCGNfz+pv/vVt1UWPUle00MbQ5AhhcQtb
	nBMAOC/5OPBqkZyBPsOuPu18pxQtXCYzlXJAZQTEI2sk72YCPLmGNs/fW/gNzcXVVYzbSnPeF/T
	OiD6+V5oL8w7tOLDPKt+NTzfZnXOlE8qFpKxgmPiiM/PAoTMzvW1gZwDLAv0CEDNKOI/DFaR+Dn
	32bPTlMjcZpDUvw1QIGpixnskiPY7AXQEMNrQCp9vFPFIfAiPbP+FTrt8gQQ95nTWD7h0L5yYiu
	vBxsUt7a+uOLmVyU7/s4tQl1j+lQGAIzgY1XoSx4YE1JrRaWJFZqvq22bwCnXFcysejmStXe/ka
	XCaQUhmru/uS3SfEINAIw17XiS6I6cKztcUjVYKKOSAu9mOtqgEehg=
X-Received: by 2002:a17:902:d487:b0:2cf:9f0b:b562 with SMTP id d9443c01a7336-2d015c37bfcmr2283295ad.22.1785199985971;
        Mon, 27 Jul 2026 17:53:05 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e86ccsm42283435ad.33.2026.07.27.17.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 17:53:05 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rtc@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] rtc: stmp3xxx: use devm_platform_ioremap_resource()
Date: Mon, 27 Jul 2026 17:53:03 -0700
Message-ID: <20260728005303.574936-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Remove irq_alarm from private struct. It's only used in _probe. Also add
check for platform_get_irq() errors.

Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: add platform_get_irq error check
 drivers/rtc/rtc-stmp3xxx.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index 7afcd14aeee5..e789458ba96a 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -56,7 +56,6 @@
 struct stmp3xxx_rtc_data {
 	struct rtc_device *rtc;
 	void __iomem *io;
-	int irq_alarm;
 };
 
 #if IS_ENABLED(CONFIG_STMP3XXX_RTC_WATCHDOG)
@@ -245,29 +244,25 @@ static void stmp3xxx_rtc_remove(struct platform_device *pdev)
 static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 {
 	struct stmp3xxx_rtc_data *rtc_data;
-	struct resource *r;
+	void __iomem *io;
 	u32 rtc_stat;
 	u32 pers0_set, pers0_clr;
 	u32 crystalfreq = 0;
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
@@ -354,13 +349,10 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(rtc_data->rtc))
 		return PTR_ERR(rtc_data->rtc);
 
-	err = devm_request_irq(&pdev->dev, rtc_data->irq_alarm,
+	err = devm_request_irq(&pdev->dev, irq_alarm,
 			stmp3xxx_rtc_interrupt, 0, "RTC alarm", &pdev->dev);
-	if (err) {
-		dev_err(&pdev->dev, "Cannot claim IRQ%d\n",
-			rtc_data->irq_alarm);
+	if (err)
 		return err;
-	}
 
 	rtc_data->rtc->ops = &stmp3xxx_rtc_ops;
 	rtc_data->rtc->range_max = U32_MAX;
-- 
2.55.0

