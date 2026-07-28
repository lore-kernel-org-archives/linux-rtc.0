Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8AC233938
	for <linux-rtc@vger.kernel.org>; Tue, 28 Jul 2026 00:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199525; cv=none; b=hTAlyFgiU1j32B0ZhcmHMN39cdiELUHLmTOtPdqw5a32unnjOM4jloUHhs6nerbnP3Uzrn94mFFE6W18RS9+0mpin48rRGfmCe2EuLyhOc5inuIfsbyVbVHR9xx6gknSe5Fz0E9f703eqjEc2EJZ08DjoZabeJfNEKKI7AqHW1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199525; c=relaxed/simple;
	bh=+bEpJy2yiNbZZHwHHMgE03n2oPgR8IpRFJtm8vxMDNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oyo/w99GpqsyKIqm56s91wWege+XrdUPQR+qczhpAiDjDdNBh1bf/A7GLYNz7tol+uEhMB6+KOuMcbshVNKHZVPyKkEPewr752IsIFGvDkszkR3uybLS2jQsJAS5xNZtB5xoooi/H4FFQM8Qi/ygtXfg/3tH/ndoHm5u8bAUOnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XC+OehMk; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XC+OehMk"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92ed19f4d60so33719585a.0
        for <linux-rtc@vger.kernel.org>; Mon, 27 Jul 2026 17:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785199522; x=1785804322; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wgqEqOeHHkV3aH841yVDpBMSyC3TFYyEh0HcssbHjh0=;
        b=XC+OehMkT26UtZBwCDWt1gjHU5Da/zBZb3hCYHPYAI520LxVq/k/UA22Lb63Yw+gor
         qpzKhb1fXijN3DZfOnObKqR7lvYKoEPOGfSl8tjgpAG7Ay3jVfpL7JJUGtupUHsxMcfo
         UcZrIM+/ZBCHP7Tyq0twKxZ5MhlqSLD/C02U1oCDu625cAqh/VhlxEkDRI2PLK8ZsHNK
         fgQrU9SgJb9MKj34Iy8S3e0SZH/kmkYXDnCPDxoZlR0uGG/RSeFyuwbVzXfNch6QzI48
         7dsLcu+dFwGLd2Q5zvRBBsp/xKcb1r4t/sQlOFZtVNTA+bJR3e8sWDDM5o+hVYfltteF
         PBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785199522; x=1785804322;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wgqEqOeHHkV3aH841yVDpBMSyC3TFYyEh0HcssbHjh0=;
        b=dVx2PwOh50GlMN8snElQI11NWwvGpbtuwTpXfnVrlM86StMol9ZUS732CK/p3z686e
         5XP6tryoZhm//B/0mOdizAo1mhrRw5wsRyKtIdx+HiLtRcPI3z58pVV8ijimy7AvjVNQ
         9FwFvqjjHKLzJIc4NOC9vk8MMtnzKOIp7AHZwCD8Lki3U3thG9WAHMYZI1cfl8tcZc9T
         SOs9TsHwTJSFo/twwxi+Z+MPpBxFK9eomNmIUQ1tQp8oCC74WulzpUTFZNI8Vw5KCg5H
         Wjy6N6dVXywXGAbn2CAUoT6tPhub9RjuCn+rb3ytAZtJgz1AdCtjmLKTysCzlV/KfDTN
         PPJQ==
X-Gm-Message-State: AOJu0YxVe+ZRsAjg1eAqZiewJRPAzBQPW1yYLZEysoXuStzKoAzj+d5d
	XrDsckILRXGLHMBEZDX6UcNYD+0uH9pHuYxJi0s5IiC1X5tBFddXya4GUbmp5YnT
X-Gm-Gg: AR+sD13oPywPBtfuV2tItBWUySfdBb3/yMSuDcB9yv4RVap/cX38gHfuws91qTeyA40
	34SKYdL0L+QqX8SSrpjWiH3dQ+BufORm+RPutE0LA+9KJg39LaRD78dHmHdKN6tUx9I+Tkyqyl4
	F8ZD/HwNLzysC9M0wkB9ux4kieLtXsop2YDddQRXvvoFaMYltUumUZ6NaP6Mk7uBWKAjM/0KoJG
	GSGoj5LDsw/ow//KqkCdM+v+7ZsF12kG5F7BGkA0hvE8VDjHMD2c5mqDGz3JxZOUyudyjOvAYmj
	h6ItKfw86wOjqUC2kxUPZbMoS5mfbGojk5I6o/XMRCjPzcKSvXsFJijRtuWp5jTwBvBkyOsOMwY
	pAaCDWK6y6d3Uq1/NUx7mor8wVfyvVVtb9CLTMBahVw/ZieHvXfWgJuEQDKYj2nt69fn2j+JvMv
	GaCHGHsdtOMZLQidKkdrqq/08YM+5s/9jH0iU4wmHg3gwTf5L/5Lekfib+4tFpUmtohcWL+xHbO
	CzFcn7kAQYJ1Nnd7Nfy2QMFMUnsdQv+SHPBxCdg3rlhn6hJzKH/EzQ=
