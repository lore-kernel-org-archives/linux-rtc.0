Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264357;
	b=i+/i10SFIToNw6HSUFW35mIXOW45dBDbsLVYaYq9N23RM4o/L3GMCBRkrlZhs92eYbeS
	 UC7AKAQRsXBmaR75j0s6jZXQ8kat6aSdfFRjLwgmLnqM5gc+wqVA03X/Wm0nAyyBqWhUx
	 ELWzX0rq/xfJjLhoAZBuTGHp/kTZC7FsiufOVzuAXnduvZ2Oeicz04D1w1WwWDw+BnDbx
	 MA9nWltUxFh1tPF7KRTfRfB5mGruf66COxfYavmqIvXHwN0DOeiQUIwnGXXTqj8xJ/yZw
	 mRynMG/Ijec6GdDBvlXlXF5JWfYrlvXmOMBBeHy64EA8OoWW3eGyGmws7Eo/DrjJR1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Pf8vm5N7CuEKM9qQ3heupZiM07wEvXe0DI+wIb1mu6U=;
	b=wmVKOMDbxchx8inRvkOttrchepdUfeO44N86igWXFFF+dXR/P97TaiMkjRkel1TIeZ5e
	 O9+EiWt18fz4SXuK96yMBM9e50x1wha6WEN/MdntCS/J5GtASFFak/N+/cHBDgCBrcn+k
	 OjYtf1PujiEf9wCZ33RmA+r+ECCCV4e7hcTDtaygjF6u/YxIygW07Ujx9BvG4HdAp0epd
	 3GPKJY3XN1YqU0JSCbWB0nPvg0iU2H9y+gShwrLMxwtnif1xoZ00KvjEsIFnmGGVPYr7F
	 EAJW36jcSOL6jaNey9+V25C5BC+C0a5ZCGw2A1v72N0DXe/VTEKkl9sZiBfHSGh1ToA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K2v0+3e3;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA41606A321
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 08:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDA41606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K2v0+3e3
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35c76e9614aso2705298eec.0
        for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 01:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793264356; x=1793869156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pf8vm5N7CuEKM9qQ3heupZiM07wEvXe0DI+wIb1mu6U=;
        b=K2v0+3e3EDuDJKYcecldqmNA0dnBAMPZ/tCas/ggAI7Q9myljmj86Fack4anqlW9GZ
         6K3tBlVgm9GtLjXDQRpy1APoGWnXJD/B+KhPDsnfdH8ImOc/kzyXISK8TcWP4pESnqd7
         BjPKKidjfszlk4nbNXKT0twyD6mIg1P3oZH2WiSQY94SpMNwXwAj/eUSDQVeKotcyZ/a
         5fG2TYaBP2WgJShkf6EwW1a23l5WGLx/FAE7MQw1xOfYiT/Lv/qGw9s4X27pHmOgJyWO
         Bpc83FlmhfIEU9wky3diYsh98VQ4XH9A4Wb8sJqOAXH5pjP8pCdkFn6jTEVuZLdscTdO
         XNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264356; x=1793869156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pf8vm5N7CuEKM9qQ3heupZiM07wEvXe0DI+wIb1mu6U=;
        b=rBxWHZifY620rYTmpjs1ToM7hwvSLesutsPPNHWD+vS52QoyBo09N5vCUWXDG1/Mzg
         62PLw8gz/g0rTdFw/+ec9z2vPijgeSD2aAO2CHSQQFm3zSN3hoQJfv86AHQIcawWBgC7
         PcCnIR0/wAY1TWRxSOfJIgBfmStxWz170DIodwqYEA0DOFs03Bljf5HItpQD6wlheksb
         LJLFwDD05m5+Dp3XQ+i7eqT+ZRWXzx48KClvlLGpIxUgCsKoZ6mJ7YPZ9UbX69SZeaAf
         /5/zjl4X3hg2updvCZWs7tkliNbN9abFl1vO11Fl2Yzg9ONZ67ndn6iiI/qTpd6rhHP2
         rJSQ==
