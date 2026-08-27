Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5281E368263;
	Thu, 27 Aug 2026 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787812304; cv=none; b=BQlLeWnO1sgwWTY9vgonhLsN0qBSK7pT55wdKDtJ3iWdOucpRuEP4LtYK0hlaJ4J5C5SmKPnikLuGDgoihJKXI8OLlOOMOi/JUcd0aPhVaXG/EMsgtZT2+Dzq4lWCdDPZKVrerZVEenbwDy8vjvslJtw+YS0wY/jtkJQ0UAV9PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787812304; c=relaxed/simple;
	bh=kGWRmejebHmrxrRnJAJrvsy+92i4X5KiatJ6vbNhWOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YoJxpAlErSMiYUQ1+m0TsyAX0+gNz72ljA/5NYzRQNdZYevQZvgnSqVGQppkjRUc4of+xTiOoXVFdOriTX8q0ATfjkVOeQff/08+TTOHahpxWRWQhcchCEGt6Aqpfn8OdiwPR4je6DC8x8ProwDOvkf1B1x36zRZ3I4OEKSbJkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: esmtpsz20t1787812246tf69520b0
X-QQ-Originating-IP: ZXeObjIOicgx6bbgtANZd2CIhj1mWYEEWSlY1MfUDts=
Received: from localhost.localdomain ( [111.8.45.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 14:30:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17649052534252163041
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
Subject: [PATCH v1 2/3] rtc: ftrtc010: use devm clock APIs to fix use-after-disable in remove
Date: Thu, 27 Aug 2026 14:30:18 +0800
Message-ID: <17C4ADB7B3B875B8+20260827063019.3342085-3-liudalin@kylinsec.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827063019.3342085-1-liudalin@kylinsec.com.cn>
References: <20260827021054.0963C1F000E9@smtp.kernel.org>
 <20260827063019.3342085-1-liudalin@kylinsec.com.cn>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NkHKfw09D6j8P79CX9CZlLA8D8mp26Y61sEywqmWQxeBpHlZSCllH4au
	9eCS+mz90VVG/kaMPWxaXOsAn67mLIQICBltI1OnH7wLUF+x8KiPZUlqbNn3ztrtymUOD6L
	okeGpRlO7deuUl98z84t7z4rO8unRUsFv6zC30HEfs/DbF4yaZaD8KACGE6Eq90w/cc2bed
	E40R+GBeI8oPJzcIRwvCfYFkHkHMGJDwIHAC0phVHYmVCKTjglZ4dvk/S7z5fJWWy2crUvW
	aaltqE/n7WnYGAHjja4WqL3v7kXi3Bh65iuVxL7FpeUv1ym7ursA2FvFcN8v0mNRCEffHFM
	1SViCXX4+ci4MiPPkZDJb3DIsKM1EYDMHaXoi/3h6oxNT7WkfFLX9/Tf8gc+1AFpjVLaTc+
	Mj1J43BnxfI39tG0PN9IAcKmgdmaVxClaQMANFgHNRBHxU/TVsjrmSzmt0rYfj5LktPo+Yt
	zoXAgPbPcn65RmgpYg0g7dJfdNtRfnJqu6IR0j0MZkgg0inBLxQ8Vwc6CMeBWL3oRcExaIB
	Evmci4AOsiggqaoqcYhV9+di5G9lq/1iQKGibPYs+kizwGowMs2vzib3jUJ+kI5IqBlFOdf
	w3kP+XLrctsB1s0GMb7y3GkgFg5ksL5dtnzKD0J46X2QqpjSagZsi6JHqhSFGn8Roml3Jx+
	XBnDGuYKNOPyeam5802jAuoSfGv03EoaLP90TcCIFwRuSzxTTEtdnGjWY3F5YQKjfdB9BFr
	7yfQvjKVZWm36ZMgRi+twiBZYBt/L3H+iYFRH9hbVVLGZGDGUky5wHsOwmGvfHQKKv1mSc0
	lclejAjh1J1JG55ID/NWs0d4yCQKD1x8buHSnpuk8qKCz3sWKrhN758Hv7YQisB1EvqluCj
	pIyy/5tc88xC3A5cRI/SR2ntRd6D/6DvY36uxc8Xb9HWYFp05BnATUGN/xMcjyc2TgWi6q8
	Wshsr8R0xBUwKxLC53BHcJzrhPDxiBqVaBaTMsgHAP6oQn/XOYI6rECVoG7vVuqR7vrdhxq
	8/lTCaLfDHXD1oPDHfgi7WadnmXM8klWYedUTMxwlqz3KnENdshtRCpmnUD3xmoBne8UXzl
	w==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

