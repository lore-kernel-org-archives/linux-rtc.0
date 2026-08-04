Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AF746AA85;
	Tue,  4 Aug 2026 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863564; cv=none; b=YXvEaPdFkRs+QFb2G+5PTry9/z2cvFw8Lrp69iEXNsFoOii9JgOaxqTmqmYUWzj2zx2RtsjRsKme/0k+PNjazd8CVXQQfoXYsFkZjmPvtyMFcWTaKAwUMuqPqu5lXGXPXnfJeJVNDAlT15xuzgWrH7F2L9eNGvRwYSv082zhCDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863564; c=relaxed/simple;
	bh=IV+cODVwN5mY9v3YGDDTgn/T0KQ0IZOa6njsPzY2tVk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hlqr68IFHZjYHluIUM3/PRdUx0GmG05PnqkS/YEhaeFy2de/TRvSZyDKoE0tVEcmdF7HsE0NThX6p9NMkS0PzWWUNZG38Gau6TiFXy6Ds/Lh0KEVJAmJkfCGniz7oY886ylqgXsc/9rP+Ihe0xoV5XI3PZzsT3i1rtfmbZgoTBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRzmQfPf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRzmQfPf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368C01F00A3A;
	Tue,  4 Aug 2026 17:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785863551;
	bh=IV+cODVwN5mY9v3YGDDTgn/T0KQ0IZOa6njsPzY2tVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bRzmQfPfRhAJmKCAepvqxxqwtzdxf5xr59g2HSFW6o4VYKLjxkUbvyZukApLhplxq
	 xkeGoTYl3iNxHkzUqAqjRyZ5sw/GYBp7GxO0M+2eWE8fInN+NqTci27bI/jlQ0N+d7
	 4StdPwHDa76sWA3FZiaEuh/m76L5RxLabsjP/c6/Rh9xHiHMBSSMpYtLyJraW+cB8e
	 mIewjMjfjK6XcMJNxfbZwozs5g19QqktOJ1C83G8ZRdPpict+KGw9oLFrQtKd9cRRY
	 XGwJvI+4cn9UnCdlrA6HfmnKbu0EB0dDKyH68vo7oLg5GJqvQK1nhWG+dbuGjBUoyo
	 IUZd6OUSe0lBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] ARM: dts: ti: am335x-shc: Remove unused
 ti,no-init property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bhargav Joshi" <j.bhargav.u@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260804-ti-omap-rtc-v3-2-ba3bbd8af570@gmail.com>
References: <20260804-ti-omap-rtc-v3-0-ba3bbd8af570@gmail.com>
 <20260804-ti-omap-rtc-v3-2-ba3bbd8af570@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 17:12:30 +0000
Message-Id: <20260804171231.368C01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The 'ti,no-init' property is a legacy, undocumented boolean property
> that is entirely unhandled by the rtc-omap driver.
> Remove this unnecessary property from dts.
>=20
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-ti-omap-rt=
c-v3-0-ba3bbd8af570@gmail.com?part=3D2

