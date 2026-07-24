Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5D12F99B8
	for <linux-rtc@vger.kernel.org>; Fri, 24 Jul 2026 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784901503; cv=none; b=Kjz6+AfwCqveUuzz0eIPfS+zOsMb4wdU0+eWASCKkiaUmutALCJor1Wk+p2hH4CTJXOYyi1cxNOAkUI/wnhfjWYu70oBwDCwNrvBqgwLZSXWMRTmMpkkr+RusH0N+f9ZgQg/iq8hgOKNx4nuHKNl3v3SORZ+12nkDdeS4rDMZeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784901503; c=relaxed/simple;
	bh=9bVq3PKKCCjYfUKFC8lsteul1thSQleu0PchsXsqgeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EEt2LVsPll8TnG7PznEoVkpzjkkJWSKabnyfFSU+eOvi7ZMWKsX+7fsYqw4MEIO2rf7iVocRhbm7NetudRPvfuobThfBpTUivzvwsJrfcJbvk1WAGRduUmULefeDV1CkEztsAd6Tsf32Y/Ex44XA1HpnuRHMuWGWP9o+zIya0Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcbDdnX9; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcbDdnX9"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81e6f2ee60bso11818057b3.1
        for <linux-rtc@vger.kernel.org>; Fri, 24 Jul 2026 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784901499; x=1785506299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jOq8PKa6aIygrh3C9B6cO75yjjM9OGV5sf4Vbyk2dT0=;
        b=XcbDdnX98q2nAjJECWaWSNrGQ+bHXeyehiNy1296XT9XVwb5s4cQiHq7jHAGWsFKFG
         AeYsQqtSo/BHpyqCnWkNW66MK7asg2x3nGi0qAV+el+Q/dCXOMAmR1EiBQZKLU9OTDaN
         Lc7qNAp3MjCIZnsm2wZu0Y4MnKKZHe2PAPQZd+NQacEzlzm9y0rxvBFNficHUKxJu4Xx
         Ge2ygSDtZz89hMIBuDdGH3PJkQB3wiWP2+KPMlA/ONE9gNQs6tgdu7XAKkDu3+j+lpRg
         NFCguoxD19zLwtngdnpG5NtwBaOCT+b3tKPjOhyf9ah9jrJpf0bAVLnAuYxXv3stNfel
         ew1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784901499; x=1785506299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jOq8PKa6aIygrh3C9B6cO75yjjM9OGV5sf4Vbyk2dT0=;
        b=FzJ3QlGuPyHVEELgYXtRKUS1vYocn49t3nIFpMT96gY4tqs6FAqZSDxz9ATtjUMHvR
         xVhoH1xGk9QrFFFYy8PRZwKSM6G6A9heinbsH7sBcsb6/JdwydAlEduOv0jaMxhBYZr3
         JndHEcFIAFOddH2Hrk5qgOpdlsMr4/b0EEQyTCP25AJQXWCguJoDbrVbOhwUlaH9L1V5
         w8YXi+6pVAxsQbSdSIMQU/g/CbPzZx42cjy/83sBda9QELRbHFfNSdDRZaWdfRUC8Wxc
         viozQhqbHEJO/iQDFINdrlGcsa8oTpNbwvTMutwWViU8cUTR2u9Q6AQCCxClg72v7Cnr
         7l4g==
X-Gm-Message-State: AOJu0Ywb4qm9quilnDq0xUd8WR8Os6r9hSW8vNZwcVEx1GPTQ7T1wf4+
	O3gmqSVkyndCqo0lxpAB1HHjFTkTrQR55k1f935b+SQn9LGep3usMEiwHu4keoQ=
X-Gm-Gg: AR+sD11/kBsafQNYe7aEd21pOubaq8waTxvFeOKxUOqqLSgNSY1mBdhPKGfzcnU5pZL
	UH/4WDmtiIQ6Jkh4ZkjWnURAqNN7Zd2y4jAPKHEct+OiVdhcTlq7kgYXCD4s047Jn6jS9K0W1+A
	mwVSt4uZ9eIjXwxtG+mEAZXDxDeBqclcWV9Dx/PruXwjp4ZSl5TfVXPj+HmTYC4qTzTCmPuhIgK
	XmTlLqfeJgKa9zNQ1CPV+fDSQv6l8hkJr/gnsjyHYVPsoPJUjHFtvnOWngDF8Snq8R1Ve1tVXz1
	JCNTPDUcDML7p8zQgnEVtsG4nWbFNHC29OKQxR3F6XRrzcCp68nptJWITauk2D97pWKZ7+guL+G
	0N6E8G7HaCxSqm6tLx2mEdcPQXVkTZ4PZoq5oR5WpyXLqJd5CX1/+ejkyIQEyyMKsvpCgNwVhs2
	Co0U/cpaOHWJZJGAfzx9Xwi7U/rpQ=
X-Received: by 2002:a05:690c:e3d0:b0:81c:2a00:aa42 with SMTP id 00721157ae682-81f63faecc5mr1632347b3.20.1784901498554;
        Fri, 24 Jul 2026 06:58:18 -0700 (PDT)
Received: from t-rex ([2401:4900:1a5e:93db:310f:3bc6:10c2:6175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f658fc799sm191397b3.34.2026.07.24.06.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 06:58:18 -0700 (PDT)
From: kr494167@gmail.com
To: alexandre.belloni@bootlin.com,
	dlan@kernel.org,
	elder@riscstar.com
Cc: linux-rtc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Surendra Singh Chouhan <kr494167@gmail.com>
Subject: [PATCH v2] rtc: spacemit: handle regmap_test_bits() error return
Date: Fri, 24 Jul 2026 19:28:03 +0530
Message-ID: <20260724135803.81223-1-kr494167@gmail.com>
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
Reviewed-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Surendra Singh Chouhan <kr494167@gmail.com>
---
v2:
 - Use ternary shorthand (ret ?: -EINVAL) as suggested by Alex Elder.
 - Collect Reviewed-by tag from Alex Elder.

 drivers/rtc/rtc-spacemit-p1.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-spacemit-p1.c b/drivers/rtc/rtc-spacemit-p1.c
index 43ab62494bb4..1de7bd995d29 100644
--- a/drivers/rtc/rtc-spacemit-p1.c
+++ b/drivers/rtc/rtc-spacemit-p1.c
@@ -57,8 +57,9 @@ static int p1_rtc_read_time(struct device *dev, struct rtc_time *t)
 	u8 time[6];
 	int ret;
 
-	if (!regmap_test_bits(regmap, RTC_CTRL, RTC_EN))
-		return -EINVAL;		/* RTC is disabled */
+	ret = regmap_test_bits(regmap, RTC_CTRL, RTC_EN);
+	if (ret <= 0)
+		return ret ?: -EINVAL;	/* RTC is disabled or error */
 
 	ret = regmap_bulk_read(regmap, RTC_TIME, time, sizeof(time));
 	if (ret)
-- 
2.55.0

