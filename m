Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6F442B72C
	for <linux-rtc@vger.kernel.org>; Wed,  1 Jul 2026 11:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903663; cv=none; b=Q7JEpWCrbTbDxHIJ0TPWFEqrVxm+L+CPTU5XFIi5LTU2cfz6c5w7z6It9NMwkWg84FMSE6QA8snJgNmv4porRGbJcDs/JWKUMCtU9SAy3HXuFqzKZl0YXNlmD9TIfnGAakRq9Sozg5B2KS7sMTlNlsbX1cf2I1Oj1FJhqOi4Qrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903663; c=relaxed/simple;
	bh=UZy0n/01gszj1LovSYaViZ/RBxd5MKpgSyrcZMJ/Kgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SL/SMK7vI7RDhUp3iL1CiWbN8q0Rr0xBSMKIvFAe6pEWyEGzhyAAcMZODL/lG3iuL9eVUQ8WqouDTEpNxZv7NoiA7MiHmamKQtBQ/AatbMsALbuqT9/KDuRunzxjhu4Dwi9J9TQuSO3GhQ4hbiQUWwxVva/PZKMqpxJr19/3UZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=UWxG8p5s; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="UWxG8p5s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=jHv5
	jf6o0MBfPU0bNEf/sSgaluNexXsyMjiq7q5MTFs=; b=UWxG8p5sAeTl4gF/M64G
	GI/za0sy9zeCbmwNh8AGmiiYTuaMbAn1fKCef1xHAabmKteJiX9yUYV4lSfsAZZT
	kjk8Xev6AaIwtD/uOwsA0v1bHWqSp/WFc4ARm+weO0RPZcLkQGDtP/OJLfybaI6d
	p2UcErIPx4XWSDy8D8xf4OPATL4I0ohgmnLiQHaQ5Et0AXfY0d7/yQjZMYnny3Tb
	pPJp0xzz6iqecpUFYnp4UImVfb6YISDPmZs7iEKFkc4pLPUX0bWm3vocEV1S8P4Z
	Bcx9S1LpqlSElb1/8JCFiQWgCErlgF14qK7AYz2Pt9hWPB+Bw/oY5IQz61I/UvtE
	Nw==
Received: (qmail 667004 invoked from network); 1 Jul 2026 13:00:51 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Jul 2026 13:00:51 +0200
X-UD-Smtp-Session: l3s3148p1@FbLPmopV6FZUhsc0
Date: Wed, 1 Jul 2026 13:00:51 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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
Subject: Re: [PATCH 07/12] rtc: rzn1: fix alarm range check truncation on
 32-bit systems
Message-ID: <akTzY0hQqwAprV4g@shikoro>
References: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260615154805.1619693-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ajJ9kNJtrY6DyQ-S@shikoro>
 <CA+V-a8u2wt6623mYjhipOvJPo4va+bXs3qirQewocFr2QmUFhA@mail.gmail.com>
 <ajr1wXCI2U23d1sY@shikoro>
 <CA+V-a8tfb5YFsh-K5F8OOBsuJi0PG72vQ=2PQb2avVNF8-kcrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6yLW7/UnYGTOQ+QC"
Content-Disposition: inline
In-Reply-To: <CA+V-a8tfb5YFsh-K5F8OOBsuJi0PG72vQ=2PQb2avVNF8-kcrQ@mail.gmail.com>


--6yLW7/UnYGTOQ+QC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

So, when I improved this driver back then, 'rtctest' from within the
kernel was my reference. This test still passes with the current kernel.
However, setting an alarm one day in the future does not work for me. It
just stays the old alarm. Without your patch series, that is. So, I
think this issue should not affect your series. Especially if you can
set an alarm more than one day in the future (and less than a week, of
course, because of the HW limit). Can you? I recall I had issues with
RTC programs compiled against uclibc. Despite I am sure I used a
glibc-compiled version of the rtc-tools, I need to investigate this. But
not now, but somewhen. I have to take care of other issues first. Let's
assume for now that I am the problem.

> I ran some tests for cases #1 and #2, and we see an out-of-range
> error. By adding a 1-sec leeway when checking the ranges I don't get
> the out-of-range error. Let me know what you think (I'll create a
> seprate patch for it).

=46rom a glimpse, I think -ERANGE is correct. Increasing the already
calculated 'farest' doesn't sound like a good idea to me TBH, unless I
am missing something.

Happy hacking,

   Wolfram


--6yLW7/UnYGTOQ+QC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpE814ACgkQFA3kzBSg
KbZuQw/9F8vOkvGVvom2XSpAo4p7tOaRGeP4N4aAoV6daZ1amS+Nqy9Bo2Ydd4yz
Jj1JWxrCXRy8aagau7ITRF0jAQ7Eh+bSo5ZFdK8Iq+6mFozyhAAPUBqqBPHQQMGl
t021ZcvrBDevjpwuXkoWz0ka18MrleDAiRuN0YPLXtUzq4+oGIrlwCtPgzZpERv4
rIIv5A1h92HtQVee59fumaPO25w9Wgy7vG3zZkiyhxRSr6DMUUj0c0bDgOlnt4xE
xIW5qHoLWrN3Lg8DtAfflkMrWPJXNksot+583+33UwyA5fVjkfKhigBCGNapZESu
cPKQ1BIGnBktKQieQG59XFuDzxTslJhSQ/APxCMbQ+Nj+gl5c8xQZosnmTv+KjuX
s/vEUtw208jrg+NO5rf2hd8tilRX6OYKRThTC9ml3B6E9x66REu6WcyDGw4WOGOY
42UB6a0l1+rM6BNz22OclrHiCbrHZavF+9XeeDrIl72wHwsirJNfnkSrNqOrI/KV
Bja1xsHAnW484NlR+FE1+yxWYaZkWYcRqVvx4QO6CReCvlzkn6WdNtMvtTQGBCfs
xkkdKLPZAJafMbiLsDHdPxV+lZkx1zW/wmZ84LjLB3/BYPN1CqWjy4jH8hVIFCwN
S/5F2yikYzWobxgDDYvH19H/XWHq8SfUJ4zqS+GwcqufreyL17M=
=Nc8W
-----END PGP SIGNATURE-----

--6yLW7/UnYGTOQ+QC--
