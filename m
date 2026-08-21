Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34E0416D17
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787346732; cv=none; b=r6Pi4Rs7LkaPh9DtTjySt2Fmn89JndsskFodMLMLSvmX1WuwiKFg6ZpD2B1MRmDt0IVazJo5q/ECS0tUmUG/HCXBqltRJcmj3GdsrYxsvthprfLG/h/I/p1XlNV6JB4BqfoSficVN35N8b3twKvl9+WpnXNxsj69aoNxMuS45p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787346732; c=relaxed/simple;
	bh=NGzA0VQ/OCeDwBZt1QE+AIRvAaTUIuyro5ezBJUttkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ms1a+n+w9stpvUj5P5uXrMRPxRNSc/7c4+NUZ9dotmQsRuLUipnLlWpHLLbnbGf5zap7dU22D3SyP8yhhVMbhNEUp09ejobrTkON7T9GHEh3Kiz/7fvrKN4mrwzxfqAZioqJgI2fz8jJi9tmRFE/PCKvY9zshbTzIrozspbPJa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXbJov1f; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXbJov1f"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc11a30a259so1491813a12.3
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 14:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787346729; x=1787951529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5nOxAjAbSX3AphlP3iCgTjG48U+KGU7cBosPA522YNg=;
        b=TXbJov1fkALBPANHyxTxvVLwWj3J5GU2vInRSqT1MaeW6ERZbby03pWPoqlNGzZ1xd
         ttQmPDwz2ma69iiY5VJqC/gsHoSz/6ZTHiHTti6qlOVg6pf//SvyPQVR1RdseSEgBsEn
         QPcU1UZwV4zp+06UeZflaDNNxQ/d8fI/liJYv7jm3OUSYTYL3eYg7sPY8jZ+LQNWQWsF
         cftOIAl8LHpgWdQjSsfTUNTUURnCPAeYERypwD1SkmUdQMBQo7BIP59thdBbRV3ObkAi
         hyGpJjzfvXKJGvbZdcw5qNjwGJVewp1WBhidBf92xfPOm7n42LeWptBXb+eFh0PXL+lO
         62TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787346729; x=1787951529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5nOxAjAbSX3AphlP3iCgTjG48U+KGU7cBosPA522YNg=;
        b=jtMrsXvmOsDRuOfn9cHo7UIK9Pk+olgLhrgcZ2IttCJ+9+HNLJNeoDaS2mynmLVQRs
         MqCYZDXDdFkppQjjpj7FBiSEKgWYAPnzMmq21AmbF0FM3O5W+7y+2axpD3q9w9vlq5az
         05IGJb8w4K8v+vjh7Meemj1WygmdD6WiruuYl6ySANqMEw4scoWvqox+06umLh5Wcuim
         vau8IvO2h7WgUeXGfSP0FhWCV/lzXkYy4Z+lptEVyXTamvpFG/E2k/DwoUw723RFkPqV
         Ak8IqFq0YKtwF3PzbuE25lmmCswjwF0+W0zydBuP4ymGtXr1vQTZm9EXy4Wd9wv12RbB
         jxiQ==
X-Gm-Message-State: AFuF++k3AxIpo9wZMCOxSzOBJqlfuyQToO2cvHjWXa+1epzSw1tzTyG7
	n0OboZbGhmv/hulhzKSKveAdaSaVQBTLCdFkJ1DHj+MuPBgo0s7fWVpQ
X-Gm-Gg: AR+sD12sjpOxvD7kVHlsTQX6MVUUpvcWCfYaTNqyKkeCyGP52SyUnCyxIb/noKDkjh5
	P1Lfcnrw3/rN6nlbjG625tbGJUPXV3d+i0Rq/Tn8tk5HCKU6vDdc2iHx31VLdl74m8+HulxruYe
	6edgUUMFg9FgzqYBvIq88G/XNjvO4mtFEntwWWGfxEgScJ5u24593OQy4sKG0XlT+bDWb2jMt7M
	xRtxZppxAodTvBthpTkMZd5Xpn/CHMPWj5CKQDZUHgvEp37RNYFd4WCKeoulVy+UP7pNpm+aTUF
	reBvOmXGND8FooJKXeuGKR5Us6llAwKhlweZL4RVM4zl29OOPeJ4UH1Api0DdJLRgXgmvPDDmm+
	kR9QroKABKa8e4xbT/Bd/27eHd//a8DGv2FtqSl1svsA5GEfV5K6N2q9wM7d3YucW8EQ4w3yYKs
	14H46YkT06WFygw/euGs5vdj+PBNlzW1u1o+pvKKab3Q++zfyNiWp9r4RpdBxOfiHYJUeYatg/n
	x3Lmk2Yk67dczWjfGf5O+4ZyNnrfrMMVkgzULufPzM5sUskSGsbrPkU9RLDHfWzUk/QOw+t
