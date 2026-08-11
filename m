Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C251446074
	for <linux-rtc@vger.kernel.org>; Tue, 11 Aug 2026 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455772; cv=none; b=GUNVGgv4rfmqcr4/nX66659Tu0BFaL6YRcs1FYY/uMgRCyrpIcIXZjvOuCnx9fPEUvDQyEnJ72RTqgdcCF9NI7iYAk5PAmfvwgCzLpoEtANiKQPWSlcx+kafXhE8JB/Y+I18XKlQI/owYtp0q1f9d7IglylSHW+Twkjr/PoEeLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455772; c=relaxed/simple;
	bh=dzCg+9gjTeQCSQnJV7nXw1uw5Ycp+ZYb0dfAyNCr8Zw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GRKyiP4tH3u/F3F4gD0uEBBubZihR8w+q/2O9m2FIs8EgKOBV7cAhxdIxIetlPwqst51cgK9eB75jE8sqBtISWmiRdwHxBRvGIYSgRp/g35y4UKZmb2bOt71vdfnpe6pBQDVZbDmtGnqtECIHFL+9lUxGegGYDtxafVCv4kJUNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=Z7VDvriF; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Z7VDvriF"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id A576D240103
	for <linux-rtc@vger.kernel.org>; Tue, 11 Aug 2026 15:42:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1786455757;
	bh=dzCg+9gjTeQCSQnJV7nXw1uw5Ycp+ZYb0dfAyNCr8Zw=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=Z7VDvriFBC8lhUvYFmS3tKbUtSuBxRPxIwNUQAWQ2KPh/R+1JHrMwWOTKJnxkQBQ+
	 9+VG6MXcV0vkfemjBH+yVDG6MmWfxNLgwBmeC4mL+vS0KZtO90jt+st5AHsU45AO34
	 4lInp4EsBrjZbvlrLbBmqTi48s3npg71bMPsunCFRb7N5l9P6BJtj3BMhoJ0s1+RER
	 1vTPwxa6ven5KKGlYQttqV7NX6ZnluQEZaki/YBwDIE7d41etx6QLMGgzgRC3dKK8x
	 xj2bpUDmZiPV+b64bXqqxbq1FA3Qsf5Ay+xB5mD4LwNMBwib7Um3sAhQqVdV32Qsl1
	 vMRXpPJr59ZkA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hKCVK3f0zz6tvx;
	Tue, 11 Aug 2026 15:42:33 +0200 (CEST)
Message-ID: <2b293ec3ff83348657a64ed551a3c8533fc1d336.camel@posteo.de>
Subject: Re: [PATCH v3 1/5] dt-bindings: rtc: Add pinctrl for S35390A
From: Markus Probst <markus.probst@posteo.de>
To: Linus Walleij <linusw@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	 <uwe@kleine-koenig.org>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement
	 <gregory.clement@bootlin.com>, Sebastian Hesselbarth
	 <sebastian.hesselbarth@gmail.com>, Michael Langer
	 <michael.brainbug.langer@googlemail.com>, Andrew Morton
	 <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 11 Aug 2026 13:42:35 +0000
In-Reply-To: <CAD++jLmbp5v5oy9oas3q=nDEvdvmPZpX71eHwEUgSKkn4bfCkQ@mail.gmail.com>
References: <20260805-rtc_s35390a_int1-v3-0-e836faba3e25@posteo.de>
	 <20260805-rtc_s35390a_int1-v3-1-e836faba3e25@posteo.de>
	 <CAD++jLmbp5v5oy9oas3q=nDEvdvmPZpX71eHwEUgSKkn4bfCkQ@mail.gmail.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-QW3gka1UqdUF6X6NqTlC"
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-QW3gka1UqdUF6X6NqTlC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-08-07 at 19:23 +0200, Linus Walleij wrote:
> On Wed, Aug 5, 2026 at 9:32=E2=80=AFPM Markus Probst <markus.probst@poste=
o.de> wrote:
>=20
> > Synology NAS devices use the output pin for interrupt signal 1 to wake =
up
> > the system.
> >=20
> > Move devicetree bindings for sii,s35390a into its own file.
> > Add necessary properties to configure the individual pins via pinctrl,
> > which allows the interrupt signal 1 to be used for wakeup alarm.
> >=20
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
>=20
> This is a bit unexpected but I really like how this looks
> and how it is using pin control!
Thanks!

To give credit, the use of pin control was Alexandre his idea.

- Markus Probst


>=20
> Yours,
> Linus Walleij

--=-QW3gka1UqdUF6X6NqTlC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmp7JrkbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPStjQQAJWXeNaXaQVNvejgSBMg
tvTp2Udl6C+FEODA4dfsNjhm16qkEzN0QBirIL86nifakQW3nergAjyuVfMvJw+0
2sQvyvsW98NW7qEDZnL2Eehxjwbab8rop3EOCnkGusLwzBZEItVwpuX8G9UDZToO
skG35NSKZ8vX7IUl04vdms+dP5ou28UseGm7CTR3y1PIaHcFwEEfUhQ1P8bZQJ7x
broWwqA+qptOFUSfTv3xdi/XzO8PvIs0CR/eCsBI6rn8uuhhX1gvY55tH6uBb9W0
NJPf+kLxgeLu2stTjGUN9+vFi8DBpX1/rj1ES6sKgd8P3MXCg15gXBZ9oYA3nNQj
JhFuy2mc3qDqFVzTwcpQghvj2o+zomWbYOLFf0lSpv305UFb2pXXVsQNNr8YUglu
21I4PRKMTIoskBqKuYyMf76CBaXmgWiP0138t2fo+BYhFkm2ivyyyaYMcDx9OGm7
D/0aWJau2Em3UwXnFLc3vhgkFfgffaS7NWsQUyxGHovlRzcrZ+gSLDexRhk5mqGL
kkQonf/4tUL4QgqriEb8qx8ey9ozpfhV/ts3cfYUdUCY/rev/8+iYfZMCIuV75VU
Zm6Ucsawg/Wj0z5Ebt0F9n8UTZvacVZLuca/pA/lFhtA3WtRE24Inf51BW0HuNd6
qrwJcxEd7O4+sMcBZXw19b1p
=1cIM
-----END PGP SIGNATURE-----

--=-QW3gka1UqdUF6X6NqTlC--
