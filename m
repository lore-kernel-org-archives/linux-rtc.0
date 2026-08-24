Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D40367293;
	Mon, 24 Aug 2026 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588824; cv=none; b=ZMBic/pnY2qxW0Udf4NmZemeDJ+A0hO3k5yWuQ58ypcvt+ruSnejV0zAn7+U45rZZ7GCxO06aWIZl8A4oi7HxlvkoKVQoLtbywXCS3lOCAA6e5fxfeGV2Ke5V2t6nJ5Ut0EHgDrSp4Oe95V7WIPKIAuqU9rUEHEz9DeQJR//0eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588824; c=relaxed/simple;
	bh=94+lDHt9R/t/J0611CwVkFZ/l8fzcQUcjYYCUB/FgEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXLYrKQikz2FusOkspdpWPHQ/B8nMB45fjP9bmp+sZnZ8UsPwnOumvrY8RG5uXAAQS7Uym+N9nnY9+K5hqKT3Te51Dl7/vd+1bVywtatvdtUMUEpXofJcEvah9bhwxLmLT3gW0Je0pvj1VHg/QYZ3tE4eJ1sIfDaJPAMviNkRCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ko4SL4N0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ko4SL4N0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988F01F000E9;
	Mon, 24 Aug 2026 16:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787588823;
	bh=94+lDHt9R/t/J0611CwVkFZ/l8fzcQUcjYYCUB/FgEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ko4SL4N0LCl6y4KP14gPoil4SO/JdcZq1o2kOJsrWfe7KprTye0ogTWQUn6cKXop1
	 9TNgTDuQrlNK5Hp8sRGX5RfjrEQrN3KottypVxCVv8VBHsZHtowmpvQOq1eUHzw361
	 ViK1df4Uvhg2TObNL0616o2l+KMkRczUEf7Z+uLVboNLeDNYQXspMnA5fqdKgUPi1/
	 n7ipxOsdwfbd+FtZa3mA0ISRxP43hw7UkGyngSlV8V4n2vyAjk10U6Zigx55BOraQm
	 zlJlVv/mGxmpIdhx8Pnn3CY7Ahlk7jdfq5SXMs4ofjwBHL2PAvvZlQy021q/kKF0KB
	 /ZAcpe5JJbacA==
Date: Mon, 24 Aug 2026 17:26:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Heiko Schocher <hs@nabladev.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: rtc: add ricoh,r2223x binding
Message-ID: <20260824-endorphin-gotten-f1271d46ab93@spud>
References: <20260824110452.4038870-1-hs@nabladev.com>
 <20260824110452.4038870-2-hs@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MDtuG3WHdW6qOPUW"
Content-Disposition: inline
In-Reply-To: <20260824110452.4038870-2-hs@nabladev.com>

--MDtuG3WHdW6qOPUW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 01:04:24PM +0200, Heiko Schocher wrote:
> The Ricoh R2223x is an I2C RTC of the same family as the r2025sd and
> r2221tl which the rtc-rs5c372 already supports. It drives a clock output
> and can be put into an eco mode that lowers its current consumption from
> the backup supply, so it needs #clock-cells and a property for the eco
> mode.
>=20
> The trivial-rtc binding does not cover this, so give the device its
> own binding.
>=20
> Signed-off-by: Heiko Schocher <hs@nabladev.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--MDtuG3WHdW6qOPUW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaoxw0wAKCRB4tDGHoIJi
0iFSAP9xTCtBh/DkUDp1g502KMP2YY6Y2eXl3dPbRl5WpI6eiQEAmoW5ThaaHxUD
S6tnyqZ0oIgFxiiDsMedsRippOW5PAg=
=wXmE
-----END PGP SIGNATURE-----

--MDtuG3WHdW6qOPUW--
