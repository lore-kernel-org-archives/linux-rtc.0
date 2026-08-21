Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F2E4189DD
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787346758; cv=none; b=ESmh+5X6BUaewtXdCCnqA7X/gtDVhGwTuB1q5yeVGB7b2wm8lW5uIkrQTMsUwLjzbLQW7Kh+LHzwbJhjYUY2WBJNCIYBIcQwaZToYUYSSuLxyis/ekvJhiFTHMKrXF71eVqjMhtVm3gYOuJMZB1ha4upNRk93x5Jnog/3z19Pj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787346758; c=relaxed/simple;
	bh=pqm8lJvKyQBek+VRRquT1stu70Oudwpmv5uE5mWefoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIcW/5be5rEB0hYiQ1WFYSTnsoAPg2OIKAC02frF6BWZO53cx15efOto9nY/E+otQ3l/2mrRaznsKuxh93CoUS9TTBzay8wst5Osud414gUbROkdevdCDOpKdXarJOLV2GFHyrSqvZd/tPOvFB51tRwbDfLVbojJWZivWVgRbWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cue0kEvA; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cue0kEvA"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1062922a91.3
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 14:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787346757; x=1787951557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hPE5YqIeze9+5WQD/4I5qaaAjG465/ANUVJrXtv+vZ8=;
        b=cue0kEvAhGWqrohDdI93OyATrdNKWcU0dab8E26lYXx6MipsjvIAF+HqVxGUeMqBTY
         bU4xHK32p+7s9JPzfhxAb4jkHxpbEYQ8ozMcm5fV35Dg6dyrsmtq4igicY7J5s7O4x9x
         8J+9Y9ZwOMRLy9vEGCypWskfJAahJSiUE3J9FTAO4sOp8KNwceQgj0DS9g4u1Jqmpnec
         BbD4An1JO2IUgiS2Z7M2cBYYubkF9rbZQRqhOVCl/uCMuiQlyyhJRU4ezzEnw0yHepGc
         OCgdAQVncHmBLccIqX4dPSIfhm+plDUxTH/3cuMf+uEPidAbfzB41H8oYUkNZH5xYIiZ
         +2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787346757; x=1787951557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hPE5YqIeze9+5WQD/4I5qaaAjG465/ANUVJrXtv+vZ8=;
        b=UuN0xfmdBvyG6psv6YAY0CM6DR269j0nBldJA4dJJPwUga9MuSzx3uSWDDcuWby9tf
         LHSddG58k9NAWV/d6k3deTUoR2nWflCEmOgiIISfj6y59Sj55DtrKf05x1Q+C3+hNsDU
         mSMYKUj4Y97f6Kp0teDtFBj8wtvqbjB52ePzyVM5h8cFeSRVM59rF8eFDf9Az7uDkxnn
         DXGuFXjlLjI1XpiihEQO40Ocf8qjhraEOSDiwMU6VxSh82xdeVSBU/LmYEZkarYLIihb
         PfYLzvRQpCtEf8XSL0u6ykhFfFxuqFo9nCNG62m5eWI9KFK8T0SqWPapyDS62QqJWepS
         aKlQ==
X-Gm-Message-State: AFuF++l25pYEtjZXlM+JjILS0+6Rkmf1U9sfDCkKj1oS5fFkLiCbBRKX
	zzL2t24TsgkJdmRlcATzQBQjJF5wMysfa7mkCjbD2V86HNENSyNRYAuf
X-Gm-Gg: AR+sD10Xh+n0FJBpycxg7EtD1yYfKXOU3/5lW6oPF3ekLnK0Xe1+BVsFl27dhLjoDoU
	wK7C538I5tkH/r+8pv+nCJI3KbJde81pVeRSLscS13WLvS9LdQJVza5XtnAi8lHP13MpDu4ISm/
	71VvtGEllMubEtCgz6Gk90BXwDnbDK2ON11cmnIRE1ZS51d69QyLXvk7wyYxIpgkzSUZW8Bnta0
	NiFkl7Zu+vH6RnBxA7WnXZSz1IuAbnB9kinHj+ewLM3LVkJ95Lb4Ne75pQYdH8gAi4LJcfAq117
	IcHD9XgzET3zwdMYxhycTzme48Hylbd3caza4+5u2dEmH/odEIF+B7t/TXfXnTE6mWBF8kfg6gw
	BS3jeHTQrDo5oxgN+toM+ZfssVd/6Hgn3nOWD56sU/dEGJZNI47NzvySFd8ns8UjSt36aHvppRp
	AfczC7/5JnaGSzXm0v9gQd0OMgoZ4qAWTEpi1MfXyVvZnYF1xi6XCCFJEaZzfY+MvFL70RhDg1z
	STkXyxnkIsCfoQCXkyh2/q1jaAqQl7AbQvTIf9yeL0n9Bcjf8F5zDUIqexjS27Syd+njuXW
X-Received: by 2002:a17:90b:1a85:b0:38e:250b:122f with SMTP id 98e67ed59e1d1-395c3aa9e26mr16109390a91.16.1787346756800;
        Fri, 21 Aug 2026 14:12:36 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:194c:dba4:ea1e:d7d1:affe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf175399sm49755257eec.26.2026.08.21.14.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 14:12:36 -0700 (PDT)
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
Subject: [PATCH v6 16/17] rtc: rzn1: Drop trailing comma from OF match table sentinel
Date: Fri, 21 Aug 2026 22:10:31 +0100
Message-ID: <20260821211032.13554-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Drop the trailing comma from the final empty entry in the RZN1 RTC OF
match table and mark it explicitly as the sentinel.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v5->v6:
- Added missing sentinel comment

v4->v5:
- Added Reviewed-by and Tested-by tag from Wolfram.

v3->v4:
- New patch
---
 drivers/rtc/rtc-rzn1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 8c3dbbc34717..906d03c65df3 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -529,7 +529,7 @@ static const struct rzn1_rtc_data rzn1_rtc_rzn1_data = {
 
 static const struct of_device_id rzn1_rtc_of_match[] = {
 	{ .compatible	= "renesas,rzn1-rtc", .data = &rzn1_rtc_rzn1_data },
-	{},
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzn1_rtc_of_match);
 
-- 
2.43.0

