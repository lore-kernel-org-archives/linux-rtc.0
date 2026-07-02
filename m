Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12B6431E78;
	Thu,  2 Jul 2026 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980179; cv=none; b=b+anChN3KZvZRrurPtSbnWtO2ls/jhzdGO6Pq7aWzpn0CFjPrKCreESe+iAM6WXAlSfxeSBwVIR5t6WjmltFmpHvrhDuVAd0RNmQe+bJti3Ydsrf7Vm+/Rhyfa2aanpOUy6/E04Bkao3Wr55lhRkuPeUaGNugVpCn1KLaTR/LYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980179; c=relaxed/simple;
	bh=aUQUNx8nUuVL8ZBnzrte25H0FxvgWkLOH7aO0aVth7E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BhNDSF3P9j4JZiiJs8ISN/gY4oyOAp6CQdtvrrz0jsBswBmFkQN9qhVgzB0AuJckHXGuH9NRN50c2/69IW7Em6oVUb7PrxF9wpVODM2wXyqXxFiANmkr9OVhtzts2luuhePMxiGDPmJ56rsTrapfUeoY4ZR4LST6ewwxR0Pq3So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVPgcVux; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVPgcVux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84FC1F000E9;
	Thu,  2 Jul 2026 08:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782980175;
	bh=aUQUNx8nUuVL8ZBnzrte25H0FxvgWkLOH7aO0aVth7E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iVPgcVuxsephufZx0axFNmaxuh7ZRPyKaeEzN/8CuI4egN+RnIyj6IkOsBlcGLxpY
	 2ekI9mH2txR3bsW1RLtEs6x2ODWB0OzGO6qi034YrB3d+s83gpBK1KULqdYG4q60ba
	 YDP2G2u4VzWfd+F537ou6RytcBLGD5Ob10dGL+4lkHjujeNSZ8hVkZMGIFxiM26m2/
	 xYH7s257xi4mBgCF1Gl3WYHhdMfQ4+WBf7EX6mNpwNQhwMgDKfRIvKXpglR8fvF94s
	 1JhXTGAJFsmvW9d5avEzqXir5QxVseg/mdQ5ukr8xzYU/+Pal8oc9XpLmuN0MiZCFg
	 cZHcHVxH+FCZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/8] clk: sunxi-ng: fix ccu probe clock unregister on
 error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: robh@kernel.org, linux-sunxi@lists.linux.dev, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260702-a733-rtc-v3-3-eb2580374de6@baylibre.com>
References: <20260702-a733-rtc-v3-0-eb2580374de6@baylibre.com>
 <20260702-a733-rtc-v3-3-eb2580374de6@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 08:16:14 +0000
Message-Id: <20260702081614.A84FC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> When registering clocks with sunxi_ccu_probe(), the number of ccu_clocks
> and the number of hw clocks might be different, eventhough they usually a=
re
> the same.
>=20
> If they are different, it could lead to out-of-bound access or registered
> clock left behind on error.
>=20
> Use a different variable when iterating on hw clocks so every registered
> clock, and only those, gets unregistered on error.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/20260629131254.7E34C1F00A3A@smtp.kernel=
.org
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-a733-rtc-v=
3-0-eb2580374de6@baylibre.com?part=3D3

