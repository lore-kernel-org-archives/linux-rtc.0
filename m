Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCB03BE650;
	Thu, 27 Aug 2026 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787817889; cv=none; b=Q05b5n5hseQEl+pPCZeyQqfVKAQfZxoQMC96Cw6n6tsVr3ljH/Hs1+tLy5cZmnz7z582M+ca+wcvmJ5lV8U1y+qWcGDMLHK9wWUom5D0f/FuHTm673cAm1x3QAeqmVnLytZgwUJ1q1e7arb/BmlL3VtMTQAx3Ohil9YDf3EoGJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787817889; c=relaxed/simple;
	bh=kGWRmejebHmrxrRnJAJrvsy+92i4X5KiatJ6vbNhWOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjGR6ETaHbLmk35XFq11AcYh2euncmvZdGhkR7r/9ZGGAUvXOsMV+yqNpIsMwyMAGM+lbta3N4CbMms/nZZ2YNEQ4MVzf0UVBWO7ovBE176P4Hqk1zjTw4Md/E5pfX8pfxL4RHh8qzYEpLAapIE33k6RmvxNHbxcepgUbH8w10M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: zesmtpgz1t1787817820tb37c0f3f
X-QQ-Originating-IP: j00K5DidhhOWMSakCHDJzAVTmonswQ2s0q6/QxIojMA=
Received: from rd.. ( [111.8.45.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 16:03:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11111018256627874167
EX-QQ-RecipientCnt: 10
From: Liu Dalin <liudalin@kylinsec.com.cn>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Linus Walleij <linusw@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Dalin <liudalin@kylinsec.com.cn>,
	Deng Yingchao <dengyingchao@kylinsec.com.cn>,
	Qin Yungao <qinyungao@kylinsec.com.cn>,
	Luo Qiu <luoqiu@kylinsec.com.cn>
Subject: [PATCH v2 2/3] rtc: ftrtc010: use devm clock APIs to fix use-after-disable in remove
Date: Thu, 27 Aug 2026 16:03:19 +0800
Message-ID: <0238203A74C9B9F6+20260827080320.3351155-3-liudalin@kylinsec.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827080320.3351155-1-liudalin@kylinsec.com.cn>
References: <20260827021054.0963C1F000E9@smtp.kernel.org>
 <20260827080320.3351155-1-liudalin@kylinsec.com.cn>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OJPZoS5g0J6bfbqlS1z88AoTgHtFMwlzEyt1+nliJIbYnDJQWohFt8jX
	+UXJQps9TBfugyZmlik0Tyq/4yHqV7A63/LODegM/OMIHHn6/I0PzizZ0E09Z1blo2Mud1M
	pxffALfQPCOMv0KLQvfKmr3N9XZgBl/NlNxlmtaKduQ6q0c1F3qnee2H4U5ZzR83zYV8vSS
	GvpMXG+8YixEHD7LnXEIwGFto0A0kgV2X70cpqaqsHFTEKJqhrQSwymM2jCqaR5j9sqBNwB
	ayUm6YcInTiUeBMBYtvMkp5ezkp49KrSInjzuJO9A1Rh6jZDHgsdVxRJf71vexBd2Gg8+HA
	LgbY9oYiSIikaUDbUj+l6UJLgteNRgtez3iD8arT1QlaWT5XGtX6dRLUaPT3j00LVkIoeQz
	jXeH0YUzbkigOnkKpIzEib6531GWE+rxzl1lo8M5OiEkt2yrU73aNm7F5+9DE0hEQETsMbS
	Vz4odJm0z2Vn8QsHDbIH68J3jUpEWoAk9ozXJucU0qO/S4HfAi4IH8QQfLmRqojUxR7Zlul
	MRdoeykupU/WveuKUioN1C8gneSMpFQNHdqLOIkTMF/Vl8Qqjo+FfQcG0asI7NUyZRp/qFT
	GZNbDc9R/GFpBdoUChMNDXmgvW5SVm6oVde2VzkgQSrnvFNeeG2MzCjxA9fj1DEpchgnkD1
	Tu1WMOyKGZxsYg+lBmgSNbw7pa3HHI895ZRs1c3ScCz2yMYxQch3V9/VcGF5u78TVd+QGas
	WJVbWlIYG+o7fmpxCRDCTjite713OpsuImLM7Zr+AVIlMd8D/d2U2IXwPVjGTqwLrpBsEIF
	31RzUUIrlxQVRXiAwJFAPvTOoEWMd67vhTBjxMGdnezUpP9pzijgz7oSMAbs8IV/eLEWMKU
	N2eQcSmwqWDjLK3aQOcZLXv5tGDxoxibcEr/ZRLVKw81LdtH+J4vOFd/o94XpzqkDl+rpnv
	lwHfA/M+WzC4EQhgV5h5ZBMlmPgwIhdhZxK69h/lUa/CnTyPnMsWDmiAKDNE8buwFUmNDX8
	LCWSW42eBUa0ndgYrxHe7LrXXfockOjjSFhxUQvAOKyCg4dEfqjyD8KkEB1seav940FBpGB
	+JrPzkiZ8bY+TVccq+Q6eShF5shsQQyghsnT+PQYBwLonWtubGo1Ep98DQxgPuYdw2rAviI
	3ESR
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

The driver mixes devm_rtc_register_device() with manual clock
disabling in ftrtc010_rtc_remove(). Because the RTC device was
registered via devm, it remains registered until devres cleanup
runs after .remove() returns. An unprivileged process holding an
open /dev/rtc0 file descriptor could issue ioctl(RTC_RD_TIME)
during this window, triggering MMIO reads on clock-gated hardware
and causing a synchronous external abort.

Replace devm_clk_get() + clk_prepare_enable() with
devm_clk_get_enabled() to tie clock lifecycle to devres. Remove
the manual .remove() callback and the corresponding error handling
labels in ftrtc010_rtc_probe().

Fixes: 1d61d2592c1f ("rtc: ftrtc010: Rename to Faraday FTRTC010")
Assisted-by: Sashiko AI [static analysis]
Signed-off-by: Liu Dalin <liudalin@kylinsec.com.cn>
---
 drivers/rtc/rtc-ftrtc010.c | 67 +++++++++-----------------------------
 1 file changed, 16 insertions(+), 51 deletions(-)

diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
index 512790bc3f2b..19e6333bfbab 100644
--- a/drivers/rtc/rtc-ftrtc010.c
+++ b/drivers/rtc/rtc-ftrtc010.c
@@ -119,51 +119,33 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, rtc);
 
-	rtc->pclk = devm_clk_get(dev, "PCLK");
-	if (IS_ERR(rtc->pclk)) {
+	rtc->pclk = devm_clk_get_enabled(dev, "PCLK");
+	if (IS_ERR_OR_NULL(rtc->pclk)) {
 		dev_err(dev, "could not get PCLK\n");
-	} else {
-		ret = clk_prepare_enable(rtc->pclk);
-		if (ret) {
-			dev_err(dev, "failed to enable PCLK\n");
-			return ret;
-		}
+		return PTR_ERR_OR_ZERO(rtc->pclk);
 	}
-	rtc->extclk = devm_clk_get(dev, "EXTCLK");
-	if (IS_ERR(rtc->extclk)) {
+	rtc->extclk = devm_clk_get_enabled(dev, "EXTCLK");
+	if (IS_ERR_OR_NULL(rtc->extclk)) {
 		dev_err(dev, "could not get EXTCLK\n");
-	} else {
-		ret = clk_prepare_enable(rtc->extclk);
-		if (ret) {
-			dev_err(dev, "failed to enable EXTCLK\n");
-			goto err_disable_pclk;
-		}
+		return PTR_ERR_OR_ZERO(rtc->extclk);
 	}
 
 	rtc->rtc_irq = platform_get_irq(pdev, 0);
-	if (rtc->rtc_irq < 0) {
-		ret = rtc->rtc_irq;
-		goto err_disable_extclk;
-	}
+	if (rtc->rtc_irq < 0)
+		return rtc->rtc_irq;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		ret = -ENODEV;
-		goto err_disable_extclk;
-	}
+	if (!res)
+		return -ENODEV;
 
 	rtc->rtc_base = devm_ioremap(dev, res->start,
 				     resource_size(res));
-	if (!rtc->rtc_base) {
-		ret = -ENOMEM;
-		goto err_disable_extclk;
-	}
+	if (!rtc->rtc_base)
+		return -ENOMEM;
 
 	rtc_dev = devm_rtc_allocate_device(dev);
-	if (IS_ERR(rtc_dev)) {
-		ret = PTR_ERR(rtc_dev);
-		goto err_disable_extclk;
-	}
+	if (IS_ERR(rtc_dev))
+		return PTR_ERR(rtc_dev);
 
 	rtc_dev->ops = &ftrtc010_rtc_ops;
 
@@ -178,29 +160,13 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
 	ret = devm_request_irq(dev, rtc->rtc_irq, ftrtc010_rtc_interrupt,
 			       IRQF_SHARED, pdev->name, dev);
 	if (unlikely(ret))
-		goto err_disable_extclk;
+		return ret;
 
 	ret = devm_rtc_register_device(rtc_dev);
 	if (ret)
-		goto err_disable_extclk;
+		return ret;
 
 	return 0;
-
-err_disable_extclk:
-	clk_disable_unprepare(rtc->extclk);
-err_disable_pclk:
-	clk_disable_unprepare(rtc->pclk);
-	return ret;
-}
-
-static void ftrtc010_rtc_remove(struct platform_device *pdev)
-{
-	struct ftrtc010_rtc *rtc = platform_get_drvdata(pdev);
-
-	if (!IS_ERR(rtc->extclk))
-		clk_disable_unprepare(rtc->extclk);
-	if (!IS_ERR(rtc->pclk))
-		clk_disable_unprepare(rtc->pclk);
 }
 
 static const struct of_device_id ftrtc010_rtc_dt_match[] = {
@@ -216,7 +182,6 @@ static struct platform_driver ftrtc010_rtc_driver = {
 		.of_match_table = ftrtc010_rtc_dt_match,
 	},
 	.probe		= ftrtc010_rtc_probe,
-	.remove		= ftrtc010_rtc_remove,
 };
 
 module_platform_driver_probe(ftrtc010_rtc_driver, ftrtc010_rtc_probe);
-- 
2.43.0

