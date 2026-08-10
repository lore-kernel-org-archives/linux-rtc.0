Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499DA3998AF
	for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 05:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786339812; cv=none; b=HBtfh0GjRxCSceRp9v5egdUVfKgwg4Zid/Q/hcDD1vlMPpTJd2TW7I2Whrnov27QRUhygQ1ezCb7eB+PYMN69N2GletDB82XH1g6x5piULjvQHjKP0QX8vuNJWRSpjT0sF+7nVUGjqG1gEoR9y6fMGqjCAqqchjMOYn/7EWC/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786339812; c=relaxed/simple;
	bh=ZF3dVc7o6GEawp9sSq2+ivBkcalgW6qupV5wHd4CHHU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZMDZEdcqve3UQYK4np3vLtrLoXwluIqZexf+WlbdFiUU2ebWNYxznrO51OI7wWE3cBjPqygmrtjYLr/JZlaCl0LT9OR1uNw6VczmIoyeOrUGZpvnjzHzvK83IiWEIxHOveHveUP2XBIpXJZJak3eJyUzdjssvyifrksReaJK0b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxUF+3+I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxUF+3+I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A721F000E9;
	Mon, 10 Aug 2026 05:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786339811;
	bh=0Fiv0KIF5U8RcBLEVdXXYpZrSftRNCmIdpxHGkF32N0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oxUF+3+IEuHJN/M4PhHGEFKBOj3RZxw+bhAxs/hZVnDj/sDdPTtUwIA4PbY91r7Om
	 aaJV12IbMG3Q6tn9akKnRRLKdjQc2eMSyVAQmqqhTHQNajew2Z50A3Hmfbc7nZ7DGH
	 1RlVkUHKzsWRw+w2dw1Zx6N07jLJ6zDtLNWqJ5Uv4jl1ocivD91SAyMw6eDKFPx6OD
	 afhgTNpSRtFCQHh8CxSo1qSWvg6MUT41FjO5CbwY+I41FPViae3Jgu8M83EPloVIVN
	 LqF9G9ZHAQhsES9bmxIhm99e40fooUfbCK0lOeXbbWL4qxfPjjfmqBtD0TxGYU5Ibd
	 oYT4Iqf0LgSIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] rtc: cmos: Propagate errors from optional IRQ
 lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: phucduc.bui@gmail.com
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260810051504.26912-2-phucduc.bui@gmail.com>
References: <20260810051504.26912-1-phucduc.bui@gmail.com>
 <20260810051504.26912-2-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 05:30:09 +0000
Message-Id: <20260810053010.B7A721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Propagating -EPROBE_DEFER from platform_get_irq_optional() causes =
a permanent device probe failure because rtc-cmos is registered using platf=
orm_driver_probe(), which explicitly forbids deferred probing.
- [High] Propagating parsing errors like -EINVAL bypasses the x86 legacy IR=
Q fallback, breaking RTC probing on systems with malformed ACPI tables.
--

--- Patch [2]: [PATCH 2/2] rtc: cmos: Propagate errors from optional IRQ lo=
okup ---
commit bf54cacd6dce9cc731cd51fdbcbf8b84af0b1e7f
Author: bui duc phuc <phucduc.bui@gmail.com>

rtc: cmos: Propagate errors from optional IRQ lookup

The commit updates the RTC CMOS driver to propagate error codes returned by
platform_get_irq_optional() other than -ENXIO, while preserving -1 for the
case where no optional IRQ is available.

> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index fa04ece151b8b..0a2c7383c8cd4 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -1436,7 +1436,9 @@ static int __init cmos_platform_probe(struct platfo=
rm_device *pdev)
>  	else
>  		resource =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	irq =3D platform_get_irq_optional(pdev, 0);
> -	if (irq < 0) {
> +	if (irq < 0 && irq !=3D -ENXIO)
> +		return irq;

[Severity: High]
Does propagating -EPROBE_DEFER from platform_get_irq_optional() cause a
permanent device probe failure?

Since rtc-cmos is registered using platform_driver_probe(), which explicitly
forbids deferred probing, returning -EPROBE_DEFER here might cause the driv=
er
core to convert it to -ENXIO and permanently fail the probe instead of
proceeding without an optional IRQ.

[Severity: High]
Does propagating parsing errors like -EINVAL bypass the x86 legacy IRQ
fallback?

On x86 systems with malformed ACPI tables (e.g., specifying IRQ 0, which
platform_get_irq_optional() rejects with -EINVAL), propagating the error
bypasses the fallback logic below that successfully hardcodes the IRQ to
RTC_IRQ if legacy PIC IRQs are supported, potentially breaking RTC probing
on those systems.

> +	if (irq =3D=3D -ENXIO) {
>  		irq =3D -1;
>  #ifdef CONFIG_X86
>  		/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810051504.2691=
2-1-phucduc.bui@gmail.com?part=3D2
