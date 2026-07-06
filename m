Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BA4422542;
	Mon,  6 Jul 2026 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361013; cv=none; b=U22qZ1mW3zLn9UUnSnSdTFp7xnu7rpJBsa962XZ9SrQJ6Vy46b+ZprL4KBDqEWYy8QNAXTSIE3VUU0CrXwqcdOyJWwWg6qP7ADXxSuOKXPknmgAS6Suz2xIhpz0g6OLDBC1eVtFyelEh0yVqOEwy7wpWa5kjRrJssaXlP1D1Vuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361013; c=relaxed/simple;
	bh=lc86k8LJPtnt1pVwLPrhPdn1daKMEwUiCJuv1fq0zWA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k44E/SAyYKCe5fA0GMKk7sPYWpuJInsusOKPcTlq4vixl/+GkbFSltR2+LwckfpZV4+7N1ngPhqnShbo7vVMJ0BX6LQsqwp9uW2iPH9PJ/q5T4eRMWRutja/VX7rr/ClTbA5RV14AwPhGIN5IJ1ADiDwKn1iAYxKEFtUIPxZ/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a93N3rHn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a93N3rHn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD811F000E9;
	Mon,  6 Jul 2026 18:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783361011;
	bh=lTT3WYy1RsizBvu2AujamAPkPp1IK1VWhyMe0S+EAQU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a93N3rHnwZI/chozvKNqhJkoCc6VtpB6AV7dFv/qDsn3WJVZiZL2tHciYkNDVJ15X
	 z0QFgG/UxU92RqfEEt/+lOdPoTLR1+guP27Dwe3dp1oFZOHvtCarU7xo3m2Dh/+h0i
	 GJOnrPiSsO/zrnoY3R27FMWKiUnR+iIqbUNz/gEHcQ1A5VM0fRErNUd+qA499bN0Ex
	 UL8NhSfjf/Jr4VUKFkiORNVyr3RfIW14yQv7DGqXkv2HQNMWCwppILzRXXMCbK9/Fy
	 Q0gIrRrszTpJjf7I8YZ5zj4FLh93OGDXwy6a0OZHWZtaFCtfXTkzmOn40KKK36tjiG
	 +i8ANxWBDVqew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/12] rtc: rzn1: Add support for Renesas RZ/T2H and
 RZ/N2H SoCs
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-rtc@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260706175138.12587-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 18:03:30 +0000
Message-Id: <20260706180331.3AD811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The driver may incorrectly fall back to SUBU mode on RZ/T2H and RZ=
/N2H SoCs, leading to accesses of the non-existent RTCA0SUBU register and a=
 potential kernel panic.
--

commit ee14aa230b364e5ad7677d78cb0c0a8599351c1c
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

rtc: rzn1: Add support for Renesas RZ/T2H and RZ/N2H SoCs
   =20
This commit adds support for the RTC block on Renesas RZ/T2H and RZ/N2H SoCs
using a new compatible string. It notes that the variants lack the RTCA0SUBU
register, but rely on the existing SCMP mode to function without it.

> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index d1a974c6b8bbe..1d4d8d01749d3 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c
> @@ -508,6 +508,7 @@ static int rzn1_rtc_probe(struct platform_device *pde=
v)
>  }
> =20
>  static const struct of_device_id rzn1_rtc_of_match[] =3D {
> +	{ .compatible	=3D "renesas,r9a09g077-rtc" },

[Severity: High]
If the devicetree for this SoC omits the "xtal" clock or specifies a standa=
rd
32768 Hz frequency, will the driver inadvertently fall back to SUBU mode?

Looking at rzn1_rtc_probe(), the driver sets scmp_val =3D 0 for 32768 Hz
crystals or when the clock is absent:

drivers/rtc/rtc-rzn1.c:rzn1_rtc_probe() {
    ...
	xtal =3D devm_clk_get_optional(dev, "xtal");
	if (IS_ERR(xtal)) {
		return PTR_ERR(xtal);
	} else if (xtal) {
		rate =3D clk_get_rate(xtal);
        ...
		if (rate !=3D 32768)
			scmp_val =3D RZN1_RTC_CTL0_SLSB_SCMP;
	}
    ...
	if (scmp_val) {
        ...
	} else {
		rtc->rtcdev->ops =3D &rzn1_rtc_ops_subu;
	}
    ...
}

If this happens on the RZ/T2H, rzn1_rtc_ops_subu exposes the .read_offset
and .set_offset callbacks. Any userspace read of the offset sysfs node
would then trigger a hardware access to the missing register:

drivers/rtc/rtc-rzn1.c:rzn1_rtc_read_offset() {
    ...
	val =3D readl(rtc->base + RZN1_RTC_SUBU);
    ...
}

Can this lead to a synchronous external abort (kernel panic) when an
unprivileged user reads /sys/class/rtc/rtc0/offset?

Should we add match data to this compatible string to identify the variant
and explicitly reject probe with -EOPNOTSUPP if the clock configuration
would require the unsupported SUBU mode?

>  	{ .compatible	=3D "renesas,rzn1-rtc" },
>  	{},
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706175138.1258=
7-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D12
