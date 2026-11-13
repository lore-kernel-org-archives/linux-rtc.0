Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794609220;
	b=5rXw3qpgvNhDDSWTLGHeSQ748S7IRaNuebwA+PvLhPDrc/aofZhAR7lZYu67r8oW455q
	 QqfJDAZfTP/eTCr6QVYBYTVLdqLgBmYmcGjp5a5+0YOsxukufKpOfka2GhIlgx4s1tDfP
	 P/AHmQTa2dC/EwBnUCvhYnxRcvuIaa6c5duDRKtiMFIKnyZ0/D0whApAIDk6XE2UjTiM3
	 kFptgKVU55++zfr4F4dYs3vLIiU0dnRIra+YYIxzmmiYxMRVHsB9O6yayfgRKZqDZy9qM
	 eGdVSGAP7x5eFxhZd3xFxDs0sVg1L9jwK8SP5MAawA8jRj0rPPSrT8u6l0wZDX2vyOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609220;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uCSBQsnFH1v0qJqLur3HuSvJBaK4cr2cKSQjBjx2zgs=;
	b=1kgZn9NzVWWbcfV7dk1XMTfsUdCoSHtU2xZqxu7HLAvUxHMcxhNp4BqCjlDPAwulXvXK
	 sisLoPNdlkmlFv7rfGxM7TirXVz05WCZMmwe4+rYWzUpET59IDX1OaWugD/iQUisYuGSY
	 Us8KcodFk5NEJpqK6cZ0imEtEZp4KZR3muUw8A+8qymuAK6pmHsXhu6VQvJVpUHn+iK14
	 0gD9XKo/4LdSzJR8/XQ6wbJIMEk4PBVy4WimYCFn503BzL3BnDLmIysnQFyW3ZEIEI0/f
	 U1bmCubHXb6qPa4CUK2fXuuGryk7vjAfe70H750H2RTj344qLnyKPo82xdlCdktRVlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ISGi70qh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3DB60A5BD0;
	Fri, 13 Nov 2026 22:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ISGi70qh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794609220;
	b=UrDpaTKoAeL32rogoy7KmjT87zEMbdIBFUi8Yqskg6PLc7LFDr/Krw62oWfwlUKO5zx2
	 OZmHbAUdq4OMuIgr1DKvan1aOxG6cDcUzi1Dwi8qWWYjfXpftheBHW68L81baZspk7n6b
	 5gL9rvROvTzL334uhWZPHg7SL7gm/lSRG8sKqL7Jh5vQyy3e1Ve2PSy5KR3imaO/bncFL
	 st3F8JbsDP6Pha4XqWVqKtiK55VnkY61wUZRpBdGxED2tZnZB0NQdUXE0TgChkW1ner42
	 /87zEcxJ2X6Mti+lxfY4iJJvsKsbPEzYEdYvdl4B0pnET7wsBHxe7MPm9Um3LgbvKWg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794609220;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uCSBQsnFH1v0qJqLur3HuSvJBaK4cr2cKSQjBjx2zgs=;
	b=Y00WgXSs2lycL4GCl9Lu42iSpguhWJbdbbfIQqrQQGLUoq0oEd0b8N2cre9CHj1pRi0Q
	 JGf1gLrIqNNZuWqHZ8Zu+Sgc8C0YdkoY9YAnv+7YoSyXoGF/eFsW6KL2iMgevqmkHgffT
	 Fvv7S/WlRJV6ES57gm1rjGsP9djDokGGr5vlPEDJ403CZ9i6gwpH2NMu1swasADhh3dY2
	 smwBoDYmBwROuIgWZxR/NgIJSJrPzrjONDY539q+BJEymzloIVY7vNfz8oLNsB9OhYdwU
	 PMzoSyuk+TfmK6G1mGhY7h4YgtZ+rPWfToW53jywtMdeL5mkZLm+arl0MoY5eEZugoQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E0D3E1F00937;
	Fri, 13 Nov 2026 22:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609220;
	bh=uCSBQsnFH1v0qJqLur3HuSvJBaK4cr2cKSQjBjx2zgs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ISGi70qhfAp3wCAhR/HLl33dPfOjD30lG6Awl/KjDKfO7VppU3ysQIY/QCpEMM0IP
	 /v4vlno1rqjj+nWtkK3JMXh/cGWTvR3JjsQnmB4C7MY9vtZnazCUrm2TjkGAHKvLKn
	 UJk0Xv7I5GyyE/b4tUiSpYQU0xe/7BbJ64bUsVEpmdTVkIYkNwjvHksc0gGFuw0rXP
	 R3BKrdf6m3OjAlBkaDMdWrbfhmbyrDwJqfxBO+o7Yg9+H30Z0+BX24XiRCz1u66JDl
	 3yEFLXZHiMnLE++W1cwkzYDCyfmXSh6P6ahPEtXDoPCqM1u2prMkZYuubRv9/o3DAP
	 6ifwM67qtqYmQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BEF0C49B8C;
	Fri, 13 Nov 2026 22:33:33 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Sat, 14 Nov 2026 06:33:40 +0800
