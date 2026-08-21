Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1F03CB551
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 21:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787346682; cv=none; b=nwb4bHUn0qxGAyHopUCJ3m8TWXjQD/uYPo9UbHC9c0J7AJSE0DI+x5ZLo3U4rCKYWEa58EHQHQ6ogjbc+8PZN4+Hn42B+UxNEnHLCAeVUdDv/TEHzhqJQCE2WefIHlNwzCdkAXgzOljaFqjjsczA2V4WySDWpolS1QuFUmzNeoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787346682; c=relaxed/simple;
	bh=4qPzU1qyixVbSt/2x/vRlwNrYljQ8mnf/LV2SZCpJyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9Z5UEKAABLYbLILU1kODgJr77CTn3UWCIG3C+b4+tR6bwngZpIW2HlJne9f33bW3izp7g3FxZJ3gShj2fuBFGsxe5SVe+U/Wiy+460KFRfV6a/qt9CjREtdSy1BdTY80+ExtQq+SvhrZ0qZDN0GTzzgM3S3rlyHSqjOYA5P0K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s5zR8mai; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5zR8mai"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2caea3f742bso23511995ad.0
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 14:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787346680; x=1787951480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yn9Flz79IoiVRVBjWq6xrtU5CbtD7DazplXOHiCs9RY=;
        b=s5zR8maipP+0MMv0lyPDQXbcWWrvQokpqP8HaTs8t8mlphvkOyTK4h+9XnHnkguFXc
         dD0zrMCz5FyKGsYywOnPcAdTgvkux1rDDegMEKC80p3Sil0DO6ua1YPdXqyGYDuyDXQR
         N1OJx4Z+F9N3kDbb8c39LGhbbO1bV9oxhVKYLaqK4cmPBMmmKdrrGcqhRefhmWrPXS1U
         7FcVURB1jj2rki6XnDM/wUa9C5mkkXWHOrl9z9c17HiQQPeyU6UcycfjAjtDOQYHPUI2
         mMLJ2+RC1i6AnQ0Wvk0piwlS66vZnRJEMvA996XFQV5zj1Aqua7cLgiYnG0sG9J6QSrJ
         cbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787346680; x=1787951480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yn9Flz79IoiVRVBjWq6xrtU5CbtD7DazplXOHiCs9RY=;
        b=QOXNBZFELsEIGVbIL15ma7EG8YU5gz1Ohj13vFe/Jq6K9hbjIpxKNNzB5DSDeUxh+U
         WkfJF/ufF6jeYfqiYTLveRU/iWMGnzBJUoEIW39B5BXx0qilFVk0wLtE7aWbDNyIW+y0
         zYyhHHVHTlnvtWJ1QEtkVrJa2541DPD6Rw+q7EnEkKpphdbUBLKz4SbAulXpHGiA+n6e
         DPyn34WUl9GbeF9iEBozVRDEkCQNdHyo6nBGKgmwj6bEP4LUu0nZD6famSJESithxa1/
         v9GBQE2KtvIu+XCrYMjNJedGkmxr+r9XPavZ+snPG8K+1aX+f6NZWEEUA85FB4aCv++X
         rz5Q==
X-Gm-Message-State: AFuF++kzRAvHZk/ChHKJTvSW9xGmpcUIG+kjcwyAfCfGw2OL5LhnuZ+0
	yFUaZkFYItjZhSODS/kQMXwsbn3qBLcCJbdf6f0VUXQltYeSK5cpRtbW
X-Gm-Gg: AR+sD11R1G7s3PK0md2CgDY1TFCyGm1UJYOb6JpyVrlkEGpqfu4QI44C0pbsQwkjjnu
	8Y/YaKsMYC8z0o4NF2EEfJ/SK6gh1DQBDZEIV4fB+/c3Rcw/0JFHNIZvqklGn2QK9DgFeWK75Fx
	5w/uvO88n6qZqhMAT6d+/WH/60NXPc+wGU2Ism0D5M3vIY8bXRxiU4QZM+Xb5d8oi2yuVyYpihI
	VzdxFjLg4955TY83/Ulr6Akl36PYcOqGHNsgpygOa2u33M9ZDv9qR6Ap0EQjC2BB2+gv9iel1Lt
	mEaMiNbgh1gUPj2SlDzGaCvJF/gd6RMFKe98PMmkIOZ8dKeSnrqOWvvIjD5WIdvy3tfI3Tgt+kR
	rQk6FR79248ooD2ul0hP88qKLaH5dHVyHBQEmdCt6dTgaSh2gcPIy0hO30ij66H9se9Y628rLF4
	Y1+/U2Q3IvcX+y1++KmwvQcWFoqMTQ9z3tUztdgQset/gOtCtcgr34wpwuCtvObHBnwVyy9WbLh
	mSqZO7s84aSnMqjHw2ZphTpHBpthG2D3iaenKSsE4lDsuTSta4kii+zwZh+g+7hyWLPlK8cqQ80
	ZeihtQtQe8Yf
X-Received: by 2002:a17:903:354b:b0:2d3:2e86:647a with SMTP id d9443c01a7336-2d64af6f896mr181704325ad.5.1787346680507;
        Fri, 21 Aug 2026 14:11:20 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:194c:dba4:ea1e:d7d1:affe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf175399sm49755257eec.26.2026.08.21.14.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 14:11:19 -0700 (PDT)
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
Subject: [PATCH v6 05/17] rtc: rzn1: Fix alarm range check truncation on 32-bit systems
Date: Fri, 21 Aug 2026 22:10:20 +0100
Message-ID: <20260821211032.13554-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v5->v6:
- No changes.

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
index d4cba0d415b6..f3268655fd37 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -268,7 +268,7 @@ static int rzn1_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct rzn1_rtc *rtc = dev_get_drvdata(dev);
 	struct rtc_time *tm = &alrm->time, tm_now;
-	unsigned long alarm, farest;
+	time64_t alarm, farest;
 	int ret;
 
 	ret = rzn1_rtc_read_time(dev, &tm_now);
@@ -278,7 +278,7 @@ static int rzn1_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	/* We cannot set alarms more than one week ahead */
 	farest = rtc_tm_to_time64(&tm_now) + rtc->rtcdev->alarm_offset_max;
 	alarm = rtc_tm_to_time64(tm);
-	if (time_after(alarm, farest))
+	if (alarm > farest)
 		return -ERANGE;
 
 	writel(bin2bcd(tm->tm_min), rtc->base + RZN1_RTC_ALM);
-- 
2.43.0

