Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF8C34D901;
	Thu,  2 Jul 2026 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783017892; cv=none; b=bhEy9UtwdX9L/oJ9y2s3DZNzBsG6h/d/k0pUQEdCXT/AP7hcYMGFUtj0Oj9HxDM3VWQD+6/1gPe75G7QOoqmQNcAYtPfiMba69NNQXQYmVOfnFMhwyK+kQLM+GoEuqETDQN4VTy7f/DaQcEjNKd4K+b+ZhHiGEbWeov8rpODz94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783017892; c=relaxed/simple;
	bh=RlWQKLBpPejSZHZZzN/mxlrqMYq2TV7X1RN6v4yZKnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/WTOv1WgjZ1PmPqenGEL+70vxHXcEhGIh9gCx3jQGz0YMqDfAeWvVxab26sSZYcNtlQ+hVG1WySNkEChJmTCtmoWFZTOsVcmO27kXaqqbYcJjf+5dYt/DvrlYfYQgRIyqxd5tNPDS+g3VijhnKyjacesitr+3PUFh8yuaKED+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mv15d627; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mv15d627"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2365B1F000E9;
	Thu,  2 Jul 2026 18:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783017890;
	bh=RlWQKLBpPejSZHZZzN/mxlrqMYq2TV7X1RN6v4yZKnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mv15d627BMhysj+dOXP1Epessj05M96xpkncn6udtJd28nby1H8MaWbOzU9mPmAmF
	 DoyFv/BiP0r6RrpTnolEpOTWx3yVNGJ+zXlsGgbiuMlT9urSaFU4VkRzMeg8qJUbno
	 Zpb7NtzkMd2U+ImaLp5xaHf2sSxAqRKormo0oW+Xzn5vMCKtvL5Wec2aiuX5FrUS4i
	 H2FDyAjV+6gqbg8UyAKSGvz/Exb1T7nO6FYTRHMy0Jp4x+hArkQRk7rhqFntHOTgfm
	 AbRkUTSAYZbycHK9S1+Cn+Gq0Qt1gS8VM12khfGIyCFv8FGpesNsd5c+liHJE6aXJ/
	 opet5GnVwyagQ==
Date: Thu, 2 Jul 2026 19:44:45 +0100
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
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: rtc: sun6i: no clock-output-names on
 h616/r329
Message-ID: <20260702-handstand-juggling-108225b4599b@spud>
References: <20260702-a733-rtc-v3-0-eb2580374de6@baylibre.com>
 <20260702-a733-rtc-v3-1-eb2580374de6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FZulPCrKKJP31cIw"
Content-Disposition: inline
In-Reply-To: <20260702-a733-rtc-v3-1-eb2580374de6@baylibre.com>

--FZulPCrKKJP31cIw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--FZulPCrKKJP31cIw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakaxnQAKCRB4tDGHoIJi
0rzBAP9zhEDgVgJdOXCZal2TY5Vh8abZgA2I4I4i3kMyryX0ZwD/XaiOCZN5gKFk
aUYY65HjHUxhL5MGWH0r0SJy4Srk0w8=
=h88k
-----END PGP SIGNATURE-----

--FZulPCrKKJP31cIw--
