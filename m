Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573174156E8
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787346746; cv=none; b=aGw5k5gddWZ803GcXEQ/k6OSgjiteblkuvmZl6w5va4gr42q7pEKLQLiksNX1TTFtxmt0trMT4HAqqSZc/rmDFgpjyP/axMRlZ2AfX/d2c71QD14HKYsZQT4oD+IqUirtNtXp0Uh7JnYDMKcztWTfqh0hu2gzpPjI57C4Zr4gEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787346746; c=relaxed/simple;
	bh=kp0XQgrlKVOiCLMcJ6To99Zr2GXCqqLHe0FU78FVMEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2pfPS469ZAPJg6Xy5cm9VUSglouKvFCCYQYoRCzBw1sd5cfQp3MLV6k6sdiabgjvnCnPmV7qabXJWZDzYMl/eP0PTFf58QyVYcGRfhbh1AfV8mIQ6+gDwnKtcSST8rEFPMQewWJl7WR64xYm2a9+mHI4DnnVDkH54Mjaq/La2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9orZ8me; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9orZ8me"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84830c774a0so1615535b3a.1
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 14:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787346743; x=1787951543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZaUWtPTrtueUn4WNcW3dNefbXmXkUwCgtLqgcO6NO5U=;
        b=I9orZ8meI/WEodCIPLys4xKzDWV2ggBtDQ7IT4gtdru7uB+YvAE/fl4rIQcryjazMg
         KjsDzNfzty+kAIwU9Cr1iXAfUueVMfvDlgCQuxobDWmSGldIMC8x6CrTwF0jc4nXivuf
         F0122ySdE3FEvQrDb0A22YaRnpaUOsbPEqphsbJT/VXmjAflvsRAhJEU1DEFjWQBbeHd
         22gpEMTKQdihRLzNxdwu0Z9qo8quplKFUxrkohxe7hPG8AmUCwyhxF/WJSWJ3jS5f7JT
         Qgolple6i5phJoqRS83MLQQTYPvHbFCx5GeU3g+4Q85mzYWUU6NMW7ldsufTcdGanmv6
         VaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787346743; x=1787951543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZaUWtPTrtueUn4WNcW3dNefbXmXkUwCgtLqgcO6NO5U=;
        b=H4b/dugvJ8i4qClWa325aXAJnYDG3jMBl7r0DuYsdAdnvsUd46y4xttUy9xb8/cZK7
         tb3K+E9hl5TGF3z606WboNckPA1h7NmUC5fDsuA3rFDBjuolIQi3oU/kckWqJlv+ysDQ
         G+ecpAtOS0enkQVifE4A+0NNm+uG2dDRfX8pC/sDiE/aplb12U8ySjOMgMuiGrFeoaOV
         NgQLG3m1sEFoj8M/KtYWN5urzmdvlDS1N6+13xeY97Yoai9d7ZBZKiLhejbk8M6q4U+e
         tmTrmaGpccRWLCAno8Jh7UBIG5CWXyp10YmkD2RhYNOzVaQsiDVZHwh9f50yfmuCh2tk
         Nz9Q==
X-Gm-Message-State: AFuF++nodk2/0k9BeMBoaCOLk9Fcm4nY6nFhxw/4ylMVi/aUTHEwX03A
	F1p5YZiOWyjtj09NletCKWj1pcq6ffK9ttqXg9hcc8Bszy4F4DvXw0k9W/cOn01v
X-Gm-Gg: AR+sD11T1tSHaGOoSDTLhMRyhYipRXZchA2xEa8WAvhPnhfzCuchh57JUor4+KZjci3
	fvcbWLvUgo3hzxJhGc/yBZgRkvr1NBCr45U1QeXrFuZMXpmWxA0eKQO/RnORAKvoo/8ExzQkg0m
	J4KL75dWhXw8HLpOOIimQH/CgXtfN59u68tqjH9Pswp0JVzr2eZCyryWYChgEoBe/gj6IV66xTz
	GS05gSEDowLmPo/Os53+bqBHkJ4DyByEgJ7/aoQVKaZfH543NOdfdoGGD15O00fvYUVktV2yrQj
	wdjAdt7js/c0YRe5K2r2s5y05byPiVsBrA4De/0bvWO6g7T93LS6baN5To86shukpo63UehrW/b
	7+SAExKji7qhcbfkkcbpWEGbJR54P3Fy6Ltj7ys5/b3SJYQ1Err5D1sRNktDJsVtnddiCPWRq28
	yYMMP5F9UxMayl1J7ZZ2v2fPVST4an/h6MeTOjMkEwVZwNmBtRaV0JUKLvlovDUS7+cKuMXSO7g
	WGAS8i+Xf0X7OwkQb1StThSjGiA7xsABzlyHn8M05VVbTXw1a0AAq5f06o5r91CX1/iaRPc
