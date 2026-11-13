Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609995;
	b=O1IiCNLsPS5OC3L8XBaWfDfRkb9Q+oEIfAiIt9A5TX18B+4qpqCgpI/FM+p3s+Q6E3K+
	 x8x0pla8MqNNZ4px70/diddWVXz1s5IdYfS3C73972TaNQG9T8mbNXOD8Tgdxr/DtHDW8
	 p4kRydOeJr63k0+AiAnFdlYWA7W5Mok18P1O1nooyJO8DhI66ldQJZYEKGa2NmUeH6681
	 h7vmOxJkHBvcjikqm1J5DExAIGUUU7uel/gwPUFVUml5nKnH/ujvp6lYzpITCb4RMBi38
	 SwylMWdEokj39R7pyTLfmEoYEkWjegHYpIUNWUALnP7DDO2DVAAPHBX+5NvpDC1D1eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609995;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SJJFXFJOjUb6U2UtiZQNfL1AoPB2mBR7cd+kQxd45dI=;
	b=D5vZC0LspIxfLBzwP+l7PQg0E6s4Ji3Fwx4X/bXBCpTdGTEP1M/U0w7SAXGbfg39KgXN
	 uS40cxx9aeKusk50OnZXgDLBe5vclKxhNoJtwfbhU1Esxiwq3Le/2WuReZU9IlyImtb/p
	 yE+39zo8S3Ch6bzu0Eym875nKAakMxfYNNiU4LDwWZ0I6jOCddbYu9T6Qhw56cHupRDX+
	 aeyBotZN0+VKf8HUaO+xL1qmAtEbtMUGnT5ZKyP52BAm/IFHaFTmehPpfSmT19PCzdpD4
	 BhOl9rXAfX7ErPHtWAHqJDanEFXB/YorgYQwnRZxb2gkMSAn2Z3qGzq1/kV/9KHiRiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXykTpMI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8658606A32D;
	Fri, 13 Nov 2026 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXykTpMI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48301F000C4;
	Fri, 13 Nov 2026 22:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609995;
	bh=SJJFXFJOjUb6U2UtiZQNfL1AoPB2mBR7cd+kQxd45dI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OXykTpMI6vEGjfkrx9j5PULfAFNQfq1W/F9Y+XHVbp7+FwSM6ZbExMxaMZ+gI6k89
	 tXWJwfOV+eb4lw7s4q/FShR14KKetT9HCLR9EQD989h26yMA+5LRC6AMNJkEFVNulV
	 H4lvEqOtc5eGN+DKlC+6WBidSD6rsgWbJRaX/fPvoR2S+XGfrvayXp56WlDUg7tQx+
	 L4yDRYSx0xMYffnyXBbJeA9AN9SkprcoL+UuqoexHfyj2f0dUijWpwEOdKIm6a7nqH
	 PSmfQq28+hk/H11vWxH+xKf5snBLbkPLuV6e/5mRzdbw0DOg6jwgjARJnnud3dCOSD
	 zfdFXe6JIdjjg==
Message-ID: <sashiko-outbox-213839@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/19] clk: sunxi-ng: add support for the Allwinner V861
 CCU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org, linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261114-v861-v1-6-eb71ec3ee523@iscas.ac.cn>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-6-eb71ec3ee523@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:46:34 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] clk: sunxi-ng: ccu_mp_set_rate() ignores
  CCU_FEATURE_UPDATE_BIT for dram_clk
--

commit 4dcfa888826dc579312b5e254290daa03aed3f59
Author: Han Gao <gaohan@iscas.ac.cn>

clk: sunxi-ng: add support for the Allwinner V861 CCU

This commit adds the main CCU clock and reset driver for the Allwinner
V861 SoC.

> diff --git a/drivers/clk/sunxi-ng/ccu-sun252i-v861.c b/drivers/clk/sunxi-=
ng/ccu-sun252i-v861.c
> new file mode 100644
> index 0000000000000..af84c49fbaf16
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun252i-v861.c
[ ... ]
> +static const struct clk_parent_data dram_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .hw =3D &pll_ddr_clk.common.hw },
> +	{ .hw =3D &pll_periph0_2x_clk.common.hw },
> +	{ .hw =3D &pll_periph0_800M_clk.common.hw },
> +};
> +
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE_FEAT(dram_clk, "dram", dram_paren=
ts,
> +					    0x800,
> +					    0, 5,	/* M */
> +					    8, 2,	/* P */
> +					    24, 3,	/* mux */
> +					    BIT(31),	/* gate */
> +					    CLK_IS_CRITICAL,
> +					    CCU_FEATURE_UPDATE_BIT);

[Severity: Medium]
Does changing the rate of dram_clk actually latch the new dividers in
hardware?

dram_clk uses ccu_mp_ops with CCU_FEATURE_UPDATE_BIT, but unlike
ccu_div_set_rate(), ccu_mp_set_rate() never checks CCU_FEATURE_UPDATE_BIT
or sets CCU_SUNXI_UPDATE_BIT before writing the register:

drivers/clk/sunxi-ng/ccu_mp.c:ccu_mp_set_rate() {
    ...
	if (shift)
		reg |=3D ilog2(p) << cmp->p.shift;
	else
		reg |=3D (p - cmp->p.offset) << cmp->p.shift;

	writel(reg, cmp->common.base + cmp->common.reg);
    ...
}

When clk_set_rate() updates the M or P dividers without a parent mux or
gate change, the hardware ignores the unlatched divider update while
ccu_mp_recalc_rate() reads back the new register fields and reports the
wrong rate to the clock framework and child clocks such as mbus_clk.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-v861-v1-0-=
eb71ec3ee523@iscas.ac.cn?part=3D6
