Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2023E0C66;
	Thu,  8 Oct 2026 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791490999; cv=none; b=bxMBy8jdjdUGtzEYFtbrZW/9wfgEctbcOvgeFaKucGjGQfJgBcwba60COFuzlyhlIbFBJiPX3pmQk95TO3W3y8Cm15751IGtHJGRmZBSsfprZ6ejyhL8sc7cAgWq3c7zLEKIoWsNokFUZd/xK1sikOrxoD00sMx8Qjpw8U2BC+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791490999; c=relaxed/simple;
	bh=ODRSas5JN4Tnq7ib7LRLXX0AugPfAlv4Q11N+OaHLjI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UwwSfORmPN06ZEN7y3M4HYeTJHoGxedsrNrRCFmmS/jYDtIHX+ZgnszQV6LdVlnsj3GFqMtSex37hXTRilLyoIGHsDljT5LInjMLzQc5t2EBsifH1UdisHwCRN4X11dVpJ4QR2KURhfJTdOs3b92aJG62gf3mGoWq7tp5SCmip8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RycuIvEH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RycuIvEH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311DE1F000FF;
	Thu,  8 Oct 2026 20:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791490998;
	bh=ODRSas5JN4Tnq7ib7LRLXX0AugPfAlv4Q11N+OaHLjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RycuIvEHn4JHAeHXTXuL4/SkLaccXPodC7d+r2yKOdEQ3VL1D0JkkEZTacFEp5orp
	 UUPFmx66X2Not0mqoakB+mI5RbDGKR0mauYClRXFdn+2LU6F+rFs1nojthFrLcXp+f
	 1pYPFMJeWimB0KxzfHtIsEuxxsCQMuT3I0spg6bkQzJLOtli4OAICXpYg82sWyJm6p
	 EcT7VPfX1pvxJLOCpu2NFZds7coQNMnJFbTsvA+1P/1W04AF/dbjcG9ypO1WS1/s9r
	 K6Oi2mURF4B0ulblUxbd55eD2FqXhHxBRIxkM6B4Lm7P1AR1osHPefwJaR+GF39ZrF
	 NNbFycpu966Ew==
Message-ID: <sashiko-outbox-164570@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: rzn1: add resets property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261008201953.34307-2-wsa+renesas@sang-engineering.com>
References: <20261008201953.34307-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 20:23:17 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The RTC on R-Car X5H does have a reset unlike the other versions.
>=20
> Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008201953.3430=
7-2-wsa+renesas@sang-engineering.com?part=3D1

