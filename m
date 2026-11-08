Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794127059;
	b=3HeZslIP7zsk+KHv/02y7h+3OIzkJuUxRT9uxjy1qpmpI6rUiDoKeEXp7BtJHYYlF+E1
	 LHDUgtgUBk+75ZLmRZHg1XZBtvU6nkEvrQAlkBEBit1ph77PH31yFgLNHRlyxphzQcvFn
	 TFLPn1aKAY1iNRGUul9vbtai/QHbkfMKcKv7enrmvjcG8WHtm+F5M++r+uN9G1sFHpctd
	 rnYhkcmMK6d7noFbWSyGA7iqrGtQ/z7vfHrM1f4KzqYTagzAyizLMv0VMnGyywvzqUyhd
	 2BxsJu0Eh8/OLOfUk5HnjcGR+V2GeUAoFUB72cbsehTJ3PLoU72FQmX6n+2YZVFMSnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794127059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=W9Ut5Tx0R51AH+pmP3Heuh8Ql+5ThEQrrnH7J3z+HIk=;
	b=kLftar/U9EOaBjM0AQ8Cs0O8XKzvrUATTWUR+BbFozl2KGsp8/fRHECKG4a+LGSI9tdW
	 pz/HMYA9/j3pO4lqx3KM8oWFAE1XYUMO4rYqmuT4tiljQK5Gzy4xDue01/GQCsZIwF+zg
	 eESq/7/E1hCOJVcncKbFQD+zhgs3tN3wwlIRihemNWTWL7Q115Kdl2mT2cSGa4WsA33aL
	 MlW4UmUdLeYu8lmC0HJUh1QzEZuzh3GfgdT/I7DB+ehYks+laA01TtBAZsXmbURTxUyN9
	 5kmwgf8wVSRdMIoHEwI+PqM9y6Mx8kE57jM6invdKZT4XotH4nOfwIwzIAKX69PLt0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="KRl1/c0P";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE32606A321
	for <linux-rtc@vger.kernel.org>; Sun,  8 Nov 2026 08:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EE32606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KRl1/c0P
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4b467581b98so1734825e9.0
        for <linux-rtc@vger.kernel.org>; Sun, 08 Nov 2026 00:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794127056; x=1794731856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W9Ut5Tx0R51AH+pmP3Heuh8Ql+5ThEQrrnH7J3z+HIk=;
        b=KRl1/c0PPnSdSq1ZKNqLBa03Uz+GxGU61qJiBhlqoyYmXnNVvI8Q1SPnzFP7uLh/QL
         DktUd+TgERSpUddShdGXWLCdk1O1O/4zQ30BEZdaa5ruAIuRLY2wfhbK+Hp2OM0mvy1E
         6nPtXk75nCi6cL2NmqmzTnk+JkN7Ra2h5WHeLZ72VeEiTYKmKHaSPIKVOgtFk1Uo3oWn
         iv7eqDXDwDWRx2rJW62u58uT3IXmPKqoniLuxEHWgOXhVsZE4cOGaPXa23C5rp2RfgGz
         DNWBM/uFcC9Y3MwnKik9kqRh2KF+Dfr5/sxr7HLpkXoIwi+Ef+zt4h15kG/Og1JYVFxF
         taQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794127056; x=1794731856;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W9Ut5Tx0R51AH+pmP3Heuh8Ql+5ThEQrrnH7J3z+HIk=;
        b=eyT9DnLVsDeEso/efNlyXiKHjlQGbFVtRNfvFOupF28MBH2nuDkVZWSyuD8UPap9Lt
         1Qx+8aJ/UfpMKs3ihi5CfLzDX3XckgJWVwHgL0X7XQ1VkW8uO87yxlPN827CQ+bb6t4n
         D+9en2YAuBSBQMBwzfvqTctGUAfxpv/RMRRZvoN5FvJLGdIxRw1pMZRGsZl9s25L10wB
         OuDzAEJGBs/9gtAkJUIlIAP5/6HdJ+l+UeLKNg+PuuxGYMb6AdJrxC4pT5G5kkJ+5Jeh
         QP2nS4UBIACy/K6qMQXSuoknvoL/IFcASKuwM5EixIcgMj1VBlk43DrhFB3Jshkzh7In
         kjaQ==
X-Forwarded-Encrypted: i=1; AL+hErGmTz86f8BRzFSyoiZeY81p0mLCIIPNaGL1Cb5FEBK+znlom5pBKwkIB/tO6ILFZVw1bMyROgCLpKY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OIcebaiaxIto65Ev/BADjx+UhtMao4yQqJTKY8nrhq4TFYdPN
	PiJYlF7XSy5Jx5dZ1G8V3ajDEs/KxPDo8lrCT8XmhRXhXKrG3lnmX8Mf4x/P24sozgI=
