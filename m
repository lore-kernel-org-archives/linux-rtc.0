Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251FB3E8C64
	for <linux-rtc@vger.kernel.org>; Mon,  6 Jul 2026 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783356467; cv=none; b=NWpVQ19UKsHMXJsvR4/2tcPrtM02hn6O04JaC9/RDE1Y6tWD8nBCpRfaFG2mJdISCy6H/uGw31IoLcABI0lfp7GCnE7HCRHW7nqcAmczeVyTkGpEz1k5dYs4aUs/ZQhF/ApiTW+1kfWN+sgwVb5cmo5XWwIASifGiqyZ4NUsIh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783356467; c=relaxed/simple;
	bh=R+o8YtHgJXSHgO5eq7i1Q8n7rZuYFQCp5qW/KIOcLKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sW95Yh6R6Xlm4y9vi6M0gQVkT+CcvT2voPKaenaufbZL7qkFLf9pH+lnBF1yK0I8LY+xpsNbKEiQKD+wmay8dNrD889q8dfdMBAU1xPzq+i2/OPYFpXSNKEuMTFdLpXp7yNvEjwfGXeBzoOLxBkajVoajAeigntxnTLREfKpQec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmN0xgzG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmN0xgzG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767D71F00ACF
	for <linux-rtc@vger.kernel.org>; Mon,  6 Jul 2026 16:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783356465;
	bh=LB2/p+oWL4RCfKiVWgBz4FzWrGlF5lzHpnv1b38gamw=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=QmN0xgzGzQ+V0jLldCISuCSfKjJIAhVQGbwgK/x7q8s0S+B4d1sytLyrP18xGpJ6f
	 PDWIyLHJjvr6jXOZOOI6wnOq5P6hyBaiM1AaL1B7I0jgo+GADFe/L5XY7UHGRNpS5M
	 MJr+lF+9uWI/154nJIJrRzwHdKrkZrhVA2ZOJF2Cr/qaIdhNnlbDMvEoVgE+iSQqop
	 1eRmkB3QZfNZ9OU7O/iAB+JnEYfK3KgYO6XmCNFrtTi8DCGunqKCRD3wu3nX+UH7Fj
	 1iVjR23hsmbkiZCH8axJAB6CKx1I3KzGP0gjUgVn7Js+DrcNWgLzG4+JTfOuLPDDFx
	 WkBtuhs0kktPQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39669bcaadfso36606651fa.0
        for <linux-rtc@vger.kernel.org>; Mon, 06 Jul 2026 09:47:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrx9E5/gPGdYLKwPDX3Sk5xtr8/0/GDcWx01xxZRP1NWHTeNhbqPa2GzPypl2xrS2Oj5JCmiIzEiMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7YBm1J5muHS1IlUPnr1Gxnr5LTVXuW2CbulaPUrC5DFM3tMFb
	0K/qTBOSwNc7ugu5nVoufI+vEjWxhtMxIxiPqIOseTB147NXOjKc5iq8tVnLsnJg6zOP1TBthAD
	FGBtLeQ/1/dXGHKuxjd0VOnCUAuoMfog=
X-Received: by 2002:a05:651c:549:b0:39b:5a79:ebdf with SMTP id
 38308e7fff4ca-39c5ffcf5a0mr3892111fa.20.1783356463703; Mon, 06 Jul 2026
 09:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-a733-rtc-v4-0-f330728db3d3@baylibre.com> <20260706-a733-rtc-v4-9-f330728db3d3@baylibre.com>
In-Reply-To: <20260706-a733-rtc-v4-9-f330728db3d3@baylibre.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 7 Jul 2026 00:47:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v67AXz=TPzNFnRMS9-vweL+6g5T57dwwYCdorwdi8HWcjA@mail.gmail.com>
X-Gm-Features: AVVi8CdByrsX-9_IhDg4o1yi7VabBipaYBE9WpxkiCIMPZgcujnRc2dyQoLeBWQ
Message-ID: <CAGb2v67AXz=TPzNFnRMS9-vweL+6g5T57dwwYCdorwdi8HWcjA@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] clk: sunxi-ng: sun6i-rtc: add a733 support
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 5:32=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.com>=
 wrote:
