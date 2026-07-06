Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D26D42E000
	for <linux-rtc@vger.kernel.org>; Mon,  6 Jul 2026 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330366; cv=none; b=jGwe85pflKSCsXxq3Tikr0omUogtWdO3uiAEEggS4Pz8NJODEW6mq5jvguJVM32eX/G86bfFAYKiOR+uhdHKzBGOpXCBkiwoz6DDgGohd5Y63Gw4Ev38ese57e8T88zUtRHE/AZXlghHvDfLXnM9PH/KU/M72J15FiA0o3T7SM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330366; c=relaxed/simple;
	bh=gRy0cN4LadJrCLwhwvNgyXM95hAtl0BkbsLdjuQgW6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rpnJ63+z47GC+jYxu9OOuxn5CThWOjFv8whJl1LNViCQHTwxcAi8P1wnU7xVAW7rlQtIW7f7rgBJCF/C82YjioMLxJK529XdK5ZwEA+GM91/nA/vLHCbFUYlvgjjuGW4P6b2YgVVJgQdv2RlbXCHqeyEJ64x7I0whVASNS0L36E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=AFvRO7xA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="AFvRO7xA"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493b7612475so25492635e9.3
        for <linux-rtc@vger.kernel.org>; Mon, 06 Jul 2026 02:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783330357; x=1783935157; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpZvamYw9AnVrZnk1GFQEFXSHxgLU3wS0Rp+AMjlVD0=;
        b=AFvRO7xAjGEzkpt6ryXRWzKzc+epUD3KhyJ7lVkwpdXW93uBaS6n5Wc2Su+u/10XJB
         9mgJ9QQq22neqpri/QlTXtfm3kP5QsrwYEfXJuLQTvllv+zJ/8XeMqR77dZ0atfYGN4c
         Pf/zQlsItqN80N2e2RwWSYkJflp17h+jMvaVVr1g61rA1yIkuTBLTVl+8NCPylDcXx+g
         ugavKRkkbg2kPpbFd4wZSALp3X4L17vGmUSckpkGIHGJ4jOFzlt4TBZQfwNgNdC7tFYA
         n3Z8YxX1IX9Nr5boCbkdSBseP2JXVc5QH6tGewsFoJKmt7S2zD+exh/HoM/9aCMcnNYF
         Vdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783330357; x=1783935157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gpZvamYw9AnVrZnk1GFQEFXSHxgLU3wS0Rp+AMjlVD0=;
        b=KZluHYEfq/8xyxX2y3RLXW+8NQFHoC2I9lvTrQHhq+veRMctE+MdfzTLDiuRCAjMEm
         g3oAMqU2IJD+jHjHOxPmcun6T8oeJni3+4Ss7X37ymYVBxYCr6DNbeJi6n/F/1sftb0t
         6C5Nv6nf0phTmbQuC7LrDwg/QmQ2pRcpXU9gvjP1tgRe3v1sayPpidO3u3o+sVAGr6cF
         MVRoWOymyvZ4H/14NrteogXNA3theQ/VWYtWY0QeJfDN5lNYcq9KdJMu3iNQbnlJfqOk
         m4Bo522lipyrE5l1TnZ/OLCdBmv+PjJyRP8/JmXeT6tn296c3yyZY6EQT3rYUVgRc5BB
         1MTQ==
X-Gm-Message-State: AOJu0YzrMjN8QZC7iDoRD1bbhZLnGN8jaYfguIQW9Nc6bah/HaPQusr5
	okj1cTuRJpQo3twP/i09nAHXeK0+8VwifFyYD5k8lc5RdJ73AOh91u42gCGVlg/FkRk=
