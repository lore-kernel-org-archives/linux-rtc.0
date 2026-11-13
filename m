Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794609224;
	b=xEnRy6DWl5cPu/h1v6ch4dcJn+2QgLfBV/8GuC4ELzumqPh1yHtcc7DNoI6lHjR6xfWa
	 gLLIPrZBvYGq0rdsGJSpyN92XvcOl5gd5A+llNB9qsXA/RdAYP6jAEp6DVdMiX7n6b9P4
	 W1y+mnGoL1J6ppf7xfCQoaEkLE4Er3WMphlDpFZf4uGyeO3cWLrrYs7xnEdNy4rgSTfzs
	 M2T3n/kw/rNwfz8bhZvPquRcV7R3G2m83ab2VdiJ1iv7eOUsuPRyLbQnkRYeho35YediF
	 ICU/nKsVXI27KZCT4h8va9Rvp89w1innQRCoTFBTfX1Amy6KF20vpnYZouGVvdkDuwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609224;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ymDT2ywdHkV5IDBLyNBgFqkWVxAvYgd6Yg9frSGix/8=;
	b=EpWu+Ve9o51C3EmcLYqvK5IEC47JMi7aTZXehzoxsbOVn57bhOW556fcz6QeCHAYHpvS
	 XO1v6K/BT9fZwM33yJ2LuCppI2erhtZeoCrzV0R+e/Pk28I1CV451w0OTLGgU3vILBolQ
	 AbW/SAitO69BnB9TsHbkgPlGt8iUZS2mmkAPdkIaHXfsXZ4TaDNTXD8tX88gsDCXixPs0
	 Kx/aaFAwwV+GmuFz3O682A2smRDz48C9itQvptnM7N508zBTMB33ckA52U2dlU8I8U2nN
	 38dpwemWj/ozCYR4X/ku3ZZVn9rbpZnJR+10vRJnoGAh1IIzYYCmyxOR/rJJR4oJ4jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MMU/ZoQ4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD0E606B781;
	Fri, 13 Nov 2026 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMU/ZoQ4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794609223;
	b=jpYzcFJTFpiAeRDkzmdIlnLc0B0IVOciXmjW+8jX4jKeDF8JrfXuKbmhtm5B+Ax3q5Hz
	 0cmjO8IwyVFp0mEazchU0U1PfZWekiyMzfu5xRo5MLY3rgLGVTNY0UOZ5LQbENA7713OA
	 XZoyvnktsoOlS4vQdGAYajsRR21WVX+vNhidXrZrVj4iseZeZWrMrLdVb5pRTByvgvy+v
	 8cK5jNiBg2NK3PpggPmAvvjmIBgnXVxqDJFWtQk1r3FbV39SQjF03eGMCp1PJKKi4MSed
	 gjf+NwPA3x83I3o8NeZD6aFjkkWQ4oB0BhUegAPms6KtEWsVpWb9ALNwKK9JwtD9PxQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794609223;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ymDT2ywdHkV5IDBLyNBgFqkWVxAvYgd6Yg9frSGix/8=;
	b=UUX8Uoxctoimqn9KsvHk59xDPxJ4H0ZnBFrYoh3/mBCJPHCCcNf08wye9lSsl/xpQpHf
	 JOyCha8QeRCmxiZ5z00895xBuveO7+H1TRLuNLtdslqwpzWWxQUpS0sLilBz6Q6QcPCy/
	 P7ibDHwKzMZ8TB3diX187XyLjxY62zXgxnqPNeZO6JTVXN9oy4BiCvd1KzMqmCGO21l21
	 +7EsGgZ3bXucdTQfe17NLnOe66d6G+u0Fw+hnMBWzit+rsOMBR82aaQwp8MzKHtoJCEbn
	 SV+tIM4gBCoDBP7WJJHIiGKWZKUm2afMn5Ln+qw04cC+nFEE/O//ixjm4kXephw/uDw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CEA591F000C8;
	Fri, 13 Nov 2026 22:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609223;
	bh=ymDT2ywdHkV5IDBLyNBgFqkWVxAvYgd6Yg9frSGix/8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MMU/ZoQ4WLwPRw3M/jWKurzZmRCAmq+WujA+uyjmjlqLsWHNl2R9s8+C9zbb7s8Ij
	 JW4/keGTzGMNul5uYCdiGDQrhoCfkLTTnA4D6ci1PeTKaUt43RBHbyBOQMUuLqTygM
	 hH6N4g16N0Ey26N3jLEtQ+J2XEVQzE6AvZ8tIEfsk80J8EBLqLfYDc6qIpe6d/QbFs
	 DwXbacyQYVHmeqSkCstJgP9akCSH/TiTHw9Z2daxvkGnKE+hSUfiSjbPdF13vQqT13
	 xaFrOjYtoGGJVgYJF9SZe5kuBhyu3IXGM8zRMs9m4U0trTBZypiwe9RnIOq9Wc5Qnh
	 yo4SMmuaxrIWQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D34D749B8F;
	Fri, 13 Nov 2026 22:33:33 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Sat, 14 Nov 2026 06:33:41 +0800
