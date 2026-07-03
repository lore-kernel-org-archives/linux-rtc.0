Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8181304976;
	Fri,  3 Jul 2026 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783095657; cv=none; b=LbImny1sq6jk8RpykjwCIXguhB30hg8pum+nFTno6GV4F02dSmoJLm6gHcz8rVSy/hrFSB+9SRIxq++/K9KN0/y8oHloCl6Xs6q3MkfUZEVhH4I3XdNra0lgR6BPCvasj590GPXPnUuZjutIFVxXCpXvqEin/dOTpIJU3Hzs9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783095657; c=relaxed/simple;
	bh=OM5LeX7Z3zehI7Br7kaR6AJOzvkDGU+AsyY3eqD986Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rp9tJbhDWNHnn1mwdl8QTdJG9lfhmmOArEeGWUTxZfYGkDFEDZCslICTdWUoRMcZKhdSBWAbuhReR4sjCZGPUhiCrKi8Vx0HrbiokWALRRoT8HRaXfphJGk6CAvy2SIIGTOxnzECRBDWg5jaWu7tpSQ8pArn2wWf5A/JbFocXok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ob47GSok; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ob47GSok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0271F000E9;
	Fri,  3 Jul 2026 16:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783095655;
	bh=OM5LeX7Z3zehI7Br7kaR6AJOzvkDGU+AsyY3eqD986Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ob47GSokjsPQlNeF1DRo+w36Qqk3j9a2jBm2ZRPypV82dDcgEhaMtpO8cg1FfNnEk
	 So4PGlSpvzqisjpgfs3gCKJ3Lf+Qq/pk/iPRWtk6uGoM8Nmi5lp4yvTgXxYwC7n8d2
	 eN1pkTjnnb+767W300paAMsO5lA91HdlzkEUw0C4wrQ5yy+OuEtgOtn/D9dFkWjyMW
	 PDYuVtgy2xN4HU7XRkh8tj2q4rFjBn/guryMnTHZ7rCW4wZT/Z0BGyfS2ZQq7Rf2OS
	 BunNP/qYhgPuCDlWWzPjUHhKbugT0jBAVgStCALqGoFUKc4qld1OyGLc2UO9l/mvQ2
	 c4ysojZEQUTLQ==
Date: Fri, 3 Jul 2026 17:20:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Udaya Kiran Challa <challauday369@gmail.com>
Cc: alexandre.belloni@bootlin.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, skhan@linuxfoundation.org,
	me@brighamcampbell.com, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: microchip,pic32mzda-rtc: Convert to DT
 schema
Message-ID: <20260703-identify-cringe-ef88079923cd@spud>
References: <20260703110442.205026-1-challauday369@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OaoQxJwKPRf9lloS"
Content-Disposition: inline
In-Reply-To: <20260703110442.205026-1-challauday369@gmail.com>

--OaoQxJwKPRf9lloS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--OaoQxJwKPRf9lloS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakfhYwAKCRB4tDGHoIJi
0jHsAQDdBhJEQFSxOsFL/90Eml086rure97kHVAlfSAso8DvAAD/VYDXUUP+IoQ3
WCNQ+7brY8b5e9u3ctKoD/7ml02CngA=
=Wmta
-----END PGP SIGNATURE-----

--OaoQxJwKPRf9lloS--
