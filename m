Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBAF44E654
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136073; cv=none; b=tfLd+JTp/2C7L+1UU8ycUrIPaEG+9kTW+H5Wzdm69KJjueo5JSC2GJaIwxf/vfWV1lGPJlHmxOB3cJN8vcPv7tTUNiQ4V/Rd44d+Z5ZHl8diXH+K+KvYFFY9qOYp9+QCmfrD1P+LQkgF3coLhCx1QaR6511CoIT9n0uU9a52h8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136073; c=relaxed/simple;
	bh=u4VgIyfXWMB8BkJNBw63P10SL3BGld4PWaviUvNwfhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTvg8B3U8CJLF6mMLOhX0xzYftoPmjNGZOi04rDkxAFA+ZV6ZlY7Q3s1DkkYoUE7s9Jluazw83NhGvi0mytAU82RVh3MtfmraFWKvIYLrPDEJhMLWx7zEh6//RzanW/XQookHX5wujITNopUWiLyzB4tnboY82lzEEh0oCUOZQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5tB4XlR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5tB4XlR"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf50c6f235so9390995ad.0
        for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 03:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787136071; x=1787740871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0X7PVCFnMu15gJNVFEZ+mwlsTpP3SMGTChmDH3l0QZ4=;
        b=E5tB4XlRWr52tfd3A5b6Z+WxgWbrk5d7COOJAsVB75gl0KayFpow50NhTemsgD4A/x
         xMsL76EeriqB3BR/jpS2KcpZeafkAtePh/2lQunNF/WorMxNOIaB2GAX9NR5VWITDvgC
         SwHCSE4v5fYL5Erdw0IEJJp5m+3ti7k+n9ZrGg4p8eWhnzNgC16Gl8AcoV1y8qNmANIM
         lu2kVuruzFnwawyP5JA1M7km5iM52UusKglDvi93z3SO5ociA0OLQnuTrRwoVplRt7rf
         e/3r0bkLMYjshIb+Kxs3n2P/dGnzyECPEnjrcqyG6QxGCjzOTruyDragphXf/9lIexqj
         4KmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787136071; x=1787740871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0X7PVCFnMu15gJNVFEZ+mwlsTpP3SMGTChmDH3l0QZ4=;
        b=cRkrc6uDQPo+y174EgFKbJ62mZ77DYT8pD/Abt3vlNZw3TzhwlQ/eBBQQfOB61WnTw
         zMHw3HhAVPuY1TrzrNgOgfJOlVSe94JUwH7xHUWUeiOahH/HfHV4DszbsOCvkEb4mCmw
         U55ARO/wxT4NNtZJRQizAE6JTYwwyswCSStBwH8CZfL7KlmOUM0+ngMUYg1Hs9FYahfE
         Ptq0OG5m6ffTBYmox/MWD4AsNcgPJPvRkDMdduawy+Lg887YhHABr94GGkUjuyb1oFFX
         g2/wJ7+Fg21UDt/4FKUua5FHr6O2DpYlA+vpEVMJPPi60w3gpjyrdxA2aE+43gz6zqqU
         UCCg==
X-Gm-Message-State: AFuF++kxgSecuEfaPJvKcRSC6bdFWsAj4HN/zidjZYXyvcos7vLQQt0u
	ZG+hqx2Mz5Et4Zs6MZddv9V8S55RhMtai9drAMBftez6orspGD0OWf/N
