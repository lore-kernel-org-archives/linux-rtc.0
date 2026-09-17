Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B8E3C9886;
	Thu, 17 Sep 2026 19:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671771; cv=none; b=XDFVhH5/vP7VkkwSTyuyC8YU8m+XtbVf3BNQ6CS/glQqemgv/EijnLCqm9HqIP9S315fV0Ad9sDuTcL7IxHc+3HCZBb4/sFAQTVG3sq27/uwlZlQHTU9PSCkZWzerR32ZGK5kvKKI0VzesQU9eygdaqX8Eksc1RF6wDLwxLRDZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671771; c=relaxed/simple;
	bh=lze+RPk+U6Poc8aKI18GAN3mxw1NYgMwfhGE1coWmwg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SwuWPSiRkTQBEOc2bHVTzixhEggNOXqj6ELDfxCkdw2eOyHljvcPg8DuBc6t6UJU7ALw0FzWxGhE9sfm07mJn3WZhAfXMVzE5juwOt5X9Yj+baweTWDBr3guMEWbj/O64pRmzIdx9XHTba2MP7NUwK//aLonwACPtzBL97xNlqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z20L8S5T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z20L8S5T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06731F00893;
	Thu, 17 Sep 2026 19:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789671770;
	bh=lze+RPk+U6Poc8aKI18GAN3mxw1NYgMwfhGE1coWmwg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z20L8S5T7gdAJHTixmsAMpGDCvL0VKnHS2EklEFJcAC3A2PjrFDDnxzEXQiUlNc75
	 +sHPNrLAw103j6A+Sixdvnvb8CLlVu3P0fn7wyOuGYtTB3GejD5CZQc0YkQk9KP/CA
	 DIkT+O2J0wdH3VKZRFr0PZnoRTwTgABgXojC4TaLrV1SdJeBB81Bts0nzfcce+wZwS
	 iASxYMtC1W+cKjNuuy9b4Gk8PtDNJDETdpEQ+N/e4AMoa1Ksze2uuxwUlpn7HUgqUB
	 gKj9BktoH5VgLg3P6h4PjOPS/1Rs4uyoS+/KX93Rg9L/VrvfZEfwSsLcP6LXSLg460
	 6nmKe3ik/hG9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] dt-bindings: rtc: rzn1: add R-Car X5H support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org
In-Reply-To: <20260917185903.61253-9-wsa+renesas@sang-engineering.com>
References: <20260917185903.61253-6-wsa+renesas@sang-engineering.com>
 <20260917185903.61253-9-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 19:02:49 +0000
Message-Id: <20260917190249.E06731F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The RTC on R-Car X5H is a bit special because interrupts are not wired.
> Future R-Car Gen5 SoCs will have them wired again. So, create a
> dedicated entry for X5H without interrupts.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917185903.6125=
3-6-wsa+renesas@sang-engineering.com?part=3D3

