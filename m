Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19F3476070
	for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394043; cv=none; b=nIHjvsiIp27u08NIAJjpywxGe8bROEzfug72B7jEzadw92+USivqlUE4Fn3ex6FQYUV0qPU2a3cGANRZQuCMxJkBnlPfOPkaLUDIZ57xV77b+0HXKZn7vyvHiO8RoB9VSFSq3Th2aJqo8s0Tlae+8L/c3wdMN0Z+9orEVXLYiqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394043; c=relaxed/simple;
	bh=CuIrv8U5RqGwzc+zzCPko4kogfl4lPlA313QaL1Y9Go=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TPI10xogGI6z8SrK+isl68i+dTPFiohj5poBjOraqC4r/gZ7ZQ7Kj5eu7X89dP5k75loauIGjNRCtTkBy4euiVMEyEBfym2U3rXfD3Yiq8KWC05ByHiPCJqT6PptPLyiFhWw4v/RJOdXceugC2DuHZU60lcEwhT7UJpXzKkvuds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mxa7FvHX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mxa7FvHX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373D91F000FF;
	Mon, 14 Sep 2026 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789394041;
	bh=I/XPbv6u+aC4PDikKr9HCzSv2EbFkDaURfdo1X6O/TM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mxa7FvHXgqgz1ExjAhgHMnzKyOBhQAl3FYEqWy3TOsI8xFPthxgYm/vKRxVO8RTyI
	 uhyUZaiwZO7MuJzOFQSLJtq1VXV2EvRaeWMGU6vNycQ1qjYW5YvQbZ0TiAPndEApVc
	 7utaoS1lTybneePuwQ/KlzuUTsjDT82yx9v7KtSrSNVGbytyHi6kGmh5tJ7iUu8Psi
	 6v625M4LzP5XgO68RwIh1D8rG1vABq9W6l2liXgc5NloF5K1UiGvY2c32dkfrcqRC0
	 EVMZuFUgi0But/6ojS5EAPFKbPFZ5Mt3bj57t8f0i2FBQ2oEXNYN2bzZNEYrdcAR+v
	 QlY2/nzsZ8sGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: stm32: fix clock leak on pinctrl probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cong Nguyen" <congnt264@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260914132914.2371788-1-congnt264@gmail.com>
References: <20260914132914.2371788-1-congnt264@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 13:54:00 +0000
Message-Id: <20260914135401.373D91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Routing pinctrl failures to the manual clock cleanup path creates =
a critical window where devm-managed resources (IRQ, RTC device) remain act=
ive while hardware clocks are disabled, risking a synchronous external abor=
t (bus fault).
--

commit 813d70ca28c122c9814bc7903a9c96494f127aea
Author: Cong Nguyen <congnt264@gmail.com>

rtc: stm32: fix clock leak on pinctrl probe failure

This commit addresses a clock leak during pinctrl probe failure. It updates
the error handling paths for devm_pinctrl_register_and_init() and
pinctrl_enable() to route through the existing err label, ensuring rtc_ck
and pclk are unwound properly.

> diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
> index d4ebf3eb54aa9..e7a942f6c1906 100644
> --- a/drivers/rtc/rtc-stm32.c
> +++ b/drivers/rtc/rtc-stm32.c

[ ... ]

> @@ -1175,12 +1175,16 @@ static int stm32_rtc_probe(struct platform_device=
 *pdev)
>  	stm32_rtc_clean_outs(rtc);
> =20
>  	ret =3D devm_pinctrl_register_and_init(&pdev->dev, &stm32_rtc_pdesc, rt=
c, &pctl);
> -	if (ret)
> -		return dev_err_probe(&pdev->dev, ret, "pinctrl register failed");
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "pinctrl register failed");
> +		goto err;

[Severity: High]
Does this new error path create a window for a synchronous external abort?

When pinctrl initialization fails (for example, returning -EPROBE_DEFER),
this now jumps to the err label where rtc_ck and pclk are manually disabled.

However, the RTC device and the alarm IRQ were registered earlier in the
probe function using devres-managed functions:

stm32_rtc_probe()
    rtc->rtc_dev =3D devm_rtc_device_register(...);
    ret =3D devm_request_threaded_irq(..., stm32_rtc_alarm_irq, ...);

Because devres resources are not released until after the probe function
returns, there is a window where the clocks are disabled but the IRQ handler
and RTC device remain active.

Could the still-registered IRQ fire during this cleanup window? If that
happens, or if userspace accesses the RTC device, driver callbacks like
stm32_rtc_alarm_irq() might attempt to access hardware registers without
the APB clock enabled, resulting in a bus fault.

> +	}
> =20
>  	ret =3D pinctrl_enable(pctl);
> -	if (ret)
> -		return dev_err_probe(&pdev->dev, ret, "pinctrl enable failed");
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "pinctrl enable failed");
> +		goto err;
> +	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914132914.2371=
788-1-congnt264@gmail.com?part=3D1
