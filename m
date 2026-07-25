Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED702FFDD6
	for <linux-rtc@vger.kernel.org>; Sat, 25 Jul 2026 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784991546; cv=none; b=D6ilrRLS1NkGO12olyj4THT6yClqFaMm7K3XpXwbvVnIxIl8XLhWwmq95WLX5j9mmI6cWJ67+shqV4ojYu9eQzDUtDoRCW3euXjb81K7FFs2meMlgYgcr9aXDYpSeY+1+Gg1xdVRMeAMlaQ7xvZsOfqiHCTUDJxsiU2a4odBqbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784991546; c=relaxed/simple;
	bh=BtqsvE/wgpRZr51N49eAjks9p/lKsVmFDtj8ZC2sh+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAbpo2pHMO60/Irr4pFY3GJc2dAjZqH+DNNiv/8cPOn7TI8st+y+DtrLVhYSXJHQ893TZhuFt7gcQasLjyHfSOUId78iEHoYuf/youcGSn054kbp4LE/aFb32xUXyPrIY1OuxVrwzb9DfwTt1Ki70Y3e7pJsSbdfSgxd0uG7TrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBq23vEr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBq23vEr"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-495590ba856so12232435e9.2
        for <linux-rtc@vger.kernel.org>; Sat, 25 Jul 2026 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784991543; x=1785596343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=40xErOTdJfX+m//AZE6fjm1QH7PFCUhAcYFlBcQFjeU=;
        b=SBq23vErx/JrnTeTwwQgX1JcZiJPBH3Xpl24ZOpLyNcC86fGMP3ZX/xSNKSa1/SJDu
         Cg0sV57uT07ZdO7M5nuIA0ypcDLiIpyR5uC1lqOY2U1xXocnzTXz7Yggpwrm4rQd+ZWD
         GHOAWJuOZX+MvZkCTSmiiymBbSeBu+L6vu37x4D/L+y0YPBkbEf9lwopvJogxbrlFO/f
         O+QYNkn/CJYBpbiIJSLFSUlUUGe3++LNTVRGB5hWAMZ5ezbNbSypmzaOOE1ttgBaxJnU
         NRmmjygrn2qgdUZCcZex1bUMwHof4PQUE5zQVb7Hz0X6a+qpnV52o5QO4Y4zTJng02/Z
         tSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784991543; x=1785596343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=40xErOTdJfX+m//AZE6fjm1QH7PFCUhAcYFlBcQFjeU=;
        b=B4VjPR5QhBdGNv8wMg3+4NwOea2PKQEiIIZw0kz7qrTZK7TtjmTF3CFBySiPVzc69/
         yiy0D2ipDQiulEatsTRBcz3E4YuE+vyDv2Rxs0xrE0qfRIa3qSGnDQt9mRRI9gwANBpf
         i+0c94zfdcmguzVLyfmB2qY9oRmrEKgo3/QRNOZBE1nqhTipFBonvlHxNRlig2nlMxY7
         Kpefh/yel8HyOCclb8xhTQOGGmyFjqy15hPso4Sp+G5zwTn5olHvB6yishyeVlIJWP+M
         z1nFLDuvK0/bn0c+T3MY8sF36GicrYg1m0KSTY9EBcV60IC5PP66qxCno5ZSIGzSMfAt
         9/Mg==
X-Forwarded-Encrypted: i=1; AHgh+RqjpKr2yLkvofiBHj1YDSU6/TyzKeS2cD3W9XP1wzcQkYfHFFBRImuHyqFr35xf/B1rdv2I8xqJ7JU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhra+fnetCuKi0RYy/DP77+1OCYIiVxK+qjOA6dN5UlesDHnp6
	J78l6+R5hZgDoSHpujBUhqrjrniyTp+0NLPmg54GcXVeBRGIVv1fpbX4
X-Gm-Gg: AR+sD12jRho9bq0b94VqO5x5H3/pXGYsg6MGgw4hlbAsJgvR8NN9VuDISkXvnxX06NW
	Xlc70/6zNZ7/8FqtnGT1re4/L92JBzNAVhuAPKXIml4EX1JQpJYSxMLvSKB4DQwiMLnePqq6qOh
	td4eV9VvsVdYlH1QZyWlglkl0TRLnuqzV9sja+S2QcZMF+zITDELZp4dKqc1P8W+JDD7gk8CJ52
	BCyNG8uJuREv6fYQDcSSYlRARQ8U+90snMPJpZitPcDic/b92C83LEqLeDrjpS3gGcJrJrw64f4
	UDH2K8kkW/q3l/KuAntJC+fd1BoQse2VFZfuEx2s1tQmWI32l0JAu13AMlemgCuHhvb7gUrMc/4
	1GP11IEqsHf57sxMoPOrF2oh0529qYIyBAFd/q33gAZ9UJIRySkdA+TYO+G1q5xvHNFW4SLQzfB
	0ENg==
X-Received: by 2002:a05:600c:630d:b0:495:5dcc:52b4 with SMTP id 5b1f17b1804b1-496b56bbe6fmr33100545e9.3.1784991543121;
        Sat, 25 Jul 2026 07:59:03 -0700 (PDT)
Received: from antoniarch ([78.212.96.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f24a93sm79704435e9.11.2026.07.25.07.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 07:59:02 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: marex@denx.de,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 3/8] rtc: abx80x: properly handle shared IRQs
Date: Sat, 25 Jul 2026 16:57:13 +0200
Message-ID: <20260725145718.14733-4-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725145718.14733-1-apokusinski01@gmail.com>
References: <20260725145718.14733-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The abx80x RTC driver registers its interrupt handler with IRQF_SHARED,
but the handler always returned IRQ_HANDLED and cleared the status
register even when no interrupt source from the RTC was active.

This could cause the driver to claim interrupts belonging to other
devices sharing the same IRQ line and could also clear unrelated status
bits in the RTC status register.

Only handle the interrupt when the alarm or watchdog flags are set, and
clear only those interrupt status bits that were handled. Return
IRQ_NONE when the interrupt was not generated by the RTC.

Fixes: 718a820a303c ("rtc: abx80x: add alarm support")
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/rtc/rtc-abx80x.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index ca3af91c2997..fd9e887bb9c5 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -261,25 +261,32 @@ static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
 	struct i2c_client *client = dev_id;
 	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	struct rtc_device *rtc = priv->rtc;
+	irqreturn_t handled = IRQ_NONE;
 	int status;
 
 	status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
 	if (status < 0)
-		return IRQ_NONE;
+		return handled;
 
-	if (status & ABX8XX_STATUS_AF)
+	if (status & ABX8XX_STATUS_AF) {
 		rtc_update_irq(rtc, 1, RTC_AF | RTC_IRQF);
+		handled = IRQ_HANDLED;
+	}
 
 	/*
 	 * It is unclear if we'll get an interrupt before the external
 	 * reset kicks in.
 	 */
-	if (status & ABX8XX_STATUS_WDT)
+	if (status & ABX8XX_STATUS_WDT) {
 		dev_alert(&client->dev, "watchdog timeout interrupt.\n");
+		handled = IRQ_HANDLED;
+	}
 
-	i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS, 0);
+	if (handled == IRQ_HANDLED)
+		i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS,
+					  status & ~(ABX8XX_STATUS_AF | ABX8XX_STATUS_WDT));
 
-	return IRQ_HANDLED;
+	return handled;
 }
 
 static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
-- 
2.55.0