X-Gm-Gg: AR+sD106lbAryrH00qTs7s+PSTMbyGIf88FUj9tfApX4TrXV7OB25cI3bBm/+gggLPu
	HWPjdQKTLpNNzZU9iB/K+UZzoM+J2UYj5fPKjjcMskfuZXhmUCUUcN9XjQx/cfRkPBw+BUA2tlG
	HbnADDfFydOeB6jxGqQLDrnuj0hOwkoscY0ibdMzCAxfm0FajLCQmGDq6G2pSLZQsBpkO23YAgV
	mpfVryKkT7IPWjyigcWj2dou44vxTouxjiSXPGDxmYtx7vSjt4eLoT/VN42bvenjU/cEpOqnK+5
	E06SEtwO/EaoKeMCbQXm1ngdhHO86KhfyqyslTUSWjyicdXAOJdwJELImyqJbKlsXROKsptNYjP
	LGQArFwbu8yQ+Fmqu9JzvOVaFizSSzJr/3ZErOXBsi/RdU5AhS8Ostx5CX1LBmKRQBQ3nB0kjQC
	toK4T6ZJVkt/oFY7+Mu7zppymCQB5a3sBCUZm/PrjbanQOLRaDb/YrQn6xrV3eEHIGZzIbk+tLn
	P6zFFaa5sbycJgHvnNClQS2KvzDluIZyMnceEQZfDjMbjGZVsTLu+J7rM+ccGMTaRCNxPFi2S9t
	GdyezqVi6Q==
X-Received: by 2002:a17:902:d483:b0:2cc:f5aa:9513 with SMTP id d9443c01a7336-2d5fd6fb665mr60736685ad.10.1787136071114;
        Wed, 19 Aug 2026 03:41:11 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c07:efb3:a897:a9b5:e171:c935])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef77fc0sm11169630eec.8.2026.08.19.03.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:41:10 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 13/15] rtc: rzn1: Add OF match data to gate SUBU register access
Date: Wed, 19 Aug 2026 11:39:24 +0100
Message-ID: <20260819103926.2136712-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The RZ/N1 RTC driver selects SCMP mode only when an optional xtal clock
is provided at a valid rate other than 32768 Hz. Without an xtal clock,
or when it runs at 32768 Hz, the driver uses SUBU mode.

However, the RTCA0SUBU register used by SUBU mode is not present on all
SoCs that integrate a similar variant of the RTC block. Allowing SUBU
mode on those variants would expose RTC offset operations that access a
non-existent register.

Add OF match data to describe whether the RTC supports the SUBU register.
Reject probe with -EOPNOTSUPP when SUBU mode would be selected on a
variant without SUBU support.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
- New patch
---
 drivers/rtc/rtc-rzn1.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 02cff5fe117a..202840eb86a6 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/rtc.h>
@@ -65,6 +66,10 @@
 #define RZN1_RTC_TIMEC 0x68
 #define RZN1_RTC_CALC 0x6c
 
+struct rzn1_rtc_data {
+	bool has_subu;
+};
+
 struct rzn1_rtc {
 	struct rtc_device *rtcdev;
 	void __iomem *base;
@@ -391,6 +396,7 @@ static void rzn1_rtc_disable_hardware(void *data)
 
 static int rzn1_rtc_probe(struct platform_device *pdev)
 {
+	const struct rzn1_rtc_data *data;
 	struct device *dev = &pdev->dev;
 	unsigned long rate = 32768;
 	struct rzn1_rtc *rtc;
@@ -398,6 +404,10 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	struct clk *xtal;
 	int irq, ret;
 
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -ENODEV;
+
 	rtc = devm_kzalloc(dev, sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
 		return -ENOMEM;
@@ -445,6 +455,9 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 			scmp_val = RZN1_RTC_CTL0_SLSB_SCMP;
 	}
 
+	if (!scmp_val && !data->has_subu)
+		return -EOPNOTSUPP;
+
 	/* Calculate the duration of two RTC_PCLK clock cycles */
 	rtc->sync_time = DIV_ROUND_UP(2 * USEC_PER_SEC, rate);
 
@@ -495,8 +508,12 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	return devm_rtc_register_device(rtc->rtcdev);
 }
 
+static const struct rzn1_rtc_data rzn1_data = {
+	.has_subu = true,
+};
+
 static const struct of_device_id rzn1_rtc_of_match[] = {
-	{ .compatible	= "renesas,rzn1-rtc" },
+	{ .compatible	= "renesas,rzn1-rtc", .data = &rzn1_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rzn1_rtc_of_match);
-- 
2.43.0

