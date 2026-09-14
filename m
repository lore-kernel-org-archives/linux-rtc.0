Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8303747127F
	for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392935; cv=none; b=OudQn8wC1/lPQ70XCy6RfkIdYl9BjkHeoinsh1Y5j6nrkBXeQpIpDhbgVKzgvQO2wF1ImCqVedNcZro+NtbS7l5ovylu/FrBuz9jzTfy2+EogkFyOmnnieCyBRPg5s7rWySeX685ycOu7nqEk9cYI3OarK2yaSrKCvTJQKigcNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392935; c=relaxed/simple;
	bh=U0cJBOmFbtiPqLLtyh/RKDzAf2Dkb8XqF4vRsUEMIvY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZJsh1g8K8F0gwZVHrmhXeUEho+FMrX+jocvNVC1lp7be+Gh+hHdGgL7WdH7g8Bz9ij2dFCpoxwMn5zoyN7ea6quzXpIPOIpWk7lQR8cNQB8Nxvo4kKZbSdHgVhwUyWBTLS9HwptY6qTLSlQTy5z/Xdvg/FQ0XdiViTNfcLWG1uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DH5qdjq8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DH5qdjq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFAA1F000FF;
	Mon, 14 Sep 2026 13:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789392933;
	bh=WwTMWcmkLSn7jkBJVfFrhccGThkSzk943WvsNPVcz+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DH5qdjq8/n/1teakV4mPTEbSFHjXGkUW6ukr6RBFNE6Zxt8MFYapY9dQ6Z5Ia1+8Z
	 4kz/yfEm4eYKBCBTQjRe9NENCR4V0S8NA2eG04xSVxvsT8V4Kq9JtIIzYOCm60A3OL
	 XnFNGV9vwdA9WAC81KIZiSiUJTwpAQ/Dx0RY2zl4YR9hMPsyYB8ErJQo2qAV1rTuOC
	 Crb05kZXJgwhoZZqHr3sWAvtY5RurHiljB/jpEVeUYWegiP4ZD9IkFbyQpUjgxS2qA
	 a9uVysRaS1uXZ+NNszK/lixFkZHAubVmIuhqp1SsMxUfIXwQqVq+c65Jz7sHSPELd8
	 m1FpWnYdh45yQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: ma35d1: fix permanent clock reference/enable-count
 leak in probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cong Nguyen" <congnt264@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260914131850.2331670-1-congnt264@gmail.com>
References: <20260914131850.2331670-1-congnt264@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 13:35:32 +0000
Message-Id: <20260914133532.CBFAA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing check for negative error codes from platform_get_irq(), wh=
ich converts -EPROBE_DEFER to a permanent -EINVAL failure.
- [High] The RTC device structure can be freed before the IRQ is disabled d=
uring unbind or probe failure, leading to a Use-After-Free in the interrupt=
 handler.
--

commit 8480cafa58acd05a264e714619a1853c7065e8bb
Author: Cong Nguyen <congnt264@gmail.com>

rtc: ma35d1: fix permanent clock reference/enable-count leak in probe

This commit fixes a clock reference and enable-count leak in
ma35d1_rtc_probe(). It replaces the manual of_clk_get() and
clk_prepare_enable() sequence with devm_clk_get_enabled(), ensuring the
clock is properly released on probe failure or unbind.

> diff --git a/drivers/rtc/rtc-ma35d1.c b/drivers/rtc/rtc-ma35d1.c
> index cfcfc28060f62..43358d68565a4 100644
> --- a/drivers/rtc/rtc-ma35d1.c
> +++ b/drivers/rtc/rtc-ma35d1.c
> @@ -221,14 +221,10 @@ static int ma35d1_rtc_probe(struct platform_device =
*pdev)

[ ... ]

> -	clk =3D of_clk_get(pdev->dev.of_node, 0);
> +	clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
>  	if (IS_ERR(clk))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(clk), "failed to find rtc clo=
ck\n");
> =20
> -	ret =3D clk_prepare_enable(clk);
> -	if (ret)
> -		return ret;
> -
>  	if (!(rtc_reg_read(rtc, MA35_REG_RTC_INIT) & RTC_INIT_ACTIVE)) {
>  		ret =3D ma35d1_rtc_init(rtc, RTC_INIT_TIMEOUT);
>  		if (ret)

[Severity: High]
This is a pre-existing issue, but does this code fail to handle deferred
probe for the IRQ?

A bit further down in this function, the return value of platform_get_irq()
is assigned directly to rtc->irq_num without checking for negative error
codes:

	rtc->irq_num =3D platform_get_irq(pdev, 0);

	ret =3D devm_request_irq(&pdev->dev, rtc->irq_num, ma35d1_rtc_interrupt,
			       IRQF_NO_SUSPEND, "ma35d1rtc", rtc);

If platform_get_irq() returns -EPROBE_DEFER, passing that negative value to
devm_request_irq() (which takes an unsigned int) will convert it into a lar=
ge
positive integer. This causes devm_request_irq() to fail with -EINVAL,
effectively breaking probe deferral and causing a permanent probe failure if
the IRQ controller is not yet ready.


[Severity: High]
This is also a pre-existing issue, but is there a risk of a use-after-free
if the RTC interrupt fires during driver unbind or error handling?

The IRQ is requested early using devm_request_irq():

	ret =3D devm_request_irq(&pdev->dev, rtc->irq_num, ma35d1_rtc_interrupt,
			       IRQF_NO_SUSPEND, "ma35d1rtc", rtc);

Later in the probe function, the RTC device is allocated and registered:

	rtc->rtcdev =3D devm_rtc_allocate_device(&pdev->dev);
	if (IS_ERR(rtc->rtcdev))
		return PTR_ERR(rtc->rtcdev);
	...
	ret =3D devm_rtc_register_device(rtc->rtcdev);

Because devres cleans up resources in reverse order of allocation (LIFO),
during unbind or if devm_rtc_register_device() fails, the RTC device will
be freed before the IRQ is disabled.

If an RTC alarm goes off in this window, the interrupt handler will execute:

drivers/rtc/rtc-ma35d1.c:ma35d1_rtc_interrupt() {
    ...
	rtc_update_irq(rtc->rtcdev, 1, events);
    ...
}

Could this pass the already-freed rtc->rtcdev pointer to rtc_update_irq(),
leading to memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914131850.2331=
670-1-congnt264@gmail.com?part=3D1
