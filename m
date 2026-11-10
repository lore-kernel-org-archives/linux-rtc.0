Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321457;
	b=D2pOpKCoA1EIOMyS4J8g5TpmiIWIOqOp1ADQqsOb3YcwhZq5Nt4MIjkCcMa29qZCnTKK
	 PQchdh7pgsxF2ll41WfKfa2I+PFmmM5jDe70gJOZSv6zpcSXBuy/8+U9GRV1Zfm4vB1Qy
	 0qEzDNLbj+3+iPqmhh0SoDzYGY8hw1bY3hIjskzixlVNX/nulx2xGP/KEnOspw4NfW4pp
	 UWbtbVE6AGWkAb6Yd/9W+4nmTgDWokDE1R4W2akDgyLsTTfLFuVk3kF4Q2+CLnH+qmoZt
	 hogHB74RZvcqCnxkGgmw1HhTxud/g62YD+dQLSBBNYW+JWUKPwq3EZaXIQq5fahhZ1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321457;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iqrBtVYs7iz7tqgAby2s1MjanSIUGtg4IMv8GIEY5mQ=;
	b=u6MH1P0BzW7T1+pr3rSgct02ohQvOk84VMc+i+u6dEeDaGE215lG0G8bRc9TcfD1KWSs
	 a6UdZwobb/ZRh/S/CxrGTd0c1iVsvHg+YpRkdxcqzWo4gU6TVPwZzusLmmo9MMjau11KY
	 29oQhW8kvfr+yrwQrp+RA4llRpUyn+xqdT2x/heW+IbVKNsx4yu4TsJHdTrSh7Uvvm8Jt
	 f6CNSf2FKHfIur6H+XICXSpClvtWqrjRnB7ou4k2CSPfLzhy47o6q7inMV1njT5wri1j0
	 cFgLTMfyWSL0DpJmqpxK7XSh/OuguTkp4MjwQYMRf2iqRlnhzrtlMQZ1OlbDNAXwJUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DtPx/ZrV";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DE5606A32E
	for <linux-rtc@vger.kernel.org>; Tue, 10 Nov 2026 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DtPx/ZrV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ACF1F0089F;
	Tue, 10 Nov 2026 14:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321456;
	bh=iqrBtVYs7iz7tqgAby2s1MjanSIUGtg4IMv8GIEY5mQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DtPx/ZrVk4fXyhUDrkrInI2eiWBNd2FCBMuZHoXtPXl6gEll6UMgM2yBwqmRHkvXS
	 4cvnMMNknmrztnJOEFZzJWrYFZuzdJI5lOZQ3cR23FH2dmLOYpHZW0VWJB+k/O21Co
	 RjcGcJwP2SHIbd023xjzCkdNIQyZ9FbUpkrrLHuvOigY6L2AGMjHSdOnG9T8zmKu0M
	 7/zUUkHoFUG8rvs2wD3GzlDilrAuclvFoJkMmoJ0e7/HFXCRnbpcQ/LrLXiB4iDqEj
	 T1H251dRpdj4Pv0D6VYBKJNcDUeGand9d8HtJN7iKSlxRUz8XYbpvjoYphiVSNGBPq
	 NvyEKlS9zhNvA==
Message-ID: <sashiko-outbox-207199@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: hym8563: Fix potential stale clock after device
 removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <liguangshuo@mail.sdu.edu.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261110-9f141e6bc8-rtc-hym8563@mail.sdu.edu.cn>
References: <20261110-9f141e6bc8-rtc-hym8563@mail.sdu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 14:37:35 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> The CLKOUT clock and its provider are registered without a matching
> unregister operation. Removal or a later probe failure releases the
> HYM8563 private data containing the clock hardware while the clock is
> still registered.
>=20
> Manage both registrations with the device so the provider is removed
> before the clock, and both are removed before their backing storage.
>=20
> This issue was found by our static analysis tool under development.
>=20
> Fixes: dcaf03849352 ("rtc: add hym8563 rtc-driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-9f141e6bc8=
-rtc-hym8563@mail.sdu.edu.cn?part=3D1