X-Gm-Gg: AfdE7cm0W10z/NTmsjUs1Z5oFr0Uer3g0boMCd/fGnamOV8e4TTJvUhVIFtzPUL5GEU
	2EmH8Es7DzWdKhP27w7qcC6Ls2k/OIl6V3gsACZRUHY+0NGgqfA66C5lYlI9MoqO6CeLtaq8MWA
	luZqLTVGz0V1MzJpC8SQkyWKbb+uKZVsGxPQ0Yx775Cr2ryeFzKwdpdmMkqPND5rd0sYijsyVVb
	2JtaM/UWNz3OU2HFkyrybT/bL6HdHTlknRKtz0dP2YLpsqJCqUoZ5KISIOpYGIF4mh1irhNbsPB
	Cnrpeex0Gn2jeYceWH5MlnHnGjX/5XDjoU/ICT6vcsyLiapM1BjkkYV2+aO82Z+bQvodL6fBPuA
	aUV23zqUd/n8bOsBIDR4FO7+PgiRzarNDOuW4QtoQcovePtnQAT+2c/e0PBr+m/YnpQk0ZR8p5k
	WN4Ywn09rmYxE=
X-Received: by 2002:a05:600c:c118:b0:492:3e66:6c84 with SMTP id 5b1f17b1804b1-493d11f918cmr92947785e9.30.1783330356762;
        Mon, 06 Jul 2026 02:32:36 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:1495:8c97:96f4:dff8])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493bef11338sm377772315e9.1.2026.07.06.02.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:32:36 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 06 Jul 2026 11:32:13 +0200
Subject: [PATCH v4 5/9] clk: sunxi-ng: sun6i-rtc: Add feature bit for IOSC
 calibration
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-a733-rtc-v4-5-f330728db3d3@baylibre.com>
References: <20260706-a733-rtc-v4-0-f330728db3d3@baylibre.com>
In-Reply-To: <20260706-a733-rtc-v4-0-f330728db3d3@baylibre.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3560; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=LjKLqtELI/k5Bm86qG39EiNLmLLQg2pvRCFKcypyAtM=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBqS3Ykm1EkaDJ069gqM3tqzZUAo6EzOomoBvrrG
 TY60PbIiaqJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCakt2JAAKCRDm/A8cN/La
 hY6PEACcL49Jv+12kjoAQsDpUPA5V1xw9VbQsEtOPVlm9vqqWLHZwoaPT4wAlORrO3AdWbLsP99
 3Va3GrObwSKZUgSScUTpAR9hNRd4uB9ay8wsEnI5doSKc0OxjECZvx5YIFWne9fn5wvJSY4dABo
 Nd1qkF+KcOd+L3w+z1WMzohuFIjRPeYo03b4QghplwZxrZrOO3erSNWE/6WdDYAVfiqCz8ozF7T
 sOBaTPh2Ya9YSPxG8OvqNnj8m1N/ozmgUCXMacKz6ZkiZUSWhwNSKytFZLrzlQHAV6d68XpK3Bd
 ztEjka3alClmehE5im7V14RfDcdAlcVDAIrxt2BCWmSHynOdEeykUKnkDaLBjC0VB3J9S0mK/Ea
 rfPUwIey53EGCzJWVafrOw20jOAmZYKXKC9jrmjmGIrrPI3kuQ9cb3jK+OlPdg2Dty7QiTX0Vnv
 smnFnurV6vL6UW4exhKbzae8TERopeRgMXTYpc1OYQuFqA7ayOUzRGbgj7eo/IIxrdfk1Am/LDz
 x9P69Vo0/ZnQUBQfQJD9pJPD30bDdiqSBFh4IGlArPzp/azMB7F7CxxS3rXjTlYfNTQAOOxYVQ4
 VUMsLMUDKkFUmjJH3j5UYg9xA0MhEEwbjcDiIPXoe9Lohy72G0WpUdGGtMMf45iETg/TYiK8S3/
 FwG9c4GpEzDcYfw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

From: Junhui Liu <junhui.liu@pigmoral.tech>

The sun6i-rtc CCU driver currently uses a global static variable to
denote whether calibration is supported, which makes IOSC operations
tightly coupled to this file.

