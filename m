Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B2D46AA81
	for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391940; cv=none; b=nZ0BA6ak+u8hU7jaASA3Bdun+Ckvhrj+zDOlapremgY82VnWc6t/BzFK44ujKoRBcUoseEG1AI30ZEXuFEZsOGhXte8kMGvXCBgIMP9sOojYd3DbRrzHCh5TCHv4bMTbN/T0tAisew9KBKcuG3QFaKVhZrXk5/cE6XL0h+72qKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391940; c=relaxed/simple;
	bh=KdKxNSK2EqzOJkxmWBpgLJOR0R0yxWfK4EduhOCNn/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sZwHZ8bOukWhORc7dPCp4I15W43ifYgx92bw1Bqj/y5zTedqbnuKE7k2P9UBz1h9uiN4xDUYYMPQhwDJNeP6z5QEZqjOlmkptOxwB5O9he3k+vwngR2T6MS39o/j0TwyyT1Bj35ImoBJxsXX5fX5qqd6YkD+aLEgplYGkDsLTHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDCfSrOS; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDCfSrOS"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebcb8d7so396130a12.0
        for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 06:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789391938; x=1789996738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+CtYN0tgKPETVlmb678BLgBAA4im2S7f1euATyuMTj0=;
        b=KDCfSrOSQ//Xg3o3nxSj+DFByzN8ywv2juXCbxy/6m8sURpOxDB4hOeYTKmqw15w5u
         6UQZlHxNlQtik8GYKeQfdoXnvhbC0yom1cL/A5ToPd6hlehj82qsHnV1FzwTT5dvrJIW
         5TmAk9+Bv+WYzMXYCvLSt73O4Pf53cD+zWaCm4wOLhlTWJgXxTJXgq2DdfE6U4/3APCp
         wMqegRCVpZGiafYisp/fBYHPEe+/WfWj05PU8489F6xiyzy3ea5yIl/iv4RTLlJfgaFo
         zTElNEJwmb52arj4HQJw794S4r6zMlHKMtqNxRs5apq/XRO1wZKbz6GhJRjbgNTTCVEw
         vkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789391938; x=1789996738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+CtYN0tgKPETVlmb678BLgBAA4im2S7f1euATyuMTj0=;
        b=A8WokXAuG1SF8mGAbAqFLMf75SexzB0D7W6pkqP3foX+5dOxM/XCu2NpVXBIhMY6KG
         w3t/Y4HFSdxMLWUx8gDyshyVdUMXEDQhIcgOWsLEVt22f8V0bqs5OnJdR+xSWMXkVy2s
         ebP+G/n6RXs6jlXp4ay7uaOB/QChP0+00g4wC9OcUiu1OSWUI9PnOx4QBXHEs/4zUw9y
         TxyILMrQmhy9UKW9WZNHnO2Wlq+JA4EN2OJvXr5+O1cEsDqficZuyNFvIpxrDtgIvxcz
         i5jFqu7atlo4OfU5beiN/lzXgnm/fhqtj7J4LMDcNbWIFwyZtzYW9Ilv/0DCXM3lU0X0
         EfaA==
X-Forwarded-Encrypted: i=1; AKwUvBzeFUexmXxQcxo2NRwRicq3wNhUsHBABeAWaLVIXWnjhVqZl72rZl4I8jYZnyPphhgqEFYPY309ouA=@vger.kernel.org
X-Gm-Message-State: AFuF++lMy0l7CdGvPh6l2zQsZikozJe/1z+k0WCPipBQ0CAQNh88F8DD
	Sw7qtn+vj5eoLqfomjXml+5f6JI3cXY/KNtOtNG+BKGyZ/HL1ehqzeFH
X-Gm-Gg: AYBFou2S3el5FuAb1gfdFpzmmAM0K4Yona/YwQVFkYwSJOjLHbyzFuAXCAWXNME+zw3
	X7TvrJPcLV6eoJVKY1d+UD/hVROJrWqjMaWOxgZb6hr7b3/vXxSTHO9dqQKmIRbH/6Wm4HgxDa5
	b5jL8sYWl7Gz757Zlnp2iyb+ZqmAt2U7xpzDH3L6CEhBzLmlDvQ/7LXpD4ypYb5ZLknCUj6mpo8
	Tn+CgUZuFIfGQsmK0uXt6dmRaID7yTp61BtJRsudAJyeledpZxKeaO1uT/9fmU8dul4BSlBvEcv
	/PkTV/1RqQkFEMA+lqdnTK71UeesrnxUzMfOPjSv+6BRqs/dQlig0Qpl3n1hAQnvNdYFstBymIN
	x13kdZ+XsAuErmi+Xqf6nvkgb9LnsiFVEc8Ej5GM1VI33yCGlaDahl21lpRdvq7+TvZaMz3ur2w
	0mL3DSTdAEw4CPDTjPtq3LA+ahm9iF5AfraTFTnZLBwdn4NhKqpvUvVjx7cBs7qiCAGIe5CujiE
	Xle31YBIEFcyvI9
X-Received: by 2002:a17:902:f791:b0:2dd:7370:e19e with SMTP id d9443c01a7336-2dd7370e21dmr12996905ad.16.1789391938060;
        Mon, 14 Sep 2026 06:18:58 -0700 (PDT)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd4007bd4dsm40753855ad.4.2026.09.14.06.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:18:57 -0700 (PDT)
From: Cong Nguyen <congnt264@gmail.com>
To: Jacky Huang <ychuang3@nuvoton.com>
Cc: Shan-Chun Hung <schung@nuvoton.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: ma35d1: fix permanent clock reference/enable-count leak in probe
Date: Mon, 14 Sep 2026 20:18:50 +0700
Message-Id: <20260914131850.2331670-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ma35d1_rtc_probe() gets the RTC clock via of_clk_get() and enables it
via clk_prepare_enable(), but the struct clk * is a local variable --
never stored anywhere, and the driver has no .remove. So on every
probe, success or failure, there's no way to ever call
clk_disable_unprepare()/clk_put() on it -- a permanent leak, and since
CONFIG_RTC_DRV_MA35D1 is tristate, each module load/unload leaks
another one.

Replace of_clk_get() + clk_prepare_enable() with
devm_clk_get_enabled() -- same clock (both route through
__of_clk_get(np, 0, ...)) but devm-managed, so it's released
automatically on unbind or any probe-failure return.

Fixes: dc0684adf3b6 ("rtc: Add driver for Nuvoton ma35d1 rtc controller")
Assisted-by: Claude:claude-opus-4
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
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
2.25.1

