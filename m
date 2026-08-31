Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCC04A014B
	for <linux-rtc@vger.kernel.org>; Mon, 31 Aug 2026 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194115; cv=none; b=AI6GWgZq8aOVg44D09LfcAI63Co/QF9e/cZuK3MoC2K7WZhLgK0Idep4FnJ967APtjp+Wm3EEwWOeLS6EpN/FgxAjMMuW1V6ZEmAxjoqUNj4NKhnAOgloJ4D/jfkDf23GFPeDUtSs1gRF3Dw9CdXMWinD3JHj/J7YKRnkJmCsnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194115; c=relaxed/simple;
	bh=KTK4H9HyhxGU3wn9sYq9WMXZ6MBQ7tESghoJzi0xTSg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Khlj30976TtkkJl0IkLtDhi/W3vA9db8aaFhZOWtTeh+EGIIt8Szz/K9xN9yDaZm39jyDmsg60S5wsUAVbcvodBay6gKcnqIlkDAUn48XbqGypfFfQmPij51Fb9f99g6g9Rt0ZO6MH/cXan0AzNM6a6oLtzMEcILSmOdeBtBC8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDqLBpHy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDqLBpHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14E61F000E9;
	Mon, 31 Aug 2026 16:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788194113;
	bh=jZP8Gym8ghr6yn2Eqr82XEwYon6Tc9rbuHy48NP2BOo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CDqLBpHyVitod5R5EfTbLsvET8EZyZXrrdfZylBww07vGOtZjWEPklPuEo6FovGzA
	 +hkCPF3plsidPs3JKQ8oht9MuUVYo/7A+XsRib+M8p9jSEIF7QH9POZCy6NHslI705
	 U00P9T98HFBdWStqNwnfnsfuluv0GMGHPQurN58Jq2LvEvFcSUyOXgw+JenITTLo9/
	 A9UQNYIj9bj3dVpAfru0UDadD670schWahrS5py8lmECs2FntxmoS4UyyJ2lCNfsGs
	 p7cwLYkWB4CshgGZ10JqmyG0N+DN06Uh0jgJ9tSKgeO2ZKfgme9DGHJdlC6QwNZvEz
	 tAvwNKPEZbZkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.12] rtc: mv: add suspend/resume support
 for wakeup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260831133314.4125787-454-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-454-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 16:35:13 +0000
Message-Id: <20260831163513.A14E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The driver unconditionally calls disable_irq_wake() in mv_rtc_resu=
me() if device_may_wakeup() is true, ignoring whether enable_irq_wake() act=
ually succeeded during suspend. On platforms with irqchips that do not supp=
ort wake configuration, this causes a WARN(1) splat on resume.

Pre-existing issues:
- [High] The probe function silently disables alarm functionality if platfo=
rm_get_irq() returns an error, failing to handle -EPROBE_DEFER correctly.
- [High] The device clock is disabled in `mv_rtc_remove()` while the shared=
 interrupt is still registered, which could cause a bus error and kernel pa=
nic if the interrupt fires.
--

commit a94ce5838cf02b58cbaaa54595d3a6090ffe754c
Author: Xue Lei <Xue.Lei@windriver.com>

rtc: mv: add suspend/resume support for wakeup

Add PM suspend/resume callbacks to enable/disable IRQ wake for the
RTC alarm interrupt. This allows the RTC alarm to wake the system
from STR (e.g. via rtcwake -m mem -s N).

Link: https://patch.msgid.link/20260611023350.1370881-1-Xue.Lei@windriver.c=
om

> diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
> index c27ad626d09fc..f88976fd6d5da 100644
> --- a/drivers/rtc/rtc-mv.c
> +++ b/drivers/rtc/rtc-mv.c
[ ... ]
> @@ -301,6 +301,28 @@ static const struct of_device_id rtc_mv_of_match_tab=
le[] =3D {
[ ... ]
> +#ifdef CONFIG_PM_SLEEP
> +static int mv_rtc_suspend(struct device *dev)
> +{
> +	struct rtc_plat_data *pdata =3D dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev) && pdata->irq >=3D 0)
> +		enable_irq_wake(pdata->irq);
> +	return 0;
> +}
> +
> +static int mv_rtc_resume(struct device *dev)
> +{
> +	struct rtc_plat_data *pdata =3D dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev) && pdata->irq >=3D 0)
> +		disable_irq_wake(pdata->irq);

[Severity: High]
Does this code trigger an unbalanced wake disable warning on resume if
enable_irq_wake() failed during suspend?

In mv_rtc_suspend(), the return value of enable_irq_wake() is ignored. On
Kirkwood and Dove platforms, the orion-intc irqchip does not support wake
configuration, so enable_irq_wake() fails and returns -ENXIO without
incrementing the IRQ's wake_depth.

During system resume, disable_irq_wake() will be called unconditionally,
which decrements the wake_depth from 0 and triggers a warning splat.

> +	return 0;
> +}
> +#endif
[ ... ]

While reviewing this driver, I noticed a few pre-existing issues:

drivers/rtc/rtc-mv.c:mv_rtc_probe() {
[ ... ]
	pdata->irq =3D platform_get_irq(pdev, 0);
[ ... ]
	if (pdata->irq >=3D 0)
		device_init_wakeup(&pdev->dev, true);
	else
		clear_bit(RTC_FEATURE_ALARM, pdata->rtc->features);
[ ... ]
}

[Severity: High]
This is a pre-existing issue, but does this code permanently disable the
alarm functionality if the IRQ probe is deferred?

If the interrupt controller is not yet ready during mv_rtc_probe(),
platform_get_irq() returns -EPROBE_DEFER. Because this value is negative,
the code skips IRQ setup and executes the clear_bit() path, successfully
registering the RTC device without the alarm instead of properly deferring
the probe.

drivers/rtc/rtc-mv.c:mv_rtc_remove() {
[ ... ]
	if (!IS_ERR(pdata->clk))
		clk_disable_unprepare(pdata->clk);
}

[Severity: High]
This is a pre-existing issue, but can this code cause a bus fault if a
shared interrupt fires while the module is being removed?

The device clock is disabled here, but the interrupt is requested using
devm_request_irq() with IRQF_SHARED. Because the IRQ is devres-managed, it
is not freed until devres_release_all() runs after mv_rtc_remove() complete=
s.

If another device on the same shared IRQ line triggers an interrupt during
this window, mv_rtc_interrupt() will execute:

drivers/rtc/rtc-mv.c:mv_rtc_interrupt() {
	/* alarm irq? */
	if (!readl(ioaddr + RTC_ALARM_INTERRUPT_CASUE_REG_OFFS))
[ ... ]
}

Attempting to read from the device registers while the clock is disabled
could trigger a synchronous external abort and a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-454-sashal@kernel.org?part=3D1
