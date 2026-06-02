Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4140C23ED6A
	for <linux-rtc@vger.kernel.org>; Tue,  2 Jun 2026 03:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780372317; cv=none; b=BcBSReisBCAAXp0RjTu4prjYCP+xkSGZFc+DktDTcOude07mrp+GGLMmRfKbduGXAcl3OJjFHJVcKuwADpAda4EiU2cIhAZVaVlBpVZRlwfzX7uKd8GxLldL0qLxj6v0grpGdYJazb3F0KhCkaIKAofUfjmD43HifgvEQ6bIxRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780372317; c=relaxed/simple;
	bh=1YO2Q5tPHU0duhqz7IUetUZGgIMV4bPyoyR6VJI0MUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XpAJMzf4Ts0dh/aqKjnx3IhRxV92Ivbdr7sEydiXpiZvv/lH080mmATeEIM0EKz4I3JGhXHNUoeN999dxA0YThXkDsLkgzsO95DqpJ9oTuL5IRkZpbYriWmzlkPoWNXUud7Fw2vgCGnuFpTC2vsUqSFDbdt/iqt0P0HHNnf8nyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNt1eaE+; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNt1eaE+"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-304d0ac5e3cso6706179eec.0
        for <linux-rtc@vger.kernel.org>; Mon, 01 Jun 2026 20:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780372315; x=1780977115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i+KNtW5JrHCEx2Gpp74agRibw3LqoXVEZ4zqVBpQiM8=;
        b=DNt1eaE+s9Dkne1Gy5zs+Ny1cnuG6Oa11UrVcgJAcA1bq7nQYrNzrWFVm2WRpyq8AT
         MOrMo4gZfXsUE1RrZkbQ22CemGZSFTK/360AY7XPM9GS8l1moym1UNmXDrOX2AHDE9mB
         w/QrFSv57RjVsOinYk9NNCzm7VYgSRQ2ouZdCkfQHSEiG0ktF0Qmc6xTg1hhPOzYtRT/
         VcbWP52xH1jebBPODByMtPDVafAM3EY5uTqT6sYgHYIz3wjEgzdqpZQn4/2npZQl/L6P
         dxdVwPFPnBAyX7VjP35XDH3uBDBsfuJTdfT8THj+SaxO0acn7rshI/+p89teOidthhV0
         KROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780372315; x=1780977115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+KNtW5JrHCEx2Gpp74agRibw3LqoXVEZ4zqVBpQiM8=;
        b=Ol5cvZBmzJMaumSCSiqH9qZqO4ODtxM/7iMJV1uz/DO+n0vLqRg2q8/9yaElTY48fr
         9Ovqzg5TFyo9u9KvvaBkBjxUw9yA3TRtiL51+83S92qNv94TU5af2PRcBvsbhcXaM7Sf
         jRGsYxbtsTOCuwgoxJxMFZYCx53TyrGqKzaDpUp+ERYPT9xhA8ijUQ0ndBl64w4++zDb
         z+u3L6NSEhf9QYTPMld8Np3ij5EiUtpJQOka8Z5vUAg+1zNsTj9hbqusClQ5AcfiODJw
         cSdE1xx2+r8M7jL/23UFr/N8KmctT541M9d2a0zMnP2t0ppXJw8BFDNdcHw5clOvr8DP
         LlLg==
X-Forwarded-Encrypted: i=1; AFNElJ/D08YUAK9YcwIL2vg2cN9uZWi9htXAfmy+iz5laNC0iXJk7KnW5BMgRxx5uqgZIpUraC05nKBSyZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIdJ9o/DdwBkcs3UjwZ9KXrdRZYZj6mru1MiSNgLE9axlk3PMp
	uRLpS86RBmOfi28mEaELsVumFGaCE6BTJXeT0YM8x9oLIUr8k4RjxuzK
