Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1986135DD1C;
	Thu,  2 Jul 2026 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783017910; cv=none; b=T/WCbC7gNgU2PChXBatqGU6JQXEmhgMyhB9N8tXni1m+o3eo3b9rgnlmzMI/0PM67cBA+E2q5zRQ6QFdhjWhx1cFIIidgatah1IIq6l5ry87zGAKhk8CZOq9UTEq621/NE+9qy1G/3nCPwVnqJuEJn6mMaZMcX2xyrhmpT8qqGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783017910; c=relaxed/simple;
	bh=2Z85cQ6uU0GVtAZUpmRXHyd6C4EsGOmLz1XMPvSK4wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jy9SNX0vPRwMYrXfF5wjndy94jq/YcKvzngvN47edJ9I4D2lC7l3gocJ81rVGSPg2b51MFUmbqF0EQ6IYg0kXhs7FDH0bAlIa/Dy3VRIXINTW1Uyv1QPUpoITR9tSD27kwhvtnIxQ6ePcnQd1VWkGyhAVeWYpY/JbHX8lWYMoWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq1WHjyM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq1WHjyM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9C81F000E9;
	Thu,  2 Jul 2026 18:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783017908;
	bh=2Z85cQ6uU0GVtAZUpmRXHyd6C4EsGOmLz1XMPvSK4wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lq1WHjyMJAk0Jm7Uv9pgDiSOP6jj32Enc3jeuBZge6AZtSYljC/kgqXGmlpt2Eb0I
	 ucueQyNOBfKaWND1I7R7mZWs1aXMtNOgtiFz6fxoqfzbWfNff3AjXdOYcRPl9K9xtB
	 kSK8ANQSv31o6Hnqt05xDCBjf8Elh3vIXhJbk3HRIU+FRYx5x3iCV4F29SuJ1Qw05y
	 U1viVePIM3pM7DOjA44c+u9aIQlTFVMaYYmETGEmS6JFZlFIFtg0M91SYKoJKicG9u
	 QqGBwD95vfL8luEeLwkwXg1ifRZZbqdugke7nKWYxfwj171Z2UvkVrkdDaVnvPIvQg
	 OxYAwsSuBiV9g==
Date: Thu, 2 Jul 2026 19:45:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 2/8] dt-bindings: rtc: sun6i: add sun60i-a733 support
Message-ID: <20260702-upper-gumball-d8bebf96da5d@spud>
References: <20260702-a733-rtc-v3-0-eb2580374de6@baylibre.com>
 <20260702-a733-rtc-v3-2-eb2580374de6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mQHzYtXtpMBTI3Nd"
Content-Disposition: inline
In-Reply-To: <20260702-a733-rtc-v3-2-eb2580374de6@baylibre.com>

--mQHzYtXtpMBTI3Nd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--mQHzYtXtpMBTI3Nd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakaxrwAKCRB4tDGHoIJi
0pVnAP4tatAlnoFqSSWR0Dehwd5JIMcYJH+x9gGwkCIsU97H/QD/ZCVMzErs59f2
PlcGU5fGnv1DYWjhCFiGO+3KWCNFyQ8=
=r6LU
-----END PGP SIGNATURE-----

--mQHzYtXtpMBTI3Nd--
