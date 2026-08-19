Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57585345ED7
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136046; cv=none; b=Io1W8HI88knHnEugLDCtFPkkK1C5tlInOr8gEWCpVkNXxYUat09JhzHskojTzWOyvsQcVyOPcM4dcxtr6pROV6YorDSdpf6NkQk5hQP+ucRaLJVxNmGBq2CCLZFBqknIGbR3X/q8a8nzQiVYrfAMPnXoYQN0paB+NkDFEhPQkBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136046; c=relaxed/simple;
	bh=o0gQVCX2jUgC0OSispZmWD76pHaSa5t7YdNfc6z+j/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FozL7bZacXUaKrt+RIHqtCxV/+A+k+AoNsfIPzH8XWTy2RUZvuBhAz3IFV5F6h4QWA/axuaS2IX/fLrcKr/PckyJy53aFKRhV06kegowOvRFEDAvpeH/YQiiAHM5+z9F/kQjet3WKAbySEshfaJZb2neQaqAEDRi82kgFMvR1ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZXorDvq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZXorDvq"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc891373e0so9835555ad.2
        for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 03:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787136045; x=1787740845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lr4Op+emA6JiU4Ny16/9KhdkQPyJvGPjtOQDkD4fONY=;
        b=IZXorDvqyXMHC9Iv7vrXAPYsvNZ8rNcACZVByu9/ZWksHb6ZX4Zh7z4sAVJBGvLFms
         jdNBdi31agxKop9FrxxvFkrXUxJrLc4xYS3rpT16qV6yru6NkoN0U+Cz7SHn5w6rWky1
         iZaYDaORJYCz5G5Fw1c33p7vww01Cfgoue0+JAk/pQjG+0fGgU2dHpIat4Gio5R9oZMJ
         dnZnKS+DkTSWolhOIxuJJyE86J9cNEB4Wq/nqB4Mc+l1u+5AlnpYxpAyblFZ207jhHAd
         cH5CYbW4QVaufBDKAL7i+O/TJYC7slr5heck5/zCrSd9bpbOex5O9QnwwLd7ye7hAccP
         FdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787136045; x=1787740845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lr4Op+emA6JiU4Ny16/9KhdkQPyJvGPjtOQDkD4fONY=;
        b=JR/OarZ3Qaj51DdUnLBlrO5QijLjy+VgZrVNq7xYO7IY/PSGYcGOcYQ3Uenz/DGt8i
         ngV9UwLi5x/5SEaYfS6fvyGIDt5c+fyIMnAde8ZCXLH8UHEcACg9G4oCmKibfsurYFZP
         0LbU+ezwi4pKO5C9XdDJabBE9WykE5nUCiDnZj8ioyzgAPyfGhaUMVXLD2f9kpaJfGtC
         x7uBsRkYG7UkeRq/8SVDql89XSj/jLnA5F+LHULgq3UC91M51NCT6Zlx1boAUED4Fxn8
         ZmVRtDEAyyZRWlXhjpnCHPGVTKEIFyGutd8XshzxNlvIA5I44NUz2AMJ5l0nP2WSxImx
         wTwA==
X-Gm-Message-State: AOJu0YwOFjJbA/Vxg0gLWIDHoXGJDJ0ZHVjZ6wGi5Zzswhv4oeyOupmn
	JIdgPDjt6p+Lh38zpiQ1xeA9hH7NYCjTg+wb5LX/T977s5FBx6M0p/F3xmGcXdq7
X-Gm-Gg: AR+sD11OOwfaHvVRl1qExa9tq9kdLoixTf8jfT6iFsOvDUPP4Hoh8AyH78WOoGq6LGv
	gptwL2Yw7p2in4DJtPxFGHqugMa0ZYUIJoxkA8PcCb4wQZdQ3VY+G40t1CoHEP6Pa9rntASf8Al
	an9ZO1s/JSARWwA+weHek4nirjDSQ9scDRobGdyy7J8JdFnVBz/B5htuLujhgRDJGAX4MxQlFR/
	xjx0vtJrAe1cnPx5mMFCggJcvtKfDpFdF2JMkGziqaDplGeDhJ6r21/+IVr/DpzIbCM7pdRfH53
	MvBfeceRXr0QoC2BqBpHbaApjhCVhvBHe8RztO+2o73o0bsEcTtf6gjnbyLHBtvBCcT58FLIrhG
	xgz23NlAtPwIDurnQ1Dj6jkWylAzVjjwkwIqWW7Mogiv/JIOmGXxX3j/GhcJ/izE9RiG53H1bSO
	jeUmKBy414FtAlIT4hnhSOwTpWkxgH7RGwxM25A2a3s/V3cnqiAoy/e6CQuzF++4oI9SscH2+mf
	VXsG3mHwhhzIIxfuoVaYlUgOfivfKQq9TQsAF89bT1Tuw7FGQ3PG9NV00AZ9diuuaxVRPUtMWUg
	FGsCp5OYxQ==
