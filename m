Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA134378830
	for <linux-rtc@vger.kernel.org>; Wed, 17 Jun 2026 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693932; cv=none; b=YpRJuKUsBfJDzI2c8Y6t1KYdqMvTxEVsIurVUtcjC9i9hLMdrEvWzV1RtfdZWqqB9o6IYs+/Ll+wtn6THVjZtPQmHMhULyJxqzMadFLpuMSBQ6CJgo+I8obMDHmy8jwe7k5W0hvtjrjOduaybeTDYRe49Xcm9lxxcoyjsTNOeqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693932; c=relaxed/simple;
	bh=cLjo9s5X8S7uXGdMEwPgj8pN7cxLDACJURIhOC46EHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nh0xsy64CJATPR847Odvj3pjHweijqi7pCOtog6UW17RumtF0k5qEqIVIekcQ5R++cW4TN0YKKN59GNJAnA+I/PNMloFUtW/PExZWXaHsThmrX5WEnw/ovHMVPwf4kAOdFxbch20vRKgDs8+CGPju9Jcemuy6auOxGAeqsd/LKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=VHJLQGJb; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="VHJLQGJb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=3WSg
	4noCdqmqODRlIZWDlHRZMDx26KJ/5lYpnLFLNic=; b=VHJLQGJbVrgl6GHo3/oo
	+NJONtDg8iCUkuTOpsJyJY7HW4L2WynxgAUx/NxZlSoD/crRa5iuNt7TFHdx2/pJ
	MdTqB8Gf7SVRsJNBBWRzAZCo3rRUrbAIY4p2z03/TwrSAEmx4taKfiiGwvjL0XLi
	OmNWfG/FGsni1recELHLBa+fXz4xIQ4iWECTQuyHdsHZJjhRKZiFC1z8P3nUNKg6
	9syL0tVlboKHx/1auFjfStwM26vztwh3ua+Tnsrq2UrolcbDky+Wzfhx2kZpt4p2
	EHsbMTDDCYii0RzujCd2sxOhSyFZCo5PPAG6CZ6cjvRxDnprrAyKOmvCUn251A/y
	cw==
Received: (qmail 132594 invoked from network); 17 Jun 2026 12:58:44 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jun 2026 12:58:44 +0200
X-UD-Smtp-Session: l3s3148p1@2Hx08XBUiu0ujnvI
Date: Wed, 17 Jun 2026 12:58:44 +0200
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
Subject: Re: [PATCH 08/12] rtc: rzn1: Dynamically calculate synchronization
 delay based on clock rate
Message-ID: <ajJ95P-jxChrTY9w@shikoro>
References: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260615154805.1619693-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I+lGIvlppK+LgZCG"
Content-Disposition: inline
In-Reply-To: <20260615154805.1619693-9-prabhakar.mahadev-lad.rj@bp.renesas.com>


--I+lGIvlppK+LgZCG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


As mentioned in another thread:

>  drivers/rtc/rtc-rzn1.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index 06339adae71f..bc6af59744e4 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c
> @@ -71,6 +71,7 @@ struct rzn1_rtc {
>  	 */
>  	spinlock_t ctl1_access_lock;
>  	struct rtc_time tm_alarm;
> +	unsigned long sync_time;
>  	int alarm_irq;
>  	int sec_irq;
>  	bool alarm_enabled;

rate =3D 32768 here...

> +		rtc->sync_time =3D DIV_ROUND_UP(2 * NSEC_PER_MSEC, rate);
> +
>  	}

=2E.. and move this to the main body of the function.


Then, we should have all values always initialized.


--I+lGIvlppK+LgZCG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoyfeQACgkQFA3kzBSg
KbZ8MRAAiUIskbQZ7nfnyM94FicQ9r5vhi2Q9D1qWdONXbmfXkYE2BgHMmPSo4KO
D6GKdNiWpXtFWU5uuBt6xv5nkmLAVaTPfG7Rq3shO1aSOx6fiZK25CXyGGxhgb5Y
FN8IzOGQ8NjdVecXMKY4Pbp6BwKhOD1vSyE3sHEPiWAt/Db9Jxq7ZDsgupTC6662
QBrv8lMyhqWXekUs8LTOt+2OxEpT8/WrOskbDmY4osN+LPcJKNj0x1a9jPv32bvS
FXFZIme88bn5MCj2RmcXWxK7NT6QaBfhgXTjVKq+maY6jO1RF5FWBGeK+7cWTEUg
yBPBz4+2AtfGgnODEeXPYST4g2NURcwarpgl3LQlmG7b4Edh28dv+/mty1xZXsjp
XU5VzUtxhe6RPjsgyHvdOoG3LgW35WNf/QAFvq+7RcjbhsGEYaFLVx5c6bsYDzMm
wNLCtUpXHZ6tsdlVkpiE64nIti2q5lweOcOLEsBgQIPy3r+WCizUYOITS/W+uQNF
EcNSaKOClBCD3YKxzhrkLhboEZxapJvz56aXdRJ1Grr6baHVRqRAagRossVhOCd7
rjyaijo4oepkviwwRFxzxzajatoWfkSdeJ91d5UJX3g1n/BHl4+bgvr5N2otI0Xi
AY1qM62uPRt70vTyVhRp2SijU+6qUhiklB/Tz2wQus1/wlhHDgI=
=P6B/
-----END PGP SIGNATURE-----

--I+lGIvlppK+LgZCG--
