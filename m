Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75EF44DB85
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136061; cv=none; b=CU+3dWAhL2OdMf83ixGJoEE9vswN0Pg/50+uXPdDPVr3kWDR4JYMfdVQv4H1ceI9Bzp27Jc6Dm+726zHwsE0hVJL4bXxn/8XrxsTRF1M1bjCADra2C6MiM3vIuhtuXbSt6O/CZnbOyHH4r5mf3nQK+rfLhUVtU9hcIHxsYDH1f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136061; c=relaxed/simple;
	bh=6VygO8fJq97cv2/LDT6K/RY5WR4BNmBEN9fDoyhwQUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oF6igHP0r1ZoYYnweAIfQplOdiDokqoE3VPfgiAtJz+yRbzoAWPBx79iysmke2867iObbuCWBnLNgzbkUfcuETpvoFy6XIkYh6DCfJNQvBI2j9fuDj0tC46qmOuivd249Broq13Sy8Ex7LsoBQyLUIcwz7UJLiXkbGcg/MtmKUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvRnzely; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvRnzely"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cf50c6f235so9389235ad.0
        for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 03:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787136057; x=1787740857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BGNWO1eqT3R5Th3PNhdxmu4ZmPk2gjulxaMorpXLcZA=;
        b=HvRnzely38dTiK+3hNCLddjbcd0Vp+OpOopUkScqRaJk2H2jiw4IV7UQNGgU0szn0V
         b64WllxRGzeQWHauHOi6wrQ6A88xgD1kGqcxt8MjxozbnsIIeJ6Bxyx5sSe2nL3lUwnk
         cZI/V8bwsdWapp+qMjSBQhm3IqJNz9lqgzzrM67BL+moVyGmACtR8jZJYnDwLYTmE2zU
         6InDJ3/1/mhR4KGTHjbj3a+uddWpnzg86rxhXDZTaWILC7qPkDyoIwlLHeA/IGzKVVgh
         dArFs5K2folg6NQuiBKVJt8AVNgof9nulk55SD+0cwBmRelFYjcTbY1OcJ9hp0pztzit
         8V+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787136057; x=1787740857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BGNWO1eqT3R5Th3PNhdxmu4ZmPk2gjulxaMorpXLcZA=;
        b=splYj3sIbRSqHik7dz4CmZSSiKU2qLX2FW8cLBU9HajlzsPe+LUDaINdGRlKpc7XQE
         /25ooMMr4l6+zqHWj2xmTXPOO9bLrA8xeyYl9Dno8YDfH99+UmK+a6J2fuz9DAJxkkns
         Obgp+JoFU4cpEuTcBN7ctebXRQ3vvzEwKgqt+Jwd0/tGsKvm88h3TBXMCzVci0CpmpK9
         mJgZxeRCwhIE4hUFFhQL6+AZEjfAcpY87yJTv/8qwtHjexvgRkIAc1PRGqpw0zhxJHhW
         9q9+ueGnHwJkxOJQkBUG5/Ezt60nLMmy5pw/S8kShXRf9fC7/7OEAGVzhSlTGoyNOHrs
         Gf5Q==
X-Gm-Message-State: AFuF++l5/uUTOo5ABC7/BajlbPmiRWbUM7C3jH8EWD9NtYzjAgotDAHu
	xNb6mX0QMD9qpTpsvOQLCLlJ+tRt5t8zxX7cTfaFMFBoFBxeRVCCAosq
X-Gm-Gg: AR+sD12wABfctXvn73xM1CnXV5MKTNqoQh0J3hUr3v3G7Lmrw/IygeUNStjzeGDKetd
	B2RUU3L5BbR2r5wUVvT6amGGCgcsJmiWjD5g2aNb6k4wLzBalERVixBQg/Lkb+I6xaTacs91HZp
	V+TPgzj3+hZPdwkYImkhUXzw5pwqswAc7fABz3unmJmZX1b6zvLCJ00m4dTujwJWU1AmpzoYzn/
	yhExW19RlYNXJ3GqnP898mOj11HKAL1VYu4lV6pSkujgKTh5/HMhWakvnLtp0dEdnBCi1AX5dkp
	gXCB9D+ecvKpNDZmul/Y6zUYUdJopkL1yQ+yDzR5V0sF4HCpnj/FCgsuoSO+uW3Zwubju0hTVJ5
	AMfIJEkf9fRTlUvCb8fIBh63188uAJX1jXyxiZhi/7bpaJ/srxb2DekttY/aovhwGRyu8hd3P9E
	Jx9JAdfvTIFbfPhpl4TQlZSA/qvPBUuikwSPixwifROmpFjVGBiQT04Xx3Jcf0YrJi+h5x4xjNM
	emaYRrMbxLReDFT18CH/I/egJgT7SR1/6KGJwRz2pe9cVOCG3tI0adf2vtr2leqJSHoCrMw0ZFR
	R04AiAN0gw==
X-Received: by 2002:a17:902:ef43:b0:2d5:e9d5:8ae with SMTP id d9443c01a7336-2d5fd62ae4fmr69464095ad.5.1787136057289;
        Wed, 19 Aug 2026 03:40:57 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c07:efb3:a897:a9b5:e171:c935])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef77fc0sm11169630eec.8.2026.08.19.03.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:40:56 -0700 (PDT)
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
Subject: [PATCH v4 11/15] rtc: rzn1: Consistently use dev_err_probe()
Date: Wed, 19 Aug 2026 11:39:22 +0100
Message-ID: <20260819103926.2136712-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Use dev_err_probe() in the IRQ request error path to make error handling
consistent with the rest of rzn1_rtc_probe().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v3->v4:
- No changes.

v2->v3:
- No changes.

v1->v2:
- Added Reviewed-by tags.
---
 drivers/rtc/rtc-rzn1.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index e67bc8831cb7..7e2177f46313 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -471,10 +471,8 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	spin_lock_init(&rtc->ctl1_access_lock);
 
 	ret = devm_request_irq(dev, irq, rzn1_rtc_alarm_irq, 0, "RZN1 RTC Alarm", rtc);
-	if (ret) {
-		dev_err(dev, "RTC alarm interrupt not available\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "RTC alarm interrupt not available\n");
 
 	irq = platform_get_irq_byname_optional(pdev, "pps");
 	if (irq == -EPROBE_DEFER)
-- 
2.43.0

