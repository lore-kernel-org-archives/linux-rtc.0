Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E777A39BFEC
	for <linux-rtc@vger.kernel.org>; Mon, 12 Oct 2026 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799793; cv=none; b=UE0p6zaG1JrrsgOeU9vwBRXH0M4IKj+kX1Bjw2w5L4+zdBXsCESlZy5q/ducfJTSoC2RjECokuywzxvtmqt31SqA0v2+Hrwv4XxGIiSLSs3LBEWoYb+3o8P75v2sZ27W2f5mNNywR/lJTFMRmgHtlyI+OK+RlAYdDC+ZnuxEjG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799793; c=relaxed/simple;
	bh=AEwkqg61I2qghq9yeHFLrk33B2hYIGSTQL7NqqYg8tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZjD5Rd1wivEc2DZYIV2Z4f5l1ElvUmUE3hG1IHAw7mSVxhUotT8Z4ePHg20AL6BGrQ5la2D8utjMUPec/p4JsWC099Gcp45i7zuNuctCx5FlJCGpwWIKbS/7UgCfmAVldDnfBJewTxPbQOfTlRghJQSgxR9ySHoCpv5jvcS9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/tVcwhR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/tVcwhR"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso14325625e9.2
        for <linux-rtc@vger.kernel.org>; Mon, 12 Oct 2026 03:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791799779; x=1792404579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6VogQbUFurz7GXGcstM5xSZa/4W+tRC0ptaL75OewR0=;
        b=q/tVcwhRLF0KOD0C6YcsOkwk3qyztLbzRj69M5jSeM3sVtddT413teV2wEf3UAa4pf
         AkfiuqDtuxyiPVYyV3WVoJ8b/Ppjtrh6EE9xHX07Nz31zfOF3N4prCiA/BfzwHwB3YjT
         nkrMnmlvujynrLX8EN1/9SyL50stgd6fqJ/Cw88blcI+dy2Vcy+4xRYcj2+z1KpxcykI
         6KVnBLJu8ci/qSzxMj/bnBcbvpAKlQWPcWPe67JRrN8wFD3nkPgMPAzYNnyT98O+bCUu
         kR0vOkcQ5VG5NXWpFdCRcT7zFNnCjFmuQXZHO8sap5Hz0AK4rdPFLWu2VfTH/rUG0Ycu
         9lPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791799779; x=1792404579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6VogQbUFurz7GXGcstM5xSZa/4W+tRC0ptaL75OewR0=;
        b=1lReHkW0khn3kbnyu91+OfUILveXyayTaSqwqemeBhBV82nRjj39WEKu6EgdCznRdf
         FqrniC+H9XO5jwB/nmpsT8Ib3oHCp91l4hhN8cINCWiQ17TWVZzbATnRmYy1zy2TAoiD
         9sGd4qf2I9pzIxY03Q7U4w7O4q/ayYtbkyW5as2fp2Iq865xPYvmYpqHCJLreKGMJMGA
         Y/9+C9aD5oc/9RcNNL0Z9TkIVEYvVq9O/rgv5BSk0hu5vGFUUlnQzbIyeHijOxOpCOLZ
         DD5Esy9bRlfvKZamZZUoDcu/fbtvXURA4BFlyuBd88EHxLabDD3Tc+MUtlFsZ3ak2E3a
         CpnA==
X-Forwarded-Encrypted: i=1; AKwUvBys/xvzRS3fWKtgpG1iicPORLzC0s2Ah4Di7v7pYkU6K8nsQ7vW2iti8zvB8aclA3swRMQbiMUnA4c=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyX5r3E206mAPq3tcy2Vtmjgcg2UPeAAqorYR9ssm4eOU4u35K
	UfC1BjhmY745wb/1MiRKmv+CKkrfqsClvYnSRFd2rn7i/159Kl38Nlr7
X-Gm-Gg: AYBFou1P1bPDFy0NujFY98b5DlxVGLu6N/6rLc7eAhO3V5DjPUf7tqWEqpVLIUW79WM
	Xc9Lnpu65HiR9vOF7Z6MlBfpAWecE7rJsTgPbWlczn4OWLGLvor+3R0X0EIZkw5nqF46kqscla7
	UMq84cwu6OPuZ7NVL9rRB/ehk5PhSd2cw4ETQhaIkbzQDIdQSAh6cXVLk2B+WOsnoOtSmgwkvP6
	eU3dMErXjEz0DNmiCNIXmscLxeXRiLj0D3LXpM8QHVPJlqGXLnTD21db3/skd/EVhuHydAMSSKk
	2qPV9a3YpG2JKAD8SHyCy7ucjBW/jZja8n85JQxqVcCYzR7HIkY2JcuXZgJyp7yrO1uQGjvnxOG
	Rurjye2VnWDIz4X0g6gX1u325I7l/efLQVFtHPCskAxxCGtYqlKHnqcxWoOg3+X8Gqo4kQPNFrB
	a/0pCnG5FXIBXYJmD77JezDkaBoKGvVC0ifaeX5KxwHVKAsgwQ5PV6TL/jZjzofp33BNyp6WbUP
	Xq4Heo6Go0qbQMVsayzRMpMwu3aY4ti
X-Received: by 2002:a05:600c:3f16:b0:4a0:2150:55fb with SMTP id 5b1f17b1804b1-4a18e44395bmr161917225e9.4.1791799778944;
        Mon, 12 Oct 2026 03:09:38 -0700 (PDT)
Received: from debian (ip-78-137-176-146.broadband.digiweb.ie. [78.137.176.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a192d3efb6sm166229885e9.1.2026.10.12.03.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 03:09:38 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Pablo Mazzini <pmazzini@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v4 06/11] rtc: sun6i: add Allwinner B288 compatible
Date: Mon, 12 Oct 2026 11:08:11 +0100
Message-ID: <20261012100816.331033-7-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012100816.331033-1-pmazzini@gmail.com>
References: <20261012100816.331033-1-pmazzini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 32 kHz clocks are the same as the A23's. Only one alarm interrupt
is wired, which is all the driver uses.

Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
---
 drivers/rtc/rtc-sun6i.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 7fc60880e409..05004e80ac08 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -350,6 +350,10 @@ static void __init sun8i_a23_rtc_clk_init(struct device_node *node)
 CLK_OF_DECLARE_DRIVER(sun8i_a23_rtc_clk, "allwinner,sun8i-a23-rtc",
 		      sun8i_a23_rtc_clk_init);
 
+/* The B288 RTC clocks are the same as the A23's */
+CLK_OF_DECLARE_DRIVER(sun8i_b288_rtc_clk, "allwinner,sun8i-b288-rtc",
+		      sun8i_a23_rtc_clk_init);
+
 static const struct sun6i_rtc_clk_data sun8i_h3_rtc_data = {
 	.rc_osc_rate = 16000000,
 	.fixed_prescaler = 32,
@@ -859,6 +863,7 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
 static const struct of_device_id sun6i_rtc_dt_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-rtc" },
 	{ .compatible = "allwinner,sun8i-a23-rtc" },
+	{ .compatible = "allwinner,sun8i-b288-rtc" },
 	{ .compatible = "allwinner,sun8i-h3-rtc" },
 	{ .compatible = "allwinner,sun8i-r40-rtc" },
 	{ .compatible = "allwinner,sun8i-v3-rtc" },
-- 
2.52.0

