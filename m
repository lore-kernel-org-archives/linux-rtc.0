Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8633FE363;
	Thu, 23 Jul 2026 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800245; cv=none; b=fEptkXVHo5xI1gf2sTDuft3763FZEwrWsWuQKWarjg2c7Kwgs1Z2LpEreZEfmW5A/ZCaW0jl54uh1/v9sUag6HJixJXObM21gtV8aqIbFsahGK1bgCR6jMn/8/Kq7jUABckmjWafTSxBX4syPZmlR8Y2Vjea23rclbRdLbTKyOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800245; c=relaxed/simple;
	bh=nceenZ3HYOpEGg/xtOLdZBB8/8rLO6zD90ibtkYSLew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tmcyc5UWRnKnEfpva/XtjX0OOBWBV02AHqP0Op7KfliXFsDewmlGsF0dbU6ekySycQgw97sJf9vEsy0JdvUPjidUC/aeq8KceQkFq0bC01valk2bDcvJVoKcegv8IVE047pD+AmM9JE30LnFVXdZFI65b1qlpcua8PSiDN4dGXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwkMt0L/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwkMt0L/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156171F000E9;
	Thu, 23 Jul 2026 09:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784800244;
	bh=nceenZ3HYOpEGg/xtOLdZBB8/8rLO6zD90ibtkYSLew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AwkMt0L//q2fgBYZVWy9nVCh+A9XUbz6TSmYeO7VA58WlFy9n3cq0WJugUlDzKGZ5
	 mz8wL9ORsw6p+w046/aZWeBximcyNUrR2shnEYy6Yh1BvHqvRH1VzN76FbLMORK/mM
	 9nqeRdqiRyuFLio19cirTIow7N9Wy0neG5BeDFBolvdK9sbZ7/b5VYHRO7tgkH9duP
	 vCJBJovw3WlFiridbYz4r4un+9QiLiNG/XGbBgSqKQmu+0Mj7zruHjIZcRC2gJWLs7
	 YWLZp1y31bSRrvs/j1yzfekFHhOst6RZZKeMBHnmdg2ErzE8occpHepevcvDmtXHAo
	 Y9eTEXNcpGgEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/4] clk: sunxi-ng: sun6i-rtc: add a733 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-sunxi@lists.linux.dev, conor+dt@kernel.org
In-Reply-To: <20260723-a733-rtc-v7-4-8fd68aab94ae@baylibre.com>
References: <20260723-a733-rtc-v7-0-8fd68aab94ae@baylibre.com>
 <20260723-a733-rtc-v7-4-8fd68aab94ae@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 09:50:43 +0000
Message-Id: <20260723095044.156171F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-a733-rtc-v=
7-0-8fd68aab94ae@baylibre.com?part=3D4

