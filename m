Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14390429CF0;
	Thu, 23 Jul 2026 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800703; cv=none; b=mgzcO5kagngDlRvsbuDaDT9K8ZuvuWh0tGmn9YfsGj5xl3ZzC1h1+vKRbGydsYIwBxJX4MDwONMQcilOKs8vsXmOWPk1zLTTSJuPChELPP88v/UyRUvZs91bPvIxS+RN7Qq+WMQV1u1WgdA9uAz04avcPnvvX8Tx18swfUmaIHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800703; c=relaxed/simple;
	bh=I1uF0h9omJA3Qml7I+ERsHabBYdrB1lZStJDNzDocBw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=esqeg2NTmAOXSOocW1WlzFFPgR33jZYx6l3b4yC8D230K/stRrJ8yBLYTOX3PhojYAsA3/Fl1cdRAlKPqaPH/LyaZJfRV5ipzhFCWYsLAQMd1KGYgP8cThSSGoavN5R1MbcEaOohExe+IMuN0hdtu0XZ0XEoTnmHkJWzNL30MDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rk5C0Si5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rk5C0Si5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629AF1F000E9;
	Thu, 23 Jul 2026 09:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784800701;
	bh=bqotnRp67tcxSmFAjK44EtUzy+HE60f0IWo6w6FheLw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rk5C0Si50Ce29VCOvGqgm9v4LkN/kxzUXVLpKYvhmnudaf6XegdMpZOTrsX4f1uwJ
	 WseDyWvPf4ypZWN9lEuJY5pX8yfArblAyV7/I1uBVt3glucims6SmPyMkDmFldwDxK
	 e4ywcfl2tGohLeNVFTgxi8H++pZbnvl4XgewLVI0U+o34hnGPc5vOUx94GHJ1xQn5Y
	 TAFhYXqqfavpn3gfyoUbuUx5mXEGMqtTl3H4NhjBrf6fopToahErUCKdYWRUDHDf49
	 tIh9DdU0R62qdmwFAWXUJoA8dy/nFWynmk8Ud8+c0uTaJqwyi3/i2LPvkL2Degs7Fa
	 l2IBOM1ZkQMaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/4] clk: sunxi-ng: mux: fix determine helper rate
 propagation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260723-a733-rtc-v7-1-8fd68aab94ae@baylibre.com>
References: <20260723-a733-rtc-v7-0-8fd68aab94ae@baylibre.com>
 <20260723-a733-rtc-v7-1-8fd68aab94ae@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 09:58:21 +0000
Message-Id: <20260723095821.629AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Treating the pre-divider as a post-divider changes the rounding or=
der, causing a mathematical mismatch between `determine_rate` and `recalc_r=
ate`.

Pre-existing issues:
- [High] `ccu_mux_get_prediv` fails to translate hardware indices to logica=
l indices for the active parent, breaking pre-dividers in `recalc_rate`.
--

--- Patch [1]: [PATCH v7 1/4] clk: sunxi-ng: mux: fix determine helper rate=
 propagation ---
commit 3ac5416eb08e665a33aeec5afae741b08d4fdb57
Author: Jerome Brunet <jbrunet@baylibre.com>

clk: sunxi-ng: mux: fix determine helper rate propagation

Applying the pre divider on the parent rate is wrong because, while
handling rate propagation through determine_rate(), the framework will
likely round the parent rate again while cycling through the possibilities,
throwing away the prediv applied. This means, the parent rate will then
be wrong when the prediv is unapplied from a parent rate on which it
was never applied to begin with.

> diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mu=
x.c
> index 09230728c4009..4503c9780c39f 100644
> --- a/drivers/clk/sunxi-ng/ccu_mux.c
> +++ b/drivers/clk/sunxi-ng/ccu_mux.c
> @@ -92,66 +92,65 @@ int ccu_mux_helper_determine_rate(struct ccu_common *=
common,
>  		struct clk_rate_request adj_req =3D *req;
> =20
>  		best_parent =3D clk_hw_get_parent(hw);
> -		best_parent_rate =3D clk_hw_get_rate(best_parent);
> -
> +		adj_req.best_parent_rate =3D clk_hw_get_rate(best_parent);
>  		adj_req.best_parent_hw =3D best_parent;
> -		adj_req.best_parent_rate =3D ccu_mux_helper_apply_prediv(common, cm, -=
1,
> -								       best_parent_rate);
> +
> +		/*
> +		 * This effectively treats the predivider as a postdivider.
> +		 * It stays mathematically correct and ensures whatever
> +		 * round() will do stays correct while walking the tree.
> +		 * It may query the parent rate too while handling rate
> +		 * propagation.
> +		 */
> +		adj_req.rate =3D ccu_mux_helper_unapply_prediv(common, cm, -1,
> +							     req->rate);
> =20
>  		ret =3D round(cm, &adj_req, data);
>  		if (ret)
>  			return ret;
> =20
> -		best_rate =3D adj_req.rate;
> -
>  		/*
> -		 * best_parent_rate might have been modified by our clock.
> -		 * Unapply the pre-divider if there's one, and give
> -		 * the actual frequency the parent needs to run at.
> +		 * parent_rate might have been modified by our clock as part
> +		 * of the rate propagation mechanism. Same goes below.
>  		 */
> -		best_parent_rate =3D ccu_mux_helper_unapply_prediv(common, cm, -1,
> -								 adj_req.best_parent_rate);
> +		best_parent_rate =3D adj_req.best_parent_rate;
> +		best_rate =3D ccu_mux_helper_apply_prediv(common, cm, -1,
> +							adj_req.rate);

[Severity: High]
Does treating the pre-divider as a post-divider here cause a mathematical
mismatch between determine_rate() and recalc_rate()?

Because integer division with round-up does not commute, this inverted
calculation order yields different results compared to recalculating the ra=
te.

For example, given a parent rate of 100 Hz, pre-divider 3, and main divider=
 8
for a target rate of 4 Hz:

- determine_rate() evaluates DIV_ROUND_UP(100, 8) / 3 =3D 13 / 3 =3D 4 Hz.
- recalc_rate() evaluates DIV_ROUND_UP(100 / 3, 8) =3D DIV_ROUND_UP(33, 8) =
=3D 5 Hz.

Could this violate the clock framework's requirement that determine_rate()
accurately predicts recalc_rate(), potentially causing rate deviation warni=
ngs
or infinite loops during rate setting?


[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the pre-divi=
der
logic, I noticed a potential issue in how hardware indices are handled when
the parent_index is less than 0.

drivers/clk/sunxi-ng/ccu_mux.c:ccu_mux_get_prediv() {
    ...
    if (parent_index < 0) {
        parent_index =3D reg >> cm->shift;
        parent_index &=3D (1 << cm->width) - 1;
    }
    ...
    for (i =3D 0; i < cm->n_fixed_predivs; i++)
        if (parent_index =3D=3D cm->fixed_predivs[i].index)
            return cm->fixed_predivs[i].div;
    ...
}

Does this fail to translate hardware indices to logical indices for the act=
ive
parent?

When ccu_mux_get_prediv() is called with parent_index < 0 (e.g. from
recalc_rate), it reads the raw hardware index from the register. It then
compares this directly against fixed_predivs[i].index, which is populated w=
ith
logical indices.

Could this cause recalc_rate() to report an incorrect clock rate by falling=
 back
to a pre-divider of 1 instead of the configured pre-divider for clocks with=
 both
a hardware mapping .table and fixed/variable predividers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-a733-rtc-v=
7-0-8fd68aab94ae@baylibre.com?part=3D1
