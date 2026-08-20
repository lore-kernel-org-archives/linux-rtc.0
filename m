Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C036439F165
	for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254609; cv=none; b=ajm8uRtjrirX0SH1cx+MPLXX8bUxg6NINyjWgb6umESYDkTp7XUPFsnGCt0VmjtL/S0h0/74nvOnOwdRfquEGFNRtiu6QBR4pPr2v/d7FPmpRc9w/HZJpjSms3DNSYjr59PRtKTx1BlUQVXe67TRLkvIuIM0kkDtVsMF0n/53v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254609; c=relaxed/simple;
	bh=6N2x0Q1+5XAWq5wnqUjktYBQJXCrVZoL6Q7yQ1TquoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfkeV0fXdC/k/G7qWRLfa6CsMPHZaYdLF1sqBHLa4/N+onoiIahCk6JD4zwUk8Tx+ZRTVw4rwKNUmU696gb8XnOowfTKrTvGPInt/rqxd4fpPVnXjMVoJ71Eg+3fpN3rJq/op8WfcEMAge26nNs46vJBP0uKFLhPqtnT28+Md0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Axf1a/rt; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Axf1a/rt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=kj7z
	gCMLzuYDnyTniwPNl/ulglW+LZ9gcz29UXTWoBw=; b=Axf1a/rtUVH+7rbXdeoM
	QftU1RiMXbrDgmQ4d0wgbNArALQ8hYo5Wiem+bemi8gm6clk+Sk2obP6gm7m7dHA
	ndRgULqf22iJGcI3MbD8Lfb/W8lgB1PstzcDdc3tRpausXwLyvVPu3StXHquakJQ
	g3i5v9zQ67ktozh4LKmP4IRjZyjqALpKOuG38TxUSV3vuTPC7dk90lhzm789vs5k
	HUJNjkkKdqSSSAU1zsIztYGf+W1Hyz/NhcPEd00LCcXEl/WsTc+7qrpVuq/Xjd0B
	XGy3Z33pCy2uNRgPdjRwr12P4JbDNQj6A5aAy87+mDm0qQe/8JeTMPKoS870r1gl
	HA==
Received: (qmail 408406 invoked from network); 20 Aug 2026 21:36:42 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Aug 2026 21:36:42 +0200
X-UD-Smtp-Session: l3s3148p1@IgSzo39ZRtoujnuE
Date: Thu, 20 Aug 2026 21:36:42 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, devicetree@vger.kernel.org,
	linux-rtc@vger.kernel.org, robh@kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	conor+dt@kernel.org
Subject: Re: [PATCH v4 06/15] rtc: rzn1: Fix alarm range check truncation on
 32-bit systems
Message-ID: <aodXSpr11Gfe6GT2@shikoro>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819105028.70F3A1F00A3A@smtp.kernel.org>
 <aoWqIxFRItjNu6uN@shikoro>
 <CA+V-a8vuA5EnPP8iCsCi2e3HY-qO6iNs=1bP-NnfQMDrrQK0vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Iad6rbpH0rI0CbT5"
Content-Disposition: inline
In-Reply-To: <CA+V-a8vuA5EnPP8iCsCi2e3HY-qO6iNs=1bP-NnfQMDrrQK0vQ@mail.gmail.com>


--Iad6rbpH0rI0CbT5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +       /* Disable alarm interrupts before reprogramming the alarm. */
> +       ret = rzn1_rtc_alarm_irq_enable(dev, 0);
> +       if (ret)
> +               return ret;

Not sure if the comment is really needed, but rest looks good.


--Iad6rbpH0rI0CbT5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqHV0YACgkQFA3kzBSg
Kbbjzg/9EPqWpUfSfzFCHpKGfyxoW3FnNUB/nScTQFIorz/EPH8BNKLysv/tS8Bn
f+SO/IRKPKZUrFoRjKEpC83eAIF72PBZcfXVORE+fRPLOqs6dwC233Do+e+H+vM0
Yfbhf+RrUgGGwsiKPxNs5EEpfdKXvGdMXM/o0C+lvmGCHnc4g0oB6eqyA3prwMdZ
sEg/BsNknLepizg/rSK75t4TBvMJ/Xs1FCenoN/V39LFediGwYtVfVlD3v5b7M0s
9mm7fgnfCNafwlZpq1iRjd/hDfthy2Lj/OTGpLvFSJ4Jz3QHjkn4H/e2iJk2Z49/
elvJHIIvz0H4nmA2mjGf3/QV0Q8r+PDHfA5zsf+F/ei/5vNfu59WGUTvEvJovwtF
DUZH7MP6FoAfPH4ZgX0w7MrINEdIXpwG4U3/oKwZJXwcOKiexY8K+Fj1q2cINJVg
AH5PxZYSU4ARWqexE0/eytj7EsT9y0lU4hJE+3KD2hxNJNtNyjS4xkAI2TqTQ/kq
O5OJlZof+LDL+CqpOwj5MXFjTsIiwlznElTu++KcU1D/+ibXoTqjKnO5KVK3xZhi
HZenqwcwGOMEWPkLR4WsNKHhA+z3Avhlg033TsYxCLoAA223AV4FZGDyz8fkZ7sX
Y/V/P8asRzAwcER2dnJcPkuIBq7ZTyCuhWAoYdYF7y6iHwcbsG4=
=L4X0
-----END PGP SIGNATURE-----

--Iad6rbpH0rI0CbT5--
