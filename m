Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21D6416CF3
	for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390809; cv=none; b=jjFVxOC8JEIRW1pZ2IeMbRtoxuKBykNMHOpFrih+jXhCVgjWChPjC60CCUF8GfUxr9W+MmkOKg/gi3A/A7hImRI8QF6B5aaxxO3DVyumgcR8Zd6mLM8lOZI8O//TC5RLVnfqf57bBi9tIwkvHH17hKKuUMFds7UzZb4zGUaRXMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390809; c=relaxed/simple;
	bh=iymtdZbAVDC4szK+VL2vsDv4Um3gp/9GnkovC0TOf7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkbCNKPJKuQ/IkEHxli7AP2FRGgXVKblLm3j0Ao3s4qblziMOGMAF7Euso3lbrDFLSW1Jrx5TbImfguUX4tG749sa90w3+WvwYmXSgs2sV2CEJJsVcXVHDFGPv7qmkoPKZAMois0bxV2WBqb1nHN2b79BUBMCoFSUA6yfhKtBOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEM3ErQZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEM3ErQZ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso1840975e9.0
        for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 12:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390805; x=1786995605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Lv+zt/h7dKa8TuGsaFOLj9Yjn5OU7W3HW8p5oLwNPc=;
        b=FEM3ErQZv/iFI2wk3UMNOzwUqmp69J7Ox/rfTj46W83fpT8fRiJSr5CPXXVhOSWLWK
         DuF/CS3bm/ADH0rajbZcuexCYPDTwCWNo2iPU1FBav7fvUEtaZ1cwVC2LiTDeLdPnMFo
         Ar2k2r+WoH0W9nXjUBbscIenAzy7AmEwAxCTxBRgfI/G8OzIZQPYBydsLQz6M92RQEq5
         6ezcSYVsv0W1dk9GNBZgUK1za6DlT0gdZSmBn7L5rdP97u38q58KIDUvGLWTmylf/QGK
         WrXxHmIniK48Cmk90p+7A9uTP6MZdtJCwr3ZNYk0IBuq458QHBUM0JojxKEo7pj/2kOP
         gN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390805; x=1786995605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Lv+zt/h7dKa8TuGsaFOLj9Yjn5OU7W3HW8p5oLwNPc=;
        b=SGGsub4M1cme/jCjRAzzGyLgnCKsYAtb6mpjL3naspemJZg7LBU83zQbyA5yqyEO1x
         APJ+HGIpkyLd11yHZxDnHmN9T74IySdHOy3yRj7osGH48KhtizXS1YL6grUMji3ATu2/
         mApYwstAoH04DAricBA4UM2tHSwno1Os46hx+WEBenZtErIVYgPlQt1kl+T1E5aTG2Np
         Tq75gh0TDgM1snkY0N7Z9KJqu2Urj2vVpuvoKeMQA9qg3xkBQ5a0Zi0VkrJOywo8iCGS
         6DuSe5FeWfLX4/QpuN7WXT6EBVASfyzhSUjdROL+U+6W5VWtmsrc5i7Nz+SVmOsugdwt
         e9eQ==
X-Gm-Message-State: AOJu0Yybb3WcOqBgeTEJ4mDOTArrdhVXbQ6ZRXdrEs8RRdiI+YhjsEZ9
	CgbiMVQp5kTN1qVC+Eo1aARikVQCQNiebGVimUGbV7S4/B8yyJT54qiG
X-Gm-Gg: AR+sD10QHRSpXRarQPfVoSvluS8w5MsQ4DZ2iI6s0ccpo9rVPk6MbjUtiOqby50h3mM
	MZz4FIkiasPKTgTt3Jzs0nWPTYqfjV70cgzc6Lhj7Gi79mdD/VitU6vYbga2wGl7Vs1Uc4MWSSE
	Hf029d0AkLDPauF2ikesDv4vo0ulPJy7BQRfKxkCSknyRpbYu64ihP2B7DY7i9msOt5fPWjnFpg
	Oh/UjDld+KNZKTf+bYhfjmOGJ4hfJ+0xGcNp+tIE/P70BdD+w6NJ84ST9LQPhok5sLrby/eYfFl
	z1cRVgiMvAayrWR0dJ5fMxpnQwInS8Tkm+ijcghA2/KYAEVHbS18r9tU9kGrOmrp3LkxxqLUrjy
	d0jerWWFBeSs+B3ziDTXKZndXI5SXXwznLb3sw6kTEfcnGduGFDhSISP/a/yTOob1d33TJKhGNP
	TqGe8e9cn9fTYw7qDnKxnBAulibem1jnqjNIoCNtrdBD1aEKhXVJm8DesXz/k4W0TBrf0M9fHi7
	t8=
X-Received: by 2002:a05:600c:8287:b0:499:5f81:8ca1 with SMTP id 5b1f17b1804b1-49974667332mr8638055e9.6.1786390804533;
        Mon, 10 Aug 2026 12:40:04 -0700 (PDT)
Received: from antoniarch ([78.213.94.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506cbsm39291689f8f.14.2026.08.10.12.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:40:04 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 2/9] rtc: abx80x: fix error check after i2c_smbus_read in read_alarm()
Date: Mon, 10 Aug 2026 21:38:19 +0200
Message-ID: <20260810193826.210683-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810193826.210683-1-apokusinski01@gmail.com>
References: <20260810193826.210683-1-apokusinski01@gmail.com>
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
 drivers/rtc/rtc-abx80x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 5486d9d0b1e5..fdf9664ebb6f 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -294,7 +294,7 @@ static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 
 	err = i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_ASC,
 					    sizeof(buf), buf);
-	if (err)
+	if (err < 0)
 		return err;
 
 	irq_mask = i2c_smbus_read_byte_data(client, ABX8XX_REG_IRQ);
-- 
2.55.0

