Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203933537C4
	for <linux-rtc@vger.kernel.org>; Wed, 29 Jul 2026 02:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785291506; cv=none; b=dSfoESYC1G7hDnwKyy/5aVRbL3zBCfxEEMa6ob4zASjOOEVoFxv4/PIvkl+n5z63itVwcmQCCIns0+dD94qODaHiGEdLOvCQfXDAYihWNhr2ijMD8VpLhDOqiF8qthg9gTCeCQWVPy9IQetCu7feE33vI4duhLn+eIcjQ13lVvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785291506; c=relaxed/simple;
	bh=6nkqDqAXcPS/8X6gEANTW4rGF9CCvG8ceg1mzWZa0xA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gF2njh8JTMDAa3k/N6yJZbMD/E9vIx3InNxWOCm7DSz+7E6ia9+bD7joSLwJq1uY9vEpJTLdt9EjFgIM2Fd2EA3bl+nnDxuIQDFWT8pISmQdpKR1FsT4adQ8SBMUYPeGzvNvWJrCscN/twAXw2Zl9wCPrYB754U4ISgQD0a9P1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqkF2XJK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqkF2XJK"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ceae1ed204so6187585ad.0
        for <linux-rtc@vger.kernel.org>; Tue, 28 Jul 2026 19:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785291501; x=1785896301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vnsZtjbV5skVSpYiYGDzFiuCt8jnr0IDD5NnHQhZM2A=;
        b=cqkF2XJKZTEbPCOMeXEv9MCr+3xfltSkgrZU+zLzzzumZJ5Eei3SFQXGKOxR+DeTnG
         gmxoVDLfPqXxgyUb5+xfHqOpnWZoHEe8TL+YSb2smpqnBvhy/XH2vEL9x1pFISmh9MH3
         5s3rREz5nzHd1WOSHdajzLRKuISJC/ugzWJmGR/6iYD38ak9Z28ZTqigTy8GpLSnBusH
         rd8U2d1cDVtsGIJMSR9ItLfLc3cswW/tcbqWJw63c5oYoLf+mAtUC2188s49HkDfaY4S
         Qg+BXOKQqTECouYljLm8r/7Sj2M3wwcI2lsHM/2FKegfKxeMiUNH3gpwoN09dEaFnHOJ
         Pe/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785291501; x=1785896301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vnsZtjbV5skVSpYiYGDzFiuCt8jnr0IDD5NnHQhZM2A=;
        b=O293NETDvM1TFIG2b9NUPKQSROwAkbQEAq4SWWk+O6mhr6O1ZlMIg9AX4e7L5pb4RQ
         Xs1zImMTgCe+eJkNk7GCLFs2EWTCMm0XpEkx2kWEwsly8Zm8y6/kGzio7pghKpKkVyTh
         BZ9sNuXeqVkkaKFwZpmQ7PbTylVCGByXsZYQtqFUnEESfVDXhovSTHIY2YvfB78Sa8ZO
         oF8jcbfSfXpk//C+i+TwLtc7EJ7LX2K8x+UqfaauMpSliuXDiQ+711fr0UuUgndFmMmq
         2N0XhT++r1ReuCNhDgInqJlB8rSRKjl5pAu2a95Hbxook71agcz+hZI9k3bLU9VKeAds
         eMjg==
X-Gm-Message-State: AOJu0YwfwC/t3V+4dTCOQRCfCqDwxAK1P3lb+JgJfCJr0aoFjS4hzusA
	TdDaK5DcPzOIelmJpj35/wPg9vf7EKa6XbxI3GutPL1/IpF77itTmV0=
X-Gm-Gg: AR+sD104rc/9c8qfwdg4t29Ba4Myhuu4dW9qW0rTjx9mVR/yCylOsrrnY4qZ2dLOoc5
	qjqJwn8AM2VsyzDpKyz5moivmqmO08m91R4ecUMWqMztTTtLtt/8mHOwsmZNSS37P7chcoaRD24
	7zBU4KucPjPrloV/ogcyaGxhbkjmR0CTLI6+RRXr9rM2Atmr4Ln4rByVNtMGISBrrV6Bw1dKkzL
	FdcRVFxs1dapKlfffHdczAfU1JQwi/s2wFbr3JAszNIz5E6sIMKFIZa65Ns/Rzt/F4onn0zBT2H
	NU8pAPoKGNu2SagBwLpFEDvYWB0N7mDDIoIMOTg+jxAt839f/lCQsoMzVeUOAoTPZbNO+InBkQ1
	Cj3jj2NPo0yEluxlQ4hT+Tv8X6n6k2AJjOopymjE2fKQqPIbrAYD7usRRkRrX4cGzNNipJS23bS
	DHU45J+cOdEEWfY3Jp2fD8KPyxX1iXjbcgTJZl8t2y/7X5WrGbBBEmkq9PdsoZag+GAoiKfqNIf
	qFqg6Zxlg+mj9qi8QkHMy3eq4+Se16yrMjeEAYWbGYxzMo3Hmmy/2bLyT2RUvwS3g5l9lSrbgCc
	lULDmsKhxGXW5DFG/92ZVTSD68e6xKgL0Q==
X-Received: by 2002:a17:902:ef07:b0:2cb:2b84:f431 with SMTP id d9443c01a7336-2d015d607d0mr57360965ad.47.1785291501453;
        Tue, 28 Jul 2026 19:18:21 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c5096asm3778355ad.81.2026.07.28.19.18.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 19:18:20 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] rtc: m41t80: clean up watchdog on registration failure
Date: Wed, 29 Jul 2026 11:18:12 +0900
Message-ID: <20260729021812.49868-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The watchdog miscdevice and reboot notifier are registered before the RTC
device. If RTC device registration fails, probe returns without undoing
either registration. The remove callback is not called after probe
failure, leaving callbacks tied to a device whose driver failed to bind.
Those callbacks continue to dereference the file-global save_client.

Unregister the notifier and miscdevice before returning the RTC
registration error.

Fixes: 10d0c768cc6d ("rtc: m41t80: fix race conditions")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/rtc/rtc-m41t80.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -1008,8 +1008,15 @@ static int m41t80_probe(struct i2c_client *client)
 #endif
 
 	rc = devm_rtc_register_device(m41t80_data->rtc);
-	if (rc)
+	if (rc) {
+#ifdef CONFIG_RTC_DRV_M41T80_WDT
+		if (m41t80_data->features & M41T80_FEATURE_HT) {
+			unregister_reboot_notifier(&wdt_notifier);
+			misc_deregister(&wdt_dev);
+		}
+#endif
 		return rc;
+	}
 
 	return 0;
 }
-- 
2.50.1
