Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C40739B4A2
	for <linux-rtc@vger.kernel.org>; Sat,  4 Jul 2026 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783153518; cv=none; b=Qu1XlOR19nRxdwbn7Ci3aI05BdJ6yQEZE9XU/sMJoqV8NCedQRrINQx3ZTqcZY+SXa6TzU/vDDzfxzbhfT9pPkXkADiHsQIxwkrta8CjJfq4Azk19kf7XAw+Khp0vcr3OeV/Oap8h0erH9zHDlutA9moosP2Z8D0brSbdUcqKhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783153518; c=relaxed/simple;
	bh=kcg7KVCWy+NnC+VfCf9xytGdC2NFAJGaOzW5jvhcj1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9gkM+QeZ72hEpNZ04YTtZHS0UE7e3Ly9MvDN/PkG8EZ2K51TmzA4IZMbeFbQsG4gsqDDNozefnYgLSe4bS8s0lHDoJKHvfOwRZFq1sTdnbScmhRM6cFdPwG1Lt8GGAILPXjGjOFJ/FWMHvs4h/L7aMgFoBkNg9KjGff+5tsvWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhmNjmDr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhmNjmDr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBF01F00AC4
	for <linux-rtc@vger.kernel.org>; Sat,  4 Jul 2026 08:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783153515;
	bh=Fs2AiFoC/uXi7Y3GxLDQdbdL/aEwooLIt1/0w5YrmTY=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=AhmNjmDrvXUIm6qq1QCLqnCOerLJyDhayVscWRp+pfxFlPNRVhDN7FxAEBUNoNMvv
	 fX29jiShaD+xLYEqR7ds9oASvt4gBXubcEqIEeeSZCjmi3wT9+gWWpA4MGRGG+Uvwt
	 mvJWckTAhYPw6RWzQe0tmkPrR3mUDBDsmlKP77VOdcSvJMAX5+xPyr5ol32ly0rNVT
	 LsT22Ht/ajL5O29l+rtTZjt3uzQXj++OBIe01iL26GOWmLzFWxhaPXrvtTvlF5Dlx7
	 6inn3nzqPF18/AmMG8zg21CDbttnRU5OLYRAYvQg7oYedlXUqccE4GDPbIzz1LhTBE
	 r3Ho1aegqR+Sg==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39b28814916so11925111fa.2
        for <linux-rtc@vger.kernel.org>; Sat, 04 Jul 2026 01:25:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpVXVsq8HluoAysxWMIULRy2j369rOncUg9jLYrEristPqaUmPiN/9NKdsmoR3Sf/o9JFGa4Mt1Y3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFPflRUYuj5cAGwwtS6CjRyB28O77hPTnO4LHxYFpWpUzEbC1+
	3MD3AUhoXlBDbAixGxO7JQmAv9fPJTQriV96S4iehKdVNGvpkiUnBJ8GIZCnMI9WYAaN831XzGz
	o3IOBhwNnf9XUazfnviEN8FmTtg6Y5fc=
X-Received: by 2002:a2e:bcc5:0:b0:39b:35bd:e704 with SMTP id
 38308e7fff4ca-39b53c3ffd6mr4690261fa.7.1783153513431; Sat, 04 Jul 2026
 01:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702-a733-rtc-v3-0-eb2580374de6@baylibre.com> <20260702-a733-rtc-v3-6-eb2580374de6@baylibre.com>
In-Reply-To: <20260702-a733-rtc-v3-6-eb2580374de6@baylibre.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sat, 4 Jul 2026 16:25:07 +0800
X-Gmail-Original-Message-ID: <CAGb2v64C4Xn=V5NQcqZQa=v0KsemsVh+_6g7ed0kHz6C_bzmww@mail.gmail.com>
X-Gm-Features: AVVi8Cco2rDKRY4RtRBz1e78QgPbRDMEhgem8aNt-eUIdWMg4uPicNKKdtWJM8A
Message-ID: <CAGb2v64C4Xn=V5NQcqZQa=v0KsemsVh+_6g7ed0kHz6C_bzmww@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] clk: sunxi-ng: div: add read-only operation support
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

On Thu, Jul 2, 2026 at 4:11=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.com>=
 wrote:
