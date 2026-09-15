Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279763D3D02;
	Tue, 15 Sep 2026 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491337; cv=none; b=PQLlacWc6ywnnmQiJ6K6Vx2ivdP3dCqThNnyQL0U1Y4w4xv/XicK3jWPwgwG7nEsPhJgWS/ig0LcIZbbiSHe5hJi+SpMPKko516wYvP9CicLzN0LBEsUMre3OIamw4iYWRO0qVDHJpUcEaGjzVzb84qCJiQMUo6sx4D5ZPYEReI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491337; c=relaxed/simple;
	bh=JlbmrggLze1HnzD9Eoa+YEVx0COikvuBKxcnDz18xz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUWW6jgQOJEqWTExGsOD5m+aXrJE8uDniAma2TdwUWaJPsJdOji3aTQ2j9VEdYhHigJZKEG1BGpLu4RxpzIMAcE21LRwav2D/0u/ZPGa0m1A1XxLsTyGlIA9I4g2Y6cpI0qD3vfg+dxyH0xy3hevn+VCvuhYYuTXA/Bc4TFZ1cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGf0psij; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGf0psij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762241F000FF;
	Tue, 15 Sep 2026 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789491335;
	bh=JlbmrggLze1HnzD9Eoa+YEVx0COikvuBKxcnDz18xz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YGf0psijawddTcatQPiaRFtTBigy5+U9jUrFuxBEHbIhfXzHaYB6hUIZT9btssSpP
	 9T10gAkxYE4Mi1Oi6hq84SE9jplcX2jNvD7cGqO7e1RletE5N8Ao7/AdT8ggDeMUon
	 Lc7cS5jmY+WePZHxGfwqA0COU5wMvPdjVYMpNaBdqp+iNzemWBspQn+aHapNR9u2F3
	 wSLR9jvEScdglmFvLIBgjNEQTN97gNwjP5Hnu7TUXdIOgF/wphvdvMqdsr8QHRJiC6
	 wsVYnaCW1l1XuVUVLGAGMwQe4g8egvRI7rRhGIJSzmeaQdZJRkRqdK5/vbUl9rAm8C
	 OuM1faRTnW+0Q==
Date: Tue, 15 Sep 2026 17:55:31 +0100
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
Subject: Re: [PATCH 1/6] dt-bindings: rtc: rzn1: drop unneeded 'start-year'
 from example
Message-ID: <20260915-jittery-sneeze-a9252f9448f1@spud>
References: <20260914211826.73727-8-wsa+renesas@sang-engineering.com>
 <20260914211826.73727-9-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hUj7EpDLQ8pK2vBn"
Content-Disposition: inline
In-Reply-To: <20260914211826.73727-9-wsa+renesas@sang-engineering.com>

--hUj7EpDLQ8pK2vBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--hUj7EpDLQ8pK2vBn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaql4gwAKCRB4tDGHoIJi
0u4lAQDgmXK63qb0SUwQCz/6yWHUSBO8c4heymzpqVVwScep8AEA1kH3rnVTo4hE
3dvh/Wc9980n2wH79Yxz0GiJwUUlqgU=
=UKnR
-----END PGP SIGNATURE-----

--hUj7EpDLQ8pK2vBn--