X-Received: by 2002:a05:620a:4713:b0:92e:fed1:beba with SMTP id af79cd13be357-9330260fdf1mr20168685a.3.1785199522276;
        Mon, 27 Jul 2026 17:45:22 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de1dcef6sm721689885a.0.2026.07.27.17.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 17:45:21 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rtc@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] rtc: mpc5121: convert from irq_of_parse_and_map to platform_get_irq
Date: Mon, 27 Jul 2026 17:45:19 -0700
Message-ID: <20260728004519.573980-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

irq_of_parse_and_map() is an OF-specific low-level function that
requires the caller to pair it with irq_dispose_mapping(). Mixing
it with devm_request_irq() creates a lifecycle hazard — the probe
error path and remove both dispose the mapping while the managed
free_irq is still pending, leading to a dangling descriptor use in
free_irq().

Switch to platform_get_irq(), which is the standard interface for
platform devices. It returns a negative errno on failure, integrates
with platform resource lookup, and eliminates the need for explicit
irq_dispose_mapping() calls since the IRQ domain core manages the
mapping lifecycle. This lets us drop the error labels and simplify
both probe and remove.

Remove these irq variables from the private struct. They were
originally used to free the irq in _remove. devm has replaced that.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>

m
---
 drivers/rtc/rtc-mpc5121.c | 59 ++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 38 deletions(-)

diff --git a/drivers/rtc/rtc-mpc5121.c b/drivers/rtc/rtc-mpc5121.c
index b90f8337a7e6..964d9594b1d7 100644
--- a/drivers/rtc/rtc-mpc5121.c
+++ b/drivers/rtc/rtc-mpc5121.c
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/rtc.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -72,8 +71,6 @@ struct mpc5121_rtc_regs {
 };
 
 struct mpc5121_rtc_data {
-	unsigned irq;
-	unsigned irq_periodic;
 	struct mpc5121_rtc_regs __iomem *regs;
 	struct rtc_device *rtc;
 	struct rtc_wkalrm wkalarm;
@@ -292,6 +289,16 @@ static int mpc5121_rtc_probe(struct platform_device *op)
 {
 	struct mpc5121_rtc_data *rtc;
 	int err = 0;
+	int irq_periodic;
+	int irq;
+
+	irq = platform_get_irq(op, 1);
+	if (irq < 0)
+		return irq;
+
+	irq_periodic = platform_get_irq(op, 0);
+	if (irq_periodic < 0)
+		return irq_periodic;
 
 	rtc = devm_kzalloc(&op->dev, sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
@@ -307,30 +314,20 @@ static int mpc5121_rtc_probe(struct platform_device *op)
 
 	platform_set_drvdata(op, rtc);
 
-	rtc->irq = irq_of_parse_and_map(op->dev.of_node, 1);
-	err = devm_request_irq(&op->dev, rtc->irq, mpc5121_rtc_handler, 0,
+	err = devm_request_irq(&op->dev, irq, mpc5121_rtc_handler, 0,
 			       "mpc5121-rtc", &op->dev);
-	if (err) {
-		dev_err(&op->dev, "%s: could not request irq: %i\n",
-							__func__, rtc->irq);
-		goto out_dispose;
-	}
+	if (err)
+		return err;
 
-	rtc->irq_periodic = irq_of_parse_and_map(op->dev.of_node, 0);
-	err = devm_request_irq(&op->dev, rtc->irq_periodic,
-			       mpc5121_rtc_handler_upd, 0, "mpc5121-rtc_upd",
-			       &op->dev);
-	if (err) {
-		dev_err(&op->dev, "%s: could not request irq: %i\n",
-						__func__, rtc->irq_periodic);
-		goto out_dispose2;
-	}
+	err = devm_request_irq(&op->dev, irq_periodic,
+			       mpc5121_rtc_handler_upd, 0,
+			       "mpc5121-rtc_upd", &op->dev);
+	if (err)
+		return err;
 
 	rtc->rtc = devm_rtc_allocate_device(&op->dev);
-	if (IS_ERR(rtc->rtc)) {
-		err = PTR_ERR(rtc->rtc);
-		goto out_dispose2;
-	}
+	if (IS_ERR(rtc->rtc))
+		return PTR_ERR(rtc->rtc);
 
 	rtc->rtc->ops = &mpc5200_rtc_ops;
 	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtc->features);
@@ -356,18 +353,7 @@ static int mpc5121_rtc_probe(struct platform_device *op)
 		rtc->rtc->range_max = U32_MAX;
 	}
 
-	err = devm_rtc_register_device(rtc->rtc);
-	if (err)
-		goto out_dispose2;
-
-	return 0;
-
-out_dispose2:
-	irq_dispose_mapping(rtc->irq_periodic);
-out_dispose:
-	irq_dispose_mapping(rtc->irq);
-
-	return err;
+	return devm_rtc_register_device(rtc->rtc);
 }
 
 static void mpc5121_rtc_remove(struct platform_device *op)
@@ -378,9 +364,6 @@ static void mpc5121_rtc_remove(struct platform_device *op)
 	/* disable interrupt, so there are no nasty surprises */
 	out_8(&regs->alm_enable, 0);
 	out_8(&regs->int_enable, in_8(&regs->int_enable) & ~0x1);
-
-	irq_dispose_mapping(rtc->irq);
-	irq_dispose_mapping(rtc->irq_periodic);
 }
 
 #ifdef CONFIG_OF
-- 
2.55.0

