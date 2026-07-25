Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D869E32E757
	for <linux-rtc@vger.kernel.org>; Sat, 25 Jul 2026 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784991545; cv=none; b=TXxJ4lHhkGQrRYSD855fzSIBp46xYa/2GvWZKe2SEUzta2dpBIZ0cIbdh1/GGi3Q99BTyWPJaAMF2t+HIYONPBnBJ23Yny2ZjCFRAYrDnv7yXX2trT+ov6EFYPA7qpBVE3g7DNsN1ZnVs/VK9v464jjz2heabh7tu6aprMpxe7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784991545; c=relaxed/simple;
	bh=Pwd4YSfxEyl7HnB6nRuYBkHVUVP1n0LKb+GUrztoMgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLZxlZ0EWw/8tYQfLsyKk+pvSFVDJ3pfGz7FP4vGz6aMhlqBTQA7v8maIEgXyoO7I5ukjd1GDzp79/EtYUf3kQNPcA962uNmCyG/cKElvbplnlwDdVlS8a5+zIUxS3GcdeD+d/ZCMh0pzmRqglZJW86c4A7xn6YDcIr3Chnp6Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nzJJuIZM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzJJuIZM"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954afac04bso14924945e9.0
        for <linux-rtc@vger.kernel.org>; Sat, 25 Jul 2026 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784991542; x=1785596342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xzb/s1u/mCU9WDH925m/XnJN8r8j9QkReDz7KZh82UM=;
        b=nzJJuIZMxqWId/S3g3CVHY6P/pvhOITCFL4lJ/ohKyKumvMdYpTPW10rnLctZiFC54
         zZ8UgQWkIeKxKS903tlnuz0rvM7XLP8nooGnpsNplkzNpuAsQhmAQQfr5/E/8oCzEjcB
         V1iWCt9ggsW3R2HNiglA+XV+5xvpJw2fHsKD6jGdGYaUOjaaGpNAxWCz8RHSdYPAsd9C
         pQa33WejQmvuG9oH06ZzFxmvVBJeSjhF525kJcTv3edrKf9DvEkf96k/9W3O1JOeuv2D
         E9ve6ANFBHrYeqFegn7tAqJefN9blV5/2rWBtj9bUm0tOHbShabWV6/x3Ft4/1cxRG/J
         nfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784991542; x=1785596342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xzb/s1u/mCU9WDH925m/XnJN8r8j9QkReDz7KZh82UM=;
        b=ClQsd8MSpQMup7F8cSRbwYZtlt640jepaOWUTm4Kjm0sZ5xgftNYdCx9adNqpiR0/z
         ifpjdAr73BTIrzZec/Nm4ywtZgOIQGcOl09WmyOrGyTz0gNns/YjYo7G3h18ZKKn6d8V
         zou3RT8O7CQdSMZz5RMsslbxVoIvh19gJT5IRgM+V19X5ETU2RMmXz5niw52v0+sbluf
         ptVXidUHQn833oc1PN8fSNrd6MMHUK7cd/gTniBDUn3wBOHwBbS/w/c5+YGxXsQN8x86
         ORtzKbxSSRAFY9hbGg2gRMJBfSsB5m7UgHDIl0hOKxlHs89LabP8gh7TLHefdqOhzdQ0
         uDIw==
X-Forwarded-Encrypted: i=1; AHgh+RoRnYFEYBcPYffGPwIcNmVLczuUm+nfexcP5R8J6qWDsagx2uigvZTykG2QNWtOWrnjSQrOunUzHFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+HEH4HIS87kNe5cqvHF3RsmiKgT6hhuURpisYvwA/EieBgbSq
	meLVGevS0CSfww/CkEwpXK00G/rcvku6CLJBfN6lVqXhkj+XZCO4moJ+
