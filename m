Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33382D73A0;
	Fri, 17 Jul 2026 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784302817; cv=none; b=FaJWobuof6g6waUiGoRQ47aN0AfkKKzriY4cmI/p7Mhi15GpWiBXeR5q6e9lDUCXX3B7SFqTBrYCPDgM0vQgXQESOuL0bnXM2QzTpBkym8zHDHcjuQg3gYxFnHiI10oFGCDaC2OFsSPAWdYYXHgur1Zy7YTyYNpqsefEMKmx8D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784302817; c=relaxed/simple;
	bh=zN18TILE3CBnXG8kzjLMYv9zTqhuXam2bzCTofNpjOs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uRxn2hDVjqGpzxeoTuc61tI7kgel3p4KYBsYcjc1Cdx+0fGUjI3FVw8QdyJcmrJzIZJqW7yTrYk+WUu+PCpQb3PRb+QfhyGRoLudBMi16FSkp1pem5MlmgmHMLLw1/FzaIFio041OWL+A0aMvOD+JWjRAJ4ajIpTqd63Hms/3fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajBN+ZJD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajBN+ZJD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6831F00A3A;
	Fri, 17 Jul 2026 15:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784302816;
	bh=zN18TILE3CBnXG8kzjLMYv9zTqhuXam2bzCTofNpjOs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ajBN+ZJDt/FPZH1gUhDHoo5FgO7etS8LdKEiySkeONoFj4xVPVkIw1OKUqikJa1/X
	 Vp7gEGXwVbDBNe15Dtq6ZBc6pFXVS7Ia2oEjIwCSIazoQcWB3nkRVUZnbka45/bfbx
	 CQnjQHL77T0Hw9FWySzEN6OKlsu1672nq9gUjEPzCZqS1ITc3f1DYetxD7KPI3IoWe
	 lYsBM394Na41e37G7J+F0u5/lFQNFxJkhNyPo8fhElkXoePsMMyrmgxSkxEfl6lWHh
	 R+MAMSU7iSRizPRQ/daPUhbpdNxfTFgndOodYbqeiiSBCzf2DDzEd8uvGdBFPlzggZ
	 ZONq+8W+h959Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/4] clk: sunxi-ng: sun6i-rtc: add a733 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, robh@kernel.org, linux-sunxi@lists.linux.dev, conor+dt@kernel.org
In-Reply-To: <20260717-a733-rtc-v5-4-3874cc26abf7@baylibre.com>
References: <20260717-a733-rtc-v5-0-3874cc26abf7@baylibre.com>
 <20260717-a733-rtc-v5-4-3874cc26abf7@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 15:40:15 +0000
Message-Id: <20260717154016.1D6831F00A3A@smtp.kernel.org>
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
> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717-a733-rtc-v=
5-0-3874cc26abf7@baylibre.com?part=3D4

