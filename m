Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89B33C1088;
	Mon,  6 Jul 2026 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331361; cv=none; b=Y6rGlp7/OuHNwNPeHu22n5is80/j+hLuHNKRdECXMUgdks4YojPrhqZLxRyd4dh8JeQDOByUW/6R9WxTq9liOpp+eig0NmrrMu2KfKEFtyuqzd48tsYWFbR+VHONpPs2woVz1/XdEy4dgZfud/rPBBmjLI4kAEN7qWS+cLZptxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331361; c=relaxed/simple;
	bh=+b9hs0d2F7m4ZhEJ9RX0uLHqnZOXcTScH2nR7J8L+x4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MoX9NH7obi87zBMBlVQ1eUJuPKZV3a8LB8H25HdsCjrL8pUSk9uORJst7jJPXohXBFKmyEzoRT02DG5nHTDbPxzD3nTFM5FyDTNRZjtxOUnTbziU/JhnNL6uu8HNVyZufDKDYe5bAGAF8PjvCDpB6jYPU+gj5Dc+UqTUN5O4+NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWsnFWEU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWsnFWEU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993361F000E9;
	Mon,  6 Jul 2026 09:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783331358;
	bh=+b9hs0d2F7m4ZhEJ9RX0uLHqnZOXcTScH2nR7J8L+x4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AWsnFWEUbvo/QlFTPCJEFq7gpQP+rzhBk4LnGiYRHX58Itsp/7v0u84HmGPgZcD3w
	 e1n/kvACcj1pLda9OBbXaxy8glYPRDnW3h72KDZC8gMeBg2Q8lQwVOtxUnSnG8HCMG
	 Ag8Bn66+2QK0CFzGJb8CheR2iLhrbAeaTY9OH67pK2ykwsOug1WhnUAK3ALeWeeLMI
	 2+RK8eR7OR7fdXnZaPGq63xwvxZOosO3L3tqaA9TVaQ0M91V09Hsy7gzcq+89sX/2O
	 p5mBw/bogfegNpwbMtJzliSLRy+SavlV/OU+v/4bvYNn6nX35WkLwcaiC2fbhzH6dI
	 /1dl+jBiT+UJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/9] clk: sunxi-ng: sun6i-rtc: clean up DT usage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, robh@kernel.org, linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org
In-Reply-To: <20260706-a733-rtc-v4-4-f330728db3d3@baylibre.com>
References: <20260706-a733-rtc-v4-0-f330728db3d3@baylibre.com>
 <20260706-a733-rtc-v4-4-f330728db3d3@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:49:17 +0000
Message-Id: <20260706094917.993361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> With sun6i-rtc compatible devices, the "ext-osc32k" clock input
> is optional for the devices that support this input (r329 and onward).
>=20
> Probably preparing for older SoC support, the driver does something funny
> when parsing DT. It check if "ext-osc32k" is present in the clock-names a=
nd
> if it is not, it uses the first clock as "ext-osc32k". This clock will
> actually be the rtc bus clock so what the driver does is wrong.
>=20
> At the moment, the driver does not support the older SoCs that would have
> an external 32k clock provided on index #0 so just remove this quirk.
>=20
> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-a733-rtc-v=
4-0-f330728db3d3@baylibre.com?part=3D4

