Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B61175A9F;
	Fri, 17 Jul 2026 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784302401; cv=none; b=mJeLdJuv8GjpNtzm/OBOg7GsYjQtXio0+dkNUTpB4xvljCoZ2aJlvL7kaO4aduVn1V4XS6OprrgsS50yY8Rnj0xVOosg+9tEYZLpXcGttXwYE7gxonhayXVHZ1CkhAxVwGRuFw6JBFIks4HOnTGAuIHEmrdbyH+Fta+gXtY6xH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784302401; c=relaxed/simple;
	bh=pSU2a2laYkd/6MmJ7DoYT/Sr5B/9zd5nIfi69GfBp84=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fjMy2J3QkMrJUbaE1KDfN8NoShjJiRS5vRDpsbOtKf1IHA2L1Zv9LV1hJl/YW6uBGjn1D0dRwCPZHSYzLsU9e+WtQu4sxNe7QY2OruEtZRKA/IOIWpl9SxI3IdyGB5MK4RFmt3UzF5iLTrDid7WJltwwszBBmiylChG8NFxiLjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8RDYSoW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8RDYSoW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7921F000E9;
	Fri, 17 Jul 2026 15:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784302399;
	bh=pSU2a2laYkd/6MmJ7DoYT/Sr5B/9zd5nIfi69GfBp84=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S8RDYSoWYKjAHfDnp4UJShC29pjBnbqSKIo69/ZJJzzfn3TFCSN6eQxpW3TSw4SuL
	 uEYsXFADAigpM2enkp/BX88GIvKsJsxcwcoBmzoVoz4Uz3UJcv5SIVNaYJaEf1aI8J
	 m2wWbubgoOVkoXsmOYGnRag55maemPlcDdNvQt9M4NSmn8PFZ463iXDOVmx2X4Kyl4
	 CIRzYO260fwWoY1FtSGMAOxb5S9TzkFuRrzJvZ2iJuur7ikmG3EuNScDZ2FpSKJcDS
	 80X54bXa1Y8ln0AqsTBhKUWEaZbcG+wOcrzD+ZyboB6H0GINBQz3oiumaxNlOOgriO
	 AUgM0Lw+aLmsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] clk: sunxi-ng: sun6i-rtc: split main oscillator
 div and gate.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-sunxi@lists.linux.dev, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260717-a733-rtc-v5-3-3874cc26abf7@baylibre.com>
References: <20260717-a733-rtc-v5-0-3874cc26abf7@baylibre.com>
 <20260717-a733-rtc-v5-3-3874cc26abf7@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 15:33:18 +0000
Message-Id: <20260717153319.5B7921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> On the a733 the "osc24M-32k" clock has the same gate bits as the previous=
ly
> supported SoC but a different divider implementation.
>=20
> Instead of a fixed 750 divider, the divider is selected based on the
> rate of the oscillator. It can be seen as a simple read-only divider.
>=20
> On the A733 the gate and the divider are on different register which is
> not supported by sunxi combined clocks. These element will be split on the
> A733. Split them for the older SoC as well to keep on sharing the gate
> definition.
>=20
> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717-a733-rtc-v=
5-0-3874cc26abf7@baylibre.com?part=3D3

