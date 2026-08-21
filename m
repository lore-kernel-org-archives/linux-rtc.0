Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4B331A065;
	Fri, 21 Aug 2026 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347532; cv=none; b=StHscWkSo9jEJJUoXaJKwc+B8KATsEF8QIOGXUJ63rTGTRrCEgUxQmL0LWsKlP9WMB9Qqgj8VpY4yJTD+EBCu+9+7bEs+DnJAxNrzRqXZ/Xzwm/aqd5vo9enTHoucusO/LQ7jidj++9tO3MX1q64OfSnzJgSe9MiWmvEPK7JjNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347532; c=relaxed/simple;
	bh=OUxmpSQS3rKAlBPmNjPHoLsC1xBnF1iKHuuEuWmoRMU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SXmfR2T7+RAThceFnNKnVPkflYOZ/NJ4q8L9NUMyJvIobkMoae6GVrwrGETtoykzFGRRbhMsKe3UFMuWaqRt6BdbLq2zY+/IXqeeF55jTopX9gi8sbcWXEgrN2VKEz8Y1t9lBUhTyoA673bz183jnrvyaLBQvMLlUd4gkDL9V1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/oTkhsu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/oTkhsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434121F000E9;
	Fri, 21 Aug 2026 21:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787347530;
	bh=OUxmpSQS3rKAlBPmNjPHoLsC1xBnF1iKHuuEuWmoRMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R/oTkhsuiY2pWepAK2T8vdkHA4mSJ2swnjG9kzZt/meRZSt66LLyKVNZWWbIxExe0
	 RVWVWLXEfcfCoRD3oE72trndGZQawxmMv6h4wJK+fP3x6k14/H0q8bbBQgMjmML8ss
	 XBUGFB5CG+llzPZaRsTrqKVYKMeRedVJ1FZM9FoSH0XsLcCIJjltp//OqydMqnIVRK
	 j8GakrGnGv0RaBiKZqw68AIbAiy7PX1tbDrpX0AeNy9JBNgQLwV9zfwambpOMsk9FO
	 ETRBrQZ7cq36ICbqNAMsU4uhUSq24Yha7UYYPJYF9DfuFk9cfnaeTpLP5mEGYBNBAX
	 sTcLtjvS4l5jQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 17/17] rtc: rzn1: Add support for Renesas RZ/T2H and
 RZ/N2H SoCs
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260821211032.13554-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821211032.13554-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:25:29 +0000
Message-Id: <20260821212530.434121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Add support for the RTC block found on the Renesas RZ/T2H (R9A09G077)
> and RZ/N2H (R9A09G087) SoCs.
>=20
> These SoCs integrate a closely related variant of the RZ/N1 RTC IP, but
> do not implement the RTCA0SUBU register. Use variant-specific match data
> to disable SUBU support for these SoCs.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821211032.1355=
4-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D17