X-Received: by 2002:a05:6a21:1fc8:b0:3cc:9316:cad3 with SMTP id adf61e73a8af0-3cd2fa367c0mr19094132637.0.1787346743522;
        Fri, 21 Aug 2026 14:12:23 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:194c:dba4:ea1e:d7d1:affe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf175399sm49755257eec.26.2026.08.21.14.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 14:12:22 -0700 (PDT)
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
Subject: [PATCH v6 14/17] rtc: rzn1: use FIELD_PREP/FIELD_GET and GENMASK for register access
Date: Fri, 21 Aug 2026 22:10:29 +0100
Message-ID: <20260821211032.13554-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Replace open-coded shift and mask operations with the bitfield API.

Note that the weekday field is changed from an explicit 0x0f mask to
an 8-bit field definition, matching the hardware manual. This does not
change behaviour, as valid weekday values cannot exceed 7.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v5->v6:
- No change

v4->v5:
- Added Tested-by tag from Wolfram.

v3->v4:
- Added RB tag from Wolfram

v2->v3:
- No changes.

v1->v2:
- Made use of RZN1_RTC_SUBU_RTCA0FX mask for SUBU register access
  instead of 0x3F.
---
 drivers/rtc/rtc-rzn1.c | 50 +++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 9fc93afee1e5..33c7ef5c1eba 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -12,6 +12,8 @@
  */
 
 #include <linux/bcd.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/iopoll.h>
@@ -39,14 +41,18 @@
 #define   RZN1_RTC_CTL2_STOPPED (RZN1_RTC_CTL2_WAIT | RZN1_RTC_CTL2_WST)
 
 #define RZN1_RTC_TIME 0x30
-#define RZN1_RTC_TIME_MIN_SHIFT 8
-#define RZN1_RTC_TIME_HOUR_SHIFT 16
+#define RZN1_RTC_TIME_SEC GENMASK(7, 0)
+#define RZN1_RTC_TIME_MIN GENMASK(15, 8)
+#define RZN1_RTC_TIME_HOUR GENMASK(23, 16)
+
 #define RZN1_RTC_CAL 0x34
-#define RZN1_RTC_CAL_DAY_SHIFT 8
-#define RZN1_RTC_CAL_MON_SHIFT 16
-#define RZN1_RTC_CAL_YEAR_SHIFT 24
+#define RZN1_RTC_CAL_WDAY GENMASK(7, 0)
+#define RZN1_RTC_CAL_DAY GENMASK(15, 8)
+#define RZN1_RTC_CAL_MON GENMASK(23, 16)
+#define RZN1_RTC_CAL_YEAR GENMASK(31, 24)
 
 #define RZN1_RTC_SUBU 0x38
+#define   RZN1_RTC_SUBU_RTCA0FX GENMASK(5, 0)
 #define   RZN1_RTC_SUBU_DEV BIT(7)
 #define   RZN1_RTC_SUBU_DECR BIT(6)
 