X-Forwarded-Encrypted: i=1; AKwUvBwibGZjAL3OQw8DLjyMBgZKoY8QgfiBEgoSGJApUDL0y9GoD0R6yJDWqXN0decBTyIjFbh1xcYbPjM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKa0333QIgIXCsABmTpJ9C71LLWREeausvppv7mBOVY7hUibAXg
	Jkh866TenyZ9fcc/8AhScCYtl7CY9qKlZ0uD9bN1Zeytvl9HnJPUzLQ=
X-Gm-Gg: AYBFou3L7hA9UumR/gowXIMts67nVmc/IeniwV5hRasVXbLzIelYwXTJR9NHLdoGsxV
	00cVOg0KwzkIKOr1efTzgU6Q1LQIFcrVHBecKFOxqf08GL0b2Y1csF+EBFoiiZPBXP7qjqspaqt
	gzYmYIT/AQgGdW24soW8bEZ2JrN3QZxF7bj77qhyqQd8TWw8jMM5bhE/0Xo6/P2aIj6i0xIT6d8
	RAQAPHd8JrOhCjE14e0kK7/1XZsZjtr2rDfXBqeWQnZIj03YTMgRFAKJIP7+3LMa20hrSnIoVi2
	rVmLWCeUXD8tRjezVD9/OrOfSz01pdiKxh1aa8R6VovgRPFAwDHHL6pN0LAZviybfIdWraDTUW+
	/G344R8fv/SRNQ+XenAihD8/4gOKdAOCU1Xqk+CkB6Zb6BmjMfT4mQm6NF6iGVT+TkwjrzUiZcG
	855Cdo83eY3CjgPb/uitJzeXNzZPYwKLYnMpr48i09W7AwyYHOoIJdY2+hpKSQvgUs0n2CeZPxA
	9lbsTqUWORsDbCjb5Q6e/gEO1QVPszN5IZMo+1+oGzA/nMc0Z1kII1iX0GhREQe97LyEsKC/hp+
	qX4WUA5rCWyKvikOTDUxmkA6puNTShWi/V9WSCLtblzbc74CKfQ8BTz7AevuQQ==
X-Received: by 2002:a05:693c:4141:10b0:36a:3453:a356 with SMTP id 5a478bee46e88-36a3453a84dmr1973145eec.36.1793264356042;
        Thu, 29 Oct 2026 01:59:16 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.20.232])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23641e78sm16497937eec.0.2026.10.29.01.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:59:15 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	mfd@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 07/14] rtc: add support for x86 macs in macsmc-rtc
Date: Thu, 29 Oct 2026 04:52:04 -0400
Message-ID: <20261029085504.3547-8-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make macsmc-rtc work on Intel Macs. The ACPI RTC doesn't
work correctly on T2 Macs, so the clock from the SMC is
used instead.

On these machines the time offset is kept in the SMC instead
of NVMEM, and the clock rate is read from the SMC too.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/rtc/rtc-macsmc.c | 126 ++++++++++++++++++++++++++++++++-------
 1 file changed, 106 insertions(+), 20 deletions(-)

diff --git a/drivers/rtc/rtc-macsmc.c b/drivers/rtc/rtc-macsmc.c
index 8fe883066..37395c64c 100644
--- a/drivers/rtc/rtc-macsmc.c
+++ b/drivers/rtc/rtc-macsmc.c
@@ -2,9 +2,12 @@
 /*
  * Apple SMC RTC driver
  * Copyright The Asahi Linux Contributors
+ *
+ * Copyright (C) 2026 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
  */
 
 #include <linux/bitops.h>
+#include <linux/delay.h>
 #include <linux/mfd/macsmc.h>
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
@@ -20,13 +23,54 @@
 /* 32768 Hz clock */
 #define RTC_SEC_SHIFT 15
 
+static bool force_clkm;
+module_param(force_clkm, bool, 0644);
+MODULE_PARM_DESC(force_clkm, "Force CLKM Key, instead of trying to use CLKL");
+
 struct macsmc_rtc {
 	struct device *dev;
 	struct apple_smc *smc;
 	struct rtc_device *rtc_dev;
 	struct nvmem_cell *rtc_offset;
+	uint8_t shift;
+	bool async_rtc;
 };
 
