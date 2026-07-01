Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976F134D90D;
	Wed,  1 Jul 2026 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917696; cv=none; b=Iad02pwdUK22XmVMYAwxBdJ8p0BXsT7oRSclBZ9cRQaUGuxKI/eqd9JCEUWRg2YnknAy52dYNPU9dcxigVK4AhzxxmVg00X9F7Fz6+ijwbvub4x04F1DhiVMJ10Wo0nTr/7pSjTI8u8Ly5mzXJ6zOOVvtgY32QLqMAC8H8W9F8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917696; c=relaxed/simple;
	bh=gOB6MCVt61sAymgIqsQEgtwiydK+N8TrTVRMuQ1j7Ek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KJmoVJryYxmCyskPM1JSb7JkVc/dnWX4luZNqHYDBTMeOFWikF27WY6w8gb/ix1R75u7OA3IfRs2QdGyKqqk0vZuyM5EULMQzII+1V5uOEQwgSKRYRkdM1TL7fdhtcjw3StBgZJ45NolyRcanXn96FTrmXfNEac9L03L2ulytys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owKcthBT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owKcthBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B451F000E9;
	Wed,  1 Jul 2026 14:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782917695;
	bh=SDR3KQw9qtIa5D9+VfKzhnvqQCKPssYPjRfAjZS0Jq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=owKcthBT8KfImP7ppFbeEpd++V8mdALHFfA1kFZQB895D73tcfNTm371VhfBF0E6d
	 zxQDHd3EPMflYFkOpIHvuGxRz4SqfQfbrOb/U6dXKjxeu5+GzmOUauY1TfcgFfHzcE
	 Of567sU5Pnlx8oDGDFYU9OULzzal9sQ09NPUSjM0053NOxOCrg5d5GCmAuETAANXle
	 mhsCrVKP7ii58UFDYcI9svSnVv7R+3vxcUEtjzXP5bQoTf5gvxnPZ90C9PDnXtsIPF
	 e7aKC9/blzFN3eeHZp361PDFAMCawu7NH3AMRrTY3D53YxV62WvZCWa4YaLIk9tExS
	 21o309jBfpDgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/10] rtc: rzn1: Add support for Renesas RZ/T2H and
 RZ/N2H SoCs
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: robh@kernel.org, wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260701142953.2014895-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260701142953.2014895-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260701142953.2014895-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 14:54:54 +0000
Message-Id: <20260701145455.02B451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The driver does not enforce SCMP mode for the new RZ/T2H compatibl=
e, allowing an unsafe fallback to SUBU mode that accesses the unimplemented=
 RTCA0SUBU register.
- [Medium] The driver clears the entire `RZN1_RTC_CTL1` register to disable=
 interrupts, which inadvertently destroys the state of the RZ/T2H-specific =
1 Hz output control bit.
--

commit a19c5bdab6f846898749c84cf9743ad18017cdd8
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

rtc: rzn1: Add support for Renesas RZ/T2H and RZ/N2H SoCs
   =20
Add support for the RTC block found on the Renesas RZ/T2H (R9A09G077)
and RZ/N2H (R9A09G087) SoCs by matching the new
renesas,r9a09g077-rtc compatible string.

>     These SoCs integrate a closely related variant of the RZ/N1 RTC IP.
>     Unlike the RZ/N1 implementation, the RZ/T2H and RZ/N2H variants lack
>     the RTCA0SUBU register. However, this register is not accessed when
>     operating in SCMP mode using the existing rzn1_rtc_ops_scmp
>     configuration, allowing the current driver infrastructure to be reused
>     without modification.

[Severity: High]
Does the current driver infrastructure guarantee SCMP mode is always used?

If the xtal clock is missing (since devm_clk_get_optional() is used) or
if its rate is exactly 32768 Hz, scmp_val remains 0:

drivers/rtc/rtc-rzn1.c:rzn1_rtc_probe() {
	...
	xtal =3D devm_clk_get_optional(dev, "xtal");
	if (IS_ERR(xtal)) {
		...
	} else if (xtal) {
		rate =3D clk_get_rate(xtal);
		...
		if (rate !=3D 32768)
			scmp_val =3D RZN1_RTC_CTL0_SLSB_SCMP;
	}
	...

This causes the driver to fall back to the SUBU ops:

	if (scmp_val) {
		writel(rate - 1, rtc->base + RZN1_RTC_SCMP);
		rtc->rtcdev->ops =3D &rzn1_rtc_ops_scmp;
	} else {
		rtc->rtcdev->ops =3D &rzn1_rtc_ops_subu;
	}

If this happens, the SUBU ops will access the missing RTCA0SUBU register,
which can trigger a synchronous external abort. Should the driver use OF ma=
tch
data to identify variants lacking the SUBU register and explicitly prevent
assigning rzn1_rtc_ops_subu?

>     The RZ/T2H RTC variant also supports a 1 Hz output signal on the
>     RTCAT1HZ pin, controlled by the RTCA0CTL1[RTCA01HZE] bit. This bit is
>     marked as reserved in the RZ/N1 hardware manual, making RZ/T2H a
>     distinct RTC variant despite its overall compatibility with the RZ/N1
>     implementation.

[Severity: Medium]
Will this 1 Hz output signal be inadvertently disabled during probe and rem=
oval?

During probe and removal, the driver unconditionally clears the entire
RZN1_RTC_CTL1 register to disable interrupts:

drivers/rtc/rtc-rzn1.c:rzn1_rtc_probe() {
	...
	/* Disable all interrupts */
	writel(0, rtc->base + RZN1_RTC_CTL1);
	...

If the bootloader or firmware previously configured the 1 Hz output signal,
won't this unconditional write to 0 destroy that state? Could the driver
perform a read-modify-write operation to clear only the interrupt enable bi=
ts
instead?

> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index e77b7e7bcd5bd..26a5cde41c6b2 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c
> @@ -518,6 +518,7 @@ static void rzn1_rtc_remove(struct platform_device *p=
dev)
>  }
> =20
>  static const struct of_device_id rzn1_rtc_of_match[] =3D {
> +	{ .compatible	=3D "renesas,r9a09g077-rtc" },
>  	{ .compatible	=3D "renesas,rzn1-rtc" },
>  	{},
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701142953.2014=
895-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D10
