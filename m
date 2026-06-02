Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26893750B9;
	Tue,  2 Jun 2026 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419603; cv=none; b=llH94rzdBuvPq+/mcEx4LRILNBvHh1BODG3viRNutAsr1j4v/ddB3Q6D2S8yKZJ9vv2q4/10pzxDRuqHGf1UD3/tIqUeHmiljn4Buj+nfH/zQEs7+roQ3j19g2gagYvzUeOF7PxKACzuoiSdgHHxI1iFKBj4RVJpLNRb5E0lmKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419603; c=relaxed/simple;
	bh=aXEL4pwfPMVz7iJb43Gvy4V5PhxsUFD/gCBxQEtwy8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hj7tsHw3/zZu+dI97TUQI/5JQ/iCrVG65Rd3zBH4Jii4/I7cPH+4zv70EhgIg9oPc96YMMS+QIQWkX57puc1xIVPC2qk2iVmFLjc3VLVmOp8xmC6IBeHQD2NEMo+sOLZhE5OI1kpRjddQLwn6sEStpZD8smaw5yEPDBD8mqTaBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqn5sFCk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqn5sFCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A6B1F00893;
	Tue,  2 Jun 2026 16:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780419602;
	bh=aXEL4pwfPMVz7iJb43Gvy4V5PhxsUFD/gCBxQEtwy8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eqn5sFCk9Gvk5MQ7a/oBBQ1+0KnpNVzVsNgERJHir3cW8slvMQ+h7DfI5X3owfXWD
	 yaoVqBHOnyep+/kld0J65qgMHBPo8MxXdXBzXcRPgP0f666v/1lXt2hemMLszNKK5o
	 bSOqyunDtFpKXL9T3vZwPHr3zV4+T7wiXsDr5DQeeubDFYlxh9zAr5ICEhwEMI5CGP
	 RstELcE6izDm6itOOogAcqL766P6clMh5X/O6NnSaUrnTKdGK3dYR20jtq5Zu4Pa44
	 eDr1YobTBhfQ/QCxqw4JxlpO0VvDONJv11f8L0FzBTdeeRGcF9zkckWecb/xveAOgz
	 tGNlOtjyzw7zw==
Date: Tue, 2 Jun 2026 17:59:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Tommy Huang <tommy_huang@aspeedtech.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH 1/2] dt-bindings: rtc: add ASPEED AST2700 compatible
Message-ID: <20260602-refresh-crawling-e6852feb9dcb@spud>
References: <20260601-ast2700-rtc-v1-0-15d4ca46500a@aspeedtech.com>
 <20260601-ast2700-rtc-v1-1-15d4ca46500a@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sSlNZiJes0XynWvQ"
Content-Disposition: inline
In-Reply-To: <20260601-ast2700-rtc-v1-1-15d4ca46500a@aspeedtech.com>


--sSlNZiJes0XynWvQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--sSlNZiJes0XynWvQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCah8MDQAKCRB4tDGHoIJi
0srpAQC+gmj4JJGrXIWGVt27womZpP49QqQ/L1k3k5X9ws77DAEAt4Hn4w2ksqmf
SI39dQOHYZ0+bCvn00VuAoOoxWr/Bww=
=kyAk
-----END PGP SIGNATURE-----

--sSlNZiJes0XynWvQ--
