Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A572B547070
	for <linux-rtc@vger.kernel.org>; Fri, 18 Sep 2026 09:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725544; cv=none; b=Q3uK//ipZqkjV49o0o3GYvmVVD+nhwQvWbYEDxZkYq4wlttgikEMlykLHfDuEuI7fyKU5WL4eWtQyAOocvm8r02IbysVJdtWugdV7i/V9BHdOe3oiKX0Qm1Hqj+YFSkYACSIatu/xLE/lhD83mDtVjoRdTUhdw0J86UgLsk7KGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725544; c=relaxed/simple;
	bh=n0HXg7tXmsbGXZGGamFcz9YHIqQEGL8QRvKLk1jFEB4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BUW9MUt1CH0apQqTS2L1DPBn+9Ny6NXwWOrDfPuLgx4sjEoe42vf3qLUGc647YEO5tEsWCe6SOtq6YH0ZO4NFdoNa5YqtHYn0dilqLfdHcaL2i4mx48oaqSI0CGi61rVwd4Pu5gqJRuv6piHUR44rnSUM+63ENp3VdO1T20fec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJVbkk0u; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJVbkk0u"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso571679a91.2
        for <linux-rtc@vger.kernel.org>; Fri, 18 Sep 2026 02:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789725542; x=1790330342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uiB0cahIV1Yxwv3/Yp5e9hUqE3ZJJdbygUJdBb1agB8=;
        b=KJVbkk0uZHd7P6lZhHKT3mrc0S7s8f1HXTqtAt0Qvh8mHtmOtWykgoLD8vnJCVaE+L
         NBQSAtTleY6sJFSmcj+MV7jmZ9bWJqTt5Uj+9E3lyaiftUuwZmxvgqTs0VyqG9VKW2/R
         5wdKAitp9FKiE0eT0z3pGuf3bCO5WyMUcvVcvENV5sK0mpY3X0dWWIRWF9N2qJBwf4F+
         leG/HIUyPximkVesf0xB+Apfqcpfi2osLOWpTyABn1ej40G9dcgYZsBcHxT8Gc+kRcmr
         oZGL0QLWlXNhgbW64MuuiMcPc8rRfxOS+9jB91iiEw06X5owOuHshEcfFDOwgPPdUUoY
         oVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789725542; x=1790330342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uiB0cahIV1Yxwv3/Yp5e9hUqE3ZJJdbygUJdBb1agB8=;
        b=BWXpEBAQXAQ1+FhCILcA+zXxeJma5QkFrD1PCcds5e5R1EJx1T/nBo6KwyMaigK/DA
         vf0gqZFFlMQnrdZ1nbVW+Ihr521xW92Or9WQm6i+RAcsd4B12dUOAfS3LQlSS30n3RZ2
         2ZFWr36ELok09dBjfFvxRF3x5ptRC/Oqp65Um4vW86w49o/85PEI/xRUlikMU2pf9zJM
         vvOBQFpG6+NHlfp3kSIARAirSbvZO1/CkM+RMpwc9W5MvGnM2aE7tgKSMbtqmNz8Mh/H
         2aR4mn4J05ErBg/PhiMTLsO4EB+p5GRsWdANOAmBcHlgC2OOwux92S/hoziiv8d9h+J/
         c42w==
X-Forwarded-Encrypted: i=1; AKwUvBzlRA+L759vu6uVdoL62MtDYrLyveGsYKQpSEeYtIMNrp2Nd0FYyZKLtQYm+VZMcgz+UUrx5j1Nb+0=@vger.kernel.org
X-Gm-Message-State: AFuF++ktIX7tmtpRAPAagvq0QvWfFMM/evVBiHKDyymDDArfV4weFM0k
	6ZLRxkANxNIieYavOI9+uoqg00N8dEjZJb5QQJ1eTrOBXg516l501cTSV7ZK0A==
