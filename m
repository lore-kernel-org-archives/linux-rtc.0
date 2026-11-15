Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794757266;
	b=yB+ZfXhl2acAoyqk+3H/HYwCKPmObpTz+qvadgFWK8DVFzdIgAOhQ7f1mxuCvDQF6gsu
	 4Ywq0xAXyqwZp5FLKFYG+oJqfXw+qoafR/t5ZupqsF4B+ODBqC0hoHJrerFYkK7SKJbaj
	 PN9JFlc4Ckwek4rSKHP1ClfE4QQO7EBpw0OmhVa/yLp0B/S99aYt07/JPhpftayJn9nYw
	 KiQUX/2ULFCkSriAJl54OwjxwLxntMMnhWh+aaQlOHZ4LnAYCPVR+0u5VylXNVk/U0guC
	 gjTnrS7eXr4OtQOGXpbqUbcy2e52jeACAEpKz1nmnYaw+AMFEiNLfUAVyt+PNEGEKbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794757266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=PVuohZ8xLFR5YiCoEYGFhyPTULZBGZj7Wpwh1r3TICY=;
	b=tj6JFG5M5oJcJblaJIUYJddBKYOYc3cO7FaIJEnbGRe2/UQoLy2H1/RaexvVEgekvtUp
	 dPFSXudL1chyWsVVG0N11Uk4BcDqHylGTDtDanQ9pS053phZgzQI82xXwHZOtF3NqekvQ
	 mh4gYjP8H43EcgkN9ZBq5N3xNqti0GomvC8Emhp25UcbzPyY9w1bIpifG82YLa07Wh+bE
	 bjIAZcdYUg63mKzVu5aIdGOd1t8VUFHKSOdzRTJeoTS+y4Y5UIToBghpKUU8WKZk6epmt
	 AkNCJVYDO+Kqv9Nl1CbXIDDkM+GViQJWMFtFt1GUhZtdMmmKZNFxjYRB0WvZCxG1yiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JcnXBjQ6;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8CE606A31A
	for <linux-rtc@vger.kernel.org>; Sun, 15 Nov 2026 15:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA8CE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JcnXBjQ6
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-497614c95f0so1129763f8f.1
        for <linux-rtc@vger.kernel.org>; Sun, 15 Nov 2026 07:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794757264; x=1795362064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PVuohZ8xLFR5YiCoEYGFhyPTULZBGZj7Wpwh1r3TICY=;
        b=JcnXBjQ6oVs3WO6WxsJjlXF3Srfn+XWnPXlN0yzPpJsvcbjAwiYznR2yVsrq+dIF0J
         W9K1hDH1dg4Rq7lZSMIhfD3gchU0KLGorPdGJ+zlQeEucdr7nNce45CvydySUCY90PWY
         Xyu/qB9TRVQV4d6tUrWZIxOCTwwDWe69IsTtjWCZjxdP2vvALjzMAogu8SPoZHkOZyaF
         zuC9NuaXKcHS/ydQMct1JDP/0pjhpMGbTARWR/YcAz+Qib3t24DwWdP7jNV5O7sXEqo0
         nlPhnW30vWk79ZmVTGvnuZbrJ2Vgh12vhrZe5Vz+JkN4iiK2dMUW8v2WdxiY8cHNmbsu
         Y4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794757264; x=1795362064;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PVuohZ8xLFR5YiCoEYGFhyPTULZBGZj7Wpwh1r3TICY=;
        b=Xuv79E3OeNLM1PPz1grofp72fUoh0HWq4BfOILBBklU/kWiThzB+AdsV79O2s6v9t/
         pmKgz8yWCp6LDU4jEOmzuIg9BVPo4FbNB5rKfZBxM5OdRWCifGznUFhk6SsqYESuXx+8
         Fz8G4bvU/1GfcXhlfdxX3xzQsFAvmZFHGyd1Cffp8XXnfnivAQngDaF/2Twou9cnYuj4
         iiIVoFhVca0vt2n3n0Ht4RLoZ74NJaYB9rB9+A/LwiB2FCmXlbWu85eggjTGR+YNytgy
         2sUoX1F/9FRXHW6N0tl2NffsHs6eM0LPosUF7siASq0aXz08Wk8rpt5amVPN33Fq6MW5
         RjvQ==
X-Forwarded-Encrypted: i=1; AL+hErEpNTUMFBu0FyvjaQYSwVBOgYeW+aj+HFZKMIKoSFE4VzysFcpWBV5TN0dn5BlOUslXBf8j20j8Tlo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9xmyIm1/YlEjkR+fUz872N+IZEV1TqMAf2rhXG/36EGK9yWZ8
	deaOaA0E5Ho6e6lcr/UuwwiqVvhWxH7R1sqKxj/jdD29y5Dey5BVQs4RVjFMaVbQuRo=