X-Gm-Gg: AYBFou2GTQHS0Ao6ps3siltYuYi2CG6WlSkUxqIjfWZavyfezwt3Djgm+2BI0QKSY2c
	Y0Vs0Nj1hmFjST43AaXMyFiOB7UapzmEI0p6I/4GegW5F2bSeASZkyCkvN9cmXZjrbAJ3IiP4qA
	V5XbhJdwE5cwqN6u1B2eFw+GZlfATESNxk6aTAxOud6P9ZtBbmZPfX4yVNu660Z/oJHrIhH7s+e
	9M8TlmiGEbsm+JBZZeYWInLvLEIsfo2N5JMAKjQyYB7BYERrvMrHiGmG7C4mCzhrAxaPQKx7pz6
	JZDdHngPRE+c8H1OB19t4ouDDXa7jZFZF3vdrEzN+qgUMaAUgiH013DyCvxZ/y9hqX4sjhXTNIu
	gUvcTVgLS+YyU0tRKL/q4ns81xzIEmF+pVuO7qkG6ZN0pefc3vkRDmqbawnBoXWvaF78FfCIysU
	y/3FJw6d8DRbBcnG/WB9BQd1fFDBdS4n2wH4V07HihxQA14eX4/y0ee0zTKeE1KiJ7mKDOPXbNP
	ogtSPBL39af57nPp3/6uvthRLVF6k4vmBMPyeva+dM+rB+LQeT+KVMVfSthN1/48Hyw7ErmaOmU
	zzK3xbFFAZpUCNw0mKLNi5IVFMjOr/+C
X-Received: by 2002:a05:600c:468d:b0:4a1:e00b:a0ea with SMTP id 5b1f17b1804b1-4b94d7634demr18663215e9.1.1794127056384;
        Sun, 08 Nov 2026 00:37:36 -0800 (PST)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4b7e32ad610sm320858215e9.3.2026.11.08.00.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 00:37:35 -0800 (PST)
Date: Sun, 8 Nov 2026 09:37:34 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Owen O'Hehir <oo.hehir@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-rtc@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Emil Renner Berthing <kernel@esmil.dk>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Philipp Zabel <p.zabel@pengutronix.de>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Hal Feng <hal.feng@starfivetech.com>, "ziv.xu" <ziv.xu@starfivetech.com>, 
	Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH 2/3] rtc: Add StarFive JH7110 RTC driver
Message-ID: <avA0OjTMLYrQtkzt@monoceros>
References: <20261106175600.3877614-1-oo.hehir@gmail.com>
 <20261106175600.3877614-3-oo.hehir@gmail.com>
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
	protocol="application/pgp-signature"; boundary="w6dqbkxjdqv4qjrl"
Content-Disposition: inline
In-Reply-To: <20261106175600.3877614-3-oo.hehir@gmail.com>


--w6dqbkxjdqv4qjrl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/3] rtc: Add StarFive JH7110 RTC driver
MIME-Version: 1.0

Hello,

On Fri, Nov 06, 2026 at 05:55:59PM +0000, Owen O'Hehir wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/platform_device.h>

Please don't include <linux/mod_devicetable.h>. You can (and IMHO
should) assume that <linux/platform_device.h> does provide struct
of_device_id and just drop <linux/mod_devicetable.h>. If you insist on
IWYU, please use <linux/device-id/of.h> instead to not get a bunch of
unneeded dependencies.

Best regards
Uwe

--w6dqbkxjdqv4qjrl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrwNMoACgkQj4D7WH0S
/k562gf+NM6dtuk+VWVwvfDXf9+p3g0jKrADlgWKDDzFhosSn+83jWZrSSeCdQHN
atEMR3M+GFDakfjamoCsKhlrIcVely5FAoEsrgBRIKs669FxDnv1DsNATMVzwwg3
Eg7y2DbMRNDqwG3W1huzFANgVlJwJnxjNyAzkIwjXJ4ysfKo82m5VmiPfRGvzsWU
UiBFjyKSYAmyZcKKgFfWPIkhzz2TybMy3giCRfuzG25nzmdfTurBybDNOR7u1SJo
P7610P2PM85V5G1mowLZWnrdVsYYv0dj/eReQgJzlnvNrPQbypbe37ci9ygplOE8
GyU8LEPvbAlhS3+i4v73X+olcVCOKA==
=o5i2
-----END PGP SIGNATURE-----

--w6dqbkxjdqv4qjrl--
