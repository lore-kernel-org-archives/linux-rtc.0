Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66BF4EBAE1
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789559146; cv=none; b=GX/XmUhpi+Nh2Yew7nLFODJv2P0TobI0XNDBFVcweBLZuu+dQ31f6w43wwHOFd5egxpzprj6YKmyybmzA23PNQEiL5p+ptJr5LOvLmGOF9I2IZFLMrsgnLCTPYP3KkYqKTkNhimz3W981WIRsWOYMHH6WPFVOmtuvcxzIhmqQ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789559146; c=relaxed/simple;
	bh=IW/yCPvFmk7YCDWqjNr9MDKFoJwkZ9AZ+1tRZDknPnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzNu+m/ZnP+KIhjGr2I+UwJ2BudozKqv+9lp5ZbucPp+F7CPZVzUu/WbLUa23l84GzCtjXdQwC5r7isaZ08j4xY2i7w0/QCug4Wg5loygNyytmSgOICO/hZoDsV+xgPZWaPukOZ2itpMSdvZZys1KIsJB8icuZAKRG5OhmVJuj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=lq5ndQNN; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="lq5ndQNN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=IW/y
	CPvFmk7YCDWqjNr9MDKFoJwkZ9AZ+1tRZDknPnE=; b=lq5ndQNNTdMy/a+Huu+y
	8YQliLZLtw83RL8kn2FMiN/oTWkG8OxKCHN5BGj4bi62dBO1ijHadUuVvg4jO5M+
	3PTailTMw3Mezs9J+tMEsHi6/wHTt0EIEWlBpFGWD5Qd1KmTkeP2/QonZkEDEhTb
	BbS6C5C7KhBv0Mdc+0rAU7g2xigot29mf4O5BWuFo7Sgg3M+EffliwIZTDlEdK/3
	o6k+Qqv4Mz3c11CkOtalh1OFqlCjN6ICpq5mNQXh8z3OqgSvMr4aPGkxfVn0LUlp
	HdiBLIxGMAXoWytBDAMWqEYnsQIIg8szvWe5r6xXwSGuNGJeHqU4Jd0b8bKYLVGY
	sg==
Received: (qmail 1525226 invoked from network); 16 Sep 2026 13:45:27 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Sep 2026 13:45:27 +0200
X-UD-Smtp-Session: l3s3148p1@AusONJhbaLoujnt4
Date: Wed, 16 Sep 2026 13:45:25 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Lad Prabhakar <prabhakar.csengg@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-rtc@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 0/4] rtc: rzn1: cleanups, R-Car Gen5 enablement
Message-ID: <aqqBUexfsgjESI7d@ninjato>
References: <20260916102520.24288-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wFfC8QQzar0Ogem8"
Content-Disposition: inline
In-Reply-To: <20260916102520.24288-1-wsa+renesas@sang-engineering.com>

--wFfC8QQzar0Ogem8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Looking forward to comments.

Wow, Sashiko is happy and did not find any pre-existing issues? I am
amazed...

Anyhow, I wanted to repeat my thanks to previous reviewers. I think this
outcome is in deed cleaner and easier to understand / maintain.


--wFfC8QQzar0Ogem8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqqgVEACgkQFA3kzBSg
KbYGRw/7B1zAAIwwga/qRXVTKs2kD1+doUePo154EoNTwLp/YyGf65OTUWBoY+Me
KWx8GM2HNSAMLI0I6s9t+Ak/LhM2C7FApbEw+NpSwJPRGT0WYBjZ48i5HDyNXhjm
g/RgcQm5YiYDHk4H0xjAwzx9TFIq1k5YRLx9Tm6xebDPmyXAppRnocJrXPMZ7X0x
x+I8nAq3DMzBjFAFAOKCYCST1J79k4l99lSkHVRmFnONM5iebu5bRW+Hs5+dgPal
i+4POSFnb0iaKzlYsuNwPuZxh0MAz5t3tgwkpff/znwhFjhLOFArwuo1wGWNXzQE
NmhnKRXPZg6fzLWLeP0apbJ+mrpNEGfYnJNtfSaVyiHzYKMIs/RbweaHpaRwYbox
bsBGX9l1Iyyr0ygfFC+dXcxT8QSDUiPts++jY4/8UueFfMuxK5H2Pkh4Be8TBZ+O
mwkOXzY55AbqnaiTkSmYJcfHaVnSkCPM/+zKyJrY8oJoBNAm90SlHMLVO2BcQXKl
XenbhKLRAiwfwumPL33cPPv7hBw0dNXsXrhmzIAf69V4KxxaZAYIy9xr9zBt8c9W
ayVyVMlhQVxvP2kCIBISTvCdtCpLD9kXYZCvNBTcpYtseUUBf+jdz0Xf+p9psTyz
e5xgBQPaSIvdbzpFHEWWX1RnguCpkbkNkYr9wRxwdhNWO0T87cs=
=uFp9
-----END PGP SIGNATURE-----

--wFfC8QQzar0Ogem8--
