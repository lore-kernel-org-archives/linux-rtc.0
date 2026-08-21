Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62230418A46
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787346751; cv=none; b=Eor4g6okqvZqzr1Gx9M4UGzvtKH3aAus9mVI2L0fv0cwOzLN+1u03M070B+DPZkNiTaXsa2Wp2kcdPCb/qih6hkpRY9gitTbFvBtvSGdrXGKSjdihdde/V2pYRKD+4WSjq5ftXn7PuBbocf5kCauF/oKYzQ7Ixa4KRdq29R2sQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787346751; c=relaxed/simple;
	bh=yBObii33XQtUMDVLhg3tSMOFUhkADs9/f6LHaLvE8qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZbqy6D+8OqMMgvjZSJbL68/L9Ls6GbRIdLyVgUYNci+6R0fksPwacoApdUn3TWcJWl52ZYRnk4nN/cRLtfXgfxtpCkELW/yrxXmuS6CtLUd8k0A7JayBJ/YfIrnGiiLEPMZr+Lad3a5PRdFbWi576oEIXfYZPDjovawsTLP+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ca2NyiPH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ca2NyiPH"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cf50c6f235so17955755ad.0
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 14:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787346750; x=1787951550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fF5C2lxgka8/ldFjOYo/eP0wFxrYBeqRPIw1nyxaOJ8=;
        b=ca2NyiPHpK5c1eh75RVL34aHtY3cfEZhhklEXCbFt2HrTOz1/YKJm4PGh6yN12dRbd
         aKXQvcxEJmTQogVGwU3OlT4UA8FsHTqAhi5bhumVYFHIZ3m9ekcSqxj/dKUJwXCuhPKp
         pFz2QMiA7t5hdjkELVwDgpbm/ShZ9A0F7bJRkt5I5TmErXCfjnrBk1EslpqR1SIFZ4HO
         iv2pKG656ML3/uHCP+ZVa13Io0XzZqSGIxpWJ6Ody+DD+S04Zz+q1QrMpxKEfcwwSnvA
         iuKZVhqBnAr5+hIQAYNOzb2t3anP/dwKNet7th8mKhZ620ijoB9tJRp75//WNknA/el8
         h70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787346750; x=1787951550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fF5C2lxgka8/ldFjOYo/eP0wFxrYBeqRPIw1nyxaOJ8=;
        b=IuaITppOnFe37ede6AY6v0reuymEiTBm4K0H/AFhWpEQQvJG/3FFHfzDwV/YU0MWOL
         ETC0iRU4+N/ZhrkJ+xu0sBB9lfsjwTOGmNNx2/4S2C7W8N15skBtnbLXzfXGRVC0yQFe
         YyRkLzMmCBG93oghgSwvMEcWDNymMP0YYtrDSCH39nFyMbZIfQ6tFzBxiOL501rLLmnB
         HwS9KP+odnnnPraRt3uhgck8Nqe6nuPgiu/Ts1I2hwAwa/dAbzZFu1m+21RhhC/HNuhX
         f7xW5n593YvJgQfL8l1Wt3kD0WyXnQvlHQs8WLDeIaO03bWEj8fZeVJuFPHaDSbKQYH8
         v6yQ==
X-Gm-Message-State: AFuF++lan2O/7JOkagREcUMDOVzoEWzY16pGQ31JpwnuWSHYkOoGwkLp
	J7CW9bCNhY1oJP3Q9TIHLNbjW3Q9p+GokH0ZPsgZHYBL9c5SJqP210ks