>
> Add support for sunxi-ng read-only dividers. This will be
> useful to the a733 oscillator detection logic.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/sunxi-ng/ccu_div.c | 42 ++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/clk/sunxi-ng/ccu_div.h |  1 +
>  drivers/clk/sunxi-ng/ccu_mux.c |  3 ++-
>  drivers/clk/sunxi-ng/ccu_mux.h |  4 ++++
>  4 files changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_di=
v.c
> index 62d680ccb524..d1c8c7baa12d 100644
> --- a/drivers/clk/sunxi-ng/ccu_div.c
> +++ b/drivers/clk/sunxi-ng/ccu_div.c
> @@ -84,6 +84,36 @@ static int ccu_div_determine_rate(struct clk_hw *hw,
>                                              req, ccu_div_determine_rate_=
helper, cd);
>  }
>
> +static int ccu_rodiv_determine_rate(struct clk_hw *hw,
> +                                   struct clk_rate_request *req)
> +{
> +       struct ccu_div *cd =3D hw_to_ccu_div(hw);
> +       unsigned long val;
> +       u32 reg;
> +       int ret;
> +
> +       reg =3D readl(cd->common.base + cd->common.reg);
> +       val =3D reg >> cd->div.shift;
> +       val &=3D (1 << cd->div.width) - 1;
> +
> +       req->rate =3D ccu_mux_helper_unapply_prediv(&cd->common, &cd->mux=
, -1,
> +                                                 req->rate);
> +
> +       if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
> +               req->rate *=3D cd->fixed_post_div;
> +
> +       ret =3D divider_ro_determine_rate(hw, req, cd->div.table,
> +                                       cd->div.width, cd->div.flags, val=
);
> +
> +       if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
> +               req->rate /=3D cd->fixed_post_div;
> +
> +       req->rate =3D ccu_mux_helper_apply_prediv(&cd->common, &cd->mux, =
-1,
> +                                               req->rate);
> +
> +       return ret;
> +}
> +
>  static int ccu_div_set_rate(struct clk_hw *hw, unsigned long rate,
>                            unsigned long parent_rate)
>  {
> @@ -143,3 +173,15 @@ const struct clk_ops ccu_div_ops =3D {
>         .set_rate       =3D ccu_div_set_rate,
>  };
>  EXPORT_SYMBOL_NS_GPL(ccu_div_ops, "SUNXI_CCU");
> +
> +const struct clk_ops ccu_rodiv_ops =3D {
> +       .disable        =3D ccu_div_disable,
> +       .enable         =3D ccu_div_enable,
> +       .is_enabled     =3D ccu_div_is_enabled,
> +
> +       .get_parent     =3D ccu_div_get_parent,
> +
> +       .determine_rate =3D ccu_rodiv_determine_rate,
> +       .recalc_rate    =3D ccu_div_recalc_rate,
> +};
> +EXPORT_SYMBOL_NS_GPL(ccu_rodiv_ops, "SUNXI_CCU");
> diff --git a/drivers/clk/sunxi-ng/ccu_div.h b/drivers/clk/sunxi-ng/ccu_di=
v.h
> index be00b3277e97..a30a92780a05 100644
> --- a/drivers/clk/sunxi-ng/ccu_div.h
> +++ b/drivers/clk/sunxi-ng/ccu_div.h
> @@ -300,5 +300,6 @@ static inline struct ccu_div *hw_to_ccu_div(struct cl=
k_hw *hw)
>  }
>
>  extern const struct clk_ops ccu_div_ops;
> +extern const struct clk_ops ccu_rodiv_ops;
>
>  #endif /* _CCU_DIV_H_ */
> diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mu=
x.c
> index 766f27cff748..e2d6833a6d33 100644
> --- a/drivers/clk/sunxi-ng/ccu_mux.c
> +++ b/drivers/clk/sunxi-ng/ccu_mux.c
> @@ -68,13 +68,14 @@ unsigned long ccu_mux_helper_apply_prediv(struct ccu_=
common *common,
>  }
>  EXPORT_SYMBOL_NS_GPL(ccu_mux_helper_apply_prediv, "SUNXI_CCU");
>
> -static unsigned long ccu_mux_helper_unapply_prediv(struct ccu_common *co=
mmon,
> +unsigned long ccu_mux_helper_unapply_prediv(struct ccu_common *common,
>                                             struct ccu_mux_internal *cm,
>                                             int parent_index,
>                                             unsigned long parent_rate)
>  {
>         return parent_rate * ccu_mux_get_prediv(common, cm, parent_index)=
;
>  }
> +EXPORT_SYMBOL_NS_GPL(ccu_mux_helper_unapply_prediv, "SUNXI_CCU");

This does not need to be exported since all the base clocks build into
one module. And maybe it shouldn't as we probably don't want individual
clock drivers implementing ops.


Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

>  int ccu_mux_helper_determine_rate(struct ccu_common *common,
>                                   struct ccu_mux_internal *cm,
> diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_mu=
x.h
> index c94a4bde5d01..272a2c36a8f2 100644
> --- a/drivers/clk/sunxi-ng/ccu_mux.h
> +++ b/drivers/clk/sunxi-ng/ccu_mux.h
> @@ -134,6 +134,10 @@ unsigned long ccu_mux_helper_apply_prediv(struct ccu=
_common *common,
>                                           struct ccu_mux_internal *cm,
>                                           int parent_index,
>                                           unsigned long parent_rate);
> +unsigned long ccu_mux_helper_unapply_prediv(struct ccu_common *common,
> +                                           struct ccu_mux_internal *cm,
> +                                           int parent_index,
> +                                           unsigned long parent_rate);
>  int ccu_mux_helper_determine_rate(struct ccu_common *common,
>                                   struct ccu_mux_internal *cm,
>                                   struct clk_rate_request *req,
>
> --
> 2.47.3
>