X-Gm-Gg: AYBFou3/OMvzytbYO2Y+++VjvhJ3JzYdfsYzSnjm44SgSQRXh3XblmLPLWfpbDm1hBb
	CKrzj6DWeEpOK8EoMzGh38BN2Pj4LcLdNUuLcvBlFH6AjDCl80rJSwMK6e/+BZsp2SSwlmwLsRC
	7B0JYQn0PR0TIuU9ylbvha9v2NBNNc9Iwg+0hsr0Jp7TPAN7AK3S6/qUQJ3jUJFbm9ZV2FrvjDd
	DrQaNpSnYjMmP9VLoCtnoBmTD5RH3QXtXnhxny1R5gRYmUlUbRke+O+e8NeSNYNd56PfRKV8gS4
	0erZJTHfELRCmEXbVcKSjHY2y0KVAlZzRNLf9MhP5NrpjtIk+0u2sPyiXaVqALmWU51bF028JXn
	aik7gNpr9+3EwyVKAFKjeeBd55HGjmcMcJsOOWYfvbvJ+qm773qAfLVOMAfY0OyDWJwbRqRNlUb
	niyJGZRLUiAjZ6UyE/Gf865uHv8eKpXoDocIL49qLRoULQVraCrgbGRveK59x7s22LQWFS6F9LS
	NTsRNso8LgOkCru
X-Received: by 2002:a17:90b:2ecb:b0:39e:4c81:6c9a with SMTP id 98e67ed59e1d1-39e54fafb06mr5161757a91.32.1789725541791;
        Fri, 18 Sep 2026 02:59:01 -0700 (PDT)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e59abb3dbsm2567700a91.11.2026.09.18.02.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:59:01 -0700 (PDT)
From: Cong Nguyen <congnt264@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Valentin Caron <valentin.caron@foss.st.com>,
	Linus Walleij <linusw@kernel.org>,
	Antonio Borneo <antonio.borneo@foss.st.com>,
	linux-rtc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rtc: stm32: fix clock leak on pinctrl probe failure
Date: Fri, 18 Sep 2026 16:58:53 +0700
Message-Id: <20260918095853.1348694-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A failing devm_pinctrl_register_and_init() or pinctrl_enable() in
stm32_rtc_probe() returns directly instead of going through err:,
leaking rtc_ck/pclk -- and since -EPROBE_DEFER is routine here, each
deferred retry leaks another.

Route both through err:, and move the pinctrl setup earlier (right
after stm32_rtc_init(), before the RTC device/IRQ are registered) so
disabling the clocks there doesn't race a still-live IRQ.

Fixes: 16ad2bc09efb ("rtc: stm32: add pinctrl and pinmux interfaces")
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260914135401.373D91F000FF@smtp.kernel.org
Assisted-by: LLM
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
Changes in v2:
- Sashiko found that routing the pinctrl failures through err: (as v1
  did) disables the clocks while the still-registered RTC device and
  alarm IRQ are live. Moved the pinctrl setup earlier instead of just
  moving where the leak was plugged.

 drivers/rtc/rtc-stm32.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index d4ebf3eb54aa..457f66663ba5 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -1137,6 +1137,20 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
+	stm32_rtc_clean_outs(rtc);
+
+	ret = devm_pinctrl_register_and_init(&pdev->dev, &stm32_rtc_pdesc, rtc, &pctl);
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret, "pinctrl register failed");
+		goto err;
+	}
+
+	ret = pinctrl_enable(pctl);
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret, "pinctrl enable failed");
+		goto err;
+	}
+
 	rtc->irq_alarm = platform_get_irq(pdev, 0);
 	if (rtc->irq_alarm <= 0) {
 		ret = rtc->irq_alarm;
@@ -1172,16 +1186,6 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	stm32_rtc_clean_outs(rtc);
-
-	ret = devm_pinctrl_register_and_init(&pdev->dev, &stm32_rtc_pdesc, rtc, &pctl);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "pinctrl register failed");
-
-	ret = pinctrl_enable(pctl);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "pinctrl enable failed");
-
 	/*
 	 * If INITS flag is reset (calendar year field set to 0x00), calendar
 	 * must be initialized
-- 
2.25.1

