Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D72471256
	for <linux-rtc@vger.kernel.org>; Tue, 15 Sep 2026 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789463866; cv=none; b=q/DERLpuhq4PoRLUntNzlIul+OmDE2Y33tol+dNBImUWMYQTqQKFkHQIBM4Gsj6YtjvLNqoA3HI+YpoA2tHKxI8TUUsTG9pAgU0Eyr9nmlnTB5BZB4tHdebQXdcY+QYaf0n8l0RNldpej0xJ7CVQXx5RZRnIvGncTlcZ00FTsig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789463866; c=relaxed/simple;
	bh=BKzAwh+TY0IDo0Q+rlUz9XdizU1dSo0XeWfh+NijpFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMmZpFn0sMwLelkRKXNFR42solBPYqsxCzsjsAWkTPVIe2xBaGhboBhVSZX9nDdW0aeQC+zbyfWJEP1+yPC/uaSaylV/8pAR8Ru/LgPMptm5s7c3aiF39C8SyoTIsJJrhJZOg7NgKoHhV9JABfU0U6kr6XnwWuS6vRgwi9Nxypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=hAZJTU2u; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="hAZJTU2u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=BKzA
	wh+TY0IDo0Q+rlUz9XdizU1dSo0XeWfh+NijpFA=; b=hAZJTU2uqtdnnbJGUwLs
	/3vYqMzVxY/WV/rnT2JqiabBMVIPici7lBs5tO8GWtBzmkpiuQJ2c4K74AaeaSby
	X0fNH+Jnbw9TbCy+pK0AouxiQ3typjxoj94I0WF+99mv4uDMXWU8QmVjtDXML2ov
	8HNmimwTTzX0CReyvx7IvG9bAv3Tk2WAowxxQWauOfBY24HXQsqHJwFi3horo/AM
	jUrGhWUHx6rAAbs2mzMMhcdvsq8EMF44vYvdNGmTe1BCCAoi7tSeTW8LEj4f39Ql
	TP6fzOqq6nKzyRdOdYOzdUVLr8mJHzGm6MHtzseBzzclUAneEDiMIU5d3zXEDGul
	aQ==
Received: (qmail 1081033 invoked from network); 15 Sep 2026 11:17:38 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Sep 2026 11:17:38 +0200
X-UD-Smtp-Session: l3s3148p1@95qWBYJbgxhUsz8D
Date: Tue, 15 Sep 2026 11:17:37 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH 4/6] rtc: rzn1: make interrupts optional
Message-ID: <aqkNLBOXfN4w85I8@shikoro>
References: <20260914211826.73727-8-wsa+renesas@sang-engineering.com>
 <20260914211826.73727-12-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K3uKiwlyZRgRrv4L"
Content-Disposition: inline
In-Reply-To: <20260914211826.73727-12-wsa+renesas@sang-engineering.com>

--K3uKiwlyZRgRrv4L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 14, 2026 at 11:18:29PM +0200, Wolfram Sang wrote:
> If no interrupts are specified, alarm handling will just be disabled. No
> need to bail out. Instead of juggling with 4 different static rtc_ops
> for all {subu|scmp}_{no_}alarm cases, a single non-static rtc_ops is
> chosen which is adapted during probe().

I kinda expected it. Sashiko complained enough abou the non-const
rtc_ops, so I will switch to multiple const ones...


--K3uKiwlyZRgRrv4L
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqpDSwACgkQFA3kzBSg
KbbzLBAAh1QHIvFao9SwTuWiQPYtehrksX3l+r2TuN9BqbXHRTPnZTFtSo/36mcf
kReQWvlB7Xb0DaerNehAwYdvu8xpEZkuMarHgviTgGN144Clov4ih5sH3aDBASBJ
W7sCYaSdYd0NJPYj+mYFRI9+kNspTjOGY1tzU52mqKrM+aBMrGoXITghJX3/Ovot
I4sPCF2vrJiQUPu8UctK2q30lf3JRMKuG25RDSd8tL87EGbOnv9jNz/8nXgwEiV9
K0Db+30xtlbziW070eAtBTT1gA/K907sdb90kdx6Q9wObKeGQUgrlIYRHJt4D+bA
PpnxIGkSzo4/D65dfOHG4O/mU1arKCE8lOBjR8hgd4ffetvPCkOWXMciPnbwFcmf
xMINex8GINkUBKJ85I9kQX/NtbR9SOwwCZ8bdGUd+CAxTXxzxlZWeJwSkNH6VA1X
iCuJi7H+KdfcBZd+nU45qMkirgxb8du+DbF8WMfd4Y3qyRc12lbcsXF4FGT6Iuuf
MehJHZyWYRyTH4uuVbxGo/NP8I/ztBSKOsidJjmKhok1x9hYqdY+f/a7ygbXLRfo
qSPKvIjrIgmz4mw5ljTXaTUUdKKxUP92oih0q23ZnTIiFJdBzXJU2jZASl0fJ0YW
g2FBCErIfEhLz/z0cFoQ3lhN/MdIIgo3XmBSZTAWk1lZAulQaKw=
=gKKq
-----END PGP SIGNATURE-----

--K3uKiwlyZRgRrv4L--
