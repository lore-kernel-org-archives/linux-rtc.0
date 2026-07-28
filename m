Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2D7288D0
	for <linux-rtc@vger.kernel.org>; Tue, 28 Jul 2026 00:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200173; cv=none; b=nB9fatnC6P0q6nP4j9aLNxz/pWT1Xf69JNw7n0htt6qpT0ebAAAlHE9076NCXqMra2vXQDA7iCRH0c6GAqOIHjn/o8I43Fy4WmjGGsdRUS0PdQMr3Qxwx31xyk7US3E07x5fZeTTEmnfqiPcMskHpIMO8IGFjnG+bsg/Z1zEXq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200173; c=relaxed/simple;
	bh=rkQC3N9SWUGIPocS+zbd3VYqzWw5ikHPCirvXOvVCtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AkS3iaS22Kw0Ixz8zGqVRDh8lfli6X94lG1xesdrWQSLMpEaXCfTCvCzx0F6dDF1g+1u3LSNrusCtP7cfcqzTsTI65EQQ5WFlqz7nsqzLNLL6GZwrfesOqJNRwp41s3LXO80GGbllQZQ55jjbsqEx+a6ZzteZ4B/SQ5cP3nxeh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rVyso7Yv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVyso7Yv"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84e0688b859so2015138b3a.0
        for <linux-rtc@vger.kernel.org>; Mon, 27 Jul 2026 17:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785200172; x=1785804972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n9aCltKzYK9V1VDRk179uRnNfROwdaBxdq5wyJYZ6KA=;
        b=rVyso7YvLBd6gvpmHuPu7RLJ+EC7FIR7Chr3MpBanGG13yihj5y0hBNcBkSbxznDxD
         bXs9DXbUiCrvU9ktD4d1mq+hS+ozXKaGTRn9O+ideW/CZp+kknC+V+Rf/Os9ehcUTHHP
         QNjBo8fyyzH/VVUz2XvqOLpSGpADnRCWd8Km8kemMSfE4z2LPB2WdMl1Lv7eV9CoUQ8Q
         vQ7NqYTd3IgCGbSDI0ulLG7fW1c3sLsukbOEKngvFL80SDI5galrnUWeHvPMP+P6gJXj
         dzch+m5Uze6fHlvc3oToEGc0sY7mvTkWEffQajHmqg1HJHTG66tQ2W3noPog+c2MyWH+
         1v7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785200172; x=1785804972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n9aCltKzYK9V1VDRk179uRnNfROwdaBxdq5wyJYZ6KA=;
        b=JKuHiGtRQZvnebtB9Yy3sa4W1IEBA9MC+edQ0lAoTBTM3f65nYjTx91AvZx/JLHL8a
         k+tUP0cq2++tFzIZlvKGnKuMKdCMlPlBlWNV1lO3MP3fVxTWet2j0ibMkKxF0osFPmJX
         qr8aPaw4XNEa25VHelPyaGHhstd+6YKUrjusWXkrxsRHRGBC6UI4hBtSu4+oV3HvYkYy
         Xemrdy+M43JieSgDejfVs8bKkTtsPCxAO5Efr/OSrTzRjSeDO2bMUYs+P/zbrT/mi7D7
         ys90hrisSDnEwMUJOnlzE659NU0M1qFL7XA0ySdnE12WmMhMzjMebMSfgWqDmHw5FlCg
         amzA==
X-Gm-Message-State: AOJu0YzvKU7bsK8luq8bkXLtPTRyViO77BxdjVwUm1Ei14iNuTkdf4vG
	ZiCofKEXB58mtgwZD5Yu2CBHTs54pfz6hySJE0Qv5KAvgA9vUUVyapHrVHRlCJps
X-Gm-Gg: AR+sD10/Equ7emxqwr04UICNvASc/dDe6Vexf8A6qUKX1xhEDHaGmHwaIRPh1unqLkC
	7aq6+QlZDtHjkZpeIuP2kySXlO7dYHynyBkG4SqiFRhEqAwm6RqrJ9+6k0+z8ILQv2JaSrBZiMo
	jgxXNt9bP2j7T9uxE+TYUnZkF9voF7Mh0FKiJTwuIQZjLhCTDu4WOawKNylr0vAAJg7XIXnugWh
	M9pnLy8zjTzAFGPimz2YQYjVoixcKw2WHPgMomKU+Bfv04JIBn56mlHlXAYwA4V1LdvC/KTDjUd
	LToZ1XLlxPjV2icJLfCrJEeyGazS4fpULDGqwBEMMYXEG/yFMss2TiY5cyNAzJfnuXvH0Si3rc8
	S0XsJTGJPjZl+aQBvESP4jl2Cxen2JVvmYuQmftiX/DJlhxoBZiiw1jkAdTX3MgNr8TAWqoPo/S
	oDvCaXVRpTQjF89xStL5IKAnKK80ow7DDSRbuifDH1wIzly84QfveBwiv34dmLHKcAo11hHqG3d
	xzPjfzA6SBBmsyl4pq08HLizzjNY3hQ5WUKx3cWJFgBg01e1TRUbhc=
X-Received: by 2002:a05:6a00:22c5:b0:84e:89a:b8ec with SMTP id d2e1a72fcca58-84e931ec68bmr181761b3a.11.1785200171996;
        Mon, 27 Jul 2026 17:56:11 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e533ce57asm3736218b3a.28.2026.07.27.17.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 17:56:11 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rtc@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] rtc: msm6242: use devm_platform_ioremap_resource()
Date: Mon, 27 Jul 2026 17:56:10 -0700
Message-ID: <20260728005610.575268-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open-coded platform_get_resource() plus devm_ioremap()
sequence with a single devm_platform_ioremap_resource() call, which folds
the resource lookup and mapping into one step and returns an ERR_PTR on
failure, checked with IS_ERR() and propagated via PTR_ERR().

The rtc-msm6242 platform device (arch/m68k/amiga/platform.c) provides a
single IORESOURCE_MEM window (0x00dc0000-0x00dcffff). It shares that
resource definition with rtc-rp5c01, but the two are registered under the
mutually exclusive A2000_CLK and A3000_CLK hardware flags, so only one
RTC device exists on a given machine. The region reservation now
performed by devm_platform_ioremap_resource() therefore introduces no
conflict.

Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/rtc/rtc-msm6242.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-msm6242.c b/drivers/rtc/rtc-msm6242.c
index 80e364baac53..6f28d9c2278f 100644
--- a/drivers/rtc/rtc-msm6242.c
+++ b/drivers/rtc/rtc-msm6242.c
@@ -188,21 +188,20 @@ static const struct rtc_class_ops msm6242_rtc_ops = {
 
 static int __init msm6242_rtc_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct msm6242_priv *priv;
 	struct rtc_device *rtc;
+	void __iomem *regs;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	priv->regs = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!priv->regs)
-		return -ENOMEM;
+	priv->regs = regs;
+
 	platform_set_drvdata(pdev, priv);
 
 	rtc = devm_rtc_device_register(&pdev->dev, "rtc-msm6242",
-- 
2.55.0