@@ -78,15 +84,15 @@ static void rzn1_rtc_get_time_snapshot(struct rzn1_rtc *rtc, struct rtc_time *tm
 	u32 val;
 
 	val = readl(rtc->base + RZN1_RTC_TIMEC);
-	tm->tm_sec = bcd2bin(val);
-	tm->tm_min = bcd2bin(val >> RZN1_RTC_TIME_MIN_SHIFT);
-	tm->tm_hour = bcd2bin(val >> RZN1_RTC_TIME_HOUR_SHIFT);
+	tm->tm_sec = bcd2bin(FIELD_GET(RZN1_RTC_TIME_SEC, val));
+	tm->tm_min = bcd2bin(FIELD_GET(RZN1_RTC_TIME_MIN, val));
+	tm->tm_hour = bcd2bin(FIELD_GET(RZN1_RTC_TIME_HOUR, val));
 
 	val = readl(rtc->base + RZN1_RTC_CALC);
-	tm->tm_wday = val & 0x0f;
-	tm->tm_mday = bcd2bin(val >> RZN1_RTC_CAL_DAY_SHIFT);
-	tm->tm_mon = bcd2bin(val >> RZN1_RTC_CAL_MON_SHIFT) - 1;
-	tm->tm_year = bcd2bin(val >> RZN1_RTC_CAL_YEAR_SHIFT) + 100;
+	tm->tm_wday = FIELD_GET(RZN1_RTC_CAL_WDAY, val);
+	tm->tm_mday = bcd2bin(FIELD_GET(RZN1_RTC_CAL_DAY, val));
+	tm->tm_mon = bcd2bin(FIELD_GET(RZN1_RTC_CAL_MON, val)) - 1;
+	tm->tm_year = bcd2bin(FIELD_GET(RZN1_RTC_CAL_YEAR, val)) + 100;
 }
 
 static int rzn1_rtc_read_time(struct device *dev, struct rtc_time *tm)
@@ -129,15 +135,15 @@ static int rzn1_rtc_set_time(struct device *dev, struct rtc_time *tm)
 			return ret;
 	}
 
-	val = bin2bcd(tm->tm_sec);
-	val |= bin2bcd(tm->tm_min) << RZN1_RTC_TIME_MIN_SHIFT;
-	val |= bin2bcd(tm->tm_hour) << RZN1_RTC_TIME_HOUR_SHIFT;
+	val = FIELD_PREP(RZN1_RTC_TIME_SEC, bin2bcd(tm->tm_sec)) |
+	      FIELD_PREP(RZN1_RTC_TIME_MIN, bin2bcd(tm->tm_min)) |
+	      FIELD_PREP(RZN1_RTC_TIME_HOUR, bin2bcd(tm->tm_hour));
 	writel(val, rtc->base + RZN1_RTC_TIME);
 
-	val = tm->tm_wday;
-	val |= bin2bcd(tm->tm_mday) << RZN1_RTC_CAL_DAY_SHIFT;
-	val |= bin2bcd(tm->tm_mon + 1) << RZN1_RTC_CAL_MON_SHIFT;
-	val |= bin2bcd(tm->tm_year - 100) << RZN1_RTC_CAL_YEAR_SHIFT;
+	val = FIELD_PREP(RZN1_RTC_CAL_WDAY, tm->tm_wday) |
+	      FIELD_PREP(RZN1_RTC_CAL_DAY, bin2bcd(tm->tm_mday)) |
+	      FIELD_PREP(RZN1_RTC_CAL_MON, bin2bcd(tm->tm_mon + 1)) |
+	      FIELD_PREP(RZN1_RTC_CAL_YEAR, bin2bcd(tm->tm_year - 100));
 	writel(val, rtc->base + RZN1_RTC_CAL);
 
 	writel(0, rtc->base + RZN1_RTC_CTL2);
@@ -308,12 +314,12 @@ static int rzn1_rtc_read_offset(struct device *dev, long *offset)
 	val = readl(rtc->base + RZN1_RTC_SUBU);
 	ppb_per_step = val & RZN1_RTC_SUBU_DEV ? 1017 : 3051;
 	subtract = val & RZN1_RTC_SUBU_DECR;
-	val &= 0x3F;
+	val = FIELD_GET(RZN1_RTC_SUBU_RTCA0FX, val);
 
 	if (!val)
 		*offset = 0;
 	else if (subtract)
-		*offset = -(((~val) & 0x3F) + 1) * ppb_per_step;
+		*offset = -(((~val) & RZN1_RTC_SUBU_RTCA0FX) + 1) * ppb_per_step;
 	else
 		*offset = (val - 1) * ppb_per_step;
 
@@ -355,7 +361,7 @@ static int rzn1_rtc_set_offset(struct device *dev, long offset)
 		subu |= steps + 1;
 	} else {
 		subu |= RZN1_RTC_SUBU_DECR;
-		subu |= (~(-steps - 1)) & 0x3F;
+		subu |= (~(-steps - 1)) & RZN1_RTC_SUBU_RTCA0FX;
 	}
 
 	ret = readl_poll_timeout(rtc->base + RZN1_RTC_CTL2, ctl2,
-- 
2.43.0

