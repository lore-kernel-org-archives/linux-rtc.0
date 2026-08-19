Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E06D3DDB1E
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136079; cv=none; b=UccfsLTsl2oo2+rH7qbJWHhbN+5MGyuIPFlWdjFQdKN5IQKparsjRU2E3JienEABPc7K7IozGc5/za87kHgrQPyn/7GZ4TI/KpAnsu8YpD3QQrpthbQnuSYlHhAab25z5lwCvXBdkiQ98zPNZphtWH7P8WK0pV10L2hjGGx7Tqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136079; c=relaxed/simple;
	bh=QvmAY2zQ/bnEha1G+lZ6sMfuqhFsDr9MAHAlO2Gs0Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0/oMD/tbDsZOWlTxcuFj9EeQTiFDQeHX5pjNjU6o9lYPJ3F+5nI1cTWAh1TIQkcO2my8QwVI2/PO2HdfUbYCcssUhzFc9YGRFgnqL/sVV0XJOS7h7wcK9QhRdSLa4ZBE+yVe81H6gKGwEzU70aXxOmevPjZT6cGgUr3NvpcgNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgOUvVsH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgOUvVsH"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d58efc7356so9202895ad.1
        for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 03:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787136077; x=1787740877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ugIT9VUnw0CMyTauhyEPxNk/2S/UCQe05/BRnC/Umfg=;
        b=jgOUvVsHjf147ud0cI9pnavGAeL1on78R8Pt/BCpSN5xakYZrqSpSEo7jk4TGTnCOw
         F6upehfW5yK82P4ODOLGdLLTcy79ZLfbuyHCCKQd3jfPVUd6QG/P6h9TxDjtPYl4gLRv
         sQegHq79pfIXXQR5kihQRPcRIVDH7oqI43li+kZbM5APyhthF+/3xddtVNYg4jnR7Xlj
         zCA2G3QiTgl/q3Ng3zg7MrFatuLoKIxMpQ0jXo7Qbz8JNV2zYlIOVkmZ/dNSv+SV4z8K
         I8cUV8lC1eaZnn8snmOh7uvyvfXVH3/uBh+Y1WtjaUz7gzA/gSfkmtVurWTC+4igjKGm
         kGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787136077; x=1787740877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ugIT9VUnw0CMyTauhyEPxNk/2S/UCQe05/BRnC/Umfg=;
        b=BmVlA739nXcxCcZzPNnIocb04yOAIMaIC/JGTTatmFPB3M9iUkPIkLGZYucoSNVp8q
         h1b09RgtgLf75RcFFYPk2e/JEwNFftxCiVDCHDxDqs/aJQBygJnhIiZPEsaOhdqJIGjc
         Lz+7QxdxAjkjBbPE76bqbdpXsQD3ukPLQbETTubU7aLdffIskxA6ry32u/7lqcIjncBe
         mYBdx3xtw6nQz3cv4czv1TSqvOBvQT03kI5OSZltaRgNEoVpbzw7WTvGVx6o1ui/kXye
         biIgRM+/Dh43gS28B95xOjbKfag5Ek9Sm+ub8+h05a7vmb8/+3JLiEk0LJSrXwDaQb1J
         NXJw==
X-Gm-Message-State: AFuF++nVImBGVGRJtUcOXMgKzAshCaGE9YEP3Gyv2yJsPCNKo1GTgxAw
	jcYn+yIrSf8rK3qyQFsJvTN8SuaNICkNIQ8tc+YdQUrVY+wdTKUAVO8ZPY8HFOjV
X-Gm-Gg: AR+sD13mzeB1KUrD95nc7bOakSmL/TIzuRB9sJ0YnI7Br/zBrqSPri2kqfxIMeA/UK7
	ePOPvPvKWHwh4aq554HPFo2SOxs0uQfTPPeKcznD72wJfiwrHUo0exnWqHFHub/JlwS0Ad5QVV2
	6NtsurKFixy3l5ttUya0bzsMsnp9ro7okSVX/FEDU7yORTbrc8SMxjUJgYppWklYB8xgieiAciz
	3dSmIX0+l7uvWQhcYQfyuNfrKY7QE8Prxbj2fsBmHbVCR+deD1oghOwldWfknt6VBnZzTxFss7b
	bIg1qRFiZHsCZJt/Qj17ot96MmYOHTa7n5b0mwbjbTL76AX9XXh7TwYK/ORnP5y1Vm5jBkjL0ih
	61mGW/aZma0ecg9Taq7EzrEE3CxLTJ8IFfuKEHI+xH3upMvJsI0UxzbM5GOBJPB/OCawIIKbNtW
	tEIl26XH8ojL/v+zpdlnN7xJu7tokc+APa1GFbN+wn64khzwRA+tZwGQOe13lmRMZoLgiiojjVD
	j3+Vdn9bkap2omtxsm9K0L+3FjG9ib78+aAXb9iBLl3EKf/Wv89vIT6yhO19jbM0Cwy14LKjYl1
	mh5iKs4v9A==
X-Received: by 2002:a17:90b:2c8f:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-39580f119d1mr7016222a91.8.1787136077359;
        Wed, 19 Aug 2026 03:41:17 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c07:efb3:a897:a9b5:e171:c935])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef77fc0sm11169630eec.8.2026.08.19.03.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:41:16 -0700 (PDT)
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
Subject: [PATCH v4 14/15] rtc: rzn1: Drop trailing comma from OF match table sentinel
Date: Wed, 19 Aug 2026 11:39:25 +0100
Message-ID: <20260819103926.2136712-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Drop the trailing comma from the final empty entry in the RZN1 RTC OF
match table and mark it explicitly as the sentinel.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
- New patch
---
 drivers/rtc/rtc-rzn1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 202840eb86a6..6097563c5f13 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -514,7 +514,7 @@ static const struct rzn1_rtc_data rzn1_data = {
 
 static const struct of_device_id rzn1_rtc_of_match[] = {
 	{ .compatible	= "renesas,rzn1-rtc", .data = &rzn1_data },
-	{},
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzn1_rtc_of_match);
 
-- 
2.43.0

