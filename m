Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794609219;
	b=QdIIRTUx0NsOONMaeLjJxpLXWyWSDPOb+oDNgO7V0H2yvdAGqm/jJH7Es5uXubzQ1FmW
	 M26AEOpk7jus4KET/c26tSImG0pcLinFtMNAwZOglUUdVThq31loKR+uJm4g6CqxQ8Ym1
	 p+129C/vXsbbrEhZ/Pvv7FGIZBd8ynmEhKVS5FWLgsrNfoX37pyCB5+vympm51cVxwUfV
	 ICnEeSwDwIl9cblpsmBBYHDt7reWQfpoV0uVmGwWEaafUC4SlR3AaFGdmSHExkhK13KIi
	 f/JCaVN4I9W4Lwgmr1EETk8Vq92SQJVSVCME/7K7s54J5kKS9wHSGsdN2h39hMSiciQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609219;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4mMY5cZaKx3ZCVEMaMmatdBt7ktTZ1OwhWVfuPFcows=;
	b=2wdES6BMp32M8Qi0xYf8hf4jFBrVj2swoaeYulw12Dkkh4mPo26iSKE3Dddux8yl366L
	 h2iZmip2dNzKsX0fnkl+uZRVFx0hyWluKz0l9X2jjQEJlW7lirf5uj+6aqu84TydIWpQy
	 n0Rc1ARpuELRc8pEpz5gEV9cajpuTousG8rU3K/o9x3Q4nGV5j4zGM+0lNkjP4WTvWpfX
	 KsmjuE/kb7E1E+zmBFV4ESEtCCIisfsJMrPoBldOlf0UrBGl3kEydbLhampJhIDiEQDXV
	 ihnRgWaF2vWSWju20eosS/2FvYn4jP1JK3dyvHBNpPgnDxzrX7VoVoSW5AGj3UWDpaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IigouBQH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD5560A3827;
	Fri, 13 Nov 2026 22:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IigouBQH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794609219;
	b=AK91dPpd1Gkrn3J41qz2CWYf1laPPWxIrSBfZlfgFim4yJisYmmr/lxoSIaywDN7nEiy
	 PlQKdyKxsK+wK4UTWAGSPcmLlc5yPC9/TleWiPLEBcRgMY2iXiORqjbAMhQiUxUZqQnuH
	 z5UdN0gBZZo73uACwxuejHe7Uno4gSRSjkzimP7+itRf+RgJoFIUwNDwQ/+M9SfsBeW6q
	 /pzFEc+cwFbNFnS46TqbhvFi4GBLb9nFfajgZxFjF4AGlxAKH4K0hCLweDuLE9AhngU8P
	 2xRJB5p2ls9JpGx1b0tPpivPeC7ugaUitzX6k0Ka4uyt0qwCaXzDBWetQP+c7oLzIrw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794609219;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4mMY5cZaKx3ZCVEMaMmatdBt7ktTZ1OwhWVfuPFcows=;
	b=2ptx1L6tcz9IB4GXAz0l18G6BNZT4lyA1V4FWo7G4FqmBuwt5Zh93ylzNL2zpKQzAuZl
	 9IfYzSnBIN3VayWIXI/ZYurNl0wBxfSjn4RwNh+HyCYNdDzLJl6R+KWduwmwbZd/KhmD0
	 Ir4wYzdSqa3+5PkLm89UOiyEUJj9/WsGaBA7vCV/+esAMEsDB1Lj6C9QSJ5YrxYED5rSd
	 GgyLNMNOrQyHD5ov80rvLCHZv4elykQ+y3Z9c1eQYCYb6PB5wvx4sqTy2Gh69XeLH/KgW
	 OIAZ3gkbG/UcGCIfRDZfxfuLBsbKBnniZazGyT7JvZBii+nhku/MrumI0KG2vyAcUMA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2DA181F000D2;
	Fri, 13 Nov 2026 22:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609219;
	bh=4mMY5cZaKx3ZCVEMaMmatdBt7ktTZ1OwhWVfuPFcows=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=IigouBQHREYR6jRjc4A6nZGQczb6EoRkq8nHMkxDPIiQmmozMVzrb42NnHzNzcNro
	 8xPtW7qZCV4G42LXacr3vytBCuTSYM+xTO03pTFRmw/kpkI/NJPSpBTPUIvCKlOy/x
	 YFcL1FmqZH4pjEYo12xobeFwf5fAF25Hjkvm9MVkN6ZjqW5IiJvoV6gbP8Jp6TSEqr
	 r0UpeMF5QjFTmQifkA0f26pbwcZa1rf0bkVgaKrmW1asF8FYCtooZBViDO27IUhMG8
	 BYNxJPw8eqUiN/CPyFvhPRl7nccEGGt1s4iFHLBWsQfKdSxsUO0E2T3O5sHqljR88O
	 dyDhP7WZcQk6w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7D95F49B80;
	Fri, 13 Nov 2026 22:33:33 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Sat, 14 Nov 2026 06:33:37 +0800
Subject: [PATCH 11/19] clk: sunxi-ng: sun6i-rtc: add Allwinner V861 support
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
Message-Id: <20261114-v861-v1-11-eb71ec3ee523@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794609209; l=1736;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=FtT3g2BsbPGWBSuneJ0o2oWXhhcqpYTjSs7COAH+YU8=;
 b=EdbVxEBsgcIrqNXI47Kh+ivqcWZsMI/zxZ4SByBdzlJzw1sOBCXPcRNpv/CWAGJtOwhd6gogI
 S8IwtXnP/rhCnSIObOMgO5DcL+JYJpzv+qW7cacx0j3ueZZ7G0KvR3A
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

The V861 RTC clocks are like the A523 ones, without the 32k fanout mux.

The 24 MHz to 32k divider ratio is not documented. With the RTC running
from it, the RTC kept time with the architectural timer, which uses the
same oscillator, to within 5 ppm over 15 minutes. So the divider
outputs 32768 Hz, not 24 MHz / 750.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
index b3619222fef0..1abee85271a9 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
@@ -392,6 +392,18 @@ static const struct sun6i_rtc_match_data sun60i_a733_rtc_ccu_data = {
 	.osc32k_fanout_nparents	= ARRAY_SIZE(sun50i_r329_osc32k_fanout_parents),
 };
 
+/*
+ * The V861 has no 32k fanout mux. Its 24 MHz to 32k divider ratio is not
+ * documented; measured against the architectural timer, it generates
+ * 32768 Hz.
+ */
+static const struct sun6i_rtc_match_data sun252i_v861_rtc_ccu_data = {
+	.have_ext_osc32k	= true,
+	.have_iosc_calibration	= true,
+	.osc24M_32k_mult	= 128,
+	.osc24M_32k_div		= 93750,
+};
+
 static const struct of_device_id sun6i_rtc_ccu_match[] = {
 	{
 		.compatible	= "allwinner,sun50i-h616-rtc",
@@ -401,6 +413,10 @@ static const struct of_device_id sun6i_rtc_ccu_match[] = {
 		.compatible	= "allwinner,sun50i-r329-rtc",
 		.data		= &sun50i_r329_rtc_ccu_data,
 	},
+	{
+		.compatible	= "allwinner,sun252i-v861-rtc",
+		.data		= &sun252i_v861_rtc_ccu_data,
+	},
 	{
 		.compatible	= "allwinner,sun55i-a523-rtc",
 		.data		= &sun55i_a523_rtc_ccu_data,

-- 
2.55.0