X-Gm-Gg: Acq92OE4irN6k+VpmDE7+kD0z7xrJkRJD+uefERmpx7aPX7xH7xs7Ds5Wr37fc3y19h
	j6Lfq//N51Wsvb4ckNRfgWCHTrjAOAhkQ/5tm1Me1DACYsplP4RSaiFgd/OwCgThfWXsAUlcSaR
	E2dD1obSita6Q+X7KFtlNL0zXtytgK/scw9CN3lMPiRlkU5chK5QDl+vTtIU79m/dPKzOh2CqOs
	GgSNrRyRHYZIljuCrqRQR2X4qsywjkQ8o9gybZy4vb26U3HybT9LwE7tp4gqMTrkkUiLgU5djWu
	jpXfJVQIJhTiVkv/pE6gFaWM7BF2D9BD+DvCIu7hmaONyywioaCGc2IAWKpEs8FD+XxHHr8gYVQ
	zJIR7uh9zhtnxaEI75sTly5sSEBh4lsafz+lU1A+aw+XBTPSlBbA08RARGXnqcniPma1I3T1JL+
	9Vr+Qwra4YVX8nLGG3FCcKUa4iKagyrie+A+xZ1s5sabK4q8kZWCOy8DPY7x2SE0xD6FG4VBoU8
	+uTuXdTK46iPS0epmzuC2b3vQCTpBtghVlqXPjZ3ew2QpFE8WL0Gt5+Y2fhGKUeee4gFpDmbADR
	sc/pOsxRgg6/eUmXN5DI2gycFWFZCVoxy28sTKl76dfdyF96p1DfL2kHAIrUxvVw00M=
X-Received: by 2002:a05:7300:e58b:b0:2ea:ed3e:13b7 with SMTP id 5a478bee46e88-304fa529392mr5686850eec.7.1780372315250;
        Mon, 01 Jun 2026 20:51:55 -0700 (PDT)
Received: from odroidn2.. (c-67-180-34-11.hsd1.ca.comcast.net. [67.180.34.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed53f002sm10969668eec.18.2026.06.01.20.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:51:54 -0700 (PDT)
From: Yi Ding <yi.s.ding@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Heiko Schocher <hs@denx.de>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yi Ding <yi.s.ding@gmail.com>
Subject: [PATCH] rtc: pcf8563: fix clock provider leak on unbind
Date: Mon,  1 Jun 2026 20:51:35 -0700
Message-ID: <20260602035135.62264-1-yi.s.ding@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcf8563_clkout_register_clk() registers the CLKOUT clock provider with
of_clk_add_provider(), but nothing ever unwinds it: there is no
of_clk_del_provider() call and the driver has no remove callback. Each
of_clk_add_provider() allocates a struct of_clk_provider, takes a
reference on the OF node and adds an entry to the global of_clk_providers
list, none of which is released when the device is unbound. Every
bind/unbind (or module reload) therefore leaks a provider structure and
an of_node reference.

The clock itself is already device-managed (devm_clk_register()); only
the provider registration was not. Use devm_of_clk_add_hw_provider() so
the provider is removed automatically on unbind. Tie it to the parent
i2c device, whose OF node carries the #clock-cells and clock-output-names
properties (the RTC class device has no OF node of its own).

Fixes: a39a6405d5f9 ("rtc: pcf8563: add CLKOUT to common clock framework")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yi Ding <yi.s.ding@gmail.com>
---
 drivers/rtc/rtc-pcf8563.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index b281e9489..7083d9278 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -449,7 +449,9 @@ static struct clk *pcf8563_clkout_register_clk(struct pcf8563 *pcf8563)
 	clk = devm_clk_register(&pcf8563->rtc->dev, &pcf8563->clkout_hw);
 
 	if (!IS_ERR(clk))
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		devm_of_clk_add_hw_provider(pcf8563->rtc->dev.parent,
+					    of_clk_hw_simple_get,
+					    &pcf8563->clkout_hw);
 
 	return clk;
 }
-- 
2.47.3

