Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2619E3D5C32;
	Thu,  2 Jul 2026 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980518; cv=none; b=Bvo6X5MbCIcj6R5bXGwLMvYJ9wUhOFQrWlqgAv8CqSClPL/+mEDcJ3PLEFKCR4GUCJKACPmXtk24lVvJ8ggZQ4iUiCFvzGJdrZUXSngbJZAETmBodpJNV/z9HFwkYMtlvZ6pbT0Ca5OgBoTQ/sQhv8oBb4dQBHj3S4v4R4ENiaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980518; c=relaxed/simple;
	bh=3HISegeDoiIC9nay9d8fLQ0exKiUD5Y6GU8C+loQwxo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TVV4ixrQkOcimyi0RCQsg54oXAZRts/Whoc2lvo3WD+WPdPowYrgleGuSl63DKMiIBnQfF/80Im0kkZSk3S1sYcM1LvjnsrCAThRoeVDSff+tKofEmOwOvLqzkHMOE3PXYm14iOaBgFrjO6un6sp4Jod3iiGOyavHvWA490frPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjKGydHU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjKGydHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6681F00A3A;
	Thu,  2 Jul 2026 08:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782980516;
	bh=3HISegeDoiIC9nay9d8fLQ0exKiUD5Y6GU8C+loQwxo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MjKGydHUozWbdWdO7ZF36vlvQVL8nvLm+8opXT5tDNTG93yY3sTz2PtENQhrJEg5e
	 VtyoZx9V97eEn4xDN5l+C3X2l9OHjJezo46WswWcq5HUAqgbQwwMZqAR7HMmaFAF8Y
	 QU/o2yFk1GYOXoC1W7Rg8EZzPPQk+w3L4X//nz11cq/93Vp8WKADYap7lODLc1K5Gt
	 l0suhbucXscYPhSMwKezgbXDaD4j7jQ15gIMEYveDbvGAGZFFyh12ykvdirFvA48NJ
	 ToRqD2SZR4hTiCKgseM5wRpD5LrB1qxmvvw7nmZ68gd/MVYHaL2G+R3xqSyruqkoBv
	 V5oL4i7noPhpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] clk: sunxi-ng: sun6i-rtc: clean up DT usage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, robh@kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260702-a733-rtc-v3-4-eb2580374de6@baylibre.com>
References: <20260702-a733-rtc-v3-0-eb2580374de6@baylibre.com>
 <20260702-a733-rtc-v3-4-eb2580374de6@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 08:21:55 +0000
Message-Id: <20260702082156.5D6681F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> With sun6i-rtc compatible devices, the "ext-osc32k" clock input
> is optional for the devices that support this input (r329 and onward).
>=20
> Probably preparing for older SoC support, the driver does something funny
> when parsing DT. It check if "ext-osc32k" is present in the clock-names a=
nd
> if it is not, it uses the first clock as "ext-osc32k". This clock will
> actually be the rtc bus clock so what the driver does is wrong.
>=20
> At the moment, the driver does not support the older SoCs that would have
> an external 32k clock provided on index #0 so just remove this quirk.
>=20
> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-a733-rtc-v=
3-0-eb2580374de6@baylibre.com?part=3D4

