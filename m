Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC41B3002DD
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787346670; cv=none; b=MG2mIL4cMjQgRTX+ZRSLkwR7Z9qreh8qii10mbY/kNCwnlDuofpmAqVODOYn6qnIzK5A0tpl/4yCNf/7pw7dzDeKp775y7c4vbCoLaNRebWwst8LL3de8Iv6c6pk0Ao//GUVxyYskdVIVt+0LdzjT5WrN/raM4kbSP4d1vYkzQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787346670; c=relaxed/simple;
	bh=G8py0KfqTCUThOelxLCduHUIUi1Im6OxQnN8n8LKgdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzBdHfbqfoLnszkrfpAfDmmuwIseTV1OceErWVd4fifkSgmIbAGS96SI9eAA/R7ouJG6FvB2PhG+y9nxfKhoePVRBT6WHrCH/daPvKl2HOdUtcIGYADt5lYRheAYu+RLEVPjues7RQeM14U+hjS0zBf2yQTdXrB3yAd7+JsxGz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8dZQz+8; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8dZQz+8"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc11a30a259so1490892a12.3
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 14:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787346667; x=1787951467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CU1oP/ljlYx+FVX14t93B7e35BUmi8NVJJ5FxmAJfS4=;
        b=X8dZQz+8ob8TBEAglcNHwCSbz2hY3zGwqtd/rynrRJq5sT6MBvyuqp87ITMzx5D6FQ
         uh/1UiIhyuOb+sNHN49eNQmS4eXQtzBuxPvjQFJJ8QfVafLPziOcvjlLArHrC0HT2wbY
         4lT+qMazTQY7EblfgKGd/GtjOC++67DZLEpJdb4y7m4p4hJbizQQOBSm/gBgxeJ1Rz5l
         830c7ECts+mFr3yNRUYzSwdkKdaiOliguyMEJaGg8l5SATZHrwE6CX1+/q/gzGQcy9Yf
         2tBHZBNw8WKMnKq5jbx6B8kX4ZT/rR2eRQIkEcOpmNmGeBsSLJ2ju/n+pFz51gpBvLst
         Ro7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787346667; x=1787951467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CU1oP/ljlYx+FVX14t93B7e35BUmi8NVJJ5FxmAJfS4=;
        b=RWP8sxKonTx8cMbYo0xXcBuHbzj7SIcOpZPD2Ee2to6YG8HPhs/CPCsHothxLWFiEa
         PBGCb7DFSnTsPyZBHvHvgi4IdkQDee0gdbXc+QiqGjPiFVwpfGQePIWYhVq6xE+FRxXw
         BvA3f1BVxoVmU3ydKe265IQKMMyCoBgXKWh2BhNMVU1vhmX8fuFgBs5ZBxHChc0StwG8
         pwYZhEWV9r9yyA4FEwBu7ZXYz50wYlcJXM1WPYbmQFSiqyWQmqnl4Wb7GD6jJQDbkTI7
         iarbU7Qw0hpn9/MLONVMPBb1EO8VNo1/uxBTf69cHHxa6jGhrsgARt/U0AcEIwNEGBQS
         LEag==
X-Gm-Message-State: AFuF++kuquPe8ah24w4hr/kjZq+AWpqaXZ6hR7Wp2ruWx3Y6pSTK48lA
	SFdFfxWr7xDBWznu5jnPFrEAzcPBF/78LvnCGPnIIHpjcQ0fE8RyXskJ
