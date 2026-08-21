Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B78D415B8E
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787346738; cv=none; b=qv//o3UK6FsBpge0UF93FVq/IkJfRpH6PYMFbF/d3D/w+K9ujcESjxA/D5ySmOZC/rZQRAy5GyhmJbztdu1LGHfCgQyeTbu4dEvMgfhL85GEtkZ118pgLvrrgzYumwlpKo3m1aLHWd2+LGs0+z/QdOucpPmfGx5ZZaHIZDc/WfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787346738; c=relaxed/simple;
	bh=bqLMPVulyGO3uPN192UU8p/Ih7Y6Dwy6WAN72JRYMms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqLHR/kisFJrtVebh84wLK+r+eyomS1vSJgAyHt4DOZgTUgNRpl8lsWqaROw1GfPBazprMGOOoCt8msev5zXEkPgnfdatwHQHfDgz/XIFDrL99ioRp5lZCp5N+k3RX3TKzsi7y8g4H93edW+BBTpCe/QX3f0+GPTEcGJAUZVOhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtMVtVPp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtMVtVPp"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cca0c5799eso13924855ad.0
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 14:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787346736; x=1787951536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VufRgxSYxCIl2Jf8aNb9F7AHOcOxi7eWJscZy8FNEAY=;
        b=NtMVtVPpv6sFBmmpadwMhaDkNClKtuRnsUWJCPTpRdcO7aI43sjb9LBnfz0ZgQs3Y/
         9xitwiV7e+ygIMZ+RUQzv6nXq2ZMiI+19j3W5opcspf7gTZWn5HR6qI160amrqH+IiOV
         zkijTG4EAcLnzfjCg6H562c7CPstvOJAQfeCiu+mBmRYB8Y15E+P7JX+F44OTaeb+tO+
         ydFFc2QTd3GxZYV92tOqTd5lKto3vG2E4p3S/xEutS++m69Q686qLsWhWoehpHyMwRCG
         H8MkhzyltAAup5Xu+lPQtGcUIKTLIjkN+aweTkyzoIOncH08gUlk0vaqxzmc7pFVLP0u
         8hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787346736; x=1787951536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VufRgxSYxCIl2Jf8aNb9F7AHOcOxi7eWJscZy8FNEAY=;
        b=WDbE/QX7W3aqzBkK9f/VM462NvyFEV4YncuDfsJq/OTDsAbf9QaBXqu5+TNKKckq4c
         3NmKO7T0X03Opq59j/VPq2zffkrxuxqW6+JjF+vaYEuzxzZZSpCfpX3m8456ek06Ptcr
         kmrHbSouIEAyrnRfO0BM7/gtkH+PMdS37nHBwTX11F1qxz8Yg8uLHhk17snGgiwGKV5C
         K9ag3jbjXPXPu+3I801bXPO01sfBcRn1xpm7V/JYqYkycA1Bm3Y7bds8IxWk02hYvmqv
         /K81GndF08nZNb1sHYXB3ZuA4APfqbXslqrgIK6RnMBE9Sqe/hNuhpY+hujzGBjLFFlX
         Tzmw==
X-Gm-Message-State: AFuF++kVOsJ1fJ82gJT2uY/vkVYshP1uwLtFhGmg9gnIxSFIk6PVRKbU
	WsJ9cBNoeU5JqNLdoCtdNXa0w0tRA0qegEH7wxkfeNL7506VlavDzepP
X-Gm-Gg: AR+sD13ctb6HRQtFIzVyddWCNFnTdE1lzXBDRJAhBfdPpyRYvJRmdGoRuULO8IOrXCe
	B9XtH4S3ouiXHyhfU8E1gpp1787GSykqc83sbp8MXRplC2d+zWgwUIWO7iq06Xz3iQTwEcr+g6r
	Ty0ytzd+y4f/bGRqiTaOwT/3HeuP4vvoRTx1xOD6Z31gsNCXuluoJ7nvxZtcwW4xyB7jHwDAxg5
	UTaw0Qtlnw52a0KoZHBN7gpeqWvZurGA7G7stmrcD0cjQT3pP5zIkkBvLLHMQXC8pPtBMUke+jr
	4oCv4wn/mxFG2RMwBxVjUUxT0PUoJbcTAzcO6Nf3XZm4q8VQJ0+j1DoxShaODeE4qGcaKpxt6OC
	NAbfjzNXEZVlPxEIE+NZ9MX9/tEJSXFq46W4vERDn/GK9/P2FrbaeFLHzSaDKM4iShb8LXSQQLG
	eD8FYitiKYnK+yg6JxWQpWnB3SGvQ57PGzEs2r/INJn3GX25tatsWgOfiXka8otRIPQEOKQ4aXd
	HpqG1LQn67Q6d+RBVXR5vzPbEW7LkaUrlqKMjlqG1gl6VCWt9mO1nd6dLvTw+n2D1nbZI7s
X-Received: by 2002:a17:903:1a30:b0:2d3:160b:c01f with SMTP id d9443c01a7336-2d64adce8e3mr179152855ad.6.1787346735900;
        Fri, 21 Aug 2026 14:12:15 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:194c:dba4:ea1e:d7d1:affe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf175399sm49755257eec.26.2026.08.21.14.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 14:12:15 -0700 (PDT)
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
Subject: [PATCH v6 13/17] rtc: rzn1: Consistently use dev_err_probe()
Date: Fri, 21 Aug 2026 22:10:28 +0100
Message-ID: <20260821211032.13554-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Use dev_err_probe() in the IRQ request error path to make error handling
consistent with the rest of rzn1_rtc_probe().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v5->v6:
- No change

v4->v5:
- Added Tested-by tag from Wolfram.

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
index 7598efc31e09..9fc93afee1e5 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -485,10 +485,8 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
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

