Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7870241229E
	for <linux-rtc@vger.kernel.org>; Mon,  6 Jul 2026 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352961; cv=none; b=dFymyPSfH8onr0pEMexmePnp1H3IXIUqi6SmuQfi/vAwfPflRyzABHM/jJrlLPFv4bgNvmo8PIpdqnQNiITOue8ViSGt8TOXoOCRJFKea5ohNsLuNZVIViX7l8MUo89P8GHvZMVALQ5zvwuHImX30ygklKJKHzqMUMeewcgTvL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352961; c=relaxed/simple;
	bh=pl1KEDOMoRl8LBORmoKUvE6Y1V92qEX1J/mJ+bBXXcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akogAgxER8cgEXGMypRTSaL7bV8gNOMx0Z4MK0rJd5WrPSIwv6rWv1PUvfnAu0VXgW9PFfvPDLNWq47QiAEvoZPi8vnyXhK/tujl8qUIdTf1/qnBm791LqFtVkrf5ZllwS4SLmm6aOsx+NsDj/jhsXLIy87RsEaId2ML0qsmEr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NssBhG6O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NssBhG6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA221F00A3F
	for <linux-rtc@vger.kernel.org>; Mon,  6 Jul 2026 15:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783352957;
	bh=x7aoi7iDnEPU3KXLwcvJh+y+bvu9z1UExF3xdy/AKzk=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=NssBhG6OWSogreUfjnBrNElKqA+l46MsjNYMWeKs4z/Ib79yPFqrxuxiEvOqNOFbj
	 k9I57Pa8Jvc5PhKKi/mMMWB5QA7u6vl8CDKeBmFf0zdzvkrf2Kn2wXYPR149zXzBsB
	 qFkBIGoZySQzH2/602ENObjxGrF0j8nndKYNnK5dGzvTe+PKBeUMuUFIXCYgLcdsx/
	 4DQT7WpdyChNpweoI+6Cfu9q0IlfN+ney66mI/W+6OPkbHrNrifngU2JLQDs+Q7ZkK
	 fSQcoSE18HJzQxM9iLS86xphv6eabE4fEDOPH50tqnv2Pkx8pSwoM6CC4SHGhi46b7
	 tMrZXJ9jCh5lw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39c62764c7cso1756421fa.0
        for <linux-rtc@vger.kernel.org>; Mon, 06 Jul 2026 08:49:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpbiAZMyNuCWSLO5i2Ia9dZygwpb3HoZ2Y4fO/yWjhb5L50PtrA2M29bJSvi9TlNGimV/x33Pcip3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV8fUuMhtHs0SR4fCnCwbY9xLpMM7Xb6OyAcp2//iCe9hyrnX+
	8nhGQ3U6IyoKZOtmQeoPh6RDG8QthntfCIEr3OZu/E5i2foqmr05OTmZWepTpFvv5SuIcaNzNjk
	TqODoZwJ3Ds6Y9Ob1LQny3K4ph4TMZ8Y=
X-Received: by 2002:a2e:a989:0:b0:393:aa48:8243 with SMTP id
 38308e7fff4ca-39b4536de31mr31562521fa.18.1783352955971; Mon, 06 Jul 2026
 08:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-a733-rtc-v4-0-f330728db3d3@baylibre.com> <20260706-a733-rtc-v4-8-f330728db3d3@baylibre.com>
In-Reply-To: <20260706-a733-rtc-v4-8-f330728db3d3@baylibre.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 6 Jul 2026 23:49:03 +0800
X-Gmail-Original-Message-ID: <CAGb2v67P9W9v-iWshJFqQfuB_qhD2S1PRCdwowGEcRBi=-ZHDw@mail.gmail.com>
X-Gm-Features: AVVi8CeWczpk78VcWF1dP30DqhdG3iRBi9A4c_ikMSI7IzDTUwpjlrCHftcPHAU
Message-ID: <CAGb2v67P9W9v-iWshJFqQfuB_qhD2S1PRCdwowGEcRBi=-ZHDw@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] clk: sunxi-ng: sun6i-rtc: split main oscillator
 div and gate.
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
> On the a733 the "osc24M-32k" clock has the same gate bits as the previous=
ly
> supported SoC but a different divider implementation.
>
> Instead of a fixed 750 divider, the divider is selected based on the
> rate of the oscillator. It can be seen as a simple read-only divider.
>
> To easily replace the divider part depending the SoC, split the divider
> and gate into two separate clock entities.

Actually, an even bigger reason to do this is because the read-only divider
and gate are in different registers, something that our combined clocks
don't support. So they need to be separate clock entities.

I think this should be mentioned. Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 20 +++++++++++---------
>  drivers/clk/sunxi-ng/ccu-sun6i-rtc.h |  3 ++-
>  2 files changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c b/drivers/clk/sunxi-ng/=
ccu-sun6i-rtc.c
> index b24c8b196e66..25dd87e78eb7 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> @@ -218,17 +218,18 @@ static const struct clk_parent_data osc24M[] =3D {
>         { .fw_name =3D "hosc", .name =3D "osc24M" }
>  };
>
> -static struct ccu_gate osc24M_32k_clk =3D {
> -       .enable =3D BIT(16),
> -       .common =3D {
> -               .reg            =3D LOSC_OUT_GATING_REG,
> -               .prediv         =3D 750,
> -               .features       =3D CCU_FEATURE_ALL_PREDIV,
> -               .hw.init        =3D CLK_HW_INIT_PARENTS_DATA("osc24M-32k"=
, osc24M,
> -                                                          &ccu_gate_ops,=
 0),
> -       },
> +static struct clk_fixed_factor osc24M_32k_div_clk =3D {
> +       .mult =3D 1,
> +       .div =3D 750,
> +       .hw.init =3D CLK_HW_INIT_PARENTS_DATA("osc24M-32k-div",
> +                                           osc24M,
> +                                           &clk_fixed_factor_ops,
> +                                           0),
>  };
>
> +static SUNXI_CCU_GATE_HW(osc24M_32k_clk, "osc24M-32k", &osc24M_32k_div_c=
lk.hw,
> +                        LOSC_OUT_GATING_REG, BIT(16), 0);
> +
>  static const struct clk_hw *rtc_32k_parents[] =3D {
>         &osc32k_clk.common.hw,
>         &osc24M_32k_clk.common.hw
> @@ -286,6 +287,7 @@ static struct clk_hw_onecell_data sun6i_rtc_ccu_hw_cl=
ks =3D {
>                 [CLK_EXT_OSC32K_GATE]   =3D &ext_osc32k_gate_clk.common.h=
w,
>                 [CLK_OSC24M_32K]        =3D &osc24M_32k_clk.common.hw,
>                 [CLK_RTC_32K]           =3D &rtc_32k_clk.common.hw,
> +               [CLK_OSC24M_32K_DIV]    =3D &osc24M_32k_div_clk.hw,
>         },
>  };
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.h b/drivers/clk/sunxi-ng/=
ccu-sun6i-rtc.h
> index 9ae821fc2599..ab7b92b47f59 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.h
> +++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.h
> @@ -9,7 +9,8 @@
>  #define CLK_EXT_OSC32K_GATE    4
>  #define CLK_OSC24M_32K         5
>  #define CLK_RTC_32K            6
> +#define CLK_OSC24M_32K_DIV     7
>
> -#define CLK_NUMBER             (CLK_RTC_32K + 1)
> +#define CLK_NUMBER             (CLK_OSC24M_32K_DIV + 1)
>
>  #endif /* _CCU_SUN6I_RTC_H */
>
> --
> 2.47.3
>
