Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797D147CA77;
	Mon, 14 Sep 2026 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395881; cv=none; b=rKsptwzMRl2K0uIqy2OUVvgz0QRHE+SNgztGj+tY2DnyvyCZOQSpVFA6wVZfCqSbyOKSgxzEsJiD8y3a9FhgKtrN8aQNGgsKZCM+dgX31jjWWDFslFVrWYXnjqNWXTBkexwJXEIGAKRlnze9xl0niGbYCdyC5m/NXeKHp4PxohA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395881; c=relaxed/simple;
	bh=S0Usofe+n3pZh9cHKjmsMVPfdz28Y7BcjyXvDbAiXCk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oDg+/etnIWnZch3xEIvPWHjXVhEwZZlKqoo0o4H9KSa6IBIQIjAh5yw7UZ0M7Xj3ZILjf2/0N8y0EOZwjM8246kqH3NwoaJyIQs6U42tRhkgdjzjIcAOXpli+Hg2X3Xr9Zar6g8XyrID2Esrazl49RR8JGZyXziSSoNzuUpAJwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXhchN7E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXhchN7E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E011F000FF;
	Mon, 14 Sep 2026 14:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395880;
	bh=S0Usofe+n3pZh9cHKjmsMVPfdz28Y7BcjyXvDbAiXCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JXhchN7Em3sOCEJD4cQvYkiKF+euGhbGz0bVaFXDPYMKBKuQzfAuwHPKk8ADSuDDX
	 4JPT+jPOjPHpDAzBWfvRtzOE/obkHHx0iFt+sHsIEKmc2swP6X+OqXd9fa39Yd1L/x
	 770YlfOaMpLUt8iPGsd7LD/+DQVYZ8YkSMC9MGgApbmXRTwL9ciRou3rs9A8kcupxg
	 oGA/CZOIkv5vksAZX+DYZokN/EDQO53FD/5uS5+0n6Kw9Q77oi82NX6PVLe0C8S+Kr
	 OPpRv32xbh85VmvFw/v9rUubGdu3TSLyGDj7neDHLgRZy5jZ60Et1iTo7k6GqtsXuY
	 ieWFc+yeQXCDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/2] dt-bindings: rtc: Add pcf85053 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260914141537.3881890-1-lakshay.piplani@nxp.com>
References: <20260914141537.3881890-1-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:24:39 +0000
Message-Id: <20260914142439.B3E011F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Add device tree bindings for NXP PCF85053 RTC chip.
>=20
> Signed-off-by: Pankit Garg <pankit.garg@nxp.com>
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914141537.3881=
890-1-lakshay.piplani@nxp.com?part=3D1

