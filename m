Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B42042BEBA;
	Fri, 21 Aug 2026 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321247; cv=none; b=Bm0d+RZ+jTjK7gWZ/yeoJPqdB7dkcbnBrdqvPTtWvWLbaBDhJjyRsFuw1Ry2i1SYQwuKcj++zHiEJKy8iP0Z8EliOeM1Ur9swA4bcit1zfhOG9gGS8p95RoxSHq08sBtorplOs0wpCbYtxahtg/Tm0YeufvsLU9FdT1GK5/NasQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321247; c=relaxed/simple;
	bh=ROLpHdy12nLF4bqt2FtQBEE75+JHbKi9chXHDv+/DTg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pbfZQ7VqYPfD4CFFRMKpHJDfjUmZMDueoyf85VQvHUGoXvrJ0RU6r3S7ygdr9OgQbM2qlhPxPDiPEVa4EjuMQ4/7KJCn4eOchyzkEkv9JR5IXMhLq7Np5m4NE/psX2goaBMtObrxY92Cy0vFFkDKbmz9SKiyUvHkyd+3KmlB6y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P47uTTH+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P47uTTH+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39CB1F000E9;
	Fri, 21 Aug 2026 14:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787321246;
	bh=YmhcKRbwRCWEwkSIviYv00n+dEI2VdqcUUcIN3iyiE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P47uTTH+5EigAryuQSI9OhlCVi2lUrr2V6cdwjfCHPQNyYO5T9IO7rPeD072zkfMD
	 Pu0tsvioU0V9wZ3fiSx7Pc+qpuTr/IjIyIhgKfwg01ePNMDq5cT5AzBI+UtlC+i2Q7
	 uw+QfvfesD9fUPVYWFH18iIuOnVjgQUGDZz5SoVeXuW0zjQN/epoUEggBKyUL++rbp
	 +U6Yv5JsFzwsLA1zkvoVDbquJBjciySs52B6i9SG17eRBxt2zFWw1JMqSP4qiOqs8a
	 cCYgEIy4GtnXZrG6F0MDHzHykEEcyLB+qhHBKsSMBw6qPguYRpdm3/yaqIhX6AeJz3
	 LqZuKcX/Y0QtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/17] rtc: rzn1: Replace remove callback with
 devm_add_action_or_reset()
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, conor+dt@kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260821135608.275233-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 14:07:25 +0000
Message-Id: <20260821140725.D39CB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hardware interrupts are disabled after the IRQ handlers are freed =
during driver unbind, creating a window for spurious, unhandled interrupts.
--

--- Patch [10]: [PATCH v5 10/17] rtc: rzn1: Replace remove callback with de=
vm_add_action_or_reset() ---
commit 473179016e2cef4b0d0185760b5e14362f0eadc1
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

rtc: rzn1: Replace remove callback with devm_add_action_or_reset()

This patch simplifies the driver teardown by replacing the explicit remove
callback and probe error paths with a managed cleanup action. It registers
rzn1_rtc_disable_hardware via devm_add_action_or_reset.

> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index 6a434cb418cd0..02d720e95a7f9 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c
> @@ -421,18 +432,19 @@ static int rzn1_rtc_probe(struct platform_device *p=
dev)
>  	if (ret < 0)
>  		return ret;
> =20
> +	ret =3D devm_add_action_or_reset(&pdev->dev, rzn1_rtc_disable_hardware,=
 &pdev->dev);
> +	if (ret)
> +		return ret;
> +

[Severity: High]
Since devres executes teardown actions in LIFO order, will registering the
hardware disable action here early in rzn1_rtc_probe cause it to run last
during driver unbind?

[ ... ]

> @@ -468,14 +480,12 @@ static int rzn1_rtc_probe(struct platform_device *p=
dev)
>  	ret =3D devm_request_irq(&pdev->dev, irq, rzn1_rtc_alarm_irq, 0, "RZN1 =
RTC Alarm", rtc);
>  	if (ret) {
>  		dev_err(&pdev->dev, "RTC alarm interrupt not available\n");
> -		goto dis_runtime_pm;
> +		return ret;
>  	}

[Severity: High]
If devm_request_irq is called after the hardware disable action is
registered, won't the IRQ handlers be freed before the hardware is disabled
during teardown?

If an RTC alarm or 1-second interrupt is active when the driver unbinds,
could an interrupt fire in the devres teardown window where the handler is
gone but the hardware is still active? This might trigger the generic IRQ
subsystem's spurious interrupt detector, which could permanently disable the
IRQ line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821135608.2752=
33-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D10
