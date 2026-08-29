Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CBE1C5D72;
	Sat, 29 Aug 2026 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013882; cv=none; b=BuzJj1+68yeCwgVA5jMzyaB+ueEVwnaKnCIvUZoigk1rHZvvgNmRMQWBAsThN18Sdiauw0mNtXnXkgCfEKA3ln7/l+jC+35iYyRTizab+F3ddD7mVA3h4mhI9NYCrcd43e0pq11iqeUwg799QobsfmCI7xocL1Glhmri9r4Ht9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013882; c=relaxed/simple;
	bh=BRgLyzI04Sjxvt+W2LYwkh48V44K/YClDSwlKV451FY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W2IL+C0jp8OROWP419dP+0PbHgy3izYxtjTkLrY6JoCfAJiK8gsh3pAOGizLtzgtPIBxbU8jyqYuv65ZSaewQgkKcpQF30WWiXLJN4dgAPKw5rwPje8rQoUE4vNkZRgeAJWFFCz7Ger/1fj00mnz4uyCk9vzZ3uzzzmeLY1D4fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdgYMttL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdgYMttL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6C91F000E9;
	Sat, 29 Aug 2026 14:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788013880;
	bh=BRgLyzI04Sjxvt+W2LYwkh48V44K/YClDSwlKV451FY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mdgYMttLvYzeOFX24trnSVoulYJYmqfPXb1TiHpvVuROu0P/yu9ZUN4BayHRStoKe
	 hEQOOkHvuApLWzvgipZLIU427N2E14vMlaURBYjW5og3pHgVYUe2CDJbVvXAxT+Ir3
	 L6wo3SVGC4bpWjFVzP75tbkNwT2fHBA0lH2g58S022EF6zmpUvRSFL9+hB6BxMFg16
	 cXvw0sr0Jsq/ejSJOHbNWPUSAiOwSn5nN+jZknegH5trPcBhXrp5k57adUK/yQRXC3
	 5+2CB+m0ttUY4H+6qQYYGhLuERdWQ0j29ZV0I1UPXVtpxu7KkcZ7i+xpKppcxijpWj
	 3TZav/p8/N1Dg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/6] rtc: s35390a: Fix alarm not disabling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-rtc@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260829-rtc_s35390a_int1-v7-3-debcd31143ae@posteo.de>
References: <20260829-rtc_s35390a_int1-v7-0-debcd31143ae@posteo.de>
 <20260829-rtc_s35390a_int1-v7-3-debcd31143ae@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 14:31:20 +0000
Message-Id: <20260829143120.7D6C91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Implement alarm_irq_enable callback.
>=20
> Fixes: 542dd33a4925 ("drivers/rtc/rtc-s35390a.c: add wakealarm support fo=
r rtc-s35390A rtc chip")
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829-rtc_s35390=
a_int1-v7-0-debcd31143ae@posteo.de?part=3D3

