Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C593D367B72
	for <linux-rtc@vger.kernel.org>; Thu, 27 Aug 2026 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787812982; cv=none; b=RXmAYwd5lFo1vs4j0YWpjgXz5ErsrdZ57bHUyHSVz07GnOO6mSHKfIV/MquGVhr2i9dOwgTMc+tOYjojUMZ0sJ5FDkeWmrC/YhNujhc2FsTTyzf8lqiJAdF4XiCInCeTt+/kVLb3iPlZ90xn1Tyge2OIKkJuVhKy4k8od7AgG2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787812982; c=relaxed/simple;
	bh=T7mXHfd4pFHOjEcP/39ZU7VYfQkvysSFtMbAnKl3kiU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mjrrk4e6S7lvdk2svtv6GOzqH5tLygZugvPebXakZ9wPVz4EAZ6Imy65WN+p7vIpS/bjGMw9vY8TyVwr808rMWd94exglsLystzbGGOEgIvqduymIVAG3MANqVrwzZ/+xJ1Yj8x1bcOSwvXFftxDzcVY8ojkPjm79tMVY6jObnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPyUM89p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPyUM89p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7825B1F000E9;
	Thu, 27 Aug 2026 06:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787812980;
	bh=IiFDFAeNnP1TBxGwBOJ7+wAe8jhZOTPffwZm1iPmyss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YPyUM89pDbi8EAedp2vE/Uo+ZVXxOA2DOhSQufhU5To8X/J8NxHbcjOhDOye3B+k8
	 F7ZVz3eEn4cGihz2yHF+uRcTiJN8RoE4SulzexG15Bzw3oaeNLgI/f53mOs5BeGlZ1
	 /MUJMLN6SheUhMjGZsdm1SiuEpXGSs/YLCbyK55BVCtefZuJXX9mFV3YbNeUyglG8m
	 z3Oa++aOtVFZS/yVJS2qfiDr0L/J7iXcBafFxQJbuIlIC3jJYwlnKFkk8QYAAlhuwj
	 NoCJaDPOtc7tzzGf4VhJccia/Riobkr75gUHOp0mFq+zLgKxGLnSJp4ioYcJeLSKEY
	 pluQf18vq+FTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/3] rtc: ftrtc010: use devm clock APIs to fix
 use-after-disable in remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liu Dalin" <liudalin@kylinsec.com.cn>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <17C4ADB7B3B875B8+20260827063019.3342085-3-liudalin@kylinsec.com.cn>
References: <20260827021054.0963C1F000E9@smtp.kernel.org>
 <20260827063019.3342085-1-liudalin@kylinsec.com.cn>
 <17C4ADB7B3B875B8+20260827063019.3342085-3-liudalin@kylinsec.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 06:43:00 +0000
Message-Id: <20260827064300.7825B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Incorrect clock API usage and error handling truncates probe on mi=
ssing or optional clocks.

Pre-existing issues:
- [High] Time-of-Check to Time-of-Use (TOCTOU) race against hardware tickin=
g causes time corruption.
- [High] Unconditional IRQ_HANDLED on a shared interrupt line defeats the s=
purious interrupt detector.
--

commit 289123a8d46a85463292da46c4edfed7ee0a88db
Author: Liu Dalin <liudalin@kylinsec.com.cn>

rtc: ftrtc010: use devm clock APIs to fix use-after-disable in remove

This commit replaces manual clock management with devm_clk_get_enabled()
to tie the clock lifecycle to devres, fixing a use-after-disable window
during device removal. It also cleans up the probe error handling path
and removes the manual remove callback.

> diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
> --- a/drivers/rtc/rtc-ftrtc010.c
> +++ b/drivers/rtc/rtc-ftrtc010.c
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
>  	}

[Severity: High]
If CONFIG_HAVE_CLK is disabled, devm_clk_get_enabled() returns NULL. Doesn't
PTR_ERR_OR_ZERO(NULL) evaluate to 0, which would cause ftrtc010_rtc_probe()=
=20
to silently return 0 and exit prematurely before mapping memory or register=
ing=20
the RTC device?

Additionally, since the old code treated PCLK as optional (only logging an=
=20
error if it failed), what happens if the clock is omitted from the Device=20
Tree? devm_clk_get_enabled() returns -ENOENT, which PTR_ERR_OR_ZERO() will=
=20
propagate as an error. Could this break backward compatibility with older=20
device trees that omit this clock?

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
>  	}

[Severity: High]
Does this have the same silent probe truncation or Device Tree compatibilit=
y=20
issues as the PCLK conversion above?

[ ... ]

> @@ -179,29 +161,13 @@ static int ftrtc010_rtc_probe(struct platform_devic=
e *pdev)
>  	ret =3D devm_request_irq(dev, rtc->rtc_irq, ftrtc010_rtc_interrupt,
>  			       IRQF_SHARED, pdev->name, dev);

[Severity: High]
This is a pre-existing issue, but I noticed the driver requests a shared=20
interrupt with IRQF_SHARED. Looking at ftrtc010_rtc_interrupt(), it returns=
=20
IRQ_HANDLED unconditionally:

static irqreturn_t ftrtc010_rtc_interrupt(int irq, void *dev)
{
        return IRQ_HANDLED;
}

If another device sharing this IRQ line asserts an interrupt and gets stuck=
,=20
would this unconditional return prevent the kernel's spurious interrupt=20
detector from disabling the broken IRQ line, potentially leading to an=20
interrupt storm and a system hang?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but looking through the driver,=
=20
is there a race condition against the hardware ticking in both=20
ftrtc010_rtc_read_time() and ftrtc010_rtc_set_time()?

In ftrtc010_rtc_read_time():

	sec  =3D readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
	min  =3D readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);
	hour =3D readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
	days =3D readl(rtc->rtc_base + FTRTC010_RTC_DAYS);

If the hardware clock rolls over (for example, incrementing the minute from=
=20
59 seconds to 00 seconds) between the reads of two registers, could the=20
software combine the old value of one register with the newly incremented=20
value of another, resulting in wildly corrupted time calculations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827063019.3342=
085-1-liudalin@kylinsec.com.cn?part=3D2