>
> Add support for the sun60i a733 CCU RTC.
>
> Compared to the a523, this SoC has a different input oscillator divider
> which auto-detects the oscillator rate and select a divider to provide
> a fixed 32768Hz clock. It also provides several phy reference clocks
> with dedicated clock gates.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 73 ++++++++++++++++++++++++++++++=
++++--
>  drivers/clk/sunxi-ng/ccu-sun6i-rtc.h |  2 +-
>  2 files changed, 71 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c b/drivers/clk/sunxi-ng/=
ccu-sun6i-rtc.c
> index 25dd87e78eb7..6b71bbd80255 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> @@ -44,9 +44,13 @@
>  #define DCXO_CTRL_REG                  0x160
>  #define DCXO_CTRL_CLK16M_RC_EN         BIT(0)
>
> +#define DCXO_GATING_REG                        0x16c
> +
>  struct sun6i_rtc_match_data {
>         bool                            have_ext_osc32k         : 1;
>         bool                            have_iosc_calibration   : 1;
> +       bool                            have_dcxo_status        : 1;
> +       bool                            have_phy_ref_gates      : 1;
>         bool                            rtc_32k_single_parent   : 1;
>         const struct clk_parent_data    *osc32k_fanout_parents;
>         u8                              osc32k_fanout_nparents;
> @@ -213,7 +217,12 @@ static struct ccu_mux osc32k_clk =3D {
>         },
>  };
>
> -/* This falls back to the global name for fwnodes without a named refere=
nce. */
> +/*
> + * This falls back to the global name for fwnodes without a named refere=
nce.
> + * NOTE: osc24M name might be misleading the oscillator could also be a =
26MHz
> + * or a 19.2MHz one starting with the a733. The original name is kept an=
yway
> + * in case anything is relying on it.
> + */
>  static const struct clk_parent_data osc24M[] =3D {
>         { .fw_name =3D "hosc", .name =3D "osc24M" }
>  };
> @@ -227,8 +236,28 @@ static struct clk_fixed_factor osc24M_32k_div_clk =
=3D {
>                                             0),
>  };
>
> -static SUNXI_CCU_GATE_HW(osc24M_32k_clk, "osc24M-32k", &osc24M_32k_div_c=
lk.hw,
> -                        LOSC_OUT_GATING_REG, BIT(16), 0);
> +static struct clk_div_table osc24M_32k_div_a733_table[] =3D {
> +       { .val =3D 0, .div =3D 732 },
> +       { .val =3D 1, .div =3D 586 },
> +       { .val =3D 2, .div =3D 793 },
> +       { .val =3D 3, .div =3D 732 },
> +       { /* Sentinel */ },
> +};
> +
> +static struct ccu_div osc24M_32k_div_a733_clk =3D {
> +       .enable =3D BIT(1),
> +       .div    =3D _SUNXI_CCU_DIV_TABLE(14, 2, osc24M_32k_div_a733_table=
),
> +       .common =3D {
> +               .reg            =3D DCXO_CTRL_REG,
> +               .hw.init        =3D CLK_HW_INIT_PARENTS_DATA("osc24M-32k-=
div",
> +                                                          osc24M,
> +                                                          &ccu_rodiv_ops=
,
> +                                                          0),
> +       },
> +};
> +
> +static SUNXI_CCU_GATE(osc24M_32k_clk, "osc24M-32k", "osc24M-32k-div",

I'm not a big fan of using global clock parent names, especially when we
can have proper struct clk_hw pointer references. However in this case
it seems unavoidable without making a huge mess.

> +                     LOSC_OUT_GATING_REG, BIT(16), 0);
>
>  static const struct clk_hw *rtc_32k_parents[] =3D {
>         &osc32k_clk.common.hw,
> @@ -267,6 +296,15 @@ static struct ccu_mux osc32k_fanout_clk =3D {
>         },
>  };
>
> +static SUNXI_CCU_GATE_FW(hosc_serdes1_clk, "hosc-serdes1", "hosc",
> +                     DCXO_GATING_REG, BIT(5), 0);
> +static SUNXI_CCU_GATE_FW(hosc_serdes0_clk, "hosc-serdes0", "hosc",
> +                     DCXO_GATING_REG, BIT(4), 0);
> +static SUNXI_CCU_GATE_FW(hosc_hdmi_clk, "hosc-hdmi", "hosc",
> +                     DCXO_GATING_REG, BIT(1), 0);
> +static SUNXI_CCU_GATE_FW(hosc_ufs_clk, "hosc-ufs", "hosc",
> +                     DCXO_GATING_REG, BIT(0), 0);
> +
>  static struct ccu_common *sun6i_rtc_ccu_clks[] =3D {
>         &iosc_clk,
>         &iosc_32k_clk,
> @@ -275,6 +313,11 @@ static struct ccu_common *sun6i_rtc_ccu_clks[] =3D {
>         &osc24M_32k_clk.common,
>         &rtc_32k_clk.common,
>         &osc32k_fanout_clk.common,
> +       &osc24M_32k_div_a733_clk.common,
> +       &hosc_serdes1_clk.common,
> +       &hosc_serdes0_clk.common,
> +       &hosc_hdmi_clk.common,
> +       &hosc_ufs_clk.common,
>  };
>
>  static struct clk_hw_onecell_data sun6i_rtc_ccu_hw_clks =3D {
> @@ -288,6 +331,10 @@ static struct clk_hw_onecell_data sun6i_rtc_ccu_hw_c=
lks =3D {
>                 [CLK_OSC24M_32K]        =3D &osc24M_32k_clk.common.hw,
>                 [CLK_RTC_32K]           =3D &rtc_32k_clk.common.hw,
>                 [CLK_OSC24M_32K_DIV]    =3D &osc24M_32k_div_clk.hw,
> +               [CLK_HOSC_UFS]          =3D &hosc_ufs_clk.common.hw,
> +               [CLK_HOSC_HDMI]         =3D &hosc_hdmi_clk.common.hw,
> +               [CLK_HOSC_SERDES0]      =3D &hosc_serdes0_clk.common.hw,
> +               [CLK_HOSC_SERDES1]      =3D &hosc_serdes1_clk.common.hw,
>         },
>  };
>
> @@ -330,6 +377,15 @@ static const struct sun6i_rtc_match_data sun55i_a523=
_rtc_ccu_data =3D {
>         .osc32k_fanout_nparents =3D ARRAY_SIZE(sun50i_r329_osc32k_fanout_=
parents),
>  };
>
> +static const struct sun6i_rtc_match_data sun60i_a733_rtc_ccu_data =3D {
> +       .have_ext_osc32k        =3D true,
> +       .have_iosc_calibration  =3D true,
> +       .have_dcxo_status       =3D true,
> +       .have_phy_ref_gates     =3D true,
> +       .osc32k_fanout_parents  =3D sun50i_r329_osc32k_fanout_parents,
> +       .osc32k_fanout_nparents =3D ARRAY_SIZE(sun50i_r329_osc32k_fanout_=
parents),
> +};
> +
>  static const struct of_device_id sun6i_rtc_ccu_match[] =3D {
>         {
>                 .compatible     =3D "allwinner,sun50i-h616-rtc",
> @@ -343,6 +399,10 @@ static const struct of_device_id sun6i_rtc_ccu_match=
[] =3D {
>                 .compatible     =3D "allwinner,sun55i-a523-rtc",
>                 .data           =3D &sun55i_a523_rtc_ccu_data,
>         },
> +       {
> +               .compatible     =3D "allwinner,sun60i-a733-rtc",
> +               .data           =3D &sun60i_a733_rtc_ccu_data,
> +       },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, sun6i_rtc_ccu_match);
> @@ -375,6 +435,13 @@ int sun6i_rtc_ccu_probe(struct device *dev, void __i=
omem *reg)
>         osc32k_fanout_init_data.parent_data =3D data->osc32k_fanout_paren=
ts;
>         osc32k_fanout_init_data.num_parents =3D data->osc32k_fanout_npare=
nts;
>
> +       if (data->have_dcxo_status)
> +               sun6i_rtc_ccu_hw_clks.hws[CLK_OSC24M_32K_DIV] =3D
> +                       &osc24M_32k_div_a733_clk.common.hw;
> +
> +       if (!data->have_phy_ref_gates)
> +               sun6i_rtc_ccu_hw_clks.num =3D CLK_OSC24M_32K_DIV + 1;

Maybe keep the old CLK_NUMBER macro and call the new one CLK_NUMBER_A733?
The point is to not directly use a random macro + 1 here.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

> +
>         return devm_sunxi_ccu_probe(dev, reg, &sun6i_rtc_ccu_desc);
>  }
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.h b/drivers/clk/sunxi-ng/=
ccu-sun6i-rtc.h
> index ab7b92b47f59..4f4f4cb00f1d 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.h
> +++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.h
> @@ -11,6 +11,6 @@
>  #define CLK_RTC_32K            6
>  #define CLK_OSC24M_32K_DIV     7
>
> -#define CLK_NUMBER             (CLK_OSC24M_32K_DIV + 1)
> +#define CLK_NUMBER             (CLK_HOSC_SERDES1 + 1)
>
>  #endif /* _CCU_SUN6I_RTC_H */
>
> --
> 2.47.3
>
