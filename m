Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794178621;
	b=ugFR8y5iAfb3XS6BxfvmwE2clki2aQavlc0tjEn+hnGaI9jNGCsXjvoHhaW3xZRxAjfW
	 F/K7f09bKk+bbfxf+62Pi7uofWJhatS6z+pI0KD6RpTXbJcNrjB1bZOYtt+sLcseCc116
	 QVs7/QDkwBlzlghIBQQZOsRrAUWabOsBMc53zn5FkmbwuFlaLX3vr7Saj3ExGREp/imKX
	 UEmly1kFMbbh+mhSYWzP9wNrW8ZSH1un/1tmZoo/paihj7cOSAQCSpchjU3p11jameXks
	 qYM/ZRGp7kC1rRDw0KrHXqz7F57B20W6aZNgZMFl6q8pgAIMU+1LtifPCbwmulifFpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794178621;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=20LGVkr7OyVCpXpA7vzhMSUIjmcZLUme60763s7WuI4=;
	b=z67D43467yWffQja7I7Nz5AABV9untfleozi6LEL0Vx6uuCXtiPXGDtyy7Jspzs6hnbS
	 sKPBIv8WsiAj7jVb4Jjl9eCInJHcN/4elkWS2Am4cXFNXZspYPWEuL0vbLmcmwf8G078t
	 YE8orxzpoXhgv2sW3pK8pPyeTCBwbewyZufkH4HwQEBqBsDnCj34TtuqNwN1qjDz3aB/E
	 vxM25qGzX6cz6EMoqk92zMaCgl5kJCcvURvusCgU1wrQj7XSvXrMt78NiS/+U2QdFbZr8
	 kEQAnNR+dnEzCJigzm3wQ17O9FZsHUoHsGp4ZHYBUEKiVp9eS85/P9nYSWf1Mpa2qnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LXRE6x6S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC6D606A31C;
	Sun,  8 Nov 2026 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LXRE6x6S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D71C1F0089F;
	Sun,  8 Nov 2026 22:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794178620;
	bh=20LGVkr7OyVCpXpA7vzhMSUIjmcZLUme60763s7WuI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LXRE6x6SdG7IyarknMia1YiU8msG0Ve5ktruCyF0lCx+UVcgvavx8E+O78sPKTsGG
	 x5+n5UPog+1EzaoORkKrMCILjgKfrifmQUiZVggZUBou2tqsshQs2fe5PG51J+trjH
	 dKpNJY0KX5zLqfrgGZEfZDmflcz024+wfgXVOl4nnvuWXLPsZcydJrzH6WkbsZrlN4
	 HBO2PGhub/47bFEdy+0XlTr2OPB5YVKtkl+Q8WIDCWSPgdljaHJI6b4F3wfI4qsbqg
	 1VoEn+HG0mveOemARyuRmlDOMjnHg7wBGxZyuMlJXXd9evDRmRKRh/Yp3xS5Pe18nV
	 ue8KI0YIlRAbQ==
Date: Sun, 8 Nov 2026 22:56:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Owen O'Hehir <oo.hehir@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Hal Feng <hal.feng@starfivetech.com>,
	"ziv.xu" <ziv.xu@starfivetech.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: rtc: Add StarFive JH7110 RTC
Message-ID: <20261108-arrogant-comfy-702e4005ffb9@spud>
References: <20261108212826.15890-1-oo.hehir@gmail.com>
 <20261108212826.15890-2-oo.hehir@gmail.com>
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
	protocol="application/pgp-signature"; boundary="SjCXAX+7+0ikTLlp"
Content-Disposition: inline
In-Reply-To: <20261108212826.15890-2-oo.hehir@gmail.com>

--SjCXAX+7+0ikTLlp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--SjCXAX+7+0ikTLlp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavD+MQAKCRB4tDGHoIJi
0pnsAP0eKWJ6w6W1snNjKukK8Fjs/2I49K2VUTuJDFtynSBZkgD+PikODNItjDsS
5JRL6HhB3lWBTwpaxHIxtWpOFzjT7wM=
=iVtu
-----END PGP SIGNATURE-----

--SjCXAX+7+0ikTLlp--