X-Gm-Gg: AR+sD10fENX2G6gRAHho5xBbeSxTPNqco3GGAOhPY17UfeNEIbSVJkGzBB1JPJH2pPQ
	FR3nScCK+2PED+n448FVdHZfRQIjNQiazDK90XRD4wV2vGvlN4Lj0vxDzKyzZJr8oL5pwEEuf1w
	eDmW1M8ZMTPD0Xq9TE6Yyo1HIymPL7RuTxa/V9O0rniZvUP/pK4L6THGUcFrgD2UgW1b+AsYyd2
	EdUAuzO2WlLHUUR5T2e946whytzBO63jrc4cUwZxcTMs567Rk1dSsmXg3dgg8U6RTVE/11dvOhX
	ntocLN9Imh2yQA/Cz/jk/dbf+Ircs0c4uBczcQK6FL48FhSYxiV/XAlWystuqrfda4jrC0D32o/
	4UzXaCTBVcnmnOE7cdmJIGoSj3EzAdU4L1d03W7FtS6WIYSYooO6uAKNjBA/MPnkcklulxW7+Mv
	sxpg==
X-Received: by 2002:a05:600c:1387:b0:495:689a:b3ff with SMTP id 5b1f17b1804b1-496b56b212fmr34762135e9.8.1784991541892;
        Sat, 25 Jul 2026 07:59:01 -0700 (PDT)
Received: from antoniarch ([78.212.96.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f24a93sm79704435e9.11.2026.07.25.07.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 07:59:01 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: marex@denx.de,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 2/8] rtc: abx80x: move part autodetection before RV1805 configuration
Date: Sat, 25 Jul 2026 16:57:12 +0200
Message-ID: <20260725145718.14733-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725145718.14733-1-apokusinski01@gmail.com>
References: <20260725145718.14733-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the driver is bound using the generic "abracon,abx80x" compatible
string or I2C ID, the RV1805 configuration is silently skipped because it
happens before the part autodetection. Fix this by moving
the autodetection before the RV1805-specific configuration.

Fixes: 75455e258ea2 ("rtc: abx80x: Configure reserved bits in RV1805")
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/rtc/rtc-abx80x.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 5486d9d0b1e5..ca3af91c2997 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -814,6 +814,25 @@ static int abx80x_probe(struct i2c_client *client)
 		return -EIO;
 	}
 
+	/* part autodetection */
+	if (part == ABX80X) {
+		for (i = 0; abx80x_caps[i].pn; i++)
+			if (partnumber == abx80x_caps[i].pn)
+				break;
+		if (abx80x_caps[i].pn == 0) {
+			dev_err(&client->dev, "Unknown part: %04x\n",
+				partnumber);
+			return -EINVAL;
+		}
+		part = i;
+	}
+
+	if (partnumber != abx80x_caps[part].pn) {
+		dev_err(&client->dev, "partnumber mismatch %04x != %04x\n",
+			partnumber, abx80x_caps[part].pn);
+		return -EINVAL;
+	}
+
 	/* Configure RV1805 specifics */
 	if (part == RV1805) {
 		/*
@@ -865,25 +884,6 @@ static int abx80x_probe(struct i2c_client *client)
 		}
 	}
 
-	/* part autodetection */
-	if (part == ABX80X) {
-		for (i = 0; abx80x_caps[i].pn; i++)
-			if (partnumber == abx80x_caps[i].pn)
-				break;
-		if (abx80x_caps[i].pn == 0) {
-			dev_err(&client->dev, "Unknown part: %04x\n",
-				partnumber);
-			return -EINVAL;
-		}
-		part = i;
-	}
-
-	if (partnumber != abx80x_caps[part].pn) {
-		dev_err(&client->dev, "partnumber mismatch %04x != %04x\n",
-			partnumber, abx80x_caps[part].pn);
-		return -EINVAL;
-	}
-
 	if (np && abx80x_caps[part].has_tc)
 		trickle_cfg = abx80x_dt_trickle_cfg(client);
 
-- 
2.55.0

