Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FCA3BE144
	for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392315; cv=none; b=SjdCQJw6yUPFo287TXnMroU2q/QNhcW/yJcyKyuq7o/W+7HzAQNArybSf85SoJFlST5aEz0xbt84bTL5KecPv0C3c5w9y5WV0o6lOXwrfIO7LP/iOv872yuWwRCxfp1HMqRwdX4UiDoZAtYk/AfbOZ5kRcu4eR0j7n6msRoGFk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392315; c=relaxed/simple;
	bh=ieGOto/Lmqnuw6XZHi4NqzamoYlK1PHnKIFnRsx1XIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nCTrNrubvsySE7nl1T2XCK8BtyVRnDgEeEqMXMnl+1+qiAI9ER8pmyMV8sp08fkX6FDVBxdV9/KSSQ9J3SY/XwciOWgDySBErYczzZsMSt4+J8urgX1ngpcFZLi5RAx5xMgdnmEV3wS9m6Dl6TtVjrCU/RjZilNZB0mqQoQjpp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNkjnJIO; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNkjnJIO"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so3220164a91.2
        for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 06:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789392314; x=1789997114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a6EI5rX+MYKMYU0UnF1Il4E9mul776cfp5306LOEsvs=;
        b=JNkjnJIOv95RnFF7OQqjfRcWVxjkyBQLp1hJfZni/yHbA7/vwIh4dtqjfaQENxE5bD
         nzgDKGB5IxFdZTP9njwZZ2f4d9LArJklDUBu4WbZYsIHrG2qi8M9YWFxVkLYQrIy3EO7
         1E9OUi7aNR7/wyhXcLTtbFtnfMRJk3m3yejrjPbB/pqhAlyrVgXyvYz+lYn32zSjMghM
         pmlmxVo/+jNHcro2MJVHE78NCaeH4zomtWvCCZAAFNjcHcEY/9YHYs8nT5BJVkyP5GpI
         Hesc7WU0vj0Ol2wkWjUMEqFiWCKxBQptbjwORZlqq+e3UsXWnaNUh/Rft5FsSR2VBcuw
         rqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789392314; x=1789997114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a6EI5rX+MYKMYU0UnF1Il4E9mul776cfp5306LOEsvs=;
        b=Y3mbJqt3RCJ+//0Qx7e7emeHEGIu09okiDyK9GPzCxwGDsqXv+wPuVqHG/ew+9fIt+
         QbDBTdabbxltyZYVHFonEt3a6Pgo4fph5xJOyHetyahWrr0BuDFZ8U2DOeAbkbp1DICx
         UNRjHZ/NB8jeIf+lszWayW6XZ9N5P6Sa47qKCqIP8aaGyemCz44muS80dsV4zHCfonou
         zUE4g7OwKT7q4sBz6P/z3/J17mWPGwYflQpWl1y3xgKvIqrrGK0K58LtmGj351EqsuLc
         NkPa73JAIqbwU7v8SnSYc56V+n1xxT5uMEPvHFZwl8sYxtvtqLfcp9Th89kJMhXMZzxu
         dfCw==
X-Forwarded-Encrypted: i=1; AKwUvByu4ltMNxjggoi2mke5xsZPN5quoH1TeTjocWimJ8c4FR27RCSrU8YOpNQ1t5ojFR46T70bOhp4vTY=@vger.kernel.org
X-Gm-Message-State: AFuF++m3ZPPT0gLsAvbON9+mycEw3ZZ0tVi/xuMRYmx9hErbqHb7QMN6
	v9Qyhp/B6DS0za6g9C+H33Glrq9HvBFfVV+2QY0odjH/wvNZaxou/F9ancCKXg==
X-Gm-Gg: AYBFou3bxSoyTDncRYdJFON3ZZSx1oMnVq1jGPIvNbUMzDGkqBZ6wijNI+V+xVD8YTj
	0KkeXRoRHvtQHd32sTAHydshGXh3SMElfrNw2aA5JqANuytZxBwfSaE7NvICULyprijGrwf9kB3
	uvPkas/lV/2BG5qpGn7e1KSwNuwqvwQm16YUktbIKqip7i2MI2h+f2SY4QtGIx70PbbumEMAnJN
	ypGLNl9US/0InczP6BO1w742u3+UMhey2+218Kupf04L7fJhaQC25RCn8nm/9jtB3VXvqHZHQN7
	r4s+UXRRBE1RYhTezxkF9aPkMGpfUpRcRUZWVc9EP73K2o6cTtWpe2hzZpAFmPj9xUi8l1Pnk3w
	sIC3MGHRe3BdriRaM1P6jE4ejRoVVQ4LSqhD4HfiGXORoHJPu2N8SWeORuTjoHs5A/ok3y1NSYP
	UY8HjgX1W0WhR1y+pDqTyjA6TZaYwz4yDiBOaECNcx1laTV+N4l4uEp64YMgkzxiYXfDo4TjCjZ
	2qUD4vrCKszaW23
X-Received: by 2002:a17:90b:3b42:b0:398:d6e8:f84e with SMTP id 98e67ed59e1d1-39debfa6792mr5368605a91.9.1789392312963;
        Mon, 14 Sep 2026 06:25:12 -0700 (PDT)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95713602sm20872894a91.11.2026.09.14.06.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:25:12 -0700 (PDT)
From: Cong Nguyen <congnt264@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-rtc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: mxc_v2: fix clk enable-count underflow warning in remove()
Date: Mon, 14 Sep 2026 20:25:05 +0700
Message-Id: <20260914132505.2356970-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After probe, pdata->clk is left prepared but disabled -- every RTC
callback enables/disables it transiently around register access.
mxc_rtc_remove() calls clk_disable_unprepare(), which disables it
again and hits clk_core_disable()'s "already disabled" WARN().

Use plain clk_unprepare() instead, matching the probe-failure paths
which already do this correctly.

Fixes: 83c880f79e88 ("rtc: add mxc driver for i.MX53 SRTC")
Assisted-by: Claude:claude-opus-4
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 drivers/rtc/rtc-mxc_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mxc_v2.c b/drivers/rtc/rtc-mxc_v2.c
index a07acbbcfaeb..93dcf18abde2 100644
--- a/drivers/rtc/rtc-mxc_v2.c
+++ b/drivers/rtc/rtc-mxc_v2.c
@@ -365,7 +365,7 @@ static void mxc_rtc_remove(struct platform_device *pdev)
 {
 	struct mxc_rtc_data *pdata = platform_get_drvdata(pdev);
 
-	clk_disable_unprepare(pdata->clk);
+	clk_unprepare(pdata->clk);
 }
 
 static const struct of_device_id mxc_ids[] = {
-- 
2.25.1

