Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794609214;
	b=SFgrQN8DknnmdLxHPdghslYeaPHne7dEhb2Oip0zZE7K+8ZTT030rF8+eOEk2ZuYR54I
	 j01C7iLSRnHta9J3HZR7jEOuvNHIePmZq4bfQy1PDn9xViXwPYQwQOiFMD5v3b/ZOibt3
	 DN7QTLMYwtKNXhkN1+t6hFuAsxFzWY+gF9wJAn3aIZdz/l7XFMOf9TRuFF7NYdHjpj7Lu
	 hOjqgukh5SIoWNWK15f+LKkQtfTEqtw+NMZ4gxxCS9lGd5RtOmu5UHDbxoJoH0MmVmEwK
	 5dgfcHglpg4TC5cdHTiFB0+vYqSozFOpgPQllAmVwFmPfLW7xudGLuKG+jr+D8DALqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609214;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HyiTVbeXPQu8fkPfhfD3gHjXLJEZSVzM7qOeO91NGRg=;
	b=ko5hGJ61DsjZ77irB5L/IeGWmi6m6wus3oYCu4Dh6lWouwMl/PaxzRzKg7TbjEUy77fc
	 ZrnKqMnTiUOQktp/Zxmf1hI4XmF6/LUPRqzHXw8EcrDi/ulG4W/7x8eTmKa/n/SY+czhK
	 MrKIS7g6KOM3qgwOG0vta+613riN3M/TcBt7KT3vnzG/R2DuLkiktjRVPhk+L++T67aQE
	 xfY2EKdkLIlMbSixuC9q59IgmgjnEqGOEiglCrkcfC0HMhTwvgr90HIICmsVreA2OUoEv
	 l8SYPesk69K0jGIGxvdpLSijN7hk2x/zCBeUZyvZfNzQsQSNpaq8WYnT+AqmAIl6iLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtZMtRuy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5262C606A883;
	Fri, 13 Nov 2026 22:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtZMtRuy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794609213;
	b=rx6seLmVjtfP07fRicajwW4gcx5wTTRbDzYT/2gEVSZRGbyPFLYvc4JlMdzz9wPMVm1a
	 o4Wuma0RFECZuk23+K6yj7gf8Gz4WLeCKlH9CFfJRe/GPpNr7vJAr2eg1TMTpEDUpRwtP
	 Za15H9KpVjHzMgQf/1l1/k7d+3haLKmyom/SUlFVrTA2UVxDndp5dK0N95zUePAVTdB/S
	 V1VBxMJkp8/OknttbjsfI6FY2z2RxQXnPDWU95byeomE+1lRfskkZn5dAWF4SYPIJ77Zg
	 0Vx41wCqd0Q+oY5pTh1jUq4nKJ6Q2NJDfYwYRZyIFRbk9Opx9y7y/aqdldWRRIir2Mw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794609213;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HyiTVbeXPQu8fkPfhfD3gHjXLJEZSVzM7qOeO91NGRg=;
	b=VWI/WkEdcF2Xlv6G3k41B0/FezxAS/CfJTmpL2XNORrf1xYrtNvDP1vaZnlCf1iqvuKY
	 scjDd2YAE39vLXSGev5jkdeMhGTU7sQvOTxr6OgIFyJV+vO4L5PBb7s2Ly8ozZVSDcYlO
	 otUPDdpbO8cuphtgIPD9st5EG0kcXb3XghlZ6Mc0FpjXYjXMzOFS69zUeCsL+yFZHpvo2
	 mes6Lea+P/yUQT5WV4GlpqlTenXCVCLSQArjsIoo+Bf1J67BEdQUMhug6NZwxixaHzrhu
	 IIgylUwAxaEqud62qoLY5JfYgGpECXS3FlMHizW6NqYEQwSDENqmBfSs2Z+SFxiCReQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 314461F000C4;
	Fri, 13 Nov 2026 22:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609213;
	bh=HyiTVbeXPQu8fkPfhfD3gHjXLJEZSVzM7qOeO91NGRg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UtZMtRuy2RreIXnt6Vk6e1sTpBtQ42hqFvY/BLiBEfGCx4AjqmVAkYmV1ALjqjy9F
	 VGgIrQa6TV9iILRc4ZtrjGqseyIhml3nkASLmeYP36fJvdWR9LL9EBW+VzRgV3yO3x
	 jq2yE/dyD/YyOHwxa4uhfZ4X1693xNj+zD3+JrYHaY1Fm8ztHfdJ8/60mc6XnXjYCu
	 K0aeGfZZd7k9Qbb2illPSJSUWJ5vfFBIl6K07SLfMHdo1VKv17IiphIZoIWI+kxZK3
	 8UlXv/aS3/U+0yePxo51ddZFjPOJPCuM4iGO8axqUf3gSXu9ph6wYw8O7tc5eDeV7I
	 wK9bQSwv3aBVA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9E3E349B58;
	Fri, 13 Nov 2026 22:33:32 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Sat, 14 Nov 2026 06:33:27 +0800
Subject: [PATCH 01/19] riscv: sunxi: describe the wider Allwinner SoC
 family
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261114-v861-v1-1-eb71ec3ee523@iscas.ac.cn>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
In-Reply-To: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Han Gao <gaohan@iscas.ac.cn>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Maxime Ripard <mripard@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>
Cc: Han Gao <rabenda.cn@gmail.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 devicetree@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 linux-gpio@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794609209; l=987;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=iIMXHW4ncH9rYCfV6gqeS1VFiDJbleuDtC++QacYRuM=;
 b=1qagKD3rCKA24HqW1EY7WOksbBJolj6tNk+/fSKplFvFfQFmuICjc/3HRPonNK6YXjTtHCQMd
 k+l2SiI9Az4DbHj5RDb1WJdE+MlgzAKOR89f9hwcRwjPTczallY0Cjt
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

ARCH_SUNXI is about to cover the V861 as well. Update its prompt and
help text instead of adding another option.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 arch/riscv/Kconfig.socs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index cecbce0c4983..4cf3b24467e8 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -61,13 +61,13 @@ config SOC_STARFIVE
 	  This enables support for StarFive SoC platform hardware.
 
 config ARCH_SUNXI
-	bool "Allwinner sun20i SoCs"
+	bool "Allwinner SoCs"
 	depends on MMU
 	select ERRATA_THEAD
 	select SUN4I_TIMER
 	help
-	  This enables support for Allwinner sun20i platform hardware,
-	  including boards based on the D1 and D1s SoCs.
+	  This enables support for Allwinner SoC platform hardware,
+	  including boards based on the D1, D1s and V861 SoCs.
 
 config ARCH_TENSTORRENT
 	bool "Tenstorrent SoCs"

-- 
2.55.0


