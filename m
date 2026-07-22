Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E003769F6;
	Wed, 22 Jul 2026 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784732431; cv=none; b=NrCYhY9RZuMA6mj4RjY/Ud29s5Y6mghWkQpBvJNavx1ed4IyOYjQsGB24KHGEP8DTbRhtz/QTIpofZmuScuHMjgobG4CcKrQY5u0iqX9WGnJXorRF8CcSyoynkGMPJzqPFqH929hlDHqll7V84tS/FUkJxQe4yBWRVJJlf3Mz4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784732431; c=relaxed/simple;
	bh=o4FBVQ03SZ7iL1N9RDLHB+2ozQoK8T2VSZ2dO1Kfa/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fR9GInZaOkq717ayiJm5+Zus0dxsC3wl4sJ3eNP2EhpgVBFxN0Qy33uhMSLSl0GCOqYK4KDUXQwDi+Ibbr39bpqCFYxMjfqFgjvgffyV61p7gA0U5DDl+X1yrKyddF+fTUfROK/Rze6D8otaI8e44POl5CorLw2TRBE4J/0ldes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQwoBZkp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQwoBZkp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C081F000E9;
	Wed, 22 Jul 2026 15:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784732428;
	bh=w7Sxilr8rHTa4ZKeCPucJAsf8LI/EtstbcWpON066To=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lQwoBZkpmwf7YKRjoQI1UHzVhXgHuGvTmvpmqyFoiYUwg65i4pqEyo4uXdOH1lek3
	 XKICsAUZ1T6pf4ZY/a3iSpA6YMDT73zq2HrqDrBlIau9bqTd2l0rVhsQ09YXvPrJsM
	 iNApudqrevxOLZSxWgSTpJCMST/B2Q2MsgoNMq2A7bnnFH3XZfUGef5j+gyl6tMCeo
	 bC6yiDhTwUwn4aIytZqvcZ4g67GCMGB2AQF6QfSNd78vxo20rEpTrzjnznmm3AGD2d
	 V2v+k2Apg5Eg0t4V1Nl21aSsR7q/PikDo7pz9oCeBqnwpd9+HxVJp7DRvBAcJSc4JO
	 BTR+vMHPYQQzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/4] clk: sunxi-ng: div: add read-only operation
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260722-a733-rtc-v6-2-631cca28cc9a@baylibre.com>
References: <20260722-a733-rtc-v6-0-631cca28cc9a@baylibre.com>
 <20260722-a733-rtc-v6-2-631cca28cc9a@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 15:00:27 +0000
Message-Id: <20260722150028.47C081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Potential division by zero due to unvalidated hardware register va=
lue propagating to `divider_ro_determine_rate`.
- [Low] Undocumented API exposure and dead code due to exporting `ccu_mux_h=
elper_unapply_prediv`.
--

--- Patch [2]: [PATCH v6 2/4] clk: sunxi-ng: div: add read-only operation s=
upport ---
commit 14ce0824b93b836a325dbcab101b0319dddbe86a
Author: Jerome Brunet <jbrunet@baylibre.com>

clk: sunxi-ng: div: add read-only operation support

Add support for sunxi-ng read-only dividers. This will be
useful to the a733 oscillator detection logic.

> diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_di=
v.c
> index 62d680ccb524b..c385e0160f13b 100644
> --- a/drivers/clk/sunxi-ng/ccu_div.c
> +++ b/drivers/clk/sunxi-ng/ccu_div.c
> @@ -20,8 +20,22 @@ static int ccu_div_determine_rate_helper(struct ccu_mu=
x_internal *mux,
>  	if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		req->rate *=3D cd->fixed_post_div;
> =20
> -	ret =3D divider_determine_rate(&cd->common.hw, req, cd->div.table,
> -				     cd->div.width, cd->div.flags);
> +	if (cd->div.flags & CLK_DIVIDER_READ_ONLY) {
> +		unsigned long val;
> +		u32 reg;
> +
> +		reg =3D readl(cd->common.base + cd->common.reg);
> +		val =3D reg >> cd->div.shift;
> +		val &=3D (1 << cd->div.width) - 1;
> +
> +		ret =3D divider_ro_determine_rate(&cd->common.hw, req, cd->div.table,
> +						cd->div.width, cd->div.flags, val);

[Severity: High]
Can this lead to a division by zero in divider_ro_determine_rate()?

When ccu_div_determine_rate_helper() reads the hardware register and passes
the unvalidated value to divider_ro_determine_rate(), _get_div() could
return 0 if the register value is 0 (with CLK_DIVIDER_ONE_BASED) or if the
value is not found in the table.

Unlike divider_recalc_rate(), divider_ro_determine_rate() does not have an
if (!div) check:

drivers/clk/clk-divider.c:divider_ro_determine_rate() {
    ...
    div =3D _get_div(table, val, flags, width);
    ...
    req->rate =3D DIV_ROUND_UP_ULL((u64)req->best_parent_rate, div);
    ...
}

Will this cause a panic if the hardware is in an unexpected reset state or
misconfigured?

[ ... ]

> diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mu=
x.c
> index 4503c9780c39f..12bfc99c91721 100644
> --- a/drivers/clk/sunxi-ng/ccu_mux.c
> +++ b/drivers/clk/sunxi-ng/ccu_mux.c
> @@ -67,7 +67,7 @@ unsigned long ccu_mux_helper_apply_prediv(struct ccu_co=
mmon *common,
>  	return parent_rate / ccu_mux_get_prediv(common, cm, parent_index);
>  }
> =20
> -static unsigned long ccu_mux_helper_unapply_prediv(struct ccu_common *co=
mmon,
> +unsigned long ccu_mux_helper_unapply_prediv(struct ccu_common *common,
>  					    struct ccu_mux_internal *cm,
>  					    int parent_index,
>  					    unsigned long parent_rate)

[Severity: Low]
Is this function intended to be exported?

The commit message only mentions adding support for read-only operation in
sunxi-ng dividers and provides no justification for modifying mux helpers.

Additionally, ccu_mux_helper_unapply_prediv appears to be completely unused
outside of ccu_mux.c in this patch series. Could this change be an
undocumented API export that accidentally leaked from earlier development?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-a733-rtc-v=
6-0-631cca28cc9a@baylibre.com?part=3D2