X-Received: by 2002:a05:6a21:168c:b0:3c4:3321:4fe8 with SMTP id adf61e73a8af0-3cd4bbe89c6mr3227466637.14.1787346729187;
        Fri, 21 Aug 2026 14:12:09 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:194c:dba4:ea1e:d7d1:affe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf175399sm49755257eec.26.2026.08.21.14.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 14:12:08 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v6 12/17] rtc: rzn1: Use temporary variable for struct device
Date: Fri, 21 Aug 2026 22:10:27 +0100
Message-ID: <20260821211032.13554-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Use a temporary variable for the struct device pointers to avoid
dereferencing.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v5->v6:
- No change

v4->v5:
- Added Tested-by tag from Wolfram.

v3->v4:
- No changes.

v2->v3:
- No changes.

v1->v2:
- Added Reviewed-by tag.
---
 drivers/rtc/rtc-rzn1.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 4e62f7bc2e34..7598efc31e09 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -399,13 +399,14 @@ static void rzn1_rtc_disable_hardware(void *data)
 
 static int rzn1_rtc_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	unsigned long rate = 32768;
 	struct rzn1_rtc *rtc;
 	u32 val, scmp_val = 0;
 	struct clk *xtal;
 	int irq, ret;
 
-	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
+	rtc = devm_kzalloc(dev, sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
 		return -ENOMEM;
 
@@ -413,13 +414,13 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 
 	rtc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rtc->base))
-		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->base), "Missing reg\n");
+		return dev_err_probe(dev, PTR_ERR(rtc->base), "Missing reg\n");
 
 	irq = platform_get_irq_byname(pdev, "alarm");
 	if (irq < 0)
 		return irq;
 
-	rtc->rtcdev = devm_rtc_allocate_device(&pdev->dev);
+	rtc->rtcdev = devm_rtc_allocate_device(dev);
 	if (IS_ERR(rtc->rtcdev))
 		return PTR_ERR(rtc->rtcdev);
 
@@ -427,19 +428,19 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	rtc->rtcdev->range_max = RTC_TIMESTAMP_END_2099;
 	rtc->rtcdev->alarm_offset_max = 7 * 86400;
 
-	ret = devm_pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(dev);
 	if (ret < 0)
 		return ret;
-	ret = pm_runtime_resume_and_get(&pdev->dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return ret;
 
-	ret = devm_add_action_or_reset(&pdev->dev, rzn1_rtc_disable_hardware, &pdev->dev);
+	ret = devm_add_action_or_reset(dev, rzn1_rtc_disable_hardware, dev);
 	if (ret)
 		return ret;
 
 	/* Only switch to scmp if we have an xtal clock with a valid rate and != 32768 */
-	xtal = devm_clk_get_optional(&pdev->dev, "xtal");
+	xtal = devm_clk_get_optional(dev, "xtal");
 	if (IS_ERR(xtal)) {
 		return PTR_ERR(xtal);
 	} else if (xtal) {
@@ -483,9 +484,9 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 
 	spin_lock_init(&rtc->ctl1_access_lock);
 
-	ret = devm_request_irq(&pdev->dev, irq, rzn1_rtc_alarm_irq, 0, "RZN1 RTC Alarm", rtc);
+	ret = devm_request_irq(dev, irq, rzn1_rtc_alarm_irq, 0, "RZN1 RTC Alarm", rtc);
 	if (ret) {
-		dev_err(&pdev->dev, "RTC alarm interrupt not available\n");
+		dev_err(dev, "RTC alarm interrupt not available\n");
 		return ret;
 	}
 
@@ -493,12 +494,12 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	if (irq == -EPROBE_DEFER)
 		return irq;
 	if (irq >= 0)
-		ret = devm_request_irq(&pdev->dev, irq, rzn1_rtc_1s_irq, 0, "RZN1 RTC 1s", rtc);
+		ret = devm_request_irq(dev, irq, rzn1_rtc_1s_irq, 0, "RZN1 RTC 1s", rtc);
 
 	if (irq < 0 || ret) {
 		set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtcdev->features);
 		clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtcdev->features);
-		dev_warn(&pdev->dev, "RTC pps interrupt not available. Alarm has only minute accuracy\n");
+		dev_warn(dev, "RTC pps interrupt not available. Alarm has only minute accuracy\n");
 	}
 
 	return devm_rtc_register_device(rtc->rtcdev);
-- 
2.43.0

