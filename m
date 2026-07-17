Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049552F7F02;
	Fri, 17 Jul 2026 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784302807; cv=none; b=hTCfJvvB85O3RKJ0t4+d58UXQDrCJuNGeWCU9ldi5vGQXt44vcsxKVSh4WcF5XIj3eOZU5AfZgvU2PMrxlVyq9pibG99i/osXA0EwJUMX51eL2hC88XulkTw3nOnzRpk3Z2EyDRGaLTkoXYdRsK+KawG4ZCJU/1KHrhiJtA/G5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784302807; c=relaxed/simple;
	bh=vtK61xJMiEJMYpu7nNFrb6vw2/PWQ+Y0YGwGnBOhtsU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lU0xQDz3stiPyrr4TAYZo0zLSncRjolC7+hKx6rpEkwNBDJCnxVW7eUBqhVuBlPdgqgBHf5hkxqCTU8/xGZLOsGzkSN8BL9y0R0SnPBFh5D4AgtVGo2OasIW8RS13Ycvf5Y/gpsuNRtbPb5D3ljr2Rm9Ywnm0VBLpkorPLDVnfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WykY+3gH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WykY+3gH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444E41F000E9;
	Fri, 17 Jul 2026 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784302805;
	bh=IYQbjKkcN5rEQRbPBCFllWyIyfp70MK4yhulBooLxg4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WykY+3gHfslwU5GtQrAMJOTSXnF10wxW2n6WXXNcIRNvl8whL6V8UPWLGgM156UGy
	 pnTf3eZVH0F8Ci2WbI8xTz6JArKNK/d/iP8Uj/UzKNtKOnPsQ12qVaMs1uwraAEpXc
	 BQO+NpSlF1Gw85lFZjXto9ZejKsXkyqYIfB1py1vOnRaCd3pUwlzZ241aK2IpFnlmQ
	 jVofoh8jxZs0S/AFnTWQDWRoVecTxoJYP4k8dqlZJGn/FihqFACB0E/X59+ZaF9MYq
	 OUgYBSsIKUSfrs3/Z3KaUrfksDyd8DveqwQdETZx1S4gc3owv2rAixolkzf3hvc0wt
	 XW8VRkfHSEfpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/4] clk: sunxi-ng: div: add read-only operation
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: robh@kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260717-a733-rtc-v5-2-3874cc26abf7@baylibre.com>
References: <20260717-a733-rtc-v5-0-3874cc26abf7@baylibre.com>
 <20260717-a733-rtc-v5-2-3874cc26abf7@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 15:40:04 +0000
Message-Id: <20260717154005.444E41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Missing `.set_parent` in `ccu_rodiv_ops` leads to silent software-=
hardware clock tree desynchronization during reparenting.

Pre-existing issues:
- [High] Unvalidated hardware register read passed to `divider_ro_determine=
_rate()` can cause a divide-by-zero kernel panic.
--

--- Patch [2]: [PATCH v5 2/4] clk: sunxi-ng: div: add read-only operation s=
upport ---
commit d732b1bc291c593bb4873ef5f04edb2855137f30
Author: Jerome Brunet <jbrunet@baylibre.com>

clk: sunxi-ng: div: add read-only operation support

This commit adds support for read-only dividers in the sunxi-ng clock
driver. It introduces a new ccu_rodiv_ops structure and updates the rate
determination helper to handle the read-only flag.

> diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_di=
v.c
> index 62d680ccb524b..93cb4cb93abe8 100644
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
This is a pre-existing issue, but could this unvalidated register read caus=
e=20
a divide-by-zero kernel panic?

In ccu_div_determine_rate_helper(), the raw register value is read and
passed as 'val' to divider_ro_determine_rate(). If the register contains
an unexpected value from the bootloader (or 0 when CLK_DIVIDER_ONE_BASED
is set) that _get_div() maps to 0, divider_ro_determine_rate() lacks a=20
zero-check before calculating:

    req->rate =3D DIV_ROUND_UP_ULL((u64)req->best_parent_rate, div);

> +
> +	} else {

[ ... ]

> @@ -143,3 +157,15 @@ const struct clk_ops ccu_div_ops =3D {
>  	.set_rate	=3D ccu_div_set_rate,
>  };
>  EXPORT_SYMBOL_NS_GPL(ccu_div_ops, "SUNXI_CCU");
> +
> +const struct clk_ops ccu_rodiv_ops =3D {
> +	.disable	=3D ccu_div_disable,
> +	.enable		=3D ccu_div_enable,
> +	.is_enabled	=3D ccu_div_is_enabled,
> +
> +	.get_parent	=3D ccu_div_get_parent,
> +
> +	.determine_rate	=3D ccu_div_determine_rate,
> +	.recalc_rate	=3D ccu_div_recalc_rate,
> +};

[Severity: High]
Could the missing .set_parent callback in ccu_rodiv_ops lead to a silent
desynchronization between the software clock tree and the hardware?

The struct provides reparenting capabilities via .get_parent and
.determine_rate, but omits .set_parent. If a rate request causes
ccu_mux_helper_determine_rate() to evaluate and select a new parent, the
Common Clock Framework will apply this new parent in software but skip
updating the hardware since .set_parent is NULL.=20

This would leave all downstream clock rate calculations incorrect.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717-a733-rtc-v=
5-0-3874cc26abf7@baylibre.com?part=3D2
