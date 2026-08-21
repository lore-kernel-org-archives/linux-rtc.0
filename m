Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D67499F0A
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320675; cv=none; b=g4xHR2nGLzFOG/0RHra02QBVe1ZYWhKSlrsTJVGPor+vXA+fzCc0SU55ZFpXBGb3jWAdnNOlgHaFf/RxnnUge4uTBVWEwGVUAimEgDIPzp08gHjZ2f9AqVNESyZ7Qo+LeWVRb+ZEMHMHA6BCObCJj90YcBMoYeXTK0H+45/WIG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320675; c=relaxed/simple;
	bh=GZSZWo7FCGuFvodhKjJU6K3a2wT+h/1TynS72/UOdJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXDcepdNAou4xnKPDd8rjLsvkd1TMWi7wBc77wmMhQ4UlVkKYlqrfrP86mZZib89oCdqO1InguyEW8KiLUeRj0ZT7e/Lr91Nd5drYiQ9MpBOMGi6aajqFVuaIUzCxRXB2EMM7zjwQQigu+Grs+cXbkQYG5xs/gi16CIickXYrcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPcrtoDk; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPcrtoDk"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so790187a12.2
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 06:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787320673; x=1787925473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1oLG+YxbJjR89MQkaFvxx9kQt98tBR55Lpko/eQdEoQ=;
        b=BPcrtoDk5bvNKyaAZ2TR0oAOxha5qSwree1kr70ABNB2yVw/+OM1Asil9WolBfSvII
         ErK3ceWjT+hGpYA2Z0I3Baa7LhL3Z0pUmRowZswB+uFe7QPmgpkj6gB/1dTbJ25N907Z
         9J7RyLbqiO9zP+QvS31IE2xf7PzhFMKavDRBLdtpy4vQEG/0158k3hKns56+f4yDP9i/
         UeXwMdRQNbrRWs5ChP4g+SZ+AvMXXMxgsgA3tUSBuYhmTlFtQ0ghNP1nAuWgls+edoFi
         eknM09Ht2r19y1svG87KbjKWjeGajoDzjAX6y9h4y9kWgPLYUyxt/1nV/mKsFjwDHzs5
         dyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320673; x=1787925473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1oLG+YxbJjR89MQkaFvxx9kQt98tBR55Lpko/eQdEoQ=;
        b=dBxr9LG217c1RisDHGuoCm35fTJDst+DYRcWI0JxWNYopk+e9SfECdFxZAfzAFznEL
         i2Eb7xU9SiUrDiy/w3jHGBiwJ2hmtHeml+xgn1LgXzNmb4e4TY5jws0O2fQ8FLlHdVcH
         f23D9PCGgmvGBsgOWF1x3V+21M6MQ22WQgbzi5qgsHg/6lpgtALacsqlI2Ybs8Lyz4f2
         wbnq2dnRh1hwJA8dNTzIRmGq3qM8wOxpnpvWTKBJZ3quNQxpeOeAoOpgj+Iv/1n+jbHr
         5nunPyrvVZ8g0OFp5UD15+5vVFKO7ThdZ4IGZ3MVXybPjCAjjl0Er8HDbzmYkWOzrCfI
         Lg8A==
X-Gm-Message-State: AFuF++nKGTNyfvdPNOGvnXxtllp34lA1CqZw81CPJkvIO7y47P9O10Jf
	/rIN7XV852TXb0oXPO2YI6u/hkaOUbSYon3IbWeBGM99pipKUY8Cqguu
X-Gm-Gg: AR+sD10dahRJgO8JBxmQKjb+Yy0xn5vWa5IGeqWR3/XiOsTELv4zGlJFC+ujkxlnnoI
	j8yb6sNgIhzpQ8owqObaNBollt4A3W+WMaGKofshTdVER4cPgdIGSr232MkLIalnlrSL9KSNGT8
	vJ4+YKK+yELZDg5DC3iCrUsM7nPWdpGIQPapla0y90GGM+aMAtujGG4VPT1DztAhbiuOwYztVrk
	dq88hsIV2qUZLP6YFxp1t5NL29WtxoIHTTJV2NIUTSoX6ZRXe/wVoBE09L3HAcOPXKL7hfGt7N0
	JxYDPCFoO4Y8ksu1EaSGKCjWyuu7ScXbM3/rqYRmX8HHH4qjCBPdoYmB41VDU1GhWQ2QMoCstLP
	97X4sQb7Rt0ryfoU16SdZeYUimdYg3f9FPTgddPXwdFMAp8yQvTTpQQa3AV97yA7e5Ve7RCFP02
	a1dryXSffmgkqvioM6BHStH7ue4v9IqzzEkNbCWSePTatzLF+SGG5oF4rPegRtvir2VSnS8xmD2
	GXy+uqomSzF9njPl0aNKYathqwwt0BywKLXRRzEiItJr7oPlPj20a2xs1hUuAkdtfDpBpufi54y
	oup5jjwPKg==
X-Received: by 2002:a17:90a:da8c:b0:381:a766:efcc with SMTP id 98e67ed59e1d1-395c3865a2emr12630467a91.14.1787320673241;
        Fri, 21 Aug 2026 06:57:53 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c07:efb3:773c:1c8c:24ea:eff6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327d01ff056sm19972277eec.19.2026.08.21.06.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:57:52 -0700 (PDT)
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
Subject: [PATCH v5 13/17] rtc: rzn1: Consistently use dev_err_probe()
Date: Fri, 21 Aug 2026 14:56:04 +0100
Message-ID: <20260821135608.275233-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Use dev_err_probe() in the IRQ request error path to make error handling
consistent with the rest of rzn1_rtc_probe().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
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
index 1b16fc06bce7..ea3906d1f868 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -484,10 +484,8 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
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

