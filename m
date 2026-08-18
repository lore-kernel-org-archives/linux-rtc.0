Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C90746C84D
	for <linux-rtc@vger.kernel.org>; Tue, 18 Aug 2026 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049140; cv=none; b=kR/LW2JFD420kHRqIVtEAwRMx3YRxmGT8Tt/Dq7xluddhxa3QQ7HXcgZbAVMO8pW71pGtSDYYWtIsuRvwKspHblZh80r2M+U0njF4rp0j/OyJauXcXtLmIlZW2Vu+RYggopDhAz016BM2Ud3sYwnd3ADDTbNCfEAVSrRUpgJEB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049140; c=relaxed/simple;
	bh=iCMwaiKjJ/HQ5DMSxuJBQtPPEs4GiOmijbIq44KHZSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sw90gWS9Gu2rjUvalZCMyIZZAn9lL13lf2Z1QFPAN/uh2oSJfLU3Veo6VjtKRAWN43HI5N5iZ8WCPNERDWRHFNY0Nq9NXc+bwZJAFFQ6G5BkvhnOjQHkqVPjREg242feeoMqdqxg4jn+00pCSUJTrMfqv+Qbx38xywKCsbViVSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=l1xnfDMh; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="l1xnfDMh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=iCMw
	aiKjJ/HQ5DMSxuJBQtPPEs4GiOmijbIq44KHZSc=; b=l1xnfDMhAE67Mh/bRnGm
	d5QOpnoZfh2czD6Qdi8DW738urA/2afllIbSDF72KlDw+7VFG686Ld14icnDOrYs
	ZPt/hRJzzsM/AwNmxHH+lDQ4Ju3c+49Ew+9FQlzDABXfD5glKGq8g3CXmNwMTliR
	j/FB0ymQxGL8SZa+Qh0Co1D4susuPzJcWGFixR09p/aGexrw/hqXeRbvOsc1y0ec
	S5opKUtyRNG40g7ulq+5LBTh6o2GRuKfTfnvt4vL8jK5mLK6Vi9D4UfgqagBXeV+
	NNoicRR3uZb1n60DcFgReI9yi040OFbJaKTP2sAju4fQf11aWez9nkk2KdyxQMVQ
	eg==
Received: (qmail 3759104 invoked from network); 18 Aug 2026 12:32:14 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Aug 2026 12:32:14 +0200
X-UD-Smtp-Session: l3s3148p1@GR7dzE9ZZMkujnuP
Date: Tue, 18 Aug 2026 12:32:14 +0200
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
Subject: Re: [PATCH v3 06/12] rtc: rzn1: Fix alarm range check truncation on
 32-bit systems
Message-ID: <aoQ0roC0n_mr3YjP@ninjato>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qBc2Tx3XgOpNPN5E"
Content-Disposition: inline
In-Reply-To: <20260706175138.12587-7-prabhakar.mahadev-lad.rj@bp.renesas.com>


--qBc2Tx3XgOpNPN5E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 06:51:32PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> alarm and farest were declared as unsigned long, but
> rtc_tm_to_time64() returns time64_t (s64). On 32-bit systems where
> unsigned long is 32 bits, the assignment silently truncates the upper
> 32 bits of the timestamp.
>=20
> Fix by declaring alarm and farest as time64_t and replacing
> time_after() with a direct signed comparison, which is correct for
> time64_t values that will never realistically overflow.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--qBc2Tx3XgOpNPN5E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqENK4ACgkQFA3kzBSg
Kba16Q//UTO3o0EGiNEeLNBEgajaGR2ujmGMYbCx/dxLIejrn/mvjOwwcOP0BqkF
GzmF/R09RPuZzkmA8L4frDUWEe0oh+6EU+bcsJxB3QUXN4dHJoyc6c/Aq6fPA1y+
kCI2OKtuyAd/Kj+VT4M4utZIjayVWbGiEONBSuNBixV/StK/c2w+HBYz4r3bFBgp
XCAa7wL7JRESzE053svNbVz10j/e81PafUtzVimUF8C9/1gEpr0m95XAOEFsmVqB
b4Do3v/igUG9sU/t2ejudo0Z6OaPLfJHccOHeYOSMbZCFOpg86xgZNQIpGmDkXGR
EpFMjd7DZxboxoNVjcrGuA5Gy4jOAwtWcFfNYG6mhsfDJb5VJB/jQrLeL9bMlrue
9zSSgPR2wlpF+Ugkbfie2wD9Mr+WsV2Pugmb5uB0IFxjAye/c2qKPGARRPcA4CLw
aSc8J6hJTI1sCY1NLkcU+jFd4dk3eR//s7L6GM24q0r+yWn1TgyIOU8yaA88gyYl
8oB1j0lWJPQlUbUI+BStMNd30ZTyueALkLsHdLLLYhvpsJqX5nN6GOO8IpgHSDRJ
VkRX5B0zqVf/YfzRP4U4GglhnTLvS9i8mhjQ43Sk7hP/QKrUgNQA5pOw9hau0rjM
yids4VguztXl544I9qwN1oONUiEwC9WrW8algl65QkxxisyxYcg=
=bK/Z
-----END PGP SIGNATURE-----

--qBc2Tx3XgOpNPN5E--
