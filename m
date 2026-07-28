Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A49D12F585
	for <linux-rtc@vger.kernel.org>; Tue, 28 Jul 2026 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200699; cv=none; b=gyaZHXrIIinut1EVXY87cHSnFk512Wth0qdaunUCah0qLonXZDqZZyhgiMjXbmyg5K6kS32qqcuq02f3tsJ4IlZvktfet5Eye2bAYtTUQ8Sww0hNsOpM1tzns2n/6uudRJCuDPSQs+dQZ+NcItWEW+5iPM/5VWmEYMNKB5xtoaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200699; c=relaxed/simple;
	bh=z3GNb/GXbg5z359tboadLGJLZ1ReQEjr3oOoHbYmzNE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eEzvGbnRHOrzciXlY5pkPAzjT9HeXEq6MZTjsKPem1d326OWd06o4VRKDCraQsu3Rid+f0Okf4hv3ovBvb9vTVNhIHlKaONYr1unmK0D2AvJenUUX5+WKPeMdGjYsUyuFmyUtIqSVBp2mCEYsdRJw6Uh0RnB7HrF4NnbIm5oez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYt1NS55; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYt1NS55"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2581F000E9;
	Tue, 28 Jul 2026 01:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785200698;
	bh=y4HXFtCKhxNE5j1/bxvTTpL0ijtys0yOoME+kHr1MLg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hYt1NS55A56ks4DQbxcuwov0i9xRea3G+an5Oh4H8iobpKAFo5kVUyILlcu3US9Op
	 KsuNTubW6ihwXPKxNuiKQ9mzpd6qzTG+lAmMbCBJ2dXV2/GAWrGqHxIsaAhr5/CPxF
	 /xvmt9BnIhLAaxqo+//mjHerW/WzPl8K5bmhPx292ah7joMUcLzU4BRW9Icj77fxiY
	 0ZBQOj8c/LIatIB5UK92WXNDxLqMMYTqGMlJF+G+MltvTTNc1RWc4AmYpdpFxW2sOA
	 1u6ouuo9gthnSjPZzssEOuHGFu21oJjuiRcO2P8j+0Ri+FPf/UHjNBcYbbixRE8/Zd
	 I+SCfYA7IAwBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2] rtc: stmp3xxx: use devm_platform_ioremap_resource()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260728005303.574936-1-rosenp@gmail.com>
References: <20260728005303.574936-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 01:04:57 +0000
Message-Id: <20260728010457.ED2581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] The local variable `irq_alarm` is used in `stmp3xxx_rtc_probe()` wi=
thout being declared.

Pre-existing issues:
- [High] The dynamically registered child watchdog device is not unregister=
ed when the RTC driver is unbound, leading to a NULL pointer dereference.
- [High] Incorrect devm cleanup order creates a race condition where a pend=
ing interrupt can trigger a Use-After-Free by re-queueing an already-cancel=
ed work object.
--

--- Patch [1]: [PATCHv2] rtc: stmp3xxx: use devm_platform_ioremap_resource(=
) ---
commit 9966c4bcfecfb31f7bf74af8e9b176bb32e74820
Author: Rosen Penev <rosenp@gmail.com>

rtc: stmp3xxx: use devm_platform_ioremap_resource()

This patch refactors the driver to use devm_platform_ioremap_resource()
instead of open-coding the resource lookup and mapping. It moves the
mapping ahead of the data allocation to handle deferred probes earlier.
It also removes irq_alarm from the private struct and adds an error
check for platform_get_irq().

> diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
> index 7afcd14aeee56..e789458ba96a6 100644
> --- a/drivers/rtc/rtc-stmp3xxx.c
> +++ b/drivers/rtc/rtc-stmp3xxx.c
> @@ -245,29 +244,25 @@ static void stmp3xxx_rtc_remove(struct platform_dev=
ice *pdev)
>  static int stmp3xxx_rtc_probe(struct platform_device *pdev)
>  {
>  	struct stmp3xxx_rtc_data *rtc_data;
> -	struct resource *r;
> +	void __iomem *io;
>  	u32 rtc_stat;
>  	u32 pers0_set, pers0_clr;
>  	u32 crystalfreq =3D 0;
>  	int err;
> =20
> +	irq_alarm =3D platform_get_irq(pdev, 0);

[Severity: Low]
Does this regression introduce a build failure?

The variable irq_alarm was removed from the private struct stmp3xxx_rtc_dat=
a,
but it is used here without being declared as a local int variable first.

> +	if (irq_alarm < 0)
> +		return irq_alarm;
> +
> +	io =3D devm_platform_ioremap_resource(pdev, 0);

[ ... ]

> @@ -354,13 +349,10 @@ static int stmp3xxx_rtc_probe(struct platform_devic=
e *pdev)
>  	if (IS_ERR(rtc_data->rtc))
>  		return PTR_ERR(rtc_data->rtc);
> =20
> -	err =3D devm_request_irq(&pdev->dev, rtc_data->irq_alarm,
> +	err =3D devm_request_irq(&pdev->dev, irq_alarm,
>  			stmp3xxx_rtc_interrupt, 0, "RTC alarm", &pdev->dev);

[Severity: High]
This isn't a bug introduced by this patch, but does this devm initialization
order create a use-after-free race condition during driver unbind?

The IRQ is requested via devm_request_irq() before the RTC device is
registered via devm_rtc_register_device() further down in probe.

During driver removal, devres cleans up in reverse order: the RTC device is
unregistered first (which cancels the irqwork), and the IRQ is freed second.

If a pending hardware interrupt fires in the window between these two steps,
could stmp3xxx_rtc_interrupt() unconditionally call rtc_update_irq(), which
re-queues the irqwork on an RTC device that is about to be freed?

> -	if (err) {
> -		dev_err(&pdev->dev, "Cannot claim IRQ%d\n",
> -			rtc_data->irq_alarm);
> +	if (err)
>  		return err;
> -	}
> =20
>  	rtc_data->rtc->ops =3D &stmp3xxx_rtc_ops;
>  	rtc_data->rtc->range_max =3D U32_MAX;

[Severity: High]
This is a pre-existing issue, but does the dynamically registered watchdog
device leak on driver unbind?

Looking at stmp3xxx_wdt_register() called at the end of stmp3xxx_rtc_probe(=
),
the watchdog child device is manually added with platform_device_add(), but
stmp3xxx_rtc_remove() doesn't appear to call platform_device_unregister()
to clean this up.

If the RTC driver is unbound via sysfs, the parent device's drvdata is
cleared and devm resources are freed. Because the child watchdog device
remains active, could a subsequent access via stmp3xxx_wdt_set_timeout()
dereference the now-NULL parent drvdata and crash the system?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728005303.5749=
36-1-rosenp@gmail.com?part=3D1
