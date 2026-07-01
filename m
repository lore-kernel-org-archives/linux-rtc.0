Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1E43546FE;
	Wed,  1 Jul 2026 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917383; cv=none; b=heSPwlUy8FNw4/NzEjiPqTnSiP5+b3I0yJM0RtyqhqrZAig/idyhSpGWCukyGqhQhWKfcq1h+JR6JS+mA7Y2aOlsZZbpaN26JjlNIJ29yH+l33m7OPeL1XlUWtAdXHBRr7IHZFxmeok8vf50Nv1VotkAH1Fu52pEyxbDUkNJtC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917383; c=relaxed/simple;
	bh=L0xWX7Wtx9qwHDdwcxyDAdRmlOY0qKyCfbuY5UD+zuM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C5G/j7cgtgxFW+x/wE4Buoiw3dbK/r5tjw/+6V/XPZFNLXcaSM6BLuyFvApHa7wZR5RDZaZjqn+T5CClu5nfhnqz4PDeTRzQAao8kiCe0UAT7pE+ePqbLSX4nQQ6Ooep3rwZ9sKj1PUC1BMwuLuQreGT1ZNvNz+GUkJzBwt9t38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9pD6tKO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9pD6tKO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FD71F000E9;
	Wed,  1 Jul 2026 14:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782917380;
	bh=mj6pPtJ0VEAuuFxI6oWIODyCrQlhIOR3jB/m96+kxsw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I9pD6tKOEz4wEP1wzacLCXKcCGhM1xEW8o8aSd0EQ2fAbxrE/ILX1B3SnsZgJGNCH
	 IiUxWZKn9gTpOUcTrYaR2apB6S+1Y+1uc5xCXopTPegrtG9Yu+XwG10opDooHe6vp6
	 +YeSwI60hS88eKoxRMU1SVl2rrscBJZhfGOTiT5K24yV1hTYboj3Js8sJO5zpNpqhE
	 6o9pG5wg4dHNrkQGM5VLg2tYCBk2+p2U+VLQidatsOXWaF6oyNrndaC/uVrnbCa3lD
	 mLZF4IESstatxr9XlqZh69FqZpizQDx6/o9jSda4BUXIpUbulFDFoj98spxxz5Nis9
	 RvbRa/UpEf1sQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/10] rtc: rzn1: Dynamically calculate
 synchronization delay based on clock rate
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-rtc@vger.kernel.org, conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260701142953.2014895-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260701142953.2014895-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260701142953.2014895-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 14:49:39 +0000
Message-Id: <20260701144940.69FD71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Incorrect time conversion macro NSEC_PER_MSEC used instead of USEC_=
PER_SEC for microsecond calculation.

Pre-existing issues:
- [High] Race condition between PM runtime teardown and devres device unreg=
istration can lead to accessing powered-down hardware.
--

commit f3a6e4b28e451318639b10e7927bf136a7d225d3
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

rtc: rzn1: Dynamically calculate synchronization delay based on clock rate

This patch replaces hardcoded hardware synchronization delays with a
calculated time window derived from the runtime clock rate. It stores this
synchronization time in the driver private structure to dynamically adjust
wait boundaries.

> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index 9969bcefede72..583d174954043 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c
[ ... ]
> @@ -432,12 +433,20 @@ static int rzn1_rtc_probe(struct platform_device *p=
dev)
>  			scmp_val =3D RZN1_RTC_CTL0_SLSB_SCMP;
>  	}
> =20
> +	/*
> +	 * The internal clock counter operates in synchronization with the
> +	 * RTC_PCLK clock. Calculate the duration of two RTC_PCLK clock
> +	 * cycles in microseconds required for operations to complete.
> +	 */
> +	rtc->sync_time =3D DIV_ROUND_UP(2 * NSEC_PER_MSEC, rate);

[Severity: Low]
This isn't a bug, but should this macro be USEC_PER_SEC instead?

The comment mentions calculating the duration in microseconds. While
NSEC_PER_MSEC evaluates to 1,000,000 which produces the correct runtime
result for converting cycles per second into microseconds, using
USEC_PER_SEC would more accurately reflect the intended units and improve
readability.

[Severity: High]
This is a pre-existing issue, but is there a race condition between the
PM runtime teardown and devres cleanup?

In drivers/rtc/rtc-rzn1.c, the RTC device is registered via devres
during rzn1_rtc_probe():

    ret =3D devm_rtc_register_device(rtc->rtcdev);

Devres runs its cleanup (which calls rtc_unregister_device()) strictly
after the driver's remove callback returns. However, in rzn1_rtc_remove(),
the driver manually drops the PM runtime reference:

    pm_runtime_put(&pdev->dev);

This powers down the hardware while the RTC character device is still
registered and exposed to userspace. If a userspace process calls an ioctl,
such as RTC_RD_TIME, during this window, the driver's rzn1_rtc_read_time()
callback executes and attempts to access unclocked registers, which could
lead to a synchronous external abort or bus fault.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701142953.2014=
895-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D6
