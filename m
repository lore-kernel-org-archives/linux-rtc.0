Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC3C36F413;
	Mon,  6 Jul 2026 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333593; cv=none; b=qfEfZS+DU5I1aJL2jJmSk0Pr6vqHF8zulo3e2ovCFhCRPi5DiqECekxh2mORJzjO0W3lIu6SPiP9XaoW5RpDl4/LhBDKdutYn9WQvfRbfMk5ligrmlRnT8a2AKyana5uU3hjR8R+LAPsAFC1Ooiw8y0pBIvw63fI6/Kw+2i7ROo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333593; c=relaxed/simple;
	bh=gRQ8gsnSlcWApYxxAO3qwcQB75QOX0tVsb90yzPP1lI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d+S+hRqpSAEAqn3T00/Rz2o+k9nTe1ruEWWBgRTXGY33PzoF6b2gim9yaKe9ENSWio14v2nu+LudFF5jU13tMoxSbo2GzxJqSqF/DeVNJhEEd3Ob1eZl34l5++0P8rqkwlJLVJhSGh72O9n5rQDIo14ynNpGc+lhIvWgnebWVsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+O60toa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+O60toa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E521F000E9;
	Mon,  6 Jul 2026 10:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783333591;
	bh=gRQ8gsnSlcWApYxxAO3qwcQB75QOX0tVsb90yzPP1lI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y+O60toaJHxHSOSBD2E+PQn0P5iMhH+KSvQL0OSZfhjxEd15vH0SbnYi36K30rVDU
	 T9Y0sskUHnqnDWZu88GUqCWh/F3H2GDeB9HRQpDBZXUq9PEZAFjMDKCDuHdV08NtV0
	 VAITwyFdVg4DbGX+jfTAXUSOWDeXsv4nT9nia/zlIXsIjnTYiwM1QG9Qp03+siDE5p
	 kZza2uVHAskvZpICdhgrfDye2d9NtP+uvRx/gyZb9b93qDMidaNig/Saxq1OkcDWR9
	 Uqzq96Ip0zGAc/uWtgR5Wz3THq6K9cH743ZTHH1Itxw8mBjAKtqTum20DbuxdMaj06
	 Bw1yUBQGMsXvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 9/9] clk: sunxi-ng: sun6i-rtc: add a733 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-sunxi@lists.linux.dev
In-Reply-To: <20260706-a733-rtc-v4-9-f330728db3d3@baylibre.com>
References: <20260706-a733-rtc-v4-0-f330728db3d3@baylibre.com>
 <20260706-a733-rtc-v4-9-f330728db3d3@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:26:30 +0000
Message-Id: <20260706102631.49E521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Add support for the sun60i a733 CCU RTC.
>=20
> Compared to the a523, this SoC has a different input oscillator divider
> which auto-detects the oscillator rate and select a divider to provide
> a fixed 32768Hz clock. It also provides several phy reference clocks
> with dedicated clock gates.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-a733-rtc-v=
4-0-f330728db3d3@baylibre.com?part=3D9

