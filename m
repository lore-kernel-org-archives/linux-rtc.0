Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0410637F8DD
	for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 05:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786339795; cv=none; b=Lfg3fFSqNLQVfR9RSvYsH72A8ta2SnL4P+Z7DCNLOmHtbby93ttgGWYZLZMrq9YHh203TTQEvANvmOs0sTIClyKNl6Frr1rub+1cArNzRlybsR+xYj60p3UxvRjtadkU4lKskkN3cSMBvmGy6lEemFO+3MMbnQNlEP9Qx69pEq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786339795; c=relaxed/simple;
	bh=px7PhzZk14y2oLYzJBwYCwdKeI5mmQ4d6U9GkmstzpA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PTcZdgri/EmX0pLw2Fz6840VPSkT3RZjT+9TTg8IP7JkZ7kXTtBYuuqxPcc3fDH6C5nk/fXnkIg6hMI5hrwwu7mXbaA/RjkUj0MIELeJcs6/2BW3WMcZwTdVoBUGBOdk1HVbFlidNgpIIPr0YJmVT8nMNMqBEO0mEvqyGqHwoHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqtj6Be+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqtj6Be+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C521F000E9;
	Mon, 10 Aug 2026 05:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786339793;
	bh=ngSstLs5JOsSEokHgnwnkwL7GgaQe2LP7GlRiR1S1JQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nqtj6Be+SbJo+Z8fuIV2NMOIx0QtNlVqVstrZZY5C6r5OMlA2OKajrZh712UA5wBJ
	 SwbyD3F45Mifv8SUVwoRLVdDhd0LkV1ZWgx52m3SagobTF/LzH148rbniYujZfkKLl
	 5w84xvBPWgnwiMS66ZcRLNjQfKyMcqWr1YqZhnU+hah20ovmDsdsQF3euams4bONzs
	 RnI3zwDxjz3VuQnqVENxW/lT88o3wVZ4my2fbu56oHuYbKBgQsQO2ood+3+r5DPedL
	 hszp/qNkwgmlXCkmebl0XmESWKbf4m/OMsFFvBi5n74Zf7DGSYHIxkj9oL8trcLizZ
	 /ljF8I0Yu0dXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] rtc: m48t59: Propagate errors from optional IRQ
 lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: phucduc.bui@gmail.com
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260810051504.26912-1-phucduc.bui@gmail.com>
References: <20260810051504.26912-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 05:29:52 +0000
Message-Id: <20260810052953.32C521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Improper use of devm_kzalloc for pdev->dev.platform_data leads to =
Use-After-Free on deferred probe.
- [High] The shared IRQ handler is registered before its required context (=
drvdata, spinlock) is initialized, risking a NULL pointer dereference.
--

--- Patch [1]: [PATCH 1/2] rtc: m48t59: Propagate errors from optional IRQ =
lookup ---
commit 9d48ac67a0a6bc0aac19eba1f8852bc6afa6e0da
Author: bui duc phuc <phucduc.bui@gmail.com>

rtc: m48t59: Propagate errors from optional IRQ lookup

This commit updates m48t59_rtc_probe() to propagate error codes other than
-ENXIO from platform_get_irq_optional(). Previously, these errors were igno=
red
and the driver fell back to polling mode.

> diff --git a/drivers/rtc/rtc-m48t59.c b/drivers/rtc/rtc-m48t59.c
> index 4e608bc8bbd36..1150f3f6b0084 100644
> --- a/drivers/rtc/rtc-m48t59.c
> +++ b/drivers/rtc/rtc-m48t59.c
> @@ -404,15 +404,17 @@ static int m48t59_rtc_probe(struct platform_device =
*pdev)
>  	 * the mode without IRQ.
>  	 */
>  	m48t59->irq =3D platform_get_irq_optional(pdev, 0);
> -	if (m48t59->irq <=3D 0)
> -		m48t59->irq =3D NO_IRQ;
> +	if (m48t59->irq < 0 && m48t59->irq !=3D -ENXIO)
> +		return m48t59->irq;

[Severity: High]
This is a pre-existing issue, but this new error return path exposes it: if
this returns -EPROBE_DEFER, will it lead to a use-after-free on the next pr=
obe
attempt?

Earlier in m48t59_rtc_probe(), if the device is memory-mapped and platform
data is not provided, pdata is allocated with devm_kzalloc() and assigned to
the device:

drivers/rtc/rtc-m48t59.c:m48t59_rtc_probe() {
	...
	pdata =3D devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
	if (!pdata)
		return -ENOMEM;
	/* Ensure we only kmalloc platform data once */
	pdev->dev.platform_data =3D pdata;
	...
}

When the probe fails and returns -EPROBE_DEFER here, devres will free the
pdata allocation. However, pdev->dev.platform_data is not cleared. On the n=
ext
probe attempt, dev_get_platdata() will return this dangling pointer, bypass=
ing
reallocation and causing the driver to dereference freed memory.

> =20
> -	if (m48t59->irq !=3D NO_IRQ) {
> +	if (m48t59->irq > 0) {
>  		ret =3D devm_request_irq(&pdev->dev, m48t59->irq,
>  				m48t59_rtc_interrupt, IRQF_SHARED,
>  				"rtc-m48t59", &pdev->dev);
>  		if (ret)
>  			return ret;

[Severity: High]
This isn't a bug introduced by this patch, but since we are modifying the I=
RQ
setup, is it safe to request a shared interrupt here before the driver data
and spinlocks are initialized?

If another device shares this interrupt line and triggers an interrupt
immediately after devm_request_irq(), the handler m48t59_rtc_interrupt() wi=
ll
execute before m48t59_rtc_probe() has finished setting up:

drivers/rtc/rtc-m48t59.c:m48t59_rtc_probe() {
	...
	spin_lock_init(&m48t59->lock);
	platform_set_drvdata(pdev, m48t59);
	...
}

Because platform_set_drvdata() hasn't been called yet, dev_get_drvdata() in
the interrupt handler will return null, resulting in a null pointer
dereference when it tries to lock it:

drivers/rtc/rtc-m48t59.c:m48t59_rtc_interrupt() {
	struct m48t59_private *m48t59 =3D dev_get_drvdata(dev);
	...
	spin_lock(&m48t59->lock);
	...
}

Could this cause a crash on platforms with a shared interrupt?

> +	} else {
> +		m48t59->irq =3D NO_IRQ;
>  	}
> =20
>  	m48t59->rtc =3D devm_rtc_allocate_device(&pdev->dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810051504.2691=
2-1-phucduc.bui@gmail.com?part=3D1
