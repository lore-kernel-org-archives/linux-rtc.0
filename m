Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9F0348C5C;
	Wed,  1 Jul 2026 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917455; cv=none; b=ehxBcwAw/jkbe/2kUJGR1tewxm54W0XTXERn7LULcRDNBS+PF3Q+DaBa6IUnXrqmy9pZUDcBVzy1Gxkp9sEXYJWLA7VlCjTLq3tsCjn21kVJMuZJXzA5G6IYVOe0lWdN3vQSFQ5Cfq+kI5DU3z4paoQhN64qo6BCBHH439H0JbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917455; c=relaxed/simple;
	bh=MDlHhwvbadiOZHKr1JF3JUzDSAh5NSOcXZOekgyLkYY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MFR3hrkO8njiMpwpcKoegoFYzTRiKdWAOEQ4vz3UO6n00GxPwl5DX40zYEL1WbgDlYdmJrXsogFygqWfSq3AC2pp9/L2fCR6QHK6GfZMw96FWQrptux6YnwWzAlycPoOet1P+KhVhA2e2dH10b7vud2A6s5aGBvXmIhh5mjHxN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwIgfLHA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwIgfLHA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757001F000E9;
	Wed,  1 Jul 2026 14:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782917453;
	bh=4dulwvD55+9wwlESTkQpE/4rzpGt4X57YDRb66/k8w4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UwIgfLHAhusuK5G/5qODflNM7essgFMbNsqt+xCet5ZI+JU3YpCj2vedRW/5dJ6/z
	 O508RWR71aRlA+xhM4LXDdI+QG3nUddolMt8rMug4nR1731yRAFV2Qpo9qDmEOEgjD
	 3RdQzCHm/DGDpZT+Rr8kO2IVMn69CTkieeygHAbmpnRqp8pkkHXS58uEnJA18/VVea
	 RmUODdpD0+tjdkG/rHkABbSFtLBVbt2gdrIcGmFFzKMzkaVe5VhBeGD85p+9Gbo3AL
	 f8St9tprZWmiKLqCk1rnjqgv6TsUKMOp/6mSAUcB6p0aZkt0BkzE5jSWB0QWa17HzR
	 vmZ2UiAhuZl7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/10] rtc: rzn1: Consistently use dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260701142953.2014895-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260701142953.2014895-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260701142953.2014895-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 14:50:53 +0000
Message-Id: <20260701145053.757001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Premature pm_runtime_put() in remove callback leads to a potential=
 bus fault or kernel panic due to devres teardown ordering.
--

commit 20388d9c3bb9eb8111711742d828f2997e736384
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

rtc: rzn1: Consistently use dev_err_probe()

This patch updates rzn1_rtc_probe() to use dev_err_probe() when the alarm
interrupt request fails. This brings the error handling into alignment with
the rest of the probe function.

> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index 244d0fc70fdad..d990075839c13 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c
> @@ -471,7 +471,7 @@ static int rzn1_rtc_probe(struct platform_device *pde=
v)
> =20
>  	ret =3D devm_request_irq(dev, irq, rzn1_rtc_alarm_irq, 0, "RZN1 RTC Ala=
rm", rtc);
>  	if (ret) {
> -		dev_err(dev, "RTC alarm interrupt not available\n");
> +		dev_err_probe(dev, ret, "RTC alarm interrupt not available\n");
>  		goto dis_runtime_pm;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but since we are looking at driv=
er
error handling and teardown paths, is there a potential use-after-suspend
issue during device removal?

Since the RTC is registered using devm_rtc_register_device() in
rzn1_rtc_probe(), it remains registered and accessible to user space until
the devres teardown runs, which happens after rzn1_rtc_remove() returns.

However, rzn1_rtc_remove() manually drops the runtime PM reference:

drivers/rtc/rtc-rzn1.c:rzn1_rtc_remove() {
	...
	/* Disable all interrupts */
	writel(0, rtc->base + RZN1_RTC_CTL1);

	pm_runtime_put(&pdev->dev);
}

If a user-space process accesses the RTC device (like reading the time via
ioctl) precisely during driver unbinding after pm_runtime_put() is called,
would this access hardware registers while the clock is gated and trigger
a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701142953.2014=
895-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D8