+static int macsmc_rtc_read_clkl(struct macsmc_rtc *rtc, u64 *ctr)
+{
+	u64 request = 0xffffffffffffULL;
+	u64 response = 0;
+	int i, j, ret;
+
+	for (i = 0; i < 4; i++) {
+		for (j = 0; j < 40; j++) {
+			ret = apple_smc_write(rtc->smc, SMC_KEY(CLKL), &request, RTC_BYTES);
+			if (ret == RTC_BYTES)
+				break;
+		}
+		if (ret != RTC_BYTES)
+			continue;
+
+		msleep(20);
+
+		for (j = 0; j < 20; j++) {
+			ret = apple_smc_read(rtc->smc, SMC_KEY(CLKL), &response, RTC_BYTES);
+			if (ret == RTC_BYTES) {
+				if ((response & 0x7fff) == 5 || (response & 0x7fff) == 6)
+					return -EAGAIN;
+
+				if (response != 0xffffffffffffULL) {
+					*ctr = response;
+					return RTC_BYTES;
+				}
+			}
+			fsleep(1000);
+		}
+	}
+
+	return -EIO;
+}
+
 static int macsmc_rtc_get_time(struct device *dev, struct rtc_time *tm)
 {
 	struct macsmc_rtc *rtc = dev_get_drvdata(dev);
@@ -36,25 +80,36 @@ static int macsmc_rtc_get_time(struct device *dev, struct rtc_time *tm)
 	size_t len;
 	int ret;
 
-	ret = apple_smc_read(rtc->smc, SMC_KEY(CLKM), &ctr, RTC_BYTES);
+	if (rtc->async_rtc && !force_clkm)
+		ret = macsmc_rtc_read_clkl(rtc, &ctr);
+	else
+		ret = apple_smc_read(rtc->smc, SMC_KEY(CLKM), &ctr, RTC_BYTES);
+
 	if (ret < 0)
 		return ret;
 	if (ret != RTC_BYTES)
 		return -EIO;
 
-	p_off = nvmem_cell_read(rtc->rtc_offset, &len);
-	if (IS_ERR(p_off))
-		return PTR_ERR(p_off);
-	if (len < RTC_BYTES) {
+	if (rtc->smc->is_acpi) {
+		ret = apple_smc_read(rtc->smc, SMC_KEY(CLKO), &off, RTC_BYTES);
+		if (ret < 0)
+			return ret;
+		if (ret != RTC_BYTES)
+			return -EIO;
+	} else {
+		p_off = nvmem_cell_read(rtc->rtc_offset, &len);
+		if (IS_ERR(p_off))
+			return PTR_ERR(p_off);
+		if (len < RTC_BYTES) {
+			kfree(p_off);
+			return -EIO;
+		}
+
+		memcpy(&off, p_off, RTC_BYTES);
 		kfree(p_off);
-		return -EIO;
 	}
-
-	memcpy(&off, p_off, RTC_BYTES);
-	kfree(p_off);
-
 	/* Sign extend from 48 to 64 bits, then arithmetic shift right 15 bits to get seconds */
-	now = sign_extend64(ctr + off, RTC_BITS - 1) >> RTC_SEC_SHIFT;
+	now = sign_extend64(ctr + off, RTC_BITS - 1) >> rtc->shift;
 	rtc_time64_to_tm(now, tm);
 
 	return ret;
@@ -66,14 +121,20 @@ static int macsmc_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	u64 ctr = 0, off = 0;
 	int ret;
 
-	ret = apple_smc_read(rtc->smc, SMC_KEY(CLKM), &ctr, RTC_BYTES);
+	if (rtc->async_rtc && !force_clkm)
+		ret = macsmc_rtc_read_clkl(rtc, &ctr);
+	else
+		ret = apple_smc_read(rtc->smc, SMC_KEY(CLKM), &ctr, RTC_BYTES);
 	if (ret < 0)
 		return ret;
 	if (ret != RTC_BYTES)
 		return -EIO;
 
 	/* This sets the offset such that the set second begins now */
-	off = (rtc_tm_to_time64(tm) << RTC_SEC_SHIFT) - ctr;
+	off = (rtc_tm_to_time64(tm) << rtc->shift) - ctr;
+	if (rtc->smc->is_acpi)
+		return (apple_smc_write(rtc->smc, SMC_KEY(CLKO), &off, RTC_BYTES) != RTC_BYTES);
+
 	return nvmem_cell_write(rtc->rtc_offset, &off, RTC_BYTES);
 }
 
@@ -86,13 +147,15 @@ static int macsmc_rtc_probe(struct platform_device *pdev)
 {
 	struct apple_smc *smc = dev_get_drvdata(pdev->dev.parent);
 	struct macsmc_rtc *rtc;
+	int ret;
+	uint32_t clkr = 0xFFFFFFFF;
 
 	/*
 	 * MFD will probe this device even without a node in the device tree,
 	 * thus bail out early if the SMC on the current machines does not
 	 * support RTC and has no node in the device tree.
 	 */
-	if (!pdev->dev.of_node)
+	if (!pdev->dev.of_node && !smc->is_acpi)
 		return -ENODEV;
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
@@ -102,18 +165,40 @@ static int macsmc_rtc_probe(struct platform_device *pdev)
 	rtc->dev = &pdev->dev;
 	rtc->smc = smc;
 
-	rtc->rtc_offset = devm_nvmem_cell_get(&pdev->dev, "rtc_offset");
-	if (IS_ERR(rtc->rtc_offset))
-		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->rtc_offset),
-				     "Failed to get rtc_offset NVMEM cell\n");
+	if (!rtc->smc->is_acpi) {
+		rtc->rtc_offset = devm_nvmem_cell_get(&pdev->dev, "rtc_offset");
+		if (IS_ERR(rtc->rtc_offset))
+			return dev_err_probe(&pdev->dev, PTR_ERR(rtc->rtc_offset),
+					     "Failed to get rtc_offset NVMEM cell\n");
+	}
+
+	if (rtc->smc->is_acpi) {
+		ret = apple_smc_read_u32(rtc->smc, SMC_KEY(CLKR), &clkr);
+		if (ret < 0 || clkr == 0xFFFFFFFF)
+			rtc->shift = RTC_SEC_SHIFT;
+		else
+			rtc->shift = ffs(clkr) - 1;
+
+		if (apple_smc_key_exists(rtc->smc, SMC_KEY(CLKL))) {
+			u64 clkl;
+
+			ret = apple_smc_read(rtc->smc, SMC_KEY(CLKL), &clkl, RTC_BYTES);
+			if (ret == RTC_BYTES && clkl != 0xFFFFFFFFFFFFFFFFULL)
+				rtc->async_rtc = true;
+		}
+	} else
+		rtc->shift = RTC_SEC_SHIFT;
+
+	dev_info(&pdev->dev, "%u clock, using %s key\n", (clkr != 0xFFFFFFFF) ? clkr : 32768,
+				rtc->async_rtc ? "CLKL" : "CLKM");
 
 	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc->rtc_dev))
 		return PTR_ERR(rtc->rtc_dev);
 
 	rtc->rtc_dev->ops = &macsmc_rtc_ops;
-	rtc->rtc_dev->range_min = S64_MIN >> (RTC_SEC_SHIFT + (64 - RTC_BITS));
-	rtc->rtc_dev->range_max = S64_MAX >> (RTC_SEC_SHIFT + (64 - RTC_BITS));
+	rtc->rtc_dev->range_min = S64_MIN >> (rtc->shift + (64 - RTC_BITS));
+	rtc->rtc_dev->range_max = S64_MAX >> (rtc->shift + (64 - RTC_BITS));
 
 	platform_set_drvdata(pdev, rtc);
 
@@ -138,3 +223,4 @@ module_platform_driver(macsmc_rtc_driver);
 MODULE_LICENSE("Dual MIT/GPL");
 MODULE_DESCRIPTION("Apple SMC RTC driver");
 MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
+MODULE_ALIAS("platform:macsmc-rtc");
-- 
2.55.0

