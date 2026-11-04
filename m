Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760815;
	b=vYiPIzmWHZgaA+109yMwjlnjXKahmUE/pjgpTAkogiTYr+LIqU3xmi9oPnnKxeLwjcim
	 LFaANM8lZzAs7mSTIJB9hk6nKvLQKVhSfWo6sPQMGqAjED0t2ldNl/HDLO3bO6mrNycHX
	 iU1fWgD0IqyocJbuLdsFBi60guWbwwS3HMyt592T/YvwVGeYzo3Qxtl9RB+iQxDC+gttB
	 t0yjbp6hru77CjZtDZTyXLeK3IwI40lfAlHAbFtSwcGjeXPZ9hCfhHPSKY2NHQhyZhg7m
	 TSEcMirFcXqYpDxwYDI3a+zC3ZAsqVh+qZT//cS00nqVc7dNx5uffKT4fVjjePmr/HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760815;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=u7Aa47YE7EQHdQgxUkhYIhldHdu8oIaNugsJipi/zpE=;
	b=B9DvL+wQ7lHs5w+J/LR0v4EidmlBz5x7XXzyZUWczcNuiwBVIOQI69c3aKiOfIvC2QKE
	 kOByZI8jGFSnm6QbUyzhoAAgtbVlpMp+/m4EozMovIdoktQwHAnq5Ws46JBlFgVo6SLet
	 L7sKbzijR/rNCOug3kaEH+Hef505qwRs0I+ewYZqCkLbCE4vErUyA8J6zoBW/ZWFR5zGP
	 CnzrPC3PHMQiEWwrI3PE9F6fysYVGsBnS3E7C3rJuASBgmPVIaj7FY30QMzMAgBL0vbhv
	 u0prNFjWjIqhg6FOBJv+LlD9WpkU0RrbXwNrdx0u5kXxeAvBDbgRaWP8c/KgbHpy7tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8698A606A326
	for <linux-rtc@vger.kernel.org>; Wed,  4 Nov 2026 02:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8698A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAC35P4qnupqyOQ+AA--.9833S2;
	Wed, 04 Nov 2026 10:53:30 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH] rtc: ma35d1: release the clock reference on probe failure
Date: Wed,  4 Nov 2026 02:53:39 +0000
Message-Id: <20261104025339.1527356-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC35P4qnupqyOQ+AA--.9833S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW8Ary3Jry8tF4rKF17Wrg_yoW8XF1Upr
	s8AFyYkryayrWrKa9rG3WxZ3Wqya1xt348K3yvka9ag3WrZry8JrZ3tFy0gFWDZrykur45
	Zw18JF1rCa1UuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
	v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0E
	wIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnU
	UI43ZEXa7IUYbiStUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgYBA2rqY4LmBQAAsA

ma35d1_rtc_probe() gets the RTC clock with of_clk_get() and enables it
with clk_prepare_enable(). The clock reference is never dropped and the
clock is never disabled, not on the many later error returns and not on
success either, since the driver has no remove callback. The reference
and the enabled clock are leaked for every probe attempt.

Use devm_clk_get_enabled(), which ties both the reference and the
enabled state to the device lifetime.

Fixes: dc0684adf3b6 ("rtc: Add driver for Nuvoton ma35d1 rtc controller")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/rtc/rtc-ma35d1.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-ma35d1.c b/drivers/rtc/rtc-ma35d1.c
index cfcfc28060f6..43358d68565a 100644
--- a/drivers/rtc/rtc-ma35d1.c
+++ b/drivers/rtc/rtc-ma35d1.c
@@ -221,14 +221,10 @@ static int ma35d1_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(rtc->rtc_reg))
 		return PTR_ERR(rtc->rtc_reg);
 
-	clk = of_clk_get(pdev->dev.of_node, 0);
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(clk), "failed to find rtc clock\n");
 
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
 	if (!(rtc_reg_read(rtc, MA35_REG_RTC_INIT) & RTC_INIT_ACTIVE)) {
 		ret = ma35d1_rtc_init(rtc, RTC_INIT_TIMEOUT);
 		if (ret)
-- 
2.34.1