Subject: [PATCH 14/19] pinctrl: sunxi: add support for the Allwinner V861
 PIO
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
Message-Id: <20261114-v861-v1-14-eb71ec3ee523@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794609209; l=3631;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=dyHeGHv1zlRbsyWinbBdGwEJ5XkzCvJf3cZN/GfUYvk=;
 b=HNsKo9qWkRP5dIQtqxM+VpZT7emu0epD/ZwzOK2CDJX/49+eucj70g22c8PstYnuPDpuVLwW6
 C8J/jc4D4tYDvHgV0PCOxmlDH2E+Huq7coTiH6w6N1oXNtS4dDJKdH1
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

Add the V861 main pin controller driver, using the DT based function
tables.

The 1.8 V mode of bank PF is not supported, as none of the existing I/O
bias variants handles its control register.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 drivers/pinctrl/sunxi/Kconfig                | 10 ++++++
 drivers/pinctrl/sunxi/Makefile               |  1 +
 drivers/pinctrl/sunxi/pinctrl-sun252i-v861.c | 49 ++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 831bb1dc9373..2d5ace1e5f5f 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -86,6 +86,16 @@ config PINCTRL_SUN20I_D1
 	default MACH_SUN8I || (RISCV && ARCH_SUNXI)
 	select PINCTRL_SUNXI
 
+config PINCTRL_SUN252I_V861
+	bool "Support for the Allwinner V861 PIO"
+	default RISCV && ARCH_SUNXI
+	select PINCTRL_SUNXI
+	help
+	  Support for the main pin controller of the Allwinner V861 SoC.
+	  It provides pin multiplexing, GPIOs and GPIO interrupts for the
+	  PA and PC to PH banks, and is required on boards based on this
+	  SoC.
+
 config PINCTRL_SUN50I_A64
 	bool "Support for the Allwinner A64 PIO"
 	default ARM64 && ARCH_SUNXI
diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index 3658c9d06b49..dc7559e260e1 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_PINCTRL_SUN8I_H3)		+= pinctrl-sun8i-h3.o
 obj-$(CONFIG_PINCTRL_SUN8I_H3_R)	+= pinctrl-sun8i-h3-r.o
 obj-$(CONFIG_PINCTRL_SUN8I_V3S)		+= pinctrl-sun8i-v3s.o
 obj-$(CONFIG_PINCTRL_SUN20I_D1)		+= pinctrl-sun20i-d1.o
+obj-$(CONFIG_PINCTRL_SUN252I_V861)	+= pinctrl-sun252i-v861.o
 obj-$(CONFIG_PINCTRL_SUN50I_H5)		+= pinctrl-sun50i-h5.o
 obj-$(CONFIG_PINCTRL_SUN50I_H6)		+= pinctrl-sun50i-h6.o
 obj-$(CONFIG_PINCTRL_SUN50I_H6_R)	+= pinctrl-sun50i-h6-r.o
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun252i-v861.c b/drivers/pinctrl/sunxi/pinctrl-sun252i-v861.c
new file mode 100644
index 000000000000..742465076d86
--- /dev/null
+++ b/drivers/pinctrl/sunxi/pinctrl-sun252i-v861.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Allwinner V861 SoC pinctrl driver.
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
+static const u8 v861_nr_bank_pins[SUNXI_PINCTRL_MAX_BANKS] =
+/*	  PA  PB  PC  PD  PE  PF  PG  PH */
+	{ 22,  0, 12, 23, 18,  7,  8, 16 };
+
+static const unsigned int v861_irq_bank_map[] = { 0, 2, 3, 4, 5, 6, 7 };
+
+static const u8 v861_irq_bank_muxes[SUNXI_PINCTRL_MAX_BANKS] =
+/*	  PA  PB  PC  PD  PE  PF  PG  PH */
+	{ 14,  0, 14, 14, 14, 14, 14, 14 };
+
+static struct sunxi_pinctrl_desc v861_pinctrl_data = {
+	.irq_banks = ARRAY_SIZE(v861_irq_bank_map),
+	.irq_bank_map = v861_irq_bank_map,
+};
+
+static int v861_pinctrl_probe(struct platform_device *pdev)
+{
+	return sunxi_pinctrl_dt_table_init(pdev, v861_nr_bank_pins,
+					   v861_irq_bank_muxes,
+					   &v861_pinctrl_data,
+					   SUNXI_PINCTRL_NCAT2_REG_LAYOUT);
+}
+
+static const struct of_device_id v861_pinctrl_match[] = {
+	{ .compatible = "allwinner,sun252i-v861-pinctrl", },
+	{}
+};
+
+static struct platform_driver v861_pinctrl_driver = {
+	.probe	= v861_pinctrl_probe,
+	.driver	= {
+		.name		= "sun252i-v861-pinctrl",
+		.of_match_table	= v861_pinctrl_match,
+	},
+};
+builtin_platform_driver(v861_pinctrl_driver);

-- 
2.55.0


