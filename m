Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D204C9E04
	for <linux-rtc@vger.kernel.org>; Fri, 18 Sep 2026 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726556; cv=none; b=WpSqg2j93aEvvp3FVs+Fw5Lyg9KrdL8ld4a+8mOF42UuHY74UVKNoDzKjP5R6esAaF33UwJgkBSJO4+jm5t/zADVWIlAnf2FHqXsg1g5JsNvZjG4nKUTxtrRDty4heY6Q+FAfVb0TiGJzRXW6Ps+ZfWAPn1auPe1BuxCcs8kQrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726556; c=relaxed/simple;
	bh=BZ5v5QLuVI9g5zM+OoppzBFIef2WHc49pT21MiVvtYo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cZuSLUcw7xHXTLEkTdNVvlcVlTteB8vR3bpvkfo3R8dE/ynR2slc7cBg2mRloidiB+lRCJRn/T4pXPd5NqafMDBqqhKmL3HrQfY/RKJDayxrbFXEqJOmHhvS1XSAVrKACynYODfBI1lhfSNeOgzX45ZTxIMVN6Cf8GUtdkOVKgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojCNuI9g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojCNuI9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B78A1F00893;
	Fri, 18 Sep 2026 10:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726553;
	bh=NUchDmUVN22SzoathcZPEQUex+SpqEoJI8CrUYtjgUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ojCNuI9giIHiV1rBj9rkg0hrQjGtOwGrEJbUKAilW6PNsrEgQrXDDurRIcXXX2M/+
	 3/7UVOhMIWcWHtSILfTX3QQQDsWvdSH+XUiCsgjinOIEeK7FZmhojCTVV5vPANgV61
	 RvxaHN0Q5lLFCFzGf0CUo+nicHPulGp64lfIlfMz74AbOurlEkIpDThWpZkJ/Au7mp
	 MXWa0IZa0mL/ZiLSMgHvz9JUjJnMbkyXA2A7h+htVSQjDdcKaF8eJOl0HW779dN9eN
	 uXu3Q29vK7dZkd425lAP7rRREN5yMVReVx0sKCJ2vKC6i4wHvOukKYC6KAzpc9QIDk
	 ZebsMtIH4oUiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rtc: stm32: fix clock leak on pinctrl probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cong Nguyen" <congnt264@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260918095853.1348694-1-congnt264@gmail.com>
References: <20260918095853.1348694-1-congnt264@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:15:52 +0000
Message-Id: <20260918101553.3B78A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] rtc: stm32: NULL pointer dereference in stm32_rtc_pinmux_action_ls=
co()
- [High] rtc: stm32: clk_lsco and OF provider leak on probe error
--

commit c5ee543f4626bb3238dc601e2915f1d27f3674f2
Author: Cong Nguyen <congnt264@gmail.com>

rtc: stm32: fix clock leak on pinctrl probe failure

A failing devm_pinctrl_register_and_init() or pinctrl_enable() in
stm32_rtc_probe() returns directly instead of going through err:,
leaking rtc_ck/pclk -- and since -EPROBE_DEFER is routine here, each
deferred retry leaks another.

Link: https://lore.kernel.org/r/20260914135401.373D91F000FF@smtp.kernel.org

> diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
> index d4ebf3eb54aa9..457f66663ba59 100644
> --- a/drivers/rtc/rtc-stm32.c
> +++ b/drivers/rtc/rtc-stm32.c
> @@ -1137,6 +1137,20 @@ static int stm32_rtc_probe(struct platform_device =
*pdev)
>  	if (ret)
>  		goto err;
> =20
> +	stm32_rtc_clean_outs(rtc);
> +
> +	ret =3D devm_pinctrl_register_and_init(&pdev->dev, &stm32_rtc_pdesc, rt=
c, &pctl);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "pinctrl register failed");
> +		goto err;
> +	}
> +
> +	ret =3D pinctrl_enable(pctl);

[Severity: High]
Does this code trigger a null pointer dereference if the 'lsco' function is
configured as a pinmux hog in the device tree?

Calling pinctrl_enable() synchronously claims hogs, which invokes the pinmux
callback. If 'lsco' is claimed, stm32_rtc_pinmux_action_lsco() will be
called:

stm32_rtc_pinmux_action_lsco() {
    struct device *dev =3D rtc->rtc_dev->dev.parent;

Since devm_rtc_device_register() hasn't been called yet in the new probe
sequence, rtc->rtc_dev is still NULL, which will cause a kernel panic during
probe.

> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "pinctrl enable failed");
> +		goto err;
> +	}
> +
>  	rtc->irq_alarm =3D platform_get_irq(pdev, 0);
>  	if (rtc->irq_alarm <=3D 0) {
>  		ret =3D rtc->irq_alarm;
>  		goto err;

[Severity: High]
Can a failure here leak the manually registered clock gate and OF provider?

If 'lsco' is claimed by pinctrl_enable() above, it registers a clock gate a=
nd
an OF provider:

stm32_rtc_pinmux_action_lsco() {
    ...
    rtc->clk_lsco =3D clk_register_gate(dev, "rtc_lsco", ...);
    of_clk_add_provider(dev->of_node, of_clk_src_simple_get, rtc->clk_lsco);

Because pinctrl setup was moved earlier, any subsequent error such as
platform_get_irq() failing will jump to the err: label. The err: cleanup pa=
th
does not unregister rtc->clk_lsco or the OF provider. This will permanently
leak these resources on routine errors like -EPROBE_DEFER, prevent successf=
ul
re-probing, and can cause a use-after-free later since there is no
of_clk_del_provider() call.

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918095853.1348=
694-1-congnt264@gmail.com?part=3D1
