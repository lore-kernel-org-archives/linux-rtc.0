Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05F433A03A;
	Wed, 24 Jun 2026 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319721; cv=none; b=Gr+2CfIt0gdGQIVNquy5k7OTT7n9idfhb5ESm2ZbPw2fYVEZLa5yBF8MENj9m4Zotts9F/hOuQkRG8sIlOH+J4vkO8MCfs+yn+11wTI0MoxbanzyOQQ6FQT7R9RyB31KEjXx/9tgYEhopLVuSxwZqjPkn/yeux04MQF9wj5F/aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319721; c=relaxed/simple;
	bh=r8SUQcCp3oOUGeXzp1ud6Kg1CzU0/PkvrDS3xpYQuSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSa5PMtzJw8BEn3JbfuZ0A7xijKQBaerIk4Upy5KhoYmiLXhY0YcW1LUZsuNtkn2wCZGQ+986atVo3thcu5vsVUs98xsImfX/Fz2qW25bJd2MRTHTu+cUOCn7RXpNtbo887WuUQZmKU3Dce2fnyL/dLvLy86AlJNINFLGsZ6fnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXuoHKe4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXuoHKe4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09641F000E9;
	Wed, 24 Jun 2026 16:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782319720;
	bh=B16ZfGRW2FDD4EalRw6jbRvtQww1cSDj03208KZHuAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gXuoHKe4o9cHfmCPOeJIPd1HCF7c1/UjlzpQL7H5m4AZNo2rIZuqTHGtvNX/IroLs
	 oxS96QhkGJLEImOSPlzezHJV30pvDhWBfEsCRXXN0g4DSbmTdnN6tU08pUXCOBI4+2
	 BuZyUPAgpe93gslNOdfPPuR9CSeoaz55eIxjMG0DsxaUlyhTZvC1lq3ZTEXToz2nvA
	 ajfLPg0DlEiGQI/cxOqNPOHzTBHdFsRursT+Tg3gpEx/MSevawtbMP7HFmewelIa+F
	 3KdE84bWJHlgWiY2AXuF+7B09pIucISZBNZsz+eb8Q/c3WBLOCA4wNnvNLwV1ZPoGq
	 IOnbiqJwShVag==
Date: Wed, 24 Jun 2026 17:48:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Udaya Kiran Challa <challauday369@gmail.com>
Cc: tsbogend@alpha.franken.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, skhan@linuxfoundation.org,
	me@brighamcampbell.com, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: microchip,pic32mzda-sqi: Convert to DT
 schema
Message-ID: <20260624-charter-footless-9752837b15f3@spud>
References: <20260624061329.130468-1-challauday369@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kJnnb0MVSAAFGHi3"
Content-Disposition: inline
In-Reply-To: <20260624061329.130468-1-challauday369@gmail.com>


--kJnnb0MVSAAFGHi3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2026 at 11:43:29AM +0530, Udaya Kiran Challa wrote:

> +  clocks:
> +    maxItems: 2

Please make this an items list too (and drop the maxItems while you're
doing so).
pw-bot: changes-requested

> +
> +  clock-names:
> +    items:
> +      - const: spi_ck
> +      - const: reg_ck

> +examples:
> +  - |
> +    #include <dt-bindings/clock/microchip,pic32-clock.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    sqi1: spi@1f8e2000 {

And remove the unused label here.

Thanks,
Conor.

> +        compatible = "microchip,pic32mzda-sqi";
> +        reg = <0x1f8e2000 0x200>;
> +        interrupts = <169 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&rootclk REF2CLK>, <&rootclk PB5CLK>;
> +        clock-names = "spi_ck", "reg_ck";
> +    };

--kJnnb0MVSAAFGHi3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajwKZAAKCRB4tDGHoIJi
0lbZAQDKDnqx+ZFA3ZbN+nQW+roXEoYvmzMt1ukqFJxMyQdgzgEAh0lyj2De4ZOH
mSzxJOJN3m7u5GZrxUqJi8l+vd/bGAQ=
=ElHG
-----END PGP SIGNATURE-----

--kJnnb0MVSAAFGHi3--
