Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB1237E301
	for <linux-rtc@vger.kernel.org>; Sat, 22 Aug 2026 19:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787426564; cv=none; b=R3WdZtbs2wvvSPUevMzwCeZujdMCZolLawrFKGgmBo8/ZULvL+zxfUPIfJ9fUUYCEhIIfB21Qn0TcCpsojNTTvUMdVqxZE3S5AfgPKwkr2VC0dv1PjAEzzcdUSVOZes1ZLyPzV94oLl8ew6ujv/hBt7Oe3kU4uqWV+H4QA/aI0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787426564; c=relaxed/simple;
	bh=x6oI0crdivDNn8DnEcADG1LuSOfPDJuvoSs8Td8hvOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I57/CwXVkvLo+RHIs/+DZkF9vyIvpZgwUAJonVDk/wg/eEOiUA2jvJIYL/76okdq6lWwzZhYPPV665T8ArMiLj3pEzv19bXF4YKDA8mGM7V7+qQFcNe+RvTQ7W2buVd+PuJ7xnm740WJ/mePayTQE09uhCrjfZU49cFIr0SQHhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=FskGE4cu; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="FskGE4cu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=x6oI
	0crdivDNn8DnEcADG1LuSOfPDJuvoSs8Td8hvOM=; b=FskGE4cu47DZhMs3K2jJ
	DfddjqqyBzpnfrG/Ftk9no3DA5ERJmbvnzDPr8nKyQo/UgDUzEHNvg2WG2DY69D0
	nFbEIhF13Z/hkrFSPLIo3Gxp2mjB+lY77xzKZ0E04gjvKQBoZM6s6zyt+FNMdS9m
	Z4qlAklidvNbX+cTBxmmPlbo+DK7w+iqbKu0OQAOdqYMzq9QOw1+3FpBmLxCYFXe
	nKLMxS0ON3oBldF2oYOdKUV/XdHAJhkv1ad8IvFd4oZd632jFJA22swyfHli3l0Z
	RRNwYSqdBd1ykAMZ0bRHxADbIAaCRTfn8ZiAQS2voOaFbHBN+/MbNKqQvU1Ks+yu
	PQ==
Received: (qmail 1015423 invoked from network); 22 Aug 2026 21:22:24 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Aug 2026 21:22:24 +0200
X-UD-Smtp-Session: l3s3148p1@+Z45rKdZvt4ujnv+
Date: Sat, 22 Aug 2026 21:22:23 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: sashiko-reviews@lists.linux.dev
Cc: Prabhakar <prabhakar.csengg@gmail.com>, linux-rtc@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, robh@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 06/17] rtc: rzn1: Disable alarm interrupt before
 reprogramming alarm registers
Message-ID: <aon271wPK9H8gAvR@ninjato>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821211032.13554-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821212612.10E0C1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T+HODbuYjh5+iWP4"
Content-Disposition: inline
In-Reply-To: <20260821212612.10E0C1F00A3E@smtp.kernel.org>


--T+HODbuYjh5+iWP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 09:26:11PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
>=20
> Pre-existing issues:
> - [High] Data race and TOCTOU in IRQ handler leading to spurious interrup=
ts and incomplete synchronization
> - [High] Hardware state lockup on timeout in rzn1_rtc_set_time()
> - [High] Alarm logic erroneously uses 1-second interrupt for past alarms =
with the same minute
> - [Medium] Race window in rzn1_rtc_read_time() fallback logic can produce=
 inconsistent timestamps

All pre-existing issues, should be handled incrementally.


--T+HODbuYjh5+iWP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqJ9uwACgkQFA3kzBSg
KbYhVw//XlKbkez+l3VpHjspOjHLYiThzVPLaQfz9QAfA9pELhV28RX4kX/HwXm7
3H66yxD9zqmkYlC56UMHLtIxQWIY1h3Fo0m+KOKawR60VbqJkoGtY28r4qvFUttm
DOdIAHdaZWGNuMowccKItbz+9gepROsKqwl8mqAGk5Wt/g6sN0dLgJm/xQZgbHmP
xNWdqBJ1nzC/Ax268hkPvjn00rwgX+KIPgc43mcbzlN78hAU5/t1IMQCWCh0V0mS
OP5dGZg8cIsBTJbH1WKMr9cTRIpM2Ax1in/gT5FyFIxfNRMXOEBXm1RKs5v25MNj
fooQE6bCfO+kanxgf7z3UWIRYdyLhOZIjl1WpRprRKFHHoSY+rfvix+SFmmFerLk
U22qmxP+yYfVlhe3D7txrYUTzX1m3eS7nfKnIOtWPVjND/cvTo0W02sKvSOSXaGW
9WzdKr6NoQD2GKipB8uEm3scKkx/NOXbAbJ9GHdvdmHebgHXgVEoKtvAx0Hzovch
hTdHCF5+MeczpChCB9B/Gnrca/xtwwe4rgJE2OuLQVMEh6ByW7OjI+ZxfjPVn1ML
AGXb70dPPJNESURoYMGgxV5xdxmZDXVMbA0g++mg0PzcHHeOqWyHkn5x5FV+BRV1
U8h+PQMHrVVx1Lm1GD54ZvtqmQih4OQz+mpUdfNTYd5PKK1i5bk=
=NvrB
-----END PGP SIGNATURE-----

--T+HODbuYjh5+iWP4--
