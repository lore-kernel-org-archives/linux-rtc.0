Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794609218;
	b=g4OCjf5BCOVkPdVfHBULnVuk4ap0wbrV6KC9TqGvtmUf/WUTjXKLsLxCHhYfgw6wJ8WB
	 aYKvhWsXlw6J+b9V/8XwHAWnT5dBzjVmNiYZg4iXEImkbY8t689uxGuANuaDzjv6hhDQw
	 2j0Xky8H3v1J4FwpKMNhHGzfjSKVRfblhLvLLrU55ILW4q9HpFxUC2rqV6IH6qsqO1Fhw
	 hXIaAuGNMAFj/P43UQxhnPnqiaCAk00Ly98dTfPBGY0ocC1MbtWGZ/ZPkDhHOEYz27xY4
	 sQiqsWRVSWXRiG4tGQpXrauR9mQTnBMXgq35AOyAVxCPmtyvLexJIQ6V23JQOzX+5fQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609218;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wpbbKA4ajLzIsgcmiI1L7FK42JRHT9STO33kEE3TcR8=;
	b=adjq/iWoj4ggbZnvzlyRMrTGchWnzmr4yKY24Z1ZDGoX1kwqCXmGPeDBFvH604pPOaP2
	 tKlxlEy8hrjV1CTyobdukalfRW59Np4cKEOkNTz2Q7NvTGGtoWYBbbXhJQ5sqjg47j1Yn
	 ufWetTYbFON02htRDhVoApV10xhGlAaZ4/RN9DCXam8CQsBYcpuMoRtFjGXT1BPFo+NU4
	 ElQO7iKqzRxsiC5xswMYIZHd8iKu5KQU+MM2ZYJopGmCmgRfNuFPVwtGyze8FIsm5bmAR
	 bXASifu2hNbS7L811Esm3V/6y96Bi2i6MOG74hipoWg7HbCh9KAD/WhIl1+I4z3IXiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOWJEzdx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9AF606A88B;
	Fri, 13 Nov 2026 22:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOWJEzdx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794609217;
	b=bCVhZy8HnEYWGbBZH8HNZErHk5Pgj1+7eBZ4XoIB6pRvEN9iCRg3rFFn+00TSr8QAzDm
	 11XTDwTY0tgHlyUSNajPWWcic2+IQdMQvzwmvz1pKt9Sz7Q92xXWwbBzfFHcNNchePWX9
	 5ra67SQ2cR6x5ZSRJF5yVajI8rES219E7RwSKi++JXzwpmohjBq4e037liX3Of1fWkZLj
	 n+yBmjr8Mt0kLQPBvZnFj2jqR7OxAtyBCk5sgd5QUmMy1CqydRc35qnSPJDbgWfif59RH
	 jXrtio1njZKs1C4Rrr5X/8rgdNRGdxZdGX6baMvJHQxbeUvEeLRzhe+pzhq68IBVmIg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794609217;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wpbbKA4ajLzIsgcmiI1L7FK42JRHT9STO33kEE3TcR8=;
	b=xGGJ+yRDLk/vdnDU+pMunghfA3rYoYMV1ULMReHGZyEB0NngMVtVbuuoVhsR47BYxnxr
	 TjJrj/AJvifAxCGeamdsr+xL7MrNQKHI76+xRUB/2uNNvcoJixnGa36IeZ69dvAQq0Mzp
	 uwnKaGyNQu56X8XB5B4kt1T1YW0RqaPA72Fl9AghLlypvW5YHogf1XCsGBWtYvrO6M6dk
	 Uz3Vl8x+2XWNmS21zR5+/YQ69TXpy0fxHIskMsRRfmfkOiNZUi2lIBQ8EdoSGLAcDMgQG
	 DWJDjN2Wc4o2ZmyrSd358xfv0DFlonPVg2WeA3NVPb4ZmAY+DNEqPdHiu8PGAaPXQ+g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D5BE71F00932;
	Fri, 13 Nov 2026 22:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609217;
	bh=wpbbKA4ajLzIsgcmiI1L7FK42JRHT9STO33kEE3TcR8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=oOWJEzdxtLc85ptJmPiOIx2OlKkXvseUVIqkJZeoV9Kiluiw3t0Ux51rwp9eU8JTw
	 N8qjiHD/HfYvCCVF+Z5z6J+eri2cn62tx+AvpJ5RZZMg9VrW3clYTvEUGAc5tNYNoo
	 705xgno9SArazNBRzKTjpIdy7Gsd6JzCfX4Gd5dXWlnvMUP48ZESvdArOA+PnYWndc
	 Vudfb23lZ0UjqZh2PLMZGZefDEyLJNmWEpcKfRqylxrboVROo8KuiyB5GG5i9BlMqj
	 T9rr6i5oy+kI7wCuh7I80L+vfIXMOJsUcDzly3ak+CLCvpykl2ze4i8x/M6pIc9gwA
	 1dTSpjp/GDM8Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A8E7B49B88;
	Fri, 13 Nov 2026 22:33:33 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Sat, 14 Nov 2026 06:33:39 +0800
Subject: [PATCH 13/19] pinctrl: sunxi: allow a per-controller IRQ register
 base
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
Message-Id: <20261114-v861-v1-13-eb71ec3ee523@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794609209; l=1288;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=Q5nKbDPfL5bIJRudVipL8eRl+Sf6kVk4l+UGPGRoSrU=;
 b=grvbJPn/+R2MO+DEgByDUFTZtLVCqIBwHkLAL0ulBtY+dR3+FlP1mIhHsm4whuN7dLMvBp/6p
 +ihd2LdEuONA/g6geIuOhI8/hEPyOVjToZchKiHiT7GGOnYmqJ2XUOA
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

The V861 always-on pin controller has its interrupt registers at 0x40
instead of 0x200. Let the descriptor override the base.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index 7c2f29e75519..a0f5eac5c914 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -152,6 +152,11 @@ struct sunxi_pinctrl_desc {
 	unsigned			pin_base;
 	unsigned			irq_banks;
 	const unsigned int		*irq_bank_map;
+	/*
+	 * Interrupt register base, where zero selects the traditional 0x200.
+	 * Not used with the NCAT3 register layout.
+	 */
+	u32				irq_reg_base;
 	bool				irq_read_needs_mux;
 	bool				disable_strict_mode;
 	enum sunxi_desc_bias_voltage	io_bias_cfg_variant;
@@ -261,7 +266,7 @@ static inline u32 sunxi_irq_base_reg(const struct sunxi_pinctrl *pctl, u16 bank)
 		return pctl->bank_offset + bank * pctl->bank_mem_size +
 		       A733_IRQ_REGS_OFFSET;
 
-	return IRQ_REGS_OFFSET +
+	return (pctl->desc->irq_reg_base ?: IRQ_REGS_OFFSET) +
 	       sunxi_irq_hw_bank_num(pctl->desc, bank) * IRQ_MEM_SIZE;
 }
 

-- 
2.55.0


