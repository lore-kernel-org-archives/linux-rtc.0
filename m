Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794609223;
	b=lLTBVcZKC3G7Bz+TafDvSQHMQGJ/s1mY1olqlB8jJkvMmL4V8aA70FUX9fetLm70YAtl
	 DjSgXQHZTUcdyuU4A/bWs9h7UlVVA9JNHU10rdL20RInLMW+lFaFjZGKalnXRUOaHZ2r/
	 PWJnA+xuM+mGmyXR+GSsQT1VmyT5QBJeI5JVagzynBYBVACqXG6iPOQRfXjGLcYoPPl0L
	 3xtbn9wbUpdB7OnC5M6tyETrIVhuGPHUsUEVMudWFDOzDHBcFKAZV0UTLubBYovnyu4Mg
	 pcupL/mfp02f8OUXBVrTCpuvNKmJ9MKpQM/BgXIFqRdw43+YWq2qHS5Mp+wG5FAuq9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609223;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pI6ZfHbfXlGGFScyQLy8hgCr3exLFr/2O4VJxzewZhw=;
	b=pbBEDuTqHfRYsksPI3GtHB4M5eWFjKXBM/xgl4siPV7tGVKhi5vTj24DuJUAqvOmPnkw
	 x6PlKbjHm0Q9A1+xU4VRxFXOzdxrmFqMcTx9/Zq4JU2avWCZJvSAq7pBOHGIuKjn6sMWX
	 tOVdMenjYhS55O06Fbbp3BLCMr16+NON2LSLV0WVxaPMVR/ewQnw3irmmQR/AfNKVLgF7
	 NFdsNB/k8UQ0fyfywQ3136bVVW4n+HB6ZxZCsntUo69MJRIax5qEHwIXPHuzwwVY0xtLN
	 7doPXbGpokMfFTJrvijzJR8WVlwHWnv4rSFqtEGDiXOjpsdAV+xTl/vz0RPnt+xtgFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BLIJ6EgY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C2A606AF19;
	Fri, 13 Nov 2026 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BLIJ6EgY
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794609222;
	b=kaXjjr7c8hHX5TeAMq9ys13wzq0mQCJOv6y6RDVzxL6rZSeSCsjR68GMA24Irt2yKoGr
	 iR8SxeeMNt7VLKv6xfuzn9gs/acF7vvQtvAnQrYGUNFyIo5PaG8leUuKxcmcsgv0s4Yk5
	 +K0rdMRpUoQnv8EpnWlL/zg/jeuXHDwM0kOGGuCYyiQ0NKryG4921wqmlNpGAH24N6OiF
	 RxaLZu1cO+fB4wBKX+NUTPwuu/0cIqaCCzrhV+MqMzwbarLpRz+8JdHREDAunuFIqnLcu
	 LZwsbZ/h0jYPBva+tzvwxNM5vDuDmBQgQlywGDJAS4AKV69zYej/lWo4OMTEhvaofRA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794609222;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pI6ZfHbfXlGGFScyQLy8hgCr3exLFr/2O4VJxzewZhw=;
	b=HPwpk7BbrpMbCnvAuxa9ifMIs7cSTevA+Yy4h4Wog0xvYYDhJU5xBRplddVnFfnrmYeG
	 3JPTehvdiOdNYBjbBUUZtIvCC8g2ym6TFfaBm2DVQQ3BFhjKRbZnzOepsB33a5EAhqcbA
	 l99VR9SVTI8//KbcawpR5PyMX9+K3lPaVadWW9OeOoBYHzB2Vy77TlF6FGn6Pl3UjtThW
	 ppHJrbOuZ0L+mzUPLutiYKr8oJuRQGAGfDPeWBjFjqJkxI8pcQnfvqQqnWcrTAcrPgZec
	 xBI2S7iMVmF3aKvHR4G1WR/eVek4q4Dv6quuGSPmWvGT1RPKLUn4peCaHwq0ZLwnO0w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7303E1F01576;
	Fri, 13 Nov 2026 22:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609222;
	bh=pI6ZfHbfXlGGFScyQLy8hgCr3exLFr/2O4VJxzewZhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BLIJ6EgYlJERejEFQdXWkCuzqJieqRcDghDv5jM+s7NQ4waw6OLKpGZ/naoPl1NAF
	 RqdcwbBBtutjmu+B21Jfeg/aoExM7sO/W1ePJrw1wgukfgvVI4w/N6Mwaficckjn1z
	 7NCuFhJLl4y/xvAdrSdQUFEzeYBNy5LUqGtZXi8wxQQuV9Kq1OTP4cGiLynKqyTFAV
	 zzzicTeuYSW6ifF+1P0FXyRiVVlHOC7FIuQqF1ITfcYFh/iZorT2rilwfsF7vYYTHO
	 KmOdTLDrHitS1yz3XhyAfXxs3vIzx6FfGZVE7H9hVadS1KXJ9hJkaY+NjoRGUphdve
	 elVdkckgPX3Vg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3345549B9E;
	Fri, 13 Nov 2026 22:33:34 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Sat, 14 Nov 2026 06:33:45 +0800
Subject: [PATCH 19/19] MAINTAINERS: add an entry for the Allwinner V861 SoC
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
Message-Id: <20261114-v861-v1-19-eb71ec3ee523@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794609209; l=1064;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=39Ac8hJzpCiQ7XryhT1eADd1ddcM2ysT57oAlX6+9R8=;
 b=yImKJfL/SM0iJ5gXSR0G3a7zEwdVCFqOgmcRGrK1c0Yxaoy5YXunPhnCNkpFmotpUgaYwGgLk
 8PkUGkVB3+cATxKHXuU20wzYPDweSAZ53K3Q6ECQOIXJmC3LIl6Sb42
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

Add myself as maintainer for the V861 bindings, clock and pin control
drivers and device trees.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..dfc300dc1eb2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24031,6 +24031,18 @@ F:	drivers/irqchip/irq-riscv-intc.c
 F:	include/linux/irqchip/riscv-aplic.h
 F:	include/linux/irqchip/riscv-imsic.h
 
+RISC-V ALLWINNER V861 SoC SUPPORT
+M:	Han Gao <gaohan@iscas.ac.cn>
+L:	linux-riscv@lists.infradead.org
+L:	linux-sunxi@lists.linux.dev
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/allwinner,sun252i-v861-ccu.yaml
+F:	arch/riscv/boot/dts/allwinner/sun252i-v861*
+F:	drivers/clk/sunxi-ng/ccu-sun252i-v861*.c
+F:	drivers/pinctrl/sunxi/pinctrl-sun252i-v861*.c
+F:	include/dt-bindings/clock/sun252i-v861*.h
+F:	include/dt-bindings/reset/sun252i-v861*.h
+
 RISC-V ANDES SoC Support
 M:	Ben Zong-You Xie <ben717@andestech.com>
 S:	Maintained

-- 
2.55.0


