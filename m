Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581674DA559
	for <linux-rtc@vger.kernel.org>; Thu, 23 Jul 2026 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832437; cv=none; b=V+xmSANh4t8eaEL8DPrGF1lcj/snSTAnh+7Z1ku1pwihCLUZx5HoGpTwprCFtyMfn6AhK2w7rj2r8aO3TTa1GvGWSFKYmgIJ2UR92aGROMjOoyi8EW2b+MGti3H9Iuem8C8bmzZ3RnTWLxtrPN2qjuiAbIkeBGsk5chPk0DM/1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832437; c=relaxed/simple;
	bh=34ZFRB+t5TBTN8y4CUuvqqvfbV1iOyh2tVj2zJDSmAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMcdF+gaAMG9oef1q/H1TuG93ytu9tdjMDydWQf7+czQS+HQXvXbzxDmeQsrC/ycqqhzitvQ89JDjs9OI3mw2Ig8bzUBn0tpHtrJy1Rjx4qaQ9A5YgNGhdTSNdR14U9Jd0WVjrPD/OuFe2bIdfpSgTxHWEs7tiWdoFroSk2dOWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TD/1Pkc1; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD/1Pkc1"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso819304a91.1
        for <linux-rtc@vger.kernel.org>; Thu, 23 Jul 2026 11:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784832430; x=1785437230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SS85S9k55fKh3CHy42qY+ZLh5U3vliQxWiJO6SqlhjU=;
        b=TD/1Pkc1wq8iwAQ6o1mNDtpMuoZuvSkiuGwfhUneJRw1HzYJ5qGaenT5rbJhCPlkMk
         R/8P0GeILLaYJBuBLIkNvrunADMq40IVULA3BKz9G2K/rmUPWQzPoOAbjNYYXTlixg/4
         QOw2LsB0nNGeEId9vQ/SPB9KLPBhRJp+ejGxLsb0Jpi11z4RB4xfIBiULLYoMcsGwjZo
         zQBzcZN/GB3uSFV0WmiUyaW3mK06FdQOm7FVDt6aMoLbQjF2OWSg8FF9aWJBMV9pIejL
         2ixwjIBGwGPQX80PfBWJxl/dfv/8Bu7jzSBfrbthCE8L5rjPA2T6Lf15a3dXmbwi/n8a
         v/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832430; x=1785437230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SS85S9k55fKh3CHy42qY+ZLh5U3vliQxWiJO6SqlhjU=;
        b=nrHrX2Xue5EkREJKFgQ+B6uFr9Cums/l3dIkqkDzCWAxb6/o5wBLilocWubAwqu1Fc
         nGdDSRNQKH62rMrh/IYZomr0jGbr28yE13Gmo0ByLVGcRaNAOnJnPNvCsLbTTY+wabEK
         Udpttm3N+hS1BGBIw7HtWzvuDaH2tm87H540XbWcLdn46zxSFt35iQXKr6EVEe1ocSYM
         nqUrcEl+7an7aFV/bsjzrAQJIlTFlzwmq9Nnh9vVktEp/8FfKfRKaQEF83HjFnh6XNHu
         9ZtfkDW5T1V7YK+d8zfYMi782VHr6174z7Yfxxu/RNbWn7vFJk0BUCU3wkQuRU0e6HGK
         A3fA==
X-Forwarded-Encrypted: i=1; AHgh+RqKD5gGlyqxwR+SFGKM4moiKZczCPVi5gXlTyQhBmWlcyNL2NgaPtLbPAPHq7iYSuhRDSGBy8wV/nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+MwPMVzP8z+bNuTqeCcBfShQ8PBWkA6Kk68IIiKeKEFrW8QdN
	NO9BPRvLj8/+3CLbe5ySybMZ1GfwpbFVDBOAi3Ud3a8NqfdbNsdgrD5i
X-Gm-Gg: AR+sD13v65isluHpWhVlcGBaQ7nx+YachB/8JgVg1oSHIDaaK3BBrz9cTvisZowwlnz
	ISFrLSEIVBNnXTdCpKvxSJHfrtPFiDHAQEsFTYaemSqJpxQQHt+LzHBNp7TVSLJbVyHXTlohinE
	ByM1wTft1ZAQfUQyHQdhecJo7kUqXdvi0rKBXbpL56DEu5q30VnVQxn17nDHmEO+UbUtO2kupiq
	y1BL/QlSd12MJ8MVecwyMklR8LSWriiuNgeN+qkntswyp6INtN3BFF8Pvh+fzvbBti+MJPD7916
	fOO0cbzZFaiv7fwsoUIpeAr8HYRh81/aC0wBqqB/awM5Upfru8lyxRsLCxG+P6ljmeOo0EcQzMN
	UGqflK8TIXf3ZrtRjF7v8HJVV3aNd6IdIFs3zS+msyEBx4FgI2RO8C0yP3bLaoYOlI1aqRiRe
X-Received: by 2002:a17:90b:3b4f:b0:387:e0bb:57f1 with SMTP id 98e67ed59e1d1-38ec6a7a591mr4120286a91.34.1784832429331;
        Thu, 23 Jul 2026 11:47:09 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:47:08 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 29/36] rtc: pcf2127: remove conditional return with no effect
Date: Fri, 24 Jul 2026 03:45:31 +0900
Message-ID: <20260723184538.3888637-30-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/rtc/rtc-pcf2127.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 1995e9f2756d..ff2023908f5a 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -1184,12 +1184,7 @@ static int pcf2127_configure_interrupt_pins(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = regmap_write(pcf2127->regmap,
-			   PCF2131_REG_INT_A_MASK2, 0);
-	if (ret)
-		return ret;
-
-	return ret;
+	return regmap_write(pcf2127->regmap, PCF2131_REG_INT_A_MASK2, 0);
 }
 
 static int pcf2127_probe(struct device *dev, struct regmap *regmap,
-- 
2.43.0

