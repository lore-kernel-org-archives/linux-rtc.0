Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948AC2F9984;
	Mon,  5 Oct 2026 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791232827; cv=none; b=NPkQLgXuf2OPsKTtzlFtmDm36lj6P5vwcRmEvFsiwUx5r8uRE1LmZHX1+HhI08n6i8CPZ2j9Ty/G01cjedVW4UaQdYDvhzmgRWB8SaMAWOfa/nEMRLEa1s67MlTA4PYkvLtwalegvFIKEo23SFzSBHPHBGQ0OlvNDIRAqiwR5oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791232827; c=relaxed/simple;
	bh=OzRC8Dns8gMF8wsQtmKE+WKMgyEqmKCzHgIeh1b2d2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=prNLyBa/YiUNt/WwN2vxzFxQCRD+nj2AhVrrCocc6eG5KkR1rLNcXN4VLypjxUme12X6WgvS5bqYJfQzsa+kORV82I62oV1Gn7Nj+iUVWca4E+6HlRh+HsNU1TBTFOw0EHYJ6YARdZXpJnGF2PO2St+2omrGgykedACihOrAGAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hik9Hl49; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hik9Hl49"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9CD1F000FF;
	Mon,  5 Oct 2026 20:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791232826;
	bh=oWWeEXxJqBH/3ewxRVjjGHA0q0FUyiJAmQ8itJ/u9a4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hik9Hl49c6PQUzzg3biUuQTa381QMt5bh6G5JeF6iQKcRGr79tqKePcNBeNf8C9gK
	 RE+ayDNAC64dy4bxMMVsOjlvdtbJfAfzoy4QH7WJXeRvuH0yF6QvtuApASJAPgxn0I
	 t+ISymol5+UYYMdJ3ui/wbuE573IQeui0pmkEJdzmNZzq+R++xuEJsHCjZebJXuJXf
	 v3GXQ3rvfzH84qZ9qtEQDW6pbbpgcLtCccRpRafz+Azgvat57q4+/g3GNm7rLUMZvK
	 xkXYWunymdAmWYNldyNl+rA+r5j8qYbOFcNyBawylYNB18/uxdajbDhYyUIAOjFYea
	 kt9ZI2zmOG4uA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/11] rtc: sun6i: add Allwinner B288 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pablo Mazzini" <pmazzini@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261005202731.153971-7-pmazzini@gmail.com>
References: <20261005202731.153971-1-pmazzini@gmail.com>
 <20261005202731.153971-7-pmazzini@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 20:40:25 +0000
Message-Id: <20261005204025.EC9CD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] rtc: sun6i: missing clock provider initialization for b288
--

commit e9a7236a84b632280651176f5049d0cbdc7cb29a
Author: Pablo Mazzini <pmazzini@gmail.com>

rtc: sun6i: add Allwinner B288 compatible

This commit adds the "allwinner,sun8i-b288-rtc" compatible string to the
sun6i RTC driver's device tree match table. This enables the driver to
probe on the Allwinner B288 platform.

> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index 7fc60880e4094..cd6ac5bb20cdc 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -859,6 +859,7 @@ static int sun6i_rtc_probe(struct platform_device *pd=
ev)
>  static const struct of_device_id sun6i_rtc_dt_ids[] =3D {
>  	{ .compatible =3D "allwinner,sun6i-a31-rtc" },
>  	{ .compatible =3D "allwinner,sun8i-a23-rtc" },
> +	{ .compatible =3D "allwinner,sun8i-b288-rtc" },

[Severity: Medium]
Does this compatible string also need a corresponding CLK_OF_DECLARE_DRIVER=
()
declaration to initialize the early clocks?

Without the declaration, the RTC driver fails to register as a clock
provider, rendering its clocks unavailable to the Common Clock Framework
even though the device tree binding specifies #clock-cells =3D <1> and
clock-output-names.

While the current in-tree sun8i-b288.dtsi added later in the series
relies on a root fixed-clock for osc32k and does not consume the RTC
clocks directly, any future board or peripheral attempting to legitimately
consume them will fail to resolve the clocks and hang with -EPROBE_DEFER.

>  	{ .compatible =3D "allwinner,sun8i-h3-rtc" },
>  	{ .compatible =3D "allwinner,sun8i-r40-rtc" },
>  	{ .compatible =3D "allwinner,sun8i-v3-rtc" },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005202731.1539=
71-1-pmazzini@gmail.com?part=3D6
