Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228E142A149
	for <linux-rtc@vger.kernel.org>; Mon,  6 Jul 2026 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360316; cv=none; b=ImJDS3AvQaxsmNpZf730koqi5RyGatqmUAABIxjd7jZxR5lyqHXX3iJcqZt6t2kUxh31fR15ENdOxUchTcfRQEgKEmW3Erpqg4J9KXN6U1ac9Yd46hSL+JPYOARRTLtcJbah8nLB9PacvjKidyUsw6FhAaKhOsBLmel7h0vz/yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360316; c=relaxed/simple;
	bh=2etUF3O4MJaQukDckxlOUsV59G7vPFsbrP7xRDKxeJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+K5wZVkcLGnN0Gfh3mZLZGhuerjnn8sgjOfyE6+VMrQvKRPv4pHHRrXM5pYxYqoL2hj3e+ufeyrO1aIjcoxLIHLHSqhtOR8ZB2/qIh1btcjiXxPJXXxlOaBqVuck0dhLX5Fw0GiUTp5zbvCGf9168VxpuZ0EK0UBkmPOMYooi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1bhDHJG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1bhDHJG"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493d1e8aa46so17916635e9.0
        for <linux-rtc@vger.kernel.org>; Mon, 06 Jul 2026 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783360312; x=1783965112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mYMkQgNYG5Y2Oort99EuINuCgWUlk2Myzb7/efCWb1k=;
        b=F1bhDHJGzbliR2CtPbixou3100nis1bFbEnyqSwIDEa2CJYhhzRgQvzh+aLhFQVwSa
         4VuNd+yqbxXkT0FHp7SZ4FI02Zw5BfTkcdanIz900VtezMljjy2KMTB2rkDzz3+bflJ8
         8Lugo0KSMRSltWKwtCFDfacgQbrn3fgilh/hU2cGzUdpNEH5JYVbkJlkE+Y6647OMYag
         YkRzkrD3AqUcWusCg5DO2cpfXp+Aq+vy87wM/MVkJLkkbvAQYrpIwv3mKVWZZJJV+lwi
         mCUQOmzOHvOPZAPH1kOR1y6r1Hm/3GrxqpkYJBmdZ8rAYDgmumSzK9lsNptdTROi4+3p
         Klrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783360312; x=1783965112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mYMkQgNYG5Y2Oort99EuINuCgWUlk2Myzb7/efCWb1k=;
        b=ArEOqKLrSUZxSk0xRoJkVJDdF5q2RvOH/GpCPUtIIUmMGwRVulbc6ZomQ2SFSskHdY
         0iDCBj0nyVkDAX6F4BGGbUSfeYyUAiqSIoq4Dta4ixeCytbAEOceAE6175heHNcnRkdq
         pbbOW05s/ncsvBe0oqo6VqGAcQDNteJ+8a9XTgXkHag8kO9OSahy6YnLoHJhPsEkTe18
         BjKOeycWyShCmOKnrrOVJOmSkDuTrfNDIDJA+imukdTI9voYQh17rSrwGwdPqT+NTyTQ
         F+KnhBwZPnOf+0rdPnZPKZemJK00ea8CD43TiJh5meygzOuLz/KYkmWX4evZStxB933z
         qvCg==
X-Gm-Message-State: AOJu0YxuRyreOaIo7F6mK7i14Npu0H4zscE+upliaul7SfEsl+3blTbh
	piAzVMsV9nNIJ7msxZAojEC+6jHd/Hh3npzKpg1dc6tT4zHoIooxvhaY
X-Gm-Gg: AfdE7cnIGfzpKAbo8bv2he71FwZG2VBYSeiAHIRG3jqY/H+gFXq6V2FHmHSJFk3qE9M
	9nPPRlExwFJEJ1NuuTwfBAy93gdo6r4NHfJpzLmuySMEc1tTH38gTWPtiKJ77JE55vVJXBefaw5
	dzMDRlmZLZL0YT0D2uRw5tXo9Vqkh5WzglXMpIu3UrjI9XrhZjs4p8rEZjwi5FGW1rBdvx0gI1P
	rX31drNHsdrtBIvfJ0wzKm8O3mgUmS2KBBA8IdeLEXEcHFO6gHVPljphfNakR2nZlS2jo92ase8
	EL6h8pp6k0PF6oS8EMJZIjUtzVQHJ/NI7DpxU2slFRGnd+6N+4KAOoLPryy23GoyCnMHCoytVmt
	Stjs+P3wwjdL9zApPGyrNpaFEHT4AiSZjoaFTpS3qcIokcammWMXJBTIgCaa/ZxOAnqUSZRk1L7
	r6nWoZJ/di0XRhxgmDgjOQ2gCS5MT+yBM355tt6L6dfQBwF+Z+QjuQmBxfBnKH+h0AY1EcQDxAE
	4+txOAJma9M0DVIINoHjfDtPDo=
X-Received: by 2002:a05:600c:19cc:b0:492:5145:f054 with SMTP id 5b1f17b1804b1-493df0930a6mr19635715e9.26.1783360312313;
        Mon, 06 Jul 2026 10:51:52 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:8e02:886d:c345:c5e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0078d49sm1263145e9.0.2026.07.06.10.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:51:51 -0700 (PDT)
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
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 06/12] rtc: rzn1: Fix alarm range check truncation on 32-bit systems
Date: Mon,  6 Jul 2026 18:51:32 +0100
Message-ID: <20260706175138.12587-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
---
v2->v3:
- No changes.

v1->v2:
- Added Reviewed-by tag.
---
 drivers/rtc/rtc-rzn1.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 2a0f0362dd52..a5283e680e36 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -20,6 +20,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/rtc.h>
 #include <linux/spinlock.h>
+#include <linux/time64.h>
 
 #define RZN1_RTC_CTL0 0x00
 #define   RZN1_RTC_CTL0_SLSB_SCMP BIT(4)
@@ -259,8 +260,8 @@ static int rzn1_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct rzn1_rtc *rtc = dev_get_drvdata(dev);
 	struct rtc_time *tm = &alrm->time, tm_now;
-	unsigned long alarm, farest;
 	struct rtc_time alarm_tm;
+	time64_t alarm, farest;
 	unsigned int wday;
 	int ret;
 
@@ -271,7 +272,7 @@ static int rzn1_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	/* We cannot set alarms more than one week ahead */
 	farest = rtc_tm_to_time64(&tm_now) + rtc->rtcdev->alarm_offset_max;
 	alarm = rtc_tm_to_time64(tm);
-	if (time_after(alarm, farest))
+	if (alarm > farest)
 		return -ERANGE;
 
 	/* Convert alarm day into week day */
-- 
2.54.0

