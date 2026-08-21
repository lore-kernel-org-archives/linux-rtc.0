Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE36352C51
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325501; cv=none; b=eQX8ZTQghXbR3cPx7fnGVGimZxuWp07hT+Av0OHyx8DmIpxvUBguN4Xpn/VnkDDV7YTbyE7In8DMftHWILPZQKXoyzTF2iAJjTLcLBDt6hxVCPELWpZrG009nRa6atDLksNRHa0wpNFrK621IEEjOKa/mPTvIwhOzMIoxTrulB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325501; c=relaxed/simple;
	bh=PyHUwuI1J5U16nUeihE0ZuD6kMweb8iUrVMA7E3ibzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMtyTH+Z52bCfeLTuTn8l5owdk0bOpI8qKWyZtEvGhAUZARMzguwMzyCOI7BBsg1J9O0dmrTh1U/LzKpY8JwyL4nqo9i0jMKx1AhXEjXLjouMAeKLBOFClHAl4FiS7YROGeMSJ2C8F2o8eOCGEoq1q8/ykYe9ZPTMmglv1GUSuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=IQurNpqQ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="IQurNpqQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=O2KI
	DdI5ojyb4S6bjg6yRvAwdQv75EVMGYNr4Cy5wKM=; b=IQurNpqQWtBVXHbxwsPh
	ip9KSDwpfRh33qPfqm3Ib2VKK9ma48Zb2yEpTZdR5wuq06Rt0zzpYXW8To0zp1Ca
	cRMylyfxPUXfxm61v502H0QOA3VpIyz8EbESxNOMKLFnMHnWNTl8Ef7XQjfLRduY
	zOrRtYOEOwYps2h2xz/6lu4SOWeSeYpHWLBg+UYBLuuMrp+WFYT+f57j+bgeR+0g
	7c7yaDKHcGmjGXFbmar3+mFoTgfGXgh95huiF7/7TvET9QDNwBnK5JZLEXO94/rm
	cle/PuL9ah+9uYpMvg5dos6KIOaEu0xetJKWLebJiy9ZwR4V1R11Xe3ivBNSMuRV
	pw==
Received: (qmail 691445 invoked from network); 21 Aug 2026 17:18:17 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Aug 2026 17:18:17 +0200
X-UD-Smtp-Session: l3s3148p1@Q85eJZBZIJAujnuu
Date: Fri, 21 Aug 2026 17:18:17 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: sashiko-reviews@lists.linux.dev
Cc: Prabhakar <prabhakar.csengg@gmail.com>, robh@kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v5 16/17] rtc: rzn1: Drop trailing comma from OF match
 table sentinel
Message-ID: <aohsOSu0-bfMuxoi@ninjato>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821140719.EBEDC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QkmHTXJ/DdWaeA46"
Content-Disposition: inline
In-Reply-To: <20260821140719.EBEDC1F000E9@smtp.kernel.org>


--QkmHTXJ/DdWaeA46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > -	{},
> > +	{}
>=20
> [Severity: Low]
> This isn't a bug, but the commit message claims to mark it explicitly as =
the
> sentinel. Should there be a /* sentinel */ comment added here to match the
> description in the commit message?

True that. In v4 you already had this.


--QkmHTXJ/DdWaeA46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqIbDkACgkQFA3kzBSg
KbYQZhAAiM7CfHXgcu6J6bq8fDm0RTNxxb+9dkpsGJV0ZZ1bTGsSnLkqLzMaykS/
DCFZwxTQy+hG4RsPW4nCnkNXw5OnK7HBFu/yqoNYxZT+2Orq8OLt+jz9WTIqclx1
cK0Vb6Jo52e/XwKeW31hRsP5ylmQjQuclJxi6mP+/cBsHDG3oRfu+nCoErCj4pWz
9C0e01vCPjJdhB6p1P/1hG9sUuIoY1aT4zMtBVnmjmam1uFciyDGnANeQkboQ7NY
w7VxQC0nkhbfSzczzXPrWuPsdetnupA6N/kPEMnf79auhDB+r/hMzQoIiRMzJuu7
spUYFjJLlhTC4+qZQQ/bW+w+qeRBLMFYNTLXnbKq6udSNxX92v8VdkSgF7a8u4u0
Yw4t3jtTiNqtbxJPQ9qe22c4i0EpEwMw4tUbuDahlByMTyDOCSamdPPBDyDrKVFc
+T0NEeovWFdqzsRb5CYVtnORMUF4VYfDUoFdXewOfT2/4+uHvwPJzurU5eHdciob
fYvTMcAeBArtUMkNNvJ9L3R4vTDCyYl9JuBf/Am2n7JYbgRqF80dj/8uDLmIW88r
cIwDlXcdhY6iMUexMnFvWYSDUez4bmtOpHYdHnPYkCT61EihRMj+/M1l5eEU0pN/
a5g4smSQsmDxC8N/3DIBFoLHe9I5LtKwYt897zfGfpDsUtZG4Go=
=sciU
-----END PGP SIGNATURE-----

--QkmHTXJ/DdWaeA46--
