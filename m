Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE1648F842
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320617; cv=none; b=qblq3p3P7kVdMlzXztLqg0L4+ud6Nep3FD/4OmFQmZ7FryMeePvB7YnF1xJvhC++VCPuQWuPyU5znFoW0fJDcR4TaCXo0Y0W4TxUEAHdI75q0SOg4pyB02rU5jVXdbVQAet4pNbPZHc06uj+bd3cMn+YY3VJfz3OtIm6vHT7dks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320617; c=relaxed/simple;
	bh=UTdaoDgRCp5m/9ZYPIxOt/TUt2k/3Iv3XjJlMaJ38PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNulYke4yaXbqBYy5hOXXO8fer86bw9L9fbh45m0ZzKI4TVkVV7utrxCIr4JZi7YxKQbDIqBvUjHLTOzmT+qHWiFjR0xnVkY/IdBGnin4IBGrvL4LlN3X6i2cL7toOoWA4Nh6P4NQcCoH3f63bLjPM7Ty0i1FmPu15EOSbMgrIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SP7LBz99; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP7LBz99"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc11a30a259so1045036a12.3
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787320615; x=1787925415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oIn/JR7QSML3LbxalAPrR4Gs+07rBcCA789wVYtHyok=;
        b=SP7LBz99tQGWq5iWJtd6FvXFClJQLZm4iULsiJcipIxbMwwVBOwR1DgTxTRYwpQtSx
         uzPOpOM3/7ZB4+Ygzbe2lREPI9RVwA5nt5ZtXPdHWR9DIdorTpDUR1TgxqdZ//MB3/qq
         vf4yJ5TXlFvuXGjR8kkGfyn1a6RqifzzafkRcLJgCqiKfiwDjGWliDiKxeWMaXdxnSGP
         NPQXhwBBPEcWMlOR0QEMbc0RoqPCJmlbcspKTdS52wVYYh0FCVoGN/fFmQAT3OvtXQfE
         j0yCMSqrXOSXwngKt5ZqOc94lJ+vqHo23ao3T0zdAXhJwjF+2e06aknPU++bdwfn5L0p
         Bx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320615; x=1787925415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oIn/JR7QSML3LbxalAPrR4Gs+07rBcCA789wVYtHyok=;
        b=PWPrvfYDut0kJBgJZ7qQVb8kuBpiJtYGms4t0HaSoNJYXeCWy4fZ60MX2KPj224Q1P
         N12EqHYGegdY9w4mK6VQHfRlOF8+jDmEUyyVNIx7onmHhu+ilpgzJgkgXaUQpGFl/ZE8
         t19Qyi/jOQ7EvTJSF/IYEXa9gmGlp4WRag2IRgrp7h2tB9ApNE9snXhulagzDVNg696U
         0NmqDRhbkdmupAeQkJU0WL0dV4iWyVgIM5Wu0PRCnIcQ84l70K0beZbanZd38XWIrm9k
         k5Xoe2sLlSFNXIlLP80JDLlodhXM7yIpzQ8GZoilAHhdS5r/5Dsyao/vvGA61w8zCvCy
         Nwlw==
X-Gm-Message-State: AOJu0YykemXsUAcZsIIVwmZvEa48zdrtKXDPvoVOvI0PZ+7i0hs8v4QV
	HwulfbkJ00FSJbsSPALCi+zFDxiVKhhY5yV0VPvJYRVypIkGFEIFAUCN
X-Gm-Gg: AR+sD10TDnGKk0WgTd+pkEfM0TeNj8arXMqmFYTIbFKN11mNKXRit9lIy4gfmGnilup
	pkkcIYejlJWzbg0opvRGZWPOxXjkSWqnFS0YY5zcmuE0jVDnr33zZIGTVGxmZfKiD4Tr22v8LjZ
	LHmINzT/i5Ptk4SkEbNouNdLfTXwWa79VX3jCymBeas4jSPN32C5kR04D3tpJcPk5lIhcgTL2dD
	GiknoVx99ZieS0t/PcwH/fKrkSzxiPZL86p4iU65uWjOmckKNHdqAEBEjeveFShQgCkmEWxKzm/
	ZGJRJkHbnOMLevkdEXGLOBmi/ze0daEhlluYq70paLysk94CYuaz5uQye8WtGlyOeH2b/zbDvDW
	1Wln3oGDCnlNLTfYq50iIIlgOQr94Y1N4bSZuMtyEs7xMafb8V5zKKlJx8aIUI53ifiEbt/RBd3
	DqB//fH/Dbh3ekkFA/HjcjMWIbQr5ouj4MA3CL0qqg4VvfRoxjKm6zszk1LYVdKCEyZgWpd1Boi
	B8INB91l8zJY/Mx+6dU7cgxSKcPtLInrhO3Jm7Jp+9aXbmzdvfUgI7cWdbsbcREF+BHoI0i47zo
	P73/KAtpcw9rXiiK/sLu4w==
