Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6F541378D
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 21:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787346724; cv=none; b=minTPadvtM7s3RpN+EF+AnZM8jV405jZvv8QKfLg2pqOzQMHwzq8/XjgeuJD00C7kJ/YRWhKv3FcerOP//r2lxULb1k9w+jIW19BlCBBbfYJjoSOlPlVjwZ3RZ/xkIfzqPpU6k/DUGKR/GI1I8Friq+Sj3SfdHiRjrny4aAP8U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787346724; c=relaxed/simple;
	bh=s9BUVibUcdXFVsJInMHWm2yG1ceknFhn/TVwbVDtmuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QH+RTKjf0db9tl17++X4+v9CXU+H9nG1WmBezZXP6HNi6fgkQEedqbYC+u40xlrOP+CtlvZ5fP1D96JKYUdodr4pVCNu9YPdIgo4XwMtYUvxIwAzjU16SNutWVBlG8KLMeC4Lo4zZT+RuL6Xlh1ExDLD0QjeM8decZNB3no7giE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHOwoIrm; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHOwoIrm"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so1130535a91.2
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 14:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787346722; x=1787951522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2RAGswYTmu3NrFU6zGdKpepBZD/bOxZ1HCrIvY615qE=;
        b=dHOwoIrmlrGbMeNqHKOy7Hq8R0UCxUm4IhQZvojRuxxl7hyFNqR0nOKtnCpzv0jJ5C
         qhYg/n59z4ClnNXgnPkXokJUYuj1YVjcIb9Xyb8tkSIfZdlTqBUTK7HjJfFWXpK1sxrU
         2DaMi9gcycXcU8RYsVj2GfaxCTzbdiYeoF2yDypxMLg/b3X41Xo5qUSp6BtikFzbizBA
         vdEilnbI4pFxlxaA8umtmP2c29BrP3WjEecUN1JYbKEk+ilqHJ4fj1tqxjjeRPOW1+4J
         E1yIJO5TKzC9BYHo0xcgOSdhxUGzpseET8TRU0OmxNzEAUJ4cQ5IKxlqWhh1ausyTDs4
         00Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787346722; x=1787951522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2RAGswYTmu3NrFU6zGdKpepBZD/bOxZ1HCrIvY615qE=;
        b=oJhAz1VDWxobeIPBVeOGBcPx0eACsnpEO6CJEAGNOzWfkk60rAciuAPCM3gsU/yGfJ
         +y/e2DxKbQoBqXHFHnifx/nwIfFf879iR0h4v1bj/9GCogoy6wgLkwqFjMQtg1cUCDw2
         WZATnF54+zzXtlB0bA7A3l1ryP+Tek15Li3OdR5ExOJI6le8n7I2G/+bFcwqk8KMaKpL
         eHHxOuze6SjZ9h9+Dsph/5d/j/+LO0HRGqEcZzlRw35RIa5Ijn7b8pzlNWGlnDEwLAVB
         iZdNxap3fKtMFiNHauVrozJdeH1KAmI9TVZED/kEpkKE/FUuZcCz3+jt3e/DjaIDMITN
         UClA==
X-Gm-Message-State: AFuF++kVjNqylMhNvN6wOSRP4ogXS+XrLJLgPdyswe1UlYcgLAndWifC
	IIezcNueWfMPZqGcEpvIPORSA0EdTuSAKM2VnqVgdW9Mz0DNSQaJGFh5
X-Gm-Gg: AR+sD1306UCAeSg/aRziErbVJ65lMXxbfKVucL3hGUls+0Zz2brcVqRxDRcZFqom1f8
	R0zfSbBDopqp+CBGskIaKztmhDqPDejD2qlTNGK3jXPLcLVnaE8yEkilH8yzirrK+dlzrAjU7jG
	E3XtNayE3nsq6lGl1OQeQ4Weg+9gs5XHQbTXfYaTzHJhH1RYJ9bZh+asmsQ4n1iBgDyMpXDmSWH
	w2oKUZGv36JqEJAPnePmGQylLer9RBwszHFH8AODRnjPXAPthqOoZ5RdQnh1pNghpiinSnKaN9r
	aD6SEfMmp3DC2r+Fgs/qGDyJRLPDzgTCoJfMtIZWx+o5K1Uo3tYNqZbcMFBB1nVjYKm2MQdDMTj
	DKl1TW6i1JmeIXO0mO1qcDmE4Cz9T9wSsYHtWDZjLxdvKFzhKQElm7OIIspUYd61DBqTFnY/5sZ
	rrG6YK16gErHx1jRJkzh/rCPV2EOxlwJVMsqeSfSc1kDg9o9yQ/xY/mDOXXncoImbHU1xxU/cvf
	sYW8kGNld2aC8ulMsVRqRZ4xtLW+ZVul2/AP3Oq4af+6MOmcmSDQNpEZSQEAXGETvQwFvmbqXCg
	K6tWLx0=
X-Received: by 2002:a17:90b:3ec4:b0:381:528a:808c with SMTP id 98e67ed59e1d1-395c397c6ccmr14692155a91.12.1787346721862;
        Fri, 21 Aug 2026 14:12:01 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:194c:dba4:ea1e:d7d1:affe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf175399sm49755257eec.26.2026.08.21.14.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 14:12:00 -0700 (PDT)
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
Subject: [PATCH v6 11/17] rtc: rzn1: Dynamically calculate synchronization delay based on clock rate
Date: Fri, 21 Aug 2026 22:10:26 +0100
Message-ID: <20260821211032.13554-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v5->v6:
- No change.

v4->v5:
- Added Reviewed-by and Tested-by tags from Wolfram.

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
index f90785827945..4e62f7bc2e34 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -70,6 +70,7 @@ struct rzn1_rtc {
 	 */
 	spinlock_t ctl1_access_lock;
 	struct rtc_time tm_alarm;
+	unsigned long sync_time;
 };
 
 static void rzn1_rtc_get_time_snapshot(struct rzn1_rtc *rtc, struct rtc_time *tm)
@@ -120,8 +121,8 @@ static int rzn1_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		/* Hold the counter if it was counting up */
 		writel(RZN1_RTC_CTL2_WAIT, rtc->base + RZN1_RTC_CTL2);
 
-		/* Wait for the counter to stop: two 32k clock cycles */
-		usleep_range(61, 100);
+		/* Wait 2-4 RTC_PCLK clock cycles for the counter to stop */
+		usleep_range(rtc->sync_time, rtc->sync_time * 2);
 		ret = readl_poll_timeout(rtc->base + RZN1_RTC_CTL2, val,
 					 val & RZN1_RTC_CTL2_WST, 0, 100);
 		if (ret)
@@ -398,10 +399,10 @@ static void rzn1_rtc_disable_hardware(void *data)
 
 static int rzn1_rtc_probe(struct platform_device *pdev)
 {
+	unsigned long rate = 32768;
 	struct rzn1_rtc *rtc;
 	u32 val, scmp_val = 0;
 	struct clk *xtal;
-	unsigned long rate;
 	int irq, ret;
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
@@ -451,12 +452,16 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
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

