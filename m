Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FCB3CB562
	for <linux-rtc@vger.kernel.org>; Wed, 29 Jul 2026 22:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785365526; cv=none; b=X/po3iWWeQHgzTo2PvIAMNC6l29psX8Y8ceXCwRreHmvvd0d9R2wnUCOfn+HB/YiBYHl0HS73Lzp0crkgHurE2j47RJvfvGS8yPvFPHWU1G990S3HMA4Z+038UoCG+ge+1tWtvqIFZLTJWF8jz/PKjDfRc18KvIzMN0pealLK+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785365526; c=relaxed/simple;
	bh=ASpKDerMW5kqehvGMv2OZhWmr6QNCaKZJSuku7fWJAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uDeqq89ypv9bdxfvo8Jn4PAz9h1sGjhT310bJDCRzZYDQPUj3ICBq6W85i6IRGg6LXiDIBo/xozzHWQXXM2Fsc1L3zNS6sTqt7TaN6ynbZN8tOu7NaKjW8cJ7oKMTNJ4DT7yNO5M4hD+xgs3tkfUpGE+cMPXIDXicb7i+9zIYP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AG4bdx/D; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AG4bdx/D"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38101f85591so149604a91.1
        for <linux-rtc@vger.kernel.org>; Wed, 29 Jul 2026 15:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785365523; x=1785970323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WLq+7wmGJnDVqRzy/9WiaGXniOfQxglk1F1iJbCO8zQ=;
        b=AG4bdx/DMuAIt/uJ2NcMn5HrKR9xWUyCLVmQuthnY2hAWezV+tYCwu94d0XFImVsSX
         jLlBKx03wl+1zIcb4n8pt/pceNMWTZUotgGg09JdQnJ6pQ0Xv52NXJ6fon8+B/h4Qwjq
         M/32HM2H40S/+VH45vu4r4Xa3s5/w7twnmLGuRZwiWYiXui83VVC0I4MMc6cDbpYnUJt
         JC9nI8To3TdyZ1gUblemuPSbQQxRHDMZ0yCbhDHc986sSturxS79DwIhb96jFjKf5asq
         TFY+MmhTF8Qn96LwqkD6D0VDaw0N1qoBz4XEht+yEmHI93+E1pLp3yznO3CfxeO0AYgO
         wcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785365523; x=1785970323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WLq+7wmGJnDVqRzy/9WiaGXniOfQxglk1F1iJbCO8zQ=;
        b=RrNoyeAm8OHMwI5dv0oE0aRsvsDzHifHtshAnoy2FUnYwjQo8S3N/PGN8YWvZGbgxA
         21vgv4Ieg1CHkovghHcJHpHVQC71gMlVWJgFngP7sh3AhKwwmC226pm/GcPdsr45WcS6
         5BZHCfAK7VC1xf0MESohf/3VB37DN3ogk4FYYD9Kk2BsAFUnk1OQI5ACPSaRBq+/rbDt
         m8DT8bPPWbFc+brJpjemba+JpO3RrXJgyqrHKgUbK70Jay3gIKvXdenZMtmRdiYmu8U5
         50X1vrxP5k+oG5biPVsVpJRvk9/TaZiftTuH2y08QipAO65qABKpuLEXFg9i8m4A0CpR
         hoTA==
X-Gm-Message-State: AOJu0Yw9yUQEYt6HrPx9nxyhaAtg5q4nI2AF9nPoT8e93j2Zeu1q9HXF
	THS3leNgVbPWEwT9TVUdokXivx4Pi0q+hfYlEJL3/hRma+qTMN/a8aanrvHsRvlD
X-Gm-Gg: AR+sD11aqzKRJsrndtYclBJK209c+pBoNIriFTKe5asb+PAo7EN+FLz48AUKaPK5xrP
	eacqoVAw9Uo1z4kvvQNxtTlvZu3cYTBO/R1oIJqrWDXU9YlXS/F35h4A4KI6JJm5utRftQeYBVi
	oG5iK0wkvv/u/VclTcMa0Ly+OIfUNYo99wmQUKxrFW44/X9HXK35F7H8g8OyZyGLEAVDnqlRzyc
	yuF5/yVQ+frp7hdtmMdx1ytMYW21bw/Grf4WB9zBOm5zMQ/WmfzGLq4cvw6+JyRguO3yYDWDDuk
	Ppet3M0Q1WQcLWd7M294yefdKaw3yAyNxgrNYAdk5WBO2eTRZQbkl6do9Yu+UjyGa97HP+rcuSN
	Y2ZSFIkRdpLE0+szxQeUBHtvs6z/m3AuhZj1b9rBBT6Z+4p8uuLcMAO71/2agAU7OYh2Db2cdDz
	DES1MfdDGBHB5UCH+sUxJX5yhlXVsd8gESgS8vZoTu+c9kX8Yhg68LcfbVhKNvz6WAl0JXiUBpz
	e5d7NCJc4eAMnLMYuNf0WnUSfqZ7pxCoOnw79geb+bMDSS28KsDGhL4mETkEeqk3b9WpQZm+e7F
	olMlUGs8v+Xk03bcmf0y49sRa9UGIgXshzxuVw==
X-Received: by 2002:a17:90b:39a6:b0:38e:5828:a446 with SMTP id 98e67ed59e1d1-38f9bb8b861mr157860a91.19.1785365523272;
        Wed, 29 Jul 2026 15:52:03 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b770e3esm58567a91.0.2026.07.29.15.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 15:52:02 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rtc@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3] rtc: stmp3xxx: use devm_platform_ioremap_resource()
Date: Wed, 29 Jul 2026 15:51:59 -0700
Message-ID: <20260729225159.775183-1-rosenp@gmail.com>
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
 v3: add missing variable in probe
 v2: add platform_get_irq error check
 drivers/rtc/rtc-stmp3xxx.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index 7afcd14aeee5..a8ca681b574f 100644
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

