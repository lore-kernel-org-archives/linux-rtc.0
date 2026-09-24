Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6F840F73A;
	Thu, 24 Sep 2026 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267273; cv=none; b=LZyxyZju4+LP0xJ1f862yogouw105VD4cKg8uafTnOQiwZoIx55PgYeMoufetTwkant93l+dd95VP4w1ob88nMYuaieyQ2AK7TAwl+qkzA9D01sOPIa/TjO8S3BIHthKj15U/JCfCHLPcTAMgjyi2jzw4Ss52yLdjme0oYB6uJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267273; c=relaxed/simple;
	bh=qenKTVWyU01On6Yw6pYMBwlPmtPWnc/gnMEn7oSbyBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/ulUji8fiNfOAf8w3Al+DY6FjuspkC7t6qbeTE9gTX6RckpHiahd3SHWDBVbi+uzqNqe4YsY+FrAi6PXJMHTzSNujRbjKwWcmipJGyC2kGVfiQwDHVTsqDwba+lT3UETuS0gJ+iHKisEBpV836jLVYCxdeEv/1/YeTE2LLX8sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYby8l6a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYby8l6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2911F00893;
	Thu, 24 Sep 2026 16:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267271;
	bh=qenKTVWyU01On6Yw6pYMBwlPmtPWnc/gnMEn7oSbyBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IYby8l6aDvXWpdeZsYTt/jeo3Js47BSl7SbC7IGw4Kz8auUpYXHbRsRalnz/nxJQU
	 aIHG6nldUH8Ktbtoc8f9mWp51AtzNcOUzzUSE+FbE9gW3pOB5X2z9cELJLEWKVZc9V
	 aIhdf8QZLqOEpLZQGETEwGs3LKETSsEmg/AanLNfci9YU78y3/pxhzzDUOaMBXzJmB
	 aPxlWf6FwuWcMT9juIwq9RPjJJ1jkAXj9TEfOICX/j16ke5xRuIzQbwL9pPPV4d7tj
	 drFJ1h1d+MjcniAiCRxKxYV8lYf6k9DwFEjXGBHg8CAHVk4joie3g8Qq/ctTanmsqP
	 wyQX/pQzLkhXg==
Date: Thu, 24 Sep 2026 17:27:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Sander Speetjens <sander.speetjens@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/2] dt-bindings: rtc: Add property for Raspberry Pi 5
 RTC
Message-ID: <20260924-verse-attendee-c2e7a68e4f18@spud>
References: <20260924132217.1281752-1-sander.speetjens@gmail.com>
 <20260924132217.1281752-2-sander.speetjens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aPgkns3KRYWa2vD/"
Content-Disposition: inline
In-Reply-To: <20260924132217.1281752-2-sander.speetjens@gmail.com>

--aPgkns3KRYWa2vD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--aPgkns3KRYWa2vD/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarVPgwAKCRB4tDGHoIJi
0oGJAQCRVhltLXItEeu6nDUP7z3EBw9Gm5wQxxOZpP0zbP8BUQEAo2HbGW7dzdql
+B8T9q4Wqx3eewFhfetPLRumDlBgOAc=
=5Lam
-----END PGP SIGNATURE-----

--aPgkns3KRYWa2vD/--
