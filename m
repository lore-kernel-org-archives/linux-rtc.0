Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6682436B910;
	Wed, 12 Aug 2026 01:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786498998; cv=none; b=IiIINGNApaRBfgpVkOTJuhQqXMscjxnm0inx+ZiMgexMq5LNqnhWKFpBPZJxP2NHcyGbGDxpAu9j3aAyRNihs9h0qbwKHPRt7yFK5s7bNdZAADSb/ggqT/S7tLuDHg0nWFNPAjrvIz0p+d+yANIB+Js9BDiPMdm81kqXYTrvbPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786498998; c=relaxed/simple;
	bh=RpT96W6McEBmUiSsXd5v3AQZbFYUbGjLH1REzPrLXBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNKJzbmV/JMSnQtwsB7oXJOPL2GOwvryi/wyDD37+VEkGamPKJZBIi5vSICwYu2y6GZYakDX5vupE4kiM2OIrD2lYNpum0M+Gf8Cd1XAf2aNjPdKSo1ztdEdjcTO2RWXvwJc4+/REVzFcj9G9Tr23iwtQc4PQgVXJXlIntdX0lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ls3ddR1v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ls3ddR1v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5301F000E9;
	Wed, 12 Aug 2026 01:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786498997;
	bh=g/vI6wCZsy/vzbFKcn60dM/qco3YlxXIkCwp9QNjgOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ls3ddR1vS4hY9X+AWkteoCYupGCcyzeSsiiivH0yZvd5yzgOBpsjP94cuh6+CXqgu
	 jzE3anvSWJAgAKaC8yhadkeVm9nRZ3hGNttK/DJuAJfGDonBFNSjVgGei+IiLZu6G2
	 rL+dbxsnVG4mKWEgiABdM6pT+Xpe6WE2ofJPtnPH5pqXQn2sQP4i5wSfdcbqniRz/d
	 Rrljh4TTE1TddcgOOwnACfjdoumk5KxbE9w36Hb02e+PJo9c4WwKC4ze6kUMxwCg32
	 0lz678SLU8DXn9/thfYemLb67pJdI7u33c4yiMsvNXjjCh4oMbp9Z+854UmbKWyDxY
	 K8f5B+EBbDvwA==
Date: Tue, 11 Aug 2026 20:43:16 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Brian Masney <bmasney@redhat.com>, linux-clk@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	mfd@lists.linux.dev, Stephen Boyd <sboyd@kernel.org>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linus Walleij <linusw@kernel.org>, linux-rtc@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 02/10] dt-bindings: rohm,bd*: Ref common ROHM bindings
Message-ID: <178649899582.485262.16944212879367030522.robh@kernel.org>
References: <cover.1785838584.git.mazziesaccount@gmail.com>
 <d419dcf8776f7ea88e4a66b9a0f0087f11e6622c.1785838585.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d419dcf8776f7ea88e4a66b9a0f0087f11e6622c.1785838585.git.mazziesaccount@gmail.com>


On Tue, 04 Aug 2026 13:20:50 +0300, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The commonly used ROHM PMIC bindings were added into
> rohm,pmic-pins.yaml. Keeping commonly used properties in one file can
> ease both the maintaining the bindings and the reviewing process.
> 
> Reference the common bindings from rohm,pmic-pins.yaml, instead of
> declaring them from the scratch for every PMIC using them. Keep the PMIC
> variant specific information (like supported pin functions) in PMIC the
> specific files, so unsupported values won't be allowed.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:
>  v2:
>   - New patch
> ---
>  .../bindings/mfd/rohm,bd71815-pmic.yaml       |  9 +++---
>  .../bindings/mfd/rohm,bd71828-pmic.yaml       |  9 +++---
>  .../bindings/mfd/rohm,bd72720-pmic.yaml       | 29 +++----------------
>  3 files changed, 12 insertions(+), 35 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

