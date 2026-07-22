Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8817633937F;
	Wed, 22 Jul 2026 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784732826; cv=none; b=FI6zRJhaftKgfCcVrKlWoxibfzK6qpFf4BQZqIc5bmdKDLT1HktCDyH3gSfWr/BjtHceSgreju+QU4o8AzbBCVAQu+UdQyil76GTtV+GSiA4UcGKkgUlY6cafLkzxH1i0TyV9XotZwN1ZwD2tCGEaCxdxqhagP3ktHJgo1bXbQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784732826; c=relaxed/simple;
	bh=7LqRTg8nl9UIS4uE2X7AgDhhxBKGbZI9RE9uvfsbamk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a3USg2A+hCB4YXyTENpKPOeBpxUU93Aqz9lZWoVctmXQ+pgqogB+y7OJ2bMeYCb3WvjZr8Z/i9ioryohVAKFRCU5Iq6wA+Co7rbzTL8gfc0+haCiW9gL28qqTjyd/5ec1XdkzID/LmymEcxtj2U8fRIb/o44dXoU0sk1exiArH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QND1Qlgl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QND1Qlgl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F111F000E9;
	Wed, 22 Jul 2026 15:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784732823;
	bh=7LqRTg8nl9UIS4uE2X7AgDhhxBKGbZI9RE9uvfsbamk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QND1QlglSMx8TK6vtz5bDwA/xrYKThz2wXr07upKi2d+Kq26Qi/gE5ijMHCH5LRxw
	 oyosCWlCALdTXRBcp7GyKFlvk91nz9rzqCXGmdfZnOf+ol4K8m1BFrYUXdEfOvId1J
	 7KG2xOtR+WXbSX6RXOdXJQhgMIVg7YQ4FW97lyjdAIxiRbOjOh16HCioCVxMVnmtA8
	 KUj/jEm1t4+U+pbPD9tvNZQ8NzE1yEpRDl147iSl562BTjc9phD00bf9G+QakOBEI4
	 jR6e2S1YItCWQZj8SnePdl5TWze8QsKBtlN8tjZs3gIqbIklfB7AuwPmoiJE+o2LEb
	 4bSJAVicnk+aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/4] clk: sunxi-ng: mux: fix determine helper rate
 propagation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: robh@kernel.org, linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org
In-Reply-To: <20260722-a733-rtc-v6-1-631cca28cc9a@baylibre.com>
References: <20260722-a733-rtc-v6-0-631cca28cc9a@baylibre.com>
 <20260722-a733-rtc-v6-1-631cca28cc9a@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 15:07:02 +0000
Message-Id: <20260722150703.29F111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Applying the pre divider on the parent rate is wrong because, while
> handling rate propagation through determine_rate(), the framework will
> likely round the parent rate again while cycling through the possibilitie=
s,
> throwing away the prediv applied. This means, the parent rate will then
> be wrong when the prediv is unapplied from a parent rate on which it
> was never applied to begin with.
>=20
> The right way to do it is to unapply the prediv from the requested rate,
> which is the wanted rate at the input on the clock element, and pass this
> to framework to do its thing.
>=20
> Change the determine rate mux helper in this way.
>=20
> Fixes: 1c8d7af61b37 ("clk: sunxi-ng: convert from divider_round_rate_pare=
nt() to divider_determine_rate()")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-a733-rtc-v=
6-0-631cca28cc9a@baylibre.com?part=3D1

