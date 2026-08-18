Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9F34582F5
	for <linux-rtc@vger.kernel.org>; Tue, 18 Aug 2026 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052532; cv=none; b=MJ+hvYZuyLUQK/mnJPmYsDnykq07dygm7voSwTWNP07473NqLNCkiqpllix+dm7iZhjbRDG6H+qz5LMOR3TIX5f5idTnTPe5qZtVEYd29K8zYIybA7WINTfvgd/5Tg37LMQpuCTJGd1IqC1j1KAgaWxRWcTtCbdWJFHK1wFbrsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052532; c=relaxed/simple;
	bh=rSoVLM/0ud3lUAUp0DqI7sQJoGb9vo5YsUfOcI3cOrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gy/23cSx+rWB73SQ9KuPcVcLgeDml3Z+TpwFoWhJcnLZkrirV6OcS9iMERqHc0Kug8W4R6lDXLIh+xZJw3K4xKZR8tcDSt2kuDsld+hEedQqqcR122mHqgTnEgeY+UE7PwnD7rO6JixSjEMcgLh7VmMW9U8kDY7F+aa766sNdx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=i5X2Vv0f; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="i5X2Vv0f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=KfvJ
	YESh3LDK7aMDLCYwiiNWKEIe9E8A0YChUBOWYh0=; b=i5X2Vv0fBv8KEb2yhSfU
	Hf/boQh7Diu1X49bhGQIOlTSEPTidKmuJWBTlEkdiq6t+7YorK1W9MmuNWN/h7mn
	B0LwdwnTjF14Vn5hQYD7JOU76+FPp4eI1mBMZYtgZagKtU7j6sut9dh4RwXnd6MQ
	7bY6MEwS9VnaLjBpFFqzYE9OPunjYRVsGOITPIXkU1+pDGaYFrWLFHUC2YAX8Azb
	LcPANmig7ZjkbDAjXeB83eWuWIINlRZEhymwqRsvCfej5jds7nrltLFsBQ5Z+3cV
	gThgRcl2jjPywL3XBaKE6d7vBmZh+0iT30kqv4XASt/8jlZ65DSygzaO5xg48aUR
	XQ==
Received: (qmail 3773925 invoked from network); 18 Aug 2026 13:28:48 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Aug 2026 13:28:48 +0200
X-UD-Smtp-Session: l3s3148p1@cOcml1BZvtsujnuP
Date: Tue, 18 Aug 2026 13:28:48 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: sashiko-reviews@lists.linux.dev
Cc: Prabhakar <prabhakar.csengg@gmail.com>, linux-rtc@vger.kernel.org,
	robh@kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devicetree@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 12/12] rtc: rzn1: Add support for Renesas RZ/T2H and
 RZ/N2H SoCs
Message-ID: <aoRB8CrV7ECOG33Y@ninjato>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706180331.3AD811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yaQdnyxd3robH3DO"
Content-Disposition: inline
In-Reply-To: <20260706180331.3AD811F000E9@smtp.kernel.org>


--yaQdnyxd3robH3DO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Should we add match data to this compatible string to identify the variant
> and explicitly reject probe with -EOPNOTSUPP if the clock configuration
> would require the unsupported SUBU mode?

Correct. Matches also my notes which say that this code

445                 if (rate != 32768)
446                         scmp_val = RZN1_RTC_CTL0_SLSB_SCMP;

is wrong when we have a variant which has no SUBU support. Because in
that case, we need to enable SCMP even for 32768Hz.

So, yes, it is needed to mark which variant has SUBU (RZ/N1 only, likely
forever) and bail out if no SUBU and no 'xtal'. The above code needs to
check SUBU support, too.


--yaQdnyxd3robH3DO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqEQfAACgkQFA3kzBSg
KbasZxAAh+UdvDISQDbAVdcFM1MRSX2vJGNj7lp0i83uMUWWY2j1jmvZFA6PNjK/
P+QY1G7iHhU8Bv/xyTaYOuZFhucgjUKBJbf5Au5L3VUuGCiEB6g3Jk8doU2j4NXr
TTJTAofOW5gDWLJNP5fFBACEp/STZxB9hr1wEz5sIJw/QTLAvDSVvkL2U5al24LQ
lBDG10itHZjmMsdKnUcEEVXL8J3Gv/ZZPCJYrXwVfxxAOoxj5e5Wn5b6NWMfA5IV
c0yTaUADCllXVk0D5HPGI2bAPx5DeLJSXsyghyYmK6sgLU2xHayJ7nlBz43XkKSt
kc+1ahOuStTQ1B6CmMXlMAIwORoTtR/34HLCd6nTLd6sL7zOy40BFtJJsZM3gvhC
5Prwj/3sl95hadnxz0TFyemhxxnQfL+dUSSO2EpmlZDXduggo1YfsgUFO9xr4q3l
BFelACcCjMSZpEO5L0CcviAqD5y/c7IK/9YdKehc72d1c0Mo6U8VkRdgVzAYPfCI
UUKuRXJlKBBIOaR8QXO5mpZhkkpscmlQdTAQDUS9/sagEVDQcoBZfO0LxcpfOsmI
JrX5sd6VC8A2/v5i9Bbe09u28nQLo8x8IJHNbI/pXsUQJRMQPfbVd5rvJVdimYCX
EV+Ok4UoTxTACBDh19+ii/gUIfr4gww/0BCO7FxikBdBeL6grLg=
=4UQo
-----END PGP SIGNATURE-----

--yaQdnyxd3robH3DO--
