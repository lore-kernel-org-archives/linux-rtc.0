Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB45494803
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320610; cv=none; b=cgvYUD9fbjuSIvGccaz552eZN261UqyjED5z04JotegK6Xvaad8tec0c4c2TWisvjtm3Ewb86PEslC66sKQ+K/twsHEIsJSNV3El9ZZPgCf/Rl+JtGr16jrGvkhUeH4pamLnC0ohhPzLaKfVTQbXyy7Fj+14XJnMlnSYyO9FrsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320610; c=relaxed/simple;
	bh=nOwCB0GUu636xzrMDwXRCKSR8TtZ4OMEI81GMCIE7vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hasedx/ld/+aJBvqwQ07mfEl9VEDSUxQUydltsuZOaftpshtl3lJJiKkCZbwIb0ebQA0IrwBySXbMdAoKc/DZnP3RvrxTM/MRLGIvuViBdPEH3aZaX08lPXUBRAxYAEeZGT3iCyI+Br3MrnHskTyDs5xJ7IZZ35ZSGYdT9YKgx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZlSwPEA; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZlSwPEA"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cbb7926836eso765208a12.3
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 06:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787320608; x=1787925408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d0FHwOXmdVjq/fR8LKjN0dCSgITp6opJdRR3Iv2IfwI=;
        b=GZlSwPEArMzym3mMiIDUoMBvgTPk1zsx40bWbVKQToRaXTN7Jttyz8G7pOnaLsJmKm
         eaU6JxtDXMghu5Fkb29IFtMKKYnaeY0nredMIOhYO73maawqLzAGD2NQ3YC9j+n+mGzH
         EwT9sahdv0VOz3KKn9kqsDo91KUNWBVvlHYTh60XeaN7aq35LEwIDTPKZgN2rD9xEvWt
         LguIJLZCO2IBy5+a6F9C+qN2MxJ0ZQyAipEkw9uH3sOmM6VozVMNLaysAZ7yWJ2+uTse
         bqsW6uQJi+evP/vaZqnaM2TGxhQIlF10WYooPsCnIkGBnWBxhIMZeZuMitgAGP+TWiQK
         pfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320608; x=1787925408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d0FHwOXmdVjq/fR8LKjN0dCSgITp6opJdRR3Iv2IfwI=;
        b=ocjXqUdzZuEGEcDiHsDlEYsCsP40kkYVyJ+EmXmdgZt6aDGFyn/ZiLTeSUFqcwX77t
         h+6vUR8oYxQgyW1ZEa5eDurU4hIzEIo0c1Gm+TQoIj3J4jj9DNXHSRIH3Vf9OHxOGTNK
         DeRLT6J1FcXhzp63zWhJ+U7YRxCm3FSVSK9CM6XGPDvNBnE00ERIYoKCMmWb24vSv45K
         tn1QbI3R38JgI1AA1kcIiwIOj81xlt/oRvcfqW2yJosQ7EdOaATJQFtQe01t+eKTKia8
         pA05fbWNkszEz2nV0/ad/1En2te6WAyMvKkCFXm6rCjy57acOACyTc0R1a6+bP924cW/
         txFw==
X-Gm-Message-State: AOJu0YylFnM8IR4P9RvvXouhb8bEN72hXPNT2QQvQq0zp7BxqVTHNH/M
	LGDonEaviJ7CqiqDHWhqEu6YoTk+ZAG3HBEwMQvRarg8HA0TAnmBiVPv
X-Gm-Gg: AR+sD127ZiQjK4T3/meIXISZeX2SKHNFs5e4/pbrA5pqYrWvpoUhr8y9zmuWJ/H73NU
	WBJBWeCQ5x1f1IAjhgXaSTnAhHtk0XMKgYd4jf4Vxgauadp4KP1rmbNSea6SeE3e/jSh0PV6MBD
	XCFhUDDzDXFBrUl+gvJjFw8QfRSx/8VN8QDsLyU7KbymrrK+TPLC/V5gOH4CEq/MIjSmUCA7tTD
	a6FuewsWyK2WNQH36E/jiVpU9JKCWni68iilNMvjSi3lEpPGHuRe0vOsnnuAhuzfy5CmJLSBfC+
	wHJLNe88KN+4+lk0Ao6WrRz9KjhXX1KX2voU2yw7LLQG/udFtUNZlKigJ2ev51k2752+Rtq8ltS
	/ewGPvvLzBFqfL2hkE2VbXrcZO/z3GIJ+Mq+O8f20C0X++iwPyrkLrLJ0Fr+CmfTRBdxx1aF41S
	8Qj9/DchI1NRAQYXaZhf1cqTnprWYdJYrnpcrj+XvCYnhX0ITdIqj5oFJQ8Y5fhNxBR5sV7Iz9b
	vd73Eproj2ofg5zJTCikM8Hs7+dDRwX0vZ7srvMvXP4fgBVl+CtjNnmeOziEK1W/421YEknMus1
	NZ1V8rp1tX7oRElSx8516b64vAhIwvwQ
X-Received: by 2002:a05:6a21:6f16:b0:3bf:8de9:c647 with SMTP id adf61e73a8af0-3cd2fa2dfa0mr14028111637.0.1787320608326;
        Fri, 21 Aug 2026 06:56:48 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c07:efb3:773c:1c8c:24ea:eff6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327d01ff056sm19972277eec.19.2026.08.21.06.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:56:47 -0700 (PDT)
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
Subject: [PATCH v5 03/17] rtc: rzn1: Fix weekday underflow when alarm crosses month boundary
Date: Fri, 21 Aug 2026 14:55:54 +0100
Message-ID: <20260821135608.275233-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
index aa27ad7f5941..8c70dbf8c7ec 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -260,7 +260,6 @@ static int rzn1_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct rzn1_rtc *rtc = dev_get_drvdata(dev);
 	struct rtc_time *tm = &alrm->time, tm_now;
 	unsigned long alarm, farest;
-	unsigned int days_ahead, wday;
 	int ret;
 
 	ret = rzn1_rtc_read_time(dev, &tm_now);
@@ -273,13 +272,9 @@ static int rzn1_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
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

