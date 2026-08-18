Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6803A6B65
	for <linux-rtc@vger.kernel.org>; Tue, 18 Aug 2026 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047923; cv=none; b=ekiokxwxZM4zPYiDA96QPBinwAocDqwQJPkvcYT21F9GPf7HGaCvA/jl8g9yKKASF+OOjCOO0+ornyPR5Zqy1ljAWfnmDDFmFb6GET/zQ8RFj3RFawQ3SSUP1AXyapTSU5o23fQk4fzyWgSjF0/DPVdJsIfeJBah2XLHRr1BdL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047923; c=relaxed/simple;
	bh=4bZ8fF3Hnh1TYuG1GgQfAMVPmMc4V5i8/vlrT37/CYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srBRvYGjWzCBAbEdt3dPMcV08Zn/sImZgoqVoXZ6fqgP9gEJ8CU0UvWA8bht+KaD+dUAbvVwXVWJ37mvtV3s4h2igpnUiqh+OHqs5R8Ba7rHtzuMQia3WKa1Ena6XDmR/W2+QxgToMQ8nnc29nOysTQvfEQw/+oGuL+ByQPRUdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=G5SH5oVx; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="G5SH5oVx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=4bZ8
	fF3Hnh1TYuG1GgQfAMVPmMc4V5i8/vlrT37/CYA=; b=G5SH5oVxwl8CH6BmIiMs
	NX86FLxHHiMfPb4YmyNwkMl7SjnZRX4qnpQuv3sYzzLMP6ldhDe8C6Q+wGtFjO30
	HWhUgW11SlnAPVxN20sqtlbgAr2MObl7R8rmK/JrWMIyoVdQQlVxD+csWmLI1zXX
	wTHFiVj5+Pu0C+8S4eIP1DAmrm2zG/otVF1x84kR0+yAugVFr7WAHH7PdfB2vqXK
	BZwpM09GZH4tjSY5SKLFJERntQdOekrHEDySkaidfv1Z1NYB+JdHaGF7426pazY2
	5NiiMklOmHXX9CKpbcnifGK8vSjS5aHsmucd6/+WsSgxwP5qL2t0/Stc6XNf6Xv8
	VA==
Received: (qmail 3753657 invoked from network); 18 Aug 2026 12:11:58 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Aug 2026 12:11:58 +0200
X-UD-Smtp-Session: l3s3148p1@ntJWhE9ZkrMujnuP
Date: Tue, 18 Aug 2026 12:11:57 +0200
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
Subject: Re: [PATCH v3 05/12] rtc: Kconfig: Broaden RTC_DRV_RZN1 dependency
 to ARCH_RENESAS
Message-ID: <aoQv7bs3YL6KjS71@ninjato>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PlqVvZZhDw3KHzwU"
Content-Disposition: inline
In-Reply-To: <20260706175138.12587-6-prabhakar.mahadev-lad.rj@bp.renesas.com>


--PlqVvZZhDw3KHzwU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 06:51:31PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Replace the ARCH_RZN1 dependency with ARCH_RENESAS for the RTC_DRV_RZN1
> config option to make the driver available across both ARM32 and ARM64
> Renesas architectures.
>=20
> The newer RZ/T2H and RZ/N2H ARM64 SoCs integrate a closely related variant
> of the RTC IP block found on the RZ/N1 SoCs. Update the build dependency
> and expand the Kconfig help text to allow this driver to be selected for
> these additional platforms.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--PlqVvZZhDw3KHzwU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqEL+0ACgkQFA3kzBSg
KbYR5w/+KAO/ykH67GIzBP828jFhRWuBelQQWbS/7MWvZs9wfSyqyloeQBUEshU4
OyywpWqiyO+sh+DNq93icno9LXWJxC+YJE7LqY/GmRgYLoFRVf4Mm/HdNK382W5j
ZylnQ2P/4LaXU6Nd8JTebqquCzmrIiPD1qwTF1pXnCQclkc2zOOIN9nBeDORZGrA
vpYryKIwkBdVK9Znu9CXjz8lKzOWFxztulQlI8aQZ5M46TL6FOjR8Z8S4X5Uo6e+
RgljO9ZoEfFgzfkcg+PDAhWBnFCHEJXL7i6bDTOwWEFe4I1NJskfIF071a8V9nc0
IJEZVQ9U/D8N9z0ToNfqAz/1J+VwRqH7g487EA6AaFlklh/UjkiJuSGfml+lFBq4
YLx/yolZbbUcljY+GA5ijP/vfjRvn2/tg03hd80RBvpnmaAdQz0KywTzuDSECFCh
kpctvvtwXXo8KejZnHxeoZpFGiWnYUFklsjLTF0TUYRI+0F8s7q8Y1hSLNMUgu40
tvoHbW9aFBje3O/Z8Ix7sMDx7+cb7nuhx5BmYE0BUEp3eD4dPu/EC2AohdnImXRk
5DNN121YZhssppbsSRBZVk+F0uNEsASCPMOngyiPb9EucUoCtK2H4e9sJ1yBGple
RbM/oZ4iETys/6keHzaK6C21D4Trw7RDndFkv7Gx5iNwSuiiZKQ=
=s/TT
-----END PGP SIGNATURE-----

--PlqVvZZhDw3KHzwU--