Subject: [PATCH 15/19] pinctrl: sunxi: add support for the Allwinner V861
 R-PIO
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
Message-Id: <20261114-v861-v1-15-eb71ec3ee523@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794609209; l=3471;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=7xONjG+lp46a2hTV2q5H0YzzfrAGY6ULMHzpssbSP/k=;
 b=/oFgWs5YN9Op9atdNmxvGndgT/Pdy+xc5IyN8DLmLOkLQ4P2/EExPX6dzuj9XgE8LlgdjUcK8
 leKgDoRdJmDCL2FkiNczbYcllswSsNf8Mr4q1HKTVAWfI8lYvws8gnd
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

Add the V861 always-on pin controller driver, using the DT based
function tables. The manual calls it RTC_GPIO.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 drivers/pinctrl/sunxi/Kconfig                  | 10 ++++++
 drivers/pinctrl/sunxi/Makefile                 |  1 +
 drivers/pinctrl/sunxi/pinctrl-sun252i-v861-r.c | 48 ++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 2d5ace1e5f5f..80a53d3619d4 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -96,6 +96,16 @@ config PINCTRL_SUN252I_V861
 	  PA and PC to PH banks, and is required on boards based on this
 	  SoC.
 
+config PINCTRL_SUN252I_V861_R
+	bool "Support for the Allwinner V861 R-PIO"
+	default RISCV && ARCH_SUNXI
+	select PINCTRL_SUNXI
+	help
+	  Support for the always-on pin controller of the Allwinner V861
+	  SoC. It provides pin multiplexing, GPIOs and GPIO interrupts for
+	  the PL bank, and is required on boards based on this SoC.
+	  Say Y here if you are building a kernel for such a board.
+
 config PINCTRL_SUN50I_A64
 	bool "Support for the Allwinner A64 PIO"
 	default ARM64 && ARCH_SUNXI
diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index dc7559e260e1..f3e601f61ce3 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_PINCTRL_SUN8I_H3_R)	+= pinctrl-sun8i-h3-r.o
 obj-$(CONFIG_PINCTRL_SUN8I_V3S)		+= pinctrl-sun8i-v3s.o
 obj-$(CONFIG_PINCTRL_SUN20I_D1)		+= pinctrl-sun20i-d1.o
 obj-$(CONFIG_PINCTRL_SUN252I_V861)	+= pinctrl-sun252i-v861.o
+obj-$(CONFIG_PINCTRL_SUN252I_V861_R)	+= pinctrl-sun252i-v861-r.o
 obj-$(CONFIG_PINCTRL_SUN50I_H5)		+= pinctrl-sun50i-h5.o
 obj-$(CONFIG_PINCTRL_SUN50I_H6)		+= pinctrl-sun50i-h6.o
 obj-$(CONFIG_PINCTRL_SUN50I_H6_R)	+= pinctrl-sun50i-h6-r.o
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun252i-v861-r.c b/drivers/pinctrl/sunxi/pinctrl-sun252i-v861-r.c
new file mode 100644
index 000000000000..fef0ed2e2684
--- /dev/null
+++ b/drivers/pinctrl/sunxi/pinctrl-sun252i-v861-r.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Allwinner V861 SoC r-pinctrl driver.
+ *
+ * Copyright (c) 2026 Han Gao <gaohan@iscas.ac.cn>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include "pinctrl-sunxi.h"
+
+static const u8 v861_r_nr_bank_pins[SUNXI_PINCTRL_MAX_BANKS] =
+/*	  PL */
+	{  7 };
+
+static const u8 v861_r_irq_bank_muxes[SUNXI_PINCTRL_MAX_BANKS] =
+/*	  PL */
+	{ 14 };
+
+static struct sunxi_pinctrl_desc v861_r_pinctrl_data = {
+	.irq_banks = 1,
+	.irq_reg_base = 0x40,	/* PL_INT_CFG0 */
+	.pin_base = PL_BASE,
+};
+
+static int v861_r_pinctrl_probe(struct platform_device *pdev)
+{
+	return sunxi_pinctrl_dt_table_init(pdev, v861_r_nr_bank_pins,
+					   v861_r_irq_bank_muxes,
+					   &v861_r_pinctrl_data,
+					   SUNXI_PINCTRL_NCAT2_REG_LAYOUT);
+}
+
+static const struct of_device_id v861_r_pinctrl_match[] = {
+	{ .compatible = "allwinner,sun252i-v861-r-pinctrl", },
+	{}
+};
+
+static struct platform_driver v861_r_pinctrl_driver = {
+	.probe	= v861_r_pinctrl_probe,
+	.driver	= {
+		.name		= "sun252i-v861-r-pinctrl",
+		.of_match_table	= v861_r_pinctrl_match,
+	},
+};
+builtin_platform_driver(v861_r_pinctrl_driver);

-- 
2.55.0