Convert this into a feature bit to decouple the logic. This allows the
IOSC clock code to be moved into a shared module for reuse by other SoCs.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 17 +++++++++--------
 drivers/clk/sunxi-ng/ccu_common.h    |  1 +
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
index 0f528bfaed00..b24c8b196e66 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
@@ -52,8 +52,6 @@ struct sun6i_rtc_match_data {
 	u8				osc32k_fanout_nparents;
 };
 
-static bool have_iosc_calibration;
-
 static int ccu_iosc_enable(struct clk_hw *hw)
 {
 	struct ccu_common *cm = hw_to_ccu_common(hw);
@@ -80,7 +78,7 @@ static unsigned long ccu_iosc_recalc_rate(struct clk_hw *hw,
 {
 	struct ccu_common *cm = hw_to_ccu_common(hw);
 
-	if (have_iosc_calibration) {
+	if (cm->features & CCU_FEATURE_IOSC_CALIBRATION) {
 		u32 reg = readl(cm->base + IOSC_CLK_CALI_REG);
 
 		/*
@@ -119,7 +117,7 @@ static int ccu_iosc_32k_prepare(struct clk_hw *hw)
 	struct ccu_common *cm = hw_to_ccu_common(hw);
 	u32 val;
 
-	if (!have_iosc_calibration)
+	if (!(cm->features & CCU_FEATURE_IOSC_CALIBRATION))
 		return 0;
 
 	val = readl(cm->base + IOSC_CLK_CALI_REG);
@@ -134,7 +132,7 @@ static void ccu_iosc_32k_unprepare(struct clk_hw *hw)
 	struct ccu_common *cm = hw_to_ccu_common(hw);
 	u32 val;
 
-	if (!have_iosc_calibration)
+	if (!(cm->features & CCU_FEATURE_IOSC_CALIBRATION))
 		return;
 
 	val = readl(cm->base + IOSC_CLK_CALI_REG);
@@ -148,7 +146,7 @@ static unsigned long ccu_iosc_32k_recalc_rate(struct clk_hw *hw,
 	struct ccu_common *cm = hw_to_ccu_common(hw);
 	u32 val;
 
-	if (have_iosc_calibration) {
+	if (cm->features & CCU_FEATURE_IOSC_CALIBRATION) {
 		val = readl(cm->base + IOSC_CLK_CALI_REG);
 
 		/* Assume the calibrated 32k clock is accurate. */
@@ -167,7 +165,7 @@ static unsigned long ccu_iosc_32k_recalc_accuracy(struct clk_hw *hw,
 	struct ccu_common *cm = hw_to_ccu_common(hw);
 	u32 val;
 
-	if (have_iosc_calibration) {
+	if (cm->features & CCU_FEATURE_IOSC_CALIBRATION) {
 		val = readl(cm->base + IOSC_CLK_CALI_REG);
 
 		/* Assume the calibrated 32k clock is accurate. */
@@ -358,7 +356,10 @@ int sun6i_rtc_ccu_probe(struct device *dev, void __iomem *reg)
 		return 0;
 
 	data = match->data;
-	have_iosc_calibration = data->have_iosc_calibration;
+	if (data->have_iosc_calibration) {
+		iosc_clk.features |= CCU_FEATURE_IOSC_CALIBRATION;
+		iosc_32k_clk.features |= CCU_FEATURE_IOSC_CALIBRATION;
+	}
 
 	if (!data->have_ext_osc32k) {
 		/* ext-osc32k-gate is an orphan, so do not register it. */
diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu_common.h
index bbec283b9d99..d9dc24ad5503 100644
--- a/drivers/clk/sunxi-ng/ccu_common.h
+++ b/drivers/clk/sunxi-ng/ccu_common.h
@@ -21,6 +21,7 @@
 #define CCU_FEATURE_CLOSEST_RATE	BIT(9)
 #define CCU_FEATURE_DUAL_DIV		BIT(10)
 #define CCU_FEATURE_UPDATE_BIT		BIT(11)
+#define CCU_FEATURE_IOSC_CALIBRATION	BIT(12)
 
 /* MMC timing mode switch bit */
 #define CCU_MMC_NEW_TIMING_MODE		BIT(30)

-- 
2.47.3

