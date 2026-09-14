Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB1C43F08F
	for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392564; cv=none; b=F4zlPvtc7s6wkIkzH9beq3wDY3UwdeDmZnDyuX7zfRw1mKic3H5K6xqJ8W64kITMagRMxkXU4n/H6AgDVD4y59DOFz8E4gLZ9eRgR+yxBonMXLyYA60elGeNpVLZjiWr/pm+3D0Am8JZZ07FZBXcpJ9wbyHMQCOFEF8DT3rYPZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392564; c=relaxed/simple;
	bh=EI/Mvo4q8jidfDbAOATfJ+esW46iCyZBUp07YscHpPo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X3VY6+TcppzC/cM74HveKoBSRkOSHuI8huRMJm/pHgD974momh/o9W5tMfiMrnSOCjhP0b9SxTfolZ3kICbi9MCl6V5ZWSz4CeeATKjWNx0VOL77boGjN26d2QYlNpU8snl3ilmE9PzDy9ltj/sx67XfePj2+EBxRTXWfbnFxoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ar7Vhw9V; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ar7Vhw9V"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469b2e1d5so2209131b3a.1
        for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 06:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789392563; x=1789997363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fc4eltycEplIA/0aLYJ4l4ExpzLKApvTuVgrIn6Z/9o=;
        b=ar7Vhw9VkhaBQIPjID/ZZkLqAbJ/1qOwR2JnB1aVLtKR1nEfxS2fTm5uzNS4PGY1xL
         OYiZV3i0nHjGPDn5XUBjTje73GXN7iXAFagATCAnlwYaoDRaZ2kx/p7olkMFTqPonlFG
         qaqQ5HxbE27VY8DXuKGep/44lb+w5c90q9106NmNZ3BCajgcKgaIV2PpCz5sx8QhDHVR
         sLY2a3zVf/QLB+0qha9bKCMIysC//2nGzRDMGFyTTjbRji1R++sgpgrHOQjq8T0t6Zoy
         xbb3+qgC4ddqCIzWWZxenZ4ytIm8HMvG9sOEnbTSZ6WeAoDuWSAHK3Mg6fSdnI0Q169d
         lksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789392563; x=1789997363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fc4eltycEplIA/0aLYJ4l4ExpzLKApvTuVgrIn6Z/9o=;
        b=WPMMBF0kTrbrxgyy3+rcwrT7Hx0c6/x9X10koCYsvbm9TsNBEUoBy9L7wmgWAyLutR
         bLH9u9ngv819e/NC+eyuT+Cf5YwkKGwJLts3YP79e+lQGH2wiSN7jLOIe1ff+sdHOUPc
         SmMLwcWg6pCf5AG1G6oAxutPyWtM/cefxRl5hF0e8tasgaRnusFq5IOnQOWpFvp+Q4D2
         2E6sxzGNXegqOE8vaRbvThs3BwnZXHP42oI0TIj2f7/ZdfWE9YqYgqoXFQeJ020KwtLD
         KiAOjULJtOmgM6kWiaW+VMdH5VFlQra7NF9H+zNUz7+yU00MKk8IV5AHFmMD7lGIrhl4
         Fn4Q==
X-Forwarded-Encrypted: i=1; AKwUvBypN8drSG4+5tgg3fp1Y4qZtnWksqP9lgHv4tSwOeF3x/qDEeQqiBUOHvcOvw5bnPardONtaJiLxl0=@vger.kernel.org
X-Gm-Message-State: AFuF++lM0cO+zLJBcE8VEvP3xt5/KWSq5cxN+/TZkFFtQjGmH6N01bKv
	IFOHyFQV+GAdNruxKceDurMzdKs3m54d3hmIG6HC2P1AaaafEUDaZf0p
X-Gm-Gg: AYBFou3rHudQxi6GsBgJb3agQ61EMPELqFBpWhEANBRFPBxBCNxXCZBEEXMRpFxwm6e
	pnx1lvzMA1tYXtdjNFTk8Y48KzhH2IyMzMG9TW0JCcylA7OE22TUHhHY5Y3NX9g15S942UbCWTN
	ErMStJ/GIb7Xjenn8m5RG1i2EbV4AkPTgfhyCda2fLwq3nUkygmVXbW83LJmYhte5sR5W1zTjqf
	NLT9xBC7a2/lb3euEVcTK2AGHtXp6mH3sdpWL5SIXW462wJ66T4MDNiJ2xJn8IL3Z6AC5Ri54uo
	kQUdCSDPLVmH5KqR6Ze2vUtYbX2mf2tCGJ+ZiRKZAe/BLYDD9KuDcuJmCN2ePaujgBVQu1vEaIn
	zekTYVJ+oEjrfaQufh5Ebd2M2A3G6vhh0jEhyjKB0b3mTBeqqAAZaDGkTkWgOSQ+pOJD+PmQG8e
	BWEqiwA9YlNcOGPrOAVY4cwTWqp/GoIoMlL3oWyGVkIJnEnfhNDOtbqgqI++02kgLkQcJPisSFo
	oviCQE5vk3xtqRX
X-Received: by 2002:a05:6a00:f08:b0:86c:bf42:fa44 with SMTP id d2e1a72fcca58-86f83543227mr5924981b3a.6.1789392562587;
        Mon, 14 Sep 2026 06:29:22 -0700 (PDT)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b2a6bbec8sm4597643b3a.60.2026.09.14.06.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:29:21 -0700 (PDT)
From: Cong Nguyen <congnt264@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Linus Walleij <linusw@kernel.org>,
	Valentin Caron <valentin.caron@foss.st.com>,
	linux-rtc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: stm32: fix clock leak on pinctrl probe failure
Date: Mon, 14 Sep 2026 20:29:14 +0700
Message-Id: <20260914132914.2371788-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stm32_rtc_probe() enables rtc_ck/pclk early and unwinds them through
the err: label on every later failure -- except a failing
devm_pinctrl_register_and_init() or pinctrl_enable(), which both
return directly, leaking both clocks. -EPROBE_DEFER is a routine
outcome from pinctrl lookups during boot, so each deferred retry
leaks another reference.

Route both through the existing err: label, matching every other
post-enable failure path in this function.

Fixes: 16ad2bc09efb ("rtc: stm32: add pinctrl and pinmux interfaces")
Assisted-by: Claude:claude-opus-4
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 drivers/rtc/rtc-stm32.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index d4ebf3eb54aa..e7a942f6c190 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -1175,12 +1175,16 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 	stm32_rtc_clean_outs(rtc);
 
 	ret = devm_pinctrl_register_and_init(&pdev->dev, &stm32_rtc_pdesc, rtc, &pctl);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "pinctrl register failed");
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret, "pinctrl register failed");
+		goto err;
+	}
 
 	ret = pinctrl_enable(pctl);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "pinctrl enable failed");
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret, "pinctrl enable failed");
+		goto err;
+	}
 
 	/*
 	 * If INITS flag is reset (calendar year field set to 0x00), calendar
-- 
2.25.1

