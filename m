Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F9B2931C8
	for <linux-rtc@vger.kernel.org>; Fri, 24 Jul 2026 02:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784860952; cv=none; b=MNmreywIZJ2mQW1pCLc9WGmiJ6h5HbKP6ghPmEi4PIldsB4DV275Pgk1tsU7Si/sJ/HF/6SdQ3nHFl1NDZyGnrHsRjLkOYFa/LLgVSID6XUCQA7EdtyJkdczIagV2WUfh+HFqlZiZJFkEXe3Pqt30qeD+xmtugWWG8lchX6id6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784860952; c=relaxed/simple;
	bh=Kcyf6DRHa971EXj2kBZ35LGhRul4erajhh5T/3cAz7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z5idSCEswwPQ03YhQY9i6AkD8QQiILf2om3MjsL8Wl38sHne6baWRqHKP05tw2MeKEU8+uEPnfaVo1y4l22JmqO43SKBfMua4oOHZoX3LdEPLM22XFLHPsEi+uoJF4bREp3OYEMC+GPjv5Ta/lormBfXg3n10WD3WCfUWWdkhXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kW4rnlco; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW4rnlco"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc97653887so15753715ad.1
        for <linux-rtc@vger.kernel.org>; Thu, 23 Jul 2026 19:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784860950; x=1785465750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z4bvXbXayEnCzzJXqVJPK7lahyeIFGKn1fz42KqQtbg=;
        b=kW4rnlcoCvyHLcKcVSePDjQzwVRSaajovPfh7DjIUy05NodyhWmwQ0OIkULCH5Ff5z
         7nw3LhbuEnVP0XuEHiMX6oddSmrd/j6aeHbzWxzBEd8rlB6zTo0KkFEDmAX2YsyVEi5K
         RLmvy1QY5HZ0esXZmvq50r2BcdmQPtRCKCid9ud2Z+8yHQVDNULN790D5x+3PsInyau3
         Jw3/Vp3jhrnVhKDf4kiJmwcqK78lirSXmZ69Z+NgmGSev3/mwNuqUyxYBM0LUVJsIJSv
         E1UR5CNV0rhoKZySc7VdiAQuet4A9tz3jXisqvQEIKXWGIz3OKtgvjNE3tLH7/emEJcp
         wOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784860950; x=1785465750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z4bvXbXayEnCzzJXqVJPK7lahyeIFGKn1fz42KqQtbg=;
        b=AVcrdmZTaxxmY7tVLUmvmZGlzaXMgT46SE5mt5WVjlrjR/wVV6WPInt3UiWqCmTKbj
         JNNzMHr9x9jvPjxndFPl6wuw03NqTS2B40L+egqOwVNgiIZ8FWT9tCx4COCleO5AfAgN
         VB8ehdVouOsL2TUfuXrzH5ZW66de09XLNkapU9AmwrygZZIFZrLNXR099/GUkltXXf+x
         2/NoFDq3/CcjTctQxvBnRuaXh7VGaglETHtjYwTaqn8qOjMxAWlG7HXfEGlI3BV/5Tz3
         U+eoz4AMAaClr11qbqJH9XlRozvI0bcltFhyGw/1in/dwG/BfWSMIjdHWZ+qyjzQtGbT
         iqAg==
X-Forwarded-Encrypted: i=1; AHgh+Rohn8fjHv3Yp4A/+5jrxQfqDVE9ZmFC5IIoIAH71wltafEoJxdbuB8gQk3kt7TZUPttpkJukqC1lTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuo91p00JmKOt+szrUXA+z1J4MLqtZLiQ8Ryu7+8cq9/lIMT5N
	4XQfdVguTZPXW6xlUJy+BfOAAQhKzdN/qNke/wRMfGz4zG8kXyalmg0NdRiHVLw=
X-Gm-Gg: AR+sD11H53HSY7RW1pxNt/XZlbRe4jDnn1Y0R6of1XEO2XEJWYndhN66YwuLTjnTrJM
	rYlQil6g6OWQ03zJaoPVWD3nLspq9qOpG2VUWHBpOK5Rs5yttyo/ztCgp9swffhMNjZTzqp8UNC
	l3qgNOnQA+yei6ZtwFdYFw6/531dAV0thEaiNvwtGojdkBGbyCKETE8G3IkWmjgJdmGPW3Y5j3N
	rx2QAH2FZZTPYwdtmRDPkWTCgjm5yXgMhWQkTelC/aQ79z5qQPzNhN5HWcAjzbp5bld/uCniAg3
	44ni+cbuGS2gPZVzxrJednPQnVBcTyO7E9BOClSjF2yaDhSLpjmM0EKJ0cy+7CFzC66fw4Zkicd
	BUoq4kakA28NXEjVFNLtdRi/stIZoltRctoF9n3KKrgfD+zAu4ypVFrayU2/eu4Iz0pOL7kaz2T
	6HHy5qc7AR59NKNXzGiqZwmdL5HHw=
X-Received: by 2002:a17:903:2b0d:b0:2ca:f8ef:33e4 with SMTP id d9443c01a7336-2cfa71d9468mr61759585ad.17.1784860950411;
        Thu, 23 Jul 2026 19:42:30 -0700 (PDT)
Received: from t-rex ([2401:4900:7b1c:a30e:8622:dbfc:dd30:d90d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1b6a45sm24761728eec.28.2026.07.23.19.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 19:42:29 -0700 (PDT)
From: kr494167@gmail.com
To: alexandre.belloni@bootlin.com,
	dlan@kernel.org
Cc: elder@riscstar.com,
	linux-rtc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Surendra Singh Chouhan <kr494167@gmail.com>
Subject: [PATCH] rtc: spacemit: handle regmap_test_bits() error return
Date: Fri, 24 Jul 2026 08:12:20 +0530
Message-ID: <20260724024220.10113-1-kr494167@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Surendra Singh Chouhan <kr494167@gmail.com>

p1_rtc_read_time() called if (!regmap_test_bits(regmap, RTC_CTRL, RTC_EN))
to check if the RTC was enabled.

regmap_test_bits() returns 1 if the bit is set, 0 if not set, and a
negative error code (e.g. -EIO) if reading the control register fails.
Using !regmap_test_bits(...) evaluates a negative error code as boolean
false, causing I2C/regmap read failures to be ignored and incorrectly
proceeding to read time registers from a failing device.

Fix this by capturing the return value of regmap_test_bits() and returning
the error code if negative, or -EINVAL if the RTC is disabled.

Fixes: a6de182daa2b ("rtc: spacemit: support the SpacemiT P1 RTC")
Signed-off-by: Surendra Singh Chouhan <kr494167@gmail.com>
---
 drivers/rtc/rtc-spacemit-p1.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-spacemit-p1.c b/drivers/rtc/rtc-spacemit-p1.c
index 43ab62494bb4..c1820c920ba3 100644
--- a/drivers/rtc/rtc-spacemit-p1.c
+++ b/drivers/rtc/rtc-spacemit-p1.c
@@ -57,8 +57,9 @@ static int p1_rtc_read_time(struct device *dev, struct rtc_time *t)
 	u8 time[6];
 	int ret;
 
-	if (!regmap_test_bits(regmap, RTC_CTRL, RTC_EN))
-		return -EINVAL;		/* RTC is disabled */
+	ret = regmap_test_bits(regmap, RTC_CTRL, RTC_EN);
+	if (ret <= 0)
+		return ret ? ret : -EINVAL;	/* RTC is disabled or error */
 
 	ret = regmap_bulk_read(regmap, RTC_TIME, time, sizeof(time));
 	if (ret)
-- 
2.55.0

