Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3C42248B4;
	Wed, 22 Jul 2026 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784732282; cv=none; b=fAuPmnuZ14WXGspR7GYI52bsmLpuco4g/Ekgdg6jsN/beMTIA28ogpWdIxcjhAAmQ6dbTS187eGBWpdEMyp94hbJtqDL9DWBVk6rmpBGT2khm8Df2k6lv/1239ZTD/iOziNeD9BHQ1seNxkWtPgrnBq1O8QzR8kjDwwN74IhB3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784732282; c=relaxed/simple;
	bh=ciMtyAPMHjQa5/mGXu2mL8eHouBFW58oZpbzs1onwnU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gGBcZOjTJHRzYYWt6vPfuw4H+7upRCyjFzjZTrrFuknPqwJRYy2HHaEEE2GLtPQ2GyFELgejQkCRFAnxqaTKgjVHUWjzWE99/kcht2QhtqdkqTL/NOiepLXKHFPOYKtTySjj2IRUOGAWKakNmTGDdELAmpvzkje3D7aFT3EOCEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ol9npmXU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ol9npmXU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66281F000E9;
	Wed, 22 Jul 2026 14:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784732281;
	bh=ciMtyAPMHjQa5/mGXu2mL8eHouBFW58oZpbzs1onwnU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ol9npmXU5lnY9rpX1aT7sfW0WXNutf2Ah8hfTqxRwSj/7mHYeQQx5EOTyuR/i6cHt
	 fMTdT+bqSVYbEIS8e7Y8EGcsHWaoM0ryglUuPp8PenO3D7bcxsRJhhCQ+cAwzRm6JW
	 r1Ytk0bewVomDh0PzROFCOGF3xSyWlqweR6N8SrMLP9TdqMnN5rTAG3t4uTr8uwHjO
	 xIYSlpFVA/3okfVNo3n7XTZi0irOXlJmj2DGhM40g6rJNEnTHQQ9TFb3Z0/QFEVen9
	 BukUe6+jliqKgD6aEloCn/i5GEu7FBOwxKun46ox5ZVf+6OhsMaffiyV1EcCwLi51M
	 +AaoI3kQATw5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/4] clk: sunxi-ng: sun6i-rtc: split main oscillator
 div and gate
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org
In-Reply-To: <20260722-a733-rtc-v6-3-631cca28cc9a@baylibre.com>
References: <20260722-a733-rtc-v6-0-631cca28cc9a@baylibre.com>
 <20260722-a733-rtc-v6-3-631cca28cc9a@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 14:57:59 +0000
Message-Id: <20260722145759.D66281F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-a733-rtc-v=
6-0-631cca28cc9a@baylibre.com?part=3D3

