Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B113D47A1
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 21:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787346696; cv=none; b=ktWBsmLkR/W0H9KlShxIl0BabWy6JGmyOX2BPzunLVs2Nf1UnHPDoo4gU5ROluMusObAmWTmz7IidEsR+s6prQguc/z01hF2sXe0ZO5tmFjrNIcL+OxwYkXTm265NS9QuM6aV61isjvW/X8nljgD3q5xHViwcfVfeS+An1V6zw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787346696; c=relaxed/simple;
	bh=BNRstsXO9Qn5hNwHi5BiqdQ6ynmasEGVgbJ6LG8IhFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DeZfKehKb3jcfPFucvkD72PjGgZQdyb8S0Jhd1mmLfbx/MqivDRw++j+IMNUiGyhAKpc9j8SWa7JtwaRTYmWJgEJPQZzEKN270XBbjnz3+xTq7lJScTETRf6IIIo/jLn7QW7KF7iZh4kiN5zkanweTX9fBJNRhEzkBgqTHztJrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVcOPJPU; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVcOPJPU"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso1964839a91.1
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 14:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787346695; x=1787951495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cseIckdQQAKYtcHlbi/8vX8CHGe20BNek8ocdDs8KAE=;
        b=oVcOPJPUjh/9WLwcNylFgGDhkQnYlWzndUTDtTdGM9i0/i1pLqZjA6tnDezIewFPON
         5xzv3h8gZWuhuo25eAoSBt0scBVHrNnd5xLx6O6DdSjBdW1qcbxO3qSocGJHbd2itOrR
         n3sqKemDeFUXiQr5OWfT6bvpBkswEchGlVozlMCJeO1BPYKdfqotAaWxLKJ6sYtbRzeO
         wAvpn3tLAA0ChgLg+kYpkjE4Nad04+x8Yv9s+cQzOpX23SuVlLbwHZ+H1e6HRvBpbYyM
         wVu4JMQHEXYBlcDrPk11RIKqMsQhBbrOqNTZHzRMYCl+xoX5QZQaRkY6wYQ7kZc6VKz1
         XGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787346695; x=1787951495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cseIckdQQAKYtcHlbi/8vX8CHGe20BNek8ocdDs8KAE=;
        b=I5uNtp5YJH0YXb2fh09ZQ+1umQ2vxAKCS4b4uqdrWCQ2Vr/R85lcg8t6I2xtkTICsy
         yKZOYSd1aH1kkK1+XcLweQ01xw5MpWfzUr1SzG9W2lntSWAaWtJ+/eP6Zc5S1lBe5z2G
         AL+ms3tPFvqJtlQsNTCr3xc7PU0RZgUccOiC0OtcuMLY462SYQKCLSFrrnTiH7Ilhn23
         rhqBEgxh49lvcpJN9tbd1poYjaELrX2TpQQ+CihZ2/dU1btOakcIEl4QV3vRqvMTa/b1
         gM2qC8eOoNMO2aCn7YNR2jxaDU5rT6nECcmd7df5kk/QIAsaJbl82glK8ycquieUqRk0
         yNyw==
X-Gm-Message-State: AFuF++mxr2JE5HDowzCH4DsjufeHWC6v5PYpocFp8gBXh7mNg5ANCE4Z
	cfBc7hSqtKy/d9hmZhv0S6nl9d1SdFT+ce9qzIpBkG/Jr0kqTJifearq
X-Gm-Gg: AR+sD10i2sybEtusIynJUtsnO7Fot4GrAxC+P298MMYCiYIhtlkqN578r4OkSy4LgdU
	cWMEk/DQyCbJJ5QxakMZEtPKax5Y2+s+3pdrmH0bFXxU4pojuk/cIx+hR/ZUKzhbn9g3mxt4YDY
	BkGVMedQ5Xhl0vVKHGumd00sFFR0OE5eoQqnHUiQfe1tP8OdTJ/CsaZ1DjlU/jLXQ6Ayz44INAE
	G6MvM2AwiaZWyYYxfVeD5DT54Nlp+YT4DAx0X3m7fc3xHzQdTd9JI9cjNACKUaEyYXiXPvy0KoT
	T3cFFo53hrJ/w0tB1e8gn/xB0Uv4X6KK+o9Mqmut9ooQSHF2XkaDVPCEvKUQaahADeXtnBgU9AZ
	wzakMq46SoNWfkw9wvh2INQTVIZGccHdGHu/zPB4m4144ln59s9bvb09+z+7pRALmmDXoNGnrKp
	BPDJYMUVdXLAPPfmIu90rD7FkutFycYHj0IF4puV78a+gpmKq950oTa2vxkEwFtIiCFa4gy0DJF
	Px2Wdqp45mayWBKixLR5An7z6nttw9ROGsI9vOoasTmDLnouy+YFlmO7IoB1/Do3eA371eaGryL
	1rlfJ7o=
X-Received: by 2002:a17:90b:1d49:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-395c3566ba6mr18408601a91.6.1787346694873;
        Fri, 21 Aug 2026 14:11:34 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:194c:dba4:ea1e:d7d1:affe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf175399sm49755257eec.26.2026.08.21.14.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 14:11:34 -0700 (PDT)
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
Subject: [PATCH v6 07/17] rtc: rzn1: Fix malformed MODULE_AUTHOR string
Date: Fri, 21 Aug 2026 22:10:22 +0100
Message-ID: <20260821211032.13554-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Fix a malformed MODULE_AUTHOR macro in the rtc-rzn1 driver where a missing
closing angle bracket on the second author entry creates an invalid format.
Correct it to the standard "Name <email>" format.

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
- No changes.

v2->v3:
- No changes.

v1->v2:
- Added Reviewed-by tags.
---
 drivers/rtc/rtc-rzn1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 42e57bf0b4aa..12c52003a7dc 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -525,6 +525,6 @@ static struct platform_driver rzn1_rtc_driver = {
 module_platform_driver(rzn1_rtc_driver);
 
 MODULE_AUTHOR("Michel Pollet <buserror@gmail.com>");
-MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com");
+MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com>");
 MODULE_DESCRIPTION("RZ/N1 RTC driver");
 MODULE_LICENSE("GPL");
-- 
2.43.0

