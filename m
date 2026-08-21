Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D38341057
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320623; cv=none; b=VhI795kKlOTwyTtRzozKTSelWOkI3BfRKZVYvUmCt7wJCA1VSEYqiDICHOTRmEsbslf3PCkTWLWdr56AMGVkvfrm4q9zVODk2hH5AUMD1bjzwLCGIuWscmTLe3438wniepShedav9rux6s5rGsMdqdaD5moK8CWApJovrayo7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320623; c=relaxed/simple;
	bh=At5m3bowVGd9aMKqLO6E2xKZxUY4pGoxgPP7q7tGP6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFzGOEfWCjDJL2wX23W6ipr9+HtPLzXdi4meuRKXVvQFhXeyldqH86box8fZjuYExGUwxNUJ/TxmfWMmsaPfZ1U+D+RFpjzhNhQ1mkLLAU85TY3ZrcSlppdTmBd3J5p5/mStOE1JunjZ66yA3YVsRpeCNp4NNARtRURNj56c2vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHTjbO9l; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHTjbO9l"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cace91f112so11371075ad.0
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 06:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787320621; x=1787925421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cpJa6Rc5FC+z/scmXNU06IkGTT32th6RwcEKPAtBpjs=;
        b=sHTjbO9lyK0K1fEBVoFK9c75OnPvzf1DaGpbxflB20LOs/j1BHkeNxXtbCqjFSPB9i
         1aprWJZC3guv0eFB0PZLi/7JM0vNLdWTZxYBVzgjkl2o3UOptgU+KGsYzpNkTaKNgqf6
         saec1Y4ymd1yN7ae8Y/4sp436aJS6MvUXGX2pyTZjuDp7NZ1hImUzoI9OWwC0pk+/8BU
         kNhra8PXH/F9+sFbdIHDXjZL/UiruUmfdRRlDXwV3r3mb1qZeg0nvxC+/n22sRgVRE0X
         7hApWI2Vhcu/Uh3YwgE33i7UMFU5Hcx1F6PZr8oCwdkzUuXzSPynR1SpZbtO0vg1kXy6
         z7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320621; x=1787925421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cpJa6Rc5FC+z/scmXNU06IkGTT32th6RwcEKPAtBpjs=;
        b=f8Jeoxebyci3mAolu9UI3Y4NhzrlGs1Hl1w9gV+ZAduO2pSRTSsMN/ZiSjP0g0bKiA
         8LumclOQLp6lXMGj1IathlwDPB9H6wVg/EJKflRcRZYdQo0vOer8L9Bnf4sYe5pw7KkY
         kQ1QAHw9r7gXI5TlGYVe+GP12NoY3c6EAjX5/wMQfLvaO3Kwy0uJ4jNc3DQw/zsJq5Z3
         AFfHj4TLd8ahQbrGP/l+EVdODQ7HeYe+cTcescyr0sZtknXy/Uf7S3GnrElx+tGz8SG2
         Q7Lp2wW2CXJWgCqbAPjN9iRPiMlYuT7UDGFLgqriX6mZEkF/+9l6gDUC6qxhuOF7ij/2
         W8Hw==
X-Gm-Message-State: AFuF++nLoeDs9h7w6ffeQ5wxFSOgEs4Y4odIDnS/heQ+IPPKJ0AruvrS
	z85XnYmvqFfWBk3pplbe+dtOii2Kgb3OsTkOfe+asP7alvfdE3G9kXQe
X-Gm-Gg: AR+sD137HYwTkdTr65cI1fjETOAPX1wKIuUH8d4SjtkJ6w1e+iyaBx0WINaIwJh91fu
	msXlLpIMeUAVHdVyEj86TzaP7L7kE1BBZvTBEYZvpwMXaQORo0yILWiTNGJiZ8WTgBbGsdIaHtm
	NZvgxiE5XVUZo/fndCgkAq7tTZaidp/odEG9RKm4WtmUjUELLPNya8DSAWwzXIfxlZpvqD/7cWf
	lKjtDTC+Hb4HY4teWOiQ6sFRKZx7Pe5xNMIeaYI9P1NPcffKuLsi/DZdflR/DDfu9KOerNintcO
	NcVInUiDHei/4RuzTWz0Tw2rm5hIBdrTrcsJ+IJFlgO+M7+jy0jDl48570oZOd+JXGgrwVadDgx
	0Iz6Ys6vvgCex013OzwIUweb1fFsrnFzDCqe5rGqW6izrewgR+f3HCrAytzSuWMmX2I2a+z9S+Z
	WECVltYDnVrRJ9OVJ/Awkepw8L3n9imvVFhfN/cNg3qVlU4Lk4d2rboJwDau59PEAXbeYOG1fZg
	PS4+QME7x+mLyLFZT1eiP2reRCo0TU8qfr2n0MEq5AYxZi5ycXEPsHfzaLqDuUwgg1UKQE0qDN0
	3bv6BhWcW4F2+Tc3PHla
X-Received: by 2002:a17:902:cf08:b0:2d5:3f5f:e645 with SMTP id d9443c01a7336-2d64b0d8789mr134872595ad.12.1787320621316;
        Fri, 21 Aug 2026 06:57:01 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c07:efb3:773c:1c8c:24ea:eff6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327d01ff056sm19972277eec.19.2026.08.21.06.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:57:00 -0700 (PDT)
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
Subject: [PATCH v5 05/17] rtc: rzn1: Fix alarm range check truncation on 32-bit systems
Date: Fri, 21 Aug 2026 14:55:56 +0100
Message-ID: <20260821135608.275233-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

alarm and farest were declared as unsigned long, but
rtc_tm_to_time64() returns time64_t (s64). On 32-bit systems where
unsigned long is 32 bits, the assignment silently truncates the upper
32 bits of the timestamp.

Fix by declaring alarm and farest as time64_t and replacing
time_after() with a direct signed comparison, which is correct for
time64_t values that will never realistically overflow.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v4->v5:
- Added Tested-by tag from Wolfram.

v3->v4:
- Added Reviewed-by tag from Wolfram.

v2->v3:
- No changes.

v1->v2:
- Added Reviewed-by tag.
---
 drivers/rtc/rtc-rzn1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index e0fdb591ba91..44e8db466cb7 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -267,7 +267,7 @@ static int rzn1_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct rzn1_rtc *rtc = dev_get_drvdata(dev);
 	struct rtc_time *tm = &alrm->time, tm_now;
-	unsigned long alarm, farest;
+	time64_t alarm, farest;
 	int ret;
 
 	ret = rzn1_rtc_read_time(dev, &tm_now);
@@ -277,7 +277,7 @@ static int rzn1_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	/* We cannot set alarms more than one week ahead */
 	farest = rtc_tm_to_time64(&tm_now) + rtc->rtcdev->alarm_offset_max;
 	alarm = rtc_tm_to_time64(tm);
-	if (time_after(alarm, farest))
+	if (alarm > farest)
 		return -ERANGE;
 
 	writel(bin2bcd(tm->tm_min), rtc->base + RZN1_RTC_ALM);
-- 
2.43.0

