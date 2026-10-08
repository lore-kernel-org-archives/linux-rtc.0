Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F0F392C32
	for <linux-rtc@vger.kernel.org>; Thu,  8 Oct 2026 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488904; cv=none; b=NGI71z75dpKZgVq0DEB3JeOvQTG4rA6qlEZGFSYgO6kOK2OElCfUX+GF8qEQvvbveOaQTrb0lkthhnKkadPU2Bbz9k/56G+yLn45eZbBlZo+zRErnG5gl3ho5MVTVaQ4RXmL4Fvfs4u0UrhQ8NNh7uTq9ZIrdWGNTFqXfPocAL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488904; c=relaxed/simple;
	bh=7J4bPm660j/7MfPVn1JNe1bO7wZnVvxHbsBjuPL9TUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5AbOP1xwMVXx/22on+kNTaR6YVr5lPBXCaK/bm8KlKo/G+oT1Gj4/JmdCh4Wk8G8gI7OlLsKnlNKQFRV19NAL3Lpwx7qMSXgVCLW+7oq3AHOUGayqrXVTL32qD92H4u84F8p/Gy65bATBsdD0V5Qmu83xUOYjltJsVu650OcdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=OtMjtbMP; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="OtMjtbMP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=7J4b
	Pm660j/7MfPVn1JNe1bO7wZnVvxHbsBjuPL9TUY=; b=OtMjtbMPIVJ1bQVsoNgR
	hjEPquo5rGcpZhHXtGE/KLzcuWpISJg4YBqqjqSVOQ3JcPmpkwLuw7RIbz56Et3E
	vHVnhcJRIiNuCXCbyIdC7yP5dl2djJq0hqQ5oJ0tWNvv8pzGJkxeCSAUCDfHTJO6
	/tpExboMeC/sg+1IEp8Qa8zDat6XKMs3sGH1VSqIw3x5QmowmC3OmBLXk31B/50c
	I7e3zT/nSINKT3CzD1ZUuuE1eaXKO7VQIGnw3fI4tVkC6mvje/ObuvzW6KSkEl1z
	btTODd3eNj6WFevb/ZwSl7InajZdGBvvXUXeEI63v0KHBovPLSqdDGju8eicKNfh
	rg==
Received: (qmail 877567 invoked from network); 8 Oct 2026 21:48:17 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Oct 2026 21:48:17 +0200
X-UD-Smtp-Session: l3s3148p1@6tZRg1ldRsbDesiu
Date: Thu, 8 Oct 2026 21:48:16 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-rtc@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 0/3] selftest: rtc: rtctest: improve handling of skipped
 tests
Message-ID: <asfzfFuBFVKP5WQA@shikoro>
References: <20260916213108.9234-5-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k3OG2Znm/XiSq3wJ"
Content-Disposition: inline
In-Reply-To: <20260916213108.9234-5-wsa+renesas@sang-engineering.com>

--k3OG2Znm/XiSq3wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 16, 2026 at 11:31:08PM +0200, Wolfram Sang wrote:
> Here are some fixes for issues I found in 'rtctest' while checking RTC
> drivers. Details are in the patch descriptions. Patches 1+2 have been
> tested on HW. Patch 3 has not been tested, just follows the pattern of
> patch 2, but may need more discussion in general. Please read there.
> Looking forward to comments!

I guess at least patches 1+2 are good to go? Who would pick them,
Alexandre or Shuah?


--k3OG2Znm/XiSq3wJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmrH83wACgkQFA3kzBSg
KbaOixAAk9tHAVJH7d/OoHdHeexUGYZCLqnplyzHosqOOHV946FqeeT2cLJT6n+4
vJjv6Fsgucl7Hd3su6WEUwQ+rqrcpYgTgooEjQtYQraperXYX1IEeQDlgBdqdDO0
eCrSW8On5+FC2sA77rIIO+oT4dCa6mBnimie3krqWfzsft94jALtxQQBKqu+2M47
35hDS7V4bsT/U6iRr61xXZsV/zdsxRen9iptjnNcU3jkPIAV+TLFj32lpNyWEJ2i
t3T7ISbpWNGmpziq/vsbO/kJWuqZE6o5IG/4RSJYDt9fFkplKbGTfaoHynIWIpq4
iulwRruLnpQnFrYP0XTKdTsQC7RzqkCgdGLO0YsFCGtcjEti0AJunD8fhQcf3C6b
nLaPZCYoX+NnZV/Y9pgnpYGX3Q2ZDBLd+kuSCyC9vgzJLf5azt9ln+4Wi81bzhjd
ZvaXvmifXythkmrFxTfr6hIyW/EPOWBPzFa1yshal+dAhyZZpi66tAIdEN7P4dvD
WWFT9k/M51mSgDN1paOpgpY4xmlG2MriGBdg2wRhk8iWDXbdtbqTU7aRex+voP5P
V2sbnVoGslz0cvcQf60E83v71yiQwCHqTFYp8CknIN1ZAFpmXR6rYroDyI1Jro9M
5OjRWSkSKdA1hdXN2dqRVmQt0IBWxOHao2LjVGYd2ePGofWeHWE=
=vAWR
-----END PGP SIGNATURE-----

--k3OG2Znm/XiSq3wJ--
