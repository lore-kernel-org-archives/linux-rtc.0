Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305323148C9
	for <linux-rtc@vger.kernel.org>; Thu, 27 Aug 2026 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818504; cv=none; b=DG/9XqO1BtPi4rE0kplxf0qPoFSD+6VxMrMjVu0UEPgv3KnM4McgZ1G2qWNQRpvZIMlbrC0TkrvBJA7vhqzgeFZ20Kqxq7ZrmceqLouP7lW7wNmMy/6pr29x/6+HlT5Ho2Me3XQzlIQnWDceiK2119vO2gcNiwqrqfUacnMi3Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818504; c=relaxed/simple;
	bh=pD81eLejbh/7qXhANfO+FmqPDG83qsUSyvDefAA6jcE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=si7CoCNf5mXrNEqBAmnoyv5GLb7YrPdMUB6OPkiIXjyicMpkH3mg8viPf3jck+aV2HJQIyFraqJxhDhzC135/uir+4yrebHaVjvEyJSZ2G8qcnTBQNe/eK2XPohMyB+iWXYrkUQ3R+XsH2HY28ldkO0ieR8F13kAdj44G9DAK4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hpgg4Jn3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hpgg4Jn3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300111F000E9;
	Thu, 27 Aug 2026 08:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787818502;
	bh=mH/MBOCxAUmHfFYizS877gkaT/hiqCgHYKbkokBOs7s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hpgg4Jn3Iense9Bq7/ctA/mDnCTjfOF2AIGuPvqgNsMSkxygCIlD3YCM/X1j0L+wd
	 QQegAEsF0QhxGttbqZ8bQ0UiaNiHEHY9ZAJL+EusWILkX9x6sNzSImrp/pFm7b0Xes
	 p4s86KUi/zQzvfv51UwEXJZtJBx34LihCwt84oAol6vS7FjFrr4A/XylmEhT3yd8dv
	 SK0vG4PUE4hAJR5+x+UKuRcKW98LjHD/f1VvUaOBrQOrS1D9+PcWgUhyxqSGJ4jHVL
	 jZzEJC8q47cdIfbyBI3mnmoLEOS6Mzr9987obzD/myhYX9bTn5AJQ9BuZdjTxOS5J4
	 YqocRWBmeWt6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] rtc: ftrtc010: use devm clock APIs to fix
 use-after-disable in remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liu Dalin" <liudalin@kylinsec.com.cn>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <0238203A74C9B9F6+20260827080320.3351155-3-liudalin@kylinsec.com.cn>
References: <20260827021054.0963C1F000E9@smtp.kernel.org>
 <20260827080320.3351155-1-liudalin@kylinsec.com.cn>
 <0238203A74C9B9F6+20260827080320.3351155-3-liudalin@kylinsec.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 08:15:01 +0000
Message-Id: <20260827081502.300111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Replacing devm_clk_get() with devm_clk_get_enabled() incorrectly t=
urns optional clocks into mandatory ones, breaking probe on platforms where=
 the clocks are missing.
- [High] The probe function erroneously returns success (0) if devm_clk_get=
_enabled() returns NULL, silently bypassing device initialization.

Pre-existing issues:
- [High] The interrupt handler unconditionally returns IRQ_HANDLED on a sha=
red IRQ line without verifying if the hardware actually generated the inter=
rupt.
- [High] Reading the RTC time registers sequentially without checking for r=
ollovers can result in reading corrupted/inconsistent time values.
--

commit ccdb9a74dea97cf4316fc81a22f1873e4caa125e
Author: Liu Dalin <liudalin@kylinsec.com.cn>

rtc: ftrtc010: use devm clock APIs to fix use-after-disable in remove
   =20
This commit replaces manual clock management with devm_clk_get_enabled() to
fix a use-after-disable window during driver removal. It also removes the
manual .remove() callback, relying on devres for cleanup.

> diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
> --- a/drivers/rtc/rtc-ftrtc010.c
> +++ b/drivers/rtc/rtc-ftrtc010.c
[ ... ]
> @@ -120,51 +120,33 @@ static int ftrtc010_rtc_probe(struct platform_devic=
e *pdev)
>  		return -ENOMEM;
>  	platform_set_drvdata(pdev, rtc);
> =20
> -	rtc->pclk =3D devm_clk_get(dev, "PCLK");
> -	if (IS_ERR(rtc->pclk)) {
> +	rtc->pclk =3D devm_clk_get_enabled(dev, "PCLK");
> +	if (IS_ERR_OR_NULL(rtc->pclk)) {
>  		dev_err(dev, "could not get PCLK\n");
> -	} else {
> -		ret =3D clk_prepare_enable(rtc->pclk);
> -		if (ret) {
> -			dev_err(dev, "failed to enable PCLK\n");
> -			return ret;
> -		}
> +		return PTR_ERR_OR_ZERO(rtc->pclk);

[Severity: High]
Does this change inadvertently make the previously optional PCLK mandatory?

In the original code, if devm_clk_get() returned an error (like -ENOENT),
it logged a message but safely allowed probe to continue. With this patch,
if devm_clk_get_enabled() returns -ENOENT, PTR_ERR_OR_ZERO() will propagate
that error and abort the probe.

Additionally, if the kernel is configured without CONFIG_HAVE_CLK,
devm_clk_get_enabled() returns NULL. In that scenario, IS_ERR_OR_NULL()
evaluates to true, and PTR_ERR_OR_ZERO(NULL) returns 0.

Will this cause the probe function to immediately return success without
actually registering the RTC device or mapping memory?

>  	}
> -	rtc->extclk =3D devm_clk_get(dev, "EXTCLK");
> -	if (IS_ERR(rtc->extclk)) {
> +	rtc->extclk =3D devm_clk_get_enabled(dev, "EXTCLK");
> +	if (IS_ERR_OR_NULL(rtc->extclk)) {
>  		dev_err(dev, "could not get EXTCLK\n");
> -	} else {
> -		ret =3D clk_prepare_enable(rtc->extclk);
> -		if (ret) {
> -			dev_err(dev, "failed to enable EXTCLK\n");
> -			goto err_disable_pclk;
> -		}
> +		return PTR_ERR_OR_ZERO(rtc->extclk);

[Severity: High]
The same issues with optional clock requirement and silent probe bypass on
NULL apply here for EXTCLK.

[ ... ]
>  	rtc_dev->ops =3D &ftrtc010_rtc_ops;
> =20
>  	sec  =3D readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
>  	min  =3D readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);
>  	hour =3D readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
>  	days =3D readl(rtc->rtc_base + FTRTC010_RTC_DAYS);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for a
hardware clock rollover to corrupt the timestamp being read here?

Since the time registers are read sequentially without any check for
rollover across multiple units, a tick occurring exactly between these
sequential reads could result in erroneously mixing an old higher-order
value with a new lower-order value.

> =20
>  	rtc_dev->range_min =3D (u64)days * 86400 + hour * 3600 + min * 60 + sec;
>  	rtc_dev->range_max =3D U32_MAX + rtc_dev->range_min;
> =20
>  	ret =3D devm_request_irq(dev, rtc->rtc_irq, ftrtc010_rtc_interrupt,
>  			       IRQF_SHARED, pdev->name, dev);

[Severity: High]
This is a pre-existing issue, but since the interrupt is registered as
IRQF_SHARED, is it safe for ftrtc010_rtc_interrupt() to unconditionally
return IRQ_HANDLED?

If another device sharing this IRQ line asserts an interrupt, returning
IRQ_HANDLED without verifying the interrupt source could prevent the core
IRQ tracking mechanism from detecting and disabling spurious interrupt
storms.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827080320.3351=
155-1-liudalin@kylinsec.com.cn?part=3D2
