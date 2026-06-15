Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44F8409138
	for <linux-rtc@vger.kernel.org>; Mon, 15 Jun 2026 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538514; cv=none; b=Hr5hdXhOYxbM8io0AfrRXobs8Lo5IILq9Mbq/Z8noUBOuApcaATOLR9MaS1+vG2/Iq/V3G9OhmClw3JDnf851MiEDONy1ti9WmsbMF8JCT48kQmSQVpyi9LrVwSkfBAMATaGu6RLYwhxIdVSjs2IXHcwBcnzXwO74oubF1rsabo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538514; c=relaxed/simple;
	bh=2OWKymJzJI+c60cQ/7m96HIrf3ANiQc7K5wZLe8G22Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPI5auELT+6InG0M4YIHMyN9YoV1g1AHyrFd+vqu1EiRxbrWNBJJKhXim/J4LkGsDibBS6cIC0Kh2J5u0yjb3DrDURtBHpa1iZ3Z8pRMnQi9lpBZCuQqsauREFuTMXZBoVs8HZ7en4FmLB05zoed6M0QT69ukrg7TJXb9ynTuRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1TwcFLh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1TwcFLh"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4921e4dd62dso19675815e9.0
        for <linux-rtc@vger.kernel.org>; Mon, 15 Jun 2026 08:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781538511; x=1782143311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPJ5nbggfdHMUBsOoocYfnWb3ApNjTIRio6Pe00dpEA=;
        b=P1TwcFLh8MyWNy607YznzMyttWbYjGkyGUlYply2rcsG/12ztCu4AFcDTFnloTzT0l
         qT3G9XTEIFW1DrpSIihfk3P0jGqhWsF0X6JLcH87FagKEu/mX4QjRvoKRQqHOSFhxXok
         HDar02wCRYhF4WEpidAydYzr062ksiEXfAUIfgTwfRIozSxt54IBLSpxIlRm5iuUDt0+
         LU6O4z0w0suRCGERYeHZASiYRGEDryfJ+JgRg5cPDgIRNzecpotCtQN7fkebGhoJ+OI7
         hZbmWz49l+SIsEmZwiEBWB6XO/7HrMIJbBhrmMNjs6bpfRe3T+CwWmb4S2lcY0oiqjO9
         o56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781538511; x=1782143311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yPJ5nbggfdHMUBsOoocYfnWb3ApNjTIRio6Pe00dpEA=;
        b=UMVqvRWdw5xPXP/HMSNsw+c6Cox2Tg7atbIfNND8/PfKB9vPbg9ZaDL+lchKasez1c
         Wz6T87HJjhNB9bsNNSuv4IMj+Ue5S+lakR3t5C3lmxtNxs6W6JvwarXbKOpNDhAOKX8O
         TaqQruTnzT7MyciUe8hsnkJ2r5H6ItVWWlleL54NI9W5XALDpfWbQNlcYE1UnMxBuJkt
         J6IoKDODzGRn1t3vd91Lqd0QTxTPHdBgntNdDVnLeA0F0RY5tigS97aTbAx2zpYAesmv
         yQXWT9RJ7cC8/pXI7yqLWMB36gJqVHPhQTcUgdGcGgg3ZjxbHgSTKVN/bBagZHDwW/9d
         DZPg==
X-Gm-Message-State: AOJu0Yx7NPOaNHnuL3tHxSkJRrP577+JHqfGjiJsbJCq/URr9H8yyvzb
	oWeIKP3FpcR7UNSvRmntNVvHxCJshhiJXoxPKAeLR2I1HgDFTIGhC4A+
X-Gm-Gg: Acq92OGj4fDVtYoIMX1KIAAOWRrV/xOU/xtEfJ0lIfDAeW4HlXgvrE/lwBM4HB5xUGF
	rkrl49yB0Sij+0MeMETa2czNMSABMI/PWlvRZ4VEkiBVQh8Ik2JsxlcK17vopAG3HhadQHlspYu
	WdpT5TexD3hsHURG7iFodeN2H1FUJR/wlplF7JAaBiVrpb2Jbal06NcockKI1mxCAqj1GiLMkiV
	iuVD3YLXI0jdVCONnj8NHmqF004dilG+oA9b0l4CYTl4h+AkCcOFbVvCQOQDgvhyIydAC5kGoAI
	C38kMJfTR0ITsK8wfFtdFvcNAQCFT7EQuizTr8MzxefNDAujxAYwDuKs+lIUMLEMHpexsk0QzQk
	P0JJsd/7GNdtuExOTYsI9kjttmd8H/kh0wnH2NnYuLQ7ExqzGNuw76V/1eUlEvWXtM/k+88fYHa
	LCReFRSh5Azd2ryvpRImUuf3JHbnhhB8I5t2HqszbK+dogNi0hgWFsP6Veo3enAt8EK+g5jqhIg
	0GZsObKU7p9FP01KBwCPXxjubcfLHO1CXh4
X-Received: by 2002:a05:600c:a40b:b0:48e:8eb0:4957 with SMTP id 5b1f17b1804b1-4922faa1474mr721775e9.2.1781538510820;
        Mon, 15 Jun 2026 08:48:30 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:1e4:992f:3ad2:4f2b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26434dsm36010995f8f.1.2026.06.15.08.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:48:30 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
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
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 11/12] rtc: rzn1: use FIELD_PREP/FIELD_GET and GENMASK for register access
Date: Mon, 15 Jun 2026 16:48:04 +0100
Message-ID: <20260615154805.1619693-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
---
 drivers/rtc/rtc-rzn1.c | 46 ++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index c7ef3c81180f..9f9cf9882fc4 100644
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
@@ -40,14 +42,18 @@
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
 
@@ -82,15 +88,15 @@ static void rzn1_rtc_get_time_snapshot(struct rzn1_rtc *rtc, struct rtc_time *tm
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
@@ -133,15 +139,15 @@ static int rzn1_rtc_set_time(struct device *dev, struct rtc_time *tm)
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
@@ -306,7 +312,7 @@ static int rzn1_rtc_read_offset(struct device *dev, long *offset)
 	val = readl(rtc->base + RZN1_RTC_SUBU);
 	ppb_per_step = val & RZN1_RTC_SUBU_DEV ? 1017 : 3051;
 	subtract = val & RZN1_RTC_SUBU_DECR;
-	val &= 0x3F;
+	val = FIELD_GET(RZN1_RTC_SUBU_RTCA0FX, val);
 
 	if (!val)
 		*offset = 0;
-- 
2.54.0

