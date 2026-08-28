Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982A2381B07
	for <linux-rtc@vger.kernel.org>; Fri, 28 Aug 2026 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787935887; cv=none; b=Eqmz1+QXCdzezOiyWpuZH6l0EyGRAHDwH65foxy8bXGsmEstHAIUYUnyA0Unk7rKfCrka0d2DEHiCL05Wu07hzEW5xJHCHgzo4T/fM3russDSU3ssga5pMYS/2CqYNiOB6BchoRzoddc48DsgDj3iS2WtiKhJMrzlo3ilD2enFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787935887; c=relaxed/simple;
	bh=dTkVXfX3alcPZIek6Ur2zyVLHYfA2+oYyCWdM3GWoaI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MKWWQhtoxYd0IH6OyKEEEhXrj0Ttn97nTA7gvixHuG8rT3SMdFnt4nCvOClm9bTG83uMvVt8HK13LyzYGSlajjZrwAiIguDGEkzZUSfFsyytWd0/D6LIX2aK0XfK2Kw70Ha4ezQBr+95fACnp7BsvSw26QCzzNugeFptUxxgbsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Te5StO5E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Te5StO5E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592111F000E9;
	Fri, 28 Aug 2026 16:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787935886;
	bh=dTkVXfX3alcPZIek6Ur2zyVLHYfA2+oYyCWdM3GWoaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Te5StO5ENtRdRBhaNXDM7vP1E8H/WSKD5izKltReVFD5dsKXkD/L5ZCQU7LPNBt/8
	 XXYGK/r3g1/UkSbgj4OXHYcCyYOoAed3ChUwgnZrmXAgymGVgRGZJWjT+btn4qXu3j
	 4yitQg1/jK/owf9d3WUhT8HV9sNHXuRazLfeXNhAACAmGl1NI7yo4AzY3kM1c6LvIm
	 oC0SwpLlbCeZrsJA0r0eS535azfRaC+SEJSJ2UJ32ccpgeiXa3sXTdyJy23QEUbBS5
	 /BaD5fgZR/TOdJZ+SRIqk+Qd7+ZlgAAhU5T9aGIItsieK3X5E2pOTmJjQ2dw3Fx75+
	 59YCWi1fTYLqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] rtc: pcf85063: use devm_of_clk_add_hw_provider()
 for clkout
Reply-To: sashiko-reviews@lists.linux.dev
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260828164445.3907839-2-alexander.sverdlin@siemens.com>
References: <20260828164445.3907839-1-alexander.sverdlin@siemens.com>
 <20260828164445.3907839-2-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 16:51:26 +0000
Message-Id: <20260828165126.592111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>=20
> pcf85063_clkout_register_clk() registered the OF clock provider with the
> deprecated of_clk_add_provider() and never removed it, so the provider
> kept pointing at freed data after unbind, leading to a use-after-free the
> next time the device-tree clock was resolved.
>=20
> Switch to devm_clk_hw_register() and devm_of_clk_add_hw_provider(): both
> the clock and its OF provider are managed resources now, and the provider
> is torn down before the clock on unbind.
>=20
> Register the clock on the parent i2c device instead of the rtc device.
> devm_of_clk_add_hw_provider() must use the parent, which owns the
> of_node, and the clkout_hw it points at lives in the driver data
> allocated on the parent. Tying both to the parent releases them together
> on unbind, before the driver data is freed, and keeps their teardown
> ordering guaranteed by a single devres list. Registering the clock on the
> rtc device instead could defer its unregistration past unbind (e.g. while
> a /dev/rtcN fd is open), after clkout_hw has already been freed.
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828164445.3907=
839-1-alexander.sverdlin@siemens.com?part=3D1

