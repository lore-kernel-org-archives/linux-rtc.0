Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB863B71CC;
	Thu, 23 Jul 2026 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800214; cv=none; b=pJP+xwsXmEoFBgX8J4DhnQoA62v4iBxjrrOoMDpUlKN7zmsNcy+KVnANuyhz+lw7R6A+m2JW47FRhydf1sihZ5mXsEH+yNEdg2bWkg3w7KD3Wh9ym3bKX6NujHWK5c/oq7ZORR/Zc1ouu6rnyQovBr5YZRL80zyKmRzR6rLrTnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800214; c=relaxed/simple;
	bh=9d286wufFg4BYvO+IYvndYl5PLOckPt9w0zHoD55G8I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gY7b5ESTxa/AmL26H/6D85RNNfkgKme5n8V0dX/iDBQsNIhWBWHrGSRdQe+fRQOSdJ+3GRGurW62I9MXPzcYjW4xC5itgZ/oWxzbfhIrTKTG6ITB8EiaxYb9WLXgxCHJcBM1zvHZY6Y5Wt/5xYGO9dUOlGyciQt0WFz9uOjdygw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fe6jMUOi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fe6jMUOi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D771F000E9;
	Thu, 23 Jul 2026 09:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784800213;
	bh=ALyWXBxSFLG1s/pKUU/Lnm1O/nLgstFcebqi7K4fklQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fe6jMUOigm7YB526LdeyDfyPoS1euH2JrtCwrD0RW4sb7Cnn0rS/Oh3LcqJsisy8F
	 1ePdTpNxbdhIl74MO1wW/7MtkkDpNhzpntIvcIb6lnCjnphVfZPCaL6Dm8SZGeYNMl
	 kDVWC8h9WS84R5CG/z2XHPA5C6kl06p+TXjbUhaWbfRmTqjIPfJDHTUseHKkG846Kg
	 2G7dBD1SIhFOrlCImbpAsuP0p6thOU+I90g6K9nQYbbU/MDZDRd2tOlvtr69wLI0ai
	 F73cdRPkLXBlNE0IGu3sr+03dU5tMw9icjko333jGkIhq6/bbnc46ijBf2O2K1stbL
	 sbMf9sVRN2ysg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/4] clk: sunxi-ng: div: add read-only operation
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org
In-Reply-To: <20260723-a733-rtc-v7-2-8fd68aab94ae@baylibre.com>
References: <20260723-a733-rtc-v7-0-8fd68aab94ae@baylibre.com>
 <20260723-a733-rtc-v7-2-8fd68aab94ae@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 09:50:12 +0000
Message-Id: <20260723095012.E2D771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential division-by-zero kernel panic in `divider_ro_determine_r=
ate` if the hardware register contains an invalid or unmapped value.
--

--- Patch [2]: [PATCH v7 2/4] clk: sunxi-ng: div: add read-only operation s=
upport ---
commit 3b6cfd40ff69176dfa1e8841c3c6d40584ab1369
Author: Jerome Brunet <jbrunet@baylibre.com>

clk: sunxi-ng: div: add read-only operation support

Add support for sunxi-ng read-only dividers. This will be
useful to the a733 oscillator detection logic.

> diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_di=
v.c
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
This is a pre-existing issue, but could this expose a division by zero in
divider_ro_determine_rate() if the hardware register yields an invalid valu=
e?

The new code reads a raw divider value from the hardware register and passes
it directly into divider_ro_determine_rate(). If the register is in an
uninitialized or corrupted state containing a value not present in the
associated table, the internal _get_div() helper can return 0.

Unlike divider_recalc_rate() which safely checks the divisor,
divider_ro_determine_rate() directly evaluates DIV_ROUND_UP_ULL(..., div):

drivers/clk/clk-divider.c:divider_ro_determine_rate() {
    ...
    div =3D _get_div(table, val, flags, width);
    ...
    req->rate =3D DIV_ROUND_UP_ULL((u64)req->best_parent_rate, div);
    ...
}

Since this macro performs a division, a divisor of 0 triggers a
divide-by-zero. Should the hardware value or the resulting divisor be
validated to prevent this regression during clock initialization?

> +
> +	} else {
> +		ret =3D divider_determine_rate(&cd->common.hw, req, cd->div.table,
> +					     cd->div.width, cd->div.flags);
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-a733-rtc-v=
7-0-8fd68aab94ae@baylibre.com?part=3D2
