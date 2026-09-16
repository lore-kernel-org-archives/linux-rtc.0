Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0104E1C75
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592023; cv=none; b=dXR7uxQ1FcB0YOsOtJyJ3rOzjDZ+kjwpG+shX+pFQqM3m1On1pxU7zwc0tUja6diXd16Z+MuNEX0gmF3zxzacXltRH3aTcEpeKSt4oe3ys5BXn1JvYlZkgyepY8PY5hNKnoIfFUTyc5RtQu8kxCiignun3RgIRUX0IGROFWvep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592023; c=relaxed/simple;
	bh=wLiYwM+a21eAKdI02nzoDqFbngX9L4TUdt0arxClA84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvM3ZR1kmIgDwzdp1pK5pfT1zvso0Uo+awY6NtAhkyzMosRIpeM9ot1P7K3zDHrWEO34cw22gTaHvMUqxYytZ3JvQ9v328hPuObBN7klWtcnS2hEt2xkwwKRPOQKk819tTUZepCR+bv9eyRLhe6BcRFuXf1AV3pneT6kGSkOoVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNIH8132; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNIH8132"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485984ebf5cso122194f8f.0
        for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 13:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789592010; x=1790196810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P8/pS3dA9RAh1ZIge2uQ9oYLHFPgMwkJbXpjt7KmlD8=;
        b=iNIH81326Q0t8HOiXH+0vL8q4DaJwaeIwZZ0qRLPYimjJy1jV8ln5iAu87wvLxZhGP
         6sbvssjMmYFe4BKz1hC6fmFtx4OpEX/NCzmtYsY+6dxMG7HYRBv3Ns7v8IW0TAIL6l9j
         1GNK6I6a+mQGBKsCHMami2ylXZe9fvc491zZh9dVGmyo0tGGODSQLL23PusCB3EhuwvQ
         zB1ZzarP9NC5Emn/HNYqSHEBXEQPYiekGmFJznjBX+f2bdF36PkYoovrHqXWhW96NCz/
         y1U+BHj1GN+Ri2mvEIYDWTvNj8G/lLj6O1ZPrdzpNdE/4gg8jWWIpS3L+0Ea2/28wKjB
         72Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789592010; x=1790196810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P8/pS3dA9RAh1ZIge2uQ9oYLHFPgMwkJbXpjt7KmlD8=;
        b=C9tIEJv11VIlAouoHifml0HzAzfaHeO6dN8gS3InL2gLJiX6bmG7l9yzak3YaaqROL
         uq2EmMJLETr4DHfkG39j5RNwbTFLyLoSfjJ2Ie467xYKWPscWuPzK/cdSIUr5DHV5Smw
         ZTeL3o3GmnuBhr/ilSf+2aLWf2vc7FplL/Azb0Z2FxUzXAcYUAR23nCDPgPZzqK4gCTr
         OrYCpj7S8axj1xbiJrxDThz+s6hlDN0wSszwNsJx17Qi61cylTkIrABeDigupQf96AYe
         cyhGlVs5KoihpmlM6qjO4g9t4OU6MGrWTerMsbo27U5QlBZa+PrdbdxAOa5RJ/s1fIvs
         +Iaw==
X-Gm-Message-State: AFuF++n6fnYpe+Yj1ntiIaI8V2KnUDXaeZpTOXoIL4vPgHIHA9Kf2Rfu
	WcSghD992Hq/Iq1RR0QSPee0kPH8ImGhLa/khUOAIYukDsAiR7lw7/+z
X-Gm-Gg: AYBFou02SsHSOsCdNhofCgOzA1eBgavV65S1OOvd7znZfpCt4dBWD76+swWgakQ6Ju4
	Zz9kDdi0VTSWzThsrj1dQu0FOudDO0E9pVlld5AqFNA6u5wTSO7hxWW7VfAcdW2eTCpTaeMg0yO
	paDR7HHKJB+zRC2R5EJooq5xavkBKfNPij56Ie0/D+r+h/HwSmcqACziEVwsWgu9MEzjzjQjse4
	vMit0UTurjn3fXrm15A8HMuPheRjpBf/OXVTdsknRQPH39j7PcuMrAA10Ji835GGilcN8W4I+7e
	/EJ0od5tqmC1rwOXevYHfGQ6dsOuK/sJ+6qn7jiTZlznEEB9Bj5nK4yfbHuuC68bU1e7ZKT1sxI
	m7aLVs55C19ZfXFHvqObbQt5RxZZ6bZ2hLi0tJ7Zu4IoFigspciEF4RhI9I/MXpsgCz/6wNb+Lu
	i6AJA4pQZfuQM3dKZkh5cpgCNaJOnaym4xlf4k/qojkX/zveWwHQ87U2u0d8Zu/ny5r7JtLnyKY
	Nw7ZJCV
X-Received: by 2002:a05:6000:2c0f:b0:487:342:d148 with SMTP id ffacd0b85a97d-4870d04800emr5622202f8f.38.1789592010254;
        Wed, 16 Sep 2026 13:53:30 -0700 (PDT)
Received: from antoniarch ([78.210.41.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bef7678sm11086166f8f.2.2026.09.16.13.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 13:53:30 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v7 2/9] rtc: abx80x: fix error check after i2c_smbus_read in read_alarm()
Date: Wed, 16 Sep 2026 22:51:31 +0200
Message-ID: <20260916205138.16771-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916205138.16771-1-apokusinski01@gmail.com>
References: <20260916205138.16771-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i2c_smbus_read_i2c_block_data() returns the number of bytes read on
success and a negative error code on failure. The existing code treated
any non-zero return value as an error.

Fix the error handling by checking only for negative return values.

Fixes: 718a820a303c ("rtc: abx80x: add alarm support")
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/rtc/rtc-abx80x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 5486d9d0b1e5..e4fd7b5d4b11 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -294,8 +294,10 @@ static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 
 	err = i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_ASC,
 					    sizeof(buf), buf);
-	if (err)
+	if (err < 0)
 		return err;
+	if (err < ARRAY_SIZE(buf))
+		return -EIO;
 
 	irq_mask = i2c_smbus_read_byte_data(client, ABX8XX_REG_IRQ);
 	if (irq_mask < 0)
@@ -311,7 +313,7 @@ static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 	t->enabled = !!(irq_mask & ABX8XX_IRQ_AIE);
 	t->pending = (buf[6] & ABX8XX_STATUS_AF) && t->enabled;
 
-	return err;
+	return 0;
 }
 
 static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
-- 
2.55.0