X-Received: by 2002:a05:6a20:ac44:b0:3cc:f008:8123 with SMTP id adf61e73a8af0-3cd2fd9e554mr13238918637.8.1787320615049;
        Fri, 21 Aug 2026 06:56:55 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c07:efb3:773c:1c8c:24ea:eff6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327d01ff056sm19972277eec.19.2026.08.21.06.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:56:54 -0700 (PDT)
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
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 04/17] rtc: rzn1: Handle unset alarm weekday in rzn1_rtc_read_alarm
Date: Fri, 21 Aug 2026 14:55:55 +0100
Message-ID: <20260821135608.275233-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

RZN1_RTC_ALW is a weekday bitmask where bit N represents weekday N.
When no alarm has been configured, the register has its power-on-reset
value of zero.

rzn1_rtc_read_alarm() uses fls() to convert the weekday bitmask into a
weekday number. When RZN1_RTC_ALW is zero, fls(0) returns zero and
fls(wday) - 1 evaluates to -1. This invalid weekday is then used to
calculate the alarm date and can either leave tm_wday set to -1 or
produce a fabricated alarm date.

Treat a zero RZN1_RTC_ALW value as an unset alarm weekday and return
without calculating the alarm date. Move reading RZN1_RTC_CTL1 before
this check so that alrm->enabled is updated for both configured and
unconfigured alarms.

On a cold-booted board with no alarm configured, the following was
observed before the fix:

    root@rzn2h-evk:~# cat /proc/driver/rtc
    rtc_time        : 00:00:19
    rtc_date        : 2000-01-01
    alrm_time       : 00:00:00
    alrm_date       : 2000-01-07
    alarm_IRQ       : no
    alrm_pending    : no
    update IRQ enabled      : no
    periodic IRQ enabled    : no
    periodic IRQ frequency  : 1
    max user IRQ frequency  : 64
    24hr            : yes

After the fix:

    root@rzn2h-evk:~# cat /proc/driver/rtc
    rtc_time        : 00:00:25
    rtc_date        : 2000-01-01
    alrm_time       : 00:00:00
    alrm_date       : 2000-01-01
    alarm_IRQ       : no
    alrm_pending    : no
    update IRQ enabled      : no
    periodic IRQ enabled    : no
    periodic IRQ frequency  : 1
    max user IRQ frequency  : 64
    24hr            : yes

Fixes: b5ad1bf00d2c4 ("rtc: rzn1: Add alarm support")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v4->v5:
- New patch
---
 drivers/rtc/rtc-rzn1.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 8c70dbf8c7ec..e0fdb591ba91 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -234,13 +234,24 @@ static int rzn1_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (ret)
 		return ret;
 
+	ctl1 = readl(rtc->base + RZN1_RTC_CTL1);
+	alrm->enabled = !!(ctl1 & (RZN1_RTC_CTL1_ALME | RZN1_RTC_CTL1_1SE));
+
 	min = readl(rtc->base + RZN1_RTC_ALM);
 	hour = readl(rtc->base + RZN1_RTC_ALH);
-	wday = readl(rtc->base + RZN1_RTC_ALW);
 
 	tm->tm_sec = 0;
 	tm->tm_min = bcd2bin(min);
 	tm->tm_hour = bcd2bin(hour);
+
+	/*
+	 * If wday is zero, no bit is set in RZN1_RTC_ALW. This is the
+	 * register's power-on reset value.
+	 */
+	wday = readl(rtc->base + RZN1_RTC_ALW);
+	if (!wday)
+		return 0;
+
 	delta_days = ((fls(wday) - 1) - tm->tm_wday + 7) % 7;
 	tm->tm_wday = fls(wday) - 1;
 
@@ -249,9 +260,6 @@ static int rzn1_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		rtc_time64_to_tm(alarm, tm);
 	}
 
-	ctl1 = readl(rtc->base + RZN1_RTC_CTL1);
-	alrm->enabled = !!(ctl1 & (RZN1_RTC_CTL1_ALME | RZN1_RTC_CTL1_1SE));
-
 	return 0;
 }
 
-- 
2.43.0