X-Received: by 2002:a05:6a21:8cc4:b0:3b3:1b38:d9c3 with SMTP id adf61e73a8af0-3cd016b16e8mr8210052637.4.1787136044429;
        Wed, 19 Aug 2026 03:40:44 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c07:efb3:a897:a9b5:e171:c935])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef77fc0sm11169630eec.8.2026.08.19.03.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:40:43 -0700 (PDT)
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
Subject: [PATCH v4 09/15] rtc: rzn1: Dynamically calculate synchronization delay based on clock rate
Date: Wed, 19 Aug 2026 11:39:20 +0100
Message-ID: <20260819103926.2136712-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Replace the hardcoded hardware synchronization delays with a calculated
time window derived from the operating sub-clock frequency.

The driver currently hardcodes microsecond ranges assuming a fixed
sub-clock frequency of 32.768 kHz. Newer SoC variants, such as the
RZ/T2H, drive this hardware block using a much faster clock rate
(~195.3 kHz). Hardcoding these wait windows forces faster blocks to
over-sleep, introducing unnecessary delays during clock initialization
and register configuration.

Calculate the duration of the required clock cycles in microseconds based
on the runtime clock rate, and store this value in the driver private
structure to adjust the usleep_range() and readl_poll_timeout() boundaries
dynamically.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
- Shortened the comment describing the calculation of RTC_PCLK.
- Updated usleep_range() value to use 2 * rtc->sync_time.

v2->v3:
- No changes.

v1->v2:
- Initialized rate variable to 32768 to avoid timeout_us of 0.
---
 drivers/rtc/rtc-rzn1.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 425d9590c55b..9eceeed14486 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -69,6 +69,7 @@ struct rzn1_rtc {
 	 */
 	spinlock_t ctl1_access_lock;
 	struct rtc_time tm_alarm;
+	unsigned long sync_time;
 };
 
 static void rzn1_rtc_get_time_snapshot(struct rzn1_rtc *rtc, struct rtc_time *tm)
@@ -119,8 +120,8 @@ static int rzn1_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		/* Hold the counter if it was counting up */
 		writel(RZN1_RTC_CTL2_WAIT, rtc->base + RZN1_RTC_CTL2);
 
-		/* Wait for the counter to stop: two 32k clock cycles */
-		usleep_range(61, 100);
+		/* Wait 2-4 RTC_PCLK clock cycles for the counter to stop */
+		usleep_range(rtc->sync_time, rtc->sync_time * 2);
 		ret = readl_poll_timeout(rtc->base + RZN1_RTC_CTL2, val,
 					 val & RZN1_RTC_CTL2_WST, 0, 100);
 		if (ret)
@@ -384,10 +385,10 @@ static void rzn1_rtc_disable_hardware(void *data)
 
 static int rzn1_rtc_probe(struct platform_device *pdev)
 {
+	unsigned long rate = 32768;
 	struct rzn1_rtc *rtc;
 	u32 val, scmp_val = 0;
 	struct clk *xtal;
-	unsigned long rate;
 	int irq, ret;
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
@@ -437,12 +438,16 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 			scmp_val = RZN1_RTC_CTL0_SLSB_SCMP;
 	}
 
+	/* Calculate the duration of two RTC_PCLK clock cycles */
+	rtc->sync_time = DIV_ROUND_UP(2 * USEC_PER_SEC, rate);
+
 	/* Disable controller during SUBU/SCMP setup */
 	val = readl(rtc->base + RZN1_RTC_CTL0) & ~RZN1_RTC_CTL0_CE;
 	writel(val, rtc->base + RZN1_RTC_CTL0);
-	/* Wait 2-4 32k clock cycles for the disabled controller */
+	/* Wait 2-4 RTC_PCLK clock cycles for the disabled controller to stop */
 	ret = readl_poll_timeout(rtc->base + RZN1_RTC_CTL0, val,
-				 !(val & RZN1_RTC_CTL0_CEST), 62, 123);
+				 !(val & RZN1_RTC_CTL0_CEST), rtc->sync_time,
+				 rtc->sync_time * 2);
 	if (ret)
 		return ret;
 
-- 
2.43.0

