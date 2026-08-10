Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE32391E4E
	for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 05:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338924; cv=none; b=NOyB4yS2JaBssCLHLwEHs8s/+oqxvvEz9mcR0WVZCD9RbYu84Ypzt5TP/8dX/oYD1oK/+bcgEeu0FEXa3A2WzNMeLo4kFu4CurILhyzbykDWN769bvzbhkda1LSBm4xrbYq8U3IbUHYhjxTrDAU06qUAHr8sbhQpOKbtarXYCa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338924; c=relaxed/simple;
	bh=XQFgdJTsK21cZVw0y27VhQen6GqemFyvLkypXTh462Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLiENi27/VTbMSCiOLPX/+m6i2pdPtZA4AL05F8amtIetxRM2A2icHnGOH7O7GV+HpS79OrHCy5YbMq6IyoKiqC7OPevSIgari1nzuGNTXKgCPrSt6OCuXjpH/8heyc5NpH+rJgYaxfEN0QRIv5cXFzrT5Y/NlGlOQbMedssF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAaGgVYZ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAaGgVYZ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so1078423a91.0
        for <linux-rtc@vger.kernel.org>; Sun, 09 Aug 2026 22:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786338923; x=1786943723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qIj4njjd+RWYh4JFURNyp7igH7Cxj0yRhELgL29odk4=;
        b=KAaGgVYZSQwxRz4oTbaibRJKbhgatuFbg64uib0A6SNdsFRh7Qj1tkSIgeyXixQM8I
         NrxYoXgTDMBFcbN04fNRKtHR1DzA4Ijx7HWq+ZZXHaJWwclby5dD1tXjfyDwKmY9rVp7
         69yTZWXCC4Nz0ZWzR/eUOrW8cepuF9LmUWvQsSLXDPuuL+5kqIJQutIKfK4e4OkbFs1H
         hlmvsgkGjbx6FFZWTTgbaKQHxbz4c1ZW4lhVi7ciLEqQgqdJO5hOK6ng9YvYe5ybrv88
         XPdFaxy5SKKnDlmtFJzCGo5CCehc3FgU23DVnZNxcvwwtoqGObnW66I/k7sKU6IJMePE
         cj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786338923; x=1786943723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qIj4njjd+RWYh4JFURNyp7igH7Cxj0yRhELgL29odk4=;
        b=omk99bHlHRphvHIuQkPHdNGxoyeZORB49ONBt+UpaD5DH1PTHMxLDrztXOaBAPsNMr
         lxS02Njbjs10ikiX4aZhOA4DgF833mXBDKbNatDGuH6DKuCNwMfqe6gH++rnhf288Jdb
         9a9kNvkZbL/ugbcxk3csaWOj3UAoiWkoDzwzpTd7A+qdJs1MVNj2L89kkpvJFDI5Ks4Y
         CKat36pkdQ8WlvT9BgALlrBAktht3u5NJvbWJPm2MkgA86ue4ShK1b55QpDDhxJelSqT
         Acr+Tx/UpC6FRPxHqr/pUM+3Ew1SfZsa/wf0EZcUOiGxuIKrEhJ/mFXRTiCPoTJ2O4pT
         CDGA==
X-Gm-Message-State: AOJu0YztysXvpaqVIPEiaHVnKn/Rta7pbyKtB1VohI/veYBasqxh1722
	nNLS7Elv5dlK+/CfukM6daSYommLFlqUGOdHY6eIy0lR2Z11QKdIqbox
X-Gm-Gg: AR+sD13qHfsxK9xAeXN8xJghrZAck/6OMNF13KcPDgWIhJV3c1QAV6O0arv6RnDRrcE
	JTaSd4cJQGBvtMmVa2aAlYrPgdAWMBs0WQh0C2mbglfkM5Kn3i4tkx9DmNQv/OqiyrAHC1lfYwC
	M+Tr9nRWxuMt/2z87WVHmHpU+Z0lmz3FTgWaPI7n5JLKz1uWhJL5RPdzP7YI2uqJUDf36PA28Cp
	E8srbPrwqfVBzf92zVCg5mh8N/+uy9/yO5500+YqG8gjh2nxBNqCJmnKFcQ/dRzNowdjfJ91EKH
	p4SfXW03/0T1dKPj1r4F0uYyd5uDgvpWTwngygg8i5vT6YqfgCXIJ9hVckXxsGwfxHCpsCG+1Ai
	+5JPOYXWn6Qzgymjc+CmC0XQA4GyZWGvVYGbl6MTKfCiO6x8g1o4Vb4x8cy/cPGvOpgz4T/Dkws
	dhbxIxt5H8NBQH2TfTOEtDF2CbIRwyf7iITWw6v07eQZzi8rGIWAUL4u7SZ8Ih89l4SWqlko4z/
	f4abzjXAa/FJ9TA1FTixDT3PSODCIMWcLBybVCDAKRfbY77ZkVE0aB8K1Mcl9C3CbPKSPWUA7Dp
	f4o1
X-Received: by 2002:a17:90b:448b:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-3909d8c3b9cmr22968988a91.13.1786338922770;
        Sun, 09 Aug 2026 22:15:22 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b13b0c74sm4719672a91.0.2026.08.09.22.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 22:15:22 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 2/2] rtc: cmos: Propagate errors from optional IRQ lookup
Date: Mon, 10 Aug 2026 12:15:04 +0700
Message-ID: <20260810051504.26912-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810051504.26912-1-phucduc.bui@gmail.com>
References: <20260810051504.26912-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

platform_get_irq_optional() returns a positive IRQ number on success or
a negative error code on failure. For an optional IRQ, -ENXIO indicates
that no optional IRQ is available, while other errors should be propagated.

Propagate all error codes returned by platform_get_irq_optional() other
than -ENXIO, while preserving -1 for the case where no optional IRQ is
available.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/rtc/rtc-cmos.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index fa04ece151b8..0a2c7383c8cd 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -1436,7 +1436,9 @@ static int __init cmos_platform_probe(struct platform_device *pdev)
 	else
 		resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq_optional(pdev, 0);
-	if (irq < 0) {
+	if (irq < 0 && irq != -ENXIO)
+		return irq;
+	if (irq == -ENXIO) {
 		irq = -1;
 #ifdef CONFIG_X86
 		/*
-- 
2.43.0