X-Gm-Gg: AYBFou2clVqrVe89UVE550obd5fb+1GpHFI/sv3t/iRhhKBxf5VJs3FFXfB1+tpkKba
	EqR1phSjTkONeWjE/vjgB+GfqqidXBGwN1LcLExFjRwuXPUhOuDogljhJBHQSdhZrvzYcd5Ji+X
	DOLlrs+YFKg28RkXeThWB78Zk0jHRu1QPCBpdWwElcLHDqMTZoFktvCYWK6OwEwAuKxuLfL2nKy
	AK0ayU/oO+wRtTj7PxrxYcvkMEWFjJn93n1F+prV3mx8x5addsmXQJe+zsDM6uZ2yH+E91kO2QP
	tItgW6PR2u37sPsxIo9mDGSjHB0ckvth3m7rP1fpdpwlAh1wOxPrr00qInNzPt58L6oQRBG3iiT
	Ji4i577miSqLK5cAB7LkcDd26D4LpxR725z5nvhVEUwXV6tnQwPCVG4VRRHIrlGNei+Z2s2UPmL
	u/KDMCTDe2j8/Svy3EUHbpQaFvER/Va16oqAy36zPJoMC/wEuWMWDwTsdmV5Mxtj4QwIeaMZMNv
	bri6Upwf68S6uaDwIAFmzw8gBv1B5XFaIFJcPt798yUVRn7D84ScctJhK4cl2GENRU0KmRv6mqQ
	R8/3Im/hLdZYsUNt2wo0opRUFzvn63uJ3gM=
X-Received: by 2002:a05:6000:2c04:b0:48e:d36:77 with SMTP id ffacd0b85a97d-49c6fc9db5bmr19465481f8f.4.1794757264141;
        Sun, 15 Nov 2026 07:41:04 -0800 (PST)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-49c888b90d4sm16462060f8f.9.2026.11.15.07.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 07:41:03 -0800 (PST)
Date: Sun, 15 Nov 2026 16:41:01 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: gaohan@iscas.ac.cn
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Samuel Holland <samuel.holland@sifive.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Maxime Ripard <mripard@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Andre Przywara <andre.przywara@arm.com>, 
	Han Gao <rabenda.cn@gmail.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, 
	Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rtc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 14/19] pinctrl: sunxi: add support for the Allwinner V861
 PIO
Message-ID: <avnR67LnZo4Mo0Tf@monoceros>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-14-eb71ec3ee523@iscas.ac.cn>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fgskattfdxvvv7hb"
Content-Disposition: inline
In-Reply-To: <20261114-v861-v1-14-eb71ec3ee523@iscas.ac.cn>


--fgskattfdxvvv7hb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 14/19] pinctrl: sunxi: add support for the Allwinner V861
 PIO
MIME-Version: 1.0

Hello,

On Sat, Nov 14, 2026 at 06:33:40AM +0800, Han Gao via B4 Relay wrote:
> new file mode 100644
> index 000000000000..742465076d86
> --- /dev/null
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun252i-v861.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Allwinner V861 SoC pinctrl driver.
> + *
> + * Copyright (c) 2026 Han Gao <gaohan@iscas.ac.cn>
> + */
> +
> +#include <linux/mod_devicetable.h>

Don't include <linux/mod_devicetable.h>. <linux/platform_device.h>
already provides of_device_id with less dependencies, so please just
drop including <linux/mod_devicetable.h>.

> +#include <linux/platform_device.h>
> +#include <linux/pinctrl/pinctrl.h>
> +
> [...]
> +static const struct of_device_id v861_pinctrl_match[] = {
> +	{ .compatible = "allwinner,sun252i-v861-pinctrl", },
> +	{}
> +};

Please drop the comma before the closing } and add a space in the list
terminator.

Best regards
Uwe

--fgskattfdxvvv7hb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr50okACgkQj4D7WH0S
/k78BwgAggANSfiR3lIax5U5QxcHapAeEwjkuu5kUUd7ThVymu6geBziPkTKM9LN
kV1vp14gkKuMuThllE6yPhDE+jBai3H2dmZPRAVxRmkHkRXaCGvN2Qy6QvjG7hn+
pKrIhNm9FD3gtJcf3syW5npYiRAxG/6TkK+Gz1PXPgmg9Yj7puOzJ5ZZsZ+kBOcS
xiSHHn5ujqEIP4jnBc7Dv7UpeDH4NxdbQ6ssuWEYpdmNKvGpbP4Xi4tlxo4RAMXF
XWXJcAtussx3dylMOghSQ5VBKABwOqksAb/tX5/oaY13ScR8Lg/M3WzfjwXPwvtR
yRXJHXEAk7lxYPB9WoXGrz3bVWm0dg==
=Eo1Y
-----END PGP SIGNATURE-----

--fgskattfdxvvv7hb--
