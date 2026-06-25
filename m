Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A427226CF6;
	Thu, 25 Jun 2026 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392540; cv=none; b=keo5vkQ92cK/o5+5V8ey1xjDpomMp14g1U0RophIZBDChilZOsuf2Y45Rei5Ac5itZu4ojS1NBlRnde5sbjRqyCI4Wy0i0qZVxqhT8o/Cjbdq4a8i1zTkNi6J8NI8c9iww4CImMsBJDgh4naLMhkUiHF8PyJUoWO2du+j6SLRPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392540; c=relaxed/simple;
	bh=5gVz3GD+JsN14YAXbJsv7T0A96S0m0Kq8gajiDIcAsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WEOhwZsl9xTvc2kZ8NE/rCyMFuwplyuOVJpxy1M1jV+it8g+HazwkGmKOy9Sx4wYffCvRHpwYoOnFaOaXQQZPmUbmqtvzdKZgAxVpva+NhxxaycKnK97Ke3OQqOF9SEf1XlOjquzjpdJ5W6TKJcIgohTW5+S2+ceL0rDUlwEVeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z+ibaKZ1; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z+ibaKZ1"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8F85B1A0993;
	Thu, 25 Jun 2026 13:02:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 643275FF03;
	Thu, 25 Jun 2026 13:02:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 99232104C9531;
	Thu, 25 Jun 2026 15:02:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782392533; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=0BqDniKI2eMO7o9mzNR7O6RD+KCeOBbHHaik/jgiuZE=;
	b=Z+ibaKZ1DO8mSkOm2ZsS+jE6pLtyRc7zfB3/jkGamU4bBi+I9LMIYuSgZlKVbcTU4rVonp
	/VhCDY4rA1j/4tNn0Cw8wswmLCIAGz/kReUCXbTWzHizfwh86tT1aExdiXDRnrpc3h583A
	wxyIiURUlypGFzDKxal2HsU75U3SaOhNO3Lcv5O2tTkYZLU+f7nRavGJWeUHkyKti7Kdd/
	I00Cph3sJndfrxrIadqIVDzx6Tov6NO8ok89P/FVJhuDhUXdkhJeJ+cU9UP8t+O+iHPL11
	0XP0RL/WyMPvKjBQXUk+5pGQ3D+OWsURRJBQzEQmlA8Op+WBNpe/M70OfFLdCA==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: =?UTF-8?q?Gr=C3=A9gory=20Clement?= <gregory.clement@bootlin.com>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rtc: mv: fix potential race condition
Date: Thu, 25 Jun 2026 15:02:00 +0200
Message-ID: <20260625130202.1621692-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Since the driver allocates the IRQ using devm_request_irq(), this means the
IRQ is going to be automatically unregistered by devres after
mv_rtc_remove() returns.

However, mv_rtc_remove() explicitly disables the hardware clock before
devres teardown happens so the interrupt handler may run while the clock is
disabled leading to a possible bus hang when accessing registers.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-mv.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
index f88976fd6d5d..c0f1bcd838e3 100644
--- a/drivers/rtc/rtc-mv.c
+++ b/drivers/rtc/rtc-mv.c
@@ -219,17 +219,15 @@ static int __init mv_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(pdata->ioaddr))
 		return PTR_ERR(pdata->ioaddr);
 
-	pdata->clk = devm_clk_get(&pdev->dev, NULL);
-	/* Not all SoCs require a clock.*/
-	if (!IS_ERR(pdata->clk))
-		clk_prepare_enable(pdata->clk);
+	pdata->clk = devm_clk_get_optional_prepared(&pdev->dev, NULL);
+	if (IS_ERR(pdata->clk))
+		return PTR_ERR(pdata->clk);
 
 	/* make sure the 24 hour mode is enabled */
 	rtc_time = readl(pdata->ioaddr + RTC_TIME_REG_OFFS);
 	if (rtc_time & RTC_HOURS_12H_MODE) {
 		dev_err(&pdev->dev, "12 Hour mode is enabled but not supported.\n");
-		ret = -EINVAL;
-		goto out;
+		return  -EINVAL;
 	}
 
 	/* make sure it is actually functional */
@@ -238,8 +236,7 @@ static int __init mv_rtc_probe(struct platform_device *pdev)
 		rtc_time = readl(pdata->ioaddr + RTC_TIME_REG_OFFS);
 		if (rtc_time == 0x01000000) {
 			dev_err(&pdev->dev, "internal RTC not ticking\n");
-			ret = -ENODEV;
-			goto out;
+			return -ENODEV;
 		}
 	}
 
@@ -249,8 +246,7 @@ static int __init mv_rtc_probe(struct platform_device *pdev)
 
 	pdata->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(pdata->rtc)) {
-		ret = PTR_ERR(pdata->rtc);
-		goto out;
+		return PTR_ERR(pdata->rtc);
 	}
 
 	if (pdata->irq >= 0) {
@@ -275,9 +271,6 @@ static int __init mv_rtc_probe(struct platform_device *pdev)
 	ret = devm_rtc_register_device(pdata->rtc);
 	if (!ret)
 		return 0;
-out:
-	if (!IS_ERR(pdata->clk))
-		clk_disable_unprepare(pdata->clk);
 
 	return ret;
 }
@@ -288,9 +281,6 @@ static void __exit mv_rtc_remove(struct platform_device *pdev)
 
 	if (pdata->irq >= 0)
 		device_init_wakeup(&pdev->dev, false);
-
-	if (!IS_ERR(pdata->clk))
-		clk_disable_unprepare(pdata->clk);
 }
 
 #ifdef CONFIG_OF
-- 
2.54.0