X-Gm-Gg: AR+sD10zk2WyaELPCzSTDK4GlGdBKnqd4yDf5vGTIVHFeU7+ki4bO2l3i+RO80zu3tj
	tEWER6KHiDmlXQc4383fKgVYdelAvzmIxI8VOzoG9GoiCJZRs1ZukmXk2GjCFtvfaHlxmgsy6al
	SsJoDNJMBhgN1AVGQ0UBdBWrT77V70ZSntoDNIwIhuuufzgfbfjSkuECGWJTeQXCLdlL12hI4uX
	6VebrElKwhCwGmUsUrjthyWG+Ol215GlRrwWf4mmzvjqOc698CsnkVSL5A1OEtr7HGaJ+G4MInq
	MR4Ds42VdGdhBofBb49igRgEtY0mufWjDN393BLFmgTkwZI6z11bcYEXAnq3TJTwRTsm+KcIFMo
	EqYJii1QoxxoPD55Mfafw2Oh2v81jFdsc/rL7cjx83EHcZG7FYnjfpbO0M8DAnKTBO/HagO8Cv7
	WUvbHf7UVKw6io+f2g8KpqLeiJ9dXbSdGaTwN75Bqr1Et8tmShalvrc6yCeMWNeo7+jWFZ9T9CI
	iTbIa0b8RJrrsxs43Aa9/UZVk95ZBqe7/zw/8HoeJz6eEMaOPTNNGB4mXFUEa54pJLOKFg4
X-Received: by 2002:a05:6a21:8cc9:b0:3c3:a3f4:5485 with SMTP id adf61e73a8af0-3cd4ba0d216mr3000476637.6.1787346667011;
        Fri, 21 Aug 2026 14:11:07 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:194c:dba4:ea1e:d7d1:affe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf175399sm49755257eec.26.2026.08.21.14.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 14:11:06 -0700 (PDT)
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
Subject: [PATCH v6 03/17] rtc: rzn1: Fix weekday underflow when alarm crosses month boundary
Date: Fri, 21 Aug 2026 22:10:18 +0100
Message-ID: <20260821211032.13554-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

rzn1_rtc_set_alarm() calculates the alarm weekday from the difference
between the alarm day and the current day of the month. When the alarm
crosses a month boundary, this difference can become negative. Since
days_ahead is unsigned, it underflows and results in an incorrect
weekday being programmed into RZN1_RTC_ALW.

The RTC core already provides a fully populated struct rtc_time for
the alarm, including the correct tm_wday. Use tm->tm_wday directly
instead of recalculating the weekday from the day-of-month.

This avoids the underflow and ensures alarms scheduled across a month
boundary use the correct weekday.

Fixes: b5ad1bf00d2c4 ("rtc: rzn1: Add alarm support")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v5->v6:
- No changes.

v4->v5:
- Added Tested-by tag from Wolfram.

v3->v4:
- Made use of tm->tm_wday directly instead of recalculating the weekday
  from the day-of-month.
- Updated commit message.

v2->v3:
- New patch to fix weekday underflow when alarm crosses month boundary.
---
 drivers/rtc/rtc-rzn1.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index f81d691c8b9a..56284a4320ae 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -261,7 +261,6 @@ static int rzn1_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct rzn1_rtc *rtc = dev_get_drvdata(dev);
 	struct rtc_time *tm = &alrm->time, tm_now;
 	unsigned long alarm, farest;
-	unsigned int days_ahead, wday;
 	int ret;
 
 	ret = rzn1_rtc_read_time(dev, &tm_now);
@@ -274,13 +273,9 @@ static int rzn1_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (time_after(alarm, farest))
 		return -ERANGE;
 
-	/* Convert alarm day into week day */
-	days_ahead = tm->tm_mday - tm_now.tm_mday;
-	wday = (tm_now.tm_wday + days_ahead) % 7;
-
 	writel(bin2bcd(tm->tm_min), rtc->base + RZN1_RTC_ALM);
 	writel(bin2bcd(tm->tm_hour), rtc->base + RZN1_RTC_ALH);
-	writel(BIT(wday), rtc->base + RZN1_RTC_ALW);
+	writel(BIT(tm->tm_wday), rtc->base + RZN1_RTC_ALW);
 
 	rtc->tm_alarm = alrm->time;
 
-- 
2.43.0

