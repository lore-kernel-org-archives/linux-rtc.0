Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC69B3BCD0A
	for <linux-rtc@vger.kernel.org>; Wed, 17 Jun 2026 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690540; cv=none; b=WiWsV6f/sOMTLdwuZ8rRwxMJGfwqshJpsT9988WdxkKsP+488UawMjqLCZtQ5HnxDqYNxPwnUf4RG7zB8Rj2Gq2U+kdfGfqGOm+sxslAkhM0eUZivGEFpB8bXdN6eySew775PtICDN0nZ5hswQhizng9M8DvoKmF9WX94K4tAZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690540; c=relaxed/simple;
	bh=4o5OuqN2tEaIFaYsOFRv2B02XJgVZiqwZxrylGJfius=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIMwFbNvddy55VDi5xUn6bralDqrvl/O/o5eKSgkiigQMm2zarmAj6eSKU2HOOBP13RUx5VuHK24Iesk60kQT6fIsBFfDVGEUk4HA1MUTV24+xGiquV5YGDZcRCpHRj1Ue9LbTeh11JhdHzsBncmPLgnwIpeLdki3wBEVYSSPf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=jfLn5P1N; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="jfLn5P1N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=4o5O
	uqN2tEaIFaYsOFRv2B02XJgVZiqwZxrylGJfius=; b=jfLn5P1NCgC/Rz+xN2o8
	24kmv3T5Qc5eDqv7F17HDBg60ZMa1R/Kbm5iFzS+Xu2bCMiwp+EW2ghDdLXU93JZ
	QLdJx55eCtK0N9Ix/OPLkC2wRqbqB/vb1zyFIi+KnlQZuf/XhIGFbGVhQbeZ6noI
	4cqv7c6bAZXDzDs+rg7LkmEsTUwTHrDfTnMclCV/9w9Kpa9i9T0Fln8cqEQOkvFD
	mCdSGJYvFafVdykyJyMXorM4UCnbdrHtbfKGfmwn49ThpVdBtBisigPNSGfxezp5
	p3fFI/d15oZOSyPTqmgDJtbhgoTUt5jqmDHUiRekXC92hkFPJiXsqufr56qd2QZD
	aQ==
Received: (qmail 114252 invoked from network); 17 Jun 2026 12:02:16 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jun 2026 12:02:16 +0200
X-UD-Smtp-Session: l3s3148p1@KRCFJ3BUMqAujnvI
Date: Wed, 17 Jun 2026 12:02:16 +0200
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
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 05/12] rtc: rzn1: Add system suspend/resume support and
 wakeup capability
Message-ID: <ajJwqDt2jUfhSD1x@shikoro>
References: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260615154805.1619693-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hqHzedOQbdGcB1SM"
Content-Disposition: inline
In-Reply-To: <20260615154805.1619693-6-prabhakar.mahadev-lad.rj@bp.renesas.com>


--hqHzedOQbdGcB1SM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Add system-wide power management support along with wakeup capability to
> the rtc-rzn1 driver.

Do you have an actual use case for the wakeup functionality? If it is so
limited, then we should maybe not support the weak abilities until
someone has a real use case? For which then, a proper solution has been
developed and tested?


--hqHzedOQbdGcB1SM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoycKgACgkQFA3kzBSg
KbbNSA//T2grMLIiSa3whMiupODJrq9i4V96Vqgef6ys7tzeh3ByXQnqHIUFIL/W
7SwwiAvkesDwbsZFFCrab2wp6j1LN/jUNmkcOrWh2Mg0TsLc/ln1X9f4W1BBfOPZ
u+mZwhmVjdt7UUl8fsG2igCE3Taxjycf7dxlUr1JjKnASriGyaVPBHFV3ASPqRin
fEShf2ldk47zfvOLrZCQlh2taP2CLY8ZjkpBwh2JO//0TQ6P2batAj3B8Sr8sugR
Y+aOt0oN6Z/SfBvYBrkwiCDNJbe0urq3+xSZ+yTTlKd3PJFHAuEFUX3UwXO77FZ0
2EEQ1rqMS92M1ZOXk6foviiuokdR98wSZguQS6hNrtUiVrhLVoqiC+WP3yFJGh1z
BDeqjR228UkjLV5TpCbcF8AzAo8ae9dHic0tpgrSplSwOevw1kpmgV0ZLxMIEutI
XczfH0vVNeRTRAnaLkaB2q6vBWuJ6Qigc6XI1uHntd2covOSBjMjtuYYW8Y6s/rw
DOh7uo2OrvjMC6ak4ndFdAJzqhZhJHUz0Nk+ju19XNAGq8BBz2zK1qXuLnf/aHIT
XuQAMeM3oGRoJ2vGafMmblI+uPO6N2vlFCDKbQAjWeYc4qCDR87KVMEBVv0PU/kX
rY0qDQuYDI8xNZDhXvWWsPwE2uPR4oLJcKh18FR4CZzoaeYuT7U=
=KyJf
-----END PGP SIGNATURE-----

--hqHzedOQbdGcB1SM--
