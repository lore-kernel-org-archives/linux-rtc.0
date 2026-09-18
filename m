Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C645E509EE2
	for <linux-rtc@vger.kernel.org>; Fri, 18 Sep 2026 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746879; cv=none; b=ugprxAaVgNu70kWXw0cXdtIeTDG8ldRpzhtAIp3cHyEpLtGVblClQzClVU3nqJMD7H6H9OKpL5Za7IxIJpUN/R+n3vFkGWKN4UlMucGWsEnY9UtXRyHW/4s3mvt0QqsXmueq6iFMZkjD8Q9Ssz9qeSi9ljuSGM9wQta6F/B6gV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746879; c=relaxed/simple;
	bh=vnibq2jyCCC3IOg4Uxm2dHT0eG7ETbRhFgTe5l/Ddz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BBeEfs43DHFf4Jz0iz7ef2boUxgGc3AExWnDZZ1+o4AnaN6fnFhokd7W+GOVbZdQAISY+hwS71tweEcBp8FM+tvPq+SRH8p/R6/H2r859mnLOl/NbjUOPfxxDSEdt1kG2iKEZlprnbA5z/djBfKmyD0deDsJ2uQ1KwLFtq0L0qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tJHQjUHr; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJHQjUHr"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469e25400so750058b3a.0
        for <linux-rtc@vger.kernel.org>; Fri, 18 Sep 2026 08:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789746877; x=1790351677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gkZT5+6MT1neXTSrRW8cuNq+wdvBlgmd5gXT5DoC4rY=;
        b=tJHQjUHr7pyNE4WRiDsGg8HFr5ZwPDVMTrBjC0Edwp3rcuNkagHNCpK/MwcQgOn+a+
         eKs0BI1QlhyivqSA+dW2AbGMcKZbfg4TEvWt4Ky0HDJ1VroauXxYt+2N3JP3io9oJkrc
         Kyphdstvc+ifrvBwGMVJQdnDai/FLBfznW/cd270E4yidBEDa/KZqTXk//S64Lg5ozHt
         axLM8Gac1vJyKivFcd0iS4/V2oq0rvJZc5ncKnEm32UYzlakwZFR53rpHY24YcSy8oSX
         iHjX+bXNTWVM9AW12qvxAB7JJiis4RAbaPak2NcF5zGHsEM/rxi2NYkglz+od+8bRbVp
         YVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789746877; x=1790351677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gkZT5+6MT1neXTSrRW8cuNq+wdvBlgmd5gXT5DoC4rY=;
        b=jMvLX2uccPkfJDilXFEzN6lu+OGpm93GKt6jqfQujTMxk3bevSMEK6CNcJmlzh6VqY
         MxUS6T53zgMM9233yFuRnHK3rWcZLnH7oKFMxS2KCdwY3g8fkGubJteJSA4uALi4s7Pa
         YRnaXpeQF/nyNW8KeeTdDV9nDHTt6/Br7plfMBei69KbA7MZ/mna3yR2nrhAcbGPXNb1
         Q5uR/CJQdwoGbKcnraDolpBb8FNgX6I5uJhJuf+tgkCcmlRoX65VBaRmX5NyBujEwAoR
         NpW50mkR/GyRjcognoIKvKL3lfjfyeDCnazX/uMzspH22XZXz+MWlyB9kXzGp5LtRLn7
         7Uag==
X-Forwarded-Encrypted: i=1; AKwUvBypt6a5EnlvdTo899JkHoa59IaN4BHo9P9F4u8M0n2y9gz7MCSwiZZnf3G6EVARsTyCLMENViFdPAg=@vger.kernel.org
X-Gm-Message-State: AFuF++l6OpK64ltpWxvhw4eBLgL64QLWZcCAsYUpBO1rlU1gTYXfURCT
	fAdajOwb+7eZZKnXFG09N+xlttKopNHaaR8xm2KeUWn50YPJ4LT/ZRxy
X-Gm-Gg: AYBFou1O0netX1zVORxJVpkJ0jW1OItNEyicVOaHQBPvyzPjGN3zNVrJJmMuDlVhIYu
	nsC0zZ0nQEVtz0ND/by3xJEiFkC3Ez7akpilzsccovdASFCNLlTobY+tdPnsFvJaRc2RllKoVZL
	05pvbnT6yElPowNDobRS0LQxkeTokp6px5cFWK+i+JrbScwFy/tB++erOifPebFxgp2ELqYx+jc
	/aT8Cfmio+N3dU5l3m3WHMAL6hD/AO/bFkGffnnWRRlqrxIuUVeQHZ05xg+I6P1dW873IMq0rRT
	9FO1eQNHWANBCORgIX48VOJLwVgbuLzMYSVbOt9lIR1ocMMRQOrpuyXZqOnpbWCR38r+j5vMyoJ
	xJ9/MkP3XTxFD4U2rdtDGGLK3AOhcBh37mkltN6AFdFWy4gP5Nq8lsiENAyIVC3CccUQ4ZPk6jm
	XFLYAvtMiYpJHpBWFj8VFICYM9SRuFr4KYfg8KabL6IC85g9kH96AdZr+nQoXmrRCIsOaQWwcnv
	uIVXf2cpGhIvKk4
X-Received: by 2002:a05:6a00:90a9:b0:874:705d:f64a with SMTP id d2e1a72fcca58-874decf71f5mr5476461b3a.44.1789746876763;
        Fri, 18 Sep 2026 08:54:36 -0700 (PDT)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-875dd8dfa1csm1091058b3a.46.2026.09.18.08.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:54:36 -0700 (PDT)
From: Cong Nguyen <congnt264@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-rtc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: mxc_v2: fix wake IRQ leak on probe failure and remove()
Date: Fri, 18 Sep 2026 22:54:29 +0700
Message-Id: <20260918155429.2549137-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dev_pm_set_wake_irq() in probe has no matching dev_pm_clear_wake_irq()
anywhere -- not on later probe-failure paths, not in remove(). Switch
to devm_pm_set_wake_irq(), which registers the clear automatically on
every exit path.

Fixes: fbc5ee9a6955 ("rtc: mxc_v2: use dev_pm_set_wake_irq() to simplify code")
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260914134826.EC26D1F000FF@smtp.kernel.org
Assisted-by: LLM
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 drivers/rtc/rtc-mxc_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mxc_v2.c b/drivers/rtc/rtc-mxc_v2.c
index a07acbbcfaeb..7080aaf9ffa0 100644
--- a/drivers/rtc/rtc-mxc_v2.c
+++ b/drivers/rtc/rtc-mxc_v2.c
@@ -302,7 +302,7 @@ static int mxc_rtc_probe(struct platform_device *pdev)
 		return pdata->irq;
 
 	device_init_wakeup(&pdev->dev, true);
-	ret = dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
+	ret = devm_pm_set_wake_irq(&pdev->dev, pdata->irq);
 	if (ret)
 		dev_err(&pdev->dev, "failed to enable irq wake\n");
 
-- 
2.25.1

