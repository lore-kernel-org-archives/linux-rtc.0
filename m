Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D0637C0EC;
	Thu, 27 Aug 2026 01:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787795931; cv=none; b=pqKC3kaFepvgRMlZG9t9U0kWUi5blffv/UezSXYRo+7eOL1/Vdt5yQ0MjUSP86YJBDbvxxXVw6FqfiBa6Hn0cDSyZ+R8+rAnHDVN0pkmnpiQsGvYD0dR7YSID6wi1pyyFusF1f8ndgo1zNhUorz3L4cQHEsXvOUfLLNWeBAhgX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787795931; c=relaxed/simple;
	bh=LoIxppfXfkAKK5goic8HLKwwdZaSM4Vo0F8gA33eUvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8Mr8l47HO+grRsQbC+TUmnRNnM6J/99rGQefT0gn0X3D8gCj9wMxJoy+m0DZDxYeRmcJXLxlpFTuUzTKOmqrdmBrHXITq0UPCxM+42j/kCssGRWTrERP4QIZkS7wj4WWtFesOkiZ4+EP3GqGiCqRIq1r5wqqJsGkDxU+kAge0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: zesmtpsz8t1787795867tcc1a0f70
X-QQ-Originating-IP: ISomFNd5LS1lCGmVK+BLD2jvsGQjujhwWsbyPRLp3Yw=
Received: from localhost.localdomain ( [111.8.45.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 09:57:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 341609150643013469
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
Subject: [PATCH] rtc: ftrtc010: fix clock resource leak on probe failure
Date: Thu, 27 Aug 2026 09:57:39 +0800
Message-ID: <6A7910FC22A9FEF1+20260827015739.3314298-1-liudalin@kylinsec.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MABkn+BX1UZ41h921ZwOJU1Z3X09n7kZ23c+3inVxQNwYoUXYt2tolYV
	pb6F+Q/43vHr74+d+1i6LdopwjpA6G4RNlSvDhsHhvv6kefy4GOS6JmrEoiCSQQdPDfEj4C
	+vvdLOPRp/uj2D2I0ampZH6iFx3KI66GLGWR9fP8XJmAjAc8H7GUF8VAHEQ3WeQE6jvDyP6
	IaC7/XW4PdU7ZqjD711zKMEuUaWwF9c0PBzxx/O5Ou5QcFmaLyfKi/NuuGhjpEmJU3AKZ1F
	hAIYLSUbNVXdX1QDkE+x1o726Obb1eRDU26xqbrksXf80riSYazHVpnqCQxaJy/lEj+2r4p
	tKkAiX8nLkL8cJ5YMnbdx8KT1qzhxT+uJrU0/t6BgoGZ0w58ZY662BP2LP3/P+KhRvQDoYn
	8ZR1ytM6vugviyElWkiuKLA4ciRQXkW2mg0CkFcNSx+gb5tGHCCr6mZm6BUcectho2GzvYP
	pSZPW/bTZctUsqrNku3vcd6Ho+634TQuyVl8b2leq+B/t9ArtmWnWXB0OxVPiIkkYcmq5FJ
	+TYoeF8bcEkYiHXV1b45EzZrdgFDTARBJqLVdJFXB7Ekt89bLR0gBiCjsczlHAJu1eeCc4O
	aHTHGqCkylGS6CLEU+F7cAfZq538iE5F8gmzZF8g8ZSMcBZ3P3/yBU7t6JVQsqY5oUiu/rU
	O7KEow3STDf8H+n6kbsw0/D+H6DI9qRQkStGUXVsOZ7Cp2E1tEEscYzAUeAAnavN+QEZIsx
	A8Tv88D6NY8BG7aRboKBF/nNQICCb41KcJpa96wBD1nymkmYqCEMkpHpzeEdHLH97ajAu8Y
	K84b6/m/W6OWw+h1bKMiGIJ92nKaYmPDMlzXq9PcYjzbRsXJfXthMEFcG50N749ZiPOFc2O
	rLys1WNR3yLorBMIAE5i+rMD3gZHKrmF17RhW545FRxIOVjlWZFRKolTGEpHjszX7ePApQK
	jQo8B3wXfyCw0dJhO5UGlIsOhG0tQiHKEgMkVSQbSVncTL1OImu7aQ3WOQ2iqeLjLkhAdNc
	hw1Qmuu1ueRGm8T+3cUsqHPKe5x56GZcvRmryXgP0KcRzt8Vm8HsrM5GeWzh2ydKenuy2JG
	w==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

When devm_rtc_register_device() fails, ftrtc010_rtc_probe() returns
the error directly without releasing clocks obtained via
clk_prepare_enable(). This leaks both extclk and pclk resources,
which may prevent subsequent probe attempts or module removal.

Capture the return value and jump to the error handling path to
properly release clocks via clk_disable_unprepare().

Fixes smatch warnings:
- drivers/rtc/rtc-ftrtc010.c:189 ftrtc010_rtc_probe() warn:
  'rtc->extclk' from clk_prepare_enable() not released on lines: 183.
- drivers/rtc/rtc-ftrtc010.c:189 ftrtc010_rtc_probe() warn:
  'rtc->pclk' from clk_prepare_enable() not released on lines: 183.

Fixes: fdcfd854333b ("rtc: rework rtc_register_device() resource management")
Assisted-by: smatch:2.0 [static analysis]
Signed-off-by: Liu Dalin <liudalin@kylinsec.com.cn>
---
 drivers/rtc/rtc-ftrtc010.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
index 98fa0f518303..512790bc3f2b 100644
--- a/drivers/rtc/rtc-ftrtc010.c
+++ b/drivers/rtc/rtc-ftrtc010.c
@@ -180,7 +180,11 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
 	if (unlikely(ret))
 		goto err_disable_extclk;
 
-	return devm_rtc_register_device(rtc_dev);
+	ret = devm_rtc_register_device(rtc_dev);
+	if (ret)
+		goto err_disable_extclk;
+
+	return 0;
 
 err_disable_extclk:
 	clk_disable_unprepare(rtc->extclk);
-- 
2.43.0

