Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CE8480DD5;
	Tue, 15 Sep 2026 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491323; cv=none; b=eLfRcLeSr9vA7nRM3aSd09No3Z5ddPDLvitlCb8t2RArSJ9ob86oyIPkiu9v4n1mNroSUS2IAxqokvNed1AEJmUAz3Sn8y0L/5u4QUYdyp36wMSyjwY4ozCRhgloF1EtBtssdprNTvz91JeL9TMGv5uJVV0iTflUfBHyNrjVgws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491323; c=relaxed/simple;
	bh=TryCSdeDRDacWumjIDtb2a5QpQ06zNaj2DO/slPtUUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cU8IK0cJqHc0xThpGmiIfttRTotkBNaJ4qVubD7sTn30M87aTpdXlrAlCjdhioKle7lZ9Fw1XN5vTOO6afSHcPzHgILO+YexDCSRi4mOMaEnPHAkSRucUcebTV/IntMF/otD5bGbf6bXAfobWcQghOyod4pUv//iq3L+O+PIlHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFvCUbp0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFvCUbp0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C461F000FF;
	Tue, 15 Sep 2026 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789491322;
	bh=TryCSdeDRDacWumjIDtb2a5QpQ06zNaj2DO/slPtUUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BFvCUbp0gWRQItBUZAgjVOLR1SDD1MkVEHF38sMx07nYKN7XaF/Hv0qcrmoPWo61j
	 4yeHwDL5XwVFajSgn8jLQhuE90rHQqGbe3FjoAgeHGdAfgOlE31FZrQkn6uIRpfD+y
	 1wR8tobROtYNpyfcKqRaJFA11dl1gqES8CUkP8dbYRjDDeDD8Wwet7xjTdY8WX6jiI
	 WqXy2qgYLNsuF0Pt/hZO1wnxFFieiYVQzCUR2Ni2Rps5FRHBmKvHV7lqmJUUZti+5u
	 VhtsxPLy4da/mRh9cVyfsFatGehpWj5ZV/5/23pkhPEevTDBZZF2Llj4yWRV13YDLo
	 jait0UvpkqR9w==
Date: Tue, 15 Sep 2026 17:55:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: rtc: rzn1: add SoC names next to their
 IDs
Message-ID: <20260915-finicky-gloss-c6495ae332a5@spud>
References: <20260914211826.73727-8-wsa+renesas@sang-engineering.com>
 <20260914211826.73727-10-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="laaFeUjaqvYgReOo"
Content-Disposition: inline
In-Reply-To: <20260914211826.73727-10-wsa+renesas@sang-engineering.com>

--laaFeUjaqvYgReOo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--laaFeUjaqvYgReOo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaql4dgAKCRB4tDGHoIJi
0kJqAP4qlJnu0MMuUJp6cIRrFShOd/hNU8FY2x9oYIOCMmXCXgEAweSrorb9k4q2
6R6mRs3BIadlN4DUPpSp4jyONQu+4go=
=e5+8
-----END PGP SIGNATURE-----

--laaFeUjaqvYgReOo--
