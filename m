Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794609217;
	b=F4cFxz3eGUd34ObldWEdzV5PKzo8P4eN7maFVvYTd5zCqJMnrBaA6cEmmkdixK+4nLH7
	 g52EapZBCaTgp3IZzDP5JBMeF5kEcq3P7II40+y3oCZIFEhhH9LFpbDR6T0uFo7lEu2TP
	 TVztf1qg+Lw1UcEK5h2Y7sUgfKt00zwIrhrrTddoueo0jFj3QUh3MOsT4m+2XQsyIBs2H
	 p9O/A4+zQ1BZ9mA9ZSJ3LeubMsdqBXaZuU1T+dWhZDNb+bYpDPFdMAdwEutumiGJCcR1o
	 BLZeu0K9yfN6rh4pxsh5H1T3AsSGkfrv/aVx66fJZPXzRlhk2wVPu6DhhIxDTcC57Ug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609217;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+LYiK/955nfnWYhkJP54cSbyAVpIlwPTqmzMMmypLBQ=;
	b=YaXATm5I6Yq29RNqwdWTSCU6pqw4gVybdT/PRI7VF7fZhO96EeaIHBgavuOYFfhSkPN2
	 ySBxCszG2t9Q9HngShMrDrwPwVS+Mn301PfQRMBfhVtliziVRgz0g6apmmUshBNf9U0as
	 XgOT6W6RQ0CN40Om0Q922q7b9zx8kJGX2ZMRyIZUD6A+5OxJGS3Zk2w2gvUTtjmRz4eBD
	 qpJTPl+pqIfSvTh8smqXHcTN1bdmt7mygspcWOL5x8LKTbvpWqafOth/nLhZ7ZBsOlVm0
	 W6cY5L1eiazCzjmW7fnpf5iSFhefMDqnxNvZO1XnR7ab2pL2RpsLrBNMIzZsxsGAK2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nbs63U4M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DF8606A88F;
	Fri, 13 Nov 2026 22:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nbs63U4M
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794609217;
	b=rm3gq3VaqNmbUVDuF6cC3EJdz+5iPw78YnNODPIdvKPJGsDnhPRRI5dWUlxf0Tv8On8O
	 BsyTMBZ2/aBJUu54xUb1G05pW0sUIZ4ABvvzp3HLo28T0cz4mohIS3ZYH8BE3tlKJErhB
	 1SzryVarflM/qo/MtIBjRnedVaULams3hWNDJ3KJqPpLA9E8trX576LitMPDhDXPNEaWe
	 m/StjAP88Hy0oJu9vR6F9iF1lNie4YfyRkx8AVq2fxDD4t+RF+SMUXxZLoIngBVon8Zhy
	 UJpIIQrRE2rOhHI9qfDk7004Ucqkq3FsDB0mOId9AdxlgNlX6JSh7qrGCkI2lmqHHPA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794609217;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+LYiK/955nfnWYhkJP54cSbyAVpIlwPTqmzMMmypLBQ=;
	b=hYy+2mRa69+MNmWzlv/k3vZZCWLKqB4d72cbQEng7EFtT8976hKztYLpnbkuw8wNI2eR
	 W648pndhdJEpHXj1PKLYuuHnLqo9Z8GmZdzD3TUahuUcuu2bjLyUe6KM1jLN+VymgBvkt
	 pF2OmKwmDZ344ApoO/p/2n04+sNOmNucYeIZwR2i6PgXiDVJpD1myN83Ew7lw0rFSBlV7
	 k9epVYe4Grl05DPD7QIr6/z1vnDrFvzDWKP0bqwrKBO45lI9vh2GTNOSC+4or647RMilG
	 Xowe0W60L4gnIP9b1aHA/h4CSA7zsZMtCevZm0LVNQArxcoDt3H3CMce5tZ72kpP7SA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 035961F000C8;
	Fri, 13 Nov 2026 22:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609217;
	bh=+LYiK/955nfnWYhkJP54cSbyAVpIlwPTqmzMMmypLBQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Nbs63U4MikP4u7GXTWu/Yh05G7PSpAOzdZ2YwMuL/uvPyy1bnfrGQGlkhz1B375bt
	 Lok75LO1oo5DXupGOvpeHeBeSb8aSFKEawx3QGQj32wdywbMIAmy/W9Mbt2fMqcFNB
	 IYH5bpflUx9C2xWueOSonWLM3YV0Lfe66fsx/IUUnPwXvUpN+OHrwHwZDcOz4czthQ
	 ErmXMQKFt58/G0Y2Cr8Rsx0IQrMq9ueYf3g/F8osAT0i0OKNDP/GlIqToQA/Av/ZIk
	 53DM960oWCTAwUPKQuY8cJ77+2hxDM0YqSYw4UWKMZalr81YkBvlpZQjH8qrGuZD7u
	 uptEuZlat6ncA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5352949B78;
	Fri, 13 Nov 2026 22:33:33 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Sat, 14 Nov 2026 06:33:35 +0800
Subject: [PATCH 09/19] clk: sunxi-ng: sun6i-rtc: allow variants without a
 32k fanout mux
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
Message-Id: <20261114-v861-v1-9-eb71ec3ee523@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794609209; l=1175;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=IjLpSZK52EbD2RXTMonjExKRJ8v5cc72rNy+1BJSluw=;
 b=u4Lz8S44b3ToLaBsujWDUTqNOl1o4PgdcDpKDa/XwGcMxJt8sFC/p1XpwLiV3n6qI2MWpZyKs
 moCFg0R6xxABDqHcZkHiY1smc7VBl2uZEKHM2N3ESxOzRNNPALUPA2A
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

Some RTC clock blocks have no 32 kHz fanout mux. Do not register the
fanout clock for variants whose match data lists no fanout parents.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
index 98ae10307f43..0e40fd5fa624 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
@@ -436,8 +436,12 @@ int sun6i_rtc_ccu_probe(struct device *dev, void __iomem *reg)
 	if (data->rtc_32k_single_parent)
 		rtc_32k_init_data.num_parents = 1;
 
-	osc32k_fanout_init_data.parent_data = data->osc32k_fanout_parents;
-	osc32k_fanout_init_data.num_parents = data->osc32k_fanout_nparents;
+	if (data->osc32k_fanout_nparents) {
+		osc32k_fanout_init_data.parent_data = data->osc32k_fanout_parents;
+		osc32k_fanout_init_data.num_parents = data->osc32k_fanout_nparents;
+	} else {
+		sun6i_rtc_ccu_hw_clks.hws[CLK_OSC32K_FANOUT] = NULL;
+	}
 
 	if (data->have_dcxo_status)
 		sun6i_rtc_ccu_hw_clks.hws[CLK_OSC24M_32K_DIV] =

-- 
2.55.0