X-Gm-Gg: AR+sD12H6rPfXHVF1Ioz/02X7gzEbAouvkuYzHddviyLDcNEQQOYxZ38QQLEfs/02+t
	l8Kdf02pr2mbu3jfj/qWxkZ9ZRfBi6SQTThqmJRgkZVe5QBNaeD0w0K9dMWLu2Geb5VUwXPD74s
	rbDhylqJSoBgdymLl+cOmwMG5uHkL9x0hTdzpX7L26yT4Y+gp7k6j8e21R1C0PgeyKtKz9iVUaH
	jvOcuoE8ugK9wWrzPR3tK17gzyCmMMf5L1Usli2mkHNCnPapHgoJP0DiP4vX0ZLTOWFHdpxFCDh
	ijwV9/TYo6PVfh4G/kf4D7aENVh//4XBhEXhIx5n+XygHnIfJIPBra0iA1KvUcJeofXTDZZvuPP
	3PpywkuFIIU4lfeW7PCV8cDpQivWcrI4NjscNL7xMNUnkpyKIPSMfXAjf4v62/6SBQNsf3fFBVK
	nVu8lzjvmBD8ER3/3H1ojXo5yJPsGjgFpr7Kk0/b4yAWk74KJ/YYsNkjqbM2/VGf5IwVETrNFMN
	/KMJvQOBoJsOP6KgypmJaPbY06/GBAiBaXdWDWZC+kJHvado+vOQejmrTns8O1nTpdWlCGbRxm2
	cw==
X-Received: by 2002:a17:90b:3985:b0:380:71eb:4014 with SMTP id 98e67ed59e1d1-395c357d3a3mr15702940a91.15.1787346749757;
        Fri, 21 Aug 2026 14:12:29 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:194c:dba4:ea1e:d7d1:affe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf175399sm49755257eec.26.2026.08.21.14.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 14:12:29 -0700 (PDT)
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
Subject: [PATCH v6 15/17] rtc: rzn1: Add OF match data to gate SUBU register access
Date: Fri, 21 Aug 2026 22:10:30 +0100
Message-ID: <20260821211032.13554-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v5->v6:
- Fixed merge-conflict on rtc-next
- Added Reviewed-by and Tested-by tags from Wolfram

v4->v5:
- Renamed rzn1_data to rzn1_rtc_rzn1_data
- Added a print message to indicate that SUBU mode is not supported
  on the variant.
- Added a comment to indicate that the xtal clock is NULL when SUBU
  mode is not supported.
- Added Suggested-by tag from Wolfram.

v3->v4:
- New patch
---
 drivers/rtc/rtc-rzn1.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 33c7ef5c1eba..8c3dbbc34717 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -19,6 +19,7 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/rtc.h>
@@ -66,6 +67,10 @@
 #define RZN1_RTC_TIMEC 0x68
 #define RZN1_RTC_CALC 0x6c
 
+struct rzn1_rtc_data {
+	bool has_subu;
+};
+
 struct rzn1_rtc {
 	struct rtc_device *rtcdev;
 	void __iomem *base;
@@ -405,6 +410,7 @@ static void rzn1_rtc_disable_hardware(void *data)
 
 static int rzn1_rtc_probe(struct platform_device *pdev)
 {
+	const struct rzn1_rtc_data *data;
 	struct device *dev = &pdev->dev;
 	unsigned long rate = 32768;
 	struct rzn1_rtc *rtc;
@@ -412,6 +418,10 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	struct clk *xtal;
 	int irq, ret;
 
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -ENODEV;
+
 	rtc = devm_kzalloc(dev, sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
 		return -ENOMEM;
@@ -455,8 +465,12 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 		if (rate < 32000 || rate > BIT(22))
 			return -EOPNOTSUPP;
 
-		if (rate != 32768)
+		if (rate != 32768 || !data->has_subu)
 			scmp_val = RZN1_RTC_CTL0_SLSB_SCMP;
+	} else if (!data->has_subu) {
+		/* xtal is NULL here */
+		return dev_err_probe(dev, -EOPNOTSUPP,
+				     "No valid XTAL provided and SUBU mode not supported\n");
 	}
 
 	/* Calculate the duration of two RTC_PCLK clock cycles */
@@ -509,8 +523,12 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	return devm_rtc_register_device(rtc->rtcdev);
 }
 
+static const struct rzn1_rtc_data rzn1_rtc_rzn1_data = {
+	.has_subu = true,
+};
+
 static const struct of_device_id rzn1_rtc_of_match[] = {
-	{ .compatible	= "renesas,rzn1-rtc" },
+	{ .compatible	= "renesas,rzn1-rtc", .data = &rzn1_rtc_rzn1_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rzn1_rtc_of_match);
-- 
2.43.0

