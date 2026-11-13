Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794609222;
	b=cMBi1A7/QzLBoQTX2MIX842LykELZ5ae9rT1i3NxLnnwFyW2jncFuI6+Qxmcnc9hX4DS
	 /GnmZhX4hivnO6seb2Azz4YS+5ivTDSiD5xDIAj2AKTBDC9zP2evgLDE7f1ndUtupRasV
	 mV3FaCKBMBERPTbAJNMqcpVDe5MDCQXqgUYybE3bPMFwjKdWaSHWVZ4RqmkQOkSVkgou+
	 RrQc/je/1xd1k422I/H83q1g5yNau3wr+9tPppVUUd9/IoKl0Yz/kBuqTP97GwpWV2f68
	 YxtePgjX3F6NXzl+0EX6QzWcj7X5EttQrTBQRzISLxcxP6px920HgABD/Qqo6A+wVPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609222;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CAFByr2n00H9cjNvqOJZ3pMec76bQwORRhdn9gRTjKE=;
	b=agvDi+UczV+1wJc6Hp/oxNowES5bFRcKriAEayDyoaLm47S9wr/jdwg4MslLhIyjKeH5
	 oSda1DjQoauBDg7nt6Hd9wl7tShS7QaU8NngtGLrnYJQbyG5CryAoBpOAcJRPpRMX4uVC
	 0juGdiNVXkqqvb3uHWLzknN9g8zvP/35i2woHgTZYbABsB8GUxOc4Ht3zdr9TinnHOFTI
	 y5hwty9a5j8bJxvpzoYczaJalZh9rvr36rB2W4LMxQaB5gEXinLqCCY5Ocj4Xq6QEOvjg
	 zeMfGtTCdEWD5CE6vq0upBL8VlA3tnpdAdCsWQBknaDm89j9iR1eACiqkIqv0oK91xA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GgBd5sd6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6037606AF0A;
	Fri, 13 Nov 2026 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GgBd5sd6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794609222;
	b=Ai4ThK1bpwD9ZB8Fa3BzV7K90L7VWI8BfdH3Apv8ipz8UhZ0EgiHRxIB6nNbhTiUMrEK
	 2tFFnsJCuwMZ/jQltYwtl/IbAdv8a/dTnUfEXUFFoGynyzBvb0aftDYh22zAG6vLmgkhy
	 ZqujVjVVnzhL6ukmnnRsWeY5ZT5IHE3iW6dDF6wPUErVTN4zhmsORnDkEy7vpB2VnYMMc
	 ynI90C3T6RlpAMNDqXsIhjQqokJk+YNbVUP4HZOLE4QXo17y/6d3Wcrm8M4Zgw8obSZAl
	 P/2z2yWCoQ41QFIxsyK3aPjscmcTvRKr6QiWqNYTWVmDfAOrFE/9MEg0hpnObJ/Fqaw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794609222;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CAFByr2n00H9cjNvqOJZ3pMec76bQwORRhdn9gRTjKE=;
	b=e9zGbSVv5EqKimZ6BIM79T0Us6/mB4ifnUooHE308wE2xZpQkEaPQrJTyy2+x412lXIF
	 RdOi0v4URkmqrriU9woyjlJ1CGS9lz5S617P6mt7pGrU85RTbMSwLIRjebU0AnVWQjY1I
	 miUBFXQIXwIb7/i4071KArJZtYEdojIjNEe079RJJH6WR2UI0KbpHje/acS5zJ8FscR8P
	 NUpkjnioYWjhVBEmgWv0G06U/0YzCjEAgHuXe1MaK/o0U1C1nLxIrQehiUpDhaNusnblX
	 VjmRC+h3Noytutz3ccVj5E4UEE7HWj8w8HGsl2cZIE33VXPeL9qeGOqtplhS/R6GzYw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3D54D1F000D4;
	Fri, 13 Nov 2026 22:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609222;
	bh=CAFByr2n00H9cjNvqOJZ3pMec76bQwORRhdn9gRTjKE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GgBd5sd6yCT6XYKUFyZ87x2EAwlGn94mo5diQzJabbmBlWv5b3Ew37mukz50amV6p
	 3JRbZr2FJPMF8glmOPUJPk68IcaBlLCRed8JIt7dd0Ma4MSlwVqmYWw/QEseHiFqOc
	 yrz3Vuql5Zb9Gkw7nwXVc57rp0LGsNoI3hzPu7g/rA/pcAZl9YLUww8QzvEu7CUFrW
	 gqUzcdymTeH52mDEmMZzV5/IoCGZGaBtwLEWoRN04k7nGYmF08BHQRTxUUL+rfWAqk
	 R/uDozwsk6yZFQgMiriJQt8+cmlX4aqxH2xqxnc/XLRHEiU2q8HfhgEfomS1332kzG
	 5CdWJfEGPTZsw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0956249B96;
	Fri, 13 Nov 2026 22:33:34 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Sat, 14 Nov 2026 06:33:43 +0800
Subject: [PATCH 17/19] dt-bindings: riscv: sunxi: add the YuzukiHD Avaota
 F2
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
Message-Id: <20261114-v861-v1-17-eb71ec3ee523@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794609209; l=831;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=ooczlTdXN+mxwhOn3DrrtrOaDvXXu8uSmXOercqvMcg=;
 b=R/PxCFRHwUc43McpjXcMGYT1yN8X25eLXw30rD02e5LKxSZr/Gn1YD5tqkBM3/MPA5VI4neiy
 /0dXCag8VjGCzSDkaC2auQA85V+nRQZqYS0WqWgn0TPWr5Ys0vGbcPq
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

Document the YuzukiHD Avaota F2 board, which is based on the Allwinner
V861 SoC.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 Documentation/devicetree/bindings/riscv/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/sunxi.yaml b/Documentation/devicetree/bindings/riscv/sunxi.yaml
index b36e313e13a6..9e993a5752e4 100644
--- a/Documentation/devicetree/bindings/riscv/sunxi.yaml
+++ b/Documentation/devicetree/bindings/riscv/sunxi.yaml
@@ -69,6 +69,11 @@ properties:
           - const: widora,mangopi-mq-r-f133
           - const: allwinner,sun20i-d1s
 
+      - description: YuzukiHD Avaota F2
+        items:
+          - const: yuzukihd,avaota-f2
+          - const: allwinner,sun252i-v861
+
 additionalProperties: true
 
 ...

-- 
2.55.0


