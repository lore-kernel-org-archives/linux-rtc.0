Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA9B424652
	for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224850; cv=none; b=XMOiVJSk3rzECOJrb4mks74RzmAZfOKQp9kU4QpB2ZWbFboMkIVST+HtDthvrS6Gniny5Gw9ZROF9l7ebnHSSH/zefwocaaTfDBGsjWsHoSGusJXQVFRuqrDU20j2z7xAsyf/C+p9qGRQMJDuOrbsGCyt7IBRjnlm7jIifh+RsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224850; c=relaxed/simple;
	bh=rNIcni1lpx8sulgXqfDqfqazBSoFacL6NoG1fGR/mvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdWmE5Ygn6IU3fKynKywYQ3zpLMXApN5vRXRcT9vc8B5J9Iu+Yag5IB8cBecUPL11UiJfLAi4RaLWHsalW+eaocCM2iB0dqbElc8z8SGlGK0pk1/70mqu3/LFnmFhqQo8oXLKCq7KUpb9SjQXq88VXQcNBpu0cBIlkZV7dKu8N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=IFvCHdX1; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="IFvCHdX1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Jspu
	ba05LjL6CBKgMcIeeBbhf0TMfLnZJ0Fd2rSTpU8=; b=IFvCHdX1OIeh2lP84d8c
	t4zJ5DgqfwoAOCO84BtxIr2ES/iDEmg4AslaFJp0hh8MhhSDB6NKGeYZnmSByfYl
	m87oz8v69ug/eHstPr4BIj2P95ti+2EXGPvbT73mIQbSSzNPkWoHMEz/RPmLvTiv
	sSlZgWYsXf68nggI4URuhRdL1k6zKoztXZxoibsAZEWxE808PsFGZIWzWMIND/qM
	YXq1R9lZrHd0MlhnZXkPL2QmxN6qsdGmwAn+TuwK6OAso8rVFCyRobsuLeGPBOaD
	oEBYMe5w2gZOGp1NYr+PKJezM2jirPAtX7OrZl0P7xGCOCfCNC4IrZ0eTcF3+e7+
	mQ==
Received: (qmail 277534 invoked from network); 20 Aug 2026 13:20:43 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Aug 2026 13:20:43 +0200
X-UD-Smtp-Session: l3s3148p1@MnTitXhZQNIujnuE
Date: Thu, 20 Aug 2026 13:20:42 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 13/15] rtc: rzn1: Add OF match data to gate SUBU
 register access
Message-ID: <aobjCr7ZtpLmL3VP@ninjato>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8FWAH1+rAwdn2nVp"
Content-Disposition: inline
In-Reply-To: <20260819103926.2136712-14-prabhakar.mahadev-lad.rj@bp.renesas.com>


--8FWAH1+rAwdn2nVp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 11:39:24AM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> The RZ/N1 RTC driver selects SCMP mode only when an optional xtal clock
> is provided at a valid rate other than 32768 Hz. Without an xtal clock,
> or when it runs at 32768 Hz, the driver uses SUBU mode.
>=20
> However, the RTCA0SUBU register used by SUBU mode is not present on all
> SoCs that integrate a similar variant of the RTC block. Allowing SUBU
> mode on those variants would expose RTC offset operations that access a
> non-existent register.
>=20
> Add OF match data to describe whether the RTC supports the SUBU register.
> Reject probe with -EOPNOTSUPP when SUBU mode would be selected on a
> variant without SUBU support.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I still think, this code needs a change:

454                 if (rate !=3D 32768)
455                         scmp_val =3D RZN1_RTC_CTL0_SLSB_SCMP;

	if (rate !=3D 32768 || !data->has_subu)

otherwise having a xtal with 32768 on a SCMP-only device will not be
accepted despite it should work.

Haven't checked if that could simplify your later has_subu-check or not.


--8FWAH1+rAwdn2nVp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqG4wYACgkQFA3kzBSg
KbbT3g//eDPd2vocikzCHllx9NDlhDYNBdNzSLAnbdJV+Fyazo96+R+WS5lQG13X
Du2S1c+EWvJzzAwhM2shDnJBTsWAl1RLkRhDsP7XQ+CyRygbrVV8vvCxvtwZGQVG
oIFHhZd0srm6lHKQJZvyHUz8su37Gib2rbuQMH6720GuVqU2b6sNuLnc1VoCgV2U
n1v6ooNrVoEoHgccI7b6j/+DVcSHWWP0Qigj/R23yQ3Jzt5Jvz0aV828yRXk9KHX
taiw1xHhIjDZnCwKNQ8ymTXk/lX92Cj0c1JUhy4LJMpeaB/7u5VQpcWkGFryR7bU
iuUIEZFIpV+fhCYFQZqrDM/R10nX6Scnf1eIHPzz55GoAjP4YSUbIspOZuSeg2nS
gOCO/uribzeQvTObAFpfr0AHWW1Q4p+Ki+/jY8NlJpc9u+cJmBL70d/0/3OhvrLs
S9U6eBDZn6wnxrfG8MYYs1ZQh9tcFVpFdOXO9spdZD9Z80zC4Fk+/DtHdBF/jqgv
SWdyHguq74w/SnSxKVkfv9VSU9CHFrBofWtRj4kwxKdOaZ+a+70DTMwIvFPzM/Ye
tqfHWApbIfPykcm29F0X37ctaLL3jyZ02/gYgJytMUCXKX4RmHblE5vrQT7evice
eBIwObAKldiHzKY6yZ7nAky/R0n26To/KTwy/IOTYqD+OgU+yeM=
=Nnnz
-----END PGP SIGNATURE-----

--8FWAH1+rAwdn2nVp--
