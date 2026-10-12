Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF573ED11B;
	Mon, 12 Oct 2026 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791800377; cv=none; b=t6FPZ2FY9ZSEsakP7ot2jlk4efnmFbE81A7ixC6ytXwjTsSBfspuSkiM1EcSh2TMlrH7EeSznFH6OjgJ0o/srByjNGEDhtgryvYNNYPe9iDTrX2lv7Bo1U4OtlXUNtxOm/jL2NSCj/EIU0dwkJQWQpHSKPZ5A/j54xClSzZSKyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791800377; c=relaxed/simple;
	bh=uRmfa/ccrE/pLG20bedCyFP+1gx3AxwoScnTUK22Bic=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=bjkgNqqPL2dOttFAmmcWHQlKm/QxAcCFhTDtC3WpGXxNuCEpXAAWpcrnmXRqKpy9Dtuc2NYFgashDGgCmUEWFZ+3TdSjVLuyNqugZCC2F7Vi90DOnUaZr9ycBMGks9mm5TNgaX3+lEyoJipJsVc9u/uhBKQsimS8IydJxKIzXzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhK42Y27; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhK42Y27"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB53B1F0089B;
	Mon, 12 Oct 2026 10:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791800366;
	bh=DTyxrAdMMx+C7Q1ABG8GATN9ef2GvzDsTwF2mpWlaOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IhK42Y27PpDb4+NjGS3/6tlYQJMOz/z7YH9D1p0e9KxCdNoLEHvXjeZjrDzKRtqMJ
	 U2zj5XLsfjUO3hPwrcUv9ZhOoPnj2ubPpQeYB4thEKcAI/nFaFYQmH3G2bQ5Sj0L7S
	 9PomD5FJs2KHA6amX0yWODW+CfsB66pE1XpO15Hpn8zLfAxwdCHJiES6k2v0nENtrz
	 Ovdo0zGdDXByIPUpNzcI04Jdkhb9iq6kUp3K5Xme7LedLU1jAIRiMg1G9Pfxx/ZKjN
	 zv5Gn+0xjRp7Xf512Hrwp0UMFRCI9wYRCcDChB1oErgdLByii3pBEb41oHAYM0cYJk
	 BdLLyWKdTZD3g==
Message-ID: <sashiko-outbox-167946@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/11] rtc: sun6i: add Allwinner B288 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pablo Mazzini" <pmazzini@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org
In-Reply-To: <20261012100816.331033-7-pmazzini@gmail.com>
References: <20261012100816.331033-1-pmazzini@gmail.com>
 <20261012100816.331033-7-pmazzini@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 10:19:25 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] rtc: sun6i: missing ERR_PTR check causes crash in probe on clk_reg=
ister failure
- [Medium] rtc: sun6i: resource leak of losc clock on initialization error =
path
- [Low] rtc: sun6i: memory leak of rtc structure in sun6i_rtc_clk_init erro=
r path
--

commit 903d00f6b5cb6afede9ad6ad5fca01853d776ce4
Author: Pablo Mazzini <pmazzini@gmail.com>
Subject: rtc: sun6i: add Allwinner B288 compatible

This commit adds support for the Allwinner B288 RTC by reusing the A23
clock configuration. It maps the new compatible string
allwinner,sun8i-b288-rtc to the existing initialization functions.

> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index 7fc60880e4094..05004e80ac089 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -350,6 +350,10 @@ static void __init sun8i_a23_rtc_clk_init(struct dev=
ice_node *node)
>  CLK_OF_DECLARE_DRIVER(sun8i_a23_rtc_clk, "allwinner,sun8i-a23-rtc",
>  		      sun8i_a23_rtc_clk_init);
> =20
> +/* The B288 RTC clocks are the same as the A23's */
> +CLK_OF_DECLARE_DRIVER(sun8i_b288_rtc_clk, "allwinner,sun8i-b288-rtc",
> +		      sun8i_a23_rtc_clk_init);
> +

[Severity: High]
Does adding this compatible string expose an issue in the error handling
of sun6i_rtc_clk_init on registration failure?

If clk_register fails for rtc->losc, the function returns an error
pointer and jumps to the err_register label. Since the global sun6i_rtc
pointer is already assigned to the allocated rtc struct earlier:

sun6i_rtc_clk_init()
    /* Yes, I know, this is ugly. */
    sun6i_rtc =3D rtc;
    ...
    rtc->losc =3D clk_register(NULL, &rtc->hw);
    if (IS_ERR(rtc->losc)) {
        pr_crit("Couldn't register the LOSC clock\n");
        goto err_register;
    }

The probe function sun6i_rtc_probe later fetches this dangling pointer:

sun6i_rtc_probe()
    struct sun6i_rtc_dev *chip =3D sun6i_rtc;
    ...
    clk_prepare_enable(chip->losc);

Can this lead to a kernel panic when clk_prepare_enable attempts to
dereference the error pointer stored in chip->losc?

[Severity: Medium]
Additionally, if clk_register succeeds for rtc->losc but a later clock
registration fails, triggering the jump to err_register, does this
cleanup path leak the rtc->losc clock?

sun6i_rtc_clk_init()
err_register:
    clk_hw_unregister_fixed_rate(rtc->int_osc);
err:
    kfree(clk_data);

The err_register path unregisters rtc->int_osc but appears to omit
calling clk_unregister(rtc->losc).

[Severity: Low]
Does the err cleanup path also leak the dynamically allocated rtc
structure?

sun6i_rtc_clk_init()
    rtc =3D kzalloc_obj(*rtc);
    ...
err:
    kfree(clk_data);

The error path frees clk_data but seems to omit freeing the allocated
rtc structure.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012100816.3310=
33-1-pmazzini@gmail.com?part=3D6
