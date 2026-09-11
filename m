Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD432414417
	for <linux-rtc@vger.kernel.org>; Fri, 11 Sep 2026 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789127765; cv=none; b=g/IsfLi6IJ+0o3t/+Iu7rK1gpMQsaPV8ejLPxIniJmEBlV/QyloBQyZNm0AfewhEmE5Us4HgU1yDlKS2gmWLh4teCxXwwnCSCrHCCEITbT+fWxQbVlgt+xovjOv0X9XlTzA6TVEzA83IPN6Gy9uwi/USIJB4qEIOetSIo/oEUF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789127765; c=relaxed/simple;
	bh=Evn+a5SGFYPJL4nDpuTxWIZYu3Rr+FDEtBqOx2C8mow=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SdgAl2Z3lRjqu6Jng76T+C2t9o4UmLpwPgfhPtY6MGzM2K7+yZV4CfSrFKmr3kQgMaODZGWGRGUPqd7w8HSr+blNi1dLf8iEe2BGfkUoZbpXjHUVaTmzozYjttppx1mSlqumxvtett/Cx9bZaBlWMdBttXN2GpoqYvLOflM0Jf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzGW0Joe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzGW0Joe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDE01F000FF;
	Fri, 11 Sep 2026 11:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789127764;
	bh=wSTbbVrLhoP3EzQvZrimhj8MYfB0/8I+T0Cgugc7mB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RzGW0Joe2+xM86BE/XUiOvtDiY234vcg6pA6xqjLN7TWbkvO+x3PU0Q7OXMMLdVwV
	 j8nxoLFc1ueXG89iHp4dt7ygidYp8YlC1XPAF2cQIj8TMv/wS7uZLNSApa7vwxXX05
	 vHMNP4TdEN9IeFzRUIc9VRNe1cX16EqJrL4nfpRbAi8Hn1Zk0Jtp0f20DQUqsyH9W1
	 I0gqDHEm8nncI4XiVMiHyzk501rs5qSAU913//tIs+CplErNwBJhbHdav4MuD4OI0A
	 ZH13uVBpuxhH1wKDFlXIemg/Cq29pAlAZuiY38smcJolFKRkT+Q4CWcbpgIXmVmwt1
	 8SJQj5V2gFaLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: omap: check clk_prepare_enable() return value
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC0?=
 =?utf-8?b?0LjQvdC+0LLQuNGH?= <r.zhambakiev@prosoftsystems.ru>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260911114350.160356-1-r.zhambakiev@prosoftsystems.ru>
References: <20260911114350.160356-1-r.zhambakiev@prosoftsystems.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 11:56:03 +0000
Message-Id: <20260911115604.4CDE01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unhandled PM runtime activation failure causes kernel panic during=
 probe.
- [High] Use-after-disable and race condition during device removal causes =
kernel panic.
--

commit d40541deeb08cdcd7e4b8124b2e9843e03d69ef2
Author: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>

rtc: omap: check clk_prepare_enable() return value

This commit updates omap_rtc_probe() to check the return value of
clk_prepare_enable() and propagate the error. This prevents continuing
with an unprepared clock and later causing a prepare/unprepare imbalance
on error paths.

> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 0f90065e352cb..97d03ded51dbe 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -758,8 +758,11 @@ static int omap_rtc_probe(struct platform_device *pd=
ev)
>  	else
>  		rtc->clk =3D devm_clk_get(&pdev->dev, "int-clk");
> =20
> -	if (!IS_ERR(rtc->clk))
> -		clk_prepare_enable(rtc->clk);
> +	if (!IS_ERR(rtc->clk)) {
> +		ret =3D clk_prepare_enable(rtc->clk);
> +		if (ret)
> +			return ret;
> +	}
> =20
>  	rtc->base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(rtc->base)) {

[Severity: High]
This isn't a bug introduced by this patch, but there is a severe pre-existi=
ng
issue in omap_rtc_probe() shortly after this clock initialization:

    pm_runtime_enable(&pdev->dev);
    pm_runtime_get_sync(&pdev->dev);

    rtc->type->unlock(rtc);

Does this code safely handle PM runtime activation failures?

The return value of pm_runtime_get_sync() is ignored before unconditionally
accessing hardware registers. If the PM domain fails to enable due to clock
issues, regulator failure, or device tree misconfiguration, the function
returns a negative error code but the driver proceeds anyway.

It then immediately calls rtc->type->unlock(rtc), which translates to
am3352_rtc_unlock() and executes rtc_writel(). Accessing OMAP peripheral
registers when the power domain is inactive triggers a synchronous external
abort, crashing the system during device probe.

[Severity: High]
This is also a pre-existing issue, but does the devres-managed registration
create a fatal race condition during device removal?

Later in omap_rtc_probe(), the RTC device and IRQs are registered via devm:

    ret =3D devm_request_irq(&pdev->dev, rtc->irq_timer, rtc_irq, 0,
                           dev_name(&rtc->rtc->dev), rtc);
    ...
    ret =3D devm_rtc_register_device(rtc->rtc);

However, in omap_rtc_remove(), the driver manually powers off the hardware:

    /* Disable the clock/module */
    pm_runtime_put_sync(&pdev->dev);
    pm_runtime_disable(&pdev->dev);

Because the RTC interface and IRQs are managed by devres, they are not
deregistered until after omap_rtc_remove() returns. This leaves a race
window where the hardware is completely powered down, but the RTC device is
still exposed to userspace via /dev/rtc0 and the IRQ handlers remain active.

If a userspace process issues an ioctl like RTC_RD_TIME, or if a spurious I=
RQ
arrives during this window, omap_rtc_read_time() or rtc_irq() will attempt =
to
read unpowered hardware registers. This triggers a synchronous external abo=
rt
and panics the kernel upon driver unbind or module removal.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911114350.1603=
56-1-r.zhambakiev@prosoftsystems.ru?part=3D1
